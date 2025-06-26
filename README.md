# Subsampling
Codes for the Article "Behavior of the scaling correlation functions under severe subsampling" by 
Camargo, S., Zamponi, N., Martin, D.A., Turova, T., Grigera, T.S., Tang, Q.Y. and Chialvo, D.R., 2025. 
arXiv preprint arXiv:2504.03203.


Codes
-----

- Radial distribution function (twopointcorr.m) 
Author: Ilya Valmianski
Reference:Ilya Valmianski (2025). Two point correlation function of a finite 2D lattice (https://www.mathworks.com/matlabcentral/fileexchange/31353-two-point-correlation-function-of-a-finite-2d-lattice), MATLAB Central File Exchange. Retrieved June 26, 2025.

- Fractal dimension (boxcount.m)
Author: F. Moisy
Reference:Frederic Moisy (2025). boxcount (https://www.mathworks.com/matlabcentral/fileexchange/13063-boxcount), MATLAB Central File Exchange. Retrieved June 26, 2025.

- Detrended fluctuation analysis (dfa.m)
Author: Patrick E. McSharry (patrick@mcsharry.net)
Copyright (c) 2005 


Files
-----

The Purkinje image is available at https://www.cellimagelibrary.org/images/CCDB_3687#cite (REF [29] in the paper).
We computed the maximum intensity projection of the given image.

Drosophila data was kindly provided by the authors  (REF [30] in the paper).
https://www.science.org/doi/10.1126/sciadv.aau9253


We attach the following data from the paper
--------------------------------------------

Serpienski Gasket (fig1_A.txt, fig1_B.txt, fig1_C.txt) 
Random Cantor (fig2_A.txt, fig2_B.txt, fig2_C.txt) 
Gaussian correlated time series (fig3_A.txt, fig3_B.txt, fig3_C.txt) 
Purkinje (fig4_A.txt, fig4_B.txt, fig4_C.txt) 
Drosophila (fig5_A.txt, fig5_B.txt, fig5_C.txt) 



Minimum example for g(r) (Figs 1(d), 2(d), and 4(d))
----------------------------------------------------
dr=0.005
T=readtable("fig1_A.txt")
X=table2array(T)
plot(X(:,1),X(:,2),'.')
[gr r]=twopointcorr(squeeze(X(:,1)),squeeze(X(:,2)),dr)
loglog(r,gr)

(then repeat for panels B and C).


Minimum example for Box Counting  (Figs 1(e), 2(e), and 4(e))
-------------------------------------------------------------

T=readtable("fig2_A.txt")
X=table2array(T)
N=512
Mat=zeros(N);
for i=1:size(X,1)
if X(i,1)<N+1
Mat(X(i,1),X(i,2))=1;
end
end
imshow(Mat)
[n,rr]=boxcount(Mat,'slope');



Minimum example for DFA  (Figs 3(d) and 5(d))
----------------------------------------------
x1=importdata('fig3_A.txt');
nn=12;
[alpha,lnstodo,lFtodo,lns,lF,lFpred] =dfa(zscore(x1(:,2)),nn,1);
(reduce nn value as you take shorter timeseries)
