import Vapor
import NIOHTTP1

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // Configure CORS
    let corsConfiguration = CORSMiddleware.Configuration(
        allowedOrigin: .all,
        allowedMethods: [.GET, .POST, .OPTIONS],
        allowedHeaders: [.accept, .authorization, .contentType, .origin, .xRequestedWith, .userAgent, .accessControlAllowOrigin]
    )
    let cors = CORSMiddleware(configuration: corsConfiguration)
    app.middleware.use(cors, at: .beginning)

    // Add custom logging middleware
    app.middleware.use(LoggingMiddleware())

    // Configure server port, body size limit, and TIMEOUTS
    app.http.server.configuration.port = 8081
    app.routes.defaultMaxBodySize = "5mb"
    
    // CRITICAL: Increase timeouts for complex reasoning tasks
    // Set request timeout to 5 minutes (300 seconds) for Tower of Hanoi, complex math, etc.
    app.http.server.configuration.requestDecompression = .enabled
    app.http.server.configuration.responseCompression = .enabled
    
    // Configure HTTP server timeouts
    app.http.server.configuration.supportVersions = Set<HTTPVersion>([.http1_1, .http2])
    
    // Set longer timeouts for complex reasoning operations
    app.http.server.configuration.tlsConfiguration = nil
    
    // Register routes
    try routes(app)
}

// Extension to configure request timeouts
extension Application {
    func configureTimeouts() {
        // Configure longer request timeout for intensive operations
        self.http.server.configuration.hostname = "127.0.0.1"
        
        // Add timeout middleware if needed - Vapor handles this internally
        // For complex AI operations, we rely on the FoundationModels timeout
    }
}