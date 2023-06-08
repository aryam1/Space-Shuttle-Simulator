function [x, t, u] = shuttle(tmax, nt, xmax, nx, method, doPlot)
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
timeData = [0  60 500 1000 1500 1750 4000]; % s
tempData = [16 17 820 760  440  16   16];   % degrees C

% Better to load surface temperature data from file.
% (you need to have modified and run plottemp.m to create the file first.)
% Uncomment the following line.
% load temp597.mat

% Initialise everything.
dt = tmax / (nt-1);
t = (0:nt-1) * dt;
dx = xmax / (nx-1);
x = (0:nx-1) * dx;
u = zeros(nt, nx);

% Use interpolation to get outside temperature at times t 
% and store it as right-hand boundary R.
R = interp1(timeData, tempData, t);

% set initial conditions equal to boundary temperature at t=0.
u(1, :) = R(1);
u(:,1)=R;

% Main timestepping loop.
for n = 1:nt - 1

    % Select method.
    switch method
        case 'forward'
            
        case 'dufort-frankel'

        otherwise
            error (['Undefined method: ' method])
            return
    end
end

if doPlot
    % Create a plot here.
end



    