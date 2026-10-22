import Zudilin.Basic
import Mathlib.Data.Complex.Basic

namespace Zudilin
open Polynomial
noncomputable section

def baseRoot (a : ℝ) : ℝ := -a^2 * (a + 1)^2

theorem baseRoot_nonpos (a : ℝ) : baseRoot a ≤ 0 := by
  dsimp [baseRoot]
  exact mul_nonpos_of_nonpos_of_nonneg (neg_nonpos.mpr (sq_nonneg a)) (sq_nonneg _)

theorem baseRoot_neg {a : ℝ} (ha : a ≠ 0) (ha₁ : a + 1 ≠ 0) : baseRoot a < 0 := by
  dsimp [baseRoot]
  exact mul_neg_of_neg_of_pos (neg_neg_of_pos (sq_pos_of_ne_zero ha))
    (sq_pos_of_ne_zero ha₁)

theorem baseRoot_lt_cube {a : ℝ} (ha₁ : a + 1 ≠ 0) : baseRoot a < (a + 1)^3 := by
  have hquad : 0 < a^2 + a + 1 := by nlinarith [sq_nonneg (a + 1 / 2)]
  have hprod := mul_pos (sq_pos_of_ne_zero ha₁) hquad
  have hid : baseRoot a - (a + 1)^3 = -(a + 1)^2 * (a^2 + a + 1) := by
    dsimp [baseRoot]
    ring
  nlinarith [hid]

theorem baseRoot_lt_endpoint {a : ℝ} (ha : a ≠ 0) (ha₁ : a + 1 ≠ 0) :
    baseRoot a < endpoint a 2 := by
  have heq : a + (2 : ℕ) - 1 = a + 1 := by push_cast; ring
  simpa only [endpoint, heq] using lt_min (baseRoot_neg ha ha₁) (baseRoot_lt_cube ha₁)

theorem eval_P_two (a x : ℝ) : (P a 2).eval x = (x + a^2 * (a + 1)^2) / 4 := by
  simp [P, C_two]
  ring

theorem eval_P_two_complex (a : ℝ) (z : ℂ) :
    (P a 2).eval₂ Complex.ofRealHom z = (z - (baseRoot a : ℂ)) / 4 := by
  simp only [P, C_two, eval₂_mul, eval₂_add, eval₂_C, eval₂_X, eval₂_pow, eval₂_one, baseRoot, map_inv₀, map_pow, map_mul, map_add, map_one, map_neg]
  norm_num
  ring

theorem P_two_complex_root_iff (a : ℝ) (z : ℂ) :
    (P a 2).eval₂ Complex.ofRealHom z = 0 ↔ z = (baseRoot a : ℂ) := by
  rw [eval_P_two_complex]
  simp only [div_eq_zero_iff, sub_eq_zero, OfNat.ofNat_ne_zero, or_false]

theorem P_two_all_complex_roots (a : ℝ) (z : ℂ)
    (hz : (P a 2).eval₂ Complex.ofRealHom z = 0) :
    ∃ r : ℝ, r ≤ 0 ∧ z = (r : ℂ) := by
  exact ⟨baseRoot a, baseRoot_nonpos a, (P_two_complex_root_iff a z).mp hz⟩

theorem P_two_all_complex_roots_strict {a : ℝ} (ha : Nonexceptional a) (z : ℂ)
    (hz : (P a 2).eval₂ Complex.ofRealHom z = 0) :
    ∃ r : ℝ, r < endpoint a 2 ∧ z = (r : ℂ) := by
  have ha₀ : a ≠ 0 := by simpa using ha 0
  have ha₁ : a + 1 ≠ 0 := by simpa using ha 1
  exact ⟨baseRoot a, baseRoot_lt_endpoint ha₀ ha₁, (P_two_complex_root_iff a z).mp hz⟩

end
end Zudilin





