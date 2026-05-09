-- ╔═══════════════════════════════════════════════════════════════╗
-- ║              GMod Radio - Theme System                         ║
-- ║               Beautiful Color Schemes                          ║
-- ╚═══════════════════════════════════════════════════════════════╝

RADIO_THEMES = {
    dark = {
        name = "Dark",
        background = Color(25, 25, 35),
        surface = Color(35, 35, 50),
        accent = Color(0, 200, 255),
        text = Color(220, 220, 220),
        secondary = Color(100, 100, 120),
        border = Color(0, 200, 255, 100),
        playing = Color(0, 255, 100),
    },
    neon = {
        name = "Neon",
        background = Color(15, 5, 25),
        surface = Color(30, 10, 40),
        accent = Color(255, 0, 150),
        text = Color(240, 240, 255),
        secondary = Color(150, 50, 200),
        border = Color(255, 0, 150, 150),
        playing = Color(0, 255, 100),
    },
    ocean = {
        name = "Ocean",
        background = Color(10, 40, 70),
        surface = Color(20, 60, 100),
        accent = Color(0, 180, 255),
        text = Color(200, 230, 255),
        secondary = Color(50, 120, 180),
        border = Color(0, 150, 255, 100),
        playing = Color(100, 255, 200),
    },
    sunset = {
        name = "Sunset",
        background = Color(80, 35, 10),
        surface = Color(120, 60, 20),
        accent = Color(255, 150, 0),
        text = Color(255, 220, 180),
        secondary = Color(200, 100, 50),
        border = Color(255, 180, 50, 100),
        playing = Color(255, 200, 100),
    }
}

function GetRadioTheme(themeName)
    return RADIO_THEMES[themeName] or RADIO_THEMES.dark
end

print("[Radio] ✓ Themes loaded: Dark, Neon, Ocean, Sunset")
