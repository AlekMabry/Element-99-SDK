//Reflection is texture is collected by rendering the screen from beneath the surface.
                if !surface_exists(ReflectionTexture)
                {
                    ReflectionTexture = surface_create(1280, 720);
                }
                surface_set_target(ReflectionTexture);
                draw_clear_alpha(c_white, 0.0);
                
                //Setting view position beneath the floor
                draw_set_colour(c_white);
                var xa = cos(direction*pi/180);
                var ya = -sin(direction*pi/180);
                var za = -tan(degtorad(pitch));
                var zLower = ds_map_find_value(argument0, "z1");
                d3d_set_projection_ext(x, y, (zLower*2)-z-cameraZ, x+xa, y+ya, (zLower*2)-z-cameraZ+za, 0, 0, 1, 90, 16/9, 0.1, 16000);
                
                draw_plainWalls();
                draw_models();
                draw_plainFloors();
                
                var ReflectedTextureFinal = surface_get_texture(ReflectionTexture);
                
                surface_reset_target();
                
                //If you suspect the surface isn't being drawn to correctly, use this to check
                //d3d_set_projection_ortho(0, 0, 1280, 720, 0);
                //draw_surface_stretched(ReflectionTexture, 16, 16, 320, 280);
                
                //Reset Render
                draw_set_colour(c_white);
                xa = cos(direction*pi/180);
                ya = -sin(direction*pi/180);
                za = tan(degtorad(pitch));
                d3d_set_projection_ext(x, y, z+cameraZ, x+xa, y+ya, z+cameraZ+za, 0, 0, 1, 90, 16/9, 0.1, 16000);
                
                //Input reflection sample
                var reflection_sampler = shader_get_sampler_index(shd_reflectionLightmap, "reflectionTex");
                texture_set_stage(reflection_sampler, ReflectedTextureFinal);
                
                //Lightmap Code ---------------------------------------------------------------
                var lightmap_sampler = shader_get_sampler_index(shd_reflectionLightmap, "lightmap");
                
                //Input lightmap sample
                //var lightmapIndex = ds_map_find_value(global.lightmapName, ds_map_find_value(argument0, "name"));
                //var lightmap_tex = background_get_texture(global.lightmaps[lightmapIndex])
                texture_set_stage(lightmap_sampler, argument1);
                
                shader_set(shd_reflectionLightmap);
                
                //Input position, scale, and hrepeat vrepeat
                //------------Light Map Position-------------------------------------
                var vec2_lightmapPos;
                vec2_lightmapPos[0] = ds_map_find_value(argument0, "mapPosX");
                vec2_lightmapPos[1] = ds_map_find_value(argument0, "mapPosY");
                var params_lightmapPos = shader_get_uniform(shd_reflectionLightmap, "lightmapPos");
                shader_set_uniform_f_array(params_lightmapPos, vec2_lightmapPos);
                //------------Light Map Scale----------------------------------------
                var vec2_lightmapScale;
                vec2_lightmapScale[0] = ds_map_find_value(argument0, "mapScaleX");
                vec2_lightmapScale[1] = ds_map_find_value(argument0, "mapScaleY");
                var params_lightmapScale = shader_get_uniform(shd_reflectionLightmap, "lightmapScale");
                shader_set_uniform_f_array(params_lightmapScale, vec2_lightmapScale);
                //------------Light Map Repeat----------------------------------------
                var vec2_lightmapRepeat;
                vec2_lightmapRepeat[0] = ds_map_find_value(argument0, "hrepeat");
                vec2_lightmapRepeat[1] = ds_map_find_value(argument0, "vrepeat");
                var params_lightmapRepeat = shader_get_uniform(shd_reflectionLightmap, "lightmapRepeat");
                shader_set_uniform_f_array(params_lightmapRepeat, vec2_lightmapRepeat);
                //------------Player Position-----------------------------------------
                var vec3_playerPos;
                vec3_playerPos[0] = x;
                vec3_playerPos[1] = y;
                vec3_playerPos[2] = z+cameraZ;
                var params_playerPos = shader_get_uniform(shd_reflectionLightmap, "playerPos");
                shader_set_uniform_f_array(params_playerPos, vec3_playerPos);
                
                
