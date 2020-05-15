from redistimeseries.client import Client
rts = Client(port=6380)
import sys
import time
from random import random

if( len(sys.argv) != 2):
   print("need to pass in task number")
   sys.exit()

print('argument list:' +  str(sys.argv))

maxtimeseries = 10000
totalrecs = "totalrecs" + str(sys.argv[1]) 
if(rts.exists(totalrecs) <=0):
   rts.create(totalrecs)
recs = 0

while True:
   for x in range(maxtimeseries):
      key = "key_" + str(sys.argv[1]) + "-" +  str(x)
      if(rts.exists(key) <= 0):
         rts.create(key)
      rts.add(key,'*',random())
      recs = recs + 1
   if (recs % 200) == 0 :
      rts.add(totalrecs, '*', recs)

