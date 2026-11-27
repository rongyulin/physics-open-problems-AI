import FidelityObserved
import FrontierEquality
import BellExperiment
import ThesisWitness

/-! # Sharp singlet extractability from a two-qutrit CHSH score

The two exported theorems state the nested physical optimization directly.
The outer minimum ranges over all normalized complex 3 × 3 amplitudes and
four binary measurements realizing exactly the specified score. The inner
maximum ranges over arbitrary local isometries and any finite pure ancillary
Schmidt spectrum. Squared fidelity uses the Bell-pair target.

Read `CHSHScoreInterval.effectScores` for the physical measurements and
`RawExtraction.scores` for the extracted squared overlaps. The rest of the
proof is in the imported source modules in the accompanying project. -/
namespace RankThreeCHSH
open CHSH QutritCHSH CHSHScoreInterval
noncomputable section

/-- The worst attainable best-extraction fidelity for an exactly observed
CHSH score 2s. Its three branches are given explicitly in the conclusion. -/
theorem sharp (s : ℝ) (hl : 1 ≤ s) (hu : s ≤ Real.sqrt 2) :
    let q := (s + 1 - Real.sqrt (-7*s^2 + 2*s + 9))/8
    let w := if s ≤ (1 + Real.sqrt 41)/6 then 2*Real.sqrt (q*(1-2*q))
      else if s ≤ (1 + 2*Real.sqrt 2)/3 then 2/3 else (s-1)/(Real.sqrt 2-1)
    IsLeast {f : ℝ | ∃ F : M, weight F = 1 ∧
      2*s ∈ effectScores F ∧ IsGreatest (RawExtraction.scores F) f} ((1+w)/2) := by
  exact CHSHFrontier.sharp_observed_fidelity s hl hu

/-- The plateau in units of the reported CHSH score, including its endpoints. -/
theorem plateau (S : ℝ)
    (hl : (1+Real.sqrt 41)/3 ≤ S) (hu : S ≤ 2*(1+2*Real.sqrt 2)/3) :
    IsLeast {f : ℝ | ∃ F : M, weight F = 1 ∧
      S ∈ effectScores F ∧ IsGreatest (RawExtraction.scores F) f} (5/6) := by
  have h := CHSHFrontier.plateau_observed (S/2)
    (by unfold CHSHFrontier.switchA; linarith)
    (by unfold CHSHFrontier.switchB; linarith)
  simpa only [CHSHFrontier.observedFidelities, show 2 * (S/2) = S by ring] using h

#print axioms sharp
#print axioms plateau
end
end RankThreeCHSH
