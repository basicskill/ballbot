close all, clear all
rw = 0.1058;
rr = 0.006335;
mw = 2.44;
Iw = 0.0174;
lb = 0.69;
Ib = 120.59;

mb = 51.66;
Dc = 3.82;
Dv = 3.68;
Ki = 2.128;
g = 9.81;

maxVreme = 5; dt = .01;
X1 = [0; -.6; 0; 0];
greska_poc_stanja = [0; 0; 0; 0];


vek_preskoka = [];
vek_kasnjenja = [];
vek_uspona = [];
vreme_smirenja = [];
epsilon = 0.02 * (pi/2);
n = 50;
t_s = 0;

%moment inercije
%{
for moment_inercije = (Ib-100): 10: (Ib+100)

    %parametri = [rw, rr, mw, moment_inercije, lb, Ib, mb, g];
    [Fi, senzorFi] = simuliraj(X1, maxVreme, dt, ...
                greska_poc_stanja, ...
                rw, rr, mw, Iw, lb, moment_inercije, mb, g);
    plot(Fi);
    
end
%}
hold on
% duzina klatna
for duzina_klatna = (lb - .5): .1: (lb + .5)
    t_10 = 0; t_50 = 0; t_90 = 0;
    brojac_smirenja = 0; t_s = 0;
    
    %parametri = [rw, rr, mw, moment_inercije, lb, Ib, mb, g];
    [Fi, senzorFi] = simuliraj(X1, maxVreme, dt, greska_poc_stanja, ...
          rw, rr, mw, Iw, duzina_klatna, Ib, mb, g);
    plot(dt:dt:maxVreme, Fi);
    maxFi = max(Fi);
    
    %Procetni uspona
    for i = 1: size(Fi, 2)
        
        if (Fi(i) >= X1(2) + abs(.1 * X1(2))) && (t_10 == 0)
            t_10 = i;
        end
        
        if (Fi(i) >= X1(2) + abs(.5 * X1(2))) && (t_50 == 0)
            t_50 = i;
        end
        
        if (Fi(i) >= X1(2) + abs(.9 * X1(2))) && (t_90 == 0)
            t_90 = i;
        end
        
        if (Fi(i) < epsilon) && (Fi(i) > -epsilon)
            brojac_smirenja = brojac_smirenja + 1;
        
            if brojac_smirenja >= n
                t_s = i;
                break
            end
        else            
            brojac_smirenja = 0;
        end
        
    end
    
    
    
        
    
    vek_uspona = [vek_uspona, (t_90 - t_10)*dt];
    vek_kasnjenja = [vek_kasnjenja, t_50*dt];
    vreme_smirenja = [vreme_smirenja, t_s*dt];
    
    preskok = (maxFi + X1(2)) / X1(2);
    vek_preskoka = [vek_preskoka, preskok];
        
end

% figure
% stem(vek_uspona)
% 
% figure
% stem(vek_kasnjenja)
% 
% figure
% stem(vreme_smirenja)
% 
% figure
% stem(vek_preskoka)

















