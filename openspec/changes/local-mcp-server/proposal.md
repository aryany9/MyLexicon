## Why

Users increasingly rely on local and on-device AI assistants (such as Loki on Android, or Claude Desktop/Cursor/Antigravity on a connected laptop) to read, research, and capture knowledge. However, MyLexicon's vocabulary, quotes, and idiom data are currently isolated within the app's internal Hive database, requiring manual entry through the Flutter UI. 

Exposing a local, on-demand Model Context Protocol (MCP) server allows any local AI agent—running either on the same phone via loopback or across the local Wi-Fi network—to perform bidirectional CRUD operations directly against MyLexicon completely offline without needing cloud sync or internet access.

## What Changes

- Embed a lightweight, on-demand HTTP server inside MyLexicon implementing the Model Context Protocol (MCP) over Server-Sent Events (SSE) and HTTP POST.
- Expose a core suite of MCP tools: `search_entries`, `get_entry`, `add_entry`, `update_entry`, `delete_entry`, and `list_collections`.
- Integrate collection-aware duplicate detection into `add_entry` so AI agents receive actionable, structured conflict errors when a term already exists in a collection.
- Implement an Android Foreground Service with a persistent notification to ensure the server remains alive reliably in the background during multitasking while keeping the user informed.
- Add a new "Local MCP Server" screen under Settings with a master toggle, real-time IP/port indicators, bearer token visibility, and a one-click desktop MCP config snippet.

## Capabilities

### New Capabilities
- `local-mcp-server`: An embedded local HTTP/SSE server implementing the Model Context Protocol (MCP) to provide offline, local-network tool-calling capabilities (`search_entries`, `get_entry`, `add_entry`, `update_entry`, `delete_entry`, `list_collections`) backed by `DatabaseService`.
- `mcp-server-settings`: An on-demand settings management page providing controls to start/stop the server, inspect binding addresses (`127.0.0.1` and LAN IP), and copy configuration payloads.

### Modified Capabilities
<!-- None: existing database models, storage schemas, and duplicate detection policies are consumed without requirement changes. -->

## Impact

- **`pubspec.yaml`**: Add lightweight HTTP routing dependency (e.g. `shelf`, `shelf_router`) and network interface lookup utilities if needed.
- **`lib/core/services/`**: Add `McpServerService` bridging incoming JSON-RPC / HTTP requests to `DatabaseService`.
- **`lib/features/settings/`**: Add `McpServerSettingsPage` and register route in `AppRouter`.
- **Database & State**: Real-time reactivity—any write made by an AI agent through `DatabaseService` immediately updates Hive boxes and triggers existing Riverpod listeners in the Flutter UI.
