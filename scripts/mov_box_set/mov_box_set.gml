/// @description mov_box_set() ;
/// @param [sprite]
/// by PKG AMES
/*
    
*/
//
var __spr = argument_count ? argument[ 0 ] : ( mask_index != -1 ? mask_index : sprite_index ) ;
var __x1 = sprite_get_bbox_left( __spr ) ,
	__y1 = sprite_get_bbox_top( __spr ) ,
	__x2 = sprite_get_bbox_right( __spr ) ,
	__y2 = sprite_get_bbox_bottom( __spr ) ,
	__xoff = sprite_get_xoffset( __spr ) ,
	__yoff = sprite_get_yoffset( __spr ) ;

//
enum mov_box { x1 , y1 , x2 , y2 , ww , hh } ;
return
	[
		__x1 - __xoff ,
		__y1 - __yoff ,
		__x2 - __xoff ,
		__y2 - __yoff ,
		__x2 - __x1 + 1 ,
		__y2 - __y1 + 1 ,
	] ;