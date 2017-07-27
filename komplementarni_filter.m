function [ output ] = komplementarni_filter( gyro, acc )

    alfa = .02;
    output = (1 - alfa) * gyro + alfa * acc;
    output = abs(output) * sign(gyro);

end

