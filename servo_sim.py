import numpy as np
import matplotlib.pyplot as plt

Ka = Ke = Km = 1 #neke konstante (dodati prava imena)
La = Ra = 1 #aktivni i pasivni otpor
m = r = 0.5 #masa tocka / precnik tocka

I = m*r*r/2 #momen inercije
Ta = La/Ra #elektricna vremenska konstanta armaturnog ...
Tm = I/(Ka*Ke*Km) #elektromehanicka vremenska konstanta

def prenosna(t):
	"""prenosna f-ja motora"""
	pass


def U(t):
	"""step f-ja napona"""
	step = 5
	return step * (t >= 2)

def W(t):
	"""ugaona brzina motora"""
	return prenosna(t) * U(t)


t = np.arange(0.0, 5.0, 0.01)

plt.plot(t, U(t), 'b', t, W(t), 'r')
plt.show()
