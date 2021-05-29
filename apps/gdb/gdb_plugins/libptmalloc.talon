tag: user.libptmalloc
-

tag(): user.heap_analysis
action(user.heap_analysis_chunk): "ptchunk "
action(user.heap_analysis_chunk_verbose): "ptchunk -v"
action(user.heap_analysis_chunk_hexdump): "ptchunk -x"
action(user.heap_analysis_chunk_help): "ptchunk -h\n"
action(user.heap_analysis_search): "ptsearch "
action(user.heap_analysis_arena): "ptarena "
action(user.heap_analysis_arena_list): "ptlist "
action(user.heap_analysis_bin):  "ptbin "
action(user.heap_analysis_call_back): "ptcallback "
action(user.heap_analysis_arena_of): "ptarenaof "
action(user.heap_analysis_scan): "ptscanchunks "
action(user.heap_analysis_help): "pthelp\n"

# XXX - eventually these could be replaced with generic heap actions
heck stump <number> chunks: "ptchunk -x -c {number} "
search <number> chunks: "ptchunk -c {number} -s"
# XXX - rename these
fast bins: "ptfast "
tea cache: "pttcache "
free bins: "ptbin "
small bins: "ptbin "
chunk meta: "ptmeta "
chunk config: "ptconfig "
chunk set config: "ptconfig -v "
heap info: "ptparam\n"


p t chunk help: "ptchunk -h\n"
p t list help: "ptlist -h\n"
p t list: "ptlist "
p t list tag trace: "ptlist -M 'tags, backtrace:3' "
p t list save: "ptlist -M 'tags, backtrace:3' --json "
