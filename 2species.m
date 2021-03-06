close all; clear all; clc; format short 
 
set_phcpath('XX/phc');    % Set your path here to locate your phc exec file

%below we set all the variables and parameters

syms N1 N2 r1 r2 a11 a12 a21 a22 b1 b2 
 
      count = 0; 
      
sims = 1000;  % number of calculations
 
 
 for k = 1 : sims  % set generic ranges. You can also keep some parameters fixed.
 
     k 
     
     mag = 2*sqrt(3);
     
        r1 = mag*(rand-0.5);
        r2 = mag*(rand-0.5);
        a11 = mag*(rand-0.5);
        a12 = mag*(rand-0.5);
        a21 = mag*(rand-0.5);
        a22 = mag*(rand-0.5);
        b1  = mag*(rand-0.5);
        b2  = mag*(rand-0.5);
        

 
eqn =[r1 + a11*N1 + a12*N2 + b1*N1*N2 ; ...
          r2 + a21*N1 + a22*N2 + b2*N1*N2];  % you dont need this - this is the systems of equations to solve (each line = 0)

% below we specify the system to solve, see eqn above, in polytope format (N1,N2,N3)        
      
MM = [r1,  0, 0; ...
      a11, 1, 0; ...
      a12, 0, 1; ...
      b1,  1, 1; ...
      0,   0, 0; ...
      r2,  0, 0; ...
      a21, 1, 0; ...
      a22, 0, 1; ...
      b2,  1, 1; ...
      0,   0, 0];    
  
make_system(MM); % shows symbolic format of the system
s = solve_system(MM); % call the blackbox solver
ns = size(s,2); % check the number of solutions
 
X = [s.x1; s.x2]; 
check = 0;
 
for i = 1:size(X,2)
    
    
if (real(X(1,i)) > 0 && real(X(2,i)) > 0 && ... 
    imag(X(1,i)) < 10^-20 && imag(X(2,i)) < 10^-20)
 
    check = 1;
    
end
 
    
end
 
count = count + check;
 
 end
 
feasibile_2 = count / sims  % probability of feasibility
ns % number of equilibrium points