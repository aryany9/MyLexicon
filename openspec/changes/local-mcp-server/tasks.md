## 1. Dependencies & MCP Protocol Models

- [x] 1.1 Add `relic` and `relic_io` dependencies to `pubspec.yaml`
- [x] 1.2 Implement MCP JSON-RPC 2.0 message models (`McpRequest`, `McpResponse`, `McpError`)
- [x] 1.3 Define MCP tool schemas and parameter definitions for `search_entries`, `get_entry`, `add_entry`, `update_entry`, `delete_entry`, and `list_collections`

## 2. Tool Execution & Duplicate Enforcement

- [x] 2.1 Implement `McpToolExecutor` connecting incoming tool calls to `DatabaseService`
- [x] 2.2 Implement collection-aware duplicate checking in `add_entry` using `DatabaseService.findDuplicateEntry` returning `isError: true` and actionable fix guidance
- [x] 2.3 Add unit tests verifying tool execution (`search_entries`, `add_entry`, `update_entry`, `delete_entry`, `list_collections`) and duplicate conflict responses

## 3. Embedded Server & Transports

- [x] 3.1 Implement `McpServerService` with dynamic port binding (try 8080, fallback to 0) and graceful shutdown of SSE connections
- [x] 3.2 Add Bearer token authentication middleware with loopback (`127.0.0.1`) bypass support
- [x] 3.3 Add automated server integration tests verifying SSE connection lifecycle and tool calls

## 4. Foreground Service & State Management

- [x] 4.1 Add `flutter_background_service` (or equivalent) dependency and update `AndroidManifest.xml` with `FOREGROUND_SERVICE` and notification permissions
- [x] 4.2 Create Riverpod `McpServerNotifier` to manage server start/stop lifecycle, local IP resolution, and actual bound port
- [x] 4.3 Integrate foreground service logic: show persistent notification when the server is active to guarantee background execution
- [x] 4.4 Build `McpServerSettingsPage` with on/off switch, live status (IP:port), and masked Bearer token with reveal/copy actions
- [x] 4.5 Add "Copy Desktop MCP Config" action generating ready-to-use JSON for Claude Desktop and Cursor
- [x] 4.6 Add "Local MCP Server" menu item in Settings and wire route in `AppRouter`
- [x] 4.7 Perform manual end-to-end verification with a local HTTP client on Android and remote workstation
