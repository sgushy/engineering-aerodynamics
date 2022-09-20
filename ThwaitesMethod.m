%% Matlab code to use Thwaites' Method to find the separation point of flow around an airfoil,
% given a set of points depicting points on the airfoil, as well as the
% velocity and circulation profiles around it
% Inputs: the lengths of each vortex panel, velocity field of each vortex
% panel, and circulation field of each vortex panel, and the x,y coords of
% each control point...
function [sep,stag] = ThwaitesMethod(panelLength,velfield,AoA_rad)

%% Define variables
panelLength = panelLength(1:end-1);

velfield = velfield*100;

indices = 1:1:length(panelLength);

%x = cumsum(panelLength); % computes total arc-distances

x = panelLength/2 + cumsum(panelLength)-panelLength(1);
x(1) = 0;

dx = panelLength; dx(1) = panelLength(1)/2;

u_6 = velfield.^6; % U_e^6
u_5 = velfield.^5; % U_e^5
u_6 = u_6(1:end-1);
u_5 = u_5(1:end-1);
du = diff(velfield);
i_u5 = cumtrapz(x,u_5);
dUedx = du./dx;

K = 0.45./(u_6).*(dUedx).*i_u5;
%% Determine front stagnation point... (back is always at first index)
if velfield(1) < 0
    ind_stag = find(velfield>0,1);
    ind_stag_1 = ind_stag-1;
    dUdx = diff(velfield)./dx(1,end-1);
    slope = dUdx(ind_stag_1);
    diff_x_1_intend = 0 - velfield(ind_stag_1);
    stag1 = diff_x_1_intend./slope+x(ind_stag_1);
else
    ind_stag = find(velfield<0,1);
    ind_stag_1 = ind_stag-1;
    dUdx = diff(velfield)./dx(1,end-1);
    slope = dUdx(ind_stag_1);
    diff_x_1_intend = velfield(ind_stag_1);
    stag1 = diff_x_1_intend./slope+x(ind_stag_1);
end
stag1=stag1; % Arc-distance from forward edge stagnation point to 
ind_stag_1; % The index at which forward edge stagnation point is...
%% Set up K to solve the Thwaites' condition
Kxbar = -0.09; % The condition of the Thwaites' Method boundary point separation

% For upper half of cylinder
upindices = indices(ind_stag_1+1:end);
upx = (x(ind_stag_1:end));

upK = (K(ind_stag_1:end));%0.45./(u_6(ind_stag_1:end)).*(dUedx(ind_stag_1:end)).*i_u5(ind_stag_1:end);%(K(ind_stag_1:end));

% Solve for separation point at top half
if upK(1) < Kxbar
    [ind_sep_up] = find(upK>Kxbar,1);
    ind_sep_up_1 = ind_sep_up-1;
    dUdx = diff(upK)./diff(upx);
    slope = dUdx(ind_sep_up_1);
    diff_x_1_intend = Kxbar - upK(ind_sep_up_1);
    upsep = diff_x_1_intend./slope+upx(ind_sep_up_1);
else
    [ind_sep_up] = find(upK<Kxbar,1);
    ind_sep_up_1 = ind_sep_up-1;
    dUdx = diff(upK)./diff(upx);
    slope = dUdx(ind_sep_up_1);
    diff_x_1_intend = Kxbar - upK(ind_sep_up_1);
    upsep = diff_x_1_intend./slope+upx(ind_sep_up_1);
end


% For lower half of cylinder
lowindices = (indices(1:ind_stag_1-1));
lowK = (K(1:ind_stag_1-1));%0.45./(u_6(1:ind_stag_1-1)).*(dUedx(1:ind_stag_1-1)).*i_u5(1:ind_stag_1-1);
lowx = (x(1:ind_stag_1-1));

% Solve for separation point at bottom half
if lowK(1) < Kxbar
    ind_sep_low = find(lowK>Kxbar,1);
    ind_sep_low_1 = ind_sep_low-1;
    dUdx = diff(lowK)./diff(lowx);
    slope = dUdx(ind_sep_low_1);
    diff_x_1_intend = Kxbar - lowK(ind_sep_low_1);
    lowsep = diff_x_1_intend./slope+lowx(ind_sep_low_1);
else
    ind_sep_low = find(lowK<Kxbar,1);
    ind_sep_low_1 = ind_sep_low-1;
    dUdx = diff(lowK)./diff(lowx);
    slope = dUdx(ind_sep_low_1);
    diff_x_1_intend = Kxbar - lowK(ind_sep_low_1);
    lowsep = diff_x_1_intend./slope+lowx(ind_sep_low_1);
end

%upsep = upsep(1,1);
%lowsep = lowsep(end);
%sep = [(upsep-pi),(lowsep-pi)];
%sep = sep*[cos(AoA_rad), sin(AoA_rad); -sin(AoA_rad), cos(AoA_rad)];
%sep = [upsep+stag1,stag1-(lowsep)];
%sep(3) = upsep;
%sep(4) = lowsep;
stag = [stag1,0];
sep = [(upsep),(lowsep)];

% figure(7);
% hold on
% xlabel('Distance Along Airfoil from Trailing Stagnation Point (x_s)');
% ylabel('K(x_s)');
% plot(x,K,'s-','Color','b');
% plot(upsep,-0.09,'x','Linewidth',8,'Color','r');
% plot(lowsep,-0.09,'x','Linewidth',8,'Color','g');
% plot(x,ones(1,length(x))*-0.09,'-');
% axis([0,8,-5,5])
% hold off
end
