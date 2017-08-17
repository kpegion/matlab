function [rmse]=calcrmse(model,verif)


[nlead,nt]=size(model);

for ilead=1:nlead
   x=model(ilead,:);
   y=verif(ilead,:);
   igood=find(~isnan(x) & ~isnan(y));
%   rmse(ilead)=sqrt(nanmean((x(igood)-y(igood)).^2));
   rmse(ilead)=sqrt(nanmean((x-y).^2));
end
