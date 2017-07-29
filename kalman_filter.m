function [ X_novo, P_novo ] = kalman_filter( A, B, Q, R, u, X, P, z )

    H = [0 1 0 1;
         0 1 0 1];

    %predikcija
    X_ = A*X + B*u;
    %Fi_ = holder(2);
    P_ = A*P*A' + Q;
    
    %inovacija
    Y = z - H * X_;
    S = H * P_ * H' + R;
    
    %update
    Kk = P_*H' * inv(S);
    
    X_novo = X_ + Kk*Y;
    P_novo = (eye(size(P_)) - Kk*H) * P_;

end

