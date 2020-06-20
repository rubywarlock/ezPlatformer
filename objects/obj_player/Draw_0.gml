/// @description code
/*
    
*/
//
mov_draw_self() ;

if debug__ {
	draw_set_color(c_red);
	draw_rectangle( __mov_box[0]+x,__mov_box[1]+y,x+__mov_box[2],__mov_box[3]+y,false );
	draw_set_color(c_yellow);
	var __yy= (__mov_box[1] + __mov_box[3])/2+y-4;
	var __hh= __mov_box[5]*0.5*0.325;
	draw_rectangle( __mov_box[0]+x,__yy-__hh,__mov_box[2]+x,__yy+__hh,false );
}