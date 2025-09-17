//===--- BlackHole.swift --------------------------------------*- swift -*-===//
//
// This source file is part of the Swift Numerics open source project
//
// Copyright (c) 2021 Apple Inc. and the Swift Numerics project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

#if canImport(_NumericsShims)
import _NumericsShims
#endif

@_transparent
public func blackHole<T>(_ thing: T) {
  withUnsafePointer(to: thing) {
    #if canImport(_NumericsShims)
    _numerics_optimization_barrier($0)
    #else
    // Fallback no-op when internal shim is not available.
    _ = $0
    #endif
  }
}
