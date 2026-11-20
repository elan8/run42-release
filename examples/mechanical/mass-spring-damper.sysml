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

package Oscillator {
    doc /*
     * A 1 kg mass on a 100 N/m spring and a 4 N·s/m damper, both fixed to a
     * wall. The mass is pulled 0.1 m out, stretching the spring, and released
     * at rest. The natural frequency is ω₀ = √(k/m) = 10 rad/s and the damping
     * ratio is ζ = c / (2√(km)) = 0.2, so the spring extension oscillates with
     * a decaying amplitude:
     *   x(t) = 0.1 m · e^(−2t) · (cos ω_d t + (2/ω_d) sin ω_d t),  ω_d = √96 rad/s.
     */

    private import ISQ::*;
    private import Quantities::*;
    private import SI::*;
    private import PhysicalModeling::*;
    private import Verification::*;

    port def Flange;

    part def Mass {
        @ModelicaModel { className = "MassSpringDamper.Mass"; resourceUri = "MassSpringDamper.mo"; }
        attribute mass : MassValue;
        port flange : Flange;
    }

    part def Spring {
        @ModelicaModel { className = "MassSpringDamper.Spring"; resourceUri = "MassSpringDamper.mo"; }
        attribute stiffness : ScalarQuantityValue;
        attribute initialExtension : LengthValue;
        attribute extension : LengthValue;
        port end1 : Flange;
        port end2 : Flange;
    }

    part def Damper {
        @ModelicaModel { className = "MassSpringDamper.Damper"; resourceUri = "MassSpringDamper.mo"; }
        attribute damping : ScalarQuantityValue;
        port end1 : Flange;
        port end2 : Flange;
    }

    part def Wall {
        @ModelicaModel { className = "MassSpringDamper.Wall"; resourceUri = "MassSpringDamper.mo"; }
        port flange : Flange;
    }

    part def Oscillator {
        part wall : Wall;
        part spring : Spring {
            attribute :>> stiffness = 100 [N / m];
            attribute :>> initialExtension = 0.1 [m];
        }
        part damper : Damper { attribute :>> damping = 4 [N * s / m]; }
        part body : Mass { attribute :>> mass = 1 [kg]; }

        connect wall.flange to spring.end1;
        connect spring.end2 to body.flange;
        connect wall.flange to damper.end1;
        connect damper.end2 to body.flange;

        attribute displacement : LengthValue;
        bind displacement = spring.extension;
    }

    requirement settlesInThreeSeconds {
        doc /* Three seconds after release, the mass is within 1 mm of its rest position. */
    }

    verification settlingTest {
        @VerificationMethod { kind = VerificationMethodKind::test; }
        subject oscillator : Oscillator;
        objective { verify settlesInThreeSeconds; }
        action release { accept after 3 [s]; }
        assert constraint {
            oscillator.displacement <= 0.001 [m] and oscillator.displacement >= -0.001 [m]
        }
    }
}
