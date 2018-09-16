//Script takes in:
//arg0 - x1
//arg1 - y1
//arg2 - z1
//arg3 - x2
//arg4 - y2
//arg5 - z2

var returnAABB;

returnAABB[0] = min(argument0, argument3);
returnAABB[1] = max(argument0, argument3);
returnAABB[2] = min(argument1, argument4);
returnAABB[3] = max(argument1, argument4);
returnAABB[4] = min(argument2, argument5);
returnAABB[5] = max(argument2, argument5);

return returnAABB;
