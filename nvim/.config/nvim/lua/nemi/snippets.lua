local lsnip = require("luasnip").snippet

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

local csharp_tools = require("nemi.csharp-tools")

-- Place this in ${HOME}/.config/nvim/LuaSnip/all.lua
return {
	-- A snippet that expands the trigger "hi" into the string "Hello, world!".
	s({ trig = "cw" }, { t("console.log('"), i(1, "logValue"), t("',"), rep(1), t(");") }),

	s(
		{ trig = "namespace", descr = "Create folder-based namespace and class" },
		fmt(
			[[
        namespace {}
        {{
            {} {} {}
            {{
                {}
            }}
        }}

        ]],
			{
				f(csharp_tools.get_namespace),
				c(1, { t("public"), t("internal") }),
				c(2, { t("class"), t("static class"), t("interface") }),
				f(csharp_tools.get_classname),
				i(0),
			}
		)
	),
	-- To return multiple snippets, use one `return` statement per snippet file
	-- and return a table of Lua snippets.
}
