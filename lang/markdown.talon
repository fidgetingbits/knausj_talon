mode: command
and tag: user.markdown

mode: command
and code.language: markdown
-

code block:
    insert("```\n\n")
    insert("```\n")
    key(up:2)
state task: "- [ ] "
paste as code: 
    insert("```\n\n")
    insert("```\n")
    key(up:2)
    edit.paste()

link clip:
    user.insert_cursor_paste("[[|]](", ")")

#link selected:
#    edit.cut()
#    key([)
#    user.insert_cursor_paste("[[|]](", ")")
#    edit.paste()


# XXX - turn the word under the cursor into a link
# link this:

