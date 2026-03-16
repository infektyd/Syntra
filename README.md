# Syntra

Syntra is a Swift-based backend server and framework for building intelligent AI agents and conversational systems. It provides a Vapor web server with LLM integration, tool execution, context management, and multi-provider support.

## Features

- Vapor-based REST API for chat completions and agent workflows
- Modular architecture with pluggable LLM providers
- Built-in tool registry and execution engine
- Context management and token optimization
- Swift Package Manager integration for reusable components
- Support for macOS and server deployments

## Architecture

Syntra follows a layered design:

- **Core**: Vapor routes and middleware for API endpoints
- **Providers**: LLM integrations (OpenAI, Anthropic, Grok, etc.)
- **Tools**: Extensible tool system for agent capabilities
- **Shared**: Common models, utilities, and services across packages
- **Documentation**: Architecture guides and technical specifications

## Quick Start

1. Ensure Swift 6.0+ and Vapor are installed.
2. From the project root:
   ```bash
   swift run
   ```
3. The server will start on `http://127.0.0.1:8081/v1`.

Use the `/v1/chat/completions` endpoint for LLM interactions or integrate with frontend clients such as Open Web UI.

## Project Structure

- `Sources/`: Main Swift source packages
- `Packages/`: Reusable SwiftPM packages
- `SyntraVaporServer/`: The primary Vapor application
- `Documentation/`: Architecture and usage guides
- `tools/`: Supporting scripts and utilities

See `syntra_architecture_flow.md` and `Syntra_Technical_Summary.md` for detailed specifications.

## License

See LICENSE file for details.
