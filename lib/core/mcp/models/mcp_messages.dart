class McpRequest {
  final dynamic id; // int or String
  final String method;
  final Map<String, dynamic>? params;

  McpRequest({
    required this.id,
    required this.method,
    this.params,
  });

  factory McpRequest.fromJson(Map<String, dynamic> json) {
    if (json['jsonrpc'] != '2.0') {
      throw FormatException('Invalid jsonrpc version');
    }
    return McpRequest(
      id: json['id'],
      method: json['method'] as String,
      params: json['params'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() => {
        'jsonrpc': '2.0',
        'id': id,
        'method': method,
        if (params != null) 'params': params,
      };
}

class McpResponse {
  final dynamic id;
  final Map<String, dynamic> result;

  McpResponse({
    required this.id,
    required this.result,
  });

  Map<String, dynamic> toJson() => {
        'jsonrpc': '2.0',
        'id': id,
        'result': result,
      };
}

class McpError {
  final dynamic id;
  final int code;
  final String message;
  final dynamic data;

  McpError({
    required this.id,
    required this.code,
    required this.message,
    this.data,
  });

  Map<String, dynamic> toJson() => {
        'jsonrpc': '2.0',
        if (id != null) 'id': id,
        'error': {
          'code': code,
          'message': message,
          if (data != null) 'data': data,
        },
      };
}
