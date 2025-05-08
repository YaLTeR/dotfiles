;; extends

; custom-shader
(node
  (identifier) @_node_name
  (#eq? @_node_name "custom-shader")
  (node_field
    (value
      (string) @normal
      (#match? @normal "^r\".*\"$")
      (#offset! @normal 0 2 0 -1))))

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
          (string_fragment) @string.regexp)))))

; match/exclude regex with raw string
(node
  (identifier) @_node_name
  (#any-of? @_node_name "match" "exclude")
  (node_field
    (prop
      (identifier) @_prop_name
      (#any-of? @_prop_name "app-id" "title")
      (value
        (string) @string.regexp
        (#match? @string.regexp "^r#\".*\"#$")
        (#offset! @string.regexp 0 3 0 -2)))))
