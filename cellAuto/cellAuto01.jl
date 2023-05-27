
using GLMakie, Random, Colors

function zpW(num::Int)    
  ncol = 101      # number of col.
  nrow =  200     
  locM = div(ncol,2)+1
  St = zeros(Int,ncol)
  spM = zeros(Int,nrow,ncol)
  St[locM] = 1 
  #nrow,ncol = size(spM)
  nextSt = zeros(Int,ncol)  
  d1 = digits(num,base=2,pad=8)
  d1 = reverse!(d1)
  for i in  1:nrow
      spM[i,:] = St
      perm=[[ii,jj,kk] for ii=0:1,jj=0:1,kk=0:1]                  
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

      #nextSt[1]   = mod(St[ncol] + St[1] + St[2],2)
      #nextSt[ncol]= mod(St[ncol-1] + St[ncol] + St[1],2)            

      St =deepcopy(nextSt)         
  end
  return spM 
end

iter = Observable(1)
data = @lift zpW($iter)

colormap_rgb = [RGB(0,0,0), RGB(1,0.8431,0)];

fig=heatmap(data,
    axis=(title=@lift("k=$($iter)"),
    ),colormap = colormap_rgb);
    
record(fig,"test.mp4",1:254;
framerate =1) do i
  iter[] = i
end



