" quickrun: hook/qo: Execute qo
" Author  : rito <rito.0305@gmail.com>
" License : zlib License

let s:save_cpo = &cpo
set cpo &vim

let s:hook = {}

function! s:hook.on_module_loaded(session, context) abort
  if !(&filetype == 'c' || &filetype == 'cpp' || &filetype == 'objc' || &filetype == 'objcpp')
    return
  endif
  let lines = readfile(a:session.config.srcfile, 0, 10)
  if len(filter(lines, 'v:val =~# "#qo"')) > 0
    call insert(a:session.config.exec, 'qo', 0)
    let a:session.config.exec = ['qo', '%s:p:h/%s:p:h:t %a']
  endif
endfunction

function! quickrun#hook#qo#new() abort
  return deepcopy(s:hook)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

