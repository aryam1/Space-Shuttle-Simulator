file = 'stability_502.mat';
load(file)
count=1:size(data,1);
d2x=smoothdata(diff(data,2,1));
d2t=diff(data,2,2);
confidence =1e-3;
for i = count
    n2x(i)=find(abs(d2x(:,i))<confidence,1);
    n2t(i)=find(abs(d2t(i,:))<confidence,1);
    n2x(i)=find(abs(smoothdata(diff(data(:,i),1)))<confidence,1);
    n2t(i)=find(abs(diff(data(i,:),1))<confidence,1); 
end
nx=mode(n2x);
nt=mode(n2t);
save(sprintf(file),'data','nx','nt');