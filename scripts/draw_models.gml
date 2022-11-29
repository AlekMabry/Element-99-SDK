//Draw the floors
var modelList = ds_map_find_value(global.mapData, "models");
if (ds_list_empty(modelList)) {} else {
    var listSize = ds_list_size(modelList);
    for (var b = 0; b < listSize; b++) { 
        var current_model = ds_list_find_value(modelList, b);
        draw_set_colour(c_white);
        //calculate texture
        var textureIndex = ds_map_find_value(global.texName, ds_map_find_value(current_model, "texture"));
        var modelIndex = ds_map_find_value(global.modelName, ds_map_find_value(current_model, "model"));
        /* Transform */
        d3d_transform_set_identity();
        d3d_transform_add_rotation_x(ds_map_find_value(current_model, "rotationx"));
        d3d_transform_add_rotation_y(ds_map_find_value(current_model, "rotationy"));
        d3d_transform_add_rotation_z(ds_map_find_value(current_model, "rotationz"));
        d3d_transform_add_translation(
            ds_map_find_value(current_model, "x"),
            ds_map_find_value(current_model, "y"),
            ds_map_find_value(current_model, "z")
        );
        var shaderType = ds_map_find_value(current_model, "shader");
        switch (shaderType) {
            case "pbr":
                shader_set(shd_pbr);
                /* Lighting Uniforms */
                var shader_params = shader_get_uniform(shd_pbr, "u_LightCol");
                shader_set_uniform_f_array(shader_params, ds_map_find_value(global.lights, "col"));
                shader_params = shader_get_uniform(shd_pbr, "u_LightPos");
                shader_set_uniform_f_array(shader_params, ds_map_find_value(global.lights, "pos"));
                shader_params = shader_get_uniform(shd_pbr, "u_LightAttr");
                shader_set_uniform_f_array(shader_params, ds_map_find_value(global.lights, "attr"));
                shader_params = shader_get_uniform(shd_pbr, "u_CameraPos");
                var camPos;
                camPos[0] = obj_player.x;
                camPos[1] = obj_player.y;
                camPos[2] = obj_player.z + obj_player.cameraZ;
                shader_set_uniform_f_array(shader_params, camPos);
                /* Normals and Material */
                texture_set_stage(global.tex_Albedo, background_get_texture(global.textures[textureIndex]))
                var normalIndex = ds_map_find_value(global.texName, ds_map_find_value(current_model, "normal"));
                texture_set_stage(global.tex_Normal, background_get_texture(global.textures[normalIndex]))
                var materialIndex = ds_map_find_value(global.texName, ds_map_find_value(current_model, "material"));
                texture_set_stage(global.tex_Material, background_get_texture(global.textures[materialIndex]))
                if (surface_exists(global.cubemap[0]))
                {
                    var tex_Cubemap = shader_get_sampler_index(shd_pbr, "tex_Cubemap");
                    texture_set_stage(tex_Cubemap, surface_get_texture(global.cubemap[0]));
                }
                break;
            case "cubemap":
                if (surface_exists(global.cubemap[0]))
                {
                    shader_set(shd_cubemap);
                    var shader_params = shader_get_uniform(shd_cubemap, "u_CameraPos");
                    var camPos;
                    camPos[0] = obj_player.x;
                    camPos[1] = obj_player.y;
                    camPos[2] = obj_player.z + obj_player.cameraZ;
                    shader_set_uniform_f_array(shader_params, camPos);
                    /* Cubemap */
                    var tex_Cubemap = shader_get_sampler_index(shd_cubemap, "tex_Cubemap");
                    texture_set_stage(tex_Cubemap, surface_get_texture(global.cubemap[0]));
                }
        }
        switch (global.modelTypes[modelIndex])
        {
            case 0:
                d3d_model_draw(global.models[modelIndex], 0, 0, 0, -1);
                break;
                
            case 1:
                vertex_submit(global.models[modelIndex], pr_trianglelist, -1);
                break;
        }
        d3d_transform_set_identity();
        shader_reset();
    }
}
