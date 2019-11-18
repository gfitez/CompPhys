from mpl_toolkits import mplot3d
import numpy as np
import matplotlib.pyplot as plt
import csv
from matplotlib import cm
from scipy.interpolate import griddata
import scipy
import math
fig = plt.figure()
ax = plt.axes(projection='3d')




x = []
y =[]
z = []
with open("xDot2-5, thetaDot2-5 high res.txt") as tsvfile:
  reader = csv.reader(tsvfile, delimiter=' ')
  i=0;
  for row in reader:
    if(False):
        break
    i+=1;
    if(True):
        x.append(float(row[1]))
        y.append(float(row[3]))
        #z.append(float(row[4]))
        z.append(math.pow(float(row[4]),1/500))

#1*10^-5 -> 190

xi = np.linspace(min(x), max(x), 100)
yi = np.linspace(min(y), max(y), 100)
X, Y = np.meshgrid(xi, yi)
Z = griddata((x,y), z, (X, Y), method='linear')  # switched to linear interpolation

ax = plt.axes(projection='3d')
#ax.contour3D(x,y,z, 50, cmap='binary')
ax.plot_surface(X,Y,Z,cmap=cm.coolwarm, linewidth=0, ccount=1000, rcount=1000)
ax.set_xlabel('x')
ax.set_ylabel('y')
ax.set_zlabel('z');




ax.set_xlabel('X Label')
ax.set_ylabel('Y Label')
ax.set_zlabel('Z Label')

plt.show()
