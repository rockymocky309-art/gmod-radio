-- ╔═══════════════════════════════════════════════════════════════╗
-- ║         GMod Radio - Server-Side Logic                        ║
-- ║              Sync & Network Management                        ║
-- ╚═══════════════════════════════════════════════════════════════╝

RADIO_SERVER = {
    currentTrack = 1,
    isPlaying = false,
    volume = 0.7,
    startTime = 0,
    theme = "dark"
}

-- Network messages
util.AddNetworkString("RADIO_PLAY_TRACK")
util.AddNetworkString("RADIO_NEXT")
util.AddNetworkString("RADIO_PREV")
util.AddNetworkString("RADIO_STOP")
util.AddNetworkString("RADIO_TOGGLE_PLAY")
util.AddNetworkString("RADIO_SET_VOLUME")
util.AddNetworkString("RADIO_SYNC")
util.AddNetworkString("RADIO_CHANGE_THEME")

-- Handle play track
net.Receive("RADIO_PLAY_TRACK", function(len, ply)
    local trackId = net.ReadInt(32)
    
    if trackId >= 1 and trackId <= #RADIO_PLAYLIST then
        RADIO_SERVER.currentTrack = trackId
        RADIO_SERVER.isPlaying = true
        RADIO_SERVER.startTime = CurTime()
        
        -- Sync to all players
        net.Start("RADIO_SYNC")
        net.WriteInt(trackId, 32)
        net.WriteBool(true)
        net.WriteFloat(RADIO_SERVER.volume)
        net.Broadcast()
        
        print("[Radio] Track playing: " .. RADIO_PLAYLIST[trackId].name)
    end
end)

-- Handle next track
net.Receive("RADIO_NEXT", function(len, ply)
    RADIO_SERVER.currentTrack = RADIO_SERVER.currentTrack + 1
    if RADIO_SERVER.currentTrack > #RADIO_PLAYLIST then
        RADIO_SERVER.currentTrack = 1
    end
    
    RADIO_SERVER.isPlaying = true
    RADIO_SERVER.startTime = CurTime()
    
    net.Start("RADIO_SYNC")
    net.WriteInt(RADIO_SERVER.currentTrack, 32)
    net.WriteBool(true)
    net.WriteFloat(RADIO_SERVER.volume)
    net.Broadcast()
end)

-- Handle previous track
net.Receive("RADIO_PREV", function(len, ply)
    RADIO_SERVER.currentTrack = RADIO_SERVER.currentTrack - 1
    if RADIO_SERVER.currentTrack < 1 then
        RADIO_SERVER.currentTrack = #RADIO_PLAYLIST
    end
    
    RADIO_SERVER.isPlaying = true
    RADIO_SERVER.startTime = CurTime()
    
    net.Start("RADIO_SYNC")
    net.WriteInt(RADIO_SERVER.currentTrack, 32)
    net.WriteBool(true)
    net.WriteFloat(RADIO_SERVER.volume)
    net.Broadcast()
end)

-- Handle toggle play
net.Receive("RADIO_TOGGLE_PLAY", function(len, ply)
    RADIO_SERVER.isPlaying = not RADIO_SERVER.isPlaying
    
    net.Start("RADIO_SYNC")
    net.WriteInt(RADIO_SERVER.currentTrack, 32)
    net.WriteBool(RADIO_SERVER.isPlaying)
    net.WriteFloat(RADIO_SERVER.volume)
    net.Broadcast()
end)

-- Handle set volume
net.Receive("RADIO_SET_VOLUME", function(len, ply)
    local vol = net.ReadFloat()
    RADIO_SERVER.volume = math.Clamp(vol, 0, 1)
    
    net.Start("RADIO_SYNC")
    net.WriteInt(RADIO_SERVER.currentTrack, 32)
    net.WriteBool(RADIO_SERVER.isPlaying)
    net.WriteFloat(RADIO_SERVER.volume)
    net.Broadcast()
end)

-- Sync to newly connected players
gameevent.Listen("player_connect")
hook.Add("PlayerInitialSpawn", "RadioSync", function(ply)
    timer.Simple(1, function()
        if not IsValid(ply) then return end
        
        net.Start("RADIO_SYNC")
        net.WriteInt(RADIO_SERVER.currentTrack, 32)
        net.WriteBool(RADIO_SERVER.isPlaying)
        net.WriteFloat(RADIO_SERVER.volume)
        net.Send(ply)
    end)
end)

print("[Radio] ✓ Server-side logic loaded")
