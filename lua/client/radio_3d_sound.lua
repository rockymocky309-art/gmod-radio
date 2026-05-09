-- ╔═══════════════════════════════════════════════════════════════╗
-- ║        GMod Radio - 3D Surround Sound Processing              ║
-- ║           Positional Audio with Distance Falloff              ║
-- ╚═══════════════════════════════════════════════════════════════╝

RADIO_3D_SOUND = {}

RADIO_3D_SOUND.soundEntities = {}
RADIO_3D_SOUND.maxDistance = 1500
RADIO_3D_SOUND.minDistance = 100

function RADIO_3D_SOUND:GetDistanceVolume(soundPos, listenerPos)
    local dist = soundPos:Distance(listenerPos)
    
    -- Volume falloff
    if dist <= self.minDistance then
        return 1.0
    elseif dist >= self.maxDistance then
        return 0.0
    else
        local ratio = (self.maxDistance - dist) / (self.maxDistance - self.minDistance)
        return math.pow(ratio, 1.5)  -- Logarithmic falloff
    end
end

function RADIO_3D_SOUND:CalculatePan(soundPos, listenerPos)
    local diff = soundPos - listenerPos
    local forward = LocalPlayer():GetAimVector()
    local right = forward:Cross(Vector(0, 0, 1)):GetNormalized()
    
    -- Pan is based on how far right the sound is
    local pan = diff:Dot(right) / diff:Length()
    return math.Clamp(pan, -1, 1)
end

function RADIO_3D_SOUND:PlayPositionalSound(pos, sound, volume)
    if not IsValid(LocalPlayer()) then return end
    
    local listenerPos = LocalPlayer():GetPos()
    local distVolume = self:GetDistanceVolume(pos, listenerPos)
    local finalVolume = volume * distVolume
    
    if finalVolume > 0 then
        -- Play sound with calculated volume
        LocalPlayer():EmitSound(sound, 75, 100, finalVolume)
    end
end

print("[Radio] ✓ 3D Sound system loaded")
