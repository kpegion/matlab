function [clim]=calcClimRefMonthly(data,ncdates,syr,eyr)

% Constants
nmpyr=12; % months per year

% Get dimensions
[nx,ny,nt]=size(data);

% Set start and end dates as date string of form yyyymm
syrstr=datestr(datestr([syr,1,1,0,0,0]),'yyyymm');
eyrstr=datestr(datestr([eyr,12,1,0,0,0]),'yyyymm');

% Find which time indices these dates correspond to
indexsyr=find(ismember(cellstr(ncdates),syrstr));
indexeyr=find(ismember(cellstr(ncdates),eyrstr));

% Subset data for specified years using indexsyr and indexeyr
datasub=data(:,:,indexsyr:indexeyr);

% Convert datasub to [nx,ny,nmpyr,nyr]
nyr=eyr-syr+1;
datasub=reshape(datasub,[nx,ny,nmpyr,nyr]);

% Calculate climatology over all years, retain NaNs
clim=nanmean(datasub,4);

