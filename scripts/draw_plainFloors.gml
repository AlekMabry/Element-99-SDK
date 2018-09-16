//Draw the floors
var floorList = ds_map_find_value(global.mapData, "floors");
if (ds_list_empty(floorList)) {} else {
    var listSize = ds_list_size(floorList);
    for (var b = 0; b < listSize; b++) { 
        var current_floor = ds_list_find_value(floorList, b);
        draw_set_colour(c_white);
        //calculate texture
        var textureIndex = ds_map_find_value(global.texName, ds_map_find_value(current_floor, "texture"));
        var shaderType = ds_map_find_value(current_floor, "shader");
        switch (shaderType) {
            case "reflection":
                //var lightmapIndex = ds_map_find_value(global.lightmapName, ds_map_find_value(current_floor, "name"));
                //var lightmap_tex = background_get_texture(global.lightmaps[lightmapIndex])
                //init_reflectionLightmapped(current_floor, lightmap_tex);
                break;
                
            case "lightmapPlain":
                var lightmap_sampler = shader_get_sampler_index(shd_lightmapPlain, "lightmap");
                
                //Input lightmap sample
                var lightmapIndex = ds_map_find_value(global.lightmapName, ds_map_find_value(current_floor, "name"));
                var lightmap_tex = background_get_texture(global.lightmaps[lightmapIndex])
                texture_set_stage(lightmap_sampler, lightmap_tex);
                
                shader_set(shd_lightmapPlainClipped);
                
                //Input position, scale, and hrepeat vrepeat
                //------------Light Map Position-------------------------------------
                var vec2_lightmapPos;
                vec2_lightmapPos[0] = ds_map_find_value(current_floor, "mapPosX");
                vec2_lightmapPos[1] = ds_map_find_value(current_floor, "mapPosY");
                var params_lightmapPos = shader_get_uniform(shd_lightmapPlain, "lightmapPos");
                shader_set_uniform_f_array(params_lightmapPos, vec2_lightmapPos);
                //------------Light Map Scale----------------------------------------
                var vec2_lightmapScale;
                vec2_lightmapScale[0] = ds_map_find_value(current_floor, "mapScaleX");
                vec2_lightmapScale[1] = ds_map_find_value(current_floor, "mapScaleY");
                var params_lightmapScale = shader_get_uniform(shd_lightmapPlain, "lightmapScale");
                shader_set_uniform_f_array(params_lightmapScale, vec2_lightmapScale);
                //------------Light Map Repeat----------------------------------------
                var vec2_lightmapRepeat;
                vec2_lightmapRepeat[0] = ds_map_find_value(current_floor, "hrepeat");
                vec2_lightmapRepeat[1] = ds_map_find_value(current_floor, "vrepeat");
                var params_lightmapRepeat = shader_get_uniform(shd_lightmapPlain, "lightmapRepeat");
                shader_set_uniform_f_array(params_lightmapRepeat, vec2_lightmapRepeat);
                //------------Clip Height---------------------------------------------
                var params_clipheight = shader_get_uniform(shd_lightmapPlainClipped, "clipHeight");
                shader_set_uniform_f(params_clipheight, ds_map_find_value(current_floor, "z1"));
                
                break;
        }
        if (shaderType != "reflection") {
        d3d_draw_floor(
            ds_map_find_value(current_floor, "x1"),
            ds_map_find_value(current_floor, "y1"),
            ds_map_find_value(current_floor, "z1"),
            ds_map_find_value(current_floor, "x2"),
            ds_map_find_value(current_floor, "y2"),
            ds_map_find_value(current_floor, "z2"),
            background_get_texture(global.textures[textureIndex]),
            ds_map_find_value(current_floor, "hrepeat"),
            ds_map_find_value(current_floor, "vrepeat")
        );
        }
        shader_reset();
    }
}
