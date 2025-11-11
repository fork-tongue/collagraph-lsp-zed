# Collagraph Extension for Zed

Language support for [Collagraph](https://github.com/fork-tongue/collagraph) `.cgx` single-file components in [Zed](https://zed.dev).

## Features

- **Syntax Highlighting** - Full syntax highlighting for Collagraph templates, including:
  - Vue-style directives (v-if, v-for, v-bind, v-on, v-slot)
  - Python expressions in templates and script sections
  - Component bindings (`:prop`) and event handlers (`@event`)
  - Template interpolation (`{{ }}`)

- **Language Server Integration** - Automatic integration with [collagraph-lsp](https://github.com/fork-tongue/collagraph-lsp) providing:
  - Real-time Python linting with Ruff
  - Code formatting
  - Python autocompletion
  - Semantic tokens

- **Smart Editing** - Enhanced editing experience with:
  - Bracket matching for tags and interpolations
  - Smart indentation
  - Comment toggling

## Prerequisites

Before using this extension, you need to install `collagraph-lsp`:

```bash
# Using uv (recommended)
uv pip install collagraph-lsp

# Or using pip
pip install collagraph-lsp
```

The extension will automatically detect and use the language server when you open `.cgx` files.

## Installation

### From Zed Extensions

1. Open Zed
2. Press `Cmd+Shift+X` (macOS) or `Ctrl+Shift+X` (Linux/Windows)
3. Search for "Collagraph"
4. Click "Install"

### From Source (Development)

Prerequisites: install [rustup](https://rustup.rs). Zed will use that to compile the plugin.

```bash
# Clone the repository
git clone https://github.com/fork-tongue/collagraph-lsp-zed.git
```
1. Open Zed
2. Press `Cmd+Shift+X` (macOS) or `Ctrl+Shift+X` (Linux/Windows)
3. Click "Install Dev Extension"
4. Select folder where this repo was cloned

After installation, whenever the plugin code is updated, all you need to do is click 'Rebuild' on the installed plugin.

## Usage

Simply open any `.cgx` file in Zed, and the extension will:

1. Recognize the file as Collagraph
2. Apply syntax highlighting
3. Launch the collagraph-lsp language server
4. Provide linting, completions, and formatting

### Example `.cgx` File

```cgx
<template>
  <widget>
    <label :text="f'Count: {count}'" />
    <button text="Increment" @clicked="increment" />
  </widget>
</template>

<script lang="python">
import collagraph as cg

class Counter(cg.Component):
    def init(self):
        self.state["count"] = 0

    def increment(self):
        self.state["count"] += 1
</script>
```

### Features in Action

- **Syntax Highlighting**: Template directives, Python expressions, and component tags are all highlighted appropriately
- **Diagnostics**: Python linting errors appear as you type
- **Completions**: Type `self.` in a method to see available properties and methods
- **Formatting**: Use `Format Document` command to format both Python and template code

## Configuration

The extension uses `collagraph-lsp` with default settings. You can customize the language server by adding settings to your Zed configuration:

```json
{
  "lsp": {
    "collagraph-lsp": {
      "initialization_options": {
        "ruff_command": "/custom/path/to/ruff"
      }
    }
  }
}
```

## Troubleshooting

### Language server not starting

**Problem**: Opening `.cgx` files doesn't show diagnostics or completions.

**Solutions**:

1. Verify collagraph-lsp is installed:
   ```bash
   collagraph-lsp --version
   # or
   uv run collagraph-lsp --version
   ```

2. Check Zed's LSP logs:
   - Open Zed's command palette (`Cmd+Shift+P` / `Ctrl+Shift+P`)
   - Search for "Open Log"
   - Look for collagraph-lsp startup messages or errors

3. Ensure the extension is installed:
   - Open Extensions (`Cmd+Shift+X` / `Ctrl+Shift+X`)
   - Verify "Collagraph" is listed and enabled

### Tree-sitter Grammar

This extension uses the official [tree-sitter-vue](https://github.com/tree-sitter-grammars/tree-sitter-vue) grammar (the same grammar used by the [official Zed Vue extension](https://github.com/zed-extensions/vue)) for template parsing, with Python language injections for expressions.

This approach provides excellent coverage for template structure, directives, and HTML syntax, while allowing Python expressions to be highlighted within directives and interpolations.

## Related Projects

- [Collagraph](https://github.com/fork-tongue/collagraph) - Python port of Vue.js
- [collagraph-lsp](https://github.com/fork-tongue/collagraph-lsp) - Language server for Collagraph
- [ruff-cgx](https://github.com/fork-tongue/ruff-cgx) - Ruff integration for .cgx files
- [zed-extensions/vue](https://github.com/zed-extensions/vue - Official Zed extension for Vue
