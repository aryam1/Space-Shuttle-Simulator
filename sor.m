% sor.m
% ME20021
%
% MATLAB script to solve Poisson's equation using the Successive
% Over-Relaxation method.
%
% D N Johnston  10/3/21
%
tic
% set dimensions etc
clear
nx = 41; ny = 41; xmax = 1; ymax = 1;
dx = xmax / (nx-1); dx2 = dx^2;
dy = ymax / (ny-1); dy2 = dy^2;
factor = 2/dx2 + 2/dy2;
S = -1.0;
maxIteration = 5000;
tolerance = 1.e-6;

% create dialog box for entering value of w
answer = inputdlg('Enter the value of relaxation factor');

% convert from string to number
w = str2num(answer{1});
 
% set x and y vectors, and initialise u matrix with initial
% and boundary values (all zero in this case).
x = (0:nx-1) * dx;
y = (0:ny-1) * dy;
u = zeros(ny, nx);
iMid = (nx+1)/2; jMid = (ny+1)/2;

% create surface plot
figure(1)
h = surf(x, y, u);
% shading interp

zlim([0 0.1])
xlabel('\itx'), ylabel('\ity'), zlabel('\itu')
% iteration loop

for iteration = 1:maxIteration
    change = 0;
    % calculate new internal values
    for i=2:nx-1
        for j=2:ny-1
            deltaU = ((u(j,i-1) + u(j,i+1)) / dx2 + ...
                (u(j-1,i) + u(j+1,i)) / dy2 - S) / factor - u(j,i);
            %update u
            u(j,i) = u(j,i) + deltaU * w;
            
            % calculate sum of changes
            change = change + abs(deltaU);
        end
    end
    if iteration == nx + ny - 1
        oldChange = change;
    elseif iteration == nx + ny
        % Set estimated optimum relaxation factor
        w = 2/(1+sqrt(1-change/oldChange))
    end
    % has it converged?
    if change < tolerance
        disp([num2str(iteration) ' iterations taken to converge; '...
            'midpoint value = ' num2str(u((ny+1)/2, (nx+1)/2))])
        break;
    end
    % Update graph
    set(h,'ZData', u);
    drawnow
    uMid(iteration) = u(jMid, iMid);
end
toc
figure(2)
plot(uMid)
xlabel('Iteration')
ylabel('mid-point value')
