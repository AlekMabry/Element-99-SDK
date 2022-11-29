var fname = argument0;

/* Model Format
[Model Type]
[Vertex Count]
[X] [Y] [Z] [U] [V] [TX] [TY] [TZ] [BX] [BY] [BZ] [NX] [NY] [NZ] 
*/

file = file_text_open_read(fname);
str_modelType = file_text_readln(file);
file_text_close(file);

model = vertex_create_buffer();
vertex_begin(model, global.E99);

