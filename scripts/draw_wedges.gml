//Draw the walls
var wedgeList = ds_map_find_value(global.mapData, "wedges");
if (ds_list_empty(wedgeList)) {} else {
    var size = ds_list_size(wedgeList);
    for (var a = 0; a < size; a++) { 
        var current_wedge = ds_list_find_value(wedgeList, a);
        draw_set_colour(c_white);
        
        //calculate texture
        var textureIndex1 = ds_map_find_value(global.texName, ds_map_find_value(current_wedge, "texture1"));
        var textureIndex2 = ds_map_find_value(global.texName, ds_map_find_value(current_wedge, "texture2"));
        var angle = ds_map_find_value(current_wedge, "angle");
        var orientation = ds_map_find_value(current_wedge, "orientation");
        var x1 = ds_map_find_value(current_wedge, "x1"),
        var y1 = ds_map_find_value(current_wedge, "y1"),
        var z1 = ds_map_find_value(current_wedge, "z1"),
        var x2 = ds_map_find_value(current_wedge, "x2"),
        var y2 = ds_map_find_value(current_wedge, "y2"),
        var z2 = ds_map_find_value(current_wedge, "z2"),
        //Orientation 0 is upright
        //Orientation 1 is sloped positively
        //Orientation 2 is sloped Negatively
        //Bottom left to top right is default angle of 0
        
        /** UPRIGHT WEDGE DRAWN **/
        if (orientation == 0) {
            if (angle == 0) {
                //Draw Top
                d3d_draw_wall(min(x1, x2), max(y1, y2), z1, max(x1, x2), max(y1, y2), z2, 
                    background_get_texture(global.textures[textureIndex1]),
                    ds_map_find_value(current_wedge, "hrepeat1"),
                    ds_map_find_value(current_wedge, "vrepeat1")
                );
                //Draw Left
                d3d_draw_wall(min(x1, x2), min(y1, y2), z1, min(x1, x2), max(y1, y2), z2, 
                    background_get_texture(global.textures[textureIndex1]),
                    ds_map_find_value(current_wedge, "hrepeat1"),
                    ds_map_find_value(current_wedge, "vrepeat1")
                );
                //Draw Angle
                d3d_draw_wall(min(x1, x2), min(y1, y2), z1, max(x1, x2), max(y1, y2), z2, 
                    background_get_texture(global.textures[textureIndex1]),
                    ds_map_find_value(current_wedge, "hrepeat1"),
                    ds_map_find_value(current_wedge, "vrepeat1")
                );
                //Draw Top
                
            }
        }
    }
}
