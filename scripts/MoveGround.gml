// Apply Friction

accelDir = argument0;
prevVelocity = argument1;

var speeed = vec3mag(argument1);
if (speeed != 0) // To avoid divide by zero errors
{
    var drop = speeed * sv_friction * (0.0166);
    scaled = max(speeed - drop, 0.0) / speeed; // Scale the velocity based on friction.
    prevVelocity[0] *= scaled;
    prevVelocity[1] *= scaled;
    prevVelocity[2] *= scaled;
}

// ground_accelerate and max_velocity_ground are server-defined movement variables
return Accelerate(accelDir, prevVelocity, sv_accelerate, sv_maxspeedground);
