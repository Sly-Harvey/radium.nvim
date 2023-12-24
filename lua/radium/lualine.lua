local colors = require("radium.colrs")

local M = {}
local default_b = { bg = colors.one_bg, fg = colors.white }
local default_c = { bg = colors.black2, fg = colors.white }

M.normal = {
    a = { bg = colors.red, fg = colors.black, gui = "bold" },
    b = default_b,
    c = default_c,
    z = { bg = colors.cyan, fg = colors.black, gui = "bold" },
}
M.insert = {
    a = { bg = colors.blue, fg = colors.black, gui = "bold" },
    b = default_b,
    c = default_c,
}
M.visual = {
    a = { bg = colors.dark_purple, fg = colors.black, gui = "bold" },
    b = default_b,
    c = default_c,
}
M.replace = {
    a = { bg = colors.red, fg = colors.black, gui = "bold" },
    b = default_b,
    c = default_c,
}
M.command = {
    a = { bg = colors.green, fg = colors.black, gui = "bold" },
    b = default_b,
    c = default_c,
}
M.inactive = {
    a = { bg = colors.black, fg = colors.gray, gui = "bold" },
    b = { bg = colors.black, fg = colors.gray },
    c = { bg = colors.black, fg = colors.gray },
}

return M
