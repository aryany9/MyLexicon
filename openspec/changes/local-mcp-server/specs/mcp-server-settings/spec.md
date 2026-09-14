## ADDED Requirements

### Requirement: MCP server settings screen
The system SHALL provide a dedicated settings page for the Local MCP Server accessible from the Settings menu.

#### Scenario: Navigating to MCP server settings
- **WHEN** the user selects the "Local MCP Server" item in the Settings screen
- **THEN** the app SHALL navigate to the MCP server configuration and status page

### Requirement: Server lifecycle toggle
The settings page SHALL display a switch control allowing the user to start and stop the local MCP server on-demand.

#### Scenario: Starting the server
- **WHEN** the user toggles the switch to ON
- **THEN** the system SHALL start the embedded HTTP server on the configured port, update the status indicator to active, and resolve the device's local IP address

#### Scenario: Stopping the server
- **WHEN** the user toggles the switch to OFF
- **THEN** the system SHALL gracefully stop the server, close open client connections, and update the status indicator to stopped

### Requirement: Network connection and endpoint display
When the server is active, the settings screen SHALL display:
1. The on-device loopback URL (`http://127.0.0.1:<port>/sse`)
2. The local Wi-Fi network URL (`http://<local-ip>:<port>/sse`)
3. A quick copy button for both URLs

#### Scenario: Displaying network URLs
- **WHEN** the server starts successfully on Wi-Fi IP `192.168.1.50` and port `8080`
- **THEN** the screen SHALL display `http://127.0.0.1:8080/sse` and `http://192.168.1.50:8080/sse` with copy buttons

### Requirement: Desktop MCP configuration exporter
The settings page SHALL provide an action to copy a ready-to-use desktop MCP JSON configuration block (compatible with Claude Desktop, Cursor, and Antigravity).

#### Scenario: Copying desktop configuration snippet
- **WHEN** the user taps the "Copy Desktop MCP Config" button
- **THEN** the app SHALL format a JSON object defining the `mylexicon` server with the current network URL and copy it to the system clipboard
