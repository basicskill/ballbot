function matrica = M(q)
    matrica = [alfa, alfa + beta*q(2);
        alfa + beta*q(2), alfa + gama + 2*beta*q(2)];
end
 M = [alpha, alpha + beta*q(2);
        alpha + beta*q(2), alpha + gama + 2*beta*q(2)];
    C = [-beta * q(2) * izvdFi; -beta * q(2) * izvdFi];
    G = [0; -beta * g * q(2) / rr];
    D = [Dc * sign(izvdTheta) + Dv * izvdTheta; 0];
   

