# TypeScript Test Project

Quick validation test for TypeScript support in Neovim.

## Features to Test

### LSP Features (ts_ls)
- Hover over variables/functions to see type information
- `grd` (go to definition) on function calls and imports
- `grr` (find references) on classes and functions
- `grn` (rename) variables/functions across files
- Autocomplete when typing (especially object properties and methods)
- Type checking and error highlighting
- Import suggestions and auto-imports

### Formatting (prettier)
- `<leader>f` to format code with prettier
- Auto-format on save

### Linting (eslint_d)
- Real-time linting errors and warnings
- Code quality suggestions
- TypeScript-specific rules

### TypeScript Commands
- `<leader>co`: Organize imports
- `<leader>ci`: Add missing imports
- `<leader>cf`: Fix all auto-fixable issues

## Quick Test
1. Open `src/index.ts`
2. Test hover by placing cursor over `PersonManager` class
3. Use `grd` on `findPersonById` method call
4. Try autocomplete by typing `person.` to see properties
5. Test formatting with `<leader>f`
6. Test organize imports with `<leader>co`

## Setup and Run
```bash
# Install dependencies (optional - just for running)
npm install

# Run the TypeScript file
npm run dev

# Or compile and run
npm run build
node dist/index.js
```

## Intentional Issues for Testing
- Line 149: Missing email field in processPersonData test
- ESLint will show warnings for unused variables if you add them
- Try adding an unused variable to test linting