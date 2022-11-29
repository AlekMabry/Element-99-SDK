vertex_format_begin();
vertex_format_add_position_3d();                                        // Position
vertex_format_add_textcoord();                                          // Texture
vertex_format_add_custom(vertex_type_float3, vertex_usage_tangent);     // Tangent
vertex_format_add_custom(vertex_type_float3, vertex_usage_binormal);    // Binormal
vertex_format_add_normal();                                             // Normal
var global.E99 = vertex_format_end();
