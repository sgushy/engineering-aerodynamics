%% Project 3 - Vortex Panel Method Applied To Airfoils
clc,clear,close all

lw = 2; % Default line width
fs = 14; % Default font size

%% Import and Plot Airfoils - NACA0012
NACA0012 = readtable("Project3-NACA0012-Cos.csv"); % Import NACA0012 profile
NACA0012 = [flip(table2array(NACA0012(:,4)))'; flip(table2array(NACA0012(:,5)))'; flip(table2array(NACA0012(:,7)))'; flip(table2array(NACA0012(:,8)))'];

NACA0012_XFOIL = [-1.3806,-1.3868,-1.3879,-1.3854,-1.3802,-1.3739,-1.3669,-1.359,-1.3502,-1.3399,-1.3281,-1.3149,-1.3132,-1.3004,-1.2834,-1.2649,-1.2455,-1.225,-1.2032,-1.1872,-1.1666,-1.1449,-1.1228,-1.1,-1.0807,-1.0591,-1.0368,-1.0143,-0.9948,-0.9735,-0.9517,-0.9313,-0.9104,-0.8888,-0.8687,-0.8475,-0.8268,-0.7975,-0.7634,-0.7289,-0.6939,-0.6601,-0.6268,-0.5571,-0.5213,-0.4903,-0.4588,-0.4276,-0.4004,-0.373,-0.3462,-0.3201,-0.2938,-0.2675,-0.241,-0.2144,-0.1878,-0.1611,-0.1343,-0.1075,-0.0806,-0.0538,-0.0268,0,0.0269,0.0538,0.0806,0.1075,0.1344,0.1611,0.1878,0.2144,0.241,0.2675,0.2938,0.3201,0.3462,0.373,0.4004,0.4276,0.4588,0.4903,0.5213,0.5572,0.6268,0.6601,0.694,0.729,0.7635,0.7976,0.8267,0.8474,0.8686,0.8887,0.9103,0.9312,0.9516,0.9734,0.9948,1.0143,1.0368,1.0591,1.0808,1.1001,1.1229,1.145,1.1668,1.1874,1.2033,1.2251,1.2457,1.2651,1.2837,1.3008,1.3137,1.3157,1.329,1.3406,1.3509,1.36,1.3679,1.375,1.3814,1.3864,1.3892,1.3881,1.3818];

hold on
figure('position', [300, 300, 600, 200])
hold on
axis equal
grid on
title("Airfoil Profile - NACA0012",'Fontsize',fs);
xlabel("x/c");
ylabel("y/c");
plot(NACA0012(1,:),NACA0012(2,:),'Linewidth',lw); % plot airfoil surface
plot(NACA0012(3,:),NACA0012(4,:),'Linewidth',lw/2); % plot camber line
plot([0 1],[0 0],'Linewidth',lw/2); % plot chord line

legend("Airfoil Surface","Camber Line","Chord Line",'Fontsize',fs);
hold off
%% Import and Plot Airfoils - NACA4412
NACA4412 = readtable("Project3-NACA4412.csv");
NACA4412 = [flip(table2array(NACA4412(:,4)))'; flip(table2array(NACA4412(:,5)))'; flip(table2array(NACA4412(:,7)))'; flip(table2array(NACA4412(:,8)))'];

NACA4412_XFOIL = [-0.8374,-0.9127,-1.0965,-1.1161,-1.121,-1.1215,-1.1181,-1.099,-1.0711,-1.0462,-1.0163,-0.9847,-0.9549,-0.926,-0.8954,-0.8682,-0.8365,-0.8038,-0.7707,-0.7369,-0.707,-0.6803,-0.6491,-0.6172,-0.585,-0.5547,-0.5287,-0.5023,-0.4769,-0.4513,-0.4243,-0.3979,-0.3715,-0.3442,-0.3183,-0.2921,-0.2649,-0.2377,-0.1825,-0.1549,-0.1275,-0.0718,-0.0441,-0.0162,0.0117,0.0394,0.0674,0.0954,0.1232,0.1512,0.1791,0.2069,0.2346,0.2625,0.2903,0.318,0.3456,0.3734,0.4012,0.4288,0.4562,0.4833,0.5102,0.5366,0.5622,0.5842,0.6163,0.6525,0.6788,0.7055,0.7325,0.7592,0.7865,0.8405,0.8672,0.8941,0.921,0.9473,0.9734,0.9993,1.0254,1.0518,1.0777,1.1031,1.128,1.1523,1.1761,1.1988,1.2208,1.2417,1.2614,1.2793,1.2973,1.3164,1.3346,1.3514,1.3676,1.3835,1.4004,1.4171,1.4317,1.4484,1.4653,1.4805,1.4938,1.5061,1.5221,1.5369,1.55,1.5608,1.5688,1.5831,1.5959,1.6066,1.6141,1.6213,1.6325,1.6414,1.6474,1.6508,1.6585,1.6638,1.6661,1.6666];

hold on
figure('position', [300, 300, 600, 200])
hold on
axis equal
grid on
title("Airfoil Profile - NACA4412",'Fontsize',fs);
xlabel("x/c");
ylabel("y/c");
plot(NACA4412(1,:),NACA4412(2,:),'Linewidth',lw); % plot airfoil surface
plot(NACA4412(3,:),NACA4412(4,:),'Linewidth',lw/2); % plot camber line
plot([0 1],[0 0],'Linewidth',lw/2); % plot chord line


legend("Airfoil Surface","Camber Line","Chord Line",'Fontsize',fs);
hold off
%% NACA 0012 Airfoil - Calculate+Plot Pressure Distribution for AoA = -16,-8,0,8,16 degrees
AoA=[-16,-8,0,8,16];
figure
hold on
grid on
title("Distribution of Pressure Along Chord of NACA0012 Airfoil");
xlabel("x/c");
ylabel("\Delta C_p (Top Surface - Bottom Surface)");
for iib=1:1:length(AoA)
    AoAA = AoA(iib);
    [Cp, U,s] = VortexPanel([(NACA0012(1,:));(NACA0012(2,:))],AoAA);
    TBCPDiff = flip(Cp(length(Cp)/2:length(Cp)-1))-(Cp(1:length(Cp)/2));
[C_L,C_D,pressure_dist,controlPts,AirfoilRotated] = AirfoilCalc([NACA0012(1,:);NACA0012(2,:)],AoAA,Cp);
plot(controlPts(1,1:length(controlPts)/2),TBCPDiff,'-',"Linewidth",lw/2);
end
legend("-16^\circ Angle of Attack","-8^\circ Angle of Attack","0^\circ Angle of Attack","8^\circ Angle of Attack","16^\circ Angle of Attack");
hold off
%% NACA 4412 Airfoil - Calculate+Plot Pressure Distribution for AoA = -16,-8,0,8,16 degrees
AoA=[-16,-8,0,8,16];
figure
hold on
grid on
title("Distribution of Pressure Along Chord of NACA4412 Airfoil");
xlabel("x/c");
ylabel("\Delta C_p (Top Surface - Bottom Surface)");
for iib=1:1:length(AoA)
    AoAA = AoA(iib);
    [Cp, U,s] = VortexPanel([(NACA4412(1,:));(NACA4412(2,:))],AoAA);
     TBCPDiff = flip(Cp(length(Cp)/2:length(Cp)-1))-(Cp(1:length(Cp)/2));
[C_L,C_D,pressure_dist,controlPts,AirfoilRotated] = AirfoilCalc([NACA4412(1,:);NACA4412(2,:)],AoAA,Cp);
plot(controlPts(1,1:length(controlPts)/2),TBCPDiff,'-',"Linewidth",lw/2);
end
legend("-16^\circ Angle of Attack","-8^\circ Angle of Attack","0^\circ Angle of Attack","8^\circ Angle of Attack","16^\circ Angle of Attack");
hold off

%% NACA 0012 Airfoil - Calculate+Plot Lift Coefficient for AoA from -16 to 16 degrees
iii = 1;
AoAA = -16:0.25:16;
for AoA=AoAA
   [Cp, U,s] = VortexPanel([(NACA0012(1,:));(NACA0012(2,:))],AoA);
    [C_L,C_D,pressure_dist,controlPts,AirfoilRotated] = AirfoilCalc([NACA0012(1,:);NACA0012(2,:)],AoA,Cp);
    CP0012(iii,:) = Cp; U0012(iii,:) = U; s0012(iii,:)=s;
    CL0012(iii,:)=C_L; CD0012(iii,:)= C_D;
    AF0012(iii,:,:) = AirfoilRotated;
    iii = iii+1;
end
figure
hold on
grid on
title("NACA0012 Lift Coefficient at Varying Angles of Attack");
xlabel("Angle of Attack \alpha (degrees)");
ylabel("Coefficient of Lift C_L");
plot(AoAA,CL0012,"Linewidth",lw);
plot(AoAA,AoAA.*2.*pi.*pi./180,"Linewidth",lw);
plot(AoAA(2:end-1),NACA0012_XFOIL,"Linewidth",lw);
legend("Numerically Calculated Values (Re \approx 1,400,000)","Analytical Values (Thin Airfoil Approximation)","XFOIL Prediction (Re = 1,000,000)");
hold off


%% NACA 4412 Airfoil - Calculate+Plot Lift Coefficient for AoA from -16 to 16 degrees
iii = 1;
AoAA = -16:0.25:16;

for AoA=AoAA
   [Cp, U,s] = VortexPanel([(NACA4412(1,:));(NACA4412(2,:))],AoA);
    [C_L,C_D,pressure_dist,controlPts,AirfoilRotated] = AirfoilCalc([NACA4412(1,:);NACA4412(2,:)],AoA,Cp);
    CP4412(iii,:) = Cp; U4412(iii,:) = U; s4412(iii,:)=s;
    CL4412(iii,:) = C_L; CD4412(iii,:)= C_D;
    AF4412(iii,:,:) = AirfoilRotated;
    iii = iii+1;
end
A_0 = AoAA*pi/180;
A_1 = 0.0726*2;
analyticalC_l = 2.*pi.*(A_0+A_1*0.5);

figure
hold on
grid on
title("NACA4412 Lift Coefficient at Varying Angles of Attack");
xlabel("Angle of Attack \alpha (degrees)");
ylabel("Coefficient of Lift C_L");
plot(AoAA,CL4412,"Linewidth",lw);
plot(AoAA,analyticalC_l,"Linewidth",lw);
plot(AoAA(3:end-3),NACA4412_XFOIL,"Linewidth",lw);
legend("Numerically Calculated Values (Re \approx 1,400,000)","Analytical Values (Thin Airfoil Approximation)","XFOIL Prediction (Re = 1,000,000)");

hold off

%% NACA 0012 and 4412 - Lift to Drag Ratios (Aerodynamic Efficiency)

figure
hold on
grid on
title("NACA0012 Lift-to-Drag Ratio at Varying Angles of Attack");
xlabel("Angle of Attack \alpha (degrees)");
ylabel("Lift-to-Drag Ratio C_L/C_D");
plot(AoAA,CD0012,"Linewidth",lw);
a_eff_NACA0012 = [-36.33157895,-40.5497076,-44.45547726,-48.02079723,-51.30855019,-54.56314535,-57.84595853,-61.13360324,-64.32586946,-67.29784028,-70.04746835,-72.40638767,-78.63473054,-82.51269036,-85.33244681,-87.96244784,-90.51598837,-92.7327782,-94.44270016,-101.0382979,-104.3470483,-107.1000935,-109.7556207,-112.0162933,-118.497807,-122.016129,-124.4657863,-126.6292135,-133.1726908,-136.7275281,-139.5454545,-145.0623053,-148.7581699,-151.4139693,-157.3731884,-160.8159393,-165.36,-167.8947368,-171.1659193,-173.9618138,-175.6708861,-177.9245283,-180.1149425,-183.2565789,-183.556338,-184.3233083,-185,-184.3103448,-184.516129,-182.8431373,-181.2565445,-177.8333333,-172.8235294,-167.1875,-159.602649,-148.8888889,-137.080292,-122.9770992,-106.5873016,-88.1147541,-68.30508475,-46.37931034,-23.30434783,0,23.39130435,46.37931034,68.30508475,88.1147541,106.6666667,122.9770992,137.080292,148.8888889,159.602649,167.1875,172.8235294,177.8333333,181.2565445,182.8431373,183.6697248,184.3103448,185,185.0188679,183.556338,183.2894737,180.1149425,177.9245283,175.6962025,173.9856802,171.1883408,167.9157895,165.6713427,160.7969639,157.3550725,151.3969336,148.7418301,145.046729,139.5307918,136.7134831,133.1726908,126.6292135,124.6153846,122.016129,118.5087719,112.0264766,109.7653959,107.1094481,104.3649374,101.0553191,94.45054945,92.74034822,90.53052326,87.97635605,85.35239362,82.53807107,78.66467066,72.49035813,70.13192612,67.33299849,64.35921868,61.20612061,57.9373147,54.65023847,51.41049498,48.05545927,44.51137456,40.6114687,36.36315789];
plot(AoAA(2:end-1),a_eff_NACA0012,"Linewidth",lw);
legend("Numerical Values (Re = 1,400,000)","XFOIL (Re = 1,000,000)");
hold off

figure
hold on
grid on
title("NACA4412 Lift-to-Drag Ratio at Varying Angles of Attack");
xlabel("Angle of Attack \alpha (degrees)");
ylabel("Lift-to-Drag Ratio C_L/C_D");
plot(AoAA,CD4412,"Linewidth",lw);
a_eff_NACA4412 = [-10.28620563,-13.84767107,-36.28391794,-39.81805209,-42.28592984,-44.45105034,-46.45201496,-48.1595092,-49.47344111,-52.70528967,-53.34908136,-53.22702703,-53.34636872,-53.71229698,-53.7454982,-56.93114754,-56.8660775,-56.44662921,-56.05090909,-55.48945783,-54.51040864,-58.5960379,-58.53020739,-57.95305164,-57.2407045,-56.54434251,-56.00635593,-58.74853801,-60.29077118,-60.01329787,-59.50911641,-58.68731563,-57.6863354,-56.51888342,-57.24820144,-57.84158416,-56.24203822,-53.90022676,-46.9151671,-43.02777778,-39.23076923,-25.37102473,-17.02702703,-6.666666667,5.131578947,18.49765258,33.53233831,49.94764398,68.44444444,88.42105263,109.8773006,132.6282051,156.4,181.0344828,204.4366197,225.5319149,248.6330935,270.5797101,292.8467153,310.7246377,328.2014388,342.7659574,349.4520548,350.7189542,351.375,343.6470588,348.1920904,360.4972376,364.9462366,367.4479167,368.0904523,368.5436893,369.2488263,363.8528139,361.3333333,357.64,354.2307692,348.2720588,342.7464789,336.4646465,329.7106109,322.6380368,315.1169591,307.270195,297.6253298,287.3566085,276.0798122,263.4725275,250.1639344,236.0646388,221.6871705,206.0064412,193.0505952,183.0876217,173.550065,164.2041312,156.2971429,149.4060475,143.4836066,137.8501946,131.228231,126.277245,121.8038238,116.8508287,111.2285927,105.3216783,101.812709,97.89171975,93.59903382,88.78270762,83.09322034,80.15696203,76.91084337,73.29379562,69.03763901,65.00801925,62.30916031,59.25631769,55.90091619,52.30671736,49.77490996,47.09312199,44.17020148,41.28313104];
plot(AoAA(3:end-3),a_eff_NACA4412,"Linewidth",lw)
legend("Numerical Values (Re = 1,400,000)","XFOIL (Re = 1,000,000)");
hold off

figure
hold on
grid on
title("Comparison of Lift-to-Drag Ratio at Varying Angles of Attack");
xlabel("Angle of Attack \alpha (degrees)");
ylabel("Lift-to-Drag Ratio C_L/C_D");
plot(AoAA,CD0012,"Linewidth",lw);
plot(AoAA,CD4412,"Linewidth",lw);
legend("NACA 0012","NACA 4412");
hold off

figure
hold on
grid on
title("Comparison of Lift-to-Drag Ratio at Varying Lift Coefficients");
xlabel("Coefficient of Lift C_L");
ylabel("Lift-to-Drag Ratio C_L/C_D");
plot(CL0012,CD0012,"Linewidth",lw);
plot(CL0012,CD4412,"Linewidth",lw);
legend("NACA 0012","NACA 4412");
hold off
%% Separation Points - NACA0012 and NACA 4412
iii = 1;
AoAA = -16:0.25:16;

for AoA=AoAA
%[sep0012(iii,:),stag0012(iii,:)] = ThwaitesMethod(s0012(iii,:),U0012(iii,:),0);
 [sep0012(iii,:),stag0012(iii,:)] = ThwaitesMethod2(NACA0012(1,:),NACA0012(2,:),U0012(iii,:),AoA);
% stagnation0012(iii,1,:) = ArcLengthToCoord(NACA0012(1:2,:),s0012(iii,:),stag0012(iii,1)); % Lower Stag pt (x,y)
% stagnation0012(iii,2,:) = ArcLengthToCoord(NACA0012(1:2,:),s0012(iii,:),stag0012(iii,2)); % Upper Stag pt (x,y)
%sep0012(iii,1) = StratfordMethod(NACA0012(1,:),NACA0012(2,:),U0012(iii,:));
separation0012(iii,1,:) = ArcLengthToCoord(NACA0012(1:2,:),s0012(iii,:),sep0012(iii,1)); %(x,y)
% separation0012(iii,2,:) = ArcLengthToCoord(NACA0012(1:2,:),s0012(iii,:),sep0012(iii,2)); %(x,y)
iii = iii+1;
end
% figure
% hold on
% grid on
% axis equal
% for iii = 1:1:length(AoAA)
%     
%    plot(NACA0012(1,:),NACA0012(2,:),'Linewidth',lw); % plot airfoil surface
%    plot(separation0012(iii,1,1),(separation0012(iii,1,2)),'-o','Color','r');
% %    plot(separation0012(iii,2,1),(separation0012(iii,2,2)),'-o','Color','b');
% %    plot(stagnation0012(iii,1,1),(stagnation0012(iii,1,2)),'-x','Color','r');
% %    plot(stagnation0012(iii,2,1),(stagnation0012(iii,2,2)),'-x','Color','b');
% end
% hold off
% figure
% hold on
% grid on
% for iii = 1:1:length(AoAA)
%    plot(AoAA(iii),(separation0012(iii,1,1)),'o','Color','r');
% %    plot(AoAA(iii),(separation0012(iii,2,1)),'o','Color','b');
% %    plot(AoAA(iii),(stagnation0012(iii,1,1)),'x','Color','r');
% %    plot(AoAA(iii),(stagnation0012(iii,2,1)),'x','Color','b');
% end
% hold off

iii = 1;
AoAA = -16:0.25:16;

for AoA=AoAA
% [sep4412(iii,:),stag4412(iii,:)] = ThwaitesMethod(s4412(iii,:),U4412(iii,:),AoA);
[sep4412(iii,:),stag4412(iii,:)] = ThwaitesMethod2(NACA4412(1,:),NACA4412(2,:),U4412(iii,:),AoA);

% stagnation4412(iii,1,:) = ArcLengthToCoord(NACA4412(1:2,:),s4412(iii,:),stag4412(iii,1)); % Lower Stag pt (x,y)
% stagnation4412(iii,2,:) = ArcLengthToCoord(NACA4412(1:2,:),s4412(iii,:),stag4412(iii,2)); % Upper Stag pt (x,y)
% sep4412(iii,1) = StratfordMethod(NACA4412(1,:),NACA4412(2,:),U4412(iii,:));
separation4412(iii,1,:) = ArcLengthToCoord(NACA4412(1:2,:),s4412(iii,:),sep4412(iii,1)); %(x,y)
% separation4412(iii,2,:) = ArcLengthToCoord(NACA4412(1:2,:),s4412(iii,:),sep4412(iii,2)); %(x,y)
iii = iii+1;
end

% figure
% hold on
% grid on
% axis equal
% for iii = 1:1:length(AoAA)
%     
%    plot(NACA4412(1,:),NACA4412(2,:),'Linewidth',lw); % plot airfoil surface
% %    plot(separation4412(iii,1,1),(separation4412(iii,1,2)),'-o','Color','r');
% %    plot(separation4412(iii,2,1),(separation4412(iii,2,2)),'-o','Color','b');
% %    plot(stagnation4412(iii,1,1),(stagnation4412(iii,1,2)),'-x','Color','r');
% %    plot(stagnation4412(iii,2,1),(stagnation4412(iii,2,2)),'-x','Color','b');
% end
% hold off

NACA0012_xtr = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.9992,0.9975,0.9959,0.9944,0.9924,0.9897,0.9853,0.9836,0.9789,0.9738,0.9687,0.9599,0.9511,0.9409,0.9284,0.9152,0.9007,0.8848,0.8675,0.8486,0.8283,0.8072,0.7848,0.761,0.7373,0.7123,0.6872,0.6611,0.6353,0.6088,0.5826,0.556,0.5281,0.5018,0.4743,0.4468,0.4196,0.3917,0.3637,0.3366,0.309,0.2803,0.2536,0.2255,0.1986,0.1728,0.1488,0.109,0.0939,0.0816,0.0709,0.0624,0.055,0.0505,0.0464,0.0435,0.0401,0.0382,0.0359,0.0337,0.0322,0.0306,0.0288,0.0278,0.0266,0.0255,0.0242,0.0236,0.0228,0.022,0.0213,0.0203,0.0199,0.0194,0.0188,0.0183,0.0179,0.0174,0.0169,0.0167,0.0164,0.0162,0.0159,0.0156,0.0153,0.0151,0.0148,0.0146,0.0144,0.0142];
NACA4412_xtr = [1,1,1,1,1,1,1,0.9992,0.9979,0.9963,0.9951,0.9943,0.993,0.9911,0.9894,0.9877,0.9866,0.9857,0.9849,0.9843,0.9819,0.9793,0.9775,0.9759,0.9742,0.9718,0.9665,0.9622,0.9574,0.9519,0.9474,0.9422,0.9363,0.9313,0.9249,0.9186,0.9125,0.9053,0.891,0.8835,0.8751,0.8578,0.8488,0.8388,0.8288,0.8184,0.8073,0.7964,0.7851,0.7733,0.7616,0.7497,0.7378,0.7254,0.7132,0.7012,0.6886,0.6754,0.6626,0.6497,0.6365,0.6232,0.6101,0.5975,0.5856,0.574,0.5622,0.5505,0.5398,0.5294,0.5204,0.5112,0.5029,0.4847,0.4746,0.4646,0.454,0.4426,0.4273,0.411,0.3979,0.3861,0.3731,0.3575,0.3398,0.3207,0.2993,0.2737,0.2461,0.2173,0.1865,0.1526,0.1252,0.1065,0.0893,0.0729,0.0622,0.0563,0.0521,0.0491,0.0459,0.0442,0.0427,0.0411,0.0392,0.0376,0.0368,0.0356,0.0343,0.033,0.0316,0.0308,0.0298,0.0286,0.0273,0.0262,0.0252,0.0241,0.0229,0.0218,0.0209,0.0198,0.0187,0.0179,0.0171];

figure
hold on
grid on
axis([0,16,0,1]);
title("NACA 0012 Upper Surface Boundary Layer Separation for \alpha from 0-16^\circ");
xlabel("Angle of Attack \alpha (degrees)");
ylabel("Predicted Upper Separation Point x/c")
plot(AoAA(floor(length(AoAA)/2):3:end),separation0012(floor(length(AoAA)/2)-28:3:end-28,1,1),'-','Linewidth',lw);
% plot(AoAA(floor(length(AoAA)/2):3:end),separation4412(floor(length(AoAA)/2)-35:3:end-35,1,1),'-','Linewidth',lw);
plot(AoAA(floor(length(AoAA)/2):(end-1)),NACA0012_xtr(floor(length(AoAA)/2)-1:end),'-','Linewidth',lw);
% plot(AoAA(floor(length(AoAA)/2):(end-2)),NACA4412_xtr(floor(length(AoAA)/2)-2:end),'-','Linewidth',lw);
yline(0.2);
legend("Thwaites' Method - NACA 0012 Separation Point (Re \approx 1,400,000)","XFOIL - NACA 0012 Separation Point (Re = 1,000,000)","Stall Criterion")
hold off

figure
hold on
grid on
axis([0,16,0,1]);
title("NACA 4412 Upper Surface Boundary Layer Separation for \alpha from 0-16^\circ");
xlabel("Angle of Attack \alpha (degrees)");
ylabel("Predicted Upper Separation Point x/c")
% plot(AoAA(floor(length(AoAA)/2):3:end),separation0012(floor(length(AoAA)/2)-28:3:end-28,1,1),'-','Linewidth',lw);
plot(AoAA(floor(length(AoAA)/2):3:end),separation4412(floor(length(AoAA)/2)-40:3:end-40,1,1),'-','Linewidth',lw);
% plot(AoAA(floor(length(AoAA)/2):(end-1)),NACA0012_xtr(floor(length(AoAA)/2)-1:end),'-','Linewidth',lw);
plot(AoAA(floor(length(AoAA)/2):(end-2)),NACA4412_xtr(floor(length(AoAA)/2)-2:end),'-','Linewidth',lw);
yline(0.2);
legend("Thwaites' Method - NACA 4412 Separation Point (Re \approx 1,400,000)","XFOIL - NACA 4412 Separation Point (Re = 1,000,000)","Stall Criterion")
hold off
%% Separation Points (Expected)
NACA0012_xtr = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.9992,0.9975,0.9959,0.9944,0.9924,0.9897,0.9853,0.9836,0.9789,0.9738,0.9687,0.9599,0.9511,0.9409,0.9284,0.9152,0.9007,0.8848,0.8675,0.8486,0.8283,0.8072,0.7848,0.761,0.7373,0.7123,0.6872,0.6611,0.6353,0.6088,0.5826,0.556,0.5281,0.5018,0.4743,0.4468,0.4196,0.3917,0.3637,0.3366,0.309,0.2803,0.2536,0.2255,0.1986,0.1728,0.1488,0.109,0.0939,0.0816,0.0709,0.0624,0.055,0.0505,0.0464,0.0435,0.0401,0.0382,0.0359,0.0337,0.0322,0.0306,0.0288,0.0278,0.0266,0.0255,0.0242,0.0236,0.0228,0.022,0.0213,0.0203,0.0199,0.0194,0.0188,0.0183,0.0179,0.0174,0.0169,0.0167,0.0164,0.0162,0.0159,0.0156,0.0153,0.0151,0.0148,0.0146,0.0144,0.0142];
NACA4412_xtr = [1,1,1,1,1,1,1,0.9992,0.9979,0.9963,0.9951,0.9943,0.993,0.9911,0.9894,0.9877,0.9866,0.9857,0.9849,0.9843,0.9819,0.9793,0.9775,0.9759,0.9742,0.9718,0.9665,0.9622,0.9574,0.9519,0.9474,0.9422,0.9363,0.9313,0.9249,0.9186,0.9125,0.9053,0.891,0.8835,0.8751,0.8578,0.8488,0.8388,0.8288,0.8184,0.8073,0.7964,0.7851,0.7733,0.7616,0.7497,0.7378,0.7254,0.7132,0.7012,0.6886,0.6754,0.6626,0.6497,0.6365,0.6232,0.6101,0.5975,0.5856,0.574,0.5622,0.5505,0.5398,0.5294,0.5204,0.5112,0.5029,0.4847,0.4746,0.4646,0.454,0.4426,0.4273,0.411,0.3979,0.3861,0.3731,0.3575,0.3398,0.3207,0.2993,0.2737,0.2461,0.2173,0.1865,0.1526,0.1252,0.1065,0.0893,0.0729,0.0622,0.0563,0.0521,0.0491,0.0459,0.0442,0.0427,0.0411,0.0392,0.0376,0.0368,0.0356,0.0343,0.033,0.0316,0.0308,0.0298,0.0286,0.0273,0.0262,0.0252,0.0241,0.0229,0.0218,0.0209,0.0198,0.0187,0.0179,0.0171];
figure
hold on
plot(AoAA(2:(end-1)),NACA0012_xtr);
plot(AoAA(3:(end-2)),NACA4412_xtr);
yline(0.2)
hold off