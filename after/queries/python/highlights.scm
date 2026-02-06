;; Allow overrides:
; extends

;; Function definitions
(function_definition
  name: (identifier) @function)

;; Function calls
(call
  function: (identifier) @function.call)

;; Function parameters
(parameters
  (identifier) @variable.parameter)

;; Global variables (top-level assignments)
(module
  (expression_statement
    (assignment
      left: (identifier) @variable.global))
)

;; Imported names
(import_statement
  name: (dotted_name (identifier) @module.imported))

(import_from_statement
  name: (dotted_name (identifier) @module.imported))
