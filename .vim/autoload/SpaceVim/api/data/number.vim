let s:save_cpo = &cpo
set cpo&vim

function! SpaceVim#api#data#number#get() abort
  return map({
        \ 'random' : '',
        \ },
        \ "function('s:' . v:key)"
        \ )
endfunction

" Random seed.
if has('reltime')
  let s:rel = reltime() + reltime()
  if len(s:rel) > 3
    let [s:x, s:y, s:z, s:w; s:rest] = s:rel
  else
    let [s:x, s:y, s:z, s:w] = [1, 2, 3, 4]
  endif
else
  let [s:x, s:y, s:z, s:w] = [1, 2, 3, 4]
endif

" Random number.
"   random()     : an unbounded random integer number.
"   random(a)    : an unbounded random number larger than a.
"   random(a, b) : a random number from [a, a + b - 1].
function! s:random(...) abort
  let a = a:0 ? a:1 : 0
  let b = a:0 > 1 ? a:2 : 0x1000000
  let t = s:xor(s:x, (s:x * 0x800))
  let [s:x, s:y, s:z] = [s:y, s:z, s:w]
  let s:w = s:xor(s:xor(s:w, (s:w / 0x80000)), s:xor(t, (t / 0x100)))
  return a + s:w % b
endfunction

" xor function from vital.vim
if exists('*xor')

  function! s:xor(a, b) abort
    return xor(a:a, a:b)
  endfunction

else

  function! s:xor(a, b) abort
    let a = a:a < 0 ? a:a - 0x80000000 : a:a
    let b = a:b < 0 ? a:b - 0x80000000 : a:b
    let r = 0
    let n = 1
    while a || b
      let r += s:xor[a % 0x10][b % 0x10] * n
      let a = a / 0x10
      let b = b / 0x10
      let n = n * 0x10
    endwhile
    if (a:a < 0) != (a:b < 0)
      let r += 0x80000000
    endif
    return r
  endfunction

  " xor table from vital.vim
  let s:xor = [
        \ [0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF],
        \ [0x1, 0x0, 0x3, 0x2, 0x5, 0x4, 0x7, 0x6, 0x9, 0x8, 0xB, 0xA, 0xD, 0xC, 0xF, 0xE],
        \ [0x2, 0x3, 0x0, 0x1, 0x6, 0x7, 0x4, 0x5, 0xA, 0xB, 0x8, 0x9, 0xE, 0xF, 0xC, 0xD],
        \ [0x3, 0x2, 0x1, 0x0, 0x7, 0x6, 0x5, 0x4, 0xB, 0xA, 0x9, 0x8, 0xF, 0xE, 0xD, 0xC],
        \ [0x4, 0x5, 0x6, 0x7, 0x0, 0x1, 0x2, 0x3, 0xC, 0xD, 0xE, 0xF, 0x8, 0x9, 0xA, 0xB],
        \ [0x5, 0x4, 0x7, 0x6, 0x1, 0x0, 0x3, 0x2, 0xD, 0xC, 0xF, 0xE, 0x9, 0x8, 0xB, 0xA],
        \ [0x6, 0x7, 0x4, 0x5, 0x2, 0x3, 0x0, 0x1, 0xE, 0xF, 0xC, 0xD, 0xA, 0xB, 0x8, 0x9],
        \ [0x7, 0x6, 0x5, 0x4, 0x3, 0x2, 0x1, 0x0, 0xF, 0xE, 0xD, 0xC, 0xB, 0xA, 0x9, 0x8],
        \ [0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF, 0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7],
        \ [0x9, 0x8, 0xB, 0xA, 0xD, 0xC, 0xF, 0xE, 0x1, 0x0, 0x3, 0x2, 0x5, 0x4, 0x7, 0x6],
        \ [0xA, 0xB, 0x8, 0x9, 0xE, 0xF, 0xC, 0xD, 0x2, 0x3, 0x0, 0x1, 0x6, 0x7, 0x4, 0x5],
        \ [0xB, 0xA, 0x9, 0x8, 0xF, 0xE, 0xD, 0xC, 0x3, 0x2, 0x1, 0x0, 0x7, 0x6, 0x5, 0x4],
        \ [0xC, 0xD, 0xE, 0xF, 0x8, 0x9, 0xA, 0xB, 0x4, 0x5, 0x6, 0x7, 0x0, 0x1, 0x2, 0x3],
        \ [0xD, 0xC, 0xF, 0xE, 0x9, 0x8, 0xB, 0xA, 0x5, 0x4, 0x7, 0x6, 0x1, 0x0, 0x3, 0x2],
        \ [0xE, 0xF, 0xC, 0xD, 0xA, 0xB, 0x8, 0x9, 0x6, 0x7, 0x4, 0x5, 0x2, 0x3, 0x0, 0x1],
        \ [0xF, 0xE, 0xD, 0xC, 0xB, 0xA, 0x9, 0x8, 0x7, 0x6, 0x5, 0x4, 0x3, 0x2, 0x1, 0x0]
        \ ]

endif

let &cpo = s:save_cpo
unlet s:save_cpo
