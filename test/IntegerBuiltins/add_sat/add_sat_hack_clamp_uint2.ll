
; RUN: clspv-opt --passes=replace-opencl-builtin,replace-llvm-intrinsics -hack-clamp-width %s -o %t.ll
; RUN: FileCheck %s < %t.ll

; AUTO-GENERATED TEST FILE
; This test was generated by add_sat_hack_clamp_test_gen.cpp.
; Please modify the that file and regenerate the tests to make changes.

target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "spir-unknown-unknown"

define <2 x i32> @add_sat_uint2(<2 x i32> %a, <2 x i32> %b) {
entry:
 %call = call <2 x i32> @_Z7add_satDv2_jS_(<2 x i32> %a, <2 x i32> %b)
 ret <2 x i32> %call
}

declare <2 x i32> @_Z7add_satDv2_jS_(<2 x i32>, <2 x i32>)

; CHECK: [[call:%[a-zA-Z0-9_.]+]] = call { <2 x i32>, <2 x i32> } @_Z8spirv.op.149.Dv2_jDv2_j(i32 149, <2 x i32> %a, <2 x i32> %b)
; CHECK: [[ex0:%[a-zA-Z0-9_.]+]] = extractvalue { <2 x i32>, <2 x i32> } [[call]], 0
; CHECK: [[ex1:%[a-zA-Z0-9_.]+]] = extractvalue { <2 x i32>, <2 x i32> } [[call]], 1
; CHECK: [[cmp:%[a-zA-Z0-9_.]+]] = icmp eq <2 x i32> [[ex1]], zeroinitializer
; CHECK: [[sel:%[a-zA-Z0-9_.]+]] = select <2 x i1> [[cmp]], <2 x i32> [[ex0]], <2 x i32> splat (i32 -1)
; CHECK: ret <2 x i32> [[sel]]
