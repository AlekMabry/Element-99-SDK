var wallList = ds_map_find_value(global.mapData, "walls");
if (ds_list_empty(wallList)) {} else {
    var listSize = ds_list_size(wallList);
    for (var b = 0; b < listSize; b++) { 
        var current_wall = ds_list_find_value(wallList, b);
        var currentTexture = ds_map_find_value(current_wall, "texture");
        if (!ds_map_exists(global.texName, currentTexture)) {
            if (directory_exists(directoryPath+"textures")) {
                if (file_exists(directoryPath+"textures\"+currentTexture)) {
                    global.textures[array_length_1d(global.textures)] = background_add(directoryPath+"textures\"+currentTexture, false, false);
                    ds_map_add(global.texName, currentTexture, (array_length_1d(global.textures)-1));
                } else {
                    ds_map_add(global.texName, currentTexture, 0);
                }
            } else {
                ds_map_add(global.texName, currentTexture, 0);
            }
        }
        if (ds_map_find_value(current_wall, "shader") == "lightmapPlain") {
            var currentLightmap = ds_map_find_value(current_wall, "name");
            var filename = directoryPath+"textures\lightmap_"+ds_map_find_value(current_wall, "name")+".png";
            if (file_exists(filename)) {
                global.lightmaps[array_length_1d(global.lightmaps)] = background_add(filename, false, false);
                ds_map_add(global.lightmapName, currentLightmap, (array_length_1d(global.lightmaps)-1));
            } else {
                ds_map_add(global.lightmapName, currentLightmap, 0);
            }
        }
    }
}

var floorList = ds_map_find_value(global.mapData, "floors");
if (ds_list_empty(floorList)) {} else {
    var listSize = ds_list_size(floorList);
    for (var b = 0; b < listSize; b++) { 
        var current_floor = ds_list_find_value(floorList, b);
        var currentTexture = ds_map_find_value(current_floor, "texture");
        if (!ds_map_exists(global.texName, currentTexture)) {
            if (directory_exists(directoryPath+"textures")) {
                if (file_exists(directoryPath+"textures\"+currentTexture)) {
                    global.textures[array_length_1d(global.textures)] = background_add(directoryPath+"textures\"+currentTexture, false, false);
                    ds_map_add(global.texName, currentTexture, (array_length_1d(global.textures)-1));
                } else {
                    ds_map_add(global.texName, currentTexture, 0);
                }
            } else {
                ds_map_add(global.texName, currentTexture, 0);
            }
        }
        if (ds_map_find_value(current_floor, "shader") == "lightmapPlain" or ds_map_find_value(current_floor, "shader") == "reflection") {
            var currentLightmap = ds_map_find_value(current_floor, "name");
            var filename = directoryPath+"textures\lightmap_"+ds_map_find_value(current_floor, "name")+".png";
            if (file_exists(filename)) {
                global.lightmaps[array_length_1d(global.lightmaps)] = background_add(filename, false, false);
                ds_map_add(global.lightmapName, currentLightmap, (array_length_1d(global.lightmaps)-1));
            } else {
                ds_map_add(global.lightmapName, currentLightmap, 0);
            }
        }
    }
}

var blockList = ds_map_find_value(global.mapData, "blocks");
if (ds_list_empty(blockList)) {} else {
    var listSize = ds_list_size(blockList);
    for (var b = 0; b < listSize; b++) { 
        var current_block = ds_list_find_value(blockList, b);
        var currentTexture = ds_map_find_value(current_block, "texture");
        var global.currentTexture = file_exists(directoryPath+"textures\"+currentTexture);
        if (!ds_map_exists(global.texName, currentTexture)) {
            if (directory_exists(directoryPath+"textures")) {
                if (file_exists(directoryPath+"textures\"+currentTexture)) {
                    global.textures[array_length_1d(global.textures)] = background_add(directoryPath+"textures\"+currentTexture, false, false);
                    ds_map_add(global.texName, currentTexture, (array_length_1d(global.textures)-1));
                } else {
                    ds_map_add(global.texName, currentTexture, 0);
                }
            } else {
                ds_map_add(global.texName, currentTexture, 0);
            }
        }
    }
}

var modelList = ds_map_find_value(global.mapData, "models");
if (ds_list_empty(modelList)) {} else {
    var listSize = ds_list_size(modelList);
    for (var b = 0; b < listSize; b++) { 
        var current_model = ds_list_find_value(modelList, b);
        var currentModel = ds_map_find_value(current_model, "texture");
        if (!ds_map_exists(global.texName, currentModel)) {
            if (directory_exists(directoryPath+"textures")) {
                if (file_exists(directoryPath+"textures\"+currentModel)) {
                    show_debug_message("Loading: "+currentModel);
                    global.textures[array_length_1d(global.textures)] = background_add(directoryPath+"textures\"+currentModel, false, false);
                    ds_map_add(global.texName, currentModel, (array_length_1d(global.textures)-1));
                } else {
                    ds_map_add(global.texName, currentModel, 0);
                }
            } else {
                ds_map_add(global.texName, currentModel, 0);
            }
        }
        if (ds_map_exists(current_model, "normal"))
        {
            var currentNormal = ds_map_find_value(current_model, "normal");
            if (!ds_map_exists(global.texName, currentNormal)) {
                if (directory_exists(directoryPath+"textures")) {
                    if (file_exists(directoryPath+"textures\"+currentNormal)) {
                        show_debug_message("Loading: "+currentNormal);
                        global.textures[array_length_1d(global.textures)] = background_add(directoryPath+"textures\"+currentNormal, false, false);
                        ds_map_add(global.texName, currentNormal, (array_length_1d(global.textures)-1));
                    } else {
                        ds_map_add(global.texName, currentNormal, 0);
                    }
                } else {
                    ds_map_add(global.texName, currentNormal, 0);
                }
            }
        }
        if (ds_map_exists(current_model, "material"))
        {
            var currentNormal = ds_map_find_value(current_model, "material");
            if (!ds_map_exists(global.texName, currentNormal)) {
                if (directory_exists(directoryPath+"textures")) {
                    if (file_exists(directoryPath+"textures\"+currentNormal)) {
                        show_debug_message("Loading: "+currentNormal);
                        global.textures[array_length_1d(global.textures)] = background_add(directoryPath+"textures\"+currentNormal, false, false);
                        ds_map_add(global.texName, currentNormal, (array_length_1d(global.textures)-1));
                    } else {
                        ds_map_add(global.texName, currentNormal, 0);
                    }
                } else {
                    ds_map_add(global.texName, currentNormal, 0);
                }
            }
        }
    }
}
