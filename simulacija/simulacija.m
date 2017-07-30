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
X1 = [0; -.1; 0; 0];
greska_poc_stanja = [0; 0; 0; 0];
hold on

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

% duzina klatna
for duzina_klatna = (lb - .5): .1: (lb + .5)

    %parametri = [rw, rr, mw, moment_inercije, lb, Ib, mb, g];
    [Fi, senzorFi] = simuliraj(X1, maxVreme, dt, ...
                greska_poc_stanja, ...
                rw, rr, mw, Iw, duzina_klatna, Ib, mb, g);
    plot(Fi);
    
end













