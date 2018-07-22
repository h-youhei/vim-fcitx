if exists('g:loaded_vim_fcitx')
	finish
endif
if !executable('fcitx-remote')
	finish
endif
if system('fcitx-remote') =~ 'Not get reply'
	finish
endif

let s:save_cpo = &cpo
set cpo&vim


if !exists('g:fcitx#insert_mode_behavior')
	let g:fcitx#insert_mode_behavior = 'restore'
endif
if !exists('g:fcitx#commandline_behavior')
	let g:fcitx#commandline_behavior = 'off'
endif

"remove these lines on 2019/7/22
if exists('g:fcitx#handle_insert_mode')
	echo 'g:fcitx#handle_insert_mode is removed.'
	echo 'use g:fcitx#insert_mode_behavior instead.'
endif
if exists('g:fcitx#handle_search_command')
	echo 'g:fcitx#handle_search_command is removed.'
	echo 'use g:fcitx#commandline_behavior instead.'
endif

augroup fcitx
	autocmd!
	au BufEnter,CmdwinEnter * let b:was_fcitx_on = v:false
augroup END

if g:fcitx#insert_mode_behavior == 'restore'
	augroup fcitx
		au InsertLeave * call fcitx#inactivate_with_state()
		au InsertEnter * call fcitx#restore_state()
	augroup END
elseif g:fcitx#insert_mode_behavior == 'off'
	augroup fcitx
		au InsertLeave * call fcitx#inactivate()
	augroup END
endif

if g:fcitx#commandline_behavior == 'restore'
	augroup fcitx
		au CmdLineLeave [/\?] call fcitx#inactivate_with_state()
		au CmdLineEnter [/\?] call fcitx#restore_state()
		au CmdLineLeave : call fcitx#inactivate()
	augroup END
elseif g:fcitx#commandline_behavior == 'off'
	augroup fcitx
		au CmdLineLeave * call fcitx#inactivate()
	augroup END
endif

let g:loaded_vim_fcitx = v:true

let &cpo = s:save_cpo
unlet s:save_cpo
