//Takes in the AABB data type and makes a bunch of points from each corner for collisions

var AABBpoints;

AABBpoints[0, 0] = argument0[0]; //min x
AABBpoints[0, 1] = argument0[2]; //min y
AABBpoints[0, 2] = argument0[4]; //min z

AABBpoints[1, 0] = argument0[0]; //min x
AABBpoints[1, 1] = argument0[3]; //max y
AABBpoints[1, 2] = argument0[4]; //min z

AABBpoints[2, 0] = argument0[1]; //max x
AABBpoints[2, 1] = argument0[2]; //min y
AABBpoints[2, 2] = argument0[4]; //min z

AABBpoints[3, 0] = argument0[1]; //max x
AABBpoints[3, 1] = argument0[3]; //max y
AABBpoints[3, 2] = argument0[4]; //min z

return AABBpoints;
