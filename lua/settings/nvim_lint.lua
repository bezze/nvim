require('lint').linters.eslint_project = function ()
    local eslint = require('lint').linters.eslint
    local linter = {}
    linter.args = {'exec', 'eslint', "--format", "json", "--stdin", "--stdin-filename", eslint.args[5] } -- list of arguments. Can contain functions with zero arguments that will be evaluated once the linter is used.
    -- linter.cmd =  '/home/odysseus/.local/bin/pnpm'
    linter.cmd =  '/usr/bin/pnpm'
    linter.ignore_exitcode = eslint.ignore_exitcode
    linter.parser = eslint.parser
    linter.stdin = eslint.stdin
    linter.stream = eslint.stream
  -- args = { "--format", "json", "--stdin", "--stdin-filename", <function 1> },
  -- cmd = <function 2>,
  -- ignore_exitcode = true,
  -- parser = <function 3>,
  -- stdin = true,
  -- stream = "stdout"
    return linter
end

require('lint').linters_by_ft = {
  typescript = {'eslint_project'},
}
