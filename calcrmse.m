function [rmse]=calcrmse(model,verif)


[nx,ny,nlead,nt]=size(model);

for ilead=1:nlead
   for i=1:nx
      for j=1:ny
        x=model(i,j,ilead,:);
        y=verif(i,j,ilead,:);
        igood=~isnan(y) & ~isnan(x);
        if (~isempty(x(igood)) & ~isempty(y(igood)))
           rmse(i,j,ilead)=nanmean((x(igood)-y(igood)).^2);
        else
           rmse(i,j,ilead)=NaN;
        end
      end
   end
end
