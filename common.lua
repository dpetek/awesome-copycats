local awful = require("awful")
local lain  = require("lain")

function clean(string)
    s = string.gsub(string, '^%s+', '')
    s = string.gsub(s, '%s+$', '')
    s = string.gsub(s, '[\n\r]+', ' ')
    return s
end

function file_exists(file)
    local cmd = "/bin/bash -c 'if [ -e " .. file .. " ]; then echo true; fi;'"
    local fh = io.popen(cmd)

    s = clean(fh:read('*a'))

    if s == 'true' then return true else return nil end
end

function require_safe(lib)
    if file_exists(awful.util.getdir("config") .. '/' .. lib ..'.lua') or
        file_exists(awful.util.getdir("config") .. '/' .. lib) then
            require(lib)
    end
end

layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.fair,
    awful.layout.suit.tile,
    lain.layout.uselessfair.horizontal,
    lain.layout.uselesstile,
    lain.layout.uselessfair,
    lain.layout.termfair,
    lain.layout.uselesspiral.dwindle
}

-- common
modkey     = "Mod4"
altkey     = "Mod1"
terminal   = "xterm"
editor     = os.getenv("EDITOR") or "nano" or "vi"
editor_cmd = terminal .. " -e " .. editor
