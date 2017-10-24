%This function extracts the hull of a mesh of simplices.

## Author: Luis <Luis@DESKTOP-I49GOFE>
## Created: 2017-04-21

function [ hull ] = ExtractHull ( simplicial_mesh )
  
  hull = [];%This will be a list of n-1 dimensional faces of each simplex. 
  
  if size( simplicial_mesh , 1 ) > 0
    dimensionality = size( simplicial_mesh , 2 ) - 1; %This is the dimensionality of the points.
    facet_index = 1 : ( dimensionality + 1 );
    
    for n1 = 1 : ( dimensionality + 1 )
      
      hull = [hull; 
                sort(simplicial_mesh( : , facet_index( facet_index ~= n1 ) ) , 2)];
    end
    
    hull = sortrows( hull );
    DIFF = [ sum( [ abs( diff( hull ) ) ; ones( 1 , dimensionality ) ] , 2 ) hull ];
    index1 = find( DIFF( : , 1 ) == 0 );
    index2 = index1 + 1;
    hull( [ index1 index2 ] , : ) = [];
  
  end
  
endfunction