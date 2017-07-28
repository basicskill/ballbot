close all
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

tork = 50;

Q = [1 0 0 0;
     0 1 0 0;
     0 0 10 0;
     0 0 0 100];
R = 0.1;

K = lqr(A, B, Q, R);

pltTheta = [];
pltFi = [];
idealnoFi = [];

%bez suma
dX = zeros(4, 1);
X = [0; .1; 0; 0]; %pocetno stanje
u = 0;
dt = 0.01;
vreme = dt: dt: 10;

for t = vreme
    
    dX = A * X + B * u;
    X = X + dX * dt;
    u = -K*X;
    
    idealnoFi = [idealnoFi, X(2)];
    %pltFi = [pltFi, X(2)];
    
end



% sa sumom
dX = zeros(4, 1);
X = [0; .1; 0; 0]; %pocetno stanje
u = 0;
dt = 0.01;
vreme = dt: dt: 10;

for t = vreme
    
    dX = A * X + B * u;
    X = X + dX * dt;
    [g, a] = imu_noise(X(2), X(4), mb, g, dt);
    X(2) = komplementarni_filter(g, a);
    u = -K*X;
    
    pltTheta = [pltTheta, X(1)];
    pltFi = [pltFi, X(2)];
    
end

figure(1)          
plot(pltFi)
hold on
plot(idealnoFi)



                                                                                                                                                                                                                        










