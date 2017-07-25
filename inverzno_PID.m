close all
M = 0.5;
m = 0.2;
b = 0.1;
I = 0.006;
g = 9.81;
l = 0.3;
s = tf('s');


t = 0: 0.01: 10;

q = (M+m)*(I+m*l^2)-(m*l)^2;

Tf_klatno = (m*l*s/q)/(s^3 + (b*(I + m*l^2))*s^2/q - ...
    ((M + m)*m*g*l)*s/q - b*m*g*l/q);

K = g*(M+m) - q*g/(I+m*l^2);
TF = feedback(Tf_klatno, K);

impulse(TF)














