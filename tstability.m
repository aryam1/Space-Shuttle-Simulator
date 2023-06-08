i=0;
nx = 150;
thick = 0.05;
tmax = 4000;
tic
for nt = 41:20:1001
    i=i+1;
    a=Common(tmax,nt,thick,nx,'502');
    dt(i) = tmax/(nt-1);
    %disp (['nt = ' num2str(nt) ', dt = ' num2str(dt(i)) ' s'])
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
plot(41:20:1001, uc)
ylim([320 360])
xlim([0 300])
legend ('Forward', 'Backward', 'DFF', 'CN')

% nt=201