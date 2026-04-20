return {
    _on_attach = function(client, bufnr)
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', '<space>oi', function()
            -- vim.lsp.buf.execute_command({command = "_typescript.organizeImports", arguments = {vim.fn.expand("%:p")}})
            client:exec_cmd({
                command = "_typescript.organizeImports",
                arguments = {vim.fn.expand("%:p")}
            })
        end, bufopts)
    end,
    settings = {
        -- config of ts_ls
        typescript = {
            format = {
                baseIndentSize = 0,
                convertTabsToSpaces = true,
                indentSize = 4,
                -- indentSize = 2,
                indentStyle = "Block", -- ESLint/Prettier usually uses block style  None | Block | Smart
                insertSpaceAfterCommaDelimiter = true,
                insertSpaceAfterConstructor = false,
                insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
                insertSpaceAfterKeywordsInControlFlowStatements = true,
                insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = true,
                insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces = true,
                insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
                insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets = false,
                insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis = false,
                insertSpaceAfterOpeningAndBeforeClosingTemplateStringBraces = false,
                insertSpaceAfterSemicolonInForStatements = true,
                insertSpaceAfterTypeAssertion = false,
                insertSpaceBeforeAndAfterBinaryOperators = true,
                insertSpaceBeforeFunctionParenthesis = false,
                insertSpaceBeforeTypeAnnotation = false,
                newLineCharacter = "\n",
                placeOpenBraceOnNewLineForControlBlocks = false,
                placeOpenBraceOnNewLineForFunctions = false,
                semicolons = "insert",
                tabSize = 2,
                trimTrailingWhitespace = true
            }
        }
    }
}
