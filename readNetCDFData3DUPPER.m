function [lon,lat,time,unitst,data,unitsd,fillValue]=readNetCDFData3DUPPER(fname,varname)

  ncid=netcdf.open(char(fname),'NC_NOWRITE');
  varid=netcdf.inqVarID(ncid,'LON')
  lon=netcdf.getVar(ncid,varid);
  varid=netcdf.inqVarID(ncid,'LAT');
  lat=netcdf.getVar(ncid,varid);
  varid=netcdf.inqVarID(ncid,'TIME');
  time=netcdf.getVar(ncid,varid);
  unitst=netcdf.getAtt(ncid,varid,'units');
  varid = netcdf.inqVarID(ncid,upper(varname));
  data=netcdf.getVar(ncid,varid);
  unitsd=netcdf.getAtt(ncid,varid,'units');

  % Look for FillValue
  try
     fillValue=ncreadatt(char(fname),upper(varname),'_FillValue');
  catch exception 
     if strcmp(exception.identifier,'MATLAB:imagesci:netcdf:libraryFailure');
    
      % Look for missing_value
      try
         fillValue=ncreadatt(char(fname),varname,'missing_value');
      catch exception 
         if strcmp(exception.identifier,'MATLAB:imagesci:netcdf:libraryFailure');
           fillValue=-9.99e8; 
         end %if catch exception
      end % end try missing_value

    end % if catch exception
 end % try fillValue

 bad=find(data == fillValue);
 data(bad)=NaN;

 netcdf.close(ncid);
