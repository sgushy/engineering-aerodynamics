%% Calculation of Lift Coefficient for Airfoil at a given angle of attack...

function [C_L,C_D,pressure_dist,controlPts,AirfoilRotated] = AirfoilCalc(AFSurface,AoA_deg,Cp)
xb = AFSurface(1,:); % X-boundary points
yb = AFSurface(2,:); % Y-boundary points

P_inf = 101300; %[Pa] (air, sea level)
rho = 1.225; % [kg/m^3] (air)
u_inf = 100; % [m/s] fluid velocity

%% Find control points (xc,yc) from boundary points (xb,yb)
xc = (xb(2:end)+xb(1:end-1))./2;
yc = (yb(2:end)+yb(1:end-1))./2;

%% Determine length of each panel
S = sqrt((xb(2:end)-xb(1:end-1)).^2+(yb(2:end)-yb(1:end-1)).^2);

%% Convert pressure coefficient to absolute pressure
P = Cp*(0.5*rho*u_inf^2)+P_inf;
dP = Cp*(0.5*rho*u_inf^2);

%% Angle made by 2 boundary points
Theta = atan2((yb(2:end)-yb(1:end-1)),(xb(2:end)-xb(1:end-1)));
Theta_Deg = Theta .* (180/pi);

%% Calculate and plot outward normal vectors
nx = cos(Theta+pi/2);
ny = sin(Theta+pi/2);

%% Calculate and plot forces
Fx = -P.*nx.*S; % x-direction forces [N/m]
Fy = -P.*ny.*S; % y-direction forces [N/m]

%Resultant forces
FX = sum(Fx); FY = sum(Fy); % [N/m]

%% Calculate and plot lift/drag forces
vec_F = [FX;FY]; AoA_rad = AoA_deg*(pi/180);
R_ccw = [cos(AoA_rad), sin(AoA_rad); -sin(AoA_rad), cos(AoA_rad)];
R_cw = [cos(AoA_rad), -sin(AoA_rad); sin(AoA_rad), cos(AoA_rad)];
[vec_DL] = R_ccw*vec_F;
D = vec_DL(1); L = vec_DL(2); % Drag and lift forces

%Rotate the airfoil properly
for iii = 1:1:length(xb)
    vec_temp = [xb(iii);yb(iii)];
    temp_res = R_ccw*vec_temp;
    Airfoil_Rot(iii,1) = temp_res(1);
    Airfoil_Rot(iii,2) = temp_res(2);
end

%% Assign results
C_L = L/(0.5*rho*u_inf^2);
C_D = L./D; % Lift to drag ratio...
pressure_dist = P;
AirfoilRotated = Airfoil_Rot;
controlPts = [xc;yc];
end