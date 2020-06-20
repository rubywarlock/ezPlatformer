/// @description log() ;
/// @param ...
/// by PKG AMES
/*
    
*/
//
var __get , __log = "\n" , i = 0 ;
repeat argument_count {
	__get = string_replace_all( string( argument[ i ++ ] ) , chr( vk_enter ) , "\n" ) ;
	if string_pos( "\n" , __get ) __get = string_replace_all( __get , "\n" , "\n\t" ) ;
	__log += __get + ( i != argument_count ? "\n" : "" ) ;
}
show_debug_message( __log ) ;
return __log ;