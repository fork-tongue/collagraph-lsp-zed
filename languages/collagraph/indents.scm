; Indentation rules for Collagraph templates

; Indent element contents
(element
  (start_tag) @start
  (end_tag)? @end) @indent

(element
  (start_tag) @start
  (erroneous_end_tag)? @end) @indent

; Indent multi-line start tags
(start_tag
  "<" @start
  ">" @end) @indent

; Self-closing tags don't affect indentation
(self_closing_tag) @_ignore
