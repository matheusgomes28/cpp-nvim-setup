set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

"
" User Global Settings
syntax on " Syntax highlighting
set number
set showmatch " Shows matching brackets
set ruler " Always shows location in file (line#)
set smarttab " Autotabs for certain code
set shiftwidth=4

"Vundle Settings (copy-paste)
"
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" YCM installation
Plugin 'Valloric/YouCompleteMe'

" FZF instal
Plugin 'junegunn/fzf.vim'
"
" Cmake install
Plugin 'cdelledonne/vim-cmake'

"
" File Explorer plugin
Plugin 'ms-jpq/chadtree'

"
" tabs
Plugin 'nvim-tree/nvim-web-devicons'
Plugin 'romgrk/barbar.nvim'

"
" Theme install ?
Plugin 'rebelot/kanagawa.nvim'

"
" Install dap
Plugin 'mfussenegger/nvim-dap'

"
" Install DAP ui
Plugin 'rcarriga/nvim-dap-ui'

"
" All of your Plugins must be added before the following line
call vundle#end()            " required

lua << EOF
require("dap").adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-vscode", -- adjust as needed
	name = "lldb",
}

local lldb = {
	name = "Launch lldb",
	type = "lldb", -- matches the adapter
	request = "launch", -- could also attach to a currently running process
	program = function()
		return vim.fn.input(
			"Path to executable: ",
			vim.fn.getcwd() .. "/",
			"file"
		)
	end,
	cwd = "${workspaceFolder}",
	stopOnEntry = false,
	args = {},
	runInTerminal = false,
}

require('dap').configurations.rust = {
	lldb -- different debuggers or more configurations can be used here
}

local dap = require('dap')
dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    -- runInTerminal = false,
  },
}
EOF

"
" Include nvim-dap-config
source nvim-dap-ui-config.vim

"
" Theme settings after plugin
colorscheme kanagawa
highlight Normal guibg=none
highlight NonText guibg=none
filetype plugin indent on    " required

" User Mappings
nmap <C-f> :Files<cr> 
nmap <C-f><C-a> :Ag<cr>
nnoremap <F12> :YcmCompleter GoToDefinition<cr>

"
" All of the dap mappings
nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
" 
" nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
nnoremap <silent> <Leader>b <Cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>
















