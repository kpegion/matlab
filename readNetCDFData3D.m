function [lon,lat,time,unitst,data,unitsd,fillValue]=readNetCDFData4D(fname,varname)

  ncid=netcdf.open(char(fname),'NC_NOWRITE');
  varid=netcdf.inqVarID(ncid,'lon');
  lon=netcdf.getVar(ncid,varid);
  varid=netcdf.inqVarID(ncid,'lat');
  lat=netcdf.getVar(ncid,varid);
  varid=netcdf.inqVarID(ncid,'time');
  time=netcdf.getVar(ncid,varid);
  unitst=netcdf.getAtt(ncid,varid,'units');
  varid = netcdf.inqVarID(ncid,varname);
  data=netcdf.getVar(ncid,varid);
  unitsd=netcdf.getAtt(ncid,varid,'units');
  fillValue=ncreadatt(char(fname),varname,'_FillValue');
  bad=find(data == fillValue);
  data(bad)=NaN;

