If I Only...
============

**If I Only...** is an only slightly smarter `:only`.

It's pretty simple: If there are any unmodifiable buffers open
([NERDTree](https://github.com/scrooloose/nerdtree),
[`:Gstatus`](https://github.com/tpope/vim-fugitive), quickfix window, etc.), close
them leaving any modifiable buffers alone.  If there are only modifiable splits
open, make the current one the only one&mdash;i.e., call plain old `:only`.
If you are in an unmofiable buffer, jump to the first modifiable one (this last
point is configurable; see `:help ifionly`).


Usage
=====

There is only one command (`:IfIOnly`) and one mapping (`<C-W>O`).

I would suggest using an even simpler mapping.  Personally, I use `L`.

I made this because my default vim state is to have two buffers open,
side-by-side.  Sometimes I'll find myself in a position where
[git](https://github.com/tpope/vim-fugitive) status, the quickfix window, and
sometimes even [NERDTree](https://github.com/scrooloose/nerdtree)--(or, *ahem* the
[twiggy](https://github.com/sodapopcan/vim-twiggy) window) are all open and
I want to quickly get back to my default state in one of two keystokes.

If this sounds useful to you yet you like to have something like NERDTree open
at all times, `g:ifionly_filetypes` can be set in your vimrc.  For example:

```viml
g:ifionly_filetypes = ['nerdtree']
```


About
=====

Like this plugin?  Please star it or vote for it on
[vim.org](http://www.vim.org)!  Any feedback is always welcome.

**If I Only...**'s namesake is a song by Toronto, ON band [Do Make Say
Think](https://www.youtube.com/watch?v=4uFwM9Bnp_I).
