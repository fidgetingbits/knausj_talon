# commands that are designed to specifically work in all editing modes, but not
# something like the term where it might have its own underlying actions (like
# readline, etc). this should not include things that are specific to one mode,
# like normal or visual. if something specific it should go directly in
# vim_normal.talon or vim_visual.talon

app:vim
and not tag: user.vim_terminal
and not tag: user.vim_command_mode
-

###
# Actions - Talon generic command implementation
###
#
# NOTE: These are provided for people that want to use the official talon
# edit and line commands. The vim-specific commands can be used as an
# alternative where the command names differ. See `generic_editor.talon`, 
#
# TODO - currently the generic talon commands for things like
# `line_commands.talon` similar or not enabled via tag by default, however the
# underlying `edit` commands works so it should be possible to add fairly
# easily.
###
action(edit.find):
    user.vim_normal_mode_exterm_key("/")
action(edit.find_next):
    user.vim_normal_mode_key("n")
action(edit.word_left):
    user.vim_normal_mode_key("b")
action(edit.word_right):
    user.vim_normal_mode_key("w")
action(edit.left):
    key(left)
action(edit.right):
    key(right)
action(edit.up):
    key(up)
action(edit.down):
    key(down)
action(edit.line_start):
    user.vim_normal_mode_key("^")
action(edit.line_end):
    user.vim_normal_mode_key("$")
action(edit.file_end):
    user.vim_normal_mode_key(G)
action(edit.file_start):
    user.vim_normal_mode("gg")
action(edit.page_down):
    user.vim_normal_mode_exterm_key("ctrl-f")
action(edit.page_up):
    user.vim_normal_mode_exterm_key("ctrl-b")


# selecting (see generic_editor.talon)
action(edit.extend_line_up):
    user.vim_visual_mode("k^")
action(edit.extend_line_down):
    user.vim_visual_mode("j^")
action(edit.extend_left):
    user.vim_visual_mode("h")
action(edit.extend_right):
    user.vim_visual_mode("l")
action(edit.extend_word_left):
    user.vim_visual_mode("b")
action(edit.extend_word_right):
    user.vim_visual_mode("e")
action(edit.select_word):
    user.vim_visual_mode("e")
action(edit.extend_line_start):
    user.vim_visual_mode("^")
action(edit.extend_line_end):
    user.vim_visual_mode("$")
action(edit.extend_file_start):
    user.vim_visual_mode("gg0")
action(edit.extend_file_end):
    user.vim_visual_mode("G")

action(edit.select_line):
    user.vim_visual_mode("V")
action(edit.select_all):
    user.vim_normal_mode("ggVG")


# See vim_normal.talon and vim_visual.talon for edit.extend_ commands

action(edit.delete_word):
    user.vim_normal_mode("dw")
action(user.delete_word_right):
    user.vim_normal_mode("dw")
action(user.delete_word_left):
    user.vim_normal_mode("db")
action(user.delete_line_remaining):
    user.vim_normal_mode("d$")
action(user.delete_line_beginning):
    user.vim_normal_mode("d0")


action(edit.indent_more):
    user.vim_normal_mode(">>")
action(edit.indent_less):
    user.vim_normal_mode("<<")
action(edit.delete_line):
    user.vim_normal_mode("dd")
action(edit.delete):
    user.vim_insert_mode_key("backspace")

# note these are for mouse/highlighted copy/paste. shouldn't be used for actual
# vim commands
action(edit.copy):
    key(ctrl-shift-c)
action(edit.paste):
    key(ctrl-shift-v)

action(edit.redo):
    user.vim_normal_mode_key("ctrl-r")
action(edit.undo):
    user.vim_normal_mode_key("u")


