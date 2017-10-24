%This function creates a triangular mesh with facets
%from separate polyhedra of truss members. It can be used
%to write a large mesh with facets for all truss members, but
%it is better to create meshes separately and write them to a file one by one
%to minimize the total size of the triangle vector triangle_mesh. 

%polyhedron_points are points on the truss member polyhedra.
%triangle_mesh is the triangular mesh connectivity of points polyhedron_points.
%endpoint_connectivity is the connectivity of the nodes in the wireframe from which the truss is defined.
%wireframe_points are the node coordinates of the nodes in the wireframe.
%diameter is the diameter of truss members.
%n is half the number of spherical points for each node of the truss.  

## Author: Luis <Luis@DESKTOP-I49GOFE>
## Created: 2017-08-11

function [ polyhedron_points , triangle_mesh ] = ThickenGraph ( endpoint_connectivity, wireframe_points, diameter, n )
  
  ns = 2 * n; %number of spherical points per wireframe node
  polyhedron_points = [];
  triangle_mesh = [];
  
  sphere_points=CreateSphere ( ns , diameter/2 , [0;0;0] ); %This creates approximately 
  %equidistant points on the surface of a sphere. These points will be repeated 
  %for each node of the wireframe. 
  %
  
  for n1 = 1:size( endpoint_connectivity,1 )
    
    Ps1 = sphere_points + wireframe_points( :,endpoint_connectivity( n1,1 ) );
    Ps2 = sphere_points + wireframe_points( :,endpoint_connectivity( n1,2 ) );
    this_polyhedron_points = [ Ps1 Ps2 ];
    this_polyhedron_triangles = ExtractHull( delaunay( this_polyhedron_points( 1,: ), this_polyhedron_points( 2,: ), this_polyhedron_points( 3,: ), 'Qt' ) );
                                
    this_polyhedron_triangles = OrientSphere( this_polyhedron_triangles, this_polyhedron_points, mean( [ wireframe_points( :,endpoint_connectivity( n1,2 ) ) wireframe_points( :,endpoint_connectivity( n1,1 ) ) ] , 2 ) );
    %This step is necessary to have correctly oriented triangles
    %in the resulting STL files.
    
    triangle_mesh = [ triangle_mesh ; this_polyhedron_triangles + size( polyhedron_points , 2 ) ];
    polyhedron_points = [ polyhedron_points this_polyhedron_points ];
    
  end

endfunction
