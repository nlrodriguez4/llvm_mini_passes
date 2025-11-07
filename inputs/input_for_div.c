// Test cases made using GenAI (ChatGPT)

int foo(int N, int M) {
  int sum = 0;

  // Case 1: derived k,t live across inner iterations (true recurrences)
  for (int i = 0; i < N; ++i) {
    int base1 = 3*i + 7;
    int base2 = 100 - 4*i;

    int k = base1;   // start depends on outer i
    int t = base2;   // start depends on outer i
    for (int j = 0; j < M; ++j) {
      k += 2;        // step +2 → AddRec {base1,+,2}<inner>
      t += 1;        // step +1 → AddRec {base2,+,1}<inner>
      sum += (k ^ t) + j;
    }
  }

  // Case 2: two different derived IVs in inner loop
  for (int i = 0; i < N; ++i) {
    int a = 5*i;     // start depends on outer i
    int b = i - 10;  // start depends on outer i
    for (int k = 0; k < M; ++k) {
      a += 5;        // {5*i,+,5}<inner>
      b += -3;       // {i-10,+,-3}<inner>
      sum += a - b + k;
    }
  }

  // Case 3: one non-affine (should NOT be reported) + one affine derived
  for (int i = 0; i < N; ++i) {
    int m = i + 1;           // non-affine update below
    int n = 42 + 2*i;        // derived start
    for (int j = 0; j < M; ++j) {
      m *= 2;                // NOT an affine AddRec → skip
      n += 4;                // {42+2*i,+,4}<inner> → report
      sum += (m & n);
    }
  }

  return sum;
}

int bar(int N, int M, int P) {
  int acc = 0;
  for (int i = 0; i < N; ++i) {
    for (int j = 1; j < M; ++j) {
      int r = 2*i + j;   // start depends on outer i,j
      int s = 10*j - i;  // start depends on outer i,j
      for (int p = 0; p < P; ++p) {
        r += 2;          // {2*i + j,+,2}<innermost>
        s += -1;         // {10*j - i,+,-1}<innermost>
        acc += r ^ s ^ p;
      }
    }
  }
  return acc;
}

