i=0;
nt = 300;
thick = 0.05;
tmax = 4000;
tic
for nx = 11:20:500
    i=i+1;
    a=Common(tmax,nt,thick,nx,'502');
    dx(i) = thick/(nx-1);
    %disp (['nx = ' num2str(nx) ', dx = ' num2str(dx(i)) ' m'])
    af=a.Forward;
    uf(i) = af.u(end, 1);
    ab=a.Backwards;
    ub(i) = ab.u(end, 1);
    ad=a.DFF;
    ud(i) = ad.u(end, 1);
    ac=a.CN;
    uc(i) = ac.u(end, 1);
end
toc
plot(11:20:500, uc)
legend ('Forward', 'Backward', 'DFF', 'CN')

% nt=401
% nx =401