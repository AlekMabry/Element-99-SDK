var fname = argument0;

/* Check to see if ASCII or Binary file */
var file = file_text_open_read(fname);
var line = file_text_readln(file);  // Possible Header

if (string_copy(line, 1, 4) = "File")
{
    show_debug_message("Loading Model [ASCII]: "+fname)
    
    /* Model Format
    [Model Type]
    [Vertex Count]
    [X] [Y] [Z] [U] [V] [TX] [TY] [TZ] [BX] [BY] [BZ] [NX] [NY] [NZ] 
    */
    
    line = file_text_readln(file);      // Desc
    line = file_text_readln(file);      // Desc
    line = file_text_readln(file);      // Desc
    type = file_text_read_real(file);   // Type
    vertices = file_text_read_real(file);   // Vertices
    
    /* Reading File into Model Buffer */
    
    model = vertex_create_buffer();
    vertex_begin(model, global.E99);
    
    for (var i = 0; i < vertices; i++)
    {
        vertex_position_3d(model,
            file_text_read_real(file),
            file_text_read_real(file),
            file_text_read_real(file));
        vertex_texcoord(model,
            file_text_read_real(file),
            file_text_read_real(file));
        vertex_normal(model,
            file_text_read_real(file),
            file_text_read_real(file),
            file_text_read_real(file));
        vertex_float3(model,
            file_text_read_real(file),
            file_text_read_real(file),
            file_text_read_real(file));
        vertex_float3(model,
            file_text_read_real(file),
            file_text_read_real(file),
            file_text_read_real(file));
    }
    vertex_end(model);
    vertex_freeze(model);
    file_text_close(file);
    
    return model;
} else {
    show_debug_message("Loading Model [Binary]: "+fname)
    
    file_text_close(file);
    vertex_buffer = buffer_load(fname);
    model = vertex_create_buffer_from_buffer(vertex_buffer, global.E99);
    vertex_freeze(model);
    
    return model;
}




