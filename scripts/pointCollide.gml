//arg0 is boundingbox
//arg1 is pointx
//arg2 is pointy
//arg3 is pointz
//arg4 is objectx
//arg5 is objecty
//arg6 is objectz

var collisionNormal;
collisionNormal[0] = 0;
collisionNormal[1] = 0;
collisionNormal[2] = 0;

if (argument1 >= (argument0[0]+argument4) && argument1 <= (argument0[1]+argument4)) {
    if (argument2 >= (argument0[2]+argument5) && argument2 <= (argument0[3]+argument5)) {
        if (argument3 >= (argument0[4]+argument6) && argument3 <= (argument0[5]+argument6)) {
            collisionNormal[0] = argument4-argument1;
            collisionNormal[1] = argument5-argument2;
            collisionNormal[2] = argument6-argument3;
            return collisionNormal;
        }
    }
}

return -1;
