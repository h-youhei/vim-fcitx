if exists('g:loaded_vim_fcitx')
	finish
endif

let g:loaded_vim_fcitx = v:true

if !executable('fcitx-remote')
	finish
endif

if !exists('g:fcitx#use_default_setting')
	let g:fcitx#use_default_setting = v:true
endif

augroup fcitx
	autocmd!
augroup END

if g:fcitx#use_default_setting
	augroup fcitx
		au BufEnter,CmdwinEnter * let b:was_fcitx_on = 0
		au InsertLeave * call fcitx#inactivate_with_state()
		au InsertEnter * call fcitx#restore_state()
	augroup END
endif
