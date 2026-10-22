import Zudilin.Basic
import Mathlib.Data.Complex.Basic
import Mathlib.Tactic.LinearCombination

/-!
The literal complex finite sum in equation (8). `w` is left arbitrary for
the endpoint cancellation identities; a cube-root-of-unity assumption is
needed only for converting its last summand into a real quadratic product.
Its equality with the recurrence-defined `P` is NOT assumed or proved here.
-/
namespace Zudilin.OriginalSum
open Polynomial
noncomputable section

def poch (z : ℂ) (n : ℕ) : ℂ := ∏ k ∈ Finset.range n, (z + k)

def term (w a t : ℂ) (n k : ℕ) : ℂ :=
  poch (w*t) k * poch (w^2*t) k * poch (a+t) (n-k) * poch (a-t+k) (n-k) /
    ((k.factorial : ℂ) * ((n-k).factorial : ℂ))

def B (w a t : ℂ) (n : ℕ) : ℂ :=
  (n.factorial : ℂ)⁻¹ * ∑ k ∈ Finset.range (n+1), term w a t n k

@[simp] theorem poch_zero (z : ℂ) : poch z 0 = 1 := by simp [poch]

theorem poch_eq_zero_of_factor (z : ℂ) (n j : ℕ) (hj : j < n) (hz : z + j = 0) :
    poch z n = 0 := by
  apply Finset.prod_eq_zero (Finset.mem_range.mpr hj)
  exact hz

theorem moving_factor_zero (a : ℂ) (n k : ℕ) (hk : k < n) :
    poch (a - (a + n - 1) + k) (n - k) = 0 := by
  apply poch_eq_zero_of_factor _ _ (n - k - 1) (by omega)
  have heq : n - k - 1 + k + 1 = n := by omega
  have hc := congrArg (fun m : ℕ => (m : ℂ)) heq
  push_cast at hc
  calc
    a - (a + (n : ℂ) - 1) + k + (n - k - 1 : ℕ) =
        ((n - k - 1 : ℕ) : ℂ) + k + 1 - n := by ring
    _ = 0 := sub_eq_zero.mpr hc

theorem term_moving_zero (w a : ℂ) (n k : ℕ) (hk : k < n) :
    term w a (a + n - 1) n k = 0 := by
  simp [term, moving_factor_zero a n k hk]

theorem sum_moving_single (w a : ℂ) (n : ℕ) :
    (∑ k ∈ Finset.range (n+1), term w a (a+n-1) n k) = term w a (a+n-1) n n := by
  apply Finset.sum_eq_single n
  · intro k hk hkn
    exact term_moving_zero w a n k (by have := Finset.mem_range.mp hk; omega)
  · intro hn
    exact False.elim (hn (Finset.mem_range.mpr (by omega)))

theorem moving_endpoint (w a : ℂ) (n : ℕ) :
    B w a (a+n-1) n =
      poch (w*(a+n-1)) n * poch (w^2*(a+n-1)) n / (n.factorial : ℂ)^2 := by
  rw [B, sum_moving_single]
  simp only [term, Nat.sub_self, poch_zero, Nat.factorial_zero, Nat.cast_one, mul_one]
  ring

theorem term_neg_parameter_zero (w a : ℂ) (n k : ℕ) (hk : k < n) :
    term w a (-a) n k = 0 := by
  have hz : poch (a + -a) (n-k) = 0 :=
    poch_eq_zero_of_factor _ _ 0 (by omega) (by ring)
  simp only [term, hz, mul_zero, zero_mul, zero_div]

theorem neg_parameter_endpoint (w a : ℂ) (n : ℕ) :
    B w a (-a) n = poch (w*(-a)) n * poch (w^2*(-a)) n / (n.factorial : ℂ)^2 := by
  have hs : (∑ k ∈ Finset.range (n+1), term w a (-a) n k) = term w a (-a) n n := by
    apply Finset.sum_eq_single n
    · intro k hk hkn
      exact term_neg_parameter_zero w a n k (by have := Finset.mem_range.mp hk; omega)
    · intro hn
      exact False.elim (hn (Finset.mem_range.mpr (by omega)))
  rw [B, hs]
  simp only [term, Nat.sub_self, poch_zero, Nat.factorial_zero, Nat.cast_one, mul_one]
  ring

theorem cube_eq_one (w : ℂ) (hw : w^2+w+1=0) : w^3=1 := by
  linear_combination (w-1)*hw

theorem paired_factor (w s : ℂ) (k : ℕ) (hw : w^2+w+1=0) :
    (w*s+k)*(w^2*s+k) = (k : ℂ)^2-k*s+s^2 := by
  have hw₃ := cube_eq_one w hw
  linear_combination (k : ℂ)*s*hw + s^2*hw₃

theorem paired_poch (w s : ℂ) (n : ℕ) (hw : w^2+w+1=0) :
    poch (w*s) n * poch (w^2*s) n =
      ∏ k ∈ Finset.range n, ((k : ℂ)^2-k*s+s^2) := by
  rw [poch, poch, ← Finset.prod_mul_distrib]
  exact Finset.prod_congr rfl (fun k _ => paired_factor w s k hw)

theorem moving_endpoint_product (w a : ℂ) (n : ℕ) (hw : w^2+w+1=0) :
    B w a (a+n-1) n =
      (∏ k ∈ Finset.range n, ((k : ℂ)^2-k*(a+n-1)+(a+n-1)^2)) /
        (n.factorial : ℂ)^2 := by
  rw [moving_endpoint, paired_poch w (a+n-1) n hw]

theorem quadratic_product_real (s : ℝ) (n : ℕ) :
    (∏ k ∈ Finset.range n, ((k : ℂ)^2-k*(s : ℂ)+(s : ℂ)^2)) =
      (quadProd (-s) n : ℂ) := by
  induction n with
  | zero => simp [quadProd]
  | succ n ih =>
    rw [Finset.prod_range_succ, ih, quadProd]
    simp only [quad, Complex.ofReal_mul, Complex.ofReal_add, Complex.ofReal_pow, Complex.ofReal_neg, Complex.ofReal_natCast]
    ring

theorem moving_endpoint_real (w : ℂ) (a : ℝ) (n : ℕ) (hw : w^2+w+1=0) :
    B w (a : ℂ) ((a : ℂ)+n-1) n =
      ((quadProd (-(a+n-1)) n / (n.factorial : ℝ)^2 : ℝ) : ℂ) := by
  rw [moving_endpoint_product w (a : ℂ) n hw]
  have hc : (a : ℂ) + n - 1 = ((a+n-1 : ℝ) : ℂ) := by push_cast; rfl
  rw [hc, quadratic_product_real]
  push_cast; rfl

theorem moving_endpoint_positive (w : ℂ) (a : ℝ) (n : ℕ) (hw : w^2+w+1=0)
    (hs : a+n-1 ≠ 0) :
    ∃ r : ℝ, 0 < r ∧ B w (a : ℂ) ((a : ℂ)+n-1) n = (r : ℂ) := by
  refine ⟨quadProd (-(a+n-1)) n / (n.factorial : ℝ)^2, ?_, moving_endpoint_real w a n hw⟩
  exact div_pos (quadProd_pos (neg_ne_zero.mpr hs) n)
    (sq_pos_of_ne_zero (factorial_cast_ne_zero n))

theorem term_zero_argument (w a : ℂ) (n k : ℕ) (hk : 0 < k) :
    term w a 0 n k = 0 := by
  have hz : poch (w*0) k = 0 := poch_eq_zero_of_factor _ _ 0 hk (by ring)
  simp only [term, hz, zero_mul, zero_div]

theorem zero_argument (w a : ℂ) (n : ℕ) :
    B w a 0 n = (poch a n)^2 / (n.factorial : ℂ)^2 := by
  have hs : (∑ k ∈ Finset.range (n+1), term w a 0 n k) = term w a 0 n 0 := by
    apply Finset.sum_eq_single 0
    · intro k hk hk₀
      exact term_zero_argument w a n k (by omega)
    · intro hn
      exact False.elim (hn (Finset.mem_range.mpr (by omega)))
  rw [B, hs]
  simp only [term, Nat.sub_zero, poch_zero, Nat.factorial_zero, Nat.cast_one,
    Nat.cast_zero, mul_one, one_mul, add_zero, sub_zero]
  ring

end
end Zudilin.OriginalSum





