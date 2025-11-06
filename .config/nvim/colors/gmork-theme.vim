" Gmork Theme - Inspired by the black wolf from The Neverending Story
" A vibrant dark theme with electric neon accents matching the tmux theme
" Author: Claude Code
" Version: 2.0

set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "gmork"

" Color Palette - Gmork inspired with BRIGHT neon colors
" Deep void blacks and charcoal grays
let s:void_black = "#000000"
let s:shadow_black = "#111111"
let s:charcoal = "#222222"
let s:dark_gray = "#2f2f2f"
let s:medium_gray = "#404040"
let s:light_gray = "#555555"

" BRIGHT mystical greens (supernatural glow like Gmork's eyes)
let s:gmork_green = "#00ff00"      " Pure neon green
let s:eerie_green = "#00ff88"      " Cyan-tinted green
let s:bright_green = "#88ff00"     " Lime green
let s:toxic_green = "#00ff44"      " Radioactive green
let s:neon_green = "#39ff14"       " Electric neon
let s:electric_green = "#00ffff"   " Electric cyan
let s:pale_green = "#88ff88"       " Soft bright green

" BRIGHT fiery oranges and reds (blazing supernatural fire)
let s:fang_orange = "#ff4400"      " Blazing orange
let s:fire_red = "#ff0000"         " Pure red
let s:blood_red = "#ff0044"        " Hot pink-red
let s:ember_orange = "#ff8800"     " Bright amber
let s:electric_orange = "#ff6600"  " Electric orange
let s:plasma_red = "#ff3366"       " Plasma pink

" Light tones
let s:bone_white = "#ffffff"       " Pure white
let s:mist_gray = "#dddddd"        " Light gray
let s:ash_gray = "#aaaaaa"         " Medium light gray

" Helper function
function! s:hi(group, guifg, guibg, attr)
  let cmd = "hi " . a:group
  if a:guifg != ""
    let cmd .= " guifg=" . a:guifg
  endif
  if a:guibg != ""
    let cmd .= " guibg=" . a:guibg
  endif
  if a:attr != ""
    let cmd .= " gui=" . a:attr
  endif
  exec cmd
endfunction

" Background and foreground
call s:hi("Normal", s:mist_gray, s:void_black, "")
call s:hi("NonText", s:medium_gray, "", "")

" UI Elements
call s:hi("CursorLine", "", s:shadow_black, "")
call s:hi("CursorColumn", "", s:shadow_black, "")
call s:hi("LineNr", s:light_gray, "", "")
call s:hi("CursorLineNr", s:gmork_green, s:shadow_black, "bold")
call s:hi("SignColumn", s:light_gray, s:void_black, "")
call s:hi("ColorColumn", "", s:shadow_black, "")

" Selection and search
call s:hi("Visual", "", s:dark_gray, "")
call s:hi("Search", s:void_black, s:ember_orange, "bold")
call s:hi("IncSearch", s:void_black, s:neon_green, "bold")

" Splits and statusline
call s:hi("VertSplit", s:dark_gray, s:void_black, "")
call s:hi("StatusLine", s:bone_white, s:charcoal, "")
call s:hi("StatusLineNC", s:ash_gray, s:shadow_black, "")

" Tabs
call s:hi("TabLine", s:ash_gray, s:shadow_black, "")
call s:hi("TabLineFill", "", s:shadow_black, "")
call s:hi("TabLineSel", s:gmork_green, s:charcoal, "bold")

" Popup menus
call s:hi("Pmenu", s:mist_gray, s:charcoal, "")
call s:hi("PmenuSel", s:void_black, s:neon_green, "bold")
call s:hi("PmenuSbar", "", s:dark_gray, "")
call s:hi("PmenuThumb", "", s:bright_green, "")

" Folding
call s:hi("Folded", s:ash_gray, s:shadow_black, "")
call s:hi("FoldColumn", s:light_gray, s:void_black, "")

" Syntax highlighting - BRIGHT AND VIBRANT
call s:hi("Comment", s:ash_gray, "", "italic")
call s:hi("String", s:bright_green, "", "")
call s:hi("Character", s:eerie_green, "", "")
call s:hi("Number", s:electric_green, "", "")
call s:hi("Boolean", s:neon_green, "", "bold")
call s:hi("Float", s:electric_green, "", "")

call s:hi("Identifier", s:bone_white, "", "")
call s:hi("Function", s:fang_orange, "", "bold")

call s:hi("Statement", s:fire_red, "", "bold")
call s:hi("Conditional", s:plasma_red, "", "bold")
call s:hi("Repeat", s:plasma_red, "", "bold")
call s:hi("Label", s:electric_orange, "", "")
call s:hi("Operator", s:ember_orange, "", "")
call s:hi("Keyword", s:fire_red, "", "bold")
call s:hi("Exception", s:blood_red, "", "bold")

call s:hi("PreProc", s:electric_orange, "", "")
call s:hi("Include", s:fang_orange, "", "bold")
call s:hi("Define", s:electric_orange, "", "")
call s:hi("Macro", s:ember_orange, "", "")
call s:hi("PreCondit", s:electric_orange, "", "")

call s:hi("Type", s:toxic_green, "", "bold")
call s:hi("StorageClass", s:neon_green, "", "bold")
call s:hi("Structure", s:gmork_green, "", "bold")
call s:hi("Typedef", s:eerie_green, "", "bold")

call s:hi("Special", s:ember_orange, "", "bold")
call s:hi("SpecialChar", s:electric_orange, "", "bold")
call s:hi("Tag", s:fang_orange, "", "")
call s:hi("Delimiter", s:ash_gray, "", "")
call s:hi("SpecialComment", s:pale_green, "", "italic")
call s:hi("Debug", s:blood_red, "", "bold")

" Errors and warnings
call s:hi("Error", s:bone_white, s:fire_red, "bold")
call s:hi("ErrorMsg", s:bone_white, s:fire_red, "bold")
call s:hi("WarningMsg", s:void_black, s:ember_orange, "bold")

" Diff colors
call s:hi("DiffAdd", s:gmork_green, s:shadow_black, "")
call s:hi("DiffChange", s:ember_orange, s:shadow_black, "")
call s:hi("DiffDelete", s:fire_red, s:shadow_black, "")
call s:hi("DiffText", s:void_black, s:ember_orange, "bold")

" Spell checking
call s:hi("SpellBad", s:fire_red, "", "underline")
call s:hi("SpellCap", s:ember_orange, "", "underline")
call s:hi("SpellLocal", s:electric_green, "", "underline")
call s:hi("SpellRare", s:plasma_red, "", "underline")

" Git signs and other plugins
call s:hi("GitSignsAdd", s:gmork_green, "", "")
call s:hi("GitSignsChange", s:ember_orange, "", "")
call s:hi("GitSignsDelete", s:fire_red, "", "")

" LSP and diagnostics
call s:hi("DiagnosticError", s:fire_red, "", "bold")
call s:hi("DiagnosticWarn", s:ember_orange, "", "bold")
call s:hi("DiagnosticInfo", s:electric_green, "", "")
call s:hi("DiagnosticHint", s:ash_gray, "", "")

" Telescope (if used)
call s:hi("TelescopeBorder", s:dark_gray, "", "")
call s:hi("TelescopeSelection", "", s:dark_gray, "")
call s:hi("TelescopeMatching", s:neon_green, "", "bold")

" Tree-sitter highlights - BRIGHT COLORS
call s:hi("@variable", s:bone_white, "", "")
call s:hi("@variable.builtin", s:toxic_green, "", "bold")
call s:hi("@function", s:fang_orange, "", "bold")
call s:hi("@function.builtin", s:electric_orange, "", "bold")
call s:hi("@function.call", s:fang_orange, "", "")
call s:hi("@method", s:ember_orange, "", "")
call s:hi("@method.call", s:ember_orange, "", "")
call s:hi("@keyword", s:fire_red, "", "bold")
call s:hi("@keyword.function", s:plasma_red, "", "bold")
call s:hi("@keyword.return", s:blood_red, "", "bold")
call s:hi("@string", s:bright_green, "", "")
call s:hi("@string.regex", s:toxic_green, "", "")
call s:hi("@string.escape", s:eerie_green, "", "bold")
call s:hi("@comment", s:ash_gray, "", "italic")
call s:hi("@type", s:toxic_green, "", "bold")
call s:hi("@type.builtin", s:gmork_green, "", "bold")
call s:hi("@constant", s:electric_green, "", "bold")
call s:hi("@constant.builtin", s:neon_green, "", "bold")
call s:hi("@number", s:electric_green, "", "")
call s:hi("@boolean", s:neon_green, "", "bold")
call s:hi("@operator", s:ember_orange, "", "")
call s:hi("@punctuation", s:ash_gray, "", "")
call s:hi("@punctuation.bracket", s:mist_gray, "", "")
call s:hi("@punctuation.delimiter", s:ash_gray, "", "")
call s:hi("@tag", s:fire_red, "", "bold")
call s:hi("@tag.attribute", s:fang_orange, "", "")
call s:hi("@tag.delimiter", s:ash_gray, "", "")
call s:hi("@text.strong", "", "", "bold")
call s:hi("@text.emphasis", "", "", "italic")
call s:hi("@text.title", s:fire_red, "", "bold")
call s:hi("@text.uri", s:electric_green, "", "underline")

" NvimTree highlights with bright colors
call s:hi("NvimTreeFolderIcon", s:gmork_green, "", "")
call s:hi("NvimTreeFolderName", s:mist_gray, "", "")
call s:hi("NvimTreeRootFolder", s:fire_red, "", "bold")
call s:hi("NvimTreeOpenedFolderName", s:bright_green, "", "bold")
call s:hi("NvimTreeExecFile", s:electric_orange, "", "")
call s:hi("NvimTreeSpecialFile", s:ember_orange, "", "bold")
call s:hi("NvimTreeImageFile", s:toxic_green, "", "")
call s:hi("NvimTreeGitDirty", s:ember_orange, "", "")
call s:hi("NvimTreeGitStaged", s:gmork_green, "", "")
call s:hi("NvimTreeGitMerge", s:plasma_red, "", "")
call s:hi("NvimTreeGitRenamed", s:electric_orange, "", "")
call s:hi("NvimTreeGitNew", s:bright_green, "", "")
call s:hi("NvimTreeGitDeleted", s:fire_red, "", "")

" Additional UI enhancements
call s:hi("MatchParen", s:void_black, s:neon_green, "bold")
call s:hi("WildMenu", s:void_black, s:gmork_green, "bold")
call s:hi("Title", s:fire_red, "", "bold")
call s:hi("Todo", s:void_black, s:ember_orange, "bold")
call s:hi("Question", s:bright_green, "", "bold")
call s:hi("MoreMsg", s:gmork_green, "", "bold")
call s:hi("Directory", s:electric_green, "", "bold")