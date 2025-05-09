// RUN: clspv %target %s -o %t.spv -pod-pushconstant -cluster-pod-kernel-args -spv-version=1.4
// RUN: spirv-dis %t.spv -o %t.spvasm
// RUN: FileCheck %s < %t.spvasm
// RUN: clspv-reflection %t.spv -o %t.map --target-env vulkan1.2
// RUN: FileCheck --check-prefix=MAP %s < %t.map
// RUN: spirv-val --target-env vulkan1.2 %t.spv

// CHECK: OpDecorate {{.*}} Block
// CHECK: OpMemberDecorate [[cluster:%[a-zA-Z0-9_]+]] 0 Offset 0
// CHECK: OpMemberDecorate [[cluster]] 1 Offset 4
// CHECK: OpMemberDecorate [[block:%[a-zA-Z0-9_]+]] 0 Offset 0
// CHECK: OpDecorate [[block]] Block
// CHECK-DAG: [[int:%[a-zA-Z0-9_]+]] = OpTypeInt 32 0
// CHECK-DAG: [[int0:%[a-zA-Z0-9_]+]] = OpConstant [[int]] 0
// CHECK-DAG: [[cluster]] = OpTypeStruct [[int]] [[int]]
// CHECK-DAG: [[block]] = OpTypeStruct [[cluster]]
// CHECK-DAG: [[ptr:%[a-zA-Z0-9_]+]] = OpTypePointer PushConstant [[block]]
// CHECK-DAG: [[var:%[a-zA-Z0-9_]+]] = OpVariable [[ptr]] PushConstant
// CHECK: [[gep:%[a-zA-Z0-9_]+]] = OpAccessChain {{.*}} [[var]] [[int0]]
// CHECK: [[ld:%[a-zA-Z0-9_]+]] = OpLoad [[cluster]] [[gep]]
// CHECK: [[copy:%[a-zA-Z0-9_]+]] = OpCopyLogical {{.*}} [[ld]]
// CHECK: [[x:%[a-zA-Z0-9_]+]] = OpCompositeExtract [[int]] [[copy]] 0
// CHECK: [[y:%[a-zA-Z0-9_]+]] = OpCompositeExtract [[int]] [[copy]] 1
// CHECK: OpIAdd [[int]] [[x]] [[y]]
// CHECK: [[gep:%[a-zA-Z0-9_]+]] = OpAccessChain {{.*}} [[var]] [[int0]]
// CHECK: [[ld:%[a-zA-Z0-9_]+]] = OpLoad [[cluster]] [[gep]]
// CHECK: [[copy:%[a-zA-Z0-9_]+]] = OpCopyLogical {{.*}} [[ld]]
// CHECK: [[x:%[a-zA-Z0-9_]+]] = OpCompositeExtract [[int]] [[copy]] 0
// CHECK: [[y:%[a-zA-Z0-9_]+]] = OpCompositeExtract [[int]] [[copy]] 1
// CHECK: OpIAdd [[int]] [[x]] [[y]]

//      MAP: kernel,foo,arg,out,argOrdinal,0,descriptorSet,0,binding,0,offset,0,argKind,buffer
// MAP-NEXT: kernel,foo,arg,x,argOrdinal,1,offset,0,argKind,pod_pushconstant,argSize,4
// MAP-NEXT: kernel,foo,arg,y,argOrdinal,2,offset,4,argKind,pod_pushconstant,argSize,4
//      MAP: kernel,bar,arg,out,argOrdinal,0,descriptorSet,0,binding,0,offset,0,argKind,buffer
// MAP-NEXT: kernel,bar,arg,a,argOrdinal,1,offset,0,argKind,pod_pushconstant,argSize,4
// MAP-NEXT: kernel,bar,arg,b,argOrdinal,2,offset,4,argKind,pod_pushconstant,argSize,4

kernel void foo(global int* out, int x, int y) {
  *out = x + y;
}

kernel void bar(global int* out, int a, int b) {
  *out = a + b;
}

