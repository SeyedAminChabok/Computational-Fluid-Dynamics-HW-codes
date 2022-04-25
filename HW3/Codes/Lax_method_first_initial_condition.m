clc, clear, close all ;

%% first initial conditions 
    
dts=[0.00050,0.00025,0.00020,0.00010];
for i = 1 : length(dts)
    
  dt = dts(i) ;
  nt = 1000 ;
    
  L = 1.0 ;
  dx = L/50.0 ;
  dxx = 2.0*dx ;
  a = 0.5 ;
  x = 0.0 : dx : L ;
  nx = length(x) ;
  
  u = zeros(nx,1) ;
  u0 = zeros(nx,1) ;
   
  CFL = [a*dts(1)/dx, a*dts(2)/dx, a*dts(3)/dx, a*dts(4)/dx] ;
  
  %% initial condition
  for ix = 1 : nx
      if (x(ix)>=0.0 && x(ix)<0.25)
          u(ix) = 1.0 ;
      else 
          u(ix) = 0.0 ;
      end
  end
  
  for it = 1 : nt
      for ix = 2 : nx-1
          % Lax method 
          %u(ix) = 0.5*(u(ix+1) + u(ix-1)) - a*dt*(u(ix+1) - u(ix-1))/dxx ;
          % FTCS method
           u(ix) = u(ix) - dt*a*(u(ix+1)-u(ix-1))/dx ; 
      end
      
  for ix = 1 : nx
      if (x(ix)>=0.0 && x(ix)<0.25)
          u_exact(ix) = 1.0 ;
      else 
          u_exact(ix) = 0.0 ;
      end
  end
      
  end
  
    hold on
    grid on
    plot (x,u,'-s','linewidth',1.1)
    xlabel x
    ylabel u
    title 'Lax Method(first initial condition)'
  
end
plot(x,u_exact,'-.k','linewidth',1.5)
legend('CFL = 0.0125','CFL = 0.00625','CFL = 0.005','CFL = 0.0025', 'Exact') 

   for ix = 1 : nx
       error(ix) = abs(u(ix)-u_exact(ix)) ;
     fprintf('\n x: %f  Numerical u: %f  Analytical u: %f Error: %f \n', x(ix), u(ix), u_exact(ix), error(ix))
   end

