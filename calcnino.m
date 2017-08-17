%
% Calculates the Nino1+2,Nino3,Nino3.4,Nino4 indices
%
% Indices are defined as SSTs averaged in the regions below (inclusive)
%  Nino1+2: 270-280; 10S-0
%  Nino3  : 210-270; 5S-5N
%  Nino3.4: 190-240; 5S-5N
%  Nino4  : 160-210; 5S-5N
%
% Input: 
%   lons(nx) -- longitudes represented as 0-360
%   lats(ny) -- latitudes represented as S to N
%   data(nx,ny,nens,nt) --  anomalies on a grid that matches lats and lons
%
%
% Output:
%   N12(nens,nt) -- Nino1+2 index for all times & ensembles
%   N3(nens,nt)  -- Nino3 index for all times & ensembles
%   N34(nens,nt) -- Nino3.4 index for all times & ensembles
%   N4(nens,nt)  -- Nino4 index for all times & ensembles
%
%
% Note:
%   - Handles NaNs and can return NaN
%   - Does not do any weighted averaging
%
%==================================================================================

function [ N12,N3,N34,N4] = calcnino(lons,lats,data)

   % Get dimensions
   [nx,ny,nens,nt]=size(data);

   %Nino1+2
   ilat=find(lats >= -10 & lats <=0);
   ilon=find(lons >=270 & lons <=280);
   nxbox=numel(ilon);
   nybox=numel(ilat);
   box=reshape(data(ilon,ilat,:,:),[nxbox.*nybox,nens,nt]);
   N12=nanmean(box,1);
 
   %Nino3
%   ilat=find(lats >= -5 & lats <=5);
   ilat=find(lats > -5 & lats <5);
   ilon=find(lons >=210 & lons <=270);
   nxbox=numel(ilon);
   nybox=numel(ilat);
   box=reshape(data(ilon,ilat,:,:),[nxbox.*nybox,nens,nt]);
   N3=nanmean(box,1);

   %Nino3.4
%   ilon=find(lons >=190 & lons <=240);
   ilon=find(lons >190 & lons <240);
   nxbox=numel(ilon);
   nybox=numel(ilat);
   box=reshape(data(ilon,ilat,:,:),[nxbox.*nybox,nens,nt]);
   N34=nanmean(box,1);

   %Nino4
   ilon=find(lons >=160 & lons <=210);
   nxbox=numel(ilon);
   nybox=numel(ilat);
   box=reshape(data(ilon,ilat,:,:),[nxbox.*nybox,nens,nt]);
   N4=nanmean(box,1);



