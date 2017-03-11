if exists('g:loaded_vim_fcitx')
	finish
endif

let s:save_cpo = &cpo
set cpo&vim

if !executable('fcitx-remote')
	finish
endif

if !exists('g:fcitx#handle_insert_mode')
	let g:fcitx#handle_insert_mode = v:true
endif
if !exists('g:fcitx#handle_search_command')
	let g:fcitx#handle_search_command = v:false
endif

augroup fcitx
	autocmd!
augroup END

if g:fcitx#handle_insert_mode
	augroup fcitx
		au BufEnter,CmdwinEnter * let b:was_fcitx_on = 0
		au InsertLeave * call fcitx#inactivate_with_state()
		au InsertEnter * call fcitx#restore_state()
	augroup END
endif

if g:fcitx#handle_search_command
	nnoremap <expr> / (fcitx#restore_state() . '/')
	nnoremap <expr> ? (fcitx#restore_state() . '?')
	cnoremap <expr> <CR> (fcitx#inactivate_with_state() . '<CR>')
	cnoremap <expr> <Esc> (fcitx#inactivate_with_state() . '<C-u><BS>')
endif

let g:loaded_vim_fcitx = v:true

let &cpo = s:save_cpo
unlet s:save_cpo
