//Vars here:
// global.models contains actual model files
// global.modelName contains the name of said model in that array. This is used for json parsing by the renderer.

var modelList = ds_map_find_value(global.mapData, "models");
if (ds_list_empty(modelList)) {} else {
    var listSize = ds_list_size(modelList);
    for (var b = 0; b < listSize; b++) { 
        var current_model = ds_list_find_value(modelList, b);
        var currentModel = ds_map_find_value(current_model, "model");
        ext = filename_ext(currentModel);
        global.debugString = currentModel;
        if (!ds_map_exists(global.modelName, currentModel)) {
            if (directory_exists(directoryPath+"models")) {
                if (file_exists(directoryPath+"models\"+currentModel)) {
                    var TemporaryModelLoader;
                    switch (ext) {
                        case ".d3d":
                            TemporaryModelLoader = d3d_model_create();
                            d3d_model_load(TemporaryModelLoader, directoryPath+"models\"+currentModel);
                            global.modelTypes[array_length_1d(global.modelTypes)] = 0;
                            break;
                        case ".E99":
                            TemporaryModelLoader = LoadE99(directoryPath+"models\"+currentModel);
                            global.modelTypes[array_length_1d(global.modelTypes)] = 1;
                            break
                    }
                    global.models[array_length_1d(global.models)] = TemporaryModelLoader;
                    ds_map_add(global.modelName, currentModel, (array_length_1d(global.models)-1));    
                } else {
                    ds_map_add(global.modelName, currentModel, 0);
                }
            } else {
                ds_map_add(global.modelName, currentModel, 0);
            }
        }
    }
}
