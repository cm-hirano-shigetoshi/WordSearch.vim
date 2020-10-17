scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

let s:fzfyml = "fzfyml run"
let s:tool_dir = expand('<sfile>:p:h')
let s:temp = tempname()
let s:yaml = s:tool_dir . "/WordSearch.yml"

function! WordSearch#Core(word)
    if has('nvim')
        let s:tmpfile = tempname()
        function! OnFzfExit(job_id, data, event)
            bd!
            let lines = readfile(s:tmpfile)
            if len(lines) > 0
                for f in lines
                    let file_line = split(f, ':')
                    execute("edit +" . file_line[1] . ' ' . file_line[0])
                    execute('normal zz')
                endfor
                redraw!
            endif
        endfunction
        call delete(s:tmpfile)
        enew
        setlocal statusline=fzf
        setlocal nonumber
        call termopen(s:fzfyml . " " .  s:yaml . " '" . a:word . "' > " . s:tmpfile, {'on_exit': 'OnFzfExit'})
        startinsert
    else
        let out = system("tput cnorm > /dev/tty; " . s:fzfyml . " " . s:yaml . " '" . a:word . "' 2>/dev/tty")
        for f in split(out, '\n')
            let file_line = split(f, ':')
            execute("edit +" . file_line[1] . ' ' . file_line[0])
            execute('normal zz')
        endfor
        redraw!
    endif
endfunction

function! WordSearch#WordSearch()
    call WordSearch#Core('')
endfunction

function! WordSearch#ThisWord()
    let word = expand('<cword>')
    call WordSearch#Core(word)
endfunction

function! WordSearch#SelectedWord()
    let tmp = @@
    silent normal gvy
    let word = @@
    let @@ = tmp
    call WordSearch#Core(word)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

