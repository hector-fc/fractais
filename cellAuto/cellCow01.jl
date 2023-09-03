
using Random
using  Colors
using GLMakie

function _get(A::Matrix{T}, i::Int, j::Int)::T where T<:Number
  r,c = size(A)
  if (1<=i<=r) && (1<=j<=c)
      return @inbounds A[i,j]
  end    
  i = mod(i,r)
  j = mod(j,c)
  if i==0
      i=r
  end
  if j==0
      j=c
  end
  return @inbounds A[i,j]
end


function new_entry(A::Matrix{Int},i::Int,j::Int)
  nc = sum(_get(A,p,q) for p=i-1:i+1 for q=j-1:j+1 if (p,q) != (i,j))
  if A[i,j]==0
      if nc==3
          return 1
      else
          return 0
      end
  end
  if nc==2 || nc==3
      return 1
  else
      return 0
  end
end


function nextEv2D(A::Matrix{Int})::Matrix{Int}
  r,c = size(A)
  B = zeros(Int,r,c)
  for i=1:r
      for j=1:c
          @inbounds B[i,j] = new_entry(A,i,j)
      end
  end
  return B
end

function numSt(num::Int) 
  rng = MersenneTwister(17)
  ncol = 100
  nrow = ncol
  ev2D = zeros(Int,nrow,ncol)
  
  loc = div(ncol,2)
  #ev2D[loc-2:loc+2,loc-2:loc+2] = Int.(bitrand(rng,5,5))      
  #ev2D = Int.(bitrand(rng,ncol,ncol)) 
  #ev2D[90:110,90:110] = Int.(bitrand(rng,21,21))
  #ev2D[50:150,70] .= 1  

  for i in 1:ncol 
    for j in 1:nrow
        dist =  abs(i-50)^2 + abs(j-50)^2 
        if dist <= 10
            ev2D[i,j] = mod(rand(1:10),2)
        end 
    end 
  end
  
  for i=1:num
     nextev2D = (nextEv2D(ev2D))
     ev2D =copy(nextev2D)
  end

 return ev2D         
end 


#mosaic( 
#heatmap(numSt(1))

iter = Observable(1)
data = @lift numSt($iter)

colormap_rgb = [RGB(0,0,0), RGB(1,0.8431,0)];

fig=heatmap(data,
    axis=(title=@lift("k=$($iter)"),
    ),colormap = colormap_rgb);

record(fig,"cow01.mp4",1:50;
framerate = 1) do i
  iter[] = i
end





#Gray.(numSt(2)), 
#Gray.(numSt(100)), 
#Gray.(numSt(500)); 
#  fillvalue =1, 
#  npad=10, 
#  nrow=1)

