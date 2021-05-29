# XXX - this should eventually be generic for handling multiple different lsp
# implementations
app: vim
-

(code server|lisp) info: user.vim_command_mode(":LspInfo\n")

#user.vim_command_mode(":lua vim.lsp.buf.clear_references()\n")
#user.vim_command_mode(":lua vim.lsp.buf.code_action()\n")
#user.vim_command_mode(":lua vim.lsp.buf.completion()\n")
tag declaration: user.vim_command_mode(":lua vim.lsp.buf.declaration()\n")
tag definition: user.vim_command_mode(":lua vim.lsp.buf.definition()\n")
tag highlight: user.vim_command_mode(":lua vim.lsp.buf.document_highlight()\n")
#user.vim_command_mode(":lua vim.lsp.buf.document_symbol()\n")
#user.vim_command_mode(":lua vim.lsp.buf.formatting()\n")
tag hover: user.vim_command_mode(":lua vim.lsp.buf.hover()\n")
#user.vim_command_mode(":lua vim.lsp.buf.implementation()\n")
tag in coming: user.vim_command_mode(":lua vim.lsp.buf.incoming_calls()\n")
tag out going: user.vim_command_mode(":lua vim.lsp.buf.outgoing_calls()\n")
tag references: user.vim_command_mode(":lua vim.lsp.buf.references()\n")
#user.vim_command_mode(":lua vim.lsp.buf.rename()\n")
#user.vim_command_mode(":lua vim.lsp.buf.signature_help()\n")
#user.vim_command_mode(":lua vim.lsp.buf.type_definition()\n")
#user.vim_command_mode(":lua vim.lsp.buf.workspace_symbol()\n")
