-- ╔═══════════════════════════════════════════════════════════════╗
-- ║         GMod MP3 Radio Player - Initialization                ║
-- ║                 Beautiful Radio for GMod                       ║
-- ╚═══════════════════════════════════════════════════════════════╝

-- Playlist with default tracks (Replace with your own URLs)
RADIO_PLAYLIST = {
    {
        id = 1,
        name = "Neon Dreams",
        artist = "Synthwave Master",
        duration = 245,
        url = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
        thumbnail = "materials/gmod_radio/neon_thumb.png"
    },
    {
        id = 2,
        name = "Digital Horizon",
        artist = "Cyber Waves",
        duration = 198,
        url = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3",
        thumbnail = "materials/gmod_radio/digital_thumb.png"
    },
    {
        id = 3,
        name = "Electric Pulse",
        artist = "Future Sound",
        duration = 276,
        url = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3",
        thumbnail = "materials/gmod_radio/electric_thumb.png"
    },
    {
        id = 4,
        name = "Midnight Echo",
        artist = "Night Vision",
        duration = 212,
        url = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3",
        thumbnail = "materials/gmod_radio/midnight_thumb.png"
    },
    {
        id = 5,
        name = "Chrome City",
        artist = "Urban Pulse",
        duration = 234,
        url = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3",
        thumbnail = "materials/gmod_radio/chrome_thumb.png"
    }
}

-- Radio State Storage
RADIO_STATE = {
    currentTrack = 1,
    isPlaying = false,
    volume = 0.7,
    currentTheme = "dark",
    time = 0,
    playlist = RADIO_PLAYLIST,
    favorites = {},
    history = {},
    stats = {
        totalTime = 0,
        totalPlays = 0
    }
}

-- Load files based on client/server
if SERVER then
    AddCSLuaFile("client/radio_ui.lua")
    AddCSLuaFile("client/radio_themes.lua")
    AddCSLuaFile("client/radio_visualizer.lua")
    AddCSLuaFile("client/radio_effects.lua")
    AddCSLuaFile("client/radio_commands.lua")
    AddCSLuaFile("client/radio_3d_sound.lua")
    
    include("server/radio_config.lua")
    include("server/radio_server.lua")
    include("server/radio_entity.lua")
    include("server/radio_networking.lua")
else
    include("client/radio_ui.lua")
    include("client/radio_themes.lua")
    include("client/radio_visualizer.lua")
    include("client/radio_effects.lua")
    include("client/radio_commands.lua")
    include("client/radio_3d_sound.lua")
end

print("[GMod Radio] ✓ Radio system initialized")
