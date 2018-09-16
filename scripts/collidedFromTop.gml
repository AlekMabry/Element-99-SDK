//Collisions are calculated with
//argument0 is AABB old
//argument1 is AABB
//argument2 is AABB map brush

return argument0[4] >= argument2[5] && // was not colliding
           argument1[4] < argument2[5];
