-- ╔═══════════════════════════════════════════════════════════════╗
-- ║         GMod Radio - Server Configuration                     ║
-- ║               Customizable Settings                           ║
-- ╚═══════════════════════════════════════════════════════════════╝

RADIO_CONFIG = {
    -- Audio Settings
    MAX_VOLUME = 1.0,
    MIN_VOLUME = 0.0,
    DEFAULT_VOLUME = 0.7,
    
    -- Display Settings
    DEFAULT_THEME = "dark",
    VISUALIZER_ENABLED = true,
    SHOW_FREQUENCY = true,
    
    -- Network Settings
    SYNC_INTERVAL = 0.5,  -- seconds
    UPDATE_RATE = 30,     -- Hz
    
    -- 3D Sound Settings
    AUDIO_RANGE = 1500,   -- units
    MIN_AUDIO_DISTANCE = 100,  -- units
    VOLUME_FALLOFF = 1.5,      -- logarithmic curve
    
    -- Performance
    MAX_CONCURRENT_SOUNDS = 10,
    BUFFER_SIZE = 4096,
    SAMPLE_RATE = 44100,
    
    -- Features
    ENABLE_3D_SOUND = true,
    ENABLE_EQUALIZER = true,
    ENABLE_EFFECTS = true,
    ENABLE_FAVORITES = true,
    ENABLE_HISTORY = true,
    ENABLE_WORLD_RADIOS = true,
    
    -- Playlist Settings
    AUTO_LOOP_PLAYLIST = true,
    SHUFFLE_ON_START = false,
    REPEAT_MODE = "playlist"  -- "off", "one", "playlist"
}

print("[Radio] ✓ Server configuration loaded")
