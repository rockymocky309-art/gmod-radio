-- ╔═══════════════════════════════════════════════════════════════╗
-- ║         GMod Radio - Worldspace Radio Entity                  ║
-- ║              Placeable Radio in the World                     ║
-- ╚═══════════════════════════════════════════════════════════════╝

if SERVER then
    local RADIO_ENTITY = {}
    RADIO_ENTITY.__index = RADIO_ENTITY
    
    function RADIO_ENTITY:new()
        local entity = {
            pos = Vector(0, 0, 0),
            isPlaying = false,
            currentTrack = 1,
            volume = 0.7,
            lastUpdate = CurTime()
        }
        setmetatable(entity, self)
        return entity
    end
    
    function RADIO_ENTITY:Play(trackId)
        self.currentTrack = trackId
        self.isPlaying = true
        self.lastUpdate = CurTime()
    end
    
    function RADIO_ENTITY:Stop()
        self.isPlaying = false
    end
    
    function RADIO_ENTITY:SetVolume(vol)
        self.volume = math.Clamp(vol, 0, 1)
    end
    
    function RADIO_ENTITY:GetDistanceVolume(listenerPos)
        local dist = self.pos:Distance(listenerPos)
        if dist < 100 then return 1.0 end
        if dist > RADIO_CONFIG.AUDIO_RANGE then return 0 end
        
        local ratio = (RADIO_CONFIG.AUDIO_RANGE - dist) / (RADIO_CONFIG.AUDIO_RANGE - 100)
        return math.pow(ratio, 1.5) * self.volume
    end
    
    -- World radio entities list
    RADIO_WORLDENTITIES = {}
    
    concommand.Add("radio_spawn", function(ply, cmd, args)
        if not IsValid(ply) then return end
        if not ply:IsAdmin() then
            print("[Radio] Only admins can spawn radios")
            return
        end
        
        -- Spawn at player's crosshair
        local traceData = {
            start = ply:GetShootPos(),
            endpos = ply:GetShootPos() + ply:GetAimVector() * 200,
            filter = ply
        }
        local trace = util.TraceLine(traceData)
        
        local radio = RADIO_ENTITY:new()
        radio.pos = trace.HitPos
        
        table.insert(RADIO_WORLDENTITIES, radio)
        
        print("[Radio] ✓ Radio spawned at " .. tostring(radio.pos))
    end)
end

print("[Radio] ✓ World entity system loaded")
