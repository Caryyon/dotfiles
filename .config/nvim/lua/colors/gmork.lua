-- Gmork colorscheme for Neovim
-- Inspired by the black wolf from The Neverending Story
-- A matte dark theme emphasizing deep blacks and subtle mystical accents

local M = {}

-- Color palette - Gmork inspired from The NeverEnding Story
-- Bright electric colors for maximum vibrancy and supernatural glow
local colors = {
  -- Deep void blacks and dark tones
  void_black = "#0d0d0d",
  shadow_black = "#1a1a1a",
  charcoal = "#252525",
  dark_gray = "#2f2f2f",
  medium_gray = "#404040",
  light_gray = "#555555",

  -- Mystical greens (supernatural glow like Gmork's eyes)
  gmork_green = "#00ff00",      -- Pure electric green
  eerie_green = "#00ff88",      -- Bright neon green
  bright_green = "#88ff00",     -- Electric lime green
  toxic_green = "#00ff44",      -- Radioactive green

  -- Fiery oranges and reds (blazing supernatural fire)
  fang_orange = "#ff4400",      -- Electric orange
  fire_red = "#ff0000",         -- Pure blazing red
  blood_red = "#ff0044",        -- Electric crimson
  ember_orange = "#ff8800",     -- Molten orange

  -- Mystical browns and earth tones
  dark_brown = "#3d2f2a",
  wolf_brown = "#4a3b35",
  earth_brown = "#5c4a42",

  -- Light tones (supernatural brightness)
  bone_white = "#ffffff",       -- Pure glowing white
  mist_gray = "#dddddd",        -- Brighter mist gray
  pale_green = "#88ff88",       -- Electric pale green

  -- Additional colors for compatibility
  warning_amber = "#ff4400",    -- Same as fang_orange
  wolf_purple = "#88ff00",      -- Same as bright_green

  -- Extended color palette for enhanced syntax highlighting
  mystic_purple = "#ff00ff",    -- Pure electric magenta for special constructs
  shadow_blue = "#0088ff",      -- Electric blue for namespaces/modules
  wolf_cyan = "#00ffff",        -- Electric cyan for attributes
  rust_brown = "#ffaa00",       -- Bright amber for enums/constants
}

-- Apply the colorscheme
function M.setup()
  -- Clear existing highlighting
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  
  -- Set background
  vim.o.background = "dark"
  vim.g.colors_name = "gmork"
  
  -- Helper function
  local function hi(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end
  
  -- Base colors (darker background to match Alacritty)
  hi("Normal", { fg = colors.bone_white, bg = "#000000" })
  hi("NonText", { fg = colors.medium_gray })
  
  -- UI Elements (darker backgrounds to match Alacritty)
  hi("CursorLine", { bg = "#111111" })
  hi("CursorColumn", { bg = "#111111" })
  hi("LineNr", { fg = colors.light_gray })
  hi("CursorLineNr", { fg = colors.mist_gray, bg = "#111111", bold = true })
  hi("SignColumn", { fg = colors.light_gray, bg = "#000000" })
  hi("ColorColumn", { bg = "#111111" })
  
  -- Selection and search
  hi("Visual", { bg = colors.dark_gray })
  hi("Search", { fg = colors.void_black, bg = colors.ember_orange })
  hi("IncSearch", { fg = colors.void_black, bg = colors.bright_green })
  
  -- Splits and statusline (darker backgrounds)
  hi("VertSplit", { fg = colors.dark_gray, bg = "#000000" })
  hi("StatusLine", { fg = colors.bone_white, bg = "#222222" })
  hi("StatusLineNC", { fg = colors.mist_gray, bg = "#111111" })
  
  -- Tabs (darker backgrounds)
  hi("TabLine", { fg = colors.mist_gray, bg = "#111111" })
  hi("TabLineFill", { bg = "#111111" })
  hi("TabLineSel", { fg = colors.bone_white, bg = "#222222", bold = true })
  
  -- Popup menus (darker backgrounds)
  hi("Pmenu", { fg = colors.bone_white, bg = "#222222" })
  hi("PmenuSel", { fg = colors.void_black, bg = colors.bright_green })
  hi("PmenuSbar", { bg = "#333333" })
  hi("PmenuThumb", { bg = colors.medium_gray })
  
  -- Folding (darker backgrounds)
  hi("Folded", { fg = colors.mist_gray, bg = "#111111" })
  hi("FoldColumn", { fg = colors.light_gray, bg = "#000000" })
  
  -- Syntax highlighting
  hi("Comment", { fg = colors.mist_gray, italic = true })
  hi("String", { fg = colors.eerie_green })
  hi("Character", { fg = colors.bright_green })
  hi("Number", { fg = colors.fang_orange })
  hi("Boolean", { fg = colors.toxic_green })
  hi("Float", { fg = colors.fang_orange })
  
  hi("Identifier", { fg = colors.bone_white })
  hi("Function", { fg = colors.bright_green })
  
  hi("Statement", { fg = colors.fire_red, bold = true })
  hi("Conditional", { fg = colors.fire_red })
  hi("Repeat", { fg = colors.fire_red })
  hi("Label", { fg = colors.ember_orange })
  hi("Operator", { fg = colors.mist_gray })
  hi("Keyword", { fg = colors.fire_red })
  hi("Exception", { fg = colors.blood_red })
  
  hi("PreProc", { fg = colors.gmork_green })
  hi("Include", { fg = colors.gmork_green })
  hi("Define", { fg = colors.gmork_green })
  hi("Macro", { fg = colors.gmork_green })
  hi("PreCondit", { fg = colors.gmork_green })
  
  hi("Type", { fg = colors.toxic_green })
  hi("StorageClass", { fg = colors.toxic_green })
  hi("Structure", { fg = colors.toxic_green })
  hi("Typedef", { fg = colors.toxic_green })
  
  hi("Special", { fg = colors.ember_orange })
  hi("SpecialChar", { fg = colors.fang_orange })
  hi("Tag", { fg = colors.ember_orange })
  hi("Delimiter", { fg = colors.mist_gray })
  hi("SpecialComment", { fg = colors.mist_gray, italic = true })
  hi("Debug", { fg = colors.blood_red })
  
  -- Errors and warnings
  hi("Error", { fg = colors.bone_white, bg = colors.blood_red })
  hi("ErrorMsg", { fg = colors.bone_white, bg = colors.blood_red })
  hi("WarningMsg", { fg = colors.void_black, bg = colors.ember_orange })
  
  -- Diff colors
  hi("DiffAdd", { fg = colors.bright_green, bg = "#111111" })
  hi("DiffChange", { fg = colors.ember_orange, bg = "#111111" })
  hi("DiffDelete", { fg = colors.blood_red, bg = "#111111" })
  hi("DiffText", { fg = colors.void_black, bg = colors.ember_orange })
  
  -- Spell checking
  hi("SpellBad", { fg = colors.blood_red, underline = true })
  hi("SpellCap", { fg = colors.ember_orange, underline = true })
  hi("SpellLocal", { fg = colors.gmork_green, underline = true })
  hi("SpellRare", { fg = colors.fire_red, underline = true })
  
  -- Git signs and other plugins
  hi("GitSignsAdd", { fg = colors.bright_green })
  hi("GitSignsChange", { fg = colors.ember_orange })
  hi("GitSignsDelete", { fg = colors.blood_red })
  
  -- LSP and diagnostics
  hi("DiagnosticError", { fg = colors.blood_red })
  hi("DiagnosticWarn", { fg = colors.ember_orange })
  hi("DiagnosticInfo", { fg = colors.gmork_green })
  hi("DiagnosticHint", { fg = colors.mist_gray })
  
  -- Telescope (if used)
  hi("TelescopeBorder", { fg = colors.dark_gray })
  
  -- MDX and Markdown specific enhancements
  hi("markdownH1", { fg = colors.bone_white, bold = true })
  hi("markdownH2", { fg = colors.fire_red, bold = true })
  hi("markdownH3", { fg = colors.bright_green, bold = true })
  hi("markdownH4", { fg = colors.ember_orange, bold = true })
  hi("markdownH5", { fg = colors.toxic_green, bold = true })
  hi("markdownH6", { fg = colors.mist_gray, bold = true })
  
  hi("markdownCode", { fg = colors.fang_orange, bg = "#111111" })
  hi("markdownCodeBlock", { fg = colors.fang_orange, bg = "#111111" })
  hi("markdownCodeDelimiter", { fg = colors.medium_gray })
  
  hi("markdownLink", { fg = colors.gmork_green, underline = true })
  hi("markdownLinkText", { fg = colors.bright_green })
  hi("markdownLinkDelimiter", { fg = colors.medium_gray })
  hi("markdownUrl", { fg = colors.gmork_green })
  
  hi("markdownBold", { fg = colors.bone_white, bold = true })
  hi("markdownItalic", { fg = colors.bone_white, italic = true })
  hi("markdownBoldItalic", { fg = colors.bone_white, bold = true, italic = true })
  
  hi("markdownBlockquote", { fg = colors.mist_gray, italic = true })
  hi("markdownRule", { fg = colors.dark_gray })
  
  hi("markdownListMarker", { fg = colors.fire_red })
  hi("markdownOrderedListMarker", { fg = colors.fire_red })
  
  -- MDX JSX components
  hi("mdxJSX", { fg = colors.bright_green })
  hi("mdxJsxBlock", { fg = colors.bright_green })
  hi("mdxJsxElement", { fg = colors.bright_green })
  hi("mdxComponent", { fg = colors.toxic_green, bold = true })
  hi("mdxImport", { fg = colors.fire_red })
  hi("mdxExport", { fg = colors.fire_red })
  
  -- Tree-sitter MDX highlighting
  hi("@text.literal.markdown", { fg = colors.fang_orange, bg = "#111111" })
  hi("@text.title.markdown", { fg = colors.bone_white, bold = true })
  hi("@text.title.1.markdown", { fg = colors.bone_white, bold = true })
  hi("@text.title.2.markdown", { fg = colors.fire_red, bold = true })
  hi("@text.title.3.markdown", { fg = colors.bright_green, bold = true })
  hi("@text.title.4.markdown", { fg = colors.ember_orange, bold = true })
  hi("@text.title.5.markdown", { fg = colors.toxic_green, bold = true })
  hi("@text.title.6.markdown", { fg = colors.mist_gray, bold = true })
  
  hi("@text.quote.markdown", { fg = colors.mist_gray, italic = true })
  hi("@text.uri.markdown", { fg = colors.gmork_green, underline = true })
  hi("@text.emphasis.markdown", { fg = colors.bone_white, italic = true })
  hi("@text.strong.markdown", { fg = colors.bone_white, bold = true })
  
  -- JSX in MDX
  hi("@tag.tsx", { fg = colors.bright_green })
  hi("@tag.attribute.tsx", { fg = colors.toxic_green })
  hi("@tag.delimiter.tsx", { fg = colors.medium_gray })
  hi("@constructor.tsx", { fg = colors.bright_green, bold = true })
  hi("TelescopeSelection", { bg = colors.dark_gray })
  hi("TelescopeMatching", { fg = colors.fire_red, bold = true })
  
  -- Tree-sitter highlights
  hi("@variable", { fg = colors.bone_white })
  hi("@function", { fg = colors.bright_green })
  hi("@keyword", { fg = colors.fire_red })
  hi("@string", { fg = colors.eerie_green })
  hi("@comment", { fg = colors.mist_gray, italic = true })
  hi("@type", { fg = colors.toxic_green })
  hi("@constant", { fg = colors.fang_orange })
  hi("@number", { fg = colors.fang_orange })
  hi("@operator", { fg = colors.mist_gray })
  
  -- TypeScript/JavaScript specific
  hi("@keyword.import", { fg = colors.fire_red })
  hi("@keyword.export", { fg = colors.fire_red })
  hi("@keyword.function", { fg = colors.fire_red })
  hi("@variable.builtin", { fg = colors.toxic_green })
  hi("@function.builtin", { fg = colors.bright_green })
  hi("@type.builtin", { fg = colors.toxic_green })
  hi("@constructor", { fg = colors.bright_green })
  hi("@parameter", { fg = colors.bone_white })
  hi("@property", { fg = colors.bone_white })
  
  -- React/JSX specific
  hi("@tag", { fg = colors.bright_green })
  hi("@tag.attribute", { fg = colors.toxic_green })
  hi("@tag.delimiter", { fg = colors.medium_gray })
  hi("@tag.builtin", { fg = colors.bright_green })
  
  -- Modern Tree-sitter groups (for newer versions)
  hi("@lsp.type.class", { fg = colors.toxic_green })
  hi("@lsp.type.interface", { fg = colors.toxic_green })
  hi("@lsp.type.type", { fg = colors.toxic_green })
  hi("@lsp.type.function", { fg = colors.bright_green })
  hi("@lsp.type.method", { fg = colors.bright_green })
  hi("@lsp.type.variable", { fg = colors.bone_white })
  hi("@lsp.type.property", { fg = colors.bone_white })
  hi("@lsp.type.parameter", { fg = colors.bone_white })
  hi("@lsp.type.keyword", { fg = colors.fire_red })
  
  -- Nvim-tree (darker background to match)
  hi("NvimTreeNormal", { fg = colors.bone_white, bg = "#000000" })
  hi("NvimTreeFolderIcon", { fg = colors.fire_red })
  hi("NvimTreeFolderName", { fg = colors.bone_white })
  hi("NvimTreeIndentMarker", { fg = colors.dark_gray })
  hi("NvimTreeOpenedFolderName", { fg = colors.bright_green })
  
  -- Which-key (darker background)
  hi("WhichKey", { fg = colors.fire_red })
  hi("WhichKeyGroup", { fg = colors.gmork_green })
  hi("WhichKeyDesc", { fg = colors.bone_white })
  hi("WhichKeySeperator", { fg = colors.mist_gray })
  hi("WhichKeySeparator", { fg = colors.mist_gray })
  hi("WhichKeyFloat", { bg = "#222222" })
  hi("WhichKeyValue", { fg = colors.eerie_green })
  
  -- Enhanced Tree-sitter groups for better syntax definition
  -- Punctuation and delimiters
  hi("@punctuation.delimiter", { fg = colors.mist_gray })
  hi("@punctuation.bracket", { fg = colors.medium_gray })
  hi("@punctuation.special", { fg = colors.ember_orange })
  
  -- Enhanced markup groups
  hi("@markup.heading", { fg = colors.bone_white, bold = true })
  hi("@markup.heading.1", { fg = colors.bone_white, bold = true })
  hi("@markup.heading.2", { fg = colors.fire_red, bold = true })
  hi("@markup.heading.3", { fg = colors.bright_green, bold = true })
  hi("@markup.heading.4", { fg = colors.ember_orange, bold = true })
  hi("@markup.heading.5", { fg = colors.toxic_green, bold = true })
  hi("@markup.heading.6", { fg = colors.mist_gray, bold = true })
  hi("@markup.list", { fg = colors.fire_red })
  hi("@markup.list.checked", { fg = colors.bright_green })
  hi("@markup.list.unchecked", { fg = colors.fire_red })
  hi("@markup.link", { fg = colors.gmork_green, underline = true })
  hi("@markup.link.label", { fg = colors.bright_green })
  hi("@markup.link.url", { fg = colors.gmork_green })
  hi("@markup.raw", { fg = colors.fang_orange })
  hi("@markup.raw.block", { fg = colors.fang_orange, bg = "#111111" })
  hi("@markup.quote", { fg = colors.mist_gray, italic = true })
  hi("@markup.math", { fg = colors.fang_orange })
  hi("@markup.environment", { fg = colors.toxic_green })
  hi("@markup.environment.name", { fg = colors.bright_green })
  hi("@markup.strikethrough", { fg = colors.mist_gray, strikethrough = true })
  hi("@markup.strong", { fg = colors.bone_white, bold = true })
  hi("@markup.italic", { fg = colors.bone_white, italic = true })
  hi("@markup.underline", { fg = colors.bone_white, underline = true })
  
  -- Enhanced attribute groups
  hi("@attribute", { fg = colors.wolf_cyan })
  hi("@attribute.builtin", { fg = colors.toxic_green })
  
  -- Enhanced variable groups
  hi("@variable.member", { fg = colors.bone_white })
  hi("@variable.parameter.builtin", { fg = colors.toxic_green })
  
  -- Enhanced function groups
  hi("@function.method", { fg = colors.bright_green })
  hi("@function.method.call", { fg = colors.bright_green })
  hi("@function.macro", { fg = colors.gmork_green })
  
  -- Enhanced type groups
  hi("@type.qualifier", { fg = colors.fire_red })
  hi("@type.definition", { fg = colors.toxic_green })
  
  -- Namespace and module groups
  hi("@module", { fg = colors.shadow_blue })
  hi("@module.builtin", { fg = colors.toxic_green })
  hi("@namespace", { fg = colors.shadow_blue })
  hi("@namespace.builtin", { fg = colors.toxic_green })
  
  -- Enhanced constant groups
  hi("@constant.builtin", { fg = colors.rust_brown })
  hi("@constant.macro", { fg = colors.rust_brown })
  
  -- Enhanced keyword groups
  hi("@keyword.modifier", { fg = colors.fire_red })
  hi("@keyword.type", { fg = colors.fire_red })
  hi("@keyword.coroutine", { fg = colors.mystic_purple })
  hi("@keyword.debug", { fg = colors.blood_red })
  hi("@keyword.directive", { fg = colors.gmork_green })
  hi("@keyword.directive.define", { fg = colors.gmork_green })
  hi("@keyword.exception", { fg = colors.blood_red })
  
  -- Enhanced string groups
  hi("@string.documentation", { fg = colors.eerie_green, italic = true })
  hi("@string.regexp", { fg = colors.ember_orange })
  hi("@string.escape", { fg = colors.fang_orange })
  hi("@string.special", { fg = colors.fang_orange })
  hi("@string.special.symbol", { fg = colors.fang_orange })
  hi("@string.special.url", { fg = colors.gmork_green, underline = true })
  hi("@string.special.path", { fg = colors.eerie_green })
  
  -- Enhanced comment groups
  hi("@comment.documentation", { fg = colors.mist_gray, italic = true })
  hi("@comment.error", { fg = colors.blood_red, italic = true })
  hi("@comment.warning", { fg = colors.ember_orange, italic = true })
  hi("@comment.todo", { fg = colors.bright_green, italic = true, bold = true })
  hi("@comment.note", { fg = colors.gmork_green, italic = true })
  
  -- Additional LSP semantic tokens
  hi("@lsp.type.namespace", { fg = colors.shadow_blue })
  hi("@lsp.type.enum", { fg = colors.rust_brown })
  hi("@lsp.type.enumMember", { fg = colors.fang_orange })
  hi("@lsp.type.decorator", { fg = colors.wolf_cyan })
  hi("@lsp.type.macro", { fg = colors.gmork_green })
  hi("@lsp.type.generic", { fg = colors.toxic_green })
  hi("@lsp.type.typeParameter", { fg = colors.toxic_green })
  hi("@lsp.type.selfKeyword", { fg = colors.mystic_purple })
  hi("@lsp.type.builtinType", { fg = colors.toxic_green })
  hi("@lsp.mod.declaration", { bold = true })
  hi("@lsp.mod.definition", { bold = true })
  hi("@lsp.mod.readonly", { italic = true })
  hi("@lsp.mod.static", { bold = true })
  hi("@lsp.mod.deprecated", { strikethrough = true })
  
  -- Modern UI elements
  hi("FloatBorder", { fg = colors.dark_gray, bg = "#222222" })
  hi("FloatTitle", { fg = colors.bone_white, bg = "#222222", bold = true })
  hi("WinSeparator", { fg = colors.dark_gray })
  hi("WinBar", { fg = colors.bone_white, bg = "#111111" })
  hi("WinBarNC", { fg = colors.mist_gray, bg = "#111111" })
  
  -- Enhanced Telescope groups
  hi("TelescopeTitle", { fg = colors.bone_white, bold = true })
  hi("TelescopePromptTitle", { fg = colors.fire_red, bold = true })
  hi("TelescopeResultsTitle", { fg = colors.bright_green, bold = true })
  hi("TelescopePreviewTitle", { fg = colors.ember_orange, bold = true })
  hi("TelescopePromptBorder", { fg = colors.fire_red })
  hi("TelescopeResultsBorder", { fg = colors.bright_green })
  hi("TelescopePreviewBorder", { fg = colors.ember_orange })
  hi("TelescopePromptNormal", { fg = colors.bone_white, bg = "#222222" })
  hi("TelescopeResultsNormal", { fg = colors.bone_white, bg = "#111111" })
  hi("TelescopePreviewNormal", { fg = colors.bone_white, bg = "#111111" })
  hi("TelescopeSelectionCaret", { fg = colors.fire_red })
  hi("TelescopeMultiSelection", { fg = colors.bright_green })
  
  -- nvim-cmp completion menu
  hi("CmpItemAbbrDeprecated", { fg = colors.mist_gray, strikethrough = true })
  hi("CmpItemAbbrMatch", { fg = colors.bright_green, bold = true })
  hi("CmpItemAbbrMatchFuzzy", { fg = colors.bright_green })
  hi("CmpItemKindText", { fg = colors.bone_white })
  hi("CmpItemKindMethod", { fg = colors.bright_green })
  hi("CmpItemKindFunction", { fg = colors.bright_green })
  hi("CmpItemKindConstructor", { fg = colors.bright_green })
  hi("CmpItemKindField", { fg = colors.bone_white })
  hi("CmpItemKindVariable", { fg = colors.bone_white })
  hi("CmpItemKindClass", { fg = colors.toxic_green })
  hi("CmpItemKindInterface", { fg = colors.toxic_green })
  hi("CmpItemKindModule", { fg = colors.shadow_blue })
  hi("CmpItemKindProperty", { fg = colors.bone_white })
  hi("CmpItemKindEnum", { fg = colors.rust_brown })
  hi("CmpItemKindKeyword", { fg = colors.fire_red })
  hi("CmpItemKindSnippet", { fg = colors.ember_orange })
  hi("CmpItemKindColor", { fg = colors.fang_orange })
  hi("CmpItemKindFile", { fg = colors.eerie_green })
  hi("CmpItemKindReference", { fg = colors.gmork_green })
  hi("CmpItemKindFolder", { fg = colors.shadow_blue })
  hi("CmpItemKindEnumMember", { fg = colors.fang_orange })
  hi("CmpItemKindConstant", { fg = colors.rust_brown })
  hi("CmpItemKindStruct", { fg = colors.toxic_green })
  hi("CmpItemKindEvent", { fg = colors.ember_orange })
  hi("CmpItemKindOperator", { fg = colors.mist_gray })
  hi("CmpItemKindTypeParameter", { fg = colors.toxic_green })
  
  -- Enhanced NvimTree groups
  hi("NvimTreeRootFolder", { fg = colors.fire_red, bold = true })
  hi("NvimTreeGitDirty", { fg = colors.ember_orange })
  hi("NvimTreeGitNew", { fg = colors.bright_green })
  hi("NvimTreeGitDeleted", { fg = colors.blood_red })
  hi("NvimTreeGitRenamed", { fg = colors.fang_orange })
  hi("NvimTreeGitStaged", { fg = colors.bright_green })
  hi("NvimTreeSpecialFile", { fg = colors.ember_orange, underline = true })
  hi("NvimTreeImageFile", { fg = colors.fang_orange })
  hi("NvimTreeMarkdownFile", { fg = colors.bright_green })
  hi("NvimTreeExecFile", { fg = colors.fire_red, bold = true })
  hi("NvimTreeSymlink", { fg = colors.wolf_cyan, italic = true })
  hi("NvimTreeBookmark", { fg = colors.mystic_purple })
  
  -- Terminal colors for integrated terminal (bright electric colors)
  vim.g.terminal_color_0 = "#111111"      -- black (darker shadow_black)
  vim.g.terminal_color_1 = "#ff0000"      -- red (pure blazing red)
  vim.g.terminal_color_2 = "#00ff00"      -- green (pure electric green)
  vim.g.terminal_color_3 = "#ff4400"      -- yellow (electric orange)
  vim.g.terminal_color_4 = "#0088ff"      -- blue (electric blue)
  vim.g.terminal_color_5 = "#ff00ff"      -- magenta (pure electric magenta)
  vim.g.terminal_color_6 = "#00ffff"      -- cyan (electric cyan)
  vim.g.terminal_color_7 = "#ffffff"      -- white (pure glowing white)
  vim.g.terminal_color_8 = "#404040"      -- bright black (medium_gray)
  vim.g.terminal_color_9 = "#ff0044"      -- bright red (electric crimson)
  vim.g.terminal_color_10 = "#88ff00"     -- bright green (electric lime green)
  vim.g.terminal_color_11 = "#ff8800"     -- bright yellow (molten orange)
  vim.g.terminal_color_12 = "#00ff88"     -- bright blue (bright neon green)
  vim.g.terminal_color_13 = "#ff00ff"     -- bright magenta (pure electric magenta)
  vim.g.terminal_color_14 = "#00ffff"     -- bright cyan (electric cyan)
  vim.g.terminal_color_15 = "#ffffff"     -- bright white (pure glowing white)
  
  -- Bufferline plugin support
  hi("BufferLineFill", { bg = "#111111" })
  hi("BufferLineBackground", { fg = colors.mist_gray, bg = "#111111" })
  hi("BufferLineBufferSelected", { fg = colors.bone_white, bg = "#222222", bold = true })
  hi("BufferLineBufferVisible", { fg = colors.mist_gray, bg = "#111111" })
  hi("BufferLineSeparator", { fg = colors.dark_gray, bg = "#111111" })
  hi("BufferLineSeparatorSelected", { fg = colors.dark_gray, bg = "#222222" })
  hi("BufferLineSeparatorVisible", { fg = colors.dark_gray, bg = "#111111" })
  hi("BufferLineIndicatorSelected", { fg = colors.fire_red, bg = "#222222" })
  hi("BufferLineModified", { fg = colors.ember_orange, bg = "#111111" })
  hi("BufferLineModifiedSelected", { fg = colors.ember_orange, bg = "#222222" })
  hi("BufferLineModifiedVisible", { fg = colors.ember_orange, bg = "#111111" })
end

return M