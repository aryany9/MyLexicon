class McpTools {
  static const searchEntries = {
    'name': 'search_entries',
    'description': 'Query entries by term, type, tag, or collection',
    'inputSchema': {
      'type': 'object',
      'properties': {
        'query': {
          'type': 'string',
          'description': 'Search query to match against term, definition, tags, or source',
        },
        'collectionName': {
          'type': 'string',
          'description': 'Optional collection name to filter by',
        },
      },
      'required': ['query'],
    },
  };

  static const getEntry = {
    'name': 'get_entry',
    'description': 'Fetch full details for a specific entry ID',
    'inputSchema': {
      'type': 'object',
      'properties': {
        'id': {
          'type': 'string',
          'description': 'The unique ID of the entry',
        },
      },
      'required': ['id'],
    },
  };

  static const addEntry = {
    'name': 'add_entry',
    'description': 'Create a new word, phrase, idiom, or quote',
    'inputSchema': {
      'type': 'object',
      'properties': {
        'term': {
          'type': 'string',
          'description': 'The word, phrase, or quote to add',
        },
        'definition': {
          'type': 'string',
          'description': 'The definition or translation',
        },
        'type': {
          'type': 'string',
          'description': 'Type of entry (e.g., word, phrase, idiom, quote)',
        },
        'collectionName': {
          'type': 'string',
          'description': 'Optional collection to add the entry to (must exist, use create_collection first if needed)',
        },
        'notes': {
          'type': 'string',
          'description': 'Optional personal notes',
        },
        'isFavorite': {
          'type': 'boolean',
          'description': 'Whether to mark this entry as a favorite (default: false)',
        },
        'examples': {
          'type': 'array',
          'items': {'type': 'string'},
          'description': 'Optional list of example sentences (use for Source Context if type is quote)',
        },
        'tags': {
          'type': 'array',
          'items': {'type': 'string'},
          'description': 'Optional list of tags',
        },
      },
      'required': ['term', 'definition', 'type'],
    },
  };

  static const updateEntry = {
    'name': 'update_entry',
    'description': 'Modify an existing entry',
    'inputSchema': {
      'type': 'object',
      'properties': {
        'id': {
          'type': 'string',
          'description': 'The unique ID of the entry to update',
        },
        'term': {
          'type': 'string',
          'description': 'The updated term',
        },
        'definition': {
          'type': 'string',
          'description': 'The updated definition',
        },
        'type': {
          'type': 'string',
          'description': 'The updated type',
        },
        'collectionName': {
          'type': 'string',
          'description': 'The updated collection name (must exist, use create_collection first if needed)',
        },
        'examples': {
          'type': 'array',
          'items': {'type': 'string'},
          'description': 'Optional updated list of example sentences (or Source Context if type is quote)',
        },
        'notes': {
          'type': 'string',
          'description': 'Optional updated personal notes',
        },
        'isFavorite': {
          'type': 'boolean',
          'description': 'Update favorite status',
        },
      },
      'required': ['id'],
    },
  };

  static const deleteEntry = {
    'name': 'delete_entry',
    'description': 'Remove an entry by ID',
    'inputSchema': {
      'type': 'object',
      'properties': {
        'id': {
          'type': 'string',
          'description': 'The unique ID of the entry to delete',
        },
      },
      'required': ['id'],
    },
  };

  static const listCollections = {
    'name': 'list_collections',
    'description': 'List all collections with their entry counts. Use create_collection if a collection is missing.',
    'inputSchema': {
      'type': 'object',
      'properties': {},
    },
  };

  static const createCollection = {
    'name': 'create_collection',
    'description': 'Create a new collection for organizing entries',
    'inputSchema': {
      'type': 'object',
      'properties': {
        'name': {
          'type': 'string',
          'description': 'The name of the new collection',
        },
        'description': {
          'type': 'string',
          'description': 'Optional description of the collection',
        },
      },
      'required': ['name'],
    },
  };

  static const allTools = [
    searchEntries,
    getEntry,
    addEntry,
    updateEntry,
    deleteEntry,
    listCollections,
    createCollection,
  ];
}
