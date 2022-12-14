clear;clc;close all;

T = 50; % [kg] of total thrust from design
%Omega_Hz = 4; % Rotational velocity (Hz)
Omega = 44.6106; % Rotational velocity (Hz)

rho = 1.225; % Air density; [kg/m^3]
nu = 1.467*10^-5; % Air kinematic viscosity
% R_o:0.52m
% R_i=0.32m
% r_o=0.268m
% r_i=0.13m
% C_max=0.04m
% c_max=0.045m
% Omega=44.6106Rad/s
% Omega_Hz=7.1Hz
% RPM=426rpm
% T_o=26.2629N
% T_i=24.6814N
% Q_o=2.7816Nm
% Q_i=2.8601Nm
% Solidity=0.063257
% Re_i=27505.3183
% Re_o=47438.6915

%% Set Up Dimensions for Outer Rotor
T_o = T/2; % Half of total thrust is generated by the outer rotor
R_i = 0.32; % Small radius of outer rotor (m)
R_o = 0.52; % Large radius of outer rotor (m)
N = 4; % Number of rotors blades for outer rotor

C_max = 0.04; % Chord length at base (m)
C_min = 0.75*C_max; % Chord length at tip (m)

%% Set Up Dimensions for Inner Rotor
T_i = T/2; % Half of total thrust is generated by the inner rotor
r_i = 0.13; % Small radius of inner rotor (m)
r_o = 0.268; % Large radius of inner rotor (m)
n = 3; % Number of rotors blades for inner rotor
c_max = 0.045; % Chord length at base (m)
c_min = 0.75*c_max; % Chord length at tip (m)

Area = pi*(r_o^2 - r_i^2)+pi*(R_o^2 - R_i^2);
V_h = sqrt(T./(2.*rho.*Area));

%% Setup and Solution of Blade Shapes and Camber: Outer Rotor
R_c = 2*R_o; % The radius of blade camber
index = 1;
for R_temp = R_i:0.001:R_o
    C_R(index) = C_max-(R_temp-R_i)*(C_max-C_min)/(R_o-R_i);
    index = index + 1;
end
Alpha = asin(C_R./(2*R_c)); % Angles of attack for outer rotor
Z_m = C_R.^2./R_c;
Phi = atan(V_h./(Omega.*(R_i:0.001:R_o)));
C_L = 2*pi.*(Alpha + 2.*Z_m./C_R); % Approx lift coefficients at each segment (outer rotor)
C_D = -Alpha.*C_L; % Approx induced drag coefficients at each segment (outer rotor)
L_1 = C_L.*cos(Phi) - C_D.*sin(Phi);
L_2 = C_L.*sin(Phi) + C_D.*cos(Phi);

Sigma = N.*C_R./(2.*pi.*(R_i:0.001:R_o));

dTdR = pi.*Sigma.*rho.*L_1.*(R_i:0.001:R_o).^3.*Omega.^2.*(sec(Phi)).^2;
dQdR = pi.*Sigma.*rho.*L_2.*(R_i:0.001:R_o).^4.*Omega.^2.*(sec(Phi)).^2;

%% Setup and Solution of Blade Shapes and Camber: Inner Rotor
R_c = 2*R_o; % The radius of blade camber
index = 1;
for r_temp = r_i:0.001:r_o
    c_r(index) = c_max-(r_temp-r_i)*(c_max-c_min)/(r_o-r_i);
    index = index + 1;
end
alpha = asin(c_r./(2.*R_c)); % Angles of attack for outer rotor
z_m = c_r.^2./R_c;
phi = atan(V_h./(Omega.*(r_i:0.001:r_o)));
c_l = 2*pi.*(alpha + 2.*z_m./c_r); % Approx lift coefficients at each segment (outer rotor)
c_d = -alpha.*c_l; % Approx induced drag coefficients at each segment (outer rotor)
l_1 = c_l.*cos(phi) - c_d.*sin(phi);
l_2 = c_l.*sin(phi) + c_d.*cos(phi);

sigma = n.*c_l./(2.*pi.*(r_i:0.001:r_o));

dTdr = pi.*sigma.*rho.*l_1.*(r_i:0.001:r_o).^3.*Omega.^2.*(sec(phi)).^2;
dQdr = pi.*sigma.*rho.*l_2.*(r_i:0.001:r_o).^4.*Omega.^2.*(sec(phi)).^2;
%% Find Total Thrust and Total Torque
T_i = cumtrapz(r_i:0.001:r_o,dTdr); % Thrust generated by the inner
T_o = cumtrapz(R_i:0.001:R_o,dTdR); % Thrust generated by the outer
Q_i = cumtrapz(r_i:0.001:r_o,dQdr);
Q_o = cumtrapz(R_i:0.001:R_o,dQdR);

T_i = n.*T_i(end); T_o = N.*T_o(end); Q_i = n.*Q_i(end); Q_o = N.*Q_o(end);

A_o = cumtrapz(R_i:0.001:R_o,C_R);
A_i = cumtrapz(r_i:0.001:r_o,c_r);
A_o = N*A_o(end); A_i = n*A_i(end);
            V_h = sqrt(T./(2.*rho.*Area));

            %% Setup and Solution of Blade Shapes and Camber: Outer Rotor
            R_c = 1*R_o; % The radius of blade camber
            index = 1;
            C_R = zeros(size(R_i:0.001:R_o));
            for R_temp = R_i:0.001:R_o
                C_R(index) = C_max-(R_temp-R_i)*(C_max-C_min)/(R_o-R_i);
                index = index + 1;
            end
            Alpha = asin(C_R./(2*R_c)); % Angles of attack for outer rotor
            Z_m = C_R.^2./R_c;
            Phi = atan(V_h./(Omega.*(R_i:0.001:R_o)));
            C_L = 2*pi.*(Alpha + 2.*Z_m./C_R); % Approx lift coefficients at each segment (outer rotor)
            C_D = -Alpha.*C_L; % Approx induced drag coefficients at each segment (outer rotor)
            L_1 = C_L.*cos(Phi) - C_D.*sin(Phi);
            L_2 = C_L.*sin(Phi) + C_D.*cos(Phi);

            Sigma = N.*C_R./(2.*pi.*(R_i:0.001:R_o));

            dTdR = pi.*Sigma.*rho.*L_1.*(R_i:0.001:R_o).^3.*Omega.^2.*(sec(Phi)).^2;
            dQdR = pi.*Sigma.*rho.*L_2.*(R_i:0.001:R_o).^4.*Omega.^2.*(sec(Phi)).^2;

            %% Setup and Solution of Blade Shapes and Camber: Inner Rotor
            R_c = 2*R_o; % The radius of blade camber
            index = 1;
            c_r = zeros(size(r_i:0.001:r_o));
            for r_temp = r_i:0.001:r_o
                c_r(index) = c_max-(r_temp-r_i)*(c_max-c_min)/(r_o-r_i);
                index = index + 1;
            end
            alpha = asin(c_r./(2*R_c)); % Angles of attack for outer rotor
            z_m = c_r.^2./R_c;
            phi = atan(V_h./(Omega.*(r_i:0.001:r_o)));
            c_l = 2*pi.*(alpha + 2.*z_m./c_r); % Approx lift coefficients at each segment (outer rotor)
            c_d = -alpha.*c_l; % Approx induced drag coefficients at each segment (outer rotor)
            l_1 = c_l.*cos(phi) - c_d.*sin(phi);
            l_2 = c_l.*sin(phi) + c_d.*cos(phi);

            sigma = n.*c_l./(2.*pi.*(r_i:0.001:r_o));

            dTdr = pi.*sigma.*rho.*l_1.*(r_i:0.001:r_o).^3.*Omega.^2.*(sec(phi)).^2;
            dQdr = pi.*sigma.*rho.*l_2.*(r_i:0.001:r_o).^4.*Omega.^2.*(sec(phi)).^2; 
            
%% Find Total Thrust and Total Torque
T_i = cumtrapz(r_i:0.001:r_o,dTdr); % Thrust generated by the inner
T_o = cumtrapz(R_i:0.001:R_o,dTdR); % Thrust generated by the outer
Q_i = cumtrapz(r_i:0.001:r_o,dQdr);
Q_o = cumtrapz(R_i:0.001:R_o,dQdR);

T_i = n.*T_i(end); T_o = N.*T_o(end); Q_i = n.*Q_i(end); Q_o = N.*Q_o(end);

A_o = cumtrapz(R_i:0.001:R_o,C_R);
A_i = cumtrapz(r_i:0.001:r_o,c_r);
A_o = N*A_o(end); A_i = n*A_i(end);

if(abs(Q_i - Q_o) < 10^-1&&abs(T_i + T_o - T) < 1 && (A_o+A_i)/Area < 0.1)
   disp("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-");
   disp("R_o:"+num2str(R_o)+"m");
   disp("R_i:"+num2str(R_i)+"m");
   disp("r_o:"+num2str(r_o)+"m");
   disp("r_i:"+num2str(r_i)+"m");
   disp("C_max:"+num2str(C_max)+"m");
   disp("c_max:"+num2str(c_max)+"m");
   disp("Start twist of outer:"+rad2deg(Alpha(1)+Phi(1))+"deg");
   disp("Finish twist of outer:"+rad2deg(Alpha(end)+Phi(end))+"deg");
   
   disp("Start twist of inner:"+rad2deg(alpha(1)+phi(1))+"deg");
   disp("Finish twist of inner:"+rad2deg(alpha(end)+phi(end))+"deg");
   
   disp("Omega:"+num2str(Omega)+"Rad/s");
   disp("Omega_Hz:"+num2str(Omega/(2*pi))+"Hz");
   disp("RPM:"+num2str(Omega/(2*pi)*60)+"rpm");
   disp("T_o:"+num2str(T_o)+"N");
   disp("T_i:"+num2str(T_i)+"N");
   disp("Q_o:"+num2str(Q_o)+"Nm");
   disp("Q_i:"+num2str(Q_i)+"Nm");
   disp("Solidity:"+num2str((A_o+A_i)/Area));
   disp("Re_i:"+num2str(c_r(end).*r_o.*Omega./nu));
   disp("Re_o:"+num2str(C_R(end).*R_o.*Omega./nu));
   disp("Ma_o:"+num2str(Omega.*R_o/343));
   
   figure;
   hold on
   title("Inner Rotor Blade - Local Chord Thickness");
   xlabel("Distance from Center of Rotation (m)");
   ylabel("Chord Thickness c(r) (m)");
   plot(r_i:0.001:r_o, c_r, "Linewidth", 2);
   hold off
   
   figure;
   hold on
   title("Outer Rotor Blade - Local Chord Thickness");
   xlabel("Distance from Center of Rotation (m)");
   ylabel("Chord Thickness c(r) (m)");
   plot(R_i:0.001:R_o, C_R, "Linewidth", 2);
   hold off
   
   figure;
   hold on
   title("Inner Rotor Blade - Local Attack, Velocity, and Pitch Angles");
   xlabel("Distance from Center of Rotation (m)");
   ylabel("Angle (degrees)");
   plot(r_i:0.001:r_o, rad2deg(alpha), "Linewidth", 2);
   plot(r_i:0.001:r_o, rad2deg(phi), "Linewidth", 2);
   plot(r_i:0.001:r_o, rad2deg(alpha+phi), "Linewidth", 2);
   legend("Local Angle of Attack \alpha (r)","Relative Fluid Velocity Angle \phi (r)","Blade Pitch Angle \theta (r)");
   hold off
   
      figure;
   hold on
   title("Outer Rotor Blade - Local Attack, Velocity, and Pitch Angles");
   xlabel("Distance from Center of Rotation (m)");
   ylabel("Angle (degrees)");
   plot(R_i:0.001:R_o, rad2deg(Alpha), "Linewidth", 2);
   plot(R_i:0.001:R_o, rad2deg(Phi), "Linewidth", 2);
   plot(R_i:0.001:R_o, rad2deg(Alpha+Phi), "Linewidth", 2);
   legend("Local Angle of Attack \alpha (r)","Relative Fluid Velocity Angle \phi (r)","Blade Pitch Angle \theta (r)");
   hold off
   
         figure;
   hold on
   title("Inner Rotor Blade - Thrust and Torque Coefficients");
   xlabel("Distance from Center of Rotation (m)");
   ylabel("Coefficient (Dimensionless)");
   plot(r_i:0.001:r_o, l_1, "Linewidth", 2);
   plot(r_i:0.001:r_o, l_2, "Linewidth", 2);
   legend("Local Thrust Coefficient \lambda_1","Local Torque Coefficient \lambda_2");
   hold off
   
         figure;
   hold on
   title("Outer Rotor Blade - Thrust and Torque Coefficients");
   xlabel("Distance from Center of Rotation (m)");
   ylabel("Coefficient (Dimensionless)");
   plot(R_i:0.001:R_o, L_1, "Linewidth", 2);
   plot(R_i:0.001:R_o, L_2, "Linewidth", 2);
   legend("Local Thrust Coefficient \lambda_1","Local Torque Coefficient \lambda_2");
   hold off
   
   figure;
   hold on
   title("Airfoil Visualization");
   xlabel("Distance from Center of Rotation (m)");
   ylabel("Chord Length");
   zlabel("Camber Height");
   %surf(r_i:0.001:r_o, c_r, z_m);
   %surf(R_i:0.001:R_o, C_R, Z_m);
   legend("Local Thrust Coefficient \lambda_1","Local Torque Coefficient \lambda_2");
   hold off
end

            
