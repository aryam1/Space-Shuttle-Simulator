methods={'Forward';'Backwards';'DFF';'CN'};
load('All stability')
for n = 1:4
subplot(2,2,n)
surf(data(:,:,n))
title(['Subplot ' num2str(n) ':' methods{n}])
xlabel('nx')
ylabel('nt')
shading interp
end