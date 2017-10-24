%This function creates a string in the following format:

%facet normal      0           0           0
%outer loop                                 
%vertex        3.401      3.7759      4.9536
%vertex       3.4093      3.6941      4.9638
%vertex        3.372      3.7345      4.9587
%endloop                                    
%endfacet                                   

%The numbers are determined from mesh_points, which are the coordinates of the nodes of
%a triangular mesh triangle_mesh

## Author: Luis <Luis@DESKTOP-I49GOFE>
## Created: 2017-10-17

function [main_string] = WriteSTL ( triangle_mesh , mesh_points )
  
  %The following instructions create a string vector in STL format
  triangles_times_7 = 7*size( triangle_mesh,1 );
  
  string1 = [ 'facet normal'; 'outer loop'; 'vertex'; 'vertex'; 'vertex' ;'endloop'; 'endfacet' ];
         
  string2 = [' ';' ';' ';' ';' ';' ';' '];
  
  for n2 = 1:( size( triangle_mesh,1 ) - 1 )
    string1 = [ string1; 'facet normal'; 'outer loop'; 'vertex'; 'vertex'; 'vertex'; 'endloop'; 'endfacet' ];
           
    string2 = [ string2;' ';' ';' ';' ';' ';' ';' ' ];
  end
  
  numbers = zeros( triangles_times_7,3 );
  numbers( 3:7:triangles_times_7 , : ) = mesh_points( :, triangle_mesh( :,1 ) )';
  numbers( 4:7:triangles_times_7 , : ) = mesh_points( :, triangle_mesh( :,2 ) )';
  numbers( 5:7:triangles_times_7 , : ) = mesh_points( :, triangle_mesh( :,3 ) )';
  numbers = num2str( numbers );
  numbers( 2:7:triangles_times_7 , : ) = [' '];
  numbers( 6:7:triangles_times_7 , : ) = [' '];
  numbers( 7:7:triangles_times_7 , : ) = [' '];
  numbers = num2str( numbers );
  
  main_string = [ string1 string2 numbers ];
  
endfunction