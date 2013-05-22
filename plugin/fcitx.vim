" NEW BSD LICENSE {{{
" Copyright (c) 2013, anekos.
" All rights reserved.
"
" Redistribution and use in source and binary forms, with or without modification,
" are permitted provided that the following conditions are met:
"
"     1. Redistributions of source code must retain the above copyright notice,
"        this list of conditions and the following disclaimer.
"     2. Redistributions in binary form must reproduce the above copyright notice,
"        this list of conditions and the following disclaimer in the documentation
"        and/or other materials provided with the distribution.
"     3. The names of the authors may not be used to endorse or promote products
"        derived from this software without specific prior written permission.
"
" THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
" ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
" WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
" IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
" INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
" BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
" DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
" LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
" OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
" THE POSSIBILITY OF SUCH DAMAGE.
"
"
" ###################################################################################
" # http://sourceforge.jp/projects/opensource/wiki/licenses%2Fnew_BSD_license       #
" # に参考になる日本語訳がありますが、有効なのは上記英文となります。                #
" ###################################################################################
"
" }}}

" Mojo {{{

if exists('g:anekos_felis_cat_igirisu_toast_express_loaded')
  finish
endif

scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

" }}}

" Meowin {{{

if executable("fcitx-remote")
  function! s:fcitx_enter()
    let l:opt = (exists('b:fcitx_last_state') && b:fcitx_last_state) ? 'o' : 'c'
    if s:fcitx_fix_mode
      call system('fcitx-remote -' . l:opt)
    endif
  endfunction

  function! s:fcitx_leave(store)
    if a:store
      let b:fcitx_last_state = match(system('fcitx-remote'), '^2') == 0
    endif
    call system('fcitx-remote -c')
  endfunction

  function! s:fcitx_fix_mode()
    let s:fcitx_fix_mode = !s:fcitx_fix_mode
    if s:fcitx_fix_mode
      echomsg 'Fcitx Fix Mode: On'
    else
      echomsg 'Fcitx Fix Mode: Off'
    endif
  endfunction

  let s:fcitx_fix_mode = 0

  command! FcitxFixMode :call <SID>fcitx_fix_mode()

  augroup FCITX
    autocmd!
    autocmd InsertEnter * call <SID>fcitx_enter()
    autocmd BufLeave    * call <SID>fcitx_leave(0)
    autocmd CmdwinLeave * call <SID>fcitx_leave(0)
    autocmd InsertLeave * call <SID>fcitx_leave(1)
  augroup END
endif

" }}}

" Mojo {{{

let &cpo = s:save_cpo
unlet s:save_cpo

let g:anekos_felis_cat_igirisu_toast_express_loaded = 1

" }}}
