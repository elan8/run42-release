package RcReports {
    doc /*
     * A Doc42 verification report for the RC example. Build it after
     * `run42 verify` has written verdicts.json next to this file.
     */
    private import Elan8::Documents::*;

    view verificationReport {
        @Document { title = "RC Charging Verification Report";
            number = "RC-VR-001"; revision = "A"; status = "Example"; template = "verification-report"; }
        view requirements {
            @Section { title = "Requirements and verdicts"; }
            @Table {
                columns = "Requirement = name, Text = text, Verified by = verified-by, Verdict = verified-by / verdict";
                kind = "requirement";
                verdicts = "verdicts.json";
            }
            expose RcCharging::chargesInFiveSeconds;
        }
        view results {
            @Section { title = "Test results"; }
            @Table {
                columns = "Case = name, Verifies = verifies, Verdict = verdict, Time = verdict-time, Detail = verdict-detail";
                kind = "verification case";
                verdicts = "verdicts.json";
            }
            expose RcCharging::chargeTest;
        }
    }
}
