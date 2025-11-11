; Syntax highlighting for Collagraph .cgx files
; Based on Vue grammar with Python-specific adaptations

; Tags
((tag_name) @tag
  (#match? @tag "^[a-z]"))

; Component names (PascalCase)
((tag_name) @type
  (#match? @type "^[A-Z]"))

; Attributes
(attribute) @property

; Directive attributes (v-if, v-for, :prop, @event, etc.)
(directive_attribute) @keyword.directive

; Directive names and arguments
(directive_name) @keyword
(directive_argument) @constant

; Attribute values
(quoted_attribute_value) @string
(attribute_value) @string

; Text interpolation {{ }}
(interpolation) @punctuation.special

; Raw text in interpolations and script blocks
(raw_text) @embedded

; Comments
(comment) @comment

; Punctuation
"<" @punctuation.bracket
">" @punctuation.bracket
"</" @punctuation.bracket
"/>" @punctuation.bracket
"=" @operator

; Special template elements
((tag_name) @keyword
  (#match? @keyword "^(template|slot)$"))
