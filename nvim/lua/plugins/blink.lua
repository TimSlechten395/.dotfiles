return {
  "saghen/blink.cmp",
  opts = function(_, opts)
    opts.sources.cmdline = function()
      local type = vim.fn.getcmdtype()
      -- Search forward and backward
      if type == "/" or type == "?" then
        return { "buffer" }
      end
      -- Commands
      if type == ":" then
        return { "cmdline" }
      end
      return {}
    end
  end,
}
