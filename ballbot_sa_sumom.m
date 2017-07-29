close all
clear all
% q = [ teta, fi ]
rw = 0.1058;
rr = 0.006335;
mw = 2.44;
Iw = 0.0174;
lb = 0.69;
Ib = 120.59;
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

tork = 500;

Q = [1 0 0 0;
     0 1 0 0;
     0 0 10 0;
     0 0 0 100];
R = 0.1;

K = lqr(A, B, Q, R);

pltTheta = [];
pltFi = [];
idealnoFi = [];

u1 = 0; %pocetni tork
X1 = [0; 0.1; 0; 0]; %pocetno stanje

dt = 0.01;
maxVreme = 10;
vreme = dt: dt: maxVreme;

%{
%bez suma

dX = zeros(4, 1);
X = X1;
u = u1;


for t = vreme
    
    dX = A * X + B * u;
    X = X + dX * dt;
    u = -K*X;% + tork*(t == 5);
    
    idealnoFi = [idealnoFi, X(2)];
    %pltFi = [pltFi, X(2)];
    
end
%}


% sa sumom
dX = zeros(4, 1);
X = X1; %pocetno stanje
u = u1;
stvarnoFi = [];
P = 0;

for t = vreme
    
    X_pred = X;
    
    dX = A * X + B * u;
    X = X + dX * dt;
    
    stvarnoFi = [stvarnoFi, X(2)];
    
    [g, a, dNoiseFi] = imu_noise(X(2), X(4), mb, g, dt);
    
    z = [g; a];
    
    [noiseX, P] = kalman_filter(A, B, Q, R, u, X_pred, P, z); 
    %noiseFi = komplementarni_filter(g, a);
    
    pltFi = [pltFi, noiseX(2)];
    
    u = -K * [X(1); noiseX(2); X(3); dNoiseFi];
    
end

figure(1)          
plot(pltFi)
hold on
plot(stvarnoFi)