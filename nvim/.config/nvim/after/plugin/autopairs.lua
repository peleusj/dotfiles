local status, autopairs = pcall(require, 'nvim-autopairs')
if (not status) then return end

autopairs.setup({
  disable_filetype = { 'TelescopePrompt', 'vim' },
  enable_check_bracket_line = false,
  ignored_next_char = "[%w%.]",
  check_ts = true,
  ts_config = {
    lua = { 'string' },
    javascript = { 'template_string' },
  }
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')

---@cast cmp -?
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
