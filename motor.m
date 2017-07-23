W = 0;
Kem = 1;
Kme = 1;
R = 1;
J = 2;
B = 0.1;
L = 0.1;

dt = 0.01;

vreme = 0.0: dt: 200.0; % vektor vremena
u1 = ones(size(vreme))*5; % vektor pobude

Ktg = 1;
A = 1;
U = 5;

s = tf('s');
t = sym('t');

Mt = 0.1*sin(5*t);


W = (U*Kem)/(R*J*s + Kme*Kem) - syms2tf(laplace(Mt))* R/(R*J*s + Kem*Kme);
W = minreal(W);

lsim(W, u1, vreme);



