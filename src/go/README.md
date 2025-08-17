# Go Test Project

Quick validation test for Go support in Neovim.

## Features to Test

### LSP Features (gopls)
- Hover over variables/functions to see type information
- `grd` (go to definition) on function calls and types
- `grr` (find references) on structs and functions
- `grn` (rename) variables/functions across files
- Autocomplete when typing (especially struct fields and methods)
- Error highlighting and suggestions

### Debugging (delve)
- Set breakpoints with `F9` or `<leader>db`
- Start debugging with `F5` 
- Step through code with `F10` (step over), `F11` (step into)
- Inspect variables and structs in debug UI
- Test panic recovery in debugger

### No Formatting
- Go has built-in formatting, no additional formatter needed
- Files are automatically formatted on save by gopls

## Quick Test
1. Open `main.go`
2. Set breakpoint on line with `calc.Add(5, 3)`
3. Press `F5` and choose "Debug file"
4. Verify variables appear in debug UI
5. Test LSP by hovering over `Person` struct
6. Try autocomplete by typing `person.` to see methods

## Run the Program
```bash
go run main.go
```

## Module Setup
The project includes a `go.mod` file with dependencies. Run `go mod tidy` if needed.