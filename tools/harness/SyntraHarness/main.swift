import Foundation
import SyntraRuntime

@main
struct Main {
    static func main() async {
        var backend: String? = nil
        var prompt: String? = nil
        var file: String? = nil

        var args = Array(CommandLine.arguments.dropFirst())
        func popValue() -> String? { args.isEmpty ? nil : (args.removeFirst()) }
        while let flag = popValue() {
            switch flag {
            case "--backend": backend = popValue()
            case "--prompt": prompt = popValue()
            case "--file": file = popValue()
            default: break
            }
        }

        if let b = backend { setenv("SYNTRA_BACKEND", b, 1) }

        var prompts: [String] = []
        if let p = prompt { prompts = [p] }
        if let path = file {
            if let content = try? String(contentsOfFile: path, encoding: .utf8) {
                for line in content.components(separatedBy: .newlines) {
                    let s = line.trimmingCharacters(in: .whitespacesAndNewlines)
                    if s.isEmpty || s.hasPrefix("#") { continue }
                    prompts.append(s)
                }
            }
        }

        if prompts.isEmpty {
            fputs("Usage: SyntraHarness --backend <cloud|afm> (--prompt <text> | --file <path>)\n", stderr)
            exit(2)
        }

        for p in prompts {
            let start = Date()
            do {
                let text = try await SyntraHandlers.handleProcessThroughBrains(p)
                let elapsed = Int(Date().timeIntervalSince(start) * 1000)
                let payload: [String: Any] = [
                    "ts": Int(start.timeIntervalSince1970),
                    "backend": backend ?? (ProcessInfo.processInfo.environment["SYNTRA_BACKEND"] ?? "(unset)"),
                    "prompt": p,
                    "response": text,
                    "duration_ms": elapsed
                ]
                if let data = try? JSONSerialization.data(withJSONObject: payload),
                   let line = String(data: data, encoding: .utf8) {
                    print(line)
                }
            } catch {
                let payload: [String: Any] = [
                    "ts": Int(Date().timeIntervalSince1970),
                    "backend": backend ?? (ProcessInfo.processInfo.environment["SYNTRA_BACKEND"] ?? "(unset)"),
                    "prompt": p,
                    "error": String(describing: error)
                ]
                if let data = try? JSONSerialization.data(withJSONObject: payload),
                   let line = String(data: data, encoding: .utf8) {
                    print(line)
                }
            }
        }
    }
}
