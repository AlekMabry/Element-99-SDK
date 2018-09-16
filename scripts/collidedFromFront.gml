//Collisions are calculated with
//argument0 is AABB old
//argument1 is AABB
//argument2 is AABB map brush

return argument0[3] <= argument2[2] && // was not colliding
           argument1[3] > argument2[2];
