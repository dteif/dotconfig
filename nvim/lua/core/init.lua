local M = {}

function M.before_setup()
  require("core.editor").before_setup()
  require("core.keymap").before_setup()
end

function M.setup()
  require("core.editor").setup()
  require("core.keymap").setup()
end

return M
