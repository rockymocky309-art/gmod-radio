# 🎵 GMod MP3 Radio Player

A feature-rich radio player addon for Garry's Mod with 3D sound, audio visualizer, equalizer, beautiful UI themes, and full server synchronization.

## ✨ Features

### Audio & Sound
- **3D Surround Sound** - Positional audio with distance falloff
- **Spatial Audio** - Sound emits from radio entity location
- **Volume Control** - Smooth 0-100% slider with dB adjustment
- **Fade Effects** - Smooth fade in/out transitions
- **Audio Visualizer** - Real-time spectrum analyzer with animated bars
- **Equalizer** - Adjust Bass, Mid, Treble frequencies

### User Interface
- **4 Themes** - Dark (default), Neon (cyberpunk), Ocean, Sunset
- **Modern Design** - Rounded corners, glassmorphism effects
- **Responsive Layout** - Adapts to all screen sizes
- **FM Radio Display** - Frequency simulation (87.5 - 108.0 FM)
- **Album Art** - Thumbnail preview support

### Playlist & Playback
- **Multiple Playlists** - Create and manage custom playlists
- **Search Function** - Find tracks instantly
- **Favorites** - Mark and organize favorite tracks
- **History** - Keep track of recently played songs
- **Shuffle & Repeat** - Control playback modes
- **Duration Display** - Current time and track length

### Multiplayer Features
- **Server Synchronization** - All players hear the same track
- **Network Updates** - Real-time sync of volume, theme, playback status
- **Persistent State** - Radio state saved across map changes
- **Admin Commands** - Control radio from server console

### World Integration
- **Placeable Radios** - Spawn radio entities in the world
- **Radio Proximity** - Only hear radios within range
- **3D Sound Positioning** - Volume decreases with distance
- **Entity Networking** - Radios sync across all clients

## 🎮 Commands

### Client Commands
```
radio_open              // Open/Close radio player UI
radio_list              // Show available tracks in console
radio_play [id]         // Play track by ID
radio_stop              // Stop playback
radio_next              // Skip to next track
radio_prev              // Play previous track
radio_theme [name]      // Change theme (dark/neon/ocean/sunset)
radio_visualizer [0/1]  // Toggle visualizer
```

### Server Commands
```
radio_volume [0-1]      // Set volume (0.0 to 1.0)
radio_force_sync        // Force sync to all clients
radio_spawn             // Spawn a radio entity at crosshair
```

## 📁 File Structure

```
addons/gmod-radio/
├── lua/
│   ├── autorun/
│   │   └── radio_init.lua              # Initialization & loader
│   ├── client/
│   │   ├── radio_ui.lua                # Main UI panel
│   │   ├── radio_themes.lua            # Theme system
│   │   ├── radio_visualizer.lua        # Audio visualizer
│   │   ├── radio_effects.lua           # Fade & effects
│   │   └── radio_commands.lua          # Client console commands
│   └── server/
│       ├── radio_server.lua            # Server logic
│       ├── radio_entity.lua            # Radio world entity
│       ├── radio_networking.lua        # Network messages
│       └── radio_config.lua            # Server configuration
├── sound/
│   └── gmod_radio/                     # Custom radio sounds
│       ├── click.wav
│       ├── startup.wav
│       └── loop.wav
└── materials/
    └── gmod_radio/                     # UI icons & assets
        ├── icon_play.vmt
        ├── icon_pause.vmt
        └── visualizer_bg.vmt
```

## 🎨 Themes

### Dark Theme (Default)
- Dark background with light text
- Perfect for night gaming sessions
- Blue accent colors

### Neon Theme
- Cyberpunk aesthetic
- Bright neon pink & cyan colors
- Glowing text effects
- Perfect for sci-fi servers

### Ocean Theme
- Cool blue colors
- Wave animation background
- Relaxing color palette

### Sunset Theme
- Warm orange & purple gradient
- Golden text
- Perfect for immersive environments

## 🔧 Installation

1. Download the addon folder
2. Place it in `SteamApps/common/GarrysMod/garrysmod/addons/`
3. Restart GMod
4. Open console and type: `radio_open`

## 📝 Configuration

Edit `lua/server/radio_config.lua` to customize:

```lua
RADIO_CONFIG = {
    MAX_VOLUME = 1.0,
    MIN_VOLUME = 0.0,
    DEFAULT_THEME = "dark",
    VISUALIZER_ENABLED = true,
    SYNC_INTERVAL = 1,
    AUDIO_RANGE = 1500,
    FADE_SPEED = 0.5
}
```

## 🎵 Adding Your Own Tracks

Edit the playlist in `lua/autorun/radio_init.lua`:

```lua
RADIO_PLAYLIST = {
    {
        id = 1,
        name = "Track Name",
        artist = "Artist Name",
        duration = 180,
        url = "path/to/sound",
        thumbnail = "materials/path/to/thumb.png"
    }
}
```

## 🌟 Advanced Features

### Equalizer
- **Bass** - Boost low frequencies (0-100%)
- **Mid** - Adjust midrange (0-100%)
- **Treble** - Enhance high frequencies (0-100%)

### Visualizer
- 32-band spectrum analyzer
- Smooth animations
- Multiple display modes
- Color-coded frequency ranges

### 3D Sound
- Positional audio in 3D space
- Distance-based volume attenuation
- Doppler effect simulation
- Multi-channel surround (stereo)

## 📊 Statistics

The radio tracks your listening:
- **Most Played** - Your favorite tracks
- **Recently Played** - Last 50 tracks
- **Play Count** - Total plays per track
- **Total Time** - Hours spent listening

## 🐛 Troubleshooting

### No Sound?
- Check volume setting (not muted)
- Ensure sound files exist
- Restart GMod
- Check console for errors

### UI Not Appearing?
- Type `radio_open` in console
- Restart game if stuck
- Check HUD is enabled

### Server Sync Issues?
- Use `radio_force_sync` on server
- Check network bandwidth
- Verify addon is installed on all clients

## 📄 License

Free to use and modify for GMod servers.

## 🎬 Credits

Created with ❤️ for the GMod community.

---

**Enjoy your beautiful radio player! 🎵🎙️**
