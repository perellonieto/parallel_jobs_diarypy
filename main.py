import sys
import os
import time
from datetime import datetime
import logging
import warnings
from diarypy.diary import Diary

seed = sys.argv[1]

def common_message(message):
    return f"[Seed {seed}][{datetime.now()} - {message}]"

diary = Diary(name=f"parallel_results", path='results',
              overwrite=False, stdout=True, stderr=True)

logging.basicConfig(format='%(asctime)s [%(levelname)-8s][%(name)s] %(message)s',
                   datefmt='%Y-%m-%d %H:%M:%S',
                   filename=os.path.join(diary.path, 'logging.log'))
logging.getLogger().setLevel('INFO')

for i in range(60):
    print(common_message('Standard print'))
    warnings.warn(common_message('Warning'))
    logging.info(common_message('Logging info'))
    time.sleep(1)
