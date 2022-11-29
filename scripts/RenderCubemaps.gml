/// Renders Cubemaps

var cubemapList = ds_map_find_value(global.mapData, "cubemaps");
var cubemaps = ds_list_size(cubemapList);
var cubemap_x, cubemap_y, cubemap_z = 0;
var backup_x, backup_y, backup_z;   // To store the player's position to return them after the cubemaps are rendered

backup_x = obj_player.x;
backup_y = obj_player.y;
backup_z = obj_player.z;

draw_set_color(c_white);

for (var i = 0; i < cubemaps; i++)
{
    var cubemap = ds_list_find_value(cubemapList, i);
    cubemap_x = ds_map_find_value(cubemap, "x");  // Obnoxious fix, player must be moved to make cubemaps because of draw_models()
    cubemap_y = ds_map_find_value(cubemap, "y");
    cubemap_z = ds_map_find_value(cubemap, "z");
    obj_player.x = cubemap_x;
    obj_player.y = cubemap_y;
    obj_player.z = cubemap_z;
    
    // Left Face (-X)
    if !surface_exists(global.cubemap_negative_x[i])
    {
        global.cubemap_negative_x[i] = surface_create(256, 256);
    }
    surface_set_target(global.cubemap_negative_x[i]);
    draw_clear_alpha(c_black, 1.0);
    d3d_set_projection_ext(cubemap_x, cubemap_y, cubemap_z,
        cubemap_x - 1, cubemap_y + 0, cubemap_z + 0,
        0, 0, 1, 90, 1, 0.1, 16000);
    draw_models();
    surface_reset_target();
    
    // Right Face (X)
    if !surface_exists(global.cubemap_positive_x[i])
    {
        global.cubemap_positive_x[i] = surface_create(256, 256);
    }
    surface_set_target(global.cubemap_positive_x[i]);
    draw_clear_alpha(c_black, 1.0);
    d3d_set_projection_ext(cubemap_x, cubemap_y, cubemap_z,
        cubemap_x + 1, cubemap_y + 0, cubemap_z + 0,
        0, 0, 1, 90, 1, 0.1, 16000);
    draw_models();
    surface_reset_target();
    
    // Front Face (-Y)
    if !surface_exists(global.cubemap_negative_y[i])
    {
        global.cubemap_negative_y[i] = surface_create(256, 256);
    }
    surface_set_target(global.cubemap_negative_y[i]);
    draw_clear_alpha(c_black, 1.0);
    d3d_set_projection_ext(cubemap_x, cubemap_y, cubemap_z,
        cubemap_x + 0, cubemap_y - 1, cubemap_z + 0,
        0, 0, 1, 90, 1, 0.1, 16000);
    draw_models();
    surface_reset_target();
    
    // Back Face (Y)
    if !surface_exists(global.cubemap_positive_y[i])
    {
        global.cubemap_positive_y[i] = surface_create(256, 256);
    }
    surface_set_target(global.cubemap_positive_y[i]);
    draw_clear_alpha(c_black, 1.0);
    d3d_set_projection_ext(cubemap_x, cubemap_y, cubemap_z,
        cubemap_x + 0, cubemap_y + 1, cubemap_z + 0,
        0, 0, 1, 90, 1, 0.1, 16000);
    draw_models();
    surface_reset_target();
    
    // Bottom Face (-Z)
    if !surface_exists(global.cubemap_negative_z[i])
    {
        global.cubemap_negative_z[i] = surface_create(256, 256);
    }
    surface_set_target(global.cubemap_negative_z[i]);
    draw_clear_alpha(c_black, 1.0);
    d3d_set_projection_ext(cubemap_x, cubemap_y, cubemap_z,
        cubemap_x + 0, cubemap_y + 0, cubemap_z - 1,
        0, 1, 0, 90, 1, 0.1, 16000);
    draw_models();
    surface_reset_target();
    
    // Top Face (Z)
    if !surface_exists(global.cubemap_positive_z[i])
    {
        global.cubemap_positive_z[i] = surface_create(256, 256);
    }
    surface_set_target(global.cubemap_positive_z[i]);
    draw_clear_alpha(c_black, 1.0);
    d3d_set_projection_ext(cubemap_x, cubemap_y, cubemap_z,
        cubemap_x + 0, cubemap_y + 0, cubemap_z + 1,
        0, 1, 0, 90, 1, 0.1, 16000);
    draw_models();
    surface_reset_target();
    
    // Render Together
    if !surface_exists(global.cubemap[i])
    {
        global.cubemap[i] = surface_create(1024, 1024);
    }
    surface_set_target(global.cubemap[i]);
    draw_clear_alpha(c_black, 1.0);
    d3d_set_projection_ortho(0, 0, 1024, 1024, 0);
    draw_surface(global.cubemap_negative_x[i], 0, 0);
    draw_surface(global.cubemap_positive_x[i], 256, 0);
    draw_surface(global.cubemap_negative_y[i], 0, 256);
    draw_surface(global.cubemap_positive_y[i], 256, 256);
    draw_surface(global.cubemap_negative_z[i], 0, 512);
    draw_surface(global.cubemap_positive_z[i], 256, 512);
    surface_reset_target();
}

obj_player.x = backup_x;
obj_player.y = backup_y;
obj_player.z = backup_z;
