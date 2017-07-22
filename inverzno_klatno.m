M = 0.5;
m = 0.2;
b = 0.1;
I = 0.006;
g = 9.8;
l = 0.3;
q = (M+m)*(I+m*l^2)-(m*l)^2;
s = tf('s');

%q = (M+m) * (I + m*l^2) - (m*l)^2;

%A = s^3 + (b*(I+m*l)/q)*s^2 - (((m+M)*m*g*l)/q)*s - b*m*g*l/q;

%HG = ((m*l)/(A*q))*(s*Kp+Ki+Kd*s*s);
P_cart = (((I+m*l^2)/q)*s^2 - (m*g*l/q))/(s^3 + (b*(I + m*l^2))*s^2/q ...
    - ((M + m)*m*g*l)*s/q - b*m*g*l/q); %transfer funkcija pozicije

t = 0.0: 0.001: 10.0;
u = ones(10001, 1);

u = u * 5;

lsim(P_cart, u, t)