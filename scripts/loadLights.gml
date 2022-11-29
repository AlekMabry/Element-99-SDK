var lightList = ds_map_find_value(global.mapData, "pointlights");
if (ds_list_empty(lightList)) {} else {
    var global.lightCount = ds_list_size(lightList);
    var col, pos, attr;
    for (var b = 0; b < global.lightCount; b++) {
        var currentLight = ds_list_find_value(lightList, b);
        pos[(3 * b) + 0] = currentLight[? "x"];
        pos[(3 * b) + 1] = currentLight[? "y"];
        pos[(3 * b) + 2] = currentLight[? "z"];
        col[(3 * b) + 0] = currentLight[? "r"];
        col[(3 * b) + 1] = currentLight[? "g"];
        col[(3 * b) + 2] = currentLight[? "b"];
        attr[(3 * b) + 0] = currentLight[? "constant"];
        attr[(3 * b) + 1] = currentLight[? "linear"];
        attr[(3 * b) + 2] = currentLight[? "quadratic"];
    }
    ds_map_add(global.lights, "col", col);
    ds_map_add(global.lights, "pos", pos);
    ds_map_add(global.lights, "attr", attr);
}
