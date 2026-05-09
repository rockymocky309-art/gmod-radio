-- ╔═══════════════════════════════════════════════════════════════╗
-- ║          GMod Radio - Audio Effects & Animations              ║
-- ║               Fade In/Out, Transitions                        ║
-- ╚═══════════════════════════════════════════════════════════════╝

RADIO_EFFECTS = {}

RADIO_EFFECTS.fadeData = {
    current = 1,
    target = 1,
    speed = 1
}

function RADIO_EFFECTS:FadeIn(speed)
    speed = speed or 1
    self.fadeData.target = 1
    self.fadeData.speed = speed
end

function RADIO_EFFECTS:FadeOut(speed)
    speed = speed or 1
    self.fadeData.target = 0
    self.fadeData.speed = speed
end

function RADIO_EFFECTS:Update(dt)
    dt = dt or 0.016
    
    if self.fadeData.current < self.fadeData.target then
        self.fadeData.current = math.Clamp(
            self.fadeData.current + dt * self.fadeData.speed,
            0, 1
        )
    elseif self.fadeData.current > self.fadeData.target then
        self.fadeData.current = math.Clamp(
            self.fadeData.current - dt * self.fadeData.speed,
            0, 1
        )
    end
    
    return self.fadeData.current
end

function RADIO_EFFECTS:GetVolume(baseVolume)
    return baseVolume * self.fadeData.current
end

-- Equalizer effects
RADIO_EFFECTS.equalizer = {
    bass = 1.0,
    mid = 1.0,
    treble = 1.0
}

function RADIO_EFFECTS:SetEQ(bass, mid, treble)
    self.equalizer.bass = math.Clamp(bass or 1, 0, 2)
    self.equalizer.mid = math.Clamp(mid or 1, 0, 2)
    self.equalizer.treble = math.Clamp(treble or 1, 0, 2)
end

print("[Radio] ✓ Effects loaded")
