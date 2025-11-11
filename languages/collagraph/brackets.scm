; Bracket matching for Collagraph templates

; HTML/XML element tags
(element
  (start_tag) @open
  (end_tag) @close)

(element
  (start_tag) @open
  (erroneous_end_tag) @close)

; Interpolation
(interpolation) @open
