function prtags#enteredVim()
    for i in globpath( g:prtags_dir, '*', 0, 1 )
        if ! isdirectory( i )
            exec 'set tags+=' . i
        endif
    endfor
endfunction

function prtags#addedNewBuffer()
    call prtags#setupTagsFile()
endfunction

function prtags#writenBuffer()      " Write tags file
    call prtags#updateTagsFile()
endfunction

function prtags#setupTagsFile()     " Set tag name for buffer
    let l:tmp = substitute( expand( '%:p' ), fnamemodify( g:prtags_dir, ':h' ) . '/', '', '' )
    let b:prtags_tagfileName = substitute( l:tmp, '/', '.', 'g' ) . '.tags'
    unlet l:tmp
    
    if expand( '%:p' ) =~ fnamemodify( g:prtags_dir, ':h' )
        let b:prtags_file_in_project = 1
    else
        let b:prtags_file_in_project = 0
    endif

    call prtags#updateTagsFile()
endfunction

function prtags#updateTagsFile()    " Update tags file if buffer changed
    if b:prtags_file_in_project 
        if index( g:prtags_file_types_array, &filetype ) >= 0
            let l:tmp = 'ctags --tag-relative=yes --verbose=yes ' .
                        \ '-f ' . g:prtags_dir . '/' . b:prtags_tagfileName .
                        \ ' ' . expand( '%:.' )
            call system( l:tmp )
        endif
    endif
endfunction
