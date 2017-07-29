function [ ugao_gyro, ugao_acc, gyro ] = imu_noise( Fi, izvdFi, m, g, dt)
    
    gyro_wn = 0.01 * randn(1); acc_wn = 0.02 * randn(1);
    
    %wn g 0.01 a0.02
    %cb g 0.1 a 0
    %rw g 0.05 a 0.001
    %djeneralove konstante
    gyro_bias = 0;
   
    k = 1;
    gyro_rwalk = rand(1);
    if (gyro_rwalk < .5) 
        k = -k; 
    end    
    gyro_koef = 0.05;
    gyro_rwalk = gyro_koef * k * gyro_rwalk;
    
    k = 1;
    acc_rwalk = rand(1);
    if (acc_rwalk < .5) 
        k = -k;
    end
    gyro_koef = 0.001;
    acc_rwalk = gyro_koef * k * acc_rwalk;
    
    
    gyro_noise = gyro_wn  + gyro_bias + gyro_rwalk;
    acc_noise = acc_wn + acc_rwalk;

    gyro = izvdFi + gyro_noise;
    acc = m * g * cos(Fi) + acc_noise;
    
    ugao_gyro = Fi + gyro * dt;
    
    ugao_acc = acc/(m*g);

    if ugao_acc > 1
        ugao_acc = 1;
    end
    if ugao_acc < -1 
        ugao_acc = -1;
    end
    
    ugao_acc = acos(ugao_acc);
    
    
    
    
    
end
