pkg load control

Ke = 1;
Ta = 10;
Tm = 1;

s = tf('s');

G = 1 /(1 + s*Tm + s^2*Ta*Tm);

G = G * 1/Ke

Kp = Ki = Kd = 2;
H = Kp + Ki/s + s*Kd 

ilaplace(G)

%pzmap(G)
%rlocus(G)