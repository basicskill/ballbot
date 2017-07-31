import matplotlib.pyplot as plt
import matplotlib.patches as patches
import matplotlib.cbook as cbook


image_file = cbook.get_sample_data('/home/mladen/Desktop/ballbot_GUI/glavudza.jpg')
image = plt.imread(image_file)

fig, ax = plt.subplots()
im = ax.imshow(image)
patch = patches.Circle((500, 500), radius=500, transform=ax.transData)
im.set_clip_path(patch)

plt.show()