//Collisions are calculated with
//argument0 is AABB old
//argument1 is AABB
//argument2 is AABB map brush

return argument0[0] >= argument2[1] && // was not colliding
           argument1[0] < argument2[1];
