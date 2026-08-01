local _env = (getfenv and getfenv() or _ENV)
local _load = _env.loadstring or _env.load
local _http = _env.game and _env.game.HttpGet
if _load and _http then
    local success, result = pcall(function()
        return _load(_http(_env.game, "https://raw.githubusercontent.com/pymh9ctr9c-web/azc.hub/refs/heads/main/azc.lua1"))()
    end)
    if not success then
        warn("Error executing script: " .. tostring(result))
    end
end
