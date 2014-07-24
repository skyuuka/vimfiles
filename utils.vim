" {{{
" use visual mode to select the text and then press \k to lookup 
" it in dict.youdao.com. :) I am Chinese 
vnoremap <leader>k :<c-u>call <SID>GrepLookUp(visualmode())<cr>
nnoremap <leader>k :set operatorfunc=<SID>GrepLookUp<cr>g@

function! s:GrepLookUp(type)
    let url = 'http://dict.youdao.com/search?q='
    let saved_unnamed_register = @@
    if a:type ==# 'v'
        execute "normal! `<v`>y"
    elseif a:type ==# 'char'
        execute "normal! `[v`]y"
    else
        return
    endif

    silent execute "!open " .  url . @@
    let @@ = saved_unnamed_register
endfunction
" }}}


" use visual mode to select text and then press \s to search it {{{
" in Google
vnoremap <leader>s :<c-u>call <SID>GrepSearch(visualmode())<cr>
nnoremap <leader>s :set operatorfunc=<SID>GrepSearch<cr>g@

function! Strip(input_string)
    return substitute(a:input_string, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction

function! s:GrepSearch(type)
    let url = 'http://www.google.com/search?q='
    let saved_unnamed_register = @@
    if a:type ==# 'v'
        execute "normal! `<v`>y"
    elseif a:type ==# 'char'
        execute "normal! `[v`]y"
    else
        return
    endif

    let keywords = url . join(split(@@), '+')
    silent execute "!open " . keywords 
    let @@ = saved_unnamed_register
endfunction
" }}}

"{{{
" put your curse under a URL and then press 
" \lo (link open) to open it in browser
nnoremap <leader>lo :call <SID>HandleURL()<cr>
function! s:HandleURL()
    let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
    if s:uri != ""
        silent exec "!open '".s:uri."'"
    else
        echo "No URI found in line."
    endif
endfunction
"}}}

" {{{
" Insert some thing special, try it. It amazing 
" you need to instll figlet first. On Mac, I install
" it using brew 
" $ brew install figlet
nnoremap <leader>isig :call <SID>InsertSpecial()<cr>
function! s:InsertSpecial()
    if executable('figlet')
        let l = line(".")
        let msg = system('figlet -f ogre "Awesome!"')
        call append(l, split(msg, '\n'))
    else
        echo "figlet is not installed"
    endif
endfunction
"}}}
