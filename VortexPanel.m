%% Function for calculating pressure dist around an airfoil 
% with boundary pts in bp and Kutta condition angle defined by ALPHA
function [Cp,U,plength,gammas] = VortexPanel(bp,ALPHA_deg) 
xb = bp(1,:); yb = bp(2,:); % Extract coordinats of boundary points
n = length(xb)-1; % Number of vortex panels, based on the size of the boundary point list
%x = zeros(1,n); y = zeros(1,n); s = zeros(1,n); theta = zeros(1,n); % Preallocate vectors
ALPHA = ALPHA_deg*pi/180; % Degrees to Radians
for ii = 1:1:n
   x(ii) = 0.5*(xb(ii)+xb(ii+1)); % The center point x of the vortex panel i
   y(ii) = 0.5*(yb(ii)+yb(ii+1)); % The center point y of the vortex panel i
   s(ii) = sqrt((xb(ii)-xb(ii+1))^2+(yb(ii)-yb(ii+1))^2); % Length of vortex panel
   theta(ii) = atan2(yb(ii+1)-yb(ii),xb(ii+1)-xb(ii)); % Angle of vortex panel
   RightHS(ii) = sin(theta(ii)-ALPHA);
end

%% Creation of matrix for solving for gamma
for ii = 1:1:n
    for jj = 1:1:n
        if ii == jj % 
           cn1(ii,jj) = -1;
           cn2(ii,jj) = 1;
           ct1(ii,jj) = 0.5*pi;
           ct2(ii,jj) = 0.5*pi;
        else
            xi = x(ii); % x of this
            %xj = x(jj); % x of other
            yi = y(ii); % y of this
            %yj = y(ii); % y of other
            thetai = theta(ii); % angle of this
            thetaj = theta(jj); % angle of other
            si = s(ii); % Length of this
            sj = s(jj); % Length of other
            A(ii) = -(xi - xb(jj))*cos(thetaj) - (yi - yb(jj))*sin(thetaj);
            B(ii) = (xi - xb(jj)).^2 + (yi-yb(jj)).^2;
            C(ii) = sin(thetai - thetaj);
            D(ii) = cos(thetai - thetaj);
            E(ii) = (xi - xb(jj))*sin(thetaj) - (yi-yb(jj))*cos(thetaj);
            F(ii) = log(1+((sj.^2)+2*A(ii).*sj)./B(ii));
            G(ii) = atan2(E(ii).*sj,B(ii)+A(ii).*sj);
            P(ii) = (xi-xb(jj))*sin(thetai-2*thetaj)+(yi-yb(jj))*cos(thetai-2.*thetaj);
            Q(ii) = (xi-xb(jj))*cos(thetai-2*thetaj)-(yi-yb(jj))*sin(thetai-2.*thetaj);
            
            cn2(ii,jj) = D(ii)+0.5*Q(ii)*F(ii)/sj-(A(ii)*C(ii)+D(ii)*E(ii))*G(ii)/sj;
            cn1(ii,jj) = 0.5*D(ii)*F(ii)+C(ii)*G(ii)-cn2(ii,jj);
            ct2(ii,jj) = C(ii)+0.5*P(ii)*F(ii)/sj + (A(ii)*D(ii)-C(ii)*E(ii))*G(ii)/sj;  
            ct1(ii,jj) = 0.5*C(ii)*F(ii) - D(ii)*G(ii) - ct2(ii,jj);
        end
    end
end

plength = (s); % The length of each vortex panel is given here

%% Set up the matrix
for ii = 1:1:n
    an(ii,1) = cn1(ii,1);
    an(ii,n+1) = cn2(ii,n);
    at(ii,1) = ct1(ii,1);
    at(ii,n+1) = ct2(ii,n);
    for jj = 2:1:n
        an(ii,jj) = cn1(ii,jj)+cn2(ii,jj-1);
        at(ii,jj) = ct1(ii,jj)+ct2(ii,jj-1);
    end
end
an(n+1,1) = 1;
an(n+1,n+1) = 1;
for jj=2:n
   an(n+1,jj) = 0; 
end
RightHS(n+1) = 0; % Right hand side of the equation
RightHS = transpose(RightHS);
%% Find gamma numerically and then solve for the Cp and U
gam = an\RightHS;
gammas = gam;
for ii = 1:1:n
   U(ii) = cos(theta(ii)-ALPHA);
   for jj = 1:1:n+1
      U(ii) = U(ii)+at(ii,jj)*gam(jj);
      Cp(ii) = 1-U(ii).^2;
   end
end
end