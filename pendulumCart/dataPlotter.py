# libraries
import matplotlib.pyplot as plt
import numpy as np



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

        z.append(min(float(row[4]),0.01))
        #z.append(int(float(row[4])>0.01))


# create data


# use the scatter function
plt.scatter(x, y, alpha=0.5, s=2,c=z)
plt.xlabel("xDot0")
plt.ylabel("thetaDot0")
plt.title("chaos")


plt.show()
