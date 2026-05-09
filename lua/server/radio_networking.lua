-- ╔═══════════════════════════════════════════════════════════════╗
-- ║         GMod Radio - Network Message Handlers                 ║
-- ║              Client-Side Synchronization                      ║
-- ╚═══════════════════════════════════════════════════════════════╝

if CLIENT then
    net.Receive("RADIO_SYNC", function(len)
        local trackId = net.ReadInt(32)
        local isPlaying = net.ReadBool()
        local volume = net.ReadFloat()
        
        if IsValid(g_RadioPanel) then
            g_RadioPanel.currentTrack = trackId
            g_RadioPanel.isPlaying = isPlaying
            g_RadioPanel.volume = volume
            
            -- Update button state
            if g_RadioPanel.btnPlay then
                g_RadioPanel.btnPlay:SetText(isPlaying and "⏹️" or "▶️")
            end
        end
        
        RADIO_STATE.currentTrack = trackId
        RADIO_STATE.isPlaying = isPlaying
        RADIO_STATE.volume = volume
    end)
end

print("[Radio] ✓ Networking handlers loaded")
