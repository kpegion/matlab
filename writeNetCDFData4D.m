%================================================================================================
%  This function write a 4D (lon,lat,time,ens) dataset to a netcdf file
%================================================================================================
function []=writeNetCDFData4D(fname,data,units,name,longname,fillValue)

% Open File
ncid = netcdf.open(char(fname),'WRITE');

% Dimension IDs

dimlat=netcdf.inqDimID(ncid,'lat');
dimlon=netcdf.inqDimID(ncid,'lon');
dimtime=netcdf.inqDimID(ncid,'time');
dimens=netcdf.inqDimID(ncid,'ens');

%Add Variable
varid = netcdf.defVar(ncid,char(name),'double',[dimlon,dimlat,dimtime,dimens]);
netcdf.putAtt(ncid,varid,'name',char(name)');
netcdf.putAtt(ncid,varid,'long_name',char(longname));
netcdf.putAtt(ncid,varid,'units',char(units));
netcdf.defVarFill(ncid,varid,false,fillValue);
netcdf.putVar(ncid,varid,data);


% Close File
netcdf.close(ncid);
