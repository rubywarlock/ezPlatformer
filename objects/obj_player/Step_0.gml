/// @description code
/*
    
*/
//
if !__mov_switch_grav {
	
	//
	__mov_fall = false ;
	if keyboard_check_pressed( ord( "W" ) ) {
		
		//
		__mov_switch_grav = true ;
		__mov_speed_y = -9 ;
		
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
		animation_set( Double_Jump__32x32_ ) ;
		double_jump_animation = true ;
	}
}	


//
__mov_speed_y_limiter = undefined ;
__mov_speed_x = ( keyboard_check( ord( "D" ) ) - keyboard_check( ord( "A" ) ) ) * 2.25 ;
if __mov_speed_x != 0 image_xscale = sign( __mov_speed_x ) ;
if !__mov_switch_grav
	if __mov_speed_x != 0
		animation_set( Run__32x32_ ) ;
	else
		animation_set( Idle__32x32_ ) ;
else {
	
	var __yy= (__mov_box[1] + __mov_box[3])/2+y-4;
	var __hh= __mov_box[5]*0.5*0.325;
	var __xx = round( x ) + sign( __mov_speed_x )*2 ;
	if __mov_speed_x != 0 and __mov_speed_y > 0 and  collision_rectangle(__xx+__mov_box[0],__yy-__hh,__xx+__mov_box[2],__yy+__hh,obj_wall_solid,false,false)  {
		__mov_speed_y_limiter = 1 ;
		if animation_set( Wall_Jump__32x32_ ) double_jump = true ;
		
	} else
	if !double_jump_animation
		if __mov_speed_y < 0
			animation_set( Jump__32x32_ ) ;
		else
			animation_set( Fall__32x32_ ) ;
}//__mov_speed_y_limiter

// Inherit the parent event
event_inherited();

//
camera_set_view_pos( view_camera[ 0 ] , x - camera_get_view_width( view_camera[ 0 ] ) / 2  , y - camera_get_view_height( view_camera[ 0 ] ) / 2 ) ;
