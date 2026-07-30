; GitHub Actions: highlight `script: |` block scalars as JavaScript
; (matches actions/github-script `with.script` values)
; extends
(block_mapping_pair
  key: (flow_node
    (plain_scalar
      (string_scalar) @_key))
  (#eq? @_key "script")
  value: (block_node
    (block_scalar) @injection.content)
  (#set! injection.language "javascript"))
