;; extends

; custom-shader
(node
  (identifier) @_node_name
  (#eq? @_node_name "custom-shader")
  (node_field
    (value
      (string) @injection.content
      (#match? @injection.content "^r\".*\"$")
      (#offset! @injection.content 0 2 0 -1)
      (#set! injection.language "glsl"))))

; match/exclude regex with regular string
(node
  (identifier) @_node_name
  (#any-of? @_node_name "match" "exclude")
  (node_field
    (prop
      (identifier) @_prop_name
      (#any-of? @_prop_name "app-id" "title")
      (value
        (string
          (string_fragment) @injection.content
          (#set! injection.language "regex"))))))

; match/exclude regex with raw string
(node
  (identifier) @_node_name
  (#any-of? @_node_name "match" "exclude")
  (node_field
    (prop
      (identifier) @_prop_name
      (#any-of? @_prop_name "app-id" "title")
      (value
        (string) @injection.content
        (#match? @injection.content "^r#\".*\"#$")
        (#offset! @injection.content 0 3 0 -2)
        (#set! injection.language "regex")))))
