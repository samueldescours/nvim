call plug#begin()

Plug 'shaunsingh/solarized.nvim'
Plug 'AmberLehmann/candyland.nvim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'folke/tokyonight.nvim'
Plug 'sainnhe/everforest'
Plug 'neovim/nvim-lspconfig'
Plug 'mason-org/mason.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': 'v0.2.0' }
Plug 'morhetz/gruvbox'

call plug#end()

execute 'luafile ' . expand("<sfile>:p:h") . "/lsp.lua"

:set number
:set rnu
:set colorcolumn=80
:set mouse=

inoremap { {<Cr>}<Esc>ko
inoremap ( ()<Esc>i
inoremap <C-End> <><Esc>i
inoremap " ""<Esc>i
inoremap ' ''<Esc>i
inoremap ` ``<Esc>i
inoremap <C-b> {}<Esc>i

imap <End> <
imap <Insert> >
cmap <End> <
cmap <Insert> >
nmap <End> <
nmap <Insert> >

let mapleader = " "

nmap <leader>ff <cmd>Telescope find_files<CR>
nmap <leader>fb <cmd>Telescope buffers<CR>
nmap <leader>ht <cmd>sp<CR><C-w><Down><cmd>terminal<CR>a
nmap <leader>vt <cmd>vs<CR><C-w><Right><cmd>terminal<CR>a

let g:gruvbox_contrast_light="soft"
set background=light
colorscheme gruvbox

runtime! ftplugin/man.vim

command! E Explore

autocmd BufRead,BufNewFile * set expandtab
autocmd BufRead,BufNewFile Makefile set noexpandtab
autocmd BufRead * filetype detect

set tabstop=4
set shiftwidth=4
set ai
set si

set fileformat=unix

autocmd BufNewFile,BufRead *.h set filetype=c

let s:comMapNoShebang = {
            \ 'c': {'b': '/*', 'm': '**', 'e': '*/'},
            \ 'cpp': {'b': '//', 'm': '//', 'e': '//'},
            \ 'make': {'b': '##', 'm': '##', 'e': '##'},
            \ 'java': {'b': '//', 'm': '//', 'e': '//'},
            \ 'latex': {'b': '%%', 'm': '%%', 'e': '%%'},
            \ 'html': {'b': '<!--', 'm': '  --', 'e': '-->'},
            \ 'lisp': {'b': ';;', 'm': ';;', 'e': ';;'},
            \ 'css': {'b': '/*', 'm': '**', 'e': '*/'},
            \ 'pov': {'b': '//', 'm': '//', 'e': '//'},
            \ 'pascal': {'b': '{ ', 'm': '   ', 'e': '}'},
            \ 'haskell': {'b': '{-', 'm': '-- ', 'e': '-}'},
            \ 'vim': {'b': '""', 'm': '"" ', 'e': '""'},
            \}

let s:comMapShebang = {
            \ 'sh': {'s': '#!/usr/bin/env sh', 'b': '##', 'm': '##', 'e': '##'},
            \ 'bash': {'s': '#!/usr/bin/env bash', 'b': '##', 'm': '##', 'e': '##'},
            \ 'zsh': {'s': '#!/usr/bin/env zsh', 'b': '##', 'm': '##', 'e': '##'},
            \ 'php': {'s': '#!/usr/bin/env php', 'b': '/*', 'm': '**', 'e': '*/'},
            \ 'perl': {'s': '#!/usr/bin/env perl', 'b': '##', 'm': '##', 'e': '##'},
            \ 'python': {'s': '#!/usr/bin/env python3', 'b': '##', 'm': '##', 'e': '##'},
            \ 'ruby': {'s': '#!/usr/bin/env ruby', 'b': '##', 'm': '##', 'e': '##'},
            \ 'node': {'s': '#!/usr/bin/env node', 'b': '/*', 'm': '**', 'e': '*/'},
            \}



function! s:Epiyear()
    let old_time = v:lc_time
    language time en_US.utf8
    let str = strftime("%Y")
    exec 'language time '.old_time
    return str
endfunction

function! s:InsertFirst()
    call inputsave()
    let proj_name = input('Enter project name: ')
    let file_desc = input('Enter file description: ')
    call inputrestore()
    1,6s/µPROJECTNAMEµ/\= proj_name/ge
    1,6s/µYEARµ/\= s:Epiyear()/ge
    1,6s/µFILEDESCµ/\= file_desc/ge
endfunction

function! s:IsSupportedFt()
    return has_key(s:comMapNoShebang, &filetype)
endfunction

function! s:IsSupportedFtShebang()
    return has_key(s:comMapShebang, &filetype)
endfunction

function! Epi_header()
    if s:IsSupportedFt()
        let Has_Shebang = 0
    elseif s:IsSupportedFtShebang()
        let Has_Shebang = 1
    else
        echoerr "Epitech header: Unsupported filetype: " . &filetype . " If you think this an error or you want an additional filetype please contact me :)"
        return
    endif

    if Has_Shebang == 0
        let l:bcom = s:comMapNoShebang[&filetype]['b']
        let l:mcom = s:comMapNoShebang[&filetype]['m']
        let l:ecom = s:comMapNoShebang[&filetype]['e']

        let l:ret = append(0, l:bcom)
        let l:ret = append(1, l:mcom . " EPITECH PROJECT, µYEARµ")
        let l:ret = append(2, l:mcom . " µPROJECTNAMEµ")
        let l:ret = append(3, l:mcom . " File description:")
        let l:ret = append(4, l:mcom . " µFILEDESCµ")
        let l:ret = append(5, l:ecom)
    else
        let l:scom = s:comMapShebang[&filetype]['s']
        let l:bcom = s:comMapShebang[&filetype]['b']
        let l:mcom = s:comMapShebang[&filetype]['m']
        let l:ecom = s:comMapShebang[&filetype]['e']

        let l:ret = append(0, l:scom)
        let l:ret = append(1, l:bcom)
        let l:ret = append(2, l:mcom . " EPITECH PROJECT, µYEARµ")
        let l:ret = append(3, l:mcom . " µPROJECTNAMEµ")
        let l:ret = append(4, l:mcom . " File description:")
        let l:ret = append(5, l:mcom . " µFILEDESCµ")
        let l:ret = append(6, l:ecom)
    endif
    call s:InsertFirst()
    :8
endfunction

command! Header call Epi_header()

command! GPL2H call append(0, [
\ '/*',
\ ' * Copyright (C) ' . strftime("%Y") . ' Samuel DESCOURS',
\ ' *',
\ ' * This program is free software; you can redistribute it and/or modify',
\ ' * it under the terms of the GNU General Public License as published by',
\ ' * the Free Software Foundation; either version 2 of the License, or',
\ ' * (at your option) any later version.',
\ ' *',
\ ' * This file is part of: https://github.com/samueldescours/dmml',
\ ' */',
\ ''
\ ])
