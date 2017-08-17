function [acc]=calcacc(model,verif)


[nx,ny,nlead,nt]=size(model);

for ilead=1:nlead
   for i=1:nx
      for j=1:ny
        x=model(i,j,ilead,:);
        y=verif(i,j,ilead,:);
        igood=~isnan(y) & ~isnan(x);
        if (~isempty(x(igood)) & ~isempty(y(igood)))
           acc(i,j,ilead)=corr2(x(igood),y(igood));
        else
           acc(i,j,ilead)=NaN;
        end

      end
   end
end
