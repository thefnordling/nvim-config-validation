# Bash Test Project

Quick validation test for Bash support in Neovim.

## Features to Test

### LSP Features (bash-language-server)
- Hover over variables and functions to see information
- `grd` (go to definition) on function calls
- `grr` (find references) on functions
- `grn` (rename) variables/functions
- Autocomplete for variables, functions, and built-in commands

### Formatting (shfmt)
- `<leader>f` to format bash scripts
- Auto-format on save
- Consistent indentation and spacing

### Linting (shellcheck)
- Real-time linting warnings (red squiggles)
- Best practice suggestions
- Security issue detection
- Missing quotes warnings

## Quick Test
1. Open `test_script.sh`
2. Test hover by placing cursor over function names
3. Use `grd` on function calls like `log_message`
4. Try autocomplete by typing `$` to see variables
5. Notice shellcheck warnings (missing quotes on line 53)
6. Test formatting with `<leader>f`

## Run the Script
```bash
# Show help
./test_script.sh --help

# Run all tests
./test_script.sh --verbose

# Run specific actions
./test_script.sh --action data
./test_script.sh --action backup
./test_script.sh --action stats
```

## Intentional Issues for Testing
- Line 53: `mkdir -p $backup_dir` - missing quotes (shellcheck warning)
- Various functions to test navigation and autocomplete
- Error handling patterns for testing debugging techniques