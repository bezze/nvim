vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.cmd [[noremap ;p iconsole.log()<Esc>i]]   -- noremap ;p iconsole.log()<Esc>i
vim.cmd [[inoremap ;p console.log()<Esc>i]]   -- inoremap ;p console.log()<Esc>i
vim.cmd [[nnoremap ;o i;(async () =>{<CR>})()<Esc>O]]   -- inoremap ;p console.log()<Esc>i

-- vim.keymap.set({'n', 'i'}, ';p', function ()
--     -- vim.api.nvim_feedkeys('iconsole.log()<Esc>i', 'n', true)
--     relevant = [[ console.log()<Esc>i ]]
--         vim.cmd [['i' .. relevant ]]
-- end)

function getTsBuildErrors(file)
    -- src/index.ts(11,1): error TS2304: Cannot find name 'hola'.
    meta = {
        title='ts-errors-3',
        context='ts-errors-3'
    }
    vim.fn.setqflist({}, 'r', meta)     -- clear quickfix
    vim.fn.setqflist({}, 'a', {
        efm=[[%f(%l\,%c): %trror TS%n: %m]],  -- XXX: we *need* to escape comma because efm is a comma serparated list
        lines=vim.fn.systemlist("rg --text 'error TS' " .. file),
        title=meta.title,
        context=meta.context
    })
    vim.cmd [[:copen]]
end


vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {"*.ts"},
    callback = function()
        vim.keymap.set('n', '<Leader>E', function ()
            getTsBuildErrors('/tmp/build.errors')
        end, { buffer = true })
    end,
})

function initLintTs()
    return vim.api.nvim_create_namespace("my/ts_linter")
end

function tsLint(namespace)
    local errorList = {};
    local pnpm_lint = "pnpm --silent lint --no-color -f json -o /tmp/out";
    local command = table.concat({
        pnpm_lint,
        "||",
        [[ jq -r '.[] | select(.errorCount > 0) | .filePath + ";;" + (.messages[] | "\(.line):\(.column);;error;;\(.message);;\(.ruleId)")'  < /tmp/out ]]
    }, " ")
    local severity = {
        error = vim.diagnostic.severity.ERROR,
    -- vim.diagnostic.severity.WARN
    -- vim.diagnostic.severity.INFO
    -- vim.diagnostic.severity.HINT
    }
    result = vim.fn.systemlist(command)
    for i=1,4 do
        removed = table.remove(result, 1)
    end

    -- vim.print(result)
    -- jq -r '.[] | select(.errorCount > 0) | .filePath + ";;" + (.messages[] | "\(.line):\(.column);;error;;\(.message);;\(.ruleId)")'  < /tmp/out
    for index, line in ipairs(result) do
        fields = vim.fn.split(line, ";;")
        filePath = fields[1]
        linecol = fields[2]
        _severity = fields[3]
        message = fields[4]
        code = fields[5]


        local splitted = vim.fn.split(linecol, ":")
        local line = vim.fn.str2nr(splitted[1])
        local col = vim.fn.str2nr(splitted[2])

      -- • {bufnr}?      (`integer`) Buffer number
      -- • {lnum}        (`integer`) The starting line of the diagnostic (0-indexed)
      -- • {end_lnum}?   (`integer`) The final line of the diagnostic (0-indexed)
      -- • {col}         (`integer`) The starting column of the diagnostic (0-indexed)
      -- • {end_col}?    (`integer`) The final column of the diagnostic (0-indexed)
      -- • {severity}?   (`vim.diagnostic.Severity`) The severity of the diagnostic |vim.diagnostic.severity|
      -- • {message}     (`string`) The diagnostic text
      -- • {source}?     (`string`) The source of the diagnostic
      -- • {code}?       (`string|integer`) The diagnostic code
      -- • {_tags}?      (`{ deprecated: boolean, unnecessary: boolean}`)
      -- • {user_data}?  (`any`) arbitrary data plugins can add
      -- • {namespace}?  (`integer`)
        errorList[index] = {
            filename = filePath,
            lnum = line,
            col = col,
            severity = severity[_severity],
            message = message,
            code = code,
            namespace = namespace
        }
    end
    return errorList
end

function TsLint (opts)
    local namespace = initLintTs()
    local errorList = tsLint(namespace)
    loclist = {}
    for i, error in ipairs(errorList) do
        -- vim.print(error)
        loclist[i] = {
            filename=error.filename,
            lnum=error.lnum,
            text=error.message .. "   ||" .. error.code
        }
    end
    -- newItems = { {filename=bufname, lnum=number, text=lineText} }
    qflist = vim.fn.setloclist(0, loclist, 'r')
    vim.cmd [[:lopen]]
    -- vim.print(vim.fn.bufnr(), errorList[1])
    -- vim.diagnostic.set(namespace, vim.fn.bufnr(), errorList)
end

vim.api.nvim_create_user_command(
  'TsLint',
  TsLint,
  {bang = true, nargs = 0 }
)
