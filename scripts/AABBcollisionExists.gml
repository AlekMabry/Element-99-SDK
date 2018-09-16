//Argument 0 is AABB 1
//Argument 1 is AABB 2
//Argument 2 is AABB 1 OLD

//if (argument0[1] < argument1[0] or argument1[1] < argument0[0] or
//argument0[3] < argument1[2] or argument1[3] < argument0[2] or
//argument0[5] < argument1[4] or argument1[5] < argument0[4]) {
//    return false;
//} else {
//    return true;
//}

if (argument0[0] < argument1[1] && argument0[1] > argument1[0]
&& argument0[2] < argument1[3] && argument0[3] > argument1[2] &&
argument0[4] < argument1[5] && argument0[5] > argument1[4]) {
    return true;
} else {
    return false;
}

//var xCollide = argument0[0] < argument1[1] || argument0[1] > argument1[0];
//var yCollide = argument0[2] < argument1[3] || argument0[3] > argument1[2];
//var zCollide = argument0[4] < argument1[5] || argument0[5] > argument1[4];

//if (xCollide && yCollide && zCollide) {
//    return true;
//} else {
//    return false;
//}
