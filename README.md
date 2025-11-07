mkdir -p build
cd build
cmake -DLLVM_DIR=/usr/lib/llvm-21/lib/cmake/llvm ..
cmake --build . -j

This produces:

build/lib/libAffineRecurrence.so
build/lib/libSimpleLICM.so
build/lib/libDerivedInductionVar.so

-------------------------------------

Test Inputs: Generate .ll from C files

clang-21 -O0 -Xclang -disable-O0-optnone -S -emit-llvm <c files> -o <c file with ll extension instead>

Do this for test files (input_for_div, input_for_licm)

-------------------------------------

SimpleLICM Command

opt -S
-load-pass-plugin build/lib/libSimpleLICM.so
-passes='function(mem2reg,loop-simplify,loop(simple-licm))'
<your ll file>

The pass prints “Hoisting” lines for each instruction it moves.

-------------------------------------

DerivedInductionVar command


opt -S
-load-pass-plugin build/lib/libDerivedInductionVar.so
-passes='function(mem2reg,loop-simplify,derived-iv)'
<your ll file>


Stderr prints each derived IV found and when it’s removed

Using diff before vs after to help verify:

opt -S -passes='function(mem2reg,loop-simplify,instnamer)'
tests/input_for_div.ll -o before.ll

opt -S
-load-pass-plugin build/lib/libDerivedInductionVar.so
-passes='function(mem2reg,loop-simplify,derived-iv,instnamer)'
tests/input_for_div.ll -o after.ll

diff -u before.ll after.ll | sed -n '1,200p'

