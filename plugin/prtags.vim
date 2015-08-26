" Ensure script is only loaded once
if &cp || exists( "g:prtags_loaded" )
    finish
endif
let g:prtags_loaded = 1

" Check if .prtags folder exists. If it does, then enable prtags features
let g:prtags_dir = finddir( ".prtags", ";" )
if g:prtags_dir ==# '.prtags'
    let g:prtags_dir = getcwd() . '/.prtags'
endif
if !empty( g:prtags_dir )
    if !exists( "g:prtags_file_types" )
        let g:prtags_file_types = "c;cpp"
    endif
    let g:prtags_file_types_array = split( g:prtags_file_types, ';' )

    " If the idrectory exists, register functions
    augroup PluginPrTags
        autocmd!
        autocmd VimEnter * call prtags#enteredVim()
        autocmd BufNewFile,BufRead * call prtags#addedNewBuffer()
        "autocmd FileChangedShellPost    "Rename tags file to match new buffer name
        autocmd BufWritePost * call prtags#writenBuffer()  "Write tags file
    augroup END
endif
