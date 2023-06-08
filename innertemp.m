thick=[0.01:0.01:0.1];
load stability_850.mat
figure
hold on
for i = 1:size(thick,2)
    a=Common(4000,nt,thick(i),nx,'850');
    a=a.CN;
    plot(a.t,a.u(:,1))
end
legend(string(thick))