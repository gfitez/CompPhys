# libraries
import matplotlib.pyplot as plt
import numpy as np



import csv



x = []
y =[]
z = []

with open("positions.txt") as tsvfile:
  reader = csv.reader(tsvfile, delimiter=',')
  i=0;
  for row in reader:
    #print(i)
    i+=1;
    if(float(row[0])>2.5 and float(row[1])>2.5):
        x.append(float(row[0]))
        y.append(float(row[1]))
        z.append(min(float(row[2]),0.5))


# create data


# use the scatter function
plt.scatter(x, y, alpha=0.5, s=2,c=z)
plt.xlabel("xDot0")
plt.ylabel("thetaDot0")
plt.title("chaos")


plt.show()
