%% Analytically solve for the pressure distribution and velocity around a cylinder 
% of radius r

function [Cp,U,thetas] = AnalyticalCylinder(r,ALPHA_deg)
    thetas = 2*pi:-0.001:0;
    U = 0;
    ALPHA = ALPHA_deg*pi/180;
    Cp = 1 - (2*sin(thetas-ALPHA) + 2*sin(ALPHA)).^2;

end