using Plots
#use heatmap 

# number of coluns 
ncol = 30;

# number of rows 
nrow =  30; 
St     = zeros(ncol);
nextSt = zeros(ncol); 
St[div(ncol,2)] = 1; 
evoM = zeros(nrow,ncol); 

#println(size(evoM))

for i in 1:nrow
  evoM[i,:]=St;
  for j in 3:ncol-2
    nextSt[j]= mod(St[j-1] +2*St[j] + St[j+1],5); 
  end           
#  St = nextSt;
  global St =deepcopy(nextSt);
end;

heatmap!(evoM)


