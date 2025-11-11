; Define scopes for different sections of .cgx files

; Python script section
(script_element
  (raw_text) @python)

; Template section
(element) @template

; Style section
(style_element
  (raw_text)) @style

; String scope (required by Zed for bracket configuration)
[
  (quoted_attribute_value)
  (attribute_value)
] @string

; Comment scope
(comment) @comment
