% q = [ teta, fi ]
rw = 0.1058;
rr = 0.006335;
mw = 2.44;
Iw = 0.0174;
lb = 0.69;
Ib = 12.59;
%Ibyy = 12.48;
%Ibzz = 0.66;
mb = 51.66;
Dc = 3.82;
Dv = 3.68;
Ki = 2.128;
g = 9.81;


alpha = Iw + (mw + mb)*rw^2;
beta = mb*rw*lb;
gama = Ib + mb*lb^2;
imenilac = alpha*gama - beta^2;

A1 = - (alpha + beta)* beta*g / (rr*imenilac);
A2 = alpha*beta*g / (rr*imenilac);
B1 = (alpha + 2*beta + gama) / imenilac;
B2 = - (alpha + beta) / imenilac;

A = [0 0 1 0;
     0 0 0 1;
     0 A1 0 0;
     0 A2 0 0];
 
 B = [0;
      0;
      B1;
      B2];

tork = 5;

Q = [1 0 0 0;
     0 1 0 0;
     0 0 10 0;
     0 0 0 100];
R = 0.1;

K = lqr(A, B, Q, R);

pltTheta = [];
pltFi = [];

xPrim = zeros(4, 1);
x = zeros(4, 1); %pocetno stanje
u = tork;
dt = 0.01;
vreme = 0: dt: 10;

for t = vreme
    
    xPrim = A * x + B * u;
    x = x + xPrim * dt;
    u = -K*x;
    
    pltTheta = [pltTheta, x(1)];
    pltFi = [pltFi, x(2)];
    
end

figure(1)          
plot(pltFi)
figure(2)
plot(pltTheta)



                                                                                                                                                                                                                        










