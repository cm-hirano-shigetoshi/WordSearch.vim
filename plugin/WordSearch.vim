scriptencoding utf-8
if exists('g:load_WordSearch')
    finish
endif
let g:load_WordSearch = 1

let s:save_cpo = &cpo
set cpo&vim

nnoremap <silent> <Plug>(WordSearch#WordSearch) :<C-u>call WordSearch#WordSearch()<CR>
nnoremap <silent> <Plug>(WordSearch#ThisWord) :<C-u>call WordSearch#ThisWord()<CR>
vnoremap <silent> <Plug>(WordSearch#SelectedWord) :<C-u>call WordSearch#SelectedWord()<CR>
nmap <Tab>/ <Plug>(WordSearch#WordSearch)
nmap <Tab>* <Plug>(WordSearch#ThisWord)
vmap <Tab>* <Plug>(WordSearch#SelectedWord)

let &cpo = s:save_cpo
unlet s:save_cpo
