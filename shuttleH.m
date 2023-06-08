function [x, t, u] = shuttleH(tmax, nt, xmax, nx, method, doPlot)
% Function for modelling temperature in a space shuttle tile
% D N Johnston  05/02/21
%
% Input arguments:
% tmax   - maximum time
% nt     - number of timesteps
% xmax   - total thickness
% nx     - number of spatial steps
% method - solution method ('forward', 'backward' etc)
% doPlot - true to plot graph; false to suppress graph.
%
% Return arguments:
% x      - distance vector
% t      - time vector
% u      - temperature matrix
%
% For example, to perform a  simulation with 501 time steps
%   [x, t, u] = shuttle(4000, 501, 0.05, 21, 'forward', true);
%

% Set tile properties
thermCon = 0.0577; % W/(m K)
density  = 144;   % 9 lb/ft^3
specHeat = 1261;  % ~0.3 Btu/lb/F at 500F

% Some crude data to get you started:
% timeData = [0  60 500 1000 1500 1750 4000]; % s
% tempData = [16 17 820 760  440  16   16];   % degrees C

% Better to load surface temperature data from file.
% (you need to have modified and run plottemp.m to create the file first.)
% Uncomment the following line.

% Inputs data from NASA temperature data to shuttle.m
load 468.mat

% Initialise everything
dt = tmax / (nt-1);
t = (0:nt-1) * dt;
dx = xmax / (nx-1);
x = (0:nx-1) * dx;
u = zeros(nt, nx);

alpha = thermCon/(density * specHeat);
p = (alpha * dt )/ dx^2;

timeData=co_ords(:,1);
tempData=co_ords(:,2);

% Use interpolation to find temperature values at origin
k = interp1(timeData, tempData, 0,'linear','extrap');

% Store interpolated temperature data at origin as right-hand R.
R = interp1([0;timeData],[k ;tempData], t);

% Set initial conditions equal to boundary temperature at t=nt
u(:,nx) = R;

% Set up index vectors
ivec = 2:nx-1;      
im = [2 1:nx-2];
i = 1:nx-1;
ip = 2:nx;
% ip = [2:nx-1 nx-2];

% Main timestepping loop
for n = 1:nt - 1
    
    % Select method
    % Uses a Neumann boundary from i=1 to i=nx-1 and Dirichlet boundary for i=nx
    switch method
        case 'forward'
            
            % Calculate internal values using forward differencing
            u(n+1, i) = (1 - (2 * p)) * u(n,i) + p * (u(n,im) + u(n,ip));
            
            
        case 'dufort-frankel'
            % when n=1, n-1 term is assumed to be 1
            if n == 1
                nmin = 1;
                
            else nmin = n-1;
                
            end
            
            % calculate internal values using dufort-frankel method
            u(n+1,i) = ((1 - 2 * p) * u(nmin,i)+ 2 * p * (u(n,im)+u(n,ip))) / (1 + (2 * p));
            
            
        case 'backward'
            %Set temperature profile at i=nx as right-side dirichlet boundary
            RB = R(n);
            
            % Calculate internal values using backward differencing
            % Left boundary
            b(1)    = 1 + (2 * p);
            c(1)    = -(2 * p);
            d(1)    = u(n,1);
               
            % Internal points
            a(ivec) = -p;
            b(ivec) = 1 + (2 * p);
            c(ivec) = -p;
            d(ivec) = u(n,ivec);    
            
            % Right boundary
            a(nx)   = 0;
            b(nx)   = 1;
            d(nx)   = RB;
            u(n+1,:) = shuttlebackward(a,b,c,d);
            
        case 'crank-nicholson'
            %Set temperature profile at i=nx as right-side dirichlet boundary
            RB = R(n);
            
            %calculate internal values using crank-nicholson
            % Left boundary
            b(1) = 1 + p;
            c(1) = -p;
            d(1) = ((1-p) * u(n,1))+(p * u(n,2));
            
            % Internal points
            a(ivec) = -(p/2);
            b(ivec) = 1 + p;
            c(ivec) = a(ivec);
            d(ivec) = (p/2) * u(n,ivec-1) + (1-p) * u(n,ivec) + (p/2) * u(n,ivec+1);
            
            % Right boundary
            a(nx) = 0;
            b(nx) = 1;
            d(nx) = RB;
            u(n+1,:) = shuttlebackward(a,b,c,d);
            
        otherwise
            error (['Undefined method: ' method])
            return
    end
end

% Create a plot
if doPlot
    % contour plot
    surf(x,t,u)
    % comment out the next line to change the surface appearance
    shading interp
    
    %label the axes
    xlabel('Distance (m)')
    ylabel('Time (s)')
    zlabel('Temperature (deg F)')
    title('Temperature Profile of Spacecraft Tile')
    ylim([0 2000]); 
%     view(140,30)
end

    