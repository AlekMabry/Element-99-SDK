//Collisions are calculated with
//argument0 is AABB old
//argument1 is AABB
//argument2 is AABB map brush

return argument0[5] <= argument2[4] && // was not colliding
           argument1[5] > argument2[4];
