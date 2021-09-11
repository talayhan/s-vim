if exists('g:loaded_svim')
    finish
endif
let g:loaded_svim = 1

echo expand('<abuf>')

fun! SubstituteMCmd(actionCmdName, actionSubCmdType, actionSubCmdName)
	" code
	s/enMegaCommands/enActionCommands
	exe 's/\<[A-Z_]\+\>/' . a:actionCmdName . '/g'
	exe 's/}/} ${enums.' . a:actionSubCmdType . '.' . a:actionSubCmdName  .'}/g'
endf

fun! SubsActionCmd(actionType)
	"echom a:actionType
	exe 's/\<[A-Z]\+\>/' . a:actionType . '/g'
endf

command! SCTab set tabstop=4 shiftwidth=4 noexpandtab | %retab!
command! SCSpace set tabstop=4 shiftwidth=4 expandtab | %retab!
command! Scompile Dispatch cd build && cmake ../ && make
command! Smake Dispatch cd build && make
command! Srun Dispatch cd build && make && ./main
command! Sall Dispatch cd build && cmake ../ && make && ./main
command! Svalgrind Dispatch cd build && valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./main
"command! Svalgrind Dispatch cd build && valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose ./main

command! Sgraph Dispatch cd build && ./main |& tee graph.gv && dot -Tpng graph.gv > graph.png && feh graph.png
