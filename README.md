# Neovim Configuration Test Suite

This repository contains comprehensive test projects for validating a multi-language Neovim development environment. Use these test projects to quickly verify that your Neovim configuration is working correctly when setting up on new machines.

## Purpose

When deploying your Neovim configuration to a new machine, these test projects help you verify that all language support is functioning properly:

- **LSP Features**: Autocomplete, go-to-definition, hover info, find references, rename refactoring
- **Debugging**: Breakpoints, step-through debugging, variable inspection
- **Formatting**: Code formatting on save and manual formatting
- **Linting**: Real-time error detection and code quality suggestions

## Supported Languages

### 🔷 C# (`src/csharp/`)

- **LSP**: omnisharp for IntelliSense features
- **Debugging**: netcoredbg with automatic project building
- **Formatting**: csharpier
- **Test**: Console application with classes, interfaces, async operations

### 🐍 Python (`src/python/`)

- **LSP**: pyright for type checking and navigation
- **Debugging**: debugpy for breakpoint debugging
- **Formatting**: black + isort (imports)
- **Test**: Script with classes, async functions, type hints

### 🐹 Go (`src/go/`)

- **LSP**: gopls for Go language support
- **Debugging**: delve (dlv) debugger
- **Formatting**: Built-in gofmt (automatic)
- **Test**: Program with structs, interfaces, error handling

### 📘 TypeScript (`src/typescript/`)

- **LSP**: ts_ls (typescript-language-server)
- **Debugging**: No debugging (focus on development features)
- **Formatting**: prettier
- **Linting**: eslint_d
- **Test**: Classes, interfaces, async operations, imports

### 🐚 Bash (`src/bash/`)

- **LSP**: bash-language-server for completions
- **Debugging**: No debugging (tracing with `set -x`)
- **Formatting**: shfmt
- **Linting**: shellcheck for best practices
- **Test**: Script with functions, arrays, argument parsing

## Quick Start

1. **Copy your Neovim config** to the new machine
2. **Open a test project**: `nvim nvim-config-validation/src/[language]/`
3. **Wait for Mason** to auto-install language tools
4. **Run the tests** described in each language's README

## Testing Procedure

For each language directory:

1. **Open the main file** in Neovim
2. **Test LSP features**:
   - Hover over variables/functions
   - Use `grd` (go-to-definition)
   - Use `grr` (find-references)
   - Use `grn` (rename)
   - Test autocomplete
3. **Test formatting**: Press `<leader>f`
4. **Test debugging** (where applicable):
   - Set breakpoint with `F9`
   - Start debugging with `F5`
   - Step through with `F10`/`F11`
5. **Verify linting**: Look for error highlights

## Expected Behavior

✅ **Success indicators**:

- Hover shows type/documentation
- Go-to-definition jumps to symbols
- Autocomplete works when typing
- Formatting applies on `<leader>f`
- Debugging UI opens and variables display
- Linting shows warnings/errors

❌ **Failure indicators**:

- "LSP not running" errors
- No autocomplete suggestions
- Formatting does nothing
- Debugger fails to start
- No linting warnings

## Troubleshooting

### Mason Installation Issues

```vim
:Mason                    " Check installation status
:MasonLog                 " View installation logs
:LspInfo                  " Check LSP server status
```

### Language-Specific Issues

**C#**: Ensure .NET SDK installed (`dotnet --version`)
**Python**: Ensure Python 3+ available (`python3 --version`)  
**Go**: Ensure Go installed (`go version`)
**TypeScript**: Node.js recommended for npm packages
**Bash**: Most systems have bash built-in

### Common Fixes

- Restart Neovim after Mason installs tools
- Run `:LspRestart` if servers aren't working
- Check `:checkhealth` for configuration issues

## File Structure

```
vim-config-validation/
├── README.md              # This file
├── src/
│   ├── csharp/
│   │   ├── Program.cs          # C# test application
│   │   ├── TestApp.csproj      # Project file
│   │   └── README.md           # C#-specific instructions
│   ├── python/
│   │   ├── main.py             # Python test script
│   │   └── README.md           # Python-specific instructions
│   ├── go/
│   │   ├── main.go             # Go test program
│   │   ├── go.mod              # Go module file
│   │   ├── go.sum              # Go dependencies
│   │   └── README.md           # Go-specific instructions
│   ├── typescript/
│   │   ├── src/index.ts        # TypeScript test code
│   │   ├── package.json        # Node.js dependencies
│   │   ├── tsconfig.json       # TypeScript config
│   │   ├── .eslintrc.json      # ESLint config
│   │   ├── .prettierrc         # Prettier config
│   │   └── README.md           # TypeScript-specific instructions
│   └── bash/
│       ├── test_script.sh      # Bash test script
│       └── README.md           # Bash-specific instructions
├── LICENSE
└── .gitignore
```

## Integration with Your Config

This test suite assumes your Neovim configuration includes:

- **Plugin manager**: lazy.nvim (Kickstart-style)
- **LSP**: nvim-lspconfig + mason-lspconfig
- **Completion**: blink.cmp or similar
- **Debugging**: nvim-dap + mason-nvim-dap
- **Formatting**: conform.nvim or similar
- **Linting**: nvim-lint
- **Tool management**: Mason with auto-install

Each test validates the complete development workflow for its respective language, ensuring your configuration provides a professional development experience across all supported languages.
