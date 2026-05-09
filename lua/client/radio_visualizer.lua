-- ╔═══════════════════════════════════════════════════════════════╗
-- ║         GMod Radio - Audio Visualizer                         ║
-- ║            Animated Frequency Spectrum Display                ║
-- ╚═══════════════════════════════════════════════════════════════╝

RADIO_VISUALIZER = {}
RADIO_VISUALIZER.bands = {}
RADIO_VISUALIZER.enabled = true

-- Initialize 32-band equalizer
for i = 1, 32 do
    RADIO_VISUALIZER.bands[i] = 0
end

function RADIO_VISUALIZER:Update()
    if not self.enabled then return end
    
    local time = CurTime()
    for i = 1, 32 do
        -- Simulate audio spectrum with sine waves
        local freq = i / 32
        local intensity = math.sin(time * (freq * 10)) * 0.5 + 0.5
        self.bands[i] = Lerp(0.1, self.bands[i], intensity)
    end
end

function RADIO_VISUALIZER:Draw(x, y, w, h, theme)
    theme = theme or RADIO_THEMES.dark
    
    -- Background
    draw.RoundedBox(8, x, y, w, h, theme.surface)
    
    -- Draw bands
    local bands = 32
    local bandWidth = (w - 20) / bands
    
    for i = 1, bands do
        local height = self.bands[i] * h * 0.8
        local bx = x + 10 + (i - 1) * bandWidth
        local by = y + h - height
        
        -- Color gradient based on frequency
        local hue = (i / bands) * 360
        local col = HSVToColor(hue, 0.8, 0.9)
        
        -- Draw rounded bar
        draw.RoundedBox(2, bx, by, bandWidth - 2, height, col)
        
        -- Glow effect
        draw.RoundedBox(2, bx, by, bandWidth - 2, height, ColorAlpha(col, 100))
    end
end

print("[Radio] ✓ Visualizer loaded")
