//Argument0 is AABB
//Argument1 is AABB previous
//Argument2 is velocity
//Argument3 is AABB brush

//Program returns a vec3 of displacement

var displacement;
displacement[0] = 0;
displacement[1] = 0;
displacement[2] = 0;


    if (collidedFromLeft(argument1, argument0, argument3)) {
        //If colliding into brush from left then figure out BrushLeft - AABB Right
        displacement[0] = argument3[0] - argument0[1];
        jumpNextFrame = 1;
    }
    if (collidedFromRight(argument1, argument0, argument3)) {
        //If colliding into brush from left then figure out BrushRight - AABB Left
        displacement[0] = argument3[1] - argument0[0];
        jumpNextFrame = 1;
    }
    if (collidedFromFront(argument1, argument0, argument3)) {
        //If colliding into brush from left then figure out BrushFront - AABB Back
        displacement[1] = argument3[2] - argument0[3];
        jumpNextFrame = 1;
    }
    if (collidedFromBack(argument1, argument0, argument3)) {
        //If colliding into brush from left then figure out BrushBack - AABB Front
        displacement[1] = argument3[3] - argument0[2];
        jumpNextFrame = 1;
    }
    if (collidedFromBottom(argument1, argument0, argument3)) {
        //If colliding into brush from left then figure out BrushBottom - AABB Top
        displacement[2] = argument3[4] - argument0[5];
    }
    if (collidedFromTop(argument1, argument0, argument3)) {
        //If colliding into brush from left then figure out BrushTop - AABB Bottom
        displacement[2] = argument3[5] - argument0[4];
    }
    var a = argument2;
    return displacement;

