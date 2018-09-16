//Collisions are calculated with
//argument0 is AABB old
//argument1 is AABB
//argument2 is AABB map brush

return argument0[2] >= argument2[3] && // was not colliding
           argument1[2] < argument2[3];
