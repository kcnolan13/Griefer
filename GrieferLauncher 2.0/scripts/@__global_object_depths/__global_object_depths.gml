// Initialise the global array that allows the lookup of the depth of a given object
// GM2.0 does not have a depth on objects so on import from 1.x a global array is created
// NOTE: MacroExpansion is used to insert the array initialisation at import time
gml_pragma( "global", "__global_object_depths()");

// insert the generated arrays here
global.__objectDepths[0] = -100; // controller
global.__objectDepths[1] = 0; // modal_button
global.__objectDepths[2] = -9999; // modal_dialogue
global.__objectDepths[3] = -95; // modal_window
global.__objectDepths[4] = 0; // modal_splat
global.__objectDepths[5] = 0; // title
global.__objectDepths[6] = 100; // background_drawer
global.__objectDepths[7] = -999999999; // cursor
global.__objectDepths[8] = 0; // bn_dialogue


global.__objectNames[0] = "controller";
global.__objectNames[1] = "modal_button";
global.__objectNames[2] = "modal_dialogue";
global.__objectNames[3] = "modal_window";
global.__objectNames[4] = "modal_splat";
global.__objectNames[5] = "title";
global.__objectNames[6] = "background_drawer";
global.__objectNames[7] = "cursor";
global.__objectNames[8] = "bn_dialogue";


// create another array that has the correct entries
var len = array_length_1d(global.__objectDepths);
global.__objectID2Depth = [];
for( var i=0; i<len; ++i ) {
	var objID = asset_get_index( global.__objectNames[i] );
	if (objID >= 0) {
		global.__objectID2Depth[ objID ] = global.__objectDepths[i];
	} // end if
} // end for