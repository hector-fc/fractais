
using GLMakie, Random, Colors

function zpW(num::Int,i::Int)    
  ncol = 101      # number of col.
  nrow = 250  
  locM = div(ncol,2)+1
  St = zeros(Int,ncol)

  spM   = zeros(Int,nrow,ncol)
  nextSp= zeros(Int,nrow,ncol)

  St[locM] = 1 

  nextSt = zeros(Int,ncol)  
  
  d1 = digits(num,base=2,pad=8)
  d1 = reverse!(d1)
    
  perm=[[ii,jj,kk] for ii=0:1,jj=0:1,kk=0:1]
  
  nextSp[i,:] = St                      
  
    #====================#
  for j in 2:ncol-1
      for ip in 1:8
          if St[j-1:j+1] == perm[ip] 
              nextSt[j] = d1[ip]
          end
      end    
  end        
  #====================#

  for ip in 1:8
    if  [St[ncol],St[1],St[2]] == perm[ip] 
        nextSt[1] = d1[ip]
    end
    if  [St[ncol],St[ncol],St[1]] == perm[ip] 
      nextSt[ncol] = d1[ip]
    end
  end  
  St =deepcopy(nextSt)                    

  
  spM = deepcopy(nextSp)  
  spM[i,:] = zeros(Int,ncol)
  return spM 
end


colormap_rgb = [RGB(0,0,0), RGB(1,0.8431,0)];



iter = Observable(1)
rule = 14
data = @lift zpW(rule,$iter)

fig=heatmap(data,
    axis=(title=@lift("k=$($iter)"),
    ), colormap = colormap_rgb);    

record(fig,"cell.mp4",2:250;
framerate =1) do i
  iter[] = i
end

