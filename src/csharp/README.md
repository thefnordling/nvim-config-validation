# C# Test Project

Quick validation test for C# support in Neovim.

## Features to Test

### LSP Features
- Hover over variables/methods to see type information
- `grd` (go to definition) on method calls and types
- `grr` (find references) on classes and methods  
- `grn` (rename) variables/methods
- Autocomplete when typing

### Debugging
- Set breakpoints with `F9` or `<leader>db`
- Start debugging with `F5`
- Step through code with `F10` (step over), `F11` (step into)

### Formatting
- `<leader>f` to format code with csharpier
- Auto-format on save

## Quick Test
1. Open `Program.cs`
2. Set breakpoint on line with `calc.Add(5, 3)`
3. Press `F5` to start debugging
4. Verify variables appear in debug UI
5. Test LSP by hovering over `Calculator` class