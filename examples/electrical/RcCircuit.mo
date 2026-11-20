within ;
package RcCircuit "Ideal circuit elements for the RC charging example"
  connector Pin "Names match the SysML ports"
    Real v(unit = "V") "Potential";
    flow Real i(unit = "A") "Current into the component";
  end Pin;

  model Resistor
    parameter Real resistance(unit = "Ohm");
    Pin positive;
    Pin negative;
    Real i(unit = "A") "Current from positive to negative";
  equation
    positive.v - negative.v = resistance * i;
    positive.i = i;
    negative.i = -i;
  end Resistor;

  model Capacitor "Starts discharged"
    parameter Real capacitance(unit = "F");
    Pin positive;
    Pin negative;
    Real v(start = 0, fixed = true, unit = "V") "positive.v - negative.v";
  equation
    positive.i = capacitance * der(v);
    positive.v - negative.v = v;
    negative.i = -positive.i;
  end Capacitor;

  model VoltageSource "Constant voltage, switched on at t = 0"
    parameter Real voltage(unit = "V");
    Pin positive;
    Pin negative;
  equation
    positive.v - negative.v = voltage;
    positive.i = -negative.i;
  end VoltageSource;

  model Ground
    Pin positive;
  equation
    positive.v = 0;
  end Ground;
end RcCircuit;
