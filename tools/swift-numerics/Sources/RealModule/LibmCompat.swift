// LibmCompat.swift
// Single place for platform math wrappers used by RealModule sources.
// This avoids duplicate Swift-function declarations across multiple files.
//
// The functions forward to platform math functions (Darwin/Glibc) so the
// vendored package can compile even if internal `_NumericsShims` isn't visible.

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

// MARK: - Float (32-bit) wrappers
@inlinable
func libm_cosf(_ x: Float) -> Float { return Darwin.cosf(x) }
@inlinable
func libm_sinf(_ x: Float) -> Float { return Darwin.sinf(x) }
@inlinable
func libm_tanf(_ x: Float) -> Float { return Darwin.tanf(x) }
@inlinable
func libm_acosf(_ x: Float) -> Float { return Darwin.acosf(x) }
@inlinable
func libm_asinf(_ x: Float) -> Float { return Darwin.asinf(x) }
@inlinable
func libm_atanf(_ x: Float) -> Float { return Darwin.atanf(x) }
@inlinable
func libm_coshf(_ x: Float) -> Float { return Darwin.coshf(x) }
@inlinable
func libm_sinhf(_ x: Float) -> Float { return Darwin.sinhf(x) }
@inlinable
func libm_tanhf(_ x: Float) -> Float { return Darwin.tanhf(x) }
@inlinable
func libm_acoshf(_ x: Float) -> Float { return Darwin.acoshf(x) }
@inlinable
func libm_asinhf(_ x: Float) -> Float { return Darwin.asinhf(x) }
@inlinable
func libm_atanhf(_ x: Float) -> Float { return Darwin.atanhf(x) }
@inlinable
func libm_expf(_ x: Float) -> Float { return Darwin.expf(x) }
@inlinable
func libm_expm1f(_ x: Float) -> Float { return Darwin.expm1f(x) }
@inlinable
func libm_logf(_ x: Float) -> Float { return Darwin.logf(x) }
@inlinable
func libm_log1pf(_ x: Float) -> Float { return Darwin.log1pf(x) }
@inlinable
func libm_erff(_ x: Float) -> Float { return Darwin.erff(x) }
@inlinable
func libm_erfcf(_ x: Float) -> Float { return Darwin.erfcf(x) }
@inlinable
func libm_exp2f(_ x: Float) -> Float { return Darwin.exp2f(x) }
#if os(macOS)
@inlinable
func libm_exp10f(_ x: Float) -> Float { return __exp10f(x) }
#endif
@inlinable
func libm_hypotf(_ x: Float, _ y: Float) -> Float { return Darwin.hypotf(x, y) }
@inlinable
func libm_tgammaf(_ x: Float) -> Float { return Darwin.tgammaf(x) }
@inlinable
func libm_log2f(_ x: Float) -> Float { return Darwin.log2f(x) }
@inlinable
func libm_log10f(_ x: Float) -> Float { return Darwin.log10f(x) }
@inlinable
func libm_powf(_ x: Float, _ y: Float) -> Float { return Darwin.powf(x, y) }
@inlinable
func libm_cbrtf(_ x: Float) -> Float { return Darwin.cbrtf(x) }
@inlinable
func libm_atan2f(_ y: Float, _ x: Float) -> Float { return Darwin.atan2f(y, x) }
@inlinable
func libm_lgammaf(_ x: Float, _ signp: UnsafeMutablePointer<Int32>?) -> Float {
    #if !os(Windows)
    var s: Int32 = 0
    let r = lgammaf_r(x, &s)
    signp?.pointee = s
    return r
    #else
    return 0.0
    #endif
}

// MARK: - Double (64-bit) wrappers
@inlinable
func libm_cos(_ x: Double) -> Double { return Darwin.cos(x) }
@inlinable
func libm_sin(_ x: Double) -> Double { return Darwin.sin(x) }
@inlinable
func libm_tan(_ x: Double) -> Double { return Darwin.tan(x) }
@inlinable
func libm_acos(_ x: Double) -> Double { return Darwin.acos(x) }
@inlinable
func libm_asin(_ x: Double) -> Double { return Darwin.asin(x) }
@inlinable
func libm_atan(_ x: Double) -> Double { return Darwin.atan(x) }
@inlinable
func libm_cosh(_ x: Double) -> Double { return Darwin.cosh(x) }
@inlinable
func libm_sinh(_ x: Double) -> Double { return Darwin.sinh(x) }
@inlinable
func libm_tanh(_ x: Double) -> Double { return Darwin.tanh(x) }
@inlinable
func libm_acosh(_ x: Double) -> Double { return Darwin.acosh(x) }
@inlinable
func libm_asinh(_ x: Double) -> Double { return Darwin.asinh(x) }
@inlinable
func libm_atanh(_ x: Double) -> Double { return Darwin.atanh(x) }
@inlinable
func libm_exp(_ x: Double) -> Double { return Darwin.exp(x) }
@inlinable
func libm_expm1(_ x: Double) -> Double { return Darwin.expm1(x) }
@inlinable
func libm_log(_ x: Double) -> Double { return Darwin.log(x) }
@inlinable
func libm_log1p(_ x: Double) -> Double { return Darwin.log1p(x) }
@inlinable
func libm_erf(_ x: Double) -> Double { return Darwin.erf(x) }
@inlinable
func libm_erfc(_ x: Double) -> Double { return Darwin.erfc(x) }
@inlinable
func libm_exp2(_ x: Double) -> Double { return Darwin.exp2(x) }
#if os(macOS)
@inlinable
func libm_exp10(_ x: Double) -> Double { return __exp10(x) }
#endif
@inlinable
func libm_hypot(_ x: Double, _ y: Double) -> Double { return Darwin.hypot(x, y) }
@inlinable
func libm_tgamma(_ x: Double) -> Double { return Darwin.tgamma(x) }
@inlinable
func libm_log2(_ x: Double) -> Double { return Darwin.log2(x) }
@inlinable
func libm_log10(_ x: Double) -> Double { return Darwin.log10(x) }
@inlinable
func libm_pow(_ x: Double, _ y: Double) -> Double { return Darwin.pow(x, y) }
@inlinable
func libm_cbrt(_ x: Double) -> Double { return Darwin.cbrt(x) }
@inlinable
func libm_atan2(_ y: Double, _ x: Double) -> Double { return Darwin.atan2(y, x) }
@inlinable
func libm_lgamma(_ x: Double, _ signp: UnsafeMutablePointer<Int32>?) -> Double {
    #if !os(Windows)
    var s: Int32 = 0
    let r = lgamma_r(x, &s)
    signp?.pointee = s
    return r
    #else
    return 0.0
    #endif
}

 // MARK: - Float80 / long double wrappers (where supported)
#if !os(Windows) && (arch(i386) || arch(x86_64))
// Provide wrappers for the long-double libm variants used by Float80 sources.
@inlinable
func libm_cosl(_ x: Float80) -> Float80 { return Darwin.cosl(x) }
@inlinable
func libm_sinl(_ x: Float80) -> Float80 { return Darwin.sinl(x) }
@inlinable
func libm_tanl(_ x: Float80) -> Float80 { return Darwin.tanl(x) }
@inlinable
func libm_acosl(_ x: Float80) -> Float80 { return Darwin.acosl(x) }
@inlinable
func libm_asinl(_ x: Float80) -> Float80 { return Darwin.asinl(x) }
@inlinable
func libm_atanl(_ x: Float80) -> Float80 { return Darwin.atanl(x) }

@inlinable
func libm_coshl(_ x: Float80) -> Float80 { return Darwin.coshl(x) }
@inlinable
func libm_sinhl(_ x: Float80) -> Float80 { return Darwin.sinhl(x) }
@inlinable
func libm_tanhl(_ x: Float80) -> Float80 { return Darwin.tanhl(x) }
@inlinable
func libm_acoshl(_ x: Float80) -> Float80 { return Darwin.acoshl(x) }
@inlinable
func libm_asinhl(_ x: Float80) -> Float80 { return Darwin.asinhl(x) }
@inlinable
func libm_atanhl(_ x: Float80) -> Float80 { return Darwin.atanhl(x) }

@inlinable
func libm_expl(_ x: Float80) -> Float80 { return Darwin.expl(x) }
@inlinable
func libm_expm1l(_ x: Float80) -> Float80 { return Darwin.expm1l(x) }
@inlinable
func libm_logl(_ x: Float80) -> Float80 { return Darwin.logl(x) }
@inlinable
func libm_log1pl(_ x: Float80) -> Float80 { return Darwin.log1pl(x) }
@inlinable
func libm_erfl(_ x: Float80) -> Float80 { return Darwin.erfl(x) }
@inlinable
func libm_erfcl(_ x: Float80) -> Float80 { return Darwin.erfcl(x) }
@inlinable
func libm_exp2l(_ x: Float80) -> Float80 { return Darwin.exp2l(x) }
@inlinable
func libm_hypotl(_ x: Float80, _ y: Float80) -> Float80 { return Darwin.hypotl(x, y) }
@inlinable
func libm_tgammal(_ x: Float80) -> Float80 { return Darwin.tgammal(x) }
@inlinable
func libm_log2l(_ x: Float80) -> Float80 { return Darwin.log2l(x) }
@inlinable
func libm_log10l(_ x: Float80) -> Float80 { return Darwin.log10l(x) }

@inlinable
func libm_powl(_ x: Float80, _ y: Float80) -> Float80 { return Darwin.powl(x, y) }
@inlinable
func libm_cbrtl(_ x: Float80) -> Float80 { return Darwin.cbrtl(x) }
@inlinable
func libm_atan2l(_ y: Float80, _ x: Float80) -> Float80 { return Darwin.atan2l(y, x) }
@inlinable
func libm_lgammal(_ x: Float80, _ signp: UnsafeMutablePointer<Int32>?) -> Float80 {
    var s: Int32 = 0
    let r = lgammal_r(x, &s)
    signp?.pointee = s
    return r
}
#endif

/*
 MARK: - Relaxed arithmetic fallbacks (if internal shim not available)

 Define fallback symbols only when the internal `_NumericsShims` module is
 NOT available. If the shim *is* available, its symbols will be used and
 these fallbacks won't be declared, avoiding duplication or recursion.
*/
#if !canImport(_NumericsShims)

@inlinable
func _numerics_relaxed_addf(_ a: Float, _ b: Float) -> Float {
  // conservative fallback when shim absent
  return a + b
}

@inlinable
func _numerics_relaxed_mulf(_ a: Float, _ b: Float) -> Float {
  return a * b
}



@inlinable
func _numerics_relaxed_add(_ a: Double, _ b: Double) -> Double {
  return a + b
}

@inlinable
func _numerics_relaxed_mul(_ a: Double, _ b: Double) -> Double {
  return a * b
}

#if !os(Windows) && (arch(i386) || arch(x86_64))
@inlinable
func _numerics_relaxed_addl(_ a: Float80, _ b: Float80) -> Float80 {
  return a + b
}

@inlinable
func _numerics_relaxed_mull(_ a: Float80, _ b: Float80) -> Float80 {
  return a * b
}
#endif

@inlinable
func _numerics_optimization_barrier(_ p: UnsafeRawPointer?) {
  // best-effort no-op fallback for the optimization barrier
  _ = p
}

#endif // !canImport(_NumericsShims)
