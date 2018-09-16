//arg0 is playerx
//arg1 is playery
//arg2 is playerz
//arg3 is player radius, usually 16

var floorCollisionZ = -666;
cycles = 0;

var testPointX;
var testPointY;
var number = 0;
for (var a = 0; a < 2; a += 0.25) {
    for (var b = 0; b < argument3; b += 8) {
        testPointX[number] = argument0+(b*cos(a));
        testPointY[number] = argument1-(b*sin(a));
        number += 1;
    }
}

var blockList = ds_map_find_value(global.mapData, "collisionblocks");
if (ds_list_empty(blockList)) {} else {
    var listSize = ds_list_size(blockList);
    for (var b = 0; b < listSize; b++) { 
        var current_block = ds_list_find_value(blockList, b);
        var x1 = ds_map_find_value(current_block, "x1");
        var y1 = ds_map_find_value(current_block, "y1");
        var z1 = ds_map_find_value(current_block, "z1");
        var x2 = ds_map_find_value(current_block, "x2");
        var y2 = ds_map_find_value(current_block, "y2");
        var z2 = ds_map_find_value(current_block, "z2");
        
        for (var i = 0; i < array_length_1d(testPointX); i++) {
            if (testPointX[i] < max(x1, x2) && testPointX[i] > min(x1, x2) && testPointY[i] < max(y1, y2) && testPointY[i] > min(y1, y2)) {
                if (argument2 <= max(z1, z2) && argument2 >= min(z1, z2)) {
                    if (floorCollisionZ < max(z1, z2)) {
                        floorCollisionZ = max(z1, z2);
                    }
                }
            }
        }
    }
}

cycles = z2
if (floorCollisionZ == -666) {
    return -1;
} else {
    return floorCollisionZ;
}
