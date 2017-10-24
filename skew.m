%This function computes the antisymmetric matrix of a column vector.

## Author: Luis <Luis@DESKTOP-I49GOFE>
## Created: 2017-04-22

function [ antisymmetric_matrix ] = skew ( column_vector )
  
  if size( column_vector,1 ) == 3
    antisymmetric_matrix = [ 0 -column_vector(3) column_vector(2); column_vector(3) 0 -column_vector(1); -column_vector(2) column_vector(1) 0 ];
  end
  
  if size( column_vector,1 ) == 2
    antisymmetric_matrix = [ 0 -column_vector(2); column_vector(1) 0 ];
  end

endfunction
