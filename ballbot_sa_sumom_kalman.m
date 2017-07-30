close all
clear all

%rng(12345);

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

realnoFi = [];

u1 = 0; %pocetni tork
X1 = [0; 0.1; 0; 0]; %pocetno stanje

dt = 0.01;
maxVreme = 5;
vreme = dt: dt: maxVreme;


sys_ct = ss(A, B, [], []);
temp = c2d(sys_ct, .01, 'zoh');
Ad = temp.a; 
Bd = temp.b;



A_kalman = Ad;
A_kalman(2,2) = A_kalman(2,2) + 0.001;

% sa sumom
dX = zeros(4, 1);
X = X1; %pocetno stanje
u = u1;
realnoFi = [];
P = diag([.1 0.00001 .1 .1]);
kalmanX = [0; .5; 0; 0];
senzor = [];
senzorFi = [kalmanX(2)];
plotP = [P(2,2)];

for t = vreme
    
    X = Ad * X + Bd * u;
    
    % X(t+1) = Ad * X(t) + Bd * u(t)
    
    realnoFi = [realnoFi, X(2)];        

    [gyro, a, dNoiseFi] = imu_noise(X(2), X(4), mb, g, dt);    
    z = [a; dNoiseFi]; %ocitavanja senzora
    senzor = [senzor, a];
    [kalmanX, P] = kalman_filter(A_kalman, Bd, u, kalmanX, P, z); 
    plotP = [plotP, P(2,2)];
    
    senzorFi = [senzorFi, kalmanX(2)];
    
    u = -K * [X(1); kalmanX(2); X(3); kalmanX(4)];
    
end

%figure(1)          
plot(senzorFi, 'b')
hold on
plot(realnoFi, 'r')
%figure(2)
%plot(gyro, 'g')