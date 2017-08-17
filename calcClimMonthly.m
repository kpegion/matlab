function [clim]=calcClimMonthly(data,nyr)

% Constants
nmpyr=12; % months per year

% Get dimensions
[nx,ny,nt]=size(data);

% Convert datasub to [nx,ny,nmpyr,nyr]
datasub=reshape(data,[nx,ny,nmpyr,nyr]);

% Calculate climatology over all years, retain NaNs
clim=nanmean(datasub,4);

