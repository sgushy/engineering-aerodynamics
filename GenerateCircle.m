%% Generation of a circle of n points, and radius of r, and centered around
% (xcenter, ycenter)
% Output: bp (all points along the edge of circle, spaced evenly
% thetas (the angle of each point on the circle's surface corresponding to
% the index of each point in bp
function [bp,thetas] = GenerateCircle(r,n,xCenter,yCenter)
theta = 2*pi : -2*pi/(n) : 0;
thetas = theta(1:end-1);
radius = r;
x = radius * cos(theta) + xCenter;
y = radius * sin(theta) + yCenter;
figure(1);
% hold on
% title("Visualization of Airfoil (Cylinder, n="+n+")");
% plot(x, y);
% axis square;
% xlim([xCenter-1.5*r xCenter+1.5*r]);
% ylim([yCenter-1.5*r yCenter+1.5*r]);
% grid on;
% axis equal;
% hold off
bp(1,:) = x;
bp(2,:) = y;
end