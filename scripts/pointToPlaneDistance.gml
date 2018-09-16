//First Argument is Plane Point
//Second Argument is Normal
//Third Argument is the Point

var d = -(argument1[0]*argument0[0])-(argument1[1]*argument0[1])-(argument1[2]*argument0[2]);
var top = abs( (argument1[0]*argument2[0])+(argument1[1]*argument2[1])+(argument1[2]*argument2[2])+d );
var bottom = vec3mag(argument1);

return top/bottom;
