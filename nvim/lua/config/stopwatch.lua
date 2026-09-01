-- Minimal on/off stopwatch, shown in the statusline (see plugins/statusline.lua).
-- <leader>us toggles start/pause, <leader>uS resets.
local M = {}

local running = false
local elapsed = 0 -- seconds accumulated across previous start/pause cycles
local started_at = nil -- os.time() when the current run began

function M.toggle()
  if running then
    elapsed = elapsed + (os.time() - started_at)
    running = false
    vim.notify("Stopwatch: paused", vim.log.levels.INFO)
  else
    started_at = os.time()
    running = true
    vim.notify("Stopwatch: started", vim.log.levels.INFO)
  end
end

function M.reset()
  running = false
  elapsed = 0
  started_at = nil
  vim.notify("Stopwatch: reset", vim.log.levels.INFO)
end

-- lualine component: empty (no clutter) until first started
function M.status()
  if not running and elapsed == 0 then
    return ""
  end
  local total = elapsed + (running and (os.time() - started_at) or 0)
  local h = math.floor(total / 3600)
  local m = math.floor((total % 3600) / 60)
  local s = total % 60
  local text = h > 0 and string.format("%d:%02d:%02d", h, m, s) or string.format("%02d:%02d", m, s)
  return (running and "⏱ " or "⏸ ") .. text
end

return M
