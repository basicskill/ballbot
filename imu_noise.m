function [ ugao_gyro, ugao_acc, gyro ] = imu_noise( Fi, izvdFi, m, g, dt)
    
    gyro_wn = 0.01 * randn(1); 
    acc_wn = 0.002 * randn(1);
    
    %wn g 0.01 a0.02
    %cb g 0.1 a 0
    %rw g 0.05 a 0.001
    %djeneralove konstante
    gyro_bias = 0;
   
    gyro_rwalk = rand(1);
    if (gyro_rwalk < .5) 
        gyro_rwalk = -gyro_rwalk; 
    end    
    gyro_koef = 0.05;
    gyro_rwalk = gyro_koef * gyro_rwalk;
    
  
    acc_rwalk = rand(1);
    if (acc_rwalk < .5) 
        acc_rwalk = -acc_rwalk;
    end
    acc_koef = 0.00001;
    acc_rwalk = acc_koef * acc_rwalk;
    
    
    gyro_noise = gyro_wn  + gyro_bias + gyro_rwalk;
    acc_noise = acc_wn + acc_rwalk;

    gyro = izvdFi + gyro_noise;
    acc = g * cos(Fi) + acc_noise;
    
    ugao_gyro = Fi + gyro * dt;
    
    ugao_acc = acc/g;
 
     if ugao_acc > 1
         ugao_acc = 1;
     end
     if ugao_acc < -1 
         ugao_acc = -1;
     end
    
    ugao_acc = sign(Fi) * acos(ugao_acc);

    
end
