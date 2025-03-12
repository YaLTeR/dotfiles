set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "alacritty"

" cterm colors

let s:cterm000 = "0"
let s:cterm001 = "1"
let s:cterm002 = "2"
let s:cterm003 = "3"
let s:cterm004 = "4"
let s:cterm005 = "5"
let s:cterm006 = "6"
let s:cterm007 = "7"
let s:cterm008 = "8"
let s:cterm009 = "9"
let s:cterm010 = "10"
let s:cterm011 = "11"
let s:cterm012 = "12"
let s:cterm013 = "13"
let s:cterm014 = "14"
let s:cterm015 = "15"
let s:cterm022 = "22"
let s:cterm023 = "23"
let s:cterm024 = "24"
let s:cterm052 = "52"
let s:cterm087 = "87"
let s:cterm166 = "166"
let s:cterm236 = "236"
let s:cterm237 = "237"

" gui colors

let s:gui000 = "#181818"
let s:gui001 = "#AC4242"
let s:gui002 = "#90A959"
let s:gui003 = "#F4BF75"
let s:gui004 = "#6A9FB5"
let s:gui005 = "#AA759F"
let s:gui006 = "#75B5AA"
let s:gui007 = "#b8b8b8"
let s:gui008 = "#6b6b6b"
let s:gui009 = "#c55555"
let s:gui010 = "#aac474"
let s:gui011 = "#feca88"
let s:gui012 = "#82b8c8"
let s:gui013 = "#c28cb8"
let s:gui014 = "#93d3c3"
let s:gui015 = "#f8f8f8"
let s:gui022 = "#052200"
let s:gui023 = "#0e3337"
let s:gui024 = "#405963"
let s:gui052 = "#442220"
let s:gui087 = "#8F5536"
let s:gui166 = "#d28445"
let s:gui236 = "#262626"
let s:gui237 = "#333333"

fun! s:H(group, ctermfg, ctermbg, guifg, guibg, guisp, attr)
  let l:hl = "hi! ".a:group

  let l:cfg = a:ctermfg
  if empty(a:ctermfg)
    let l:cfg = "none"
  endif
  let l:cfg=" ctermfg=".l:cfg

  let l:cbg = a:ctermbg
  if empty(a:ctermbg)
    let l:cbg = "none"
  endif
  let l:cbg=" ctermbg=".l:cbg

  let l:gfg = a:guifg
  if empty(a:guifg)
    let l:gfg = "none"
  endif
  let l:gfg=" guifg=".l:gfg

  let l:gbg = a:guibg
  if empty(a:guibg)
    let l:gbg = "none"
  endif
  let l:gbg=" guibg=".l:gbg

  let l:gsp = a:guisp
  if empty(a:guisp)
    let l:gsp = "none"
  endif
  let l:gsp = " guisp=".l:gsp

  let l:cmd_attr = ""
  if !empty(a:attr)
    let l:cmd_attr = " cterm=".a:attr." gui=".a:attr
  endif

  let l:cmd = l:hl.l:cfg.l:cbg.l:gfg.l:gbg.l:gsp.l:cmd_attr
  exec l:cmd
endfun

" Vim colors

call s:H("Normal",       "",         "",         s:gui007, "",       "", "")
call s:H("Bold",         "",         "",         "",       "",       "", "bold")
call s:H("Debug",        s:cterm002, "",         s:gui002, "",       "", "")
call s:H("Directory",    s:cterm004, "",         s:gui004, "",       "", "bold")
call s:H("EndOfBuffer",  s:cterm000, "",         s:gui000, "",       "", "")
call s:H("Error",        "",         s:cterm001, "",       s:gui001, "", "")
call s:H("ErrorMsg",     s:cterm001, "",         s:gui001, "",       "", "")
call s:H("Exception",    s:cterm001, "",         s:gui001, "",       "", "")
call s:H("FoldColumn",   s:cterm006, s:cterm236, s:gui006, s:gui236, "", "")
call s:H("Folded",       s:cterm008, s:cterm236, s:gui008, s:gui236, "", "italic")
call s:H("IncSearch",    s:cterm003, s:cterm000, s:gui003, s:gui000, "", "")
call s:H("Italic",       "",         "",         "",       "",       "", "italic")
call s:H("Macro",        s:cterm001, "",         s:gui001, "",       "", "")
call s:H("MatchParen",   s:cterm004, "",         s:gui004, "",       "", "underline")
call s:H("ModeMsg",      s:cterm002, "",         s:gui002, "",       "", "")
call s:H("MoreMsg",      s:cterm002, "",         s:gui002, "",       "", "")
call s:H("Question",     s:cterm004, "",         s:gui004, "",       "", "")
call s:H("Search",       s:cterm000, s:cterm001, s:gui000, s:gui001, "", "")
call s:H("Substitue",    s:cterm236, s:cterm003, s:gui236, s:gui003, "", "")
call s:H("SpecialKey",   s:cterm008, "",         s:gui008, "",       "", "")
call s:H("TooLong",      s:cterm001, "",         s:gui001, "",       "", "")
call s:H("Underlined",   s:cterm006, "",         s:gui006, "",       "", "underline")
call s:H("Visual",       "",         s:cterm237, "",       s:gui237, "", "")
call s:H("VisualNOS",    s:cterm001, "",         s:gui001, "",       "", "")
call s:H("Warning",      "",         s:cterm003, "",       s:gui003, "", "")
call s:H("WarningMsg",   s:cterm003, "",         s:gui003, "",       "", "")
call s:H("WildMenu",     s:cterm001, "",         s:gui001, "",       "", "none")
call s:H("Title",        s:cterm002, "",         s:gui002, "",       "", "bold")
call s:H("NonText",      s:cterm008, "",         s:gui008, "",       "", "")
call s:H("LineNr",       s:cterm008, "",         s:gui008, "",       "", "none")
call s:H("SignColumn",   s:cterm008, s:cterm236, s:gui008, s:gui236, "", "none")
call s:H("StatusLine",   s:cterm236, s:cterm008, s:gui236, s:gui008, "", "")
call s:H("StatusLineNC", s:cterm236, s:cterm008, s:gui236, s:gui008, "", "")
call s:H("VertSplit",    s:cterm236, s:cterm236, s:gui236, s:gui236, "", "none")
call s:H("ColorColumn",  "",         s:cterm236, "",       s:gui236, "", "none")
call s:H("Conceal",      "",         "",         s:gui007, "",       "", "none")
call s:H("CursorColumn", "",         s:cterm236, "",       s:gui236, "", "none")
call s:H("CursorLine",   "",         s:cterm236, "",       s:gui236, "", "none")
call s:H("CursorLineNr", s:cterm015, s:cterm236, s:gui015, s:gui236, "", "bold")
call s:H("QuickFixLine", "",         s:cterm236, "",       s:gui236, "", "none")
call s:H("Pmenu",        "",         s:cterm236, "",       s:gui236, "", "none")
call s:H("PmenuSel",     s:cterm000, s:cterm007, s:gui000, s:gui007, "", "")
call s:H("TabLine",      s:cterm008, s:cterm236, s:gui008, s:gui236, "", "none")
call s:H("TabLineFill",  s:cterm008, s:cterm236, s:gui008, s:gui236, "", "none")
call s:H("TabLineSel",   s:cterm002, s:cterm236, s:gui002, s:gui236, "", "none")
call s:H("Whitespace",   s:cterm237, "",         s:gui237, "",       "", "nocombine")

" Syntax highlighting

call s:H("Boolean",      s:cterm166, "", s:gui166, "", "", "")
call s:H("Character",    s:cterm166, "", s:gui166, "", "", "")
call s:H("Comment",      s:cterm008, "", s:gui008, "", "", "italic")
call s:H("Conditional",  s:cterm005, "", s:gui005, "", "", "")
call s:H("Constant",     s:cterm166, "", s:gui166, "", "", "")
call s:H("Define",       s:cterm005, "", s:gui005, "", "", "none")
call s:H("Delimiter",    s:cterm087, "", s:gui087, "", "", "")
call s:H("Float",        s:cterm166, "", s:gui166, "", "", "")
call s:H("Function",     s:cterm004, "", s:gui004, "", "", "")
call s:H("Identifier",   s:cterm003, "", s:gui003, "", "", "none")
call s:H("Include",      s:cterm004, "", s:gui004, "", "", "")
call s:H("Keyword",      s:cterm005, "", s:gui005, "", "", "")
call s:H("Label",        s:cterm003, "", s:gui003, "", "", "")
call s:H("Number",       s:cterm166, "", s:gui166, "", "", "")
call s:H("Operator",     s:cterm007, "", s:gui007, "", "", "none")
call s:H("PreProc",      s:cterm003, "", s:gui003, "", "", "")
call s:H("Repeat",       s:cterm005, "", s:gui005, "", "", "")
call s:H("Special",      s:cterm006, "", s:gui006, "", "", "")
call s:H("SpecialChar",  s:cterm087, "", s:gui087, "", "", "")
call s:H("Statement",    s:cterm001, "", s:gui001, "", "", "bold")
call s:H("StorageClass", s:cterm003, "", s:gui003, "", "", "")
call s:H("String",       s:cterm002, "", s:gui002, "", "", "")
call s:H("Structure",    s:cterm003, "", s:gui005, "", "", "")
call s:H("Tag",          s:cterm003, "", s:gui003, "", "", "")
call s:H("Todo",         s:cterm009, "", s:gui009, "", "", "bold")
call s:H("Type",         s:cterm003, "", s:gui003, "", "", "none")
call s:H("Typedef",      s:cterm003, "", s:gui003, "", "", "")
call s:H("Variable",     s:cterm007, "", s:gui007, "", "", "")
call s:H("Punctuation",  s:cterm007, "", s:gui007, "", "", "")

" Diff highlighting

call s:H("DiffAdd",    "", s:cterm022, "", s:gui022, "", "")
call s:H("DiffDelete", "", s:cterm052, "", s:gui052, "", "")
call s:H("DiffChange", "", s:cterm023, "", s:gui023, "", "")
call s:H("DiffText",   "", s:cterm024, "", s:gui024, "", "")

" Git gutter

call s:H("GitGutterAdd",    s:cterm010, s:cterm236, s:gui010, s:gui236, "", "")
call s:H("GitGutterDelete", s:cterm009, s:cterm236, s:gui009, s:gui236, "", "")
call s:H("GitGutterChange", s:cterm011, s:cterm236, s:gui011, s:gui236, "", "")

" Vim highlighting


hi! link vimOper Normal

hi! link diffRemoved Constant
hi! link diffAdded String

" Spell Checking highlighting

call s:H("SpellBad",   "", "", "", "", s:gui001, "undercurl")
call s:H("SpellCap",   "", "", "", "", s:gui003, "undercurl")
call s:H("SpellRare",  "", "", "", "", s:gui004, "undercurl")
call s:H("SpellLocal", "", "", "", "", s:gui005, "undercurl")


" Lsp highlights

call s:H("DiagnosticSignError",  s:cterm001, s:cterm236, s:gui001, s:gui236, "", "")
call s:H("DiagnosticSignWarn",   s:cterm003, s:cterm236, s:gui003, s:gui236, "", "")
call s:H("DiagnosticSignInfo",   s:cterm004, s:cterm236, s:gui012, s:gui236, "", "")
call s:H("DiagnosticSignHint",   s:cterm007, s:cterm236, s:gui013, s:gui236, "", "")

call s:H("DiagnosticFloatError", s:cterm001, s:cterm236, s:gui001, s:gui236, "", "")
call s:H("DiagnosticFloatWarn",  s:cterm003, s:cterm236, s:gui011, s:gui236, "", "")
call s:H("DiagnosticFloatInfo",  s:cterm004, s:cterm236, s:gui004, s:gui236, "", "")
call s:H("DiagnosticFloatHint",  s:cterm005, s:cterm236, s:gui007, s:gui236, "", "")

call s:H("DiagnosticUnderlineError", "", "", "", "", s:gui001, "undercurl")
call s:H("DiagnosticUnderlineWarn",  "", "", "", "", s:gui003, "undercurl")
call s:H("DiagnosticUnderlineInfo",  "", "", "", "", s:gui004, "undercurl")
call s:H("DiagnosticUnderlineHint",  "", "", "", "", s:gui005, "undercurl")

hi! link @lsp.mod.constant Number
hi! link @lsp.type.comment None
hi! link @lsp.type.enumMember Function
hi! link @lsp.type.keyword Keyword
hi! link @lsp.type.lifetime Macro
hi! link @lsp.type.namespace Include
hi! link @lsp.type.namespace Include
hi! link @lsp.type.operator Function
hi! link @lsp.type.parameter Variable
hi! link @lsp.type.builtinType Type
hi! link @lsp.type.property Variable
hi! link @lsp.type.boolean Number
hi! link @lsp.type.number Number
hi! link @lsp.type.typeAlias Type
hi! link @lsp.type.character Number
hi! link @lsp.type.string String
hi! link @lsp.type.selfKeyword Keyword
hi! link @lsp.type.selfTypeKeyword Type
hi! link @lsp.type.variable Variable
call s:H("@lsp.typemod.comment.documentation", s:cterm010, "", s:gui010, "", "", "")
hi! link @lsp.typemod.property.declaration None

" Treesitter

hi! link @punctuation Punctuation
hi! link @variable @lsp.type.variable
hi! link @property @lsp.type.property

" scdoc

call s:H("scdocHeader",    s:cterm004, "",  s:gui004, "", "", "bold")
call s:H("scdocLineBreak", s:cterm001, "",  s:gui001, "", "", "bold")
call s:H("scdocBold",      s:cterm004, "",  s:gui004, "", "", "")
call s:H("scdocUnderline", s:cterm002, "",  s:gui002, "", "", "")

" TOML key

call s:H("tomlKey", s:cterm001, "", s:gui001, "", "", "")
hi! link @property.toml tomlKey

" Markdown

call s:H("markdownH1Delimiter", s:cterm004, "", s:gui004, "", "", "bold")
call s:H("markdownH2Delimiter", s:cterm004, "", s:gui004, "", "", "bold")
call s:H("markdownH3Delimiter", s:cterm004, "", s:gui004, "", "", "bold")
call s:H("markdownH4Delimiter", s:cterm004, "", s:gui004, "", "", "bold")
call s:H("markdownCodeDelimiter", s:cterm003, "", s:gui003, "", "", "")

" Rust highlighting

hi! link rustCommentLineDoc @lsp.typemod.comment.documentation
hi! link rustSelf Keyword
hi! link rustStorage Keyword
hi! link rustLifetime Macro
hi! link rustEnumVariant Function
hi! link rustOperator Function
hi! link rustModPath None
hi! link rustSigil None
hi! link rustModPathSep None
hi! link rustInvalidBareKeyword None

" Python highlighting

hi! link pythonOperator Statement

" C highlighting

hi! link cType Statement
hi! link cFormat Identifier
hi! link cOperator Constant

" CPP highlighting

hi! link cppSTLnamespace Identifier

" Lua highlighting

hi! link luaOperator Conditional
hi! link luaFunc Function

" Objective-C/Coco highlightinga

hi! link objcClass Type
hi! link cocoaClass objcClass
hi! link objcSubclass objcClass
hi! link objcSuperclass objcClass
hi! link objcDirective rubyClass
hi! link objcStatement Constant
hi! link cocoaFunction Function
hi! link objcMethodName Identifier
hi! link objcMethodArg Normal
hi! link objcMessageName Identifier

" XML highlighting

hi! link xmlTag Statement
hi! link xmlEndTag xmlTag
hi! link xmlTagName xmlTag
hi! link xmlEqual xmlTag
hi! link xmlEntity Special
hi! link xmlEntityPunct xmlEntity
hi! link xmlDocTypeDecl PreProc
hi! link xmlDocTypeKeyword PreProc
hi! link xmlProcessingDelim xmlAttrib

" Delete functions

delf s:H

unlet s:cterm000 s:cterm001 s:cterm002 s:cterm003 s:cterm004 s:cterm005 s:cterm006 s:cterm007 s:cterm008 s:cterm009 s:cterm010 s:cterm011 s:cterm012 s:cterm013 s:cterm014 s:cterm015 s:cterm022 s:cterm023 s:cterm024 s:cterm052 s:cterm087 s:cterm166 s:cterm236
unlet s:gui000 s:gui001 s:gui002 s:gui003 s:gui004 s:gui005 s:gui006 s:gui007 s:gui008 s:gui009 s:gui010 s:gui011 s:gui012 s:gui013 s:gui014 s:gui015 s:gui022 s:gui023 s:gui024 s:gui052 s:gui087 s:gui166 s:gui236
