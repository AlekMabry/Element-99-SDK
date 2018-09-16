///Calculate Collisions and Correct Velocities and Position
///Displace your prop without editing it's velocity first. This then corrects velocity and displacement if a collision has been found
///Simply run this in your movement loop with no arguments

var correctionShift;
correctionShift[0] = 0; //x
correctionShift[1] = 0; //y
correctionShift[2] = 0; //z

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
        
        //check for collisions under prop
        if ((collisionBox[4]+z) < z2 && (collisionBox[5]+z) > z1) {
            correctionShift[2] = z2-(z+collisionBox[4]);
            z = correctionShift[2];
            velocity[2] = 0;
            
            if (velocity[0] >= 0.2) {
                velocity[0] -= 0.2;
            } else {
                velocity[0] = 0;
            }
            
            if (velocity[1] >= 0.2) {
                velocity[1] -= 0.2;
            } else {
                velocity[1] = 0;
            }
        }
    }
}
