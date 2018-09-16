var length = sqrt(sqr(argument0[0])+sqr(argument0[1])+sqr(argument0[2]));
var output;
if (length != 0) {
    output[0] = argument0[0]/length;
    output[1] = argument0[1]/length;
    output[2] = argument0[2]/length;
} else {
    output[0] = 0;
    output[1] = 0;
    output[2] = 0;
}
return output;
