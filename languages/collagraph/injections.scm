; Inject Python syntax into Collagraph templates

; Inject Python into <script lang="python"> blocks
((script_element
  (start_tag
    (attribute
      (attribute_name) @_lang
      (quoted_attribute_value
        (attribute_value) @_python)))
  (raw_text) @injection.content)
  (#eq? @_lang "lang")
  (#any-of? @_python "python" "py")
  (#set! injection.language "python"))

; Inject Python into <script> blocks without lang attribute (default to Python for Collagraph)
((script_element
  (raw_text) @injection.content)
  (#set! injection.language "python"))

; Inject Python into {{ }} interpolations
((interpolation
  (raw_text) @injection.content)
  (#set! injection.language "python"))

; Inject Python into all directive attributes (v-*, :*, @*, #*)
((directive_attribute
  (quoted_attribute_value
    (attribute_value) @injection.content))
  (#set! injection.language "python"))

; Inject CSS into <style> blocks
((style_element
  (raw_text) @injection.content)
  (#set! injection.language "css"))
