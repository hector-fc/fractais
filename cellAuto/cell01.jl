
#use heatmap 

#=
ncol = 10;
nrow =  10; 
St     = zeros(ncol);
nextSt = zeros(ncol); 
St[div(ncol,2)] = 1; 
evoM = zeros(nrow,ncol); 



for i in 1:nrow
  evoM[i,:]=St;
  for j in 3:ncol-2
    nextSt[j]= mod(St[j-1] +2*St[j] + St[j+1],5); 
  end           

  global St =deepcopy(nextSt);
end;

heatmap!(evoM)
=#

using GLMakei

a = 2 

