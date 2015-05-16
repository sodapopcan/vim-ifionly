If I Only...
============

**If I Only...** is an only slightly smarter `:only`.

It's pretty simple: If there are any unmodifiable buffers open (NERDtree,
`:Gstatus`, quickfix window), close them leaving any modifiable buffers alone.
If there are only modifiable splits open, make the current one the only one
&mdash; i.e., call plain old `:only`.  If you are in an unmofiable buffer, jump
to the first modifiable one (this last point is configurable; see `:help
ifionly`).


Usage
=====

There is only one command (`:IfIOnly`) and one mapping (`<C-W>O`).


Information
===========

**If I Only...**'s namesake is a song by Toronto, ON band [Do Make Say
Think](https://www.youtube.com/watch?v=4uFwM9Bnp_I).
