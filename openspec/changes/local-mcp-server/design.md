## Context

MyLexicon is an offline-first personal vocabulary and knowledge organizer built with Flutter and Hive. Currently, all CRUD operations are performed through user interactions in the Flutter UI. 

With the rise of local AI assistants (like Loki running on-device with LiteRT-LM, or Claude Desktop/Cursor running on a local development workstation), users want their assistants to read and write directly to their personal lexicon. This design establishes an on-demand, local Model Context Protocol (MCP) server running inside the Flutter process, enabling zero-internet, bidirectional CRUD operations for both same-device and local-network AI agents.

## Goals / Non-Goals

**Goals:**
- Provide an embedded HTTP server running inside MyLexicon that implements standard Model Context Protocol (MCP) over Server-Sent Events (SSE) and JSON-RPC 2.0.
- Expose a core set of tool calls: `search_entries`, `get_entry`, `add_entry`, `update_entry`, `delete_entry`, and `list_collections`.
- Integrate collection-aware duplicate detection into `add_entry`, returning structured, recoverable error feedback (`isError: true` with existing entry details) to guide LLM behavior.
- Ensure all mutations through the MCP server immediately trigger Hive saves and update Riverpod state so the Flutter UI reacts in real time.
- Provide an On-Demand Settings UI with start/stop control, active network interface IP display, dynamic port configuration, token visibility, and desktop MCP configuration export.
- Implement an Android Foreground Service with a persistent notification to guarantee the server remains alive in the background indefinitely and to keep the user informed of its battery impact.

**Non-Goals:**
- **Internet Sync / Cloud Tunneling**: All operations are strictly local (loopback `127.0.0.1` and LAN subnet `192.168.x.x`). No internet connection or remote relays are used.
- **Native Android ContentProvider**: Avoiding Android-specific JNI/FlutterEngine overhead in favor of standard HTTP loopback sockets.

## Decisions

### 1. Pure Dart `relic` Server inside Flutter Isolate
* **Decision**: Implement the server in pure Dart using `relic` and `relic_io` running on the main UI isolate.
* **Rationale**: Hive boxes in MyLexicon (`DatabaseService`) are opened on the main isolate. Handling HTTP requests directly in the same isolate eliminates cross-isolate serialization overhead, avoids file lock contention on `.hive` files, and allows immediate dispatch of Riverpod state updates to UI widgets. Relic offers strongly typed APIs, improved trie-based routing, and high performance compared to Shelf.
* **Alternatives Considered**: 
  - *Android Native Kotlin Server / ContentProvider*: Would require bridging back into Flutter via `MethodChannel` or migrating Hive to SQLite.
  - *Background Isolate Server*: Would require opening Hive boxes in multiple isolates or managing complex send/receive ports.

### 2. Standard MCP Transport Only (SSE + JSON-RPC)
* **Decision**: Strictly enforce standard MCP over SSE (`GET /sse`) and JSON-RPC 2.0 (`POST /messages`). Drop any custom lightweight REST bridge.
* **Rationale**: 
  - Desktop AI tools natively consume MCP over SSE.
  - Universal design: Any client, including lightweight local apps like Loki, should conform to the standard MCP payload (sending a simple JSON-RPC 2.0 `tools/call` POST request) rather than MyLexicon building custom APIs for them. This future-proofs the server and encourages clients to adopt the standard.
* **Alternatives Considered**: 
  - *Custom REST Bridge (`/api/tools/*`)*: Rejected because it fragments the API surface and violates universal design principles.

### 3. Actionable LLM Duplicate Error Format
* **Decision**: When `add_entry` encounters a duplicate via `DatabaseService.findDuplicateEntry`, return `{ "content": [{"type": "text", "text": "..."}], "isError": true }` including the conflicting entry ID, term, and collection name.
* **Rationale**: LLMs are trained to inspect error strings and dynamically adapt (e.g. asking the user to update the existing entry or automatically calling `update_entry`). Returning a generic 400 error fails to guide the agent.

### 4. Local Authentication via Generated Bearer Token
* **Decision**: Generate a random 16-character bearer token stored in `SharedPreferences`. All non-loopback requests must include `Authorization: Bearer <token>`. The token will be viewable in the Settings UI (masked by default) for manual client configuration.
* **Rationale**: Token protection prevents unauthorized read/write access from other devices on the same subnet.

### 5. Foreground Service & Background Execution
* **Decision**: 
  - Wrap the server execution in an Android Foreground Service (using a package like `flutter_foreground_task` or `flutter_background_service`).
  - Display a persistent notification (e.g., "MyLexicon MCP Server is running") when active.
  - The server continues to run when the app is backgrounded or the screen is off, allowing for true multitasking.
* **Rationale**: This guarantees the server won't be killed by Android's Doze mode, allows remote agents to interact seamlessly while the user does other tasks, and the persistent notification acts as a safety measure so the user remembers to turn it off to save battery.

## Architecture & Data Flow

```
┌─────────────────────────────────┐        ┌──────────────────────────────────┐
│   Remote Client (Claude/Cursor) │        │     Local Assistant (Loki)       │
└────────────────┬────────────────┘        └────────────────┬─────────────────┘
                 │ (LAN Wi-Fi)                              │ (127.0.0.1 Loopback)
                 │ GET /sse + POST /messages                │ GET /sse + POST /messages
                 └─────────────────────────┬────────────────┘
                                           ▼
                 ┌──────────────────────────────────────────────────┐
                 │           McpServerService (shelf router)        │
                 ├──────────────────────────────────────────────────┤
                 │  - Auth Middleware (Bearer Token Verification)   │
                 │  - SSE Session Manager                           │
                 │  - JSON-RPC 2.0 Dispatcher (MCP tools/*)         │
                 └─────────────────────────┬────────────────────────┘
                                           ▼
                 ┌──────────────────────────────────────────────────┐
                 │                  DatabaseService                 │
                 │  - findDuplicateEntry() validation               │
                 │  - saveEntry() / deleteEntry()                   │
                 │  - getCollections()                              │
                 └─────────────────────────┬────────────────────────┘
                                           ▼
                 ┌──────────────────────────────────────────────────┐
                 │              Hive & Riverpod Notifiers           │
                 │   (Screen updates instantaneously on mutation)   │
                 └──────────────────────────────────────────────────┘
```

## Risks / Trade-offs

- **[Risk] Wi-Fi AP Client Isolation**: Some guest or public Wi-Fi networks block device-to-device communication on the LAN.
  - *Mitigation*: The settings page documents USB port forwarding (`adb forward tcp:8080 tcp:8080`) as a guaranteed, ultra-fast fallback that works anywhere without Wi-Fi.
- **[Risk] Mobile Sleep / Process Suspension**: When the device screen turns off, Android may pause background network sockets.
  - *Mitigation*: Design is explicitly on-demand. When the user opens MyLexicon, the server is active. The UI clearly states that the server is active while the app remains open.
- **[Risk] Malformed Input from AI Agents**: LLMs may omit fields or pass unexpected types.
  - *Mitigation*: Strict JSON schema validation on every tool call with clear, explanatory error messages returned to the model.
