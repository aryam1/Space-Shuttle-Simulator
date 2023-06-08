i=0;
tmax=2000;
thick=0.05;
step=1;
startval=10;
endval=500;
counter=startval:step:endval;
data=zeros(size(counter,2));
tic
for nx = counter
    i=1+(nx/step)-startval;
    j=0;
  for nt = counter
       j=1+(nt/step)-startval;
       a=Common(tmax,nt,thick,nx,'502');
       af=a.Forward;
%        ab=a.Backwards;
%        ad=a.DFF;
%        ac=a.CN;
       data(i,j,1)=mean(af.u(end,:));
%        data(i,j,2)=mean(ab.u(end,:));
%        data(i,j,3)=mean(ad.u(end,:));
%        data(i,j,4)=mean(ac.u(end,:));
  end
end
toc
% methods={'Forward';'Backwards';'DFF';'CN'};
% figure()
% for n = 1:4
%     subplot(2,2,n)
%     surf(data(:,:,n))
%     title(['Subplot ' num2str(n) ':' methods{n}])
%     xlabel('nx')
%     ylabel('nt')
% end