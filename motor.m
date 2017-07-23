W = 0;
Kem = 1;
Kme = 1;
R = 1;
J = 2;
B = 0.1;
L = 0.1;

dt = 0.01;

vreme = 0.0: dt: 20.0; % vektor vremena

Ktg = 1;
A = 1;
pW = [];

for t = vreme
    Ur = A*(napon_motor(t) - W * Ktg);
    M = (Ur*Kem)/R - sila_tereta(t);
    W = (M/J) * exp(-(B/J) * t);
    pW = [pW W];
end

plot(vreme, pW);

