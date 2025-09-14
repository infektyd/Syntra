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

    // Add custom timeout middleware for AI operations (10 minutes)
    app.middleware.use(TimeoutMiddleware(timeout: .seconds(600)))
    
    // Add custom logging middleware
    app.middleware.use(LoggingMiddleware())

    // Configure server settings for long-running operations
    app.http.server.configuration.port = 8081
    app.routes.defaultMaxBodySize = "5mb"
    
    // Configure HTTP server for extended processing times
    app.http.server.configuration.hostname = "127.0.0.1"
    app.http.server.configuration.requestDecompression = .enabled
    app.http.server.configuration.responseCompression = .enabled
    
    // Configure client timeouts for NIO
    app.http.client.configuration.timeout = HTTPClient.Configuration.Timeout(
        connect: .seconds(30),
        read: .seconds(600)  // 10 minutes for complex AI operations
    )
    
    // Register routes
    try routes(app)
    
    // Log server configuration
    app.logger.info("\u{1f680} SyntraVaporServer configured with extended timeouts for AI operations")
    app.logger.info("\u{1f4dd} Chat completion timeout: 10 minutes")
    app.logger.info("\u{1f4ca} Max body size: 5MB")
}