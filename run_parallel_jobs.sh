#!/bin/bash

# When this script is killed, kill all the background processes
trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

# If the wait version does not have the -n option
# source: https://stackoverflow.com/questions/69233150/does-bash-wait-command-support-n-option
wait-n ()
{ StartJobs="$(jobs -p)"
  CurJobs="$(jobs -p)"
  while diff -q  <(echo -e "$StartJobs") <(echo -e "$CurJobs") >/dev/null
  do
    sleep 1
    CurJobs="$(jobs -p)"
  done
}


N_JOBS=4
N_REPETITIONS=100

for ((SEED=0;SEED<$N_REPETITIONS;SEED++))
do
    echo "Running repetition ${SEED}"
    (
    # Run any script or Python code here with optional arguments
    python main.py ${SEED}
    sleep 1
    ) &

    # Allow only $N_JOBS parallel jobs
    if [[ $(jobs -r -p | wc -l) -ge $N_JOBS ]]; then
        # Wait for any job to be finished
        wait-n
    fi
done

wait-n
