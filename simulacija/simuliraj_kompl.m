function [ realnoFi, senzorFi ] = simuliraj_kompl(X, maxVreme, dt, ...
                            greska_kalman, ...
                            rw, rr, mw, lb, mb, g)

    Ib = (mb * lb^2)/3;
    Iw = 2 * (mw * rw^2) / 3;                    
                        
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

    vreme = dt: dt: maxVreme;


    sys_ct = ss(A, B, [], []);
    temp = c2d(sys_ct, .01, 'zoh');
    Ad = temp.a; 
    Bd = temp.b;


   
    u = 0;
    realnoFi = [];
    senzorFi = [];
    
    for t = vreme
        
        X = Ad * X + Bd * u;
       
        realnoFi = [realnoFi, X(2)];        

        [gyro, a, dNoiseFi] = imu_noise(X(2), X(4), mb, g, dt);    
        z = [gyro; a; dNoiseFi]; %ocitavanja senzora

        mereni_ugao = komplementarni_filter(gyro, a);
        senzorFi = [senzorFi, mereni_ugao];

        u = -K * [X(1); mereni_ugao; X(3); dNoiseFi];

    end
end


