if vim.g.vscode then
  -- VSCode extension
  -- skip folds (down, up)
  vim.cmd("nmap j gj")
  vim.cmd("nmap k gk")

  -- sync system clipboard
  vim.opt.clipboard = "unnamedplus"

  -- search ignoring case
  vim.opt.ignorecase = true

  -- disable "ignorecase" when search pattern contains upper case characters
  vim.opt.smartcase = true
else
  -- ordinary Neovim
  -- bootstrap lazy.nvim, LazyVim and your plugins
  require("config.lazy")
end
