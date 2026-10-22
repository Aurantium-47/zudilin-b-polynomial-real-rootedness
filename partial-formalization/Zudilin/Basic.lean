import Mathlib.Algebra.Polynomial.Roots
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum

/-!
Zudilin arXiv:1504.07696v2, §4, Lemma 3.
`C a n` is the factorial-scaled polynomial `(n!)² P_n^a`.
`P a n` restores the original normalization. The recurrence equivalence is
proved below, rather than assumed. The full real-rootedness theorem is pending.
-/

namespace Zudilin
open Polynomial

noncomputable section

def N (a : ℝ) (n : ℕ) : ℝ :=
  2 * (n : ℝ)^2 + 3 * n * (a + 1) + a^2 + 3 * a + 1

def C (a : ℝ) : ℕ → ℝ[X]
  | 0 => 1
  | 1 => Polynomial.C (a^2)
  | n + 2 => Polynomial.C (N a n) * C a (n + 1) +
      Polynomial.C (n + 1 : ℝ) * (X - Polynomial.C ((n + a)^3)) * C a n

def P (a : ℝ) (n : ℕ) : ℝ[X] :=
  Polynomial.C (((n.factorial : ℝ)^2)⁻¹) * C a n

@[simp] theorem C_zero (a : ℝ) : C a 0 = 1 := rfl
@[simp] theorem C_one (a : ℝ) : C a 1 = Polynomial.C (a^2) := rfl
theorem C_recurrence (a : ℝ) (n : ℕ) :
    C a (n + 2) = Polynomial.C (N a n) * C a (n + 1) +
      Polynomial.C (n + 1 : ℝ) * (X - Polynomial.C ((n + a)^3)) * C a n := rfl

def rising (a : ℝ) : ℕ → ℝ
  | 0 => 1
  | n + 1 => rising a n * (a + n)

theorem eval_C_zero (a : ℝ) (n : ℕ) : (C a n).eval 0 = (rising a n)^2 := by
  induction n using Nat.twoStepInduction with
  | zero => simp [rising]
  | one => simp [rising]
  | more n ih₀ ih₁ =>
    simp only [C_recurrence, eval_add, eval_mul, eval_C, eval_sub, eval_X, ih₀, ih₁]
    simp only [rising, N, Nat.cast_add, Nat.cast_one]
    ring

def quad (a : ℝ) (k : ℕ) : ℝ := (k : ℝ)^2 + k * a + a^2

def quadProd (a : ℝ) : ℕ → ℝ
  | 0 => 1
  | n + 1 => quadProd a n * quad a n

theorem eval_C_neg_cube (a : ℝ) (n : ℕ) :
    (C a n).eval (-a^3) = quadProd a n := by
  induction n using Nat.twoStepInduction with
  | zero => simp [quadProd]
  | one => simp [quadProd, quad]
  | more n ih₀ ih₁ =>
    simp only [C_recurrence, eval_add, eval_mul, eval_C, eval_sub, eval_X, ih₀, ih₁]
    simp only [quadProd, quad, N, Nat.cast_add, Nat.cast_one]
    ring

theorem factorial_cast_ne_zero (n : ℕ) : (n.factorial : ℝ) ≠ 0 :=
  Nat.cast_ne_zero.mpr (Nat.factorial_ne_zero n)

@[simp] theorem P_zero (a : ℝ) : P a 0 = 1 := by simp [P]
@[simp] theorem P_one (a : ℝ) : P a 1 = Polynomial.C (a^2) := by simp [P]

theorem eval_P (a x : ℝ) (n : ℕ) :
    (P a n).eval x = (C a n).eval x / (n.factorial : ℝ)^2 := by
  simp [P, div_eq_mul_inv, mul_comm]

theorem P_recurrence (a : ℝ) (n : ℕ) :
    P a (n + 2) = Polynomial.C (N a n / (n + 2 : ℝ)^2) * P a (n + 1) +
      Polynomial.C (1 / ((n + 2 : ℝ)^2 * (n + 1))) *
        (X - Polynomial.C ((n + a)^3)) * P a n := by
  letI : Infinite ℝ := Infinite.of_injective (fun n : ℕ => (n : ℝ)) Nat.cast_injective
  apply Polynomial.funext
  intro x
  simp only [eval_add, eval_mul, eval_C, eval_sub, eval_X, eval_P, C_recurrence]
  simp only [show n + 2 = (n + 1) + 1 by omega, Nat.factorial_succ, Nat.cast_mul, Nat.cast_add, Nat.cast_one]
  have hn₁ : (n : ℝ) + 1 ≠ 0 := ne_of_gt (by positivity)
  have hn₂ : (n : ℝ) + 2 ≠ 0 := ne_of_gt (by positivity)
  have hn₂' : (n : ℝ) + 1 + 1 ≠ 0 := ne_of_gt (by positivity)
  field_simp [factorial_cast_ne_zero, hn₁, hn₂, hn₂']
  ring

theorem eval_P_zero (a : ℝ) (n : ℕ) :
    (P a n).eval 0 = (rising a n)^2 / (n.factorial : ℝ)^2 := by
  rw [eval_P, eval_C_zero]

theorem eval_P_neg_cube (a : ℝ) (n : ℕ) :
    (P a n).eval (-a^3) = quadProd a n / (n.factorial : ℝ)^2 := by
  rw [eval_P, eval_C_neg_cube]

theorem quad_pos {a : ℝ} (ha : a ≠ 0) (k : ℕ) : 0 < quad a k := by
  have ha₂ : 0 < a^2 := sq_pos_of_ne_zero ha
  have hs : 0 ≤ ((k : ℝ) + a / 2)^2 := sq_nonneg _
  dsimp [quad]
  nlinarith

theorem quadProd_pos {a : ℝ} (ha : a ≠ 0) (n : ℕ) : 0 < quadProd a n := by
  induction n with
  | zero => norm_num [quadProd]
  | succ n ih => exact mul_pos ih (quad_pos ha n)

theorem eval_P_neg_cube_pos {a : ℝ} (ha : a ≠ 0) (n : ℕ) :
    0 < (P a n).eval (-a^3) := by
  rw [eval_P_neg_cube]
  exact div_pos (quadProd_pos ha n) (sq_pos_of_ne_zero (factorial_cast_ne_zero n))

theorem P_ne_zero_of_parameter_ne_zero {a : ℝ} (ha : a ≠ 0) (n : ℕ) : P a n ≠ 0 := by
  intro h
  have hp := eval_P_neg_cube_pos ha n
  simp [h] at hp

def Nonexceptional (a : ℝ) : Prop := ∀ k : ℕ, a + k ≠ 0

theorem rising_ne_zero {a : ℝ} (ha : Nonexceptional a) (n : ℕ) : rising a n ≠ 0 := by
  induction n with
  | zero => norm_num [rising]
  | succ n ih => exact mul_ne_zero ih (ha n)

theorem eval_P_zero_pos {a : ℝ} (ha : Nonexceptional a) (n : ℕ) :
    0 < (P a n).eval 0 := by
  rw [eval_P_zero]
  exact div_pos (sq_pos_of_ne_zero (rising_ne_zero ha n))
    (sq_pos_of_ne_zero (factorial_cast_ne_zero n))

theorem recurrence_unique (a : ℝ) (F : ℕ → ℝ[X])
    (h₀ : F 0 = 1) (h₁ : F 1 = Polynomial.C (a^2))
    (hrec : ∀ n, F (n + 2) = Polynomial.C (N a n / (n + 2 : ℝ)^2) * F (n + 1) +
      Polynomial.C (1 / ((n + 2 : ℝ)^2 * (n + 1))) *
        (X - Polynomial.C ((n + a)^3)) * F n) : ∀ n, F n = P a n := by
  intro n
  induction n using Nat.twoStepInduction with
  | zero => simpa using h₀
  | one => simpa using h₁
  | more n ih₀ ih₁ => rw [hrec, P_recurrence, ih₀, ih₁]

theorem eval_P_at_next_root (a q : ℝ) (n : ℕ)
    (hq : (P a (n + 1)).eval q = 0) :
    (P a (n + 2)).eval q = (1 / ((n + 2 : ℝ)^2 * (n + 1))) *
      (q - (n + a)^3) * (P a n).eval q := by
  rw [P_recurrence]
  simp only [eval_add, eval_mul, eval_C, eval_sub, eval_X, hq, mul_zero, zero_add]

theorem recurrence_factor_neg (a q : ℝ) (n : ℕ) (hq : q < (n + a)^3) :
    (1 / ((n + 2 : ℝ)^2 * (n + 1))) * (q - (n + a)^3) < 0 := by
  exact mul_neg_of_pos_of_neg (by positivity) (sub_neg.mpr hq)

theorem eval_P_next_neg (a q : ℝ) (n : ℕ)
    (hq : (P a (n + 1)).eval q = 0) (hbound : q < (n + a)^3)
    (hp : 0 < (P a n).eval q) : (P a (n + 2)).eval q < 0 := by
  rw [eval_P_at_next_root a q n hq]
  exact mul_neg_of_neg_of_pos (recurrence_factor_neg a q n hbound) hp

theorem eval_P_next_pos (a q : ℝ) (n : ℕ)
    (hq : (P a (n + 1)).eval q = 0) (hbound : q < (n + a)^3)
    (hp : (P a n).eval q < 0) : 0 < (P a (n + 2)).eval q := by
  rw [eval_P_at_next_root a q n hq]
  exact mul_pos_of_neg_of_neg (recurrence_factor_neg a q n hbound) hp

def endpoint (a : ℝ) (n : ℕ) : ℝ := min 0 ((a + n - 1)^3)

theorem endpoint_le_zero (a : ℝ) (n : ℕ) : endpoint a n ≤ 0 := min_le_left _ _

theorem endpoint_next_le_cube (a : ℝ) (n : ℕ) : endpoint a (n + 1) ≤ (n + a)^3 := by
  have heq : a + (n + 1 : ℕ) - 1 = (n : ℝ) + a := by push_cast; ring
  simpa only [endpoint, heq] using (min_le_right 0 (((n : ℝ) + a)^3))

theorem endpoint_monotone (a : ℝ) : Monotone (endpoint a) := by
  intro i j hij
  apply min_le_min le_rfl
  apply (show Odd (3 : ℕ) by decide).pow_le_pow.mpr
  exact sub_le_sub_right (add_le_add_left (Nat.cast_le.mpr hij) a) 1

theorem C_two (a : ℝ) : C a 2 = X + Polynomial.C (a^2 * (a + 1)^2) := by
  letI : Infinite ℝ := Infinite.of_injective (fun n : ℕ => (n : ℝ)) Nat.cast_injective
  apply Polynomial.funext
  intro x
  simp [C, N]
  ring

end
end Zudilin

