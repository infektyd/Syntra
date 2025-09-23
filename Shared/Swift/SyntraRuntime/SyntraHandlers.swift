import Foundation
import SyntraKit
import ConversationalInterface

public struct SyntraHandlers {
    public static func handleProcessThroughBrains(_ input: String) async throws -> String {
        if #available(macOS 26.0, *) {
            // Route through SYNTRA consciousness (stateless to avoid bleed)
            return await chatWithSyntraStateless(input)
        } else {
            // Fallback to backend selection via SyntraKit
            return try await SyntraEngine.continueSession(input)
        }
    }
}

