function [alpha,lnstodo,lFtodo,lns,lF,lFpred] = dfa(x, enene,pflag)
% alpha = dfa(x) calculates the detrended fluctuation analysis 
% estimate of the scaling exponent alpha. 
% The raw time series x(i) is first integrated to give y(i); i=1,...,N. 
% For each length scale, n, y(i) is divided into segments of equal length, n.
% In each segment, the data is detrended by subtracting the local linear least 
% squares fit, yn(k).  The root-mean-square fluctuation of this integrated 
% and detrended time series is given by 
% F(n) = sqrt( (1/N) sum_{k=1}^N [y(k) - yn(k)]^2 )
% We calculate the average fluctuation F(n) for each segment n. 
% If the scaling approximately given by F(n) = c n^alpha, 
% we can estimate alpha by calculating the slope of log F(n) versus log n.
% Such a linear relationship on a log-log plot indicates the presence of 
% power law (fractal) scaling. 
% A log-log plot of F(n) against n is provided when pflag=1.  Default: plag=0.
% Peng C-K, Buldyrev SV, Havlin S, Simons M, Stanley HE, Goldberger AL. 
% Mosaic organization of DNA nucleotides. Phys Rev E 1994;49:1685-1689.
% Copyright (c) 2005 Patrick E. McSharry (patrick@mcsharry.net)

if nargin < 2
   pflag = 0;
end

N = length(x);     
y = cumsum(x);

n1 = 3; 
n2 = round(log2(N/2)); 
ns = [2.^[n1:n2] N]'; 
nn = length(ns);
F = zeros(nn,1);
for n=1:nn
   t = trend(y, ns(n));
   z = y - t;
   F(n) = sqrt(mean(z.^2));
   
end
nntodo=nn;
nn=enene;

lnstodo = log10(ns(1:nntodo));
lFtodo = log10(F(1:nntodo));  

lns = log10(ns(1:nn)); 
lF = log10(F(1:nn));  


A = ones(nn,2);
A(:,2) = lns;
a = pinv(A)*lF;
alpha = a(2);
lFpred = A*a;
Fpred = 10.^(lFpred);

if pflag == 1
%figure;

loglog(10.^lnstodo, 10.^lFtodo,'k.-','MarkerSize',23);
hold on;
loglog(10.^[lns(1) lns(nn)], 10.^[lFpred(1) lFpred(nn)],'--r');


xlabel('n');
ylabel('F(n)');
title(['F(n) ~ n^{\alpha} with \alpha = ' num2str(a(2)) ]);
end



function t = trend(y, n)
N = length(y);
t = zeros(N,1);
r = floor(N/n);
for i=1:r 
   v = y((i-1)*n+1:i*n);
   t((i-1)*n+1:i*n) = linfit(v); 
end 
v = y(r*n+1:N);
t(r*n+1:N) = linfit(v);

   
function up = linfit(v)
k = length(v);
A = ones(k,2);
u = [1:k]';
A(:,2) = u;
a = pinv(A)*v;
up = A*a;
