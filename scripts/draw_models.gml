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
        d3d_transform_set_identity();
        d3d_transform_add_rotation_z(ds_map_find_value(current_model, "rotationz"));
        d3d_transform_add_translation(
            ds_map_find_value(current_model, "x"),
            ds_map_find_value(current_model, "y"),
            ds_map_find_value(current_model, "z")
        );
        d3d_model_draw(global.models[modelIndex], 
            0, 0, 0,
            background_get_texture(global.textures[textureIndex]));
        d3d_transform_set_identity();
    }
}
