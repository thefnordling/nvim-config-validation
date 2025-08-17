# Python Test Project

Quick validation test for Python support in Neovim.

## Features to Test

### LSP Features (pyright)
- Hover over variables/functions to see type information
- `grd` (go to definition) on function calls and imports
- `grr` (find references) on classes and functions
- `grn` (rename) variables/functions across files
- Autocomplete when typing
- Type checking and error highlighting

### Debugging (debugpy)
- Set breakpoints with `F9` or `<leader>db`
- Start debugging with `F5`
- Step through code with `F10` (step over), `F11` (step into)
- Inspect variables in debug UI

### Formatting (black + isort)
- `<leader>f` to format code with black and organize imports with isort
- Auto-format on save

## Quick Test
1. Open `main.py`
2. Set breakpoint on line with `calc.add(5, 3)`
3. Press `F5` to start debugging
4. Verify variables appear in debug UI
5. Test LSP by hovering over `Person` class
6. Try autocomplete by typing `person.` to see methods

## Run the Script
```bash
python main.py
```