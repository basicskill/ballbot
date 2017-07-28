function [ ugao_gyro, ugao_acc, gyro ] = imu_noise( Fi, izvdFi, m, g, dt)
    
    gyro_kw = .001; acc_kw = .005;
    
    gyro_drift = 1 * dt;
   
    k = 1;
    gyro_rwalk = rand(1);
    if (gyro_rwalk < .5) 
        k = -k; 
    end    
    gyro_koef = .001;
    gyro_rwalk = gyro_koef * k * gyro_rwalk;
    
    k = 1;
    acc_rwalk = rand(1);
    if (acc_rwalk < .5) 
        k = -k;
    end
    gyro_koef = .001;
    acc_rwalk = gyro_koef * k * acc_rwalk;
    
    
    gyro_noise = gyro_kw * randn(1) + gyro_drift + gyro_rwalk;
    acc_noise = acc_kw * randn(1);

    gyro = izvdFi + gyro_noise;
    acc = m * g * cos(Fi) + acc_noise;
    
    ugao_gyro = Fi + gyro * dt;
    ugao_acc = acos(acc/(m*g));
    
end
