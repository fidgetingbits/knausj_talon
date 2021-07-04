tag: user.libptmalloc
-

tag(): user.heap_analysis

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
