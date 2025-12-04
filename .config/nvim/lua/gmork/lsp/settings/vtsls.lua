return {
  root_markers = { "package.json" },
  single_file_support = false,
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = { enabled = "all" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
    vtsls = {
      autoUseWorkspaceTsdk = true,
    },
  },
}
