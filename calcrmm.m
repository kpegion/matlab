function [rmm1,rmm2]=calcrmm(olr,u200,u850,lon,lat,eoffile)

   [nxwnd,nywnd,nt]=size(u200);
   [nxolr,nyolr,nt]=size(olr);

   % Dimensions of Reanalysis/Obs Data
   nxobs=144;
   nyobs=73;
   lonObs=0:2.5:357.5;
   latObs=-90:2.5:90;
   ilatobs=find(latObs >=-15 & latObs <= 15);
   [obslats,obslons]=meshgrid(latObs(ilatobs),lonObs);

   % Read Wheeler Hendon EOFs
   [eigvec,eig,nf]=readWH04EOFS(eoffile,nxobs);

   % Subset grid to 15S-15N
   ilatmodel=find(lat >=-15 & lat <= 15);

   % Make meshgrid & interpolate data to Obs grid for projection onto EOF patterns
   [modellat,modellon]=meshgrid(double(lat(ilatmodel)),double(lon));

   for it=1:nt
       newu200(:,:,it)=griddata(modellon,modellat,squeeze(double(olr(:,ilatmodel,it))),obslons,obslats);
       newu850(:,:,it)=griddata(modellon,modellat,squeeze(double(u200(:,ilatmodel,it))),obslons,obslats);
       newolr(:,:,it)=griddata(modellon,modellat,squeeze(double(u850(:,ilatmodel,it))),obslons,obslats);
   end

   % Average 15S-15N
   zmolr=sum(newolr(:,:,:),2)./numel(ilatobs);
   zmu200=sum(newu200(:,:,:),2)./numel(ilatobs);
   zmu850=sum(newu850(:,:,:),2)./numel(ilatobs);

   % Normalize
   zmolr=squeeze(zmolr)./nf(1,1);
   zmu850=squeeze(zmu850)./nf(1,2);
   zmu200=squeeze(zmu200)./nf(1,3);

   % Build vector of all vars
   datamat=vertcat(zmolr,zmu850,zmu200);

   % Compute RMM1 and RMM2
   pc=eigvec*datamat;
   rmm1 = pc(1,:)./sqrt(eig(1));
   rmm2 = pc(2,:)./sqrt(eig(2));


