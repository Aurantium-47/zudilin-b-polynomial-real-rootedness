import Zudilin

/- Independent review harness. These lemmas are not part of the author's 53. -/
namespace IndependentReview
open Polynomial Zudilin

theorem P_two_nonzero (a : ℝ) : P a 2 ≠ 0 := by
  intro h
  have hv : (P a 2).eval (baseRoot a + 1) = 1 / 4 := by
    rw [eval_P_two]
    dsimp [baseRoot]
    ring
  rw [h] at hv
  norm_num at hv

theorem P_two_root_exists (a : ℝ) :
    ∃ z : ℂ, (P a 2).eval₂ Complex.ofRealHom z = 0 := by
  exact ⟨(baseRoot a : ℂ), (P_two_complex_root_iff a _).mpr rfl⟩

theorem bridge_requires_root_condition :
    OriginalSum.B 0 0 1 1 ≠ (P 0 1).eval₂ Complex.ofRealHom ((1 : ℂ)^3) := by
  norm_num [OriginalSum.B, OriginalSum.term, OriginalSum.poch, Finset.sum_range_succ]

end IndependentReview

#print axioms IndependentReview.P_two_nonzero
#print axioms IndependentReview.P_two_root_exists
#print axioms IndependentReview.bridge_requires_root_condition
