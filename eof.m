%-------------------------------------------------------------------------------
%  Calculate EOFS using Matlab eig routine
%
%  Input:
%     F [nx*ny,nt]  dataset to calculate EOFs on
%     neof (scaler)  number of EOFs to return
%
%  Output:
%     PC [nt,neof] timeseries for each EOF sorted in descending order of variance
%     EOF [nx*ny,neof] spatial component for each EOF 
%     lambda [neof] eigenvalues for each EOF 
%  
%  Notes:    
%  Any missing, maskout, or NaN values must be set to zero prior to calling
%  Any latitude weighting must be performed prior to calling
%  Output is not normalized
%-------------------------------------------------------------------------------
function [ PC, EOF, lambda ] = eof(F,neof)

% Get the dimensions
   nt=numel(F(1,:));
   nxny=numel(F(:,1));

% Detrend the data  
   F=detrend(F')';

% Calculate Covariance matrix
   C=(F*F')/squeeze(nt);

% Get Eigenvalues(L) and Eigenvectors(E)
% Eigenvalue are EOFS which are spatial part

   [E,L]=eig(C);
   LL=diag(L);

% Sort Eigenvalues (lambda) and Eigenvectors (ES)
   [EV,I]=sort(LL,'descend');
   ES=E(:,I);

% Calcuate the PCs  (Time Series)
   P=F'*ES;
 
% Extract the requested number of EOFs (Spatial Components)

  EOF=ES(:,1:neof);
  PC=P(:,1:neof);
  lambda=EV(1:neof); 
