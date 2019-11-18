# libraries
import matplotlib.pyplot as plt
import numpy as np
import math
from matplotlib import cm

import csv



x = []
y =[]
z = []

with open("xDot2-5, thetaDot2-5 high res.txt") as tsvfile:
  reader = csv.reader(tsvfile, delimiter=' ')
  i=0;
  for row in reader:
    #break;
    i+=1;
    if(float(row[1])>0 and float(row[3])>0 or True):
        x.append(float(row[1]))
        y.append(float(row[3]))

        #z.append(min(float(row[4]),0.01))
        z.append(math.log(float(row[4])))

def tD(xD,E):#find thetaDot from xDot and energy
    try:
        tD = 1/5 *(math.sqrt(5) * math.sqrt(-5*xD**2 + 10*E + 98) - 5*xD)
        return tD
    except:
        return None
def tD2(xD,E):#find thetaDot from xDot and energy
    try:
        tD = 1/5 *(-math.sqrt(5) * math.sqrt(-5*xD**2 + 10*E + 98) - 5*xD)
        return tD
    except:
        return None
    #-9.8+xD**2+xD*tD+0.5*tD**2;
    #-9.8+mot.xDot*mot.xDot+mot.xDot*mot.thetaDot+0.5*mot.thetaDot*mot.thetaDot;
     #-9.8+ 0.5*2*mot.xDot*mot.xDot*(1)+mot.xDot*mot.thetaDot*(1+)+0.5*mot.thetaDot*mot.thetaDot;



axes = plt.gca()
axes.set_xlim([2,5])
axes.set_ylim([2,5])
# use the scatter function
plt.scatter(x, y, alpha=0.5, s=2,c=z,cmap=cm.coolwarm)
if(False):

    data=np.linspace(-100,100,10000)# teh xdot inputs for tD

    for E in np.linspace(0,30000,200):#the values of chaos to draw at
        plt.plot(data,[tD(x,E) for x in data],"w")
        plt.plot(data,[tD2(x,E) for x in data],"w")
plt.xlabel("xDot0")
plt.ylabel("thetaDot0")
plt.title("ln(chaos)")
# z.sort()
# for i in range(len(z)):
#     z[i]=min(z[i],0.001)
# plt.plot(range(len(z)),z)
# plt.xlabel("i");
# plt.ylabel("min(chaos[i],0.001)")


plt.show()
