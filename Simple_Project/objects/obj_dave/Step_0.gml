/// @description Movement

// Check if solid ground will be under the character at the end of this step
// Have to add acceleration onto vspeed, because this is the amount it will be
// increased by gravity potentially
if not place_free(x + hspeed, y + vspeed + acceleration){
	// Even if the character was moving at a greater speed like
	// 3 pixels per second, this would still stop the character perfectly
	// on top the solid object because once the vspeed is reduced to 0
	// the player would again start dropping till the solid object
	// was less than one acceleration magnitude away
	vspeed = 0
	
	// Stick the landings, so when jumping on a platform the character
	// does not slide off
	if (gravity > 0){
		if (abs(hspeed) > 1){
			hspeed = 1*sign(hspeed)
		}
	}
	
	// Ensure gravity does not force character into solid object
	gravity = 0
	
	// Since adding acceleration to the check, character may stop the
	// magnitude of acceleration above. This rounding will prevent the
	// character from stopping at some weird half pixel.
	y = round(y)
	
	// Jumping
	if (keyboard_check_pressed(ord("W"))){
		// Do not accelerate slowly up, set speed all at once
		// gravity will take care of the rest
		vspeed = -move_speed
	}
	
	// Running, only allow when on the ground
	friction = 0
	if (keyboard_check(ord("D")) and hspeed < move_speed){
		hspeed += acceleration
	}
	else if (keyboard_check(ord("A")) and hspeed > -move_speed){
		hspeed -= acceleration
	}
	else if (abs(hspeed) > 0){
		friction = deacceleration
	}
}
// Only apply gravity if with it, it will not drive the character in the ground
else{
	gravity = deacceleration
	// No friction effect if in air
	// Friction affects speed regardless of direction, so it would double
	// the gravity effect
	friction = 0
}

// Side collisions
if not place_free(x + hspeed, y){
	hspeed = 0
	x = round(x)
}