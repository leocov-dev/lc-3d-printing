// Remixed from MiseryBot's original work: http://www.thingiverse.com/thing:8063

$fn = 60;
fan(50, 15, 40);

module fan(width, depth, mount, mount_diameter = 3.4, blade_angle = - 45)
{
  bore_diameter = width - 3;

  color("dimgrey")
    {
      body(width, depth, bore_diameter, mount, mount_diameter);
      fan_blades(bore_diameter, depth, blade_angle);
    }
}

module body(width, depth, bore_diameter, mount, mount_diameter)
{
  difference()
    {
      linear_extrude(height = depth, center = true, convexity = 4, twist = 0)
        {
          difference()
            {
              square([width, width], center = true);
              inside_bore(bore_diameter, width / 2 + 2);
              mounting_holes(mount / 2, mount_diameter / 2);
              round_corners(width / 2, (width/2) - (mount/2));
            }
        }

      outside_ring(width, depth);
    }
}

module inside_bore(diameter, hub)
{
  difference()
    {
      circle(r = diameter / 2);
      circle(r = hub / 2);
    }
}

module mounting_holes(offset, r)
{
  for (i = [0:3])
  {
    rotate([0, 0, i * 90])
      {
        translate([offset, offset])
          {
            circle(r = r);
          }
      }
  }
}

module round_corners(offset, r = 5)
{
  square_offset = r - 0.1;
  square_side = r + 0.2;
  for (i = [0:3])
  {
    rotate([0, 0, i * 90])
      {
        translate([offset, offset])
          {
            difference()
              {
                translate([- square_offset, - square_offset])
                  {
                    square([square_side, square_side]);
                  }

                translate([- r, - r])
                  {
                    circle(r = r);
                  }
              }
          }
      }
  }
}

module outside_ring(width, depth, surface_thickness = 3.6)
{
  difference()
    {
      cylinder(r = width * .75, h = depth - 2 * surface_thickness, center = true);
      cylinder(r = (width + 2) / 2, h = depth - 2 * surface_thickness + 0.2, center = true);
    }
}

module fan_blades(width, depth, angle)
{
  linear_extrude(height = depth - 1, center = true, convexity = 4, twist = angle)
    {
      for (i = [0:6])
      rotate((360 * i) / 7)
        translate([0, - 1.5 / 2]) square([width / 2 - 0.75, 1.5]);
    }
}
