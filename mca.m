function [ SP1,SP2,TS1,TS2,VE ] = mca(S,P,nmca)

% Calculate Covariance Matrix
   C=S'*P;

% Take SVD
   [U,L,V]=svd(C);

% Calculate Time Series
    A=S*U;
    B=P*V;
    TS1=A(:,1:nmca);
    TS2=B(:,1:nmca);

% Co-Variance Explained
    VE=diag(L)./sum(l);

% Calculate Spatial components
    SP1=U(:,1:nmca);
    SP2=V(:,1:nmca);

