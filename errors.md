# Error Handling and Diagnostics

This document catalogs common errors, debugging strategies, and resolution steps for the Syntra project.

## Common Issues

- Build and dependency resolution errors in SwiftPM
- Vapor server routing and middleware failures
- LLM provider API integration issues
- Tool execution and permission errors
- Context management and token limit violations

## Debugging

- Use `swift build --verbose` for build diagnostics
- Enable Vapor logging with appropriate log levels
- Check network and API key configuration
- Review stack traces in test_results/ and logs/

For architecture-specific troubleshooting, refer to `Syntra_Technical_Summary.md`.
