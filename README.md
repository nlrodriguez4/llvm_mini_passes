Build Instructions
------------------
1) Replace CMakeLists from llvm-tutor/lib with the newly provided one (so sources are defined)

2) Add the .cpp files to llvm-tutor/lib

2) Add the .c input files to llvm-tutor/inputs

3) Rebuild llvm-tutor to create:
     build/lib/libSimpleLICM.so
     build/lib/libDerivedInductionVar.so





Generate LLVM IR from C tests
-----------------------------
Use clang to get LL files:

   clang-21 -O0 -Xclang -disable-O0-optnone -S -emit-llvm inputs/input_for_div.c -o input_for_div.ll
   clang-21 -O0 -Xclang -disable-O0-optnone -S -emit-llvm inputs/input_for_licm.c -o input_for_licm.ll




A) SimpleLICM
--------------
Runs the LICM pass to hoist invariant code from loops.

opt -load-pass-plugin ./build/lib/libSimpleLICM.so -passes='function(mem2reg,loop-simplify,loop(simple-licm))'   -S input_for_licm.ll -o - 2>&1

- "Hoisting:" messages in the terminal
- Can also view `simple_licm_demo.ll` to see instructions moved into preheader.





B) DerivedInductionVar
-----------------------
First do the test without applying the pass --> save to before.ll:

opt -S -passes='function(mem2reg,loop-simplify,instnamer)' input_for_div.ll -o before.ll

Then do the same thing but apply the pass --> save to after.ll:

opt -load-pass-plugin build/lib/libDerivedInductionVar.so -passes='function(mem2reg,loop-simplify,derived-iv)' input_for_div.ll -o after.ll

Now use to diff to verify changes between before.ll and after.ll:

diff -u before.ll after.ll | sed -n '1,200p'

Check output:
- Terminal prints "[iv-elim] removed PHI ..."
- In `out/div.after.ll`, derived PHIs should be gone.


