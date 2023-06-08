file=input('File:','s');
data=zeros(991);
parfor i = 10:1000
    data2=zeros(1,991);
    disp(i)
  for j = 10:1000
       a=Common(4000,j,0.05,i,file);
       a=a.CN;
       data2(j-9)=mean(a.u(end,:));
  end
  data(i-9,:)=data2;
end