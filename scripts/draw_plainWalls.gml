//Draw the walls
var wallList = ds_map_find_value(global.mapData, "walls");
if (ds_list_empty(wallList)) {} else {
    var size = ds_list_size(wallList);
    for (var a = 0; a < size; a++) { 
        var current_wall = ds_list_find_value(wallList, a);
        draw_set_colour(c_white);
        //calculate texture
        var textureIndex = ds_map_find_value(global.texName, ds_map_find_value(current_wall, "texture"));
        var shaderType = ds_map_find_value(current_wall, "shader");
        switch (shaderType) {
            case "lightmapPlain":
                var lightmap_sampler = shader_get_sampler_index(shd_lightmapPlain, "lightmap");
                
                //Input lightmap sample
                var lightmapIndex = ds_map_find_value(global.lightmapName, ds_map_find_value(current_wall, "name"));
                var lightmap_tex = background_get_texture(global.lightmaps[lightmapIndex])
                texture_set_stage(lightmap_sampler, lightmap_tex);
                
                shader_set(shd_lightmapPlainClipped);
                
                //Input position, scale, and hrepeat vrepeat
                //------------Light Map Position-------------------------------------
                var vec2_lightmapPos;
                vec2_lightmapPos[0] = ds_map_find_value(current_wall, "mapPosX");
                vec2_lightmapPos[1] = ds_map_find_value(current_wall, "mapPosY");
                var params_lightmapPos = shader_get_uniform(shd_lightmapPlain, "lightmapPos");
                shader_set_uniform_f_array(params_lightmapPos, vec2_lightmapPos);
                //------------Light Map Scale----------------------------------------
                var vec2_lightmapScale;
                vec2_lightmapScale[0] = ds_map_find_value(current_wall, "mapScaleX");
                vec2_lightmapScale[1] = ds_map_find_value(current_wall, "mapScaleY");
                var params_lightmapScale = shader_get_uniform(shd_lightmapPlain, "lightmapScale");
                shader_set_uniform_f_array(params_lightmapScale, vec2_lightmapScale);
                //------------Light Map Repeat----------------------------------------
                var vec2_lightmapRepeat;
                vec2_lightmapRepeat[0] = ds_map_find_value(current_wall, "hrepeat");
                vec2_lightmapRepeat[1] = ds_map_find_value(current_wall, "vrepeat");
                var params_lightmapRepeat = shader_get_uniform(shd_lightmapPlain, "lightmapRepeat");
                shader_set_uniform_f_array(params_lightmapRepeat, vec2_lightmapRepeat);
                //------------Clip Height---------------------------------------------
                var params_clipheight = shader_get_uniform(shd_lightmapPlainClipped, "clipHeight");
                shader_set_uniform_f(params_clipheight, max(ds_map_find_value(current_wall, "z1"), ds_map_find_value(current_wall, "z2")));
                
                break;
        }
        d3d_draw_wall( 
            ds_map_find_value(current_wall, "x1"),
            ds_map_find_value(current_wall, "y1"),
            ds_map_find_value(current_wall, "z1"),
            ds_map_find_value(current_wall, "x2"),
            ds_map_find_value(current_wall, "y2"),
            ds_map_find_value(current_wall, "z2"),
            background_get_texture(global.textures[textureIndex]),
            ds_map_find_value(current_wall, "hrepeat"),
            ds_map_find_value(current_wall, "vrepeat")
        );
        shader_reset();
    }
}
