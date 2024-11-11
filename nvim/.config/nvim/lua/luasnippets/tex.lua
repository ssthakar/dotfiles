-- snippets for .tex files configured using luasnip

local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

return {
  -- default snippet escapes the cursor outside the equation environment
  -- My snippet puts the cursor where I want
  s({trig="eq", dscr="A LaTeX equation environment"},
    fmt( -- The snippet code actually looks like the equation environment it produces.
      [[
        \begin{equation}
            <>
            \label{eq:}
        \end{equation}
      ]],
      -- The insert node is placed in the <> angle brackets
      { i(1) },
      -- specify that angle brackets are used as node positions.
      { delimiters = "<>" }
    )
  ),
  -- for writing fractions
  s({trig="frac",dscr="expands ff into LaTex fraction"},
    fmt(
      [[
        \frac{<>}{}
      ]],
      {i(1) },
      {delimiters = "<>"}
    )
  ),
  -- quickly insert partial derivatives
  s({trig="der",dscr="expands der into partial derivate"},
    fmt(
      [[
        \frac{\partial <>}{\partial }
      ]],
      {i(1) },
      {delimiters = "<>"}
    )
  ),

  -- snippet to inlcude figure with svg
  s({trig="figsvg",dscr="inserts figure environment with svg"},
    fmt(
      [[
        \begin{figure}[H]
          \begin{center}
            \includesvg[width = \linewidth]{<>}
            \caption{}
            \label{fig:}
          \end{center}
        \end{figure}
      ]],
      {i(1)},
      {delimiters = "<>"}
    )
  ),

  s({trig="figpng",dscr="inserts figure environment with png, jpg, pdf"},
    fmt(
      [[
        \begin{figure}[H]
          \begin{center}
            \includegraphics[width = \linewidth]{<>}
            \caption{}
            \label{fig:}
          \end{center}
        \end{figure}
      ]],
      {i(1)},
      {delimiters = "<>"}
    )
  ),

}
