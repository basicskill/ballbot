from numpy import *
import matplotlib.pyplot as plt

W = 0

Tm = 5
Km = 1

def U(t):
	"""step f-ja napona"""
	step = 5
	return step * (t >= 1)

def izvdW(t, W):
	T = 1/Tm
	return T * (Km*U(t) - W)


dt = 0.01
pltW = [];
t = arange(0.0, 5.0, dt)


for i in nditer(t):
	W += izvdW(i, W) * dt
	pltW.append(W)

#print(type(W))
#print(pltW)
plt.plot(t, pltW, 'r')
plt.show()