%main script in Octave for turning a wireframe design into a polyhedral truss.
%The file nonmanifold.stl is written to create a 3D object formed from the superposition
%of the polyhedral meshes formed independently for each member of the truss.
%The files frame n1 .stl are written for each member of the truss.
%The file unionoflinkage.scad is written to be read with OpenSCAD. With this file,
%the files frame n1.stl are imported into OpenSCAD, and the Boolean union of
%the polyhedron of each member in the truss is computed. 

clear

CreateSeahorse%This script creates x, y, and z coordinates of the nodes of a wireframe,
%and defines the connectivity between wireframe nodes with a vector L of segment indices.

diameter = .2; %Approximate diameter of the members of the resulting truss. 
n = 20; %Half the number of spherical points for each endpoint of the wireframe.

fid1 = fopen('nonmanifold.stl' , 'w'); %Establishes the file for writing 
%the non manifold truss.
fprintf( fid1, ['solid nonmanifold' "\r\n"] ); %Header of the non manifold truss STL file.

for n1 = 1:size( endpoint_connectivity,1 ) %For each segment defined by the endpoint vector:
  
  %Generate a triangular mesh for each segment in the endpoint vector:
  [ mesh_points , triangle_mesh ] = ThickenGraph ( endpoint_connectivity( n1,: ), points, diameter, n); 
   
  %Create the body of the STL file for this truss polyhedron.
  [main_string] = WriteSTL( triangle_mesh , mesh_points ); 
  
  %Create an independent file for each beam polyhedron.
  fid2 = fopen(['frame' num2str(n1) '.stl'] , 'w');
  fprintf( fid2, ['solid frame' num2str(n1) "\r\n"] );%Header of this beam polyhedron.
  for n2 = 1:size( main_string,1 )
    %Write the STL data of this polyhedron to an independent STL and also
    %the STL of the superposition of all polyhedra.
    fprintf( fid1, [ main_string( n2,: ) "\r\n" ] );
    fprintf( fid2, [ main_string( n2,: ) "\r\n" ] );
  end
  fprintf( fid2, ['endsolid frame' num2str(n1)] );%Footer of this beam polyhedron.
  fclose(fid2);
  
end
fprintf( fid1, 'endsolid nonmanifold' );%Footer of the STL file of the superposition
                                        %of all polyhedra.
fclose(fid1);

%The following instructions create an OpenSCAD file that imports the individual 
%STL files of each independent polyhedron of the input wireframe and computes their union.

%The render() function in OpenSCAD executes the mathematical operations invoked
%in the command line, which takes a long time for complex models, and is not necessary for
%previewing the model.

%string1 = [ 'render() rotate([90, 0, 0]) union()';'{' ]; 

string1 = [ 'rotate([90, 0, 0]) union()';'{' ];
string2 = [];

for n1 = 1:size( endpoint_connectivity,1 )
  
  string2 = [ string2; ['import("C:' '\\' '\\' 'Users' '\\' '\\' 'Luis' '\\' '\\' 'Documents' '\\' '\\' 'Portfolio' '\\' '\\' 'graphtotruss' '\\' '\\' 'frame' num2str(n1) '.stl");' ] ];
end

string3 = [ '}' ];
main_string = [ string1 ; string2 ; string3 ];

%%The following instructions write the previously created text to an OpenScad file.
fid = fopen( 'unionoflinkage.scad' , 'w' );
for n1 = 1:size( main_string , 1 )
  fprintf( fid, [ main_string( n1,: ) "\r\n" ] );
end
fclose( fid );