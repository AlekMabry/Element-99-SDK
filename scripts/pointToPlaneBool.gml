//First 3 Arguments are plane point  x=arg0, y=arg1, z=arg2
//Second 3 Arguments are normal      x=arg3, y=arg4, z=arg5
//Third 3 Arguments are point        x=arg6, y=arg7, z=arg8

var vecDirection = vec3sub(argument2, argument0);
vecDirection = vec3norm(vecDirection);
var epsilon = vec3dot(vecDirection, argument1);
if (epsilon > 0.5) {
    return true;
} else {
    return false;
}
/**
if (((argument1[0]*(argument2[0]-argument0[0]))+(argument1[1]*(argument2[1]-argument0[1]))+(argument1[2]*(argument2[2]-argument0[2]))) > 0) {
    return true;
} else {
    return false;
}
**/


