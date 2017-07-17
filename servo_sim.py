import numpy as np
import matplotlib.pyplot as plt
from sympy import *

Ka = Ke = Km = 0.01 #neke konstante (dodati prava imena)
La = Ra = 1 #aktivni i pasivni otpor
m = r = 0.5 #masa tocka / precnik tocka

I = m*r*r/2 #momen inercije
Ta = La/Ra #elektricna vremenska konstanta armaturnog ...
Tm = I/(Ka*Ke*Km) #elektromehanicka vremenska konstanta

s = symbols('s') 
H = (1/Ke) / (Tm*Ta*s**2 + Tm*s + 1) #prenosna funkcija motora


def prenosna(t):
	"""prenosna f-ja motora"""
	return inverse_laplace_transform(H, s, t)	

def U(t):
	"""step f-ja napona"""
	step = 5
	return step * (t >= 1)

def W(t):
	"""ugaona brzina motora"""
	return prenosna(t) * U(t)


t = np.arange(0.0, 10.0, 0.1)

rez = []

for i in np.nditer(t):
	x = W(i)*1000 # ne treba da bleji ovo  1000
	rez.append(x)
	print(x)

plt.plot(t, U(t), 'b', t, rez, 'r')
#plt.plot(t, W(t), 'b')
plt.show()
