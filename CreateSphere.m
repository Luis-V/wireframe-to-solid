%This function creates a vector of n-1 approximately equidistant
%point coordinates along the surface of a sphere centered at centre. 

## Author: Luis <Luis@DESKTOP-I49GOFE>
## Created: 2017-08-11

function [ points ] = CreateSphere ( n , radius , centre )
  
  xi( [ 1 n ] ) = 0;
  theta( [ 1 n ] ) = 0;
  phi( [ 1 n ] ) = 0;
  k = 2:( n-1 );
  
  for k = 2:( n - 1 )
    xi( k ) = 2 * ( k - 1 ) / ( n - 1 ) - 1;
    theta( k ) =acos( xi( k ) );
    phi( k ) = mod( phi( k - 1 ) + 4/( n^.5 )/( ( 1-xi( k ) ^2)^.5 ), 2*pi );
  end
  
  xi(1) = [];
  theta(1) = [];
  phi(1) = [];
  
  angular_coordinates = [ cos(phi).*sin(theta); sin(phi).*sin(theta); cos(theta) ];
  
  points = radius*[angular_coordinates zeros(3,1)] + centre;

endfunction
