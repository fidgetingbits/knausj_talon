os: linux
tag: user.gdb
-
tag(): user.debugger
tag(): user.terminal_program
tag(): user.readline

# XXX - this would be better to be managed with settings maybe
# optional generic debugger plugins
# specify which heap plugin you're using
# similar to the architecture
tag(): user.libptmalloc
#tag(): user.libdlmalloc
#tag(): user.libheap
tag(): user.gef
#tag(): user.pwndbg


until <number>: "until {number}"

force clear all break points:
    insert("d br\n")
    insert("y\n")



break [on] clipboard:
    insert("break ")
    key(ctrl-shift-v)
    key(enter)

clear screen: "shell clear\n"
# information
list [source]: "list\n"

print: "p "
print [variable] <user.text>: "p {text}"
print hex: "p/x "
print hex [variable] <user.text>: "p/x {text}"
print string: "p/s "
print (bits|binary): "p/t "

# hexdumping
# XXX - switch the sizes to a list in python?
# XXX - should cache the last used size
hex dump <number> bytes: "x/{number}bx "
hex dump <number> (half|short) words: "x/{number}hx "
hex dump <number> (d|long) words: "x/{number}dx "
hex dump <number> quad words: "x/{number}gx "
# this is some arbitrary default for convenience
hex dump: "x/100gx "
hex dump highlighted:
    insert("x/100gx ")
    edit.copy()
    edit.paste()
    key(enter)
hex dump clipboard:
    insert("x/100gx ")
    edit.paste()
    key(enter)

# symbols
symbol refresh: "sharedlibrary\n"

# execution
source: "source \t\t"

# displays
# XXX - move thee invoke command into a python script
(list|show|info) display: "info display\n"
display assembly line$: "display /i $pc\n"
display source: "display "
enable display <number_small>: "enable display {number_small}\n"
disable display <number_small>: "disable display {number_small}\n"
undisplay: "undisplay\n"

# variables
(list|show|info) local: "info local "
(list|show|info) local typed: "info local -t "
(list|show|info) variable: "info variable "
(list|show|info) variable typed: "info variable -t "
(list|show|info) locals: "info local\n"
(list|show|info) variables: "info variables\n"

# threads
info threads: "info threads\n"

# inferiors
info inferiors: "info inferiors\n"
inferior <number_small>$: "inferior {number_small}\n"
inferior: "inferior "
resume from main:
    insert("inferior 1\n")
    insert("c\n")
resume [from] (inf|inferior) <number_small>$:
    insert("inferior {number_small}\n")
    insert("c\n")
    
# arguments
set args: "set args "

info source: "info source\n"

show follow (fork|forks) [mode]: "show follow-fork-mode\n"
[set] follow (fork|forks) [mode] child: "set follow-fork-mode child\n"
[set] follow (fork|forks) [mode] parent: "set follow-fork-mode parent\n"

show detach on fork: "show detach-on-fork\n"
set detach on fork: "set detach-on-fork on\n"
unset detach on fork: "set detach-on-fork off\n"

info library: "info sharedlibrary\n"
info file: "info file\n"

set remote file: "set remote exec-file "

set system root: "set sysroot "
show system root: "show sysroot\n"

set substitute path: "set substitute-path "
show substitute path: "show substitute-path\n"

show list size: "show listsize\n"
set list size <number_small>: "set listsize {number_small}\n"

set remote target: "target extended-remote :9999\n"
