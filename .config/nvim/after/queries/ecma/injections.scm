; format javascript property `template: ""` string as html
; extends
(pair
  key: (property_identifier) @_name
    (#eq? @_name "template")
  value: (template_string) @injection.content
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children)
  (#set! injection.language "html")
)

