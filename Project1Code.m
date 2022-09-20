%% Initialize grid
clear; clc;
x = linspace(-5,5,101);
y = linspace(-5,5,101);

[XX,YY] = meshgrid(x,y);
dt = 0.5;
t_i = 0; t_f = 5;
nt = 1+t_f/dt;
%% Set up vortices here
num_vortices = 2;
vortices(1) = createvortex(1,3,0,3,nt,false);
vortices(2) = createvortex(2,-3,0,-3,nt,false);
% for index = 1:1:num_vortices
%    vortices(index) = createvortex(index*1.5,index*1.5,2,nt); 
% end
%% Loop through time;
for t=2:nt
    for index = 1:1:length(vortices)
        vortex = vortices(index);
        u_field=0; v_field=0;
        for index2 = 1:1:length(vortices)
                vortex2 = vortices(index2);
                if vortex2.id ~= vortex.id
                [provu,provv] = calcvortexfieldat(vortex.posx(t-1),vortex.posy(t-1),vortex2.circ,vortex2.posx(t-1),vortex2.posy(t-1));
                u_field = u_field+provu;
                v_field = v_field+provv;
                else
                u_field = u_field+0;
                v_field = v_field+0;
                end
        end
       u_new = u_field;
       v_new = v_field;
       tempposx = vortex.posx;
       tempposx(t) = tempposx(t-1)+u_new*dt;
       tempposy = vortex.posy;
       tempposy(t) = tempposy(t-1)+v_new*dt;
       vortex.posx = tempposx;
       vortex.posy = tempposy;
    end
end
%% Plot 
fig = figure(1);
hold on
xlabel('X','Fontsize',16);
ylabel('Y','Fontsize',16);

axis equal
axis([-5,5,-5,5])
grid on
set(gcf, 'color', 'w');

colors_ = ['m','k','g','b'];

for index2 = 1:1:length(vortices)
    vortex = vortices(index);
    plot(vortex.posx,vortex.posy,'LineWidth',2);
end

hold off
%% Vortex vector field calculator (from 1 single vortex)
function [u,v] = calcvortexfieldat(x_pos,y_pos,circ,vortex_x,vortex_y)
u = (circ./(2*pi.*(((x_pos-vortex_x).^2 + (y_pos-vortex_y).^2)))).*(-(y_pos-vortex_y));
v = (circ./(2*pi.*(((x_pos-vortex_x).^2 + (y_pos-vortex_y).^2)))).*((x_pos-vortex_x));
end

%% Create vortex
function [vortex] = createvortex(index,center_x,center_y,circ,timesteps,isimage)
vortex.id = index;
vortex.posx = zeros(timesteps,1);
vortex.posx(1) = center_x;
vortex.posy = zeros(timesteps,1);
vortex.posy(1) = center_y;
vortex.circ = circ;
vortex.image = isimage;
end

%% Update vortex velocity field
% These are the methods to use now 
function [ufield2] = ufield(circ,xposvort,yposvort,xposalt,yposalt)
ufield2 = calcvortexfieldat(xposalt,yposalt,circ,xposvort,yposvort)
end
function [vfield2] = vfield(circ,xposvort,yposvort,xposalt,yposalt)
[~,vfield2] = calcvortexfieldat(xposalt,yposalt,circ,xposvort,yposvort)
end
%%


