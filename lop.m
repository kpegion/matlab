function [ L, c0 ] = lop( liminput,ilag )

n1=size(liminput,1);
n2=size(liminput,2);

% Calculate the covariance matrix of the data

c0=(liminput'*liminput)./n1;
c0inv=inv(c0);

% Calculate cov( Tau0 ) by shifting data by itau

xtau0=liminput(1+ilag:n1,:);
xt=liminput(1:n1-ilag,:);
ctau0=(xtau0'*xt)./(n1-ilag);

% Calculate the linear operator 

L=(1.0/ilag).*logm( ctau0*c0inv );

