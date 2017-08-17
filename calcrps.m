function [r]=calcrps(fcst,fterc,verif,vterc,catts)

[nensf,junk]=size(fcst);
ncatts=numel(catts);

% Calc fcst probs
r=0.0;

iflower=find(fcst < fterc(1));
ifmiddle=find(fcst >= fterc(1) & fcst < fterc(2));
ifupper=find(fcst >= fterc(2));

if (isempty(iflower))
  fcstp(1)=0;
else
  fcstp(1)=numel(iflower)./nensf;
end

if (isempty(ifmiddle))
  fcstp(2)=0;
else 
  fcstp(2)=numel(ifmiddle)./nensf;
end
 
if (isempty(ifupper))
  fcstp(3)=0;
else
  fcstp(3)=numel(ifupper)./nensf;
end

% Calc obs probs
verifp=zeros(1,ncatts);
if (verif < vterc(1))
   verifp(1)=1;
end
if (verif >= vterc(1) & verif < fterc(2))
   verifp(2)=1;
end
if (verif >= vterc(2))
   verifp(3)=1;
end

for icatts=1:ncatts
   pk=0;
   ok=0;
   for k=1:icatts
      pk=pk+fcstp(k);
      ok=ok+verifp(k);
   end
    r=r+(pk-ok).^2;
end
r=0.5.*r;
