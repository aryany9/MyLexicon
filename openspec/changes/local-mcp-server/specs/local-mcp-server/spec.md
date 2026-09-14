## ADDED Requirements

### Requirement: Embedded MCP HTTP and SSE transport
The system SHALL embed a local HTTP server capable of listening on all interfaces (`0.0.0.0`) on a configurable port (default: 8080). The server SHALL provide an MCP Server-Sent Events endpoint at `GET /sse` and a JSON-RPC message endpoint at `POST /messages`.

#### Scenario: Client connects via SSE
- **WHEN** an MCP client issues an HTTP `GET /sse` request
- **THEN** the server SHALL open a persistent event stream with `Content-Type: text/event-stream` and emit an initial `endpoint` event referencing the session's message POST URL

#### Scenario: JSON-RPC message handling
- **WHEN** an MCP client sends a valid JSON-RPC 2.0 request to `POST /messages` with an active session ID
- **THEN** the server SHALL process the request and return or emit the JSON-RPC response

### Requirement: MCP tool discovery and execution
The server SHALL support the standard MCP `tools/list` and `tools/call` protocols. The tool registry SHALL expose the following core tools:
1. `search_entries` — query entries by term, type, tag, or collection
2. `get_entry` — fetch full details for a specific entry ID
3. `add_entry` — create a new word, phrase, idiom, or quote
4. `update_entry` — modify an existing entry
5. `delete_entry` — remove an entry by ID
6. `list_collections` — list all collections with IDs and entry counts

#### Scenario: Listing available tools
- **WHEN** the client sends a `tools/list` JSON-RPC request
- **THEN** the server SHALL return the schemas, parameter specifications, and descriptions for all six tools

#### Scenario: Searching entries
- **WHEN** a client invokes `tools/call` for `search_entries` with query `"ephemeral"`
- **THEN** the server SHALL query `DatabaseService` and return matching entries formatted as JSON in the tool content block

#### Scenario: Creating a new entry
- **WHEN** a client invokes `tools/call` for `add_entry` with valid term, definition, and type
- **THEN** the server SHALL persist the new entry to the database and return the created entry's ID and details

### Requirement: Actionable duplicate detection error
When executing `add_entry`, the server SHALL execute `DatabaseService.findDuplicateEntry` to evaluate term, type, and collection membership conflicts. If a duplicate exists, the tool call SHALL return an error response with `isError: true` containing actionable guidance.

#### Scenario: Duplicate term in same collection rejected with guidance
- **WHEN** an agent attempts to `add_entry` for a term and type that already exists within the specified collection
- **THEN** the server SHALL reject the creation, return `isError: true`, and include the existing entry's ID, term, and collection name in the error message explaining that the item already exists and suggesting `update_entry`

#### Scenario: Same term in different collection allowed
- **WHEN** an agent invokes `add_entry` for an existing term but assigns it to a non-overlapping collection
- **THEN** the creation SHALL succeed without duplicate errors

### Requirement: Direct HTTP tool invocation bridge
The server SHALL provide a direct HTTP endpoint at `POST /api/tools/<tool_name>` accepting a JSON request body of tool arguments.

#### Scenario: Direct execution from local assistant
- **WHEN** an on-device client (such as Loki) sends a `POST /api/tools/add_entry` request with JSON arguments
- **THEN** the server SHALL execute the tool directly against `DatabaseService` and return the result as an HTTP JSON response without requiring an SSE session

### Requirement: Local network bearer authentication
The server SHALL support optional token authentication. When enabled, non-loopback requests SHALL require an `Authorization: Bearer <token>` header matching the persisted server token.

#### Scenario: Unauthenticated request from external IP rejected
- **WHEN** a remote client sends a request without the correct bearer token and token authentication is enabled
- **THEN** the server SHALL return HTTP 401 Unauthorized

#### Scenario: Loopback request permitted
- **WHEN** an on-device client connects from `127.0.0.1` and loopback bypass is enabled
- **THEN** the server SHALL process the request without requiring a bearer token
