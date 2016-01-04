%================================================================================================
% This function sets up everything for writing a netcdf file 
% It assumes the following:  
%
%   Data to be written is dimensions (lat,lon,time)
%
%   lons:  standard name is 'lon'; longname is 'longitude'; units are 'degrees east'
%   lats:  standard name is 'lat'; longname is 'latitude'; units are 'degrees nort'
%   time:  standard name is 'time'; longname is 'Time of measurements; units are passed in
%   fillValue and missing value for the data are the same and are passed in
%   There is no scale_factor and/or offset
%   Only dimenstion variables are written
%   Global Attributes are not set here
%
%================================================================================================
function []=setupNetCDF4D(fname,lons,lats,time,ens,unitst,fillValue)

% Open File
ncid=netcdf.create(char(fname),'netcdf4');

% Get dimensions
nx=numel(lons);
ny=numel(lats);
nt=numel(time);
ne=numel(ens);

% Set file Dimensions
dimlat=netcdf.defDim(ncid,'lat',ny);
dimlon=netcdf.defDim(ncid,'lon',nx);
dimtime = netcdf.defDim(ncid,'time',nt);
dimens = netcdf.defDim(ncid,'ens',ne);

% Define lons, lats, time,ens
varid = netcdf.defVar(ncid,'lat','double',[dimlat]);
netcdf.putAtt(ncid,varid,'standard_name','latitude');
netcdf.putAtt(ncid,varid,'long_name','latitude');
netcdf.putAtt(ncid,varid,'units','degrees_north');
netcdf.defVarFill(ncid,varid,false,fillValue);
netcdf.putVar(ncid,varid,squeeze(lats));


varid = netcdf.defVar(ncid,'lon','double',[dimlon]);
netcdf.putAtt(ncid,varid,'standard_name','longitude');
netcdf.putAtt(ncid,varid,'long_name','longitude');
netcdf.putAtt(ncid,varid,'units','degrees_east');
netcdf.defVarFill(ncid,varid,false,fillValue);
netcdf.putVar(ncid,varid,squeeze(lons));

varid = netcdf.defVar(ncid,'time','double',[dimtime]);
netcdf.putAtt(ncid,varid,'standard_name','time');
netcdf.putAtt(ncid,varid,'long_name','Time of measurements');
netcdf.putAtt(ncid,varid,'units',unitst);
netcdf.defVarFill(ncid,varid,false,fillValue);
netcdf.putVar(ncid,varid,squeeze(time));

varid = netcdf.defVar(ncid,'ens','double',[dimens]);
netcdf.putAtt(ncid,varid,'standard_name','ensemble');
netcdf.putAtt(ncid,varid,'grads_dim','e');
netcdf.putAtt(ncid,varid,'long_name','Ensemble Member');
netcdf.defVarFill(ncid,varid,false,fillValue);
netcdf.putVar(ncid,varid,squeeze(ens));

% Close File
netcdf.close(ncid);
