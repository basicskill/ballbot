import numpy as np
import matplotlib.pyplot as plt
from sympy import *

Ka = Ke = Km = 0.01 #neke konstante (dodati prava imena)
La = Ra = 1 #aktivni i pasivni otpor
m = r = 0.5 #masa tocka / precnik tocka

I = m*r*r/2 #momen inercije
Ta = La/Ra #elektricna vremenska konstanta armaturnog ...
Tm = I/(Ka*Ke*Km) #elektromehanicka vremenska konstanta

Kp = Ki = Kd = 2 # PID gain

#s, t = symbols('s t') 
#G = (1/Ke) / (Tm*Ta*s**2 + Tm*s + 1) #prenosna funkcija motora

#H = (Kp*s + Ki + Kd*s**2)/s
"""
HG1 = Kp*s + Ki + Kd*s*s
HG2 = Tm*Ta*s*s*s + Tm*s*s + s
HG = HG1 / HG2
"""



def prenosna(x):
	"""prenosna f-ja motora"""
	return tf.evalf(subs={t: x})	

def U(t):
	"""step f-ja napona"""
	step = 5
	return step * (t >= 1)

def W(t):
	"""ugaona brzina motora"""
	return prenosna(t) * U(t)


x = np.arange(0.0, 10.0, 0.1)

rez = []

for i in np.nditer(x):
	print('.')
	a = W(i)*1000 # ne treba da bleji ovo  1000
	rez.append(a)
	print(a)

plt.plot(x, U(x), 'b', x, rez, 'r')
#plt.plot(t, W(t), 'b')
plt.show()
