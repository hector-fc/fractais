using Colors, Plots 


function mandelbrot(c,maxiter)
  z = c 
  for n in 1:maxiter
    if abs(z)>2
      return (n/maxiter)
    end 
    z = z^2 + c  
  end
  return 0.0
end


function julia(z,maxiter)
  c =  0.355534-0.33729im 
  for n in 1:maxiter
    if abs(z)>2
      return 0# - exp(-n/maxiter)
    end 
    z = z^(2) + c  
  end
  return 1 - exp(-abs(z))
end

function  fractal_set(xmin=-2, xmax = 2,
                      ymin=-2, ymax = 2,
                      width = 300,height=300,
                      maxiter=64)
  r1 = range(xmin,xmax,length = width)
  r2 = range(xmin,xmax,length = height)                      
  n3 = zeros(Float32,width, height)
  for i in 1:width
    for j in 1:height
        n3[i,j] = mandelbrot(r1[i] + r2[j]*im,maxiter)
#      n3[i,j] = julia(r1[i] + r2[j]*im,maxiter)
    end  
  end   
  return (r1,r2,n3)
end

(plotx, ploty,plotz)= fractal_set()
fig=heatmap(plotx,
            ploty,plotz',
            c=cgrad( [:red, :yellow], [0.1, 0.3, 0.8],scale=:exp),
            colorbar=false);

#=
fig=contour(plotx,
            ploty,
            plotz',
            fill=true,
            colorbar=false);
=#
fig
#savefig(fig,"julia.svg")  # pdf, ssvg 
#c=cgrad([:orange, :red], [0.1, 0.3, 0.8]),
#c=cgrad(:thermal, rev = true),
