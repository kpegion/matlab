function [acc]=calcacc(model,verif)


[nlead,nt]=size(model);

for ilead=1:nlead
   x=model(ilead,:);
   y=verif(ilead,:);

   igood=find(~isnan(x) & ~isnan(y));
   acc(ilead)=corr2(x(igood),y(igood));
end
