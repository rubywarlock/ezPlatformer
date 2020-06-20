/// @description code
/*
    
*/
// x-control
__mov_wallJump = false ;
__mov_speed_ylimiter = undefined ;
__mov_speed_x = ( keyboard_check( ord( "D" ) ) - keyboard_check( ord( "A" ) ) ) * 2.25 ;
if __mov_speed_ximpulse_power != 0 
	image_xscale = sign( __mov_speed_ximpulse_power ) ;
else
	if __mov_speed_x != 0 image_xscale = sign( __mov_speed_x ) ;

// animation
if !__mov_switch_grav
	if __mov_speed_x != 0
		animation_set( spr_player_vrgay_Run ) ;
	else
		animation_set( spr_player_vrgay_Idle ) ;
else {
	
	//
	var __yy = ( __mov_box[ 1 ] + __mov_box[ 3 ] ) / 2 + y - 4 ;
	var __hh = __mov_box[ 5 ] * 0.5 * 0.325 ;
	var __xx = x + sign( __mov_speed_x ) ;
	if __mov_speed_x != 0 and __mov_speed_y > 0 and collision_rectangle( __xx +__mov_box[ 0 ] , __yy - __hh , __xx + __mov_box[ 2 ] , __yy +__hh , obj_wall_solid , false , false ) {
		
		//
		__mov_speed_ylimiter = 1 ;
		if animation_set( spr_player_vrgay_Wall_Jump ) double_jump = true ;
		__mov_wallJump = true ;
	}
}

// y-contol
if !__mov_switch_grav {
	
	//
	__mov_fall = false ;
	if keyboard_check_pressed( ord( "W" ) ) {
		
		//
		__mov_switch_grav = true ;
		__mov_speed_y = -10 ;
		
		//
		double_jump = true ;
	} else {
		
		//
		double_jump = false ;
		if keyboard_check_pressed( ord( "S" ) ) and !place_meeting( x , y + 1 , obj_wall_solid ) {
			__mov_switch_grav = true ;
			y += 1 ;
		}
	}
} else {
	
	//
	if !__mov_fall {
		
		//
		__mov_fall = true ;
		if !double_jump double_jump = true ;
	}
	
	//
	if double_jump and keyboard_check_pressed( ord( "W" ) ) {
		
		//
		double_jump = false ;
		__mov_speed_y = -9 ;
		
		//
		if __mov_wallJump {
			
			//
			__mov_speed_ximpulse_power = -5.5 * image_xscale ;
			__mov_speed_y = -11 ;
			__mov_speed_ximpulse_accelerator = 0.1125 ;
		}
		
		//
		animation_set( spr_player_vrgay_Double_Jump ) ;
		double_jump_animation = true ;
	}
}

//
if __mov_switch_grav and !double_jump_animation and !__mov_wallJump
	if __mov_speed_y < 0
		animation_set( spr_player_vrgay_Jump ) ;
	else
		animation_set( spr_player_vrgay_Fall ) ;

//
if keyboard_check( vk_control )
	mov_time = 0.5 ;
else
	mov_time = 1 ;

// Inherit the parent event
event_inherited() ;

//
camera_set_view_pos( view_camera[ 0 ] , xstart - camera_get_view_width( view_camera[ 0 ] ) / 2  , ystart - camera_get_view_height( view_camera[ 0 ] ) / 2 ) ;