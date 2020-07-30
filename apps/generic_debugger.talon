tag: debugger
-

# Code execution
step into: user.debugger_step_into()
step over: user.debugger_step_over()
step out: user.debugger_step_out()
continue: user.debugger_continue()

# these are multi word to avoid accidental utterance
debug stop: user.debugger_stop()
debug detach: user.debugger_detach()
debug restart: user.debugger_restart()

# Register
show registers: user.debugger_show_registers()
get register: user.debugger_get_register()
set register: user.debugger_set_register()

# Breakpoints
break now: user.debugger_break()
(list|show) (breaks|break points): user.debugger_show_breakpoints()
(set|add) (break|break point): user.debugger_add_sw_breakpoint()
(set|add) hardware (break|break point): user.debugger_add_hw_breakpoint()
clear all (breaks|break points): user.debugger_clear_all_breakpoints()
clear (break|break point): user.debugger_clear_breakpoint()
clear (break|break point) <number_small>:
    user.debugger_clear_breakpoint_id(number_small)
disable all (breaks|break points): user.debugger_disable_all_breakpoints()
disable (break|break point): user.debugger_disable_breakpoint()
disable (break|break point) <number_small>:
    user.debugger_disable_breakpoint_id(number_small)
enable all (breaks|break points): user.debugger_enable_all_breakpoints()
enable (break|break point): user.debugger_enable_breakpoint()
enable (break|break point) <number_small>:
    user.debugger_enable_breakpoint_id(number_small)

# Navigation


# Memory Inspection
back trace: user.debugger_backtrace()
jump to address: user.debugger_goto_address()
dump string: user.debugger_dump_string()
