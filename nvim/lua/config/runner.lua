-- Minimal compile-and-run helper for DSA practice (C/C++/Python/Java).
local M = {}

function M.run_file()
  vim.cmd("silent! write")
  local ft = vim.bo.filetype
  local file = vim.fn.expand("%")
  local file_noext = vim.fn.expand("%:p:r")
  local cmd

  if ft == "cpp" then
    cmd = string.format("g++ -std=c++17 -O2 -Wall %s -o %s && %s", file, file_noext, file_noext)
  elseif ft == "c" then
    cmd = string.format("gcc -O2 -Wall %s -o %s && %s", file, file_noext, file_noext)
  elseif ft == "python" then
    cmd = string.format("python3 %s", file)
  elseif ft == "java" then
    cmd = string.format("java %s", file)
  else
    vim.notify("No run command configured for filetype: " .. ft, vim.log.levels.WARN)
    return
  end

  vim.cmd("belowright split | resize 15")
  vim.cmd("terminal " .. cmd)
  vim.cmd("startinsert")
end

return M
