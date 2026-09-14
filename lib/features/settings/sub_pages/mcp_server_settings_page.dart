import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mylexicon/core/mcp/providers/mcp_server_provider.dart';

class McpServerSettingsPage extends ConsumerStatefulWidget {
  const McpServerSettingsPage({super.key});

  @override
  ConsumerState<McpServerSettingsPage> createState() => _McpServerSettingsPageState();
}

class _McpServerSettingsPageState extends ConsumerState<McpServerSettingsPage> {
  bool _obscureToken = true;
  String _localIp = '127.0.0.1';

  @override
  void initState() {
    super.initState();
    _resolveLocalIp();
  }

  Future<void> _resolveLocalIp() async {
    try {
      final interfaces = await NetworkInterface.list(
        type: InternetAddressType.IPv4,
        includeLinkLocal: false,
      );
      for (var interface in interfaces) {
        for (var addr in interface.addresses) {
          if (!addr.isLoopback) {
            setState(() {
              _localIp = addr.address;
            });
            return;
          }
        }
      }
    } catch (_) {}
  }

  void _copyToClipboard(String text, String message) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _copyDesktopConfig(String token, int? port) {
    if (port == null) return;
    
    final jsonConfig = {
      "mcpServers": {
        "mylexicon": {
          "serverUrl": "http://$_localIp:$port/sse",
          "headers": {
            "Authorization": "Bearer $token"
          }
        }
      }
    };
    _copyToClipboard(const JsonEncoder.withIndent('  ').convert(jsonConfig), 'Copied MCP Config');
  }

  @override
  Widget build(BuildContext context) {
    final mcpState = ref.watch(mcpServerProvider);
    final isRunning = mcpState.isRunning;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Local MCP Server'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title: Row(
              children: [
                const Text('Enable MCP Server'),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('How it Works'),
                        content: const Text(
                          'The Local MCP Server enables AI assistants to manage your lexicon data securely over your local network.\n\n'
                          '• On Wi-Fi: Connect from your laptop using Claude Desktop, Cursor, or other MCP-compatible clients.\n'
                          '• On Mobile Data: Connect from on-device AI apps (like Loki) using the loopback address, or connect laptops via Mobile Hotspot.\n\n'
                          'All data stays strictly local on your device.'
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Got it'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Icon(Icons.info_outline, size: 20, color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
            subtitle: const Text('Run embedded AI server in background'),
            value: isRunning,
            onChanged: (val) {
              if (val) {
                ref.read(mcpServerProvider.notifier).startServer();
              } else {
                ref.read(mcpServerProvider.notifier).stopServer();
              }
            },
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: isRunning
                ? Container(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.lightbulb_outline, size: 20, color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'The server is running! AI assistants can now connect using the credentials below. '
                              'It will continue running in the background until you disable it to save battery.',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          const Divider(),
          if (isRunning) ...[
            ListTile(
              title: const Text('Server Status'),
              subtitle: Text('IP: $_localIp\nPort: ${mcpState.port ?? '...'}'),
              trailing: const Icon(Icons.check_circle, color: Colors.green),
            ),
            ListTile(
              title: const Text('Bearer Token'),
              subtitle: Text(_obscureToken ? '••••••••••••••••' : mcpState.bearerToken),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(_obscureToken ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscureToken = !_obscureToken;
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () => _copyToClipboard(mcpState.bearerToken, 'Token copied'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.integration_instructions),
              label: const Text('Copy Desktop MCP Config'),
              onPressed: () => _copyDesktopConfig(mcpState.bearerToken, mcpState.port),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Paste this configuration into your AI assistant (e.g., Cursor, Claude Desktop) to allow it to read and write to your lexicon.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ]
        ],
      ),
    );
  }
}
