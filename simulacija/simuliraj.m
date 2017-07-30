function [ realnoFi, senzorFi ] = simuliraj(X1, maxVreme, dt, ...
                            greska_kalman, ...
                            rw, rr, mw, Iw, lb, Ib, mb, g)

    %rw, rr, mw, Iw, lb, Ib, mb, g 
    %[rw, rr, mw, Iw, lb, Ib, mb, g] = parametri;
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

    Q = [1 0 0 0;
         0 1 0 0;
         0 0 10 0;
         0 0 0 100];
    R = 0.1;

    K = lqr(A, B, Q, R);

    realnoFi = [];
    vreme = dt: dt: maxVreme;


    sys_ct = ss(A, B, [], []);
    temp = c2d(sys_ct, .01, 'zoh');
    Ad = temp.a; 
    Bd = temp.b;

    dX = zeros(4, 1);
    X = X1; 
    u = 0;
    realnoFi = [];
    P = diag([.1 .1 .1 .1]);
    kalmanX = X1 + greska_kalman;
    senzorFi = [kalmanX(2)];

    for t = vreme

        X = Ad * X + Bd * u;

        realnoFi = [realnoFi, X(2)];        

        [gyro, a, dNoiseFi] = imu_noise(X(2), X(4), mb, g, dt);    
        z = [a; dNoiseFi]; %ocitavanja senzora
        %senzor = [senzor, a];
        [kalmanX, P, inov] = kalman_filter(Ad, Bd, u, kalmanX, P, z); 

        senzorFi = [senzorFi, kalmanX(2)];

        u = -K * [X(1); kalmanX(2); X(3); kalmanX(4)];

    end
end

