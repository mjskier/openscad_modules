//
// Draw a rectangle with rounded corners
// By default all 4 corners are rounded, but some corners can be kept
//    90 degrees if so specified in the flags argument.
//
// Bruno Melli. 9/27/2020

function adjust(v, a, c) = ( c ? v + a: v);

module cyl_or_rect(dims, crad, round) {
     if (round)
	  cylinder(dims[2], r = crad);
     else
	  translate([0, 0, dims[2] / 2])
	       cube([2 * crad, 2 * crad, dims[2]], center = true);
}

// w: dims[0]
// d: dims[1]
// h: dims[2]

// crad: radius of corner

// flags: This corner shoud be round (1) or square (0).           3   2
//        Numberinf is counter clockwise startng at bottom left.  0   1


module rounded_cube(dims, crad, flags = [1, 1, 1, 1], c = false) {
     if (crad * 2 > dims[1]) {
	  echo("--- Warning: The corner radius is too large for the specified depth");
	  echo("---          The rectangle will be deeper than specified");
     }
     x1 = adjust(crad, - dims[0] / 2, c);
     x2 = adjust(dims[0] - crad, - dims[0] / 2, c);
     y1 = adjust(crad, - dims[1] / 2, c);
     y2 = adjust(dims[1] - crad, - crad / 2, c);
     h1 = adjust(0, - dims[2] / 2, c);
     
     hull() {
	  translate([x1, y1, h1]) cyl_or_rect(dims, crad, flags[0]);
	  translate([x2, y1, h1]) cyl_or_rect(dims, crad, flags[1]);
	  translate([x2, y2, h1]) cyl_or_rect(dims, crad, flags[2]);
	  translate([x1, y2, h1]) cyl_or_rect(dims, crad, flags[3]);
     }
}
