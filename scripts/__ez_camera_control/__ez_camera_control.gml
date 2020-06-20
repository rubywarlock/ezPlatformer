/// @description __ez_camera_control() ;
/// @param camera
/// @param move
/// @param scale
/// by PKG AMES
/*
    
*/
//
var __cams = argument0 ;
var __cams_x = camera_get_view_x( __cams ) ;
var __cams_y = camera_get_view_y( __cams ) ;
var __cams_w = camera_get_view_width( __cams ) ;
var __cams_h = camera_get_view_height( __cams ) ;

//
{
	var __SPEED = 4 ;
	var __SPEED_CONTROL = 0.4 ;
	var __SCALE = 0.15 ;
}

//
if argument1 {
	var __x_key = keyboard_check( vk_right ) - keyboard_check( vk_left ) ;
	var __y_key = keyboard_check( vk_down ) - keyboard_check( vk_up ) ;
	if keyboard_check( vk_control ) __SPEED = __SPEED_CONTROL ;
	if ( __x_key != 0 ) or ( __y_key != 0 ) {
		
		//
		__cams_x += __x_key * __SPEED ;
		__cams_y += __y_key * __SPEED ;
		camera_set_view_pos( __cams , __cams_x , __cams_y ) ;
	}
}

//
if argument2 {
	var __scale = mouse_wheel_down() - mouse_wheel_up() ;
	if ( __scale != 0 ) {
		if !variable_global_exists( "__z_ez_camera_control_debug" ) global.__z_ez_camera_control_debug = [ __cams_w , __cams_h , 1 ] ;
		var xx = __cams_x + __cams_w / 2 ;
		var yy = __cams_y + __cams_h / 2 ;
		__cams_w = global.__z_ez_camera_control_debug[ 0 ] ;
		__cams_h = global.__z_ez_camera_control_debug[ 1 ] ;
		global.__z_ez_camera_control_debug[ 2 ] += __scale * __SCALE ;
		global.__z_ez_camera_control_debug[ 2 ] = max( 0.05 , round( global.__z_ez_camera_control_debug[ 2 ] * 100 ) / 100 ) ;
		__cams_w *= global.__z_ez_camera_control_debug[ 2 ] ; __cams_x = xx - __cams_w / 2 ;
		__cams_h *= global.__z_ez_camera_control_debug[ 2 ] ; __cams_y = yy - __cams_h / 2 ;
		camera_set_view_size( __cams , __cams_w , __cams_h ) ;
		camera_set_view_pos( __cams , __cams_x , __cams_y ) ;
	} else if keyboard_check_pressed( vk_numpad0 ) and variable_global_exists( "__z_ez_camera_control_debug" ) {
		var xx = __cams_x + __cams_w / 2 ;
		var yy = __cams_y + __cams_h / 2 ;
		__cams_w = global.__z_ez_camera_control_debug[ 0 ] ;
		__cams_h = global.__z_ez_camera_control_debug[ 1 ] ;
		global.__z_ez_camera_control_debug[ 2 ] = 1 ;
		__cams_w *= global.__z_ez_camera_control_debug[ 2 ] ; __cams_x = xx - __cams_w / 2 ;
		__cams_h *= global.__z_ez_camera_control_debug[ 2 ] ; __cams_y = yy - __cams_h / 2 ;
		camera_set_view_size( __cams , __cams_w , __cams_h ) ;
		camera_set_view_pos( __cams , __cams_x , __cams_y ) ;
	}
}