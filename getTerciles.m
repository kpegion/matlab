function [fterciles,vterviles]=getTertiles(fcst,verif,catts)

% fcst = vector containing all times for which to determine terciles from for fcst
% verif = vector containng all times for which to determine terciles from for verif


fterciles=prctile(fcst,catts);
vterviles=prctile(verif,catts);

