import numpy as np
import matplotlib.pyplot as plt
import matplotlib.patches as patches
import matplotlib.cbook as cbook
from matplotlib import animation
import csv

ugao_bota = []
ugao_lopte = []
stanja = []

""" Ucitavanje nizova vrednosti za Fi, Teta i stanja """
with open('kalman_fi.csv') as fajl_fi:
  rider = csv.reader(fajl_fi)
  for i in rider:
    ugao_bota.append(float(i[0]))
  

with open('kalman_teta.csv') as fajl_teta:
  rider = csv.reader(fajl_teta)
  for i in rider:
    ugao_lopte.append(float(i[0]))  


with open('pocetni_uslovi.csv') as fajl_stanja:
  rider = csv.reader(fajl_stanja)
  for i in rider:
    stanja.append(float(i[0]))

dt = stanja[0] # vremenski korak
maxVreme = int(3) # vreme izvrsavanja
Fi_1 = stanja[2] # pocetni ugao ballbota
l = stanja[3] # duzina sipke
rw = stanja[4] # poluprecnik lopte

print(rw)


fig = plt.figure()
fig.set_dpi(100)
fig.set_size_inches(5, 5)


r_lopte = 10
r_cm = 5
l = 45

pocetna_pozicija = 0;


ax = plt.axes(xlim=(-175, 5), ylim=(0, 175)) # ose

image_file = cbook.get_sample_data('/home/mladen/Desktop/ballbot_GUI/glavudza.jpg')
image = plt.imread(image_file)

glavudza = ax.imshow(image)
patch = patches.Circle((-50, 50), radius=r_lopte, transform=ax.transData)
glavudza.set_clip_path(patch)

lopta = plt.Circle((5, -5), r_lopte, fc='g')
lajna = plt.Line2D((1, 2), (r_lopte, 3), lw=4)
cm = plt.Circle((5, -5), r_cm, color='r', fill=False) # centar mase
lajna_lopte = plt.Line2D((1, 2), (r_lopte, 3), lw=1, color='black')


def init():
    lopta.center = (pocetna_pozicija, r_lopte)
    cm.center = (pocetna_pozicija, r_lopte + l)
    ax.add_patch(lopta)
    ax.add_line(lajna)
    ax.add_patch(cm)
    ax.add_line(lajna_lopte)
    ax.add_patch(patch)

    return lopta, lajna

def animate(i):

    Fi = ugao_bota[i]
    Teta = ugao_lopte[i]

    x, y = lopta.center
    x = rw * (Teta + Fi)
    lopta.center = (x, y)

    x_cm = l * np.sin(Fi)
    y_cm = l * np.cos(Fi)
    cm.center = (x - x_cm, r_lopte + y_cm)   

    lajna.set_xdata(np.array([x, x-x_cm]))   
    lajna.set_ydata(np.array([r_lopte, r_lopte + y_cm]))   

    y_vektora = y + r_lopte * np.cos(-Teta)
    x_vektora = x - r_lopte * np.sin(-Teta)

    lajna_lopte.set_xdata(np.array([x, x_vektora]))
    lajna_lopte.set_ydata(np.array([y, y_vektora]))

    return lopta, lajna, cm, lajna_lopte



interval1 = int(dt * 1000) * 4
frejmovi = int(maxVreme/dt)

anim = animation.FuncAnimation(fig, animate, 
                               init_func=init, 
                               frames=frejmovi, 
                               interval=interval1,
                               blit=True)

plt.show()