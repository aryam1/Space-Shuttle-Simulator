% jacobi.m
% ME20021
%
% MATLAB script to solve Poisson's equation using the Jacobi method. This
% could represent fluid velocity in a rectangular duct, for example
%
% D N Johnston  04/03/2021
%
% Exercises:
% Try different nx, ny values, and see what effect these have on the number of
% iterations.

tic
% set dimensions etc
nx = 21;
ny = 21;
h = 0.05;
S = -1.0;
maxIteration = 10000;
tolerance = 1.e-6;

% set x and y vectors, and initialise u and unew matrices
x = (0:nx-1) * h;
y = (0:ny-1) * h;
uOld = zeros(ny, nx);
uNew = zeros(ny, nx);
iMid = (nx+1)/2; jMid = (ny+1)/2;

% create surface plot
pl = surf(x, y, uOld);
% shading interp
zlim([0 0.1])
xlabel('\itx')
ylabel('\ity')
zlabel('\itu')

% Set up i and j as vectors to cover all internal points
i=2:nx-1;
j=2:ny-1;

% iteration loop
for iteration = 1:maxIteration
    % calculate new internal values: Not that this is done as a matrix
    % equation as i and j are vectors.
    uNew(j,i) = (uOld(j,i-1)+uOld(j,i+1)+uOld(j-1,i)+uOld(j+1,i)...
        - h^2 * S)/4;
    
    % calculate sum of changes
    change = sum(abs(uNew - uOld), 'all');
    
    % has it converged?
    if change < tolerance
        disp([num2str(iteration) ' iterations taken to converge; '...
            'midpoint value = ' num2str(uNew((ny+1)/2, (nx+1)/2))])
        break;
    end
    
    % overwrite uold matrix with unew
    uOld = uNew;
    
    % update graph
    set(pl,'ZData', uOld);
    drawnow
    
    umid(iteration) = uOld(jMid, iMid);
end
toc
figure(2)
plot(umid)
xlabel('Iteration')
ylabel('mid-point value')