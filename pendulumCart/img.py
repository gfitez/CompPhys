# libraries
import matplotlib.pyplot as plt
import numpy as np
from PIL import Image
import math


import csv



x = []
y =[]
z = []

with open("positions.txt") as tsvfile:
  reader = csv.reader(tsvfile, delimiter=' ')
  i=0;
  for row in reader:
    #print(i)
    i+=1;
    if(float(row[1])>2 and float(row[3])>3.5):
        x.append(float(row[1]))
        y.append(float(row[3]))

        z.append(float(row[4]))
        #z.append(int(float(row[4])>0.01))


#
img = Image.new('HSV', [1200,1200], 255)
data=img.load();
index=0;
for i in range(0,len(x)):
    data[index%1200,math.floor(index/1200)] = (
        int(255-z[i]*100000),255,255
    )
    index+=1;

img.convert('RGB').save('image.png')
