function [ lonReg,latReg,dataReg] = getRegion(lon,lat,data,region)

minLon=region(1);
maxLon=region(2);
minLat=region(3);
maxLat=region(4);

ilats=find(lat <= maxLat & lat >= minLat);
if (maxLon >= minLon)
ilons=find(lon <= maxLon & lon >= minLon);
else
ilons=find(lon >= minLon & lon <= 360 | lon <= maxLon & lon >= 0);
end

lonReg=lon(ilons);
latReg=lat(ilats);

dataReg=data(ilons,ilats,:);

