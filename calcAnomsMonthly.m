function [anoms]=calcAnomsMonthly(data,clim)

% Constants
nmpyr=12; % # months per year

% Get dimensions of data
[nx,ny,nt]=size(data);

% Get integer number of years
nyrs=floor(nt./nmpyr);
ntint=nyrs.*nmpyr;

% Convert data to [nx,ny,nmpyr,nyrs]
data=reshape(data(:,:,1:ntint),[nx,ny,nmpyr,nyrs]);

% Calculate monthly anomalies
for iyr=1:nyrs
    anoms(:,:,:,iyr)=data(:,:,:,iyr)-clim(:,:,:);
end

% Convert anoms to [nx,ny,ntint]
anoms=reshape(anoms,[nx,ny,ntint]);

