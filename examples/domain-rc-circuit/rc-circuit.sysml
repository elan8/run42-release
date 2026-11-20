package DomainRc {
    doc /*
     * A capacitor charging through a resistor from a 5 V source, built only from parts of the
     * Elan8 domain library: no Modelica file. The time constant is R·C = 10 kΩ · 100 µF = 1 s,
     * so the capacitor voltage is v(t) = 5 V · (1 − e^(−t / 1 s)).
     *
     * A Run42 release includes the domain library, so
     *   run42 run examples/domain-rc-circuit --root DomainRc::Circuit --t-end 5s
     * needs no library path.
     */

    private import Elan8::Electronics::Components::*;
    private import SI::*;

    part def Circuit {
        part supply : VoltageSource {
            attribute :>> sourceVoltage = 5 [V];
        }
        part resistor : Resistor {
            attribute :>> resistance = 10 [kilo * ohm];
        }
        part capacitor : Capacitor {
            attribute :>> capacitance = 100 [micro * F];
        }
        part ground : Ground;

        connect supply.terminal1 to resistor.terminal1;
        connect resistor.terminal2 to capacitor.terminal1;
        connect capacitor.terminal2 to ground.terminal;
        connect supply.terminal2 to ground.terminal;
    }
}
