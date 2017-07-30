function [ X_novo, P_novo, Y ] = kalman_filter(A, B, u, X, P, z )


%gyro 0.05 acc 0.5 brzina 0.8
    H = [0 1 0 0;
         0 0 0 1];
     
    Q = diag([1e-10 0.001 1e-10 1e-10]);
      
    R = [0.1 0;
         0 0.1];
     
    %predikcija
    X_ = A*X + B*u;
    P_ = A*P*A' + Q;
    
    %inovacija
    Y = z - H * X_;
    S = H * P_ * H' + R;
    
    %update
    Kk = P_ * H' / S;
    
    X_novo = X_ + Kk*Y;
    P_novo = (eye(size(P)) - Kk*H) * P_;

end




