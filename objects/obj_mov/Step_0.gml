/// @description moving-form
/*
    
*/
#region __debug
	if keyboard_check_pressed( vk_control )
		__mov_speed_ximpulse_power = 3 ;
		__mov_speed_ximpulse_accelerator = 0.12 ;
#endregion

//
#region //// INIT //////////////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	gml_pragma( "global" , @"
		global.__zProject_mov_collision_list = ds_list_create() ;
	" ) ;
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	#macro mov_list global.__zProject_mov_collision_list
	#macro speed_max 5
	#macro speed_acceleration 0.65
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endregion /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#region [default] switch-moving
	if !__mov_switch_mov exit ;
#endregion
/* 
	used:
		__mov_switch_mov
*/

#region [default] {0} image_xscale-control
	if __mov_switch_xscale_control {
		
		//
		var __xscale = image_xscale ;
		image_xscale = 1 ;
	}
#endregion
/* 
	used:
		__mov_switch_xscale_control
*/

#region [default] gravity-grav_auto
if __mov_switch_grav_auto and !__mov_switch_grav {
	
	//
	var __x1 = __mov_box[ 0 ] + x , __x2 = __mov_box[ 2 ] + x , __y1 = y , __y2 = y + 1 ;
	if !collision_rectangle( __x1 , __y1 , __x2 , __y2 , obj_wall_solid , false , false ) {
		
		//
		ds_list_clear( mov_list ) ;
		if collision_rectangle_list( __x1 , __y1 , __x2 , __y2 , obj_wall_soft , false , false , mov_list , false ) {
			
			var i = 0 , __id_in ;
			repeat ds_list_size( mov_list ) {
				__id_in = mov_list[| i ++ ] ;
				if __id_in.y < y {
					
					//
					__mov_switch_grav = true ;
					break ;
				}
			}
		} else __mov_switch_grav = true ;
	}
} #endregion
/* 
	used:
		__mov_switch_grav_auto
		__mov_switch_grav
		__mov_box
		
		mov_list
*/

#region [default] speed_y-moving
if __mov_switch_grav {
	
	// speed_y-acceleration
	if __mov_switch_grav_acceleration {
		
		//
		if __mov_speed_y < speed_max __mov_speed_y = min( speed_max , __mov_speed_y + speed_acceleration ) ;
		if !is_undefined( __mov_speed_ylimiter ) and __mov_speed_y > __mov_speed_ylimiter __mov_speed_y = __mov_speed_ylimiter ;
	}
	
	//
	if __mov_speed_y != 0 {
		
		// moving to up
		var __speed_y = round( __mov_speed_y ) + sign( __mov_speed_y ) ;
		if __speed_y < 0 {
			
			//
			ds_list_clear( mov_list ) ;
			if instance_place_list( x , y + __speed_y , obj_wall_solid , mov_list , false ) {
				
				//
				var i = 1 , __ymax = mov_list[| 0 ].y + mov_list[| 0 ].sprite_height , __yy ;
				repeat ds_list_size( mov_list ) - 1 {
					
					//
					__yy = mov_list[| i ].y + mov_list[| i ].sprite_height ; i ++ ;
					if __yy > __ymax __ymax = __yy ;
				}
				__mov_speed_y = 0 ;
				y = __ymax + __mov_box[ mov_box.hh ] ;
				ystart = y ;
			} else {
				
				//
				ystart += __mov_speed_y ;
				y = round( ystart ) ;
			}
		} else {
			
			// moving to down
			ds_list_clear( mov_list ) ;
			instance_place_list( x , y + __speed_y , obj_wall_solid , mov_list , false ) ;
			instance_place_list( x , y + __speed_y , obj_wall_soft , mov_list , false ) ;
			if !ds_list_empty( mov_list ) {
				
				//
				if mov_list[| 0 ].object_index == obj_wall_solid
					var i = 1 , __id_out = mov_list[| 0 ] , __id_in ;
				else
					var i = 0 , __id_out = undefined , __id_in ;
				
				repeat ds_list_size( mov_list ) - i {
					
					//
					__id_in = mov_list[| i ++ ] ;
					if __id_in.object_index == obj_wall_solid {
						
						//
						if __id_out.y < __id_in.y __id_out = __id_in ;
					} else
						if y < __id_in.y {
						
							//
							if is_undefined( __id_out ) or __id_out.y < __id_in.y __id_out = __id_in ;
						}
				}
				if !is_undefined( __id_out ) {
					__mov_speed_y = 0 ;
					__mov_switch_grav = false ;
					y = __id_out.y - 1 ;
					ystart = y ;
				} else __speed_y = undefined ;
			} else __speed_y = undefined ;
			if is_undefined( __speed_y ) {
				
				//
				ystart += __mov_speed_y ;
				y = round( ystart ) ;
			}
		}
	}
} #endregion
/* 
	used:
		__mov_switch_grav
		__mov_switch_grav_acceleration
		__mov_speed_y
		__mov_speed_ylimiter
		__mov_box
		
		speed_max
		speed_acceleration
		
		mov_list
*/

#region [default] speed_x-acceleration
__mov_speed_x += __mov_speed_xacceleration ;
if __mov_speed_ximpulse_power != 0 {
	
	//
	if __mov_speed_ximpulse_maximizer
		if __mov_speed_ximpulse_power < 0
			var __speed_xmov = min( __mov_speed_x , __mov_speed_ximpulse_power ) ;
		else
			var __speed_xmov = max( __mov_speed_x , __mov_speed_ximpulse_power ) ;
	else
		var __speed_xmov = __mov_speed_ximpulse_power ;
	
	//
	if __mov_speed_ximpulse_modifier != 0 {
		
		//
		var __disable = sign( __mov_speed_ximpulse_power ) ;
		__mov_speed_ximpulse_power += __mov_speed_ximpulse_modifier ;
		__mov_speed_ximpulse_modifier = 0 ;
		if __disable != sign( __mov_speed_ximpulse_power ) __mov_speed_ximpulse_power = 0 ;
	}
	
	//
	__mov_speed_ximpulse_power = lerp( __mov_speed_ximpulse_power , 0 , __mov_speed_ximpulse_accelerator ) ;
	if abs( __mov_speed_ximpulse_power ) < 0.1 {
		
		//
		__mov_speed_ximpulse_power = 0 ;
		__mov_speed_ximpulse_accelerator = 0 ;
	}
} else var __speed_xmov = __mov_speed_x ; #endregion
/* 
	used:
		__mov_speed_x
		__mov_speed_xacceleration
		__mov_speed_ximpulse_power
		__mov_speed_ximpulse_accelerator
		__mov_speed_ximpulse_maximizer
		__mov_speed_ximpulse_modifier
*/

#region [default] speed_x-moving
var __speed_x = round( __speed_xmov ) + sign( __speed_xmov ) ;
if __speed_x != 0 {
	
	// moving left or right
	ds_list_clear( mov_list ) ;
	if !instance_place_list( x + __speed_x , y , obj_wall_solid , mov_list , false ) {
		
		//
		xstart += __speed_xmov ;
		x = round( xstart ) ;
	} else {
		
		// moving
		__mov_speed_x = 0 ;
		__mov_speed_ximpulse_power = 0 ;
		__mov_speed_ximpulse_accelerator = 0 ;
		__mov_speed_ximpulse_modifier = 0 ;
		if __speed_x {
			
			// moving left
			var i = 1 , __xmin = mov_list[| 0 ].x ;
			repeat ds_list_size( mov_list ) - 1 {
				
				//
				if mov_list[| i ].x < __xmin __xmin = mov_list[| i ].x ; i ++ ;
			}
			x = __xmin - __mov_box[ mov_box.x2 ] - 1 ;
			xstart = x ;
		} else {
			
			// moving right
			var i = 1 , __xmax = mov_list[| 0 ].x + mov_list[| 0 ].sprite_width , __xx ;
			repeat ds_list_size( mov_list ) - 1 {
				
				//
				__xx = mov_list[| i ].x + mov_list[| i ].sprite_width ; i ++ ;
				if __xx > __xmax __xmax = __xx ;
			}
			x = __xmax - __mov_box[ mov_box.x1 ] ;
			xstart = x ;
		}
	}
} #endregion
/* 
	used:
		__mov_speed_x
		__mov_speed_ximpulse_power
		__mov_speed_ximpulse_accelerator
		__mov_speed_ximpulse_modifier
		__mov_box
		
		mov_list
*/

#region [default] {1} image_xscale-control
	if __mov_switch_xscale_control image_xscale = __xscale ;
#endregion
/* 
	used:
		__mov_switch_xscale_control
*/
