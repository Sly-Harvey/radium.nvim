local M = {}

function M.merge_tbl(tbl1, tbl2)
    return vim.tbl_deep_extend("force", tbl1, tbl2)
end

function M.get_hls(transparent)
    local colors = M.get_colors()
    local highlights = {}
    local integrations = require("integrations")

    if transparent then
        table.insert(integrations, "glassy")
    end

    for _, integration_module in ipairs(integrations) do
        local hls = require("integrations." .. integration_module)(colors)
        highlights = M.merge_tbl(highlights, hls)
    end

    return highlights
end

function M.set_hls()
    local colors = M.get_colors()
    vim.g.terminal_color_0 = "#" .. colors.base00
    vim.g.terminal_color_1 = "#" .. colors.base08
    vim.g.terminal_color_2 = "#" .. colors.base0B
    vim.g.terminal_color_3 = "#" .. colors.base0A
    vim.g.terminal_color_4 = "#" .. colors.base0D
    vim.g.terminal_color_5 = "#" .. colors.base0E
    vim.g.terminal_color_6 = "#" .. colors.base0C
    vim.g.terminal_color_7 = "#" .. colors.base05
    vim.g.terminal_color_8 = "#" .. colors.base03
    vim.g.terminal_color_9 = "#" .. colors.base08
    vim.g.terminal_color_10 = "#" .. colors.base0B
    vim.g.terminal_color_11 = "#" .. colors.base0A
    vim.g.terminal_color_12 = "#" .. colors.base0D
    vim.g.terminal_color_13 = "#" .. colors.base0E
    vim.g.terminal_color_14 = "#" .. colors.base0C
    vim.g.terminal_color_15 = "#" .. colors.base07
end

function M.get_colors()
    local path = "radium.colors"
    local present, theme = pcall(require, path)

    if not present then
        error("`" .. path .. "`" .. " is not an available theme", 2)
        return
    end

    local output = M.merge_tbl(theme.base_16, theme.custom)
    return output
end

function M.get_polish()
    local path = "radium.colors"
    local present, theme = pcall(require, path)

    if not present then
        error("`" .. path .. "`" .. " is not available!", 2)
        return
    end

    return theme.polish_hl
end

function M.get_dir_modules(dir_path)
    local dir_contents = require("plenary.scandir").scan_dir(dir_path, {})

    local modules = {}
    for _, content in ipairs(dir_contents) do
        local module = vim.fn.fnamemodify(vim.fn.fnamemodify(content, ":t"), ":r")
        table.insert(modules, module)
    end

    return modules
end

return M
