function [sep_upper] = StratfordMethod(xb,yb,velfield)
%% Find control points (xc,yc) from boundary points (xb,yb)
xc = (xb(2:end)+xb(1:end-1))./2;
yc = (yb(2:end)+yb(1:end-1))./2;

%% Determine length of each panel
S_b = sqrt((xb(2:end)-xb(1:end-1)).^2+(yb(2:end)-yb(1:end-1)).^2);
% x = cumsum(sqrt(gradient(xc).^2+gradient(xb).^2)); 
x = S_b/2 + cumsum(S_b)-S_b(1);
x(1) = 0;
%%
[~,index_fastest] = max(velfield);
xm = S_b(index_fastest);
Cp_ = 1-velfield.^2;
dCp_dx = gradient(Cp_)/gradient(x);
xm_ = cumtrapz(x,velfield.^5);
x_ = x-(xm-xm_);

K = (x_.^2).*Cp_.*(dCp_dx.^2);
Kxbar = 0.0104;

%% Determine front stagnation point... (back is always at first index)
if velfield(1) < 0
    ind_stag = find(velfield>0,1);
    ind_stag_1 = ind_stag-1;
    dUdx = gradient(velfield)./gradient(x);
    slope = dUdx(ind_stag_1);
    gradient_x_1_intend = 0 - velfield(ind_stag_1);
    stag1 = gradient_x_1_intend./slope+x(ind_stag_1);
else
    ind_stag = find(velfield<0,1);
    ind_stag_1 = ind_stag-1;
    dUdx = gradient(velfield)./gradient(x);
    slope = dUdx(ind_stag_1);
    gradient_x_1_intend = velfield(ind_stag_1);
    stag1 = gradient_x_1_intend./slope+x(ind_stag_1);
end
%% Determine Separation Points

% For upper half of cylinder
upx = (x(ind_stag_1:end));

upK = (K(ind_stag_1:end));%0.45./(u_6(ind_stag_1:end)).*(dUedx(ind_stag_1:end)).*i_u5(ind_stag_1:end);%(K(ind_stag_1:end));

% Solve for separation point at top half
if upK(1) < Kxbar
    [ind_sep_up] = find(upK>Kxbar,1);
    ind_sep_up_1 = ind_sep_up-1;
    dUdx = gradient(upK)./gradient(upx);
    slope = dUdx(ind_sep_up_1);
    gradient_x_1_intend = Kxbar - upK(ind_sep_up_1);
    sep_upper = gradient_x_1_intend./slope+upx(ind_sep_up_1);
else
    [ind_sep_up] = find(upK<Kxbar,1);
    ind_sep_up_1 = ind_sep_up-1;
    dUdx = gradient(upK)./gradient(upx);
    slope = dUdx(ind_sep_up_1);
    gradient_x_1_intend = Kxbar - upK(ind_sep_up_1);
    sep_upper = gradient_x_1_intend./slope+upx(ind_sep_up_1);
end

% For lower half of cylinder
lowK = (K(1:ind_stag_1-1));%0.45./(u_6(1:ind_stag_1-1)).*(dUedx(1:ind_stag_1-1)).*i_u5(1:ind_stag_1-1);
lowx = (x(1:ind_stag_1-1));

% Solve for separation point at bottom half
if lowK(1) < Kxbar
    ind_sep_low = find(lowK>Kxbar,1);
    ind_sep_low_1 = ind_sep_low-1;
    dUdx = gradient(lowK)./gradient(lowx);
    slope = dUdx(ind_sep_low_1);
    gradient_x_1_intend = Kxbar - lowK(ind_sep_low_1);
    lowsep = gradient_x_1_intend./slope+lowx(ind_sep_low_1);
else
    ind_sep_low = find(lowK<Kxbar,1);
    ind_sep_low_1 = ind_sep_low-1;
    dUdx = gradient(lowK)./gradient(lowx);
    slope = dUdx(ind_sep_low_1);
    gradient_x_1_intend = Kxbar - lowK(ind_sep_low_1);
    lowsep = gradient_x_1_intend./slope+lowx(ind_sep_low_1);
end

if(length(sep_upper)==0)
   sep_upper = 0; 
end

% %% 
% K = (x_.^2).*Cp_.*(dCp_dx.^2);
% Kxbar = 0.0104;
% ind_cc = find(K>Kxbar);
% ind_c = ind_cc(1);
% ind_b = ind_c-1;
% dKdx = gradient(K)./gradient(x);
% slope = dKdx(ind_b);
% gradient_x_1_intend = Kxbar - K(ind_b);
% sep_upper = gradient_x_1_intend./slope+x(ind_b);


%% Plot K, xbar
% fig = figure(2);
% hold on
% title('K vs x, Criterion Threshold, and Crossing Point','Interpreter','latex','Fontsize',16);
% plot(x,K,'-');
% yline(0.0104);
% %plot(sep_upper,0.0104,'x','Linewidth',8,'Color','g');
% %plot(xbar2,-3,'x','Linewidth',8,'Color','b');
% grid on
% %axis([0,8,-5,5])
% xlabel('X','Fontsize',16);
% legend('K','Criterion Threshold','Crossing Points','Interpreter','latex','Fontsize',16);
% hold off