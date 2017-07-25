close all
M = 0.5;
m = 0.2;
b = 0.1;
I = 0.006;
g = 9.81;
l = 0.3;
s = tf('s');
Kp = 10;
Ki = 1;
Kd = 0;

t = 0: 0.01: 10;

q = (M+m)*(I+m*l^2)-(m*l)^2;

Tf_klatno = (m*l*s/q)/(s^3 + (b*(I + m*l^2))*s^2/q - ...
    ((M + m)*m*g*l)*s/q - b*m*g*l/q);

kontroler = (1/s) * (s + 4)*(s + 3);
HG = kontroler * Tf_klatno;

HG = minreal(HG);

polovi = pole(HG);

rlocus(HG);
sgrid(0.9, 5)

K = 12.5; 
kontroler = K * kontroler;

TF = feedback(Tf_klatno, kontroler);
figure(2)
step(TF);
















