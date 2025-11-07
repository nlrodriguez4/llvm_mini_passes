// Test cases created by GenAI (ChatGPT)

#include <stdint.h>
#include <stdio.h>

#define N 256

// Prevent accidental inlining that might collapse loops at -O0 on some setups.
#if defined(__GNUC__)
#define NOINLINE __attribute__((noinline))
#else
#define NOINLINE
#endif

// Volatile globals to keep side effects and prevent some constant folding
volatile int g_sink = 0;
volatile int g_flag = 1;

// ------------------------------
// 1) Pure register arithmetic — should HOIST (all inside-loop constants/arith).
// Expect: sext/zext/add/mul/sub/etc hoisted; no memory touched.
NOINLINE int case_reg_invariants(int n) {
  int sum = 0;
  for (int i = 0; i < n; ++i) {
    int a = n * 2;        // invariant
    int b = a + 5;        // invariant
    int c = b - 3;        // invariant
    sum += c + i;
  }
  return sum;
}

// ------------------------------
// 2) Inner-loop invariant wrt inner 'k', variant wrt outer 'j'.
// Expect: inside inner loop, computations using only 'j' are invariant and hoisted
// to the INNER loop preheader (not all the way outside the outer loop).
NOINLINE int case_nested_inner_invariant(int n) {
  int out = 0;
  for (int j = 0; j < n; ++j) {
    for (int k = 0; k < n; ++k) {
      int t = (j * 3) + 7;   // invariant for the inner loop, hoist to inner preheader
      out += t + k;
    }
  }
  return out;
}

// ------------------------------
// 3) GEP vs LOAD — only the GEP is register-only and should HOIST; load must NOT.
// Expect: GEPs hoisted, but 'tmp = arr[idx]' not hoisted.
NOINLINE int case_gep_vs_load(int *arr, int idx, int n) {
  int acc = 0;
  for (int i = 0; i < n; ++i) {
    int *p = &arr[idx];   // GEP (invariant) — hoistable
    int tmp = *p;         // LOAD — must NOT hoist
    acc += tmp + i;
  }
  return acc;
}

// ------------------------------
// 4) PHI presence — the running sum is via PHI and must NOT be hoisted.
// Expect: no hoist for PHI; only independent invariant arithmetic (if any).
NOINLINE int case_phi_not_hoisted(int n) {
  int s = 0;
  for (int i = 0; i < n; ++i) {
    int k = n + 1;   // invariant — hoistable
    s += k + i;      // s is via PHI — cannot be hoisted
  }
  return s;
}

// ------------------------------
// 5) Invariant address + STORE — store writes memory; must NOT hoist.
// Expect: GEP may hoist, but store remains in loop.
NOINLINE void case_store_not_hoisted(int *arr, int idx, int n) {
  for (int i = 0; i < n; ++i) {
    int *p = &arr[idx]; // GEP — hoistable
    *p = i;             // STORE — NOT hoistable
  }
}

// ------------------------------
// 6) Volatile load — never hoist memory ops, volatile or not.
// Expect: no hoist of the load; any adjacent invariant reg ops may hoist.
NOINLINE int case_volatile_not_hoisted(volatile int *vp, int n) {
  int r = 0;
  for (int i = 0; i < n; ++i) {
    int x = (int)n * 4; // invariant — hoistable
    int y = *vp;        // volatile LOAD — must NOT be hoisted
    r += (x ^ y) + i;
  }
  return r;
}

// ------------------------------
// 7) Division: safe vs potentially trapping.
// (a) Denominator is a nonzero constant => safe to speculate, HOIST.
// (b) Denominator may be zero => should NOT be hoisted (isSafeToSpeculate false).
NOINLINE int case_division_safe(int n) {
  int acc = 0;
  for (int i = 0; i < n; ++i) {
    int d = 3;          // invariant and nonzero — hoistable
    int q = n / d;      // safe division — hoistable
    acc += q + i;
  }
  return acc;
}
NOINLINE int case_division_unsafe(int n) {
  int acc = 0;
  for (int i = 0; i < n; ++i) {
    int d = (g_flag ? 0 : 1); // may be zero at runtime — DO NOT hoist division
    int q = n / d;            // should remain inside loop
    acc += q + i;             // (this is UB if g_flag keeps 0; it's just to test safety)
  }
  return acc;
}

// ------------------------------
// 8) Function call — even if "pure", calls mayHaveSideEffects by default.
// Expect: call NOT hoisted; surrounding register-only invariants may hoist.
static NOINLINE int helper_square(int x) { return x * x; }
NOINLINE int case_call_not_hoisted(int n) {
  int sum = 0;
  for (int i = 0; i < n; ++i) {
    int t = n + 5;                 // invariant — hoistable
    int s = helper_square(i);      // call — NOT hoistable
    sum += t + s;
  }
  return sum;
}

// ------------------------------
// 9) Casts (sext/zext/bitcasts) and simple math — all hoistable.
// Expect: the casts and derived arithmetic hoisted.
NOINLINE long case_casts(int n) {
  long acc = 0;
  for (int i = 0; i < n; ++i) {
    long ln = (long)n;             // sext/zext — hoistable
    long k  = (ln * 2) + 17;       // reg-reg — hoistable
    acc += k + i;
  }
  return acc;
}

// ------------------------------
// 10) Invariant branch condition: icmp is invariant, but the branch itself is a terminator.
// Expect: the icmp hoists; the terminator obviously cannot.
// (Gives your pass a chance to hoist a non-terminator used by control flow.)
NOINLINE int case_invariant_cond(int n) {
  int acc = 0;
  for (int i = 0; i < n; ++i) {
    if (n > 10) {      // icmp is invariant — hoistable; branch stays.
      acc += 3;
    } else {
      acc += i;
    }
  }
  return acc;
}

// A tiny main so the file links if you ever build a native exe (not required for opt testing).
int main(void) {
  static int A[N], B[N];
  for (int i = 0; i < N; ++i) { A[i] = i; B[i] = N - i; }

  int s = 0;
  s += case_reg_invariants(32);
  s += case_nested_inner_invariant(32);
  s += case_gep_vs_load(A, 3, 32);
  s += case_phi_not_hoisted(32);
  case_store_not_hoisted(B, 7, 32);
  s += case_volatile_not_hoisted(&g_sink, 32);
  s += case_division_safe(32);
  // case_division_unsafe(32); // intentionally not called to avoid UB at runtime
  s += case_call_not_hoisted(32);
  s += (int)case_casts(32);
  s += case_invariant_cond(32);

  printf("%d\n", s); // side effect to keep things reachable
  return 0;
}

