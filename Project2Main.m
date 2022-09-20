%% Project 2 - Vortex Panel Method
clc,clear,close all
%% Test Case (from book)
bp(1,:) = [1., .933, .750, .500, .250, .067,0.,.067,.250,.500,.750,.933,1.];
bp(2,:) = [0.,-.005,-.017,-.033,-.042,-.033,0., .041 ,.076, .072, .044, .013,0.];
ALPHA = 0; % Kutta condition in test case
[CpTest, UTest, stest, gamtest] = VortexPanel(bp, ALPHA);
figure(1);
hold on
axis equal
title("Airfoil Profile - Test Case",'Fontsize',14);
plot(bp(1,:),bp(2,:));
hold off
%% Test Case (from piazza)
% ALPHA = 0;
% rn = 1;
% [bp4,thetas_actual4] = GenerateCircle(rn,4,0,0);
% [Cp4N, U4N,s4N, gam4N] = VortexPanel(bp4, ALPHA); % 4 spaced panels
% figure(2)
% hold on
% title("Vortex Panel vs Analytical Solution of Cp Around Cylinder: Non-Lifting Case");
% xlabel("\theta (radians)");
% ylabel("Cp");
% grid on
% axis equal
% plot(thetas_actual4,Cp4N,'Color','r','Linewidth',1.5);
% plot(thetas_actual4,CP_4p(1:end-1),'Color','b','Linewidth',1.5);
% legend('Simulated, 4 points','Test Dataset');
% hold off
%% No lift condition
ALPHA = 0;
rn = 1;
[bp32,thetas_actual32] = GenerateCircle(rn,32,0,0);
[Cp32N, U32N,s32N] = VortexPanel(bp32, ALPHA); % 32 spaced panels
[bp64,thetas_actual64] = GenerateCircle(rn,64,0,0); 
[Cp64N, U64N,s64N] = VortexPanel(bp64, ALPHA); % 64 spaced panels
[bp128,thetas_actual128] = GenerateCircle(rn,128,0,0);
[Cp128N, U128N,s128N] = VortexPanel(bp128, ALPHA); % 128 spaced panels
[CpAnalyticalN,~,thetas_analytical] = AnalyticalCylinder(rn,ALPHA); % Analytical solution
figure(2)
hold on
title("Vortex Panel vs Analytical Solution of Cp Around Cylinder: No Lift Case");
xlabel("\theta (radians)");
ylabel("Cp");
grid on
axis equal
plot(thetas_actual32,Cp32N,'Color','r','Linewidth',1.5);
plot(thetas_actual64,Cp64N,'Color','b','Linewidth',1.5);
plot(thetas_actual128,Cp128N,'Color','g','Linewidth',1.5);
plot(thetas_analytical,CpAnalyticalN,'Color','k','Linewidth',1.5);
legend('Simulated, 32 points','Simulated, 64 points','Simulated, 128 points','Analytical Solution');
hold off
%% Lift condition (Kutta condition at -30deg)
ALPHA = 30;
rn = 1;
[bp32,thetas_actual32] = GenerateCircle(rn,32,0,0);
[Cp32L, U32L,s32L] = VortexPanel(bp32, ALPHA); % 32 spaced panels
[bp64,thetas_actual64] = GenerateCircle(rn,64,0,0); 
[Cp64L, U64L,s64L] = VortexPanel(bp64, ALPHA); % 64 spaced panels
[bp128,thetas_actual128] = GenerateCircle(rn,128,0,0);
[Cp128L, U128L,s128L] = VortexPanel(bp128, ALPHA); % 128 spaced panels
[CpAnalyticalL,~,thetas_analytical] = AnalyticalCylinder(rn,ALPHA); % Analytical solution
figure(3)
hold on
title("Vortex Panel vs Analytical Solution of Cp Around Cylinder: Lifting Case");
xlabel("\theta (radians)");
ylabel("Cp");
grid on
axis equal
plot(thetas_actual32,Cp32L,'Color','r','Linewidth',1.5);
plot(thetas_actual64,Cp64L,'Color','b','Linewidth',1.5);
plot(thetas_actual128,Cp128L,'Color','g','Linewidth',1.5);
plot(thetas_analytical,CpAnalyticalL,'Color','k','Linewidth',1.5);
legend('Simulated, 32 points','Simulated, 64 points','Simulated, 128 points','Analytical Solution');
hold off

figure(4)
hold on
title("Vortex Panel vs Analytical Solution of Cp Around Cylinder: No Lift Case");
xlabel("Position on Chord");
ylabel("Cp");
grid on
axis square
xlim([-1.5*rn 1.5*rn]);
    ylim([-10*rn 10*rn]);
plot(rn.*cos(thetas_actual32),Cp32N,'Color','r','Linewidth',1.5);
plot(rn.*cos(thetas_actual64),Cp64N,'Color','b','Linewidth',1.5);
plot(rn.*cos(thetas_actual128),Cp128N,'Color','g','Linewidth',1.5);
plot(rn.*cos(thetas_analytical),CpAnalyticalN,'Color','k','Linewidth',1.5);
legend('Simulated, 32 points','Simulated, 64 points','Simulated, 128 points','Analytical Solution');
hold off

figure(5)
hold on
title("Vortex Panel vs Analytical Solution of Cp Around Cylinder: Lifting Case");
xlabel("Position on Chord");
ylabel("Cp");
grid on
axis square
xlim([-1.5*rn 1.5*rn]);
    ylim([-10*rn 10*rn]);
plot(rn.*cos(thetas_actual32),Cp32L,'Color','r','Linewidth',1.5);
plot(rn.*cos(thetas_actual64),Cp64L,'Color','b','Linewidth',1.5);
plot(rn.*cos(thetas_actual128),Cp128L,'Color','g','Linewidth',1.5);
plot(rn.*cos(thetas_analytical),CpAnalyticalL,'Color','k','Linewidth',1.5);
legend('Simulated, 32 points','Simulated, 64 points','Simulated, 128 points','Analytical Solution');
hold off

%% Observe stagnation points
% figure(4)
% hold on
% grid on
% axis equal
% title("Velocity Along Surface of Cylinder");
% xlabel("\theta (radians)");
% ylabel("Relative velocity, U/U_{\infty}");
% plot(thetas_actual128,U128N,'Color','g','Linewidth',1.5);
% plot(thetas_actual128,U128L,'Color','r','Linewidth',1.5);
% legend('No Lift', 'Lifting Condition');
% hold off

%% Thwaites' Condition to find separation points
% No lift case:
[sep128N,stag128N] = ThwaitesMethod(s128N,U128N,0);
N_A = sep128N(1); N_B = sep128N(2);
theta_N_A = N_A/rn; theta_N_B = N_B/rn;
x_NA = rn*cos(theta_N_A); x_NB = rn*cos(theta_N_B);
y_NA = rn*sin(theta_N_A); y_NB = rn*sin(theta_N_B);
[pos1N] = ArcLengthToCoord(bp128,s128N,N_A);
[pos2N] = ArcLengthToCoord(bp128,s128N,N_B);
x_NA = pos1N(1); y_NA = pos1N(2);
x_NB = pos2N(1); y_NB = pos2N(2);
x_stag_N = rn*cos(-stag128N./rn); y_stag_N = rn*sin(-stag128N./rn); 
% Lift case:
[sep128L,stag128L] = ThwaitesMethod(s128L,U128L,ALPHA);
L_A = sep128L(1); L_B = sep128L(2);
theta_L_A = L_A./rn; theta_L_B = L_B./rn;
x_LA = rn*cos(theta_L_A); x_LB = rn*cos(theta_L_B);
y_LA = rn*sin(theta_L_A); y_LB = rn*sin(theta_L_B);
[pos1L] = ArcLengthToCoord(bp128,s128L,L_A);
[pos2L] = ArcLengthToCoord(bp128,s128L,L_B);

% pos1L = [cosd(ALPHA), sind(ALPHA); -sind(ALPHA), cosd(ALPHA)]*pos1L';
% pos2L = [cosd(ALPHA), sind(ALPHA); -sind(ALPHA), cosd(ALPHA)]*pos2L';
stag1L = ArcLengthToCoord(bp128,s128L,stag128L(1));
stag2L = ArcLengthToCoord(bp128,s128L,stag128L(2));
% stag1L = [cosd(ALPHA), sind(ALPHA); -sind(ALPHA), cosd(ALPHA)]*stag1L';
% stag2L = [cosd(ALPHA), sind(ALPHA); -sind(ALPHA), cosd(ALPHA)]*stag2L';

x_LA = pos1L(1); y_LA = pos1L(2);
% x_LB = pos2L(1); y_LB = pos2L(2);
% x_stag_L = rn*cos((stag128L./rn)); y_stag_L = rn*sin((stag128L./rn));
% staga = [cosd(ALPHA), sind(ALPHA); -sind(ALPHA), cosd(ALPHA)]*[x_stag_L;y_stag_L];
x_stag_L = [stag1L(1),stag2L(1)]; y_stag_L = [stag1L(2),stag2L(2)];
% x_stag_L = staga(1,1); y_stag_L = staga(2,1);
figure(6)
hold on
    title("Visualization of Airfoil and Separation Points");
    plot(bp128(1,:), bp128(2,:),'Color','b');
    plot([x_NA,x_NB],[y_NA,y_NB],'O','Linewidth',4,'Color','r');
    plot([x_LA,x_LB],[y_LA,y_LB],'O','Linewidth',4,'Color','g');
    plot(x_stag_N,y_stag_N,'x','Linewidth',2,'Color','b');
    plot(x_stag_L,y_stag_L,'x','Linewidth',2,'Color','k');
    axis square;
    xlim([-1.5*rn 1.5*rn]);
    ylim([-1.5*rn 1.5*rn]);
    grid on;
    axis equal;
    legend("Approximate Airfoil Outline","Separation Points: No-Lift Case","Separation Points: Lifting Case","Stagnation Points: No Lift Case", "Stagnation Points: Lifting Case");
hold off

%% Separation Points for 32, 64, 128 n vortex panels
% No lift case:
[sep32N,stag32N] = ThwaitesMethod(s32N,U32N,0);
N_A = sep32N(1); N_B = sep32N(2);
theta_N_A = N_A/rn; theta_N_B = N_B/rn;
x_NA32 = rn*cos(theta_N_A); x_NB32 = rn*cos(theta_N_B);
y_NA32 = rn*sin(theta_N_A); y_NB32 = rn*sin(theta_N_B);
x_stag_N32 = rn*cos(-stag32N./rn); y_stag_N32 = rn*sin(-stag32N./rn); 
[sep64N,stag64N] = ThwaitesMethod(s64N,U64N,0);
N_A = sep64N(1); N_B = sep64N(2);
theta_N_A = N_A/rn; theta_N_B = N_B/rn;
x_NA64 = rn*cos(theta_N_A); x_NB64 = rn*cos(theta_N_B);
y_NA64 = rn*sin(theta_N_A); y_NB64 = rn*sin(theta_N_B);
x_stag_N64 = rn*cos(-stag64N./rn); y_stag_N64 = rn*sin(-stag64N./rn); 
[sep128N,stag128N] = ThwaitesMethod(s128N,U128N,0);
N_A = sep128N(1); N_B = sep128N(2);
theta_N_A = N_A/rn; theta_N_B = N_B/rn;
x_NA = rn*cos(theta_N_A); x_NB = rn*cos(theta_N_B);
y_NA = rn*sin(theta_N_A); y_NB = rn*sin(theta_N_B);
x_stag_N128 = rn*cos(-stag128N./rn); y_stag_N128 = rn*sin(-stag128N./rn); 

% Lift case:
[sep32L,stag32L] = ThwaitesMethod(s32L,U32L,ALPHA);
L_A = sep32L(1); L_B = sep32L(2);
theta_L_A = L_A./rn+ALPHA; theta_L_B = L_B./rn+ALPHA;
x_LA32 = rn*cos(theta_L_A); x_LB32 = rn*cos(theta_L_B);
y_LA32 = rn*sin(theta_L_A); y_LB32 = rn*sin(theta_L_B);
x_stag_L32 = rn*cos((-stag32L./rn)-ALPHA); y_stag_L32 = rn*sin((-stag32L./rn)-ALPHA);
[sep64L,stag64L] = ThwaitesMethod(s64L,U64L,ALPHA);
L_A = sep64L(1); L_B = sep64L(2);
theta_L_A = L_A./rn+ALPHA; theta_L_B = L_B./rn+ALPHA;
x_LA64 = rn*cos(theta_L_A); x_LB64 = rn*cos(theta_L_B);
y_LA64 = rn*sin(theta_L_A); y_LB64 = rn*sin(theta_L_B);
x_stag_L64 = rn*cos((-stag64L./rn)-ALPHA); y_stag_L64 = rn*sin((-stag64L./rn)-ALPHA); 
[sep128L,stag128L] = ThwaitesMethod(s128L,U128L,ALPHA);
L_A = sep128L(1); L_B = sep128L(2);
theta_L_A = L_A./rn+ALPHA; theta_L_B = L_B./rn+ALPHA;
x_LA = rn*cos(theta_L_A); x_LB = rn*cos(theta_L_B);
y_LA = rn*sin(theta_L_A); y_LB = rn*sin(theta_L_B);
x_stag_L128 = rn*cos((-stag128L./rn)-ALPHA); y_stag_L128 = rn*sin((-stag128L./rn)-ALPHA);

% Plot!!
figure(8)
hold on
    title("Visualization of Airfoil and Separation Points: No Lift Case");
    %plot(bp32(1,:), bp32(2,:),'Color','r');
    %plot(bp64(1,:), bp64(2,:),'Color','g');
    plot(bp128(1,:), bp128(2,:),'Color','b');
    plot([x_NA32,x_NB32],[y_NA32,y_NB32],'O','Linewidth',4,'Color','r');
    plot([x_NA64,x_NB64],[y_NA64,y_NB64],'O','Linewidth',4,'Color','g');
    plot([x_NA,x_NB],[y_NA,y_NB],'O','Linewidth',4,'Color','b');
    plot(x_stag_N32,y_stag_N32,'x','Linewidth',2,'Color','b');
    plot(x_stag_N64,y_stag_N64,'x','Linewidth',2,'Color','r');
    plot(x_stag_N128,y_stag_N128,'x','Linewidth',2,'Color','g');
    axis square;
    xlim([-1.5*rn 1.5*rn]);
    ylim([-1.5*rn 1.5*rn]);
    grid on;
    axis equal;
    legend("Approximate Airfoil Outline","Separation Points: n=32","Separation Points: n=64","Separation Points: n=128","Stagnation Points: n=32", "Stagnation Points: n=64","Stagnation Points: n=128");
hold off

figure(9)
hold on
    title("Visualization of Airfoil and Separation Points: Lifting Case");
    %plot(bp32(1,:), bp32(2,:),'Color','r');
    %plot(bp64(1,:), bp64(2,:),'Color','g');
    plot(bp128(1,:), bp128(2,:),'Color','b');
    plot([x_LA32,x_LB32],[y_LA32,y_LB32],'O','Linewidth',4,'Color','r');
    plot([x_LA64,x_LB64],[y_LA64,y_LB64],'O','Linewidth',4,'Color','g');
    plot([x_LA,x_LB],[y_LA,y_LB],'O','Linewidth',4,'Color','b');
    plot(x_stag_L32,y_stag_L32,'x','Linewidth',2,'Color','b');
    plot(x_stag_L64,y_stag_L64,'x','Linewidth',2,'Color','r');
    plot(x_stag_L,y_stag_L,'x','Linewidth',2,'Color','g');
    axis square;
    xlim([-1.5*rn 1.5*rn]);
    ylim([-1.5*rn 1.5*rn]);
    grid on;
    axis equal;
    legend("Approximate Airfoil Outline","Separation Points: n=32","Separation Points: n=64","Separation Points: n=128","Stagnation Points: n=32", "Stagnation Points: n=64","Stagnation Points: n=128");
hold off
