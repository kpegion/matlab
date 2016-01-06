function [lon,lat,time,unitst,data,unitsd,fillValue]=readNetCDFData3D(fname,varname)

  ncid=netcdf.open(char(fname),'NC_NOWRITE');
  varid=netcdf.inqVarID(ncid,'lon');
  lon=netcdf.getVar(ncid,varid);
  varid=netcdf.inqVarID(ncid,'lat');
  lat=netcdf.getVar(ncid,varid);
  varid=netcdf.inqVarID(ncid,'time');
  time=netcdf.getVar(ncid,varid);
  unitst=netcdf.getAtt(ncid,varid,'units');
  varid = netcdf.inqVarID(ncid,varname);
  netcdf.close(ncid);

