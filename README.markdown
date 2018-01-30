If I Only&hellip;
=================

**If I Only&hellip;** is an only slightly smarter `:only`.

It's pretty simple: If there are any unmodifiable buffers open
([NERDTree](https://github.com/scrooloose/nerdtree),
[`:Gstatus`](https://github.com/tpope/vim-fugitive), quickfix window, etc.),
close them leaving any modifiable buffers alone.  If there are only modifiable
splits open, make the current one the only one&mdash;i.e., call plain old
`:only`.  If you are in an unmodifiable buffer, jump to the first modifiable one
(this last point is configurable; see `:help ifionly`).


Usage
-----

There is only one command (`:IfIOnly`) and one mapping (`<C-W>O`).

I would suggest using an even simpler mapping.  Personally, I use `L`:

```viml
nnoremap L :IfIOnly<CR>
```


Motivation
----------

My default vim state is to have two modifiable buffers open, side-by-side.
Sometimes I'll find myself in a position where the
[`:Gstatus`](https://github.com/tpope/vim-fugitive) window, the quickfix window,
and sometimes even [NERDTree](https://github.com/scrooloose/nerdtree)&mdash;or,
*ahem* [twiggy](https://github.com/sodapopcan/vim-twiggy)&mdash;are all open and
I want to quickly get back to my default state in one or two keystokes.  For the
longest time, I was calling `:only` like crazy, only to have to bring back my
split... hence If I Only&hellip;

If this sounds useful to you yet you like to have something like NERDTree open
at all times, `g:ifionly_filetypes` can be set in your vimrc.  It take a list of
filetypes to be left alone by this plugin.  For example:

```viml
let g:ifionly_filetypes = ['nerdtree']
```


About
-----

Like this plugin?  Please star it or vote for it on
[vim.org](http://www.vim.org)!  Any feedback is always welcome.

**If I Only&hellip;**'s namesake is [a song by Do Make Say
Think](https://www.youtube.com/watch?v=4uFwM9Bnp_I).
