Ka = 0.01;
Ke = 0.01;
Km = 0.01; %neke konstante (dodati prava imena)

La = 1; %aktivni otpor
Ra = 1; %pasivni otpor
m = 0.5; %masa tocka 
r = 0.5; %precnik tocka

I = m*r*r/2; %momen inercije
Ta = La/Ra; %elektricna vremenska konstanta armaturnog ...
Tm = I/(Ka*Ke*Km); %elektromehanicka vremenska konstanta
