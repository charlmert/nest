#!/usr/bin/python
import sys
import re
from cStringIO import StringIO
import subprocess
from subprocess import *

try:
  log_file = sys.argv[1]
except IndexError:
  print "USAGE: ", sys.argv[0], " log_file.log"
  exit(0)

#perl style regex
key_key15 = "BIL"
key_key12 = "EBI"

match_key15 = "apache watch"
match_key12 = "do apache watch"

match_criterion = ''.join([".*", match_key15, ".*", ".*", match_key12, ".*", ])

# what in the log file we're focusing on
criterion = ''.join(["(", match_key15, "|", match_key12,"|", ")"])

uniq_hourly = {}
type_hourly = {}

f = open(log_file, 'r')
for line in f:
  # if the log line contains a timestamp and matches the criterion
  if (re.match('^\d\d\d\d\d\d\d\d \d\d:\d\d:\d\d', line) and re.search(criterion, line)):
    parts = re.split('(\d\d:\d\d:\d\d )', line)
    try:
      #print parts[0], parts[1], parts[2]

      date = parts[0].strip()
      timestamp = parts[1].strip()
    
      ts_parts = re.split(':', timestamp)
      hh = ts_parts[0].strip()
      mm = ts_parts[1].strip()
      ss = ts_parts[2].strip()

      message = parts[2]
    
      #hourly stats
      key = ''.join([date, " ", hh])
      try:
        uniq_hourly[key] += 1
      except KeyError:
        uniq_hourly[key] = 1

      if (re.match(''.join([".*", match_key15, ".*"]), line)):
         key = ''.join([key, " ", key_key15])
         try:
           type_hourly[key] += 1
         except KeyError:
           type_hourly[key] = 1
      elif (re.match(''.join([".*", match_key12, ".*"]), line)):
         key = ''.join([key, " ", key_key12])
         try:
           type_hourly[key] += 1
         except KeyError:
           type_hourly[key] = 1

    except IndexError:
      continue

for uh in uniq_hourly:
  #for th in type_hourly: do query match instead of iteration
  #date_hh = re.findall('(\d\d\d\d\d\d\d\d \d\d).*', date_hh_type)[0] constructing key, reverse
  fk_key_key15 = ''.join([uh, " ", key_key15])
  fk_key_key12 = ''.join([uh, " ", key_key12])
  buff = StringIO()
  buff.write("%s - Total: %d" % (uh, uniq_hourly[uh]))
  buff.write("   \t| %s : %d" % (key_key15, type_hourly[fk_key_key15]))
  buff.write("   \t| %s : %d" % (key_key12, type_hourly[fk_key_key12]))
  print buff.getvalue()

f.close()
