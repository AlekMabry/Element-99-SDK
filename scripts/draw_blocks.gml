//Draw the floors
var blockList = ds_map_find_value(global.mapData, "blocks");
if (ds_list_empty(blockList)) {} else {
    var listSize = ds_list_size(blockList);
    for (var b = 0; b < listSize; b++) { 
        var current_block = ds_list_find_value(blockList, b);
        draw_set_colour(c_white);
        //calculate texture
        var textureIndex = ds_map_find_value(global.texName, ds_map_find_value(current_block, "texture"));
        d3d_draw_block( 
            ds_map_find_value(current_block, "x1"),
            ds_map_find_value(current_block, "y1"),
            ds_map_find_value(current_block, "z1"),
            ds_map_find_value(current_block, "x2"),
            ds_map_find_value(current_block, "y2"),
            ds_map_find_value(current_block, "z2"),
            background_get_texture(global.textures[textureIndex]),
            ds_map_find_value(current_block, "hrepeat"),
            ds_map_find_value(current_block, "vrepeat")
        );
    }
}
