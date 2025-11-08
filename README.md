!!! (REQUIREMENTS: LLVM-21 & CMAKE 3.2)

A) SimpleLICM
--------------
Runs the LICM pass to hoist invariant code from loops. Redirects to terminal to see output quickly. Can also view simple_licm_demo.ll to see instructions moved into preheader.

/usr/lib/llvm-21/bin/opt -load-pass-plugin build/lib/libSimpleLICM.so -passes='function(mem2reg,loop-simplify,loop(simple-licm))' -S input_for_licm.ll -o - 2>&1


B) DerivedInductionVar
-----------------------
First, without applying the pass --> saved to before.ll:

/usr/lib/llvm-21/bin/opt -S -passes='function(mem2reg,loop-simplify,instnamer)' input_for_div.ll -o before.ll

Now, we apply the pass --> saved to after.ll:

/usr/lib/llvm-21/bin/opt -load-pass-plugin build/lib/libDerivedInductionVar.so -passes='function(mem2reg,loop-simplify,derived-iv)' input_for_div.ll -o after.ll

Finally, using grep to verify changes between before.ll and after.ll:

grep -n 'phi' before.ll (168 phi instructions based on test cases)
grep -n 'phi' after.ll (0 phi instructions after running the pass)

C) Test Cases
-----------------------
Generated using ChatGPT as C programs (input_for_div.c & input_for_licm.c)
