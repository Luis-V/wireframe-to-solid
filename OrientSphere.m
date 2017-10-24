%This function flips the order of the 2nd and 3rd indices of triangles whose
%points are on the surface of a sphere if their normal is oriented toward 
%the inside of the sphere. It can also work for convex polyedra that are not spherical.

%triangle_mesh is the list of triangle vertex indices.
%points are the coordinates of triangle vertices.
%centre is a point inside the polyhedron defined by the triangles in triangle_mesh.

## Author: Luis <Luis@DESKTOP-I49GOFE>
## Created: 2017-04-22

function [triangle_mesh] = OrientSphere( triangle_mesh , points , centre )
  
  for n1 = 1:size( triangle_mesh,1 )
    %a triangle on the surface of the input polyhedron.
    this_triangle_points = points( :,triangle_mesh( n1,: ) );
    d = this_triangle_points * [ -1 -1;eye( 2 ) ];
    circumcenter = this_triangle_points( :,1 ) + d/2 * inv( d'*d ) * sum( d'.*d' ,2 ); %This is the circumcenter of
    centre_to_circumcenter = circumcenter - centre;
    point1_to_point2 = this_triangle_points( :,2 ) - this_triangle_points( :,1 );
    point1_to_point3 = this_triangle_points( :,3 ) - this_triangle_points( :,1 );
    
    if ( point1_to_point3'*skew( point1_to_point2 )'*centre_to_circumcenter ) < 0 %skew means cross product.
      triangle_mesh( n1 , [ 2 3 ] ) = fliplr( triangle_mesh( n1,[ 2 3 ] ) );
    end
  end

endfunction
