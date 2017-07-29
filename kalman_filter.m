function [ X_novo, P_novo ] = kalman_filter( A, B, Q, R, u, X, P, z )

    H = [1 0;
         1 0;
         0 1];
    
    B = [B(2); B(4)];
    A = [A(2, 2), A(2, 4);
         A(4, 2), A(4, 4)];
    
    Q = [Q(2, 2), 0;
         0, Q(4, 4)];
     
    %predikcija
    X_ = A*X + B*u;
    P_ = A*P*A' + Q;
    
    %inovacija
    Y = z - H * X_;
    S = H * P_ * H' + R;
    
    %update
    Kk = P_*H' * pinv(S);
    
    X_novo = X_ + Kk*Y;
    P_novo = (eye(size(P_)) - Kk*H) * P_;

end

