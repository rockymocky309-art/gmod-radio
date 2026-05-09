-- ╔═══════════════════════════════════════════════════════════════╗
-- ║            GMod Radio - Client Console Commands               ║
-- ║                  Player Control Interface                      ║
-- ╚═══════════════════════════════════════════════════════════════╝

-- Open/Close radio UI
concommand.Add("radio_open", function(ply, cmd, args)
    if not IsValid(g_RadioPanel) then
        g_RadioPanel = vgui.Create("RadioPanel")
    else
        g_RadioPanel:SetVisible(not g_RadioPanel:IsVisible())
    end
    print("[Radio] UI toggled")
end)

-- List all tracks
concommand.Add("radio_list", function(ply, cmd, args)
    print("\n" .. string.rep("=", 50))
    print("🎵 AVAILABLE RADIO TRACKS")
    print(string.rep("=", 50))
    
    for id, track in ipairs(RADIO_PLAYLIST) do
        print(string.format("[%2d] ♫ %s - %s (%d sec)", id, track.name, track.artist, track.duration))
    end
    
    print(string.rep("=", 50) .. "\n")
end)

-- Play specific track
concommand.Add("radio_play", function(ply, cmd, args)
    local trackId = tonumber(args[1])
    
    if not trackId or trackId < 1 or trackId > #RADIO_PLAYLIST then
        print("[Radio] ✗ Invalid track ID")
        print("[Radio] Usage: radio_play [1-" .. #RADIO_PLAYLIST .. "]")
        return
    end
    
    net.Start("RADIO_PLAY_TRACK")
    net.WriteInt(trackId, 32)
    net.SendToServer()
    
    print("[Radio] ✓ Playing: " .. RADIO_PLAYLIST[trackId].name)
end)

-- Play next track
concommand.Add("radio_next", function(ply, cmd, args)
    net.Start("RADIO_NEXT")
    net.SendToServer()
    print("[Radio] ⏭️ Skipping to next track...")
end)

-- Play previous track
concommand.Add("radio_prev", function(ply, cmd, args)
    net.Start("RADIO_PREV")
    net.SendToServer()
    print("[Radio] ⏮️ Previous track...")
end)

-- Stop playback
concommand.Add("radio_stop", function(ply, cmd, args)
    net.Start("RADIO_STOP")
    net.SendToServer()
    print("[Radio] ⏹️ Playback stopped")
end)

-- Toggle play/pause
concommand.Add("radio_toggle", function(ply, cmd, args)
    net.Start("RADIO_TOGGLE_PLAY")
    net.SendToServer()
    print("[Radio] ⏸️ Play/Pause toggled")
end)

-- Set volume (0-100)
concommand.Add("radio_volume", function(ply, cmd, args)
    local volume = tonumber(args[1])
    
    if not volume or volume < 0 or volume > 100 then
        print("[Radio] ✗ Invalid volume value")
        print("[Radio] Usage: radio_volume [0-100]")
        return
    end
    
    net.Start("RADIO_SET_VOLUME")
    net.WriteFloat(volume / 100)
    net.SendToServer()
    
    print("[Radio] 🔊 Volume set to " .. volume .. "%")
end)

-- Change theme
concommand.Add("radio_theme", function(ply, cmd, args)
    local theme = args[1] or "dark"
    local validThemes = {dark = true, neon = true, ocean = true, sunset = true}
    
    if not validThemes[theme] then
        print("[Radio] ✗ Invalid theme")
        print("[Radio] Available themes: dark, neon, ocean, sunset")
        return
    end
    
    if IsValid(g_RadioPanel) then
        g_RadioPanel:ApplyTheme(theme)
    end
    
    print("[Radio] 🎨 Theme changed to: " .. theme)
end)

-- Toggle visualizer
concommand.Add("radio_visualizer", function(ply, cmd, args)
    local state = args[1]
    
    if state == "1" or state == "on" then
        print("[Radio] ✓ Visualizer enabled")
    elseif state == "0" or state == "off" then
        print("[Radio] ✓ Visualizer disabled")
    else
        print("[Radio] Usage: radio_visualizer [0/1]")
    end
end)

-- Show stats
concommand.Add("radio_stats", function(ply, cmd, args)
    print("\n" .. string.rep("=", 40))
    print("📊 RADIO LISTENING STATISTICS")
    print(string.rep("=", 40))
    print("[Radio] Total songs played: N/A")
    print("[Radio] Total listening time: N/A")
    print("[Radio] Current volume: " .. math.Round(RADIO_STATE.volume * 100) .. "%")
    print("[Radio] Current theme: " .. RADIO_STATE.currentTheme)
    print(string.rep("=", 40) .. "\n")
end)

-- Help command
concommand.Add("radio_help", function(ply, cmd, args)
    print("\n" .. string.rep("=", 50))
    print("🎙️ GMOD RADIO PLAYER - COMMANDS")
    print(string.rep("=", 50))
    print("radio_open          - Open/close player UI")
    print("radio_list          - List all available tracks")
    print("radio_play [id]     - Play track by ID")
    print("radio_next          - Skip to next track")
    print("radio_prev          - Play previous track")
    print("radio_stop          - Stop playback")
    print("radio_toggle        - Toggle play/pause")
    print("radio_volume [0-100]- Set volume in percent")
    print("radio_theme [name]  - Change theme")
    print("radio_visualizer[0/1]-Toggle visualizer")
    print("radio_stats         - Show listening stats")
    print(string.rep("=", 50) .. "\n")
end)

print("[Radio] ✓ Client commands loaded")
