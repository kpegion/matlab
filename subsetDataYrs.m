function [dataSub,timeSub]=subsetDataYrs(data,time,unitst,syr,eyr)

% Get the date strings that correspond to the netcdf times
ncdates=nctime2datestr(time,unitst);

% Set start and end dates as date string of form yyyymm
syrstr=datestr(datestr([syr,1,1,0,0,0]),'yyyymm');
eyrstr=datestr(datestr([eyr,12,1,0,0,0]),'yyyymm');

% Find which time indices these dates correspond to
indexsyr=find(ismember(cellstr(ncdates),syrstr));
indexeyr=find(ismember(cellstr(ncdates),eyrstr));

% Subset data for specified years using indexsyr and indexeyr
dataSub=data(:,:,indexsyr:indexeyr);
timeSub=time(indexsyr:indexeyr);


