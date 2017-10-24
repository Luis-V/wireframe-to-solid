# wireframe-to-solid

These functions and scripts convert a line segment graph into a solid truss with approximately cylindrical members.
The input segment graph in this example is created in the script CreateSeahorse.
These scripts and functions are listed as a MATLAB documents, but there may be a few commands that only work in Octave, 
especially commmands that involve the addition of mXn matrices with mX1 vectors. Octave automatically expands
mX1 vectors along the second dimension when adding to a mXn matrix, but MATLAB does not. 
