//argument0 is prevVelocity
//argument1 is accelDirection (normalized)
//argument2 is accelerate
//argument3 is max_velocity


var projVel = vec3dot(argument1, argument0); // Vector projection of Current velocity onto accelDir.
debug = abs(projVel);
var accelVel = argument2 * (0.0166); // Accelerated velocity in direction of movment
//the "(0.0166)" is the percentage of a second a step is

// If necessary, truncate the accelerated velocity so the vector projection does not exceed max_velocity
if(projVel + accelVel > (argument3*(0.0166))) {
    accelVel = (argument3*(0.0166)) - projVel;
}
//if (accelVel < 0) {
//    accelVel = 0;
//}

debug1 = accelVel;

addVector[0] = accelVel*argument0[0];
addVector[1] = accelVel*argument0[1];
addVector[2] = accelVel*argument0[2];

debug2 = addVector;

finalVector[0] = addVector[0]+argument1[0];
finalVector[1] = addVector[1]+argument1[1];
finalVector[2] = addVector[2]+argument1[2];

debug2 = argument0

return finalVector;
