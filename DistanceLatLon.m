function [ D ] = DistanceLatLon(lon1,lat1,lon2,lat2)

% km

R=6371.0;

dLon=abs(lon2-lon1);
dLat=abs(lat2-lat1);
a=sind(dLat/2).*sind(dLat/2)+cosd(lat1)*cosd(lat2)*sin(dLon/2).*sin(dLon/2);
c=2.*atan2(sqrt(a),sqrt(1-a));
D=R.*c;


end

