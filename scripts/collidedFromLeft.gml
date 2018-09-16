//Collisions are calculated with
//argument0 is AABB old
//argument1 is AABB
//argument2 is AABB map brush

return argument0[1] <= argument2[0] && // was not colliding
           argument1[1] > argument2[0];
