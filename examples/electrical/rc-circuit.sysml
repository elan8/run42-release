package PhysicalModeling {
    private import ScalarValues::*;
    metadata def ModelicaModel {
        attribute className : String;
        attribute resourceUri : String;
    }
}

package Verification {
    enum def VerificationMethodKind { test; }
    metadata def VerificationMethod { attribute kind : VerificationMethodKind; }
}

package RcCharging {
    doc /*
     * A capacitor charging through a resistor from a 5 V source.
     * The time constant is R·C = 10 kΩ · 100 µF = 1 s, so the capacitor
     * voltage is v(t) = 5 V · (1 − e^(−t / 1 s)).
     */

    private import ISQ::*;
    private import SI::*;
    private import PhysicalModeling::*;
    private import Verification::*;

    port def Pin;

    part def Resistor {
        @ModelicaModel { className = "RcCircuit.Resistor"; resourceUri = "RcCircuit.mo"; }
        attribute resistance : ResistanceValue;
        port positive : Pin;
        port negative : Pin;
    }

    part def Capacitor {
        @ModelicaModel { className = "RcCircuit.Capacitor"; resourceUri = "RcCircuit.mo"; }
        attribute capacitance : CapacitanceValue;
        attribute v : ElectricPotentialValue;
        port positive : Pin;
        port negative : Pin;
    }

    part def VoltageSource {
        @ModelicaModel { className = "RcCircuit.VoltageSource"; resourceUri = "RcCircuit.mo"; }
        attribute voltage : ElectricPotentialValue;
        port positive : Pin;
        port negative : Pin;
    }

    part def Ground {
        @ModelicaModel { className = "RcCircuit.Ground"; resourceUri = "RcCircuit.mo"; }
        port positive : Pin;
    }

    part def Circuit {
        part supply : VoltageSource { attribute :>> voltage = 5 [V]; }
        part resistor : Resistor { attribute :>> resistance = 10 [kilo * ohm]; }
        part capacitor : Capacitor { attribute :>> capacitance = 100 [micro * F]; }
        part ground : Ground;

        connect supply.positive to resistor.positive;
        connect resistor.negative to capacitor.positive;
        connect capacitor.negative to ground.positive;
        connect supply.negative to ground.positive;

        attribute capacitorVoltage : ElectricPotentialValue;
        bind capacitorVoltage = capacitor.v;
    }

    requirement chargesInFiveSeconds {
        doc /* Five seconds after switch-on, the capacitor is charged to at least 4.9 V. */
    }

    verification chargeTest {
        @VerificationMethod { kind = VerificationMethodKind::test; }
        subject circuit : Circuit;
        objective { verify chargesInFiveSeconds; }
        action switchOn { accept after 5 [s]; }
        assert constraint { circuit.capacitorVoltage >= 4.9 [V] }
    }
}
