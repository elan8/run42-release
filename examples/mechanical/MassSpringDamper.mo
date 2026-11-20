within ;
package MassSpringDamper "One-dimensional translational elements for the mass-spring-damper example"
  connector Flange "Names match the SysML ports"
    Real v(unit = "m/s") "Velocity";
    flow Real f(unit = "N") "Force on the component";
  end Flange;

  model Mass "Starts at rest"
    parameter Real mass(unit = "kg");
    Flange flange;
    Real v(start = 0, fixed = true, unit = "m/s") "Velocity";
  equation
    flange.v = v;
    mass * der(v) = flange.f;
  end Mass;

  model Spring "Linear spring. extension is end2 relative to end1, from the unstretched length."
    parameter Real stiffness(unit = "N/m");
    parameter Real initialExtension(unit = "m");
    Flange end1;
    Flange end2;
    Real extension(start = initialExtension, fixed = true, unit = "m");
    Real f(unit = "N") "Tension";
  equation
    der(extension) = end2.v - end1.v;
    f = stiffness * extension;
    end1.f = -f;
    end2.f = f;
  end Spring;

  model Damper "Linear viscous damper"
    parameter Real damping(unit = "N.s/m");
    Flange end1;
    Flange end2;
    Real f(unit = "N") "Tension";
  equation
    f = damping * (end2.v - end1.v);
    end1.f = -f;
    end2.f = f;
  end Damper;

  model Wall "Does not move"
    Flange flange;
  equation
    flange.v = 0;
  end Wall;
end MassSpringDamper;
