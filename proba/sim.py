import numpy as np
import matplotlib.pyplot as plt

W = 0

Tm = 1
Km = 1
Ktg = 1
Kem = 0.6

R = 1
J = 2
B = 0.1

def U(t):
	"""step f-ja napona"""
	step = 2.5
	return step * (t >= 1)

def Omega(t):
	global J, B, M
	return (np.exp(-B/J)/J) * M

def izvdW(t, W):
	T = 1/Tm
	return T * (Km*U(t) - W)

def Mt(t):
	if (t > 6) and (t < 10):
		return 0.2
	elif (t > 14):
		return -0.1
	return	0

dt = 0.001
pltW = [];
t = np.arange(0.0, 20.0, dt)


for i in np.nditer(t):
	Ur = U(i) - W * Ktg
	
	M = Ur * (Kem/R) - Mt(i)

	W = Omega(t)
	pltW.append(W)

#print(type(W))
#print(pltW)
plt.plot(t, pltW, 'r')
plt.show()









