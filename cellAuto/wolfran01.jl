
using Random
using Colors
using GLMakie

function TransitionFunction(A::Matrix{Int},
                            i::Int,
                            n::Int)
  nrow, ncol = size(A)
  nextSt = zeros(Int,ncol)
  num = n
  St = A[i,:] 
  d1 = digits(num,base=2,pad=8)
  d1 = reverse!(d1)

  perm = [[ii,jj,kk] for ii=0:1,jj=0:1,kk=0:1]
   
  for j in 2:ncol-1
    for ip in 1:8
      if St[j-1:j+1] == perm[ip] 
        nextSt[j] = d1[ip]
      end
    end    
  end        

  for ip in 1:8
    if  [St[ncol],St[1],St[2]] == perm[ip] 
        nextSt[1] = d1[ip]
    end
    if  [St[ncol],St[ncol],St[1]] == perm[ip] 
      nextSt[ncol] = d1[ip]
    end
  end  

  #A[i+1,:]= nextSt   
  return nextSt
end


function nextEv2D(A::Matrix{Int},
                  i::Int,
                  n::Int)
  r,c = size(A)
  B = zeros(Int,r,c)
  @inbounds B[i,:] = TransitionFunction(A,i-1,n)    
  return B
end


function numSt(num::Int,
               n::Int) 

  ncol = 100
  nrow = ncol
  ev2D = zeros(Int,nrow,ncol)    
  locM = div(ncol,2)+1
  #ev2D[1,locM] = 1 
  for i in 1:ncol 
    ev2D[1,i] = mod(rand(1:100),2)
  end  


  if num==1    
    return ev2D
  end 

  for i=2:num
     nextev2D = nextEv2D(ev2D,i,n)
     ev2D =deepcopy(nextev2D)
  end    
  return ev2D         
end 


function videoC(n::Int) 
  iter = Observable(1)
  data = @lift numSt($iter,n)

  colormap_rgb = [RGB(0,0,0), RGB(1,0.8431,0)];

  fig=heatmap(data,
  axis=(title=@lift("k=$($iter)"),
  ),colormap = colormap_rgb);

  record(fig,"wolf01.mp4",1:90;
    framerate = 5) do i
    iter[] = i
  end
end


#################

videoC(46)

