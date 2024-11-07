local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

local csharp_tools = require("nemi.csharp-tools")

-- Define your snippets
local csSnippet = {
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
}
ls.add_snippets("cs", csSnippet)

local jsSnippet = {
	s({ trig = "cw" }, { t("console.log('"), i(1, "logValue"), t("',"), i(1), t(");") }),
}
ls.add_snippets("js", jsSnippet)

local mdSnippet = {
	s("todo", {
		t("<!-- TODO: "),
		i(1),
		t(" -->"),
	}),
}
ls.add_snippets("md", mdSnippet)
ls.add_snippets("pandoc", mdSnippet)
