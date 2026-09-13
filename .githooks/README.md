# Git Hooks

This directory contains repository hooks for MyLexicon.

## Setup

To enable these hooks for your local clone, run:

```bash
git config core.hooksPath .githooks
```

## Included Hooks

### `pre-commit`
Enforces that whenever the `version` in `pubspec.yaml` is bumped:
1. `CHANGELOG.md` must be staged for the commit.
2. `CHANGELOG.md` must contain an entry section for the new version (`## [X.Y.Z]`).
