// RUN: clspv --long-vector %s -o %t.spv -int8
// RUN: spirv-dis -o %t2.spvasm %t.spv
// RUN: FileCheck %s < %t2.spvasm
// RUN: spirv-val --target-env vulkan1.0 %t.spv

kernel void foo(global int* a, global int8* b) {
  *a = all(*b);
}

// CHECK-DAG: [[int:%[a-zA-Z0-9_]+]] = OpTypeInt 32 0
// CHECK-DAG: [[bool:%[a-zA-Z0-9_]+]] = OpTypeBool
// CHECK-DAG: [[int_0:%[a-zA-Z0-9_]+]] = OpConstant [[int]] 0
// CHECK-DAG: [[int_1:%[a-zA-Z0-9_]+]] = OpConstant [[int]] 1
// CHECK-DAG: [[bool4:%[a-zA-Z0-9_]+]] = OpTypeVector [[bool]] 4
// CHECK:     [[vec10:%[a-zA-Z0-9_]+]] = OpSLessThan [[bool]] {{.*}} [[int_0]]
// CHECK:     [[vec11:%[a-zA-Z0-9_]+]] = OpSLessThan [[bool]] {{.*}} [[int_0]]
// CHECK:     [[vec12:%[a-zA-Z0-9_]+]] = OpSLessThan [[bool]] {{.*}} [[int_0]]
// CHECK:     [[vec13:%[a-zA-Z0-9_]+]] = OpSLessThan [[bool]] {{.*}} [[int_0]]
// CHECK:     [[vec20:%[a-zA-Z0-9_]+]] = OpSLessThan [[bool]] {{.*}} [[int_0]]
// CHECK:     [[vec21:%[a-zA-Z0-9_]+]] = OpSLessThan [[bool]] {{.*}} [[int_0]]
// CHECK:     [[vec22:%[a-zA-Z0-9_]+]] = OpSLessThan [[bool]] {{.*}} [[int_0]]
// CHECK:     [[vec23:%[a-zA-Z0-9_]+]] = OpSLessThan [[bool]] {{.*}} [[int_0]]
// CHECK:     [[vec1:%[a-zA-Z0-9_]+]] = OpCompositeConstruct [[bool4]] [[vec10]] [[vec11]] [[vec12]] [[vec13]]
// CHECK:     [[all1:%[a-zA-Z0-9_]+]] = OpAll [[bool]] [[vec1]]
// CHECK:     [[vec2:%[a-zA-Z0-9_]+]] = OpCompositeConstruct [[bool4]] [[vec20]] [[vec21]] [[vec22]] [[vec23]]
// CHECK:     [[all2:%[a-zA-Z0-9_]+]] = OpAll [[bool]] [[vec2]]
// CHECK:     [[and:%[a-zA-Z0-9_]+]] = OpLogicalAnd [[bool]] [[all1]] [[all2]]
// CHECK:     OpSelect [[int]] [[and]] [[int_1]] [[int_0]]

