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


pltTheta = [];
pltFi = [];

izvdTheta = 0; izvd2Theta = 0; izvdFi = 0; izvd2Fi = 0;
q = [0; 0];

dt = 0.01;
vreme = 0: dt: 10;

for t = vreme
    M = [alpha, alpha + beta*q(2);
        alpha + beta*q(2), alpha + gama + 2*beta*q(2)];
    C = [-beta * q(2) * izvdFi; -beta * q(2) * izvdFi];
    G = [0; -beta * g * q(2) / rr];
    D = [Dc * sign(izvdTheta) + Dv * izvdTheta; 0];
    
    kl = inv(M) * ([1; 0] - D - G - C);
    izvd2Theta = kl(1);
    izvd2Fi = kl(2);
    izvdTheta = izvdTheta + izvd2Theta * dt;
    q(1) = q(1) + izvdTheta * dt;
    
    izvdFi = izvdFi + izvd2Fi * dt;
    q(2) = q(2) + izvdFi * dt;
    
    pltTheta = [pltTheta, q(1)];
    pltFi = [pltFi, q(2)];    
end

figure(1)          
plot(pltFi)
figure(2)
plot(pltTheta)







                                                                                                                                                                                                                        










