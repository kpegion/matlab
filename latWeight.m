function [ dataRegWeight ] = latWeight(data,lon,lat)

nx=numel(lon);
ny=numel(lat);

for j=1:ny
   dataRegWeight(:,j,:)=data(:,j,:).*sqrt(cos(degtorad(lat(j))));
end
