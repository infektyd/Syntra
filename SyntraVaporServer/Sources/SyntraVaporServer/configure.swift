import Vapor

public func configure(_ app: Application) throws {
    // Configure the server address
    app.http.server.configuration.hostname = "127.0.0.1"
    app.http.server.configuration.port = 8081

    // Request logging (env-gated)
    if Environment.get("LOG_REQUEST_BODIES") == "1" {
        app.middleware.use(RequestBodyLoggerMiddleware())
    }
    // ... existing config ...
    try routes(app)
}
