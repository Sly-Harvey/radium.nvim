local M = {}
local util = require("radium.util")

vim.api.nvim_create_autocmd({ "User" }, {
  pattern = { "SetRadiumTheme" },
  group = vim.api.nvim_create_augroup("SetRadiumTheme", { clear = true }),
  callback = function()
    if vim.fn.has("lualine") then
      require("lualine").setup({ options = { theme = require("radium.lualine") } })
    end
    vim.api.nvim_create_autocmd({ "ColorSchemePre" }, {
      pattern = { "*" },
      once = true,
      callback = function()
        vim.api.nvim_command 'highlight clear'
        if vim.fn.has("lualine") then
          require('lualine').setup({ options = { theme = "auto" } })
        end
      end
    })
  end
})

M.config = {
  transparency = false,
}

local function check_config(config)
  local err
  return not err
end

function M.setup(config)
  if check_config(config) then
    M.config = vim.tbl_deep_extend("force", M.config, config or {})
  else
    vim.notify("radium: Errors found while loading user config. Using default config.", vim.log.levels.ERROR)
  end
end

function M.load()
  local colors = util.get_colors()
  if not colors then
    return
  end

  -- term hls
  util.set_hls()

  -- get hls
  local hls = util.get_hls(M.config.transparency)

  -- actually highlight stuff
  for hl, col in pairs(hls) do
    vim.api.nvim_set_hl(0, hl, col)
  end

  local polish = util.get_polish()
  if polish ~= nil then
    for hl, col in pairs(polish) do
      vim.api.nvim_set_hl(0, hl, col)
    end
  end
  vim.g.colors_name = "radium"
  if vim.fn.has("lualine") then
    require("lualine").setup({ options = { theme = require("radium.lualine") } })
  end
  vim.cmd("doautocmd User SetRadiumTheme")
end

return M
