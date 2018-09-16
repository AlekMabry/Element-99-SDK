//argument0 is a vec3 point
//argument1 is an AABB

if (argument0[0] < argument1[1] && argument0[0] > argument1[0] &&
    argument0[1] < argument1[3] && argument0[1] > argument1[2] &&
    argument0[2] < argument1[5] && argument0[2] > argument1[4]) {
        return true;
    } else {
        return false;
    }
