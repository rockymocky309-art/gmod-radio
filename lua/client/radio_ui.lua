-- ╔═══════════════════════════════════════════════════════════════╗
-- ║              GMod Radio - Beautiful UI Panel                  ║
-- ║                    Main Player Interface                       ║
-- ╚═══════════════════════════════════════════════════════════════╝

local PANEL = {}

function PANEL:Init()
    self:SetSize(600, 700)
    self:Center()
    self:MakePopup()
    self:SetTitle("🎵 GMod Radio Player")
    self:SetBackgroundBlur(true)
    
    self.currentTrack = 1
    self.isPlaying = false
    self.volume = 0.7
    self.currentTheme = "dark"
    self.time = 0
    
    -- Initialize theme
    self:ApplyTheme("dark")
    
    -- Create UI elements
    self:CreateHeader()
    self:CreateVisualizer()
    self:CreateDisplay()
    self:CreateControls()
    self:CreateVolumeControl()
    self:CreatePlaylist()
    self:CreateSettings()
    
    self:SetVisible(false)
end

function PANEL:CreateHeader()
    local header = vgui.Create("Panel", self)
    header:Dock(TOP)
    header:SetHeight(60)
    
    function header:Paint(w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(30, 30, 40, 255))
        draw.SimpleText("🎙️ FM Radio Station", "DermaLarge", w/2, h/2, Color(0, 200, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

function PANEL:CreateVisualizer()
    local viz = vgui.Create("Panel", self)
    viz:Dock(TOP)
    viz:SetHeight(100)
    
    self.visualizer = viz
    
    function viz:Paint(w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(40, 40, 60, 220))
        
        -- Draw spectrum bars
        local bars = 32
        local barWidth = (w - 10) / bars
        
        for i = 1, bars do
            local height = math.sin(CurTime() * 5 + i) * 40 + 30
            local x = 5 + (i-1) * barWidth
            
            local hue = (i / bars) * 360
            local col = HSVToColor(hue, 0.8, 0.9)
            
            draw.RoundedBox(2, x, h - height, barWidth - 2, height, col)
        end
    end
end

function PANEL:CreateDisplay()
    local display = vgui.Create("Panel", self)
    display:Dock(TOP)
    display:SetHeight(120)
    
    function display:Paint(w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(35, 35, 50, 200))
        
        -- Track info
        local track = RADIO_PLAYLIST[self:GetParent().currentTrack]
        if track then
            draw.SimpleText(track.name, "DermaLarge", 15, 15, Color(0, 200, 255, 255), TEXT_ALIGN_LEFT)
            draw.SimpleText(track.artist, "DermaDefault", 15, 45, Color(200, 200, 200, 255), TEXT_ALIGN_LEFT)
            draw.SimpleText("🎚️ 95." .. string.format("%d", math.abs(track.id * 7) % 100) .. " FM", "DermaDefault", 15, 70, Color(100, 100, 100, 255), TEXT_ALIGN_LEFT)
        end
        
        -- Status
        local status = self:GetParent().isPlaying and "▶️ Playing" or "⏸️ Stopped"
        draw.SimpleText(status, "DermaDefault", w - 15, 15, Color(0, 255, 100, 255), TEXT_ALIGN_RIGHT)
    end
end

function PANEL:CreateControls()
    local controls = vgui.Create("Panel", self)
    controls:Dock(TOP)
    controls:SetHeight(60)
    
    function controls:Paint(w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(30, 30, 40, 200))
    end
    
    -- Previous button
    local btnPrev = vgui.Create("DButton", controls)
    btnPrev:SetSize(50, 50)
    btnPrev:SetPos(20, 5)
    btnPrev:SetText("⏮️")
    btnPrev:SetFont("DermaLarge")
    function btnPrev:Paint(w, h)
        if self:IsHovered() then
            draw.RoundedBox(6, 0, 0, w, h, Color(0, 150, 200, 200))
        else
            draw.RoundedBox(6, 0, 0, w, h, Color(50, 50, 80, 200))
        end
        self:DrawLabel()
    end
    function btnPrev:DoClick()
        net.Start("RADIO_PREV")
        net.SendToServer()
    end
    
    -- Play/Stop button
    local btnPlay = vgui.Create("DButton", controls)
    btnPlay:SetSize(60, 60)
    btnPlay:SetPos(85, 0)
    btnPlay:SetText("▶️")
    btnPlay:SetFont("DermaLarge")
    function btnPlay:Paint(w, h)
        if self:IsHovered() then
            draw.RoundedBox(8, 0, 0, w, h, Color(0, 200, 100, 200))
        else
            draw.RoundedBox(8, 0, 0, w, h, Color(0, 150, 80, 200))
        end
        self:DrawLabel()
    end
    function btnPlay:DoClick()
        local parent = self:GetParent():GetParent()
        parent.isPlaying = not parent.isPlaying
        net.Start("RADIO_TOGGLE_PLAY")
        net.SendToServer()
        self:SetText(parent.isPlaying and "⏹️" or "▶️")
    end
    self.btnPlay = btnPlay
    
    -- Next button
    local btnNext = vgui.Create("DButton", controls)
    btnNext:SetSize(50, 50)
    btnNext:SetPos(160, 5)
    btnNext:SetText("⏭️")
    btnNext:SetFont("DermaLarge")
    function btnNext:Paint(w, h)
        if self:IsHovered() then
            draw.RoundedBox(6, 0, 0, w, h, Color(0, 150, 200, 200))
        else
            draw.RoundedBox(6, 0, 0, w, h, Color(50, 50, 80, 200))
        end
        self:DrawLabel()
    end
    function btnNext:DoClick()
        net.Start("RADIO_NEXT")
        net.SendToServer()
    end
    
    -- Favorite button
    local btnFav = vgui.Create("DButton", controls)
    btnFav:SetSize(50, 50)
    btnFav:SetPos(w - 70, 5)
    btnFav:SetText("♡")
    btnFav:SetFont("DermaLarge")
    function btnFav:Paint(w, h)
        if self:IsHovered() then
            draw.RoundedBox(6, 0, 0, w, h, Color(255, 50, 100, 200))
        else
            draw.RoundedBox(6, 0, 0, w, h, Color(100, 50, 80, 200))
        end
        self:DrawLabel()
    end
    function btnFav:DoClick()
        print("Added to favorites!")
    end
end

function PANEL:CreateVolumeControl()
    local volume = vgui.Create("Panel", self)
    volume:Dock(TOP)
    volume:SetHeight(50)
    
    function volume:Paint(w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(35, 35, 50, 200))
    end
    
    -- Volume slider
    local slider = vgui.Create("DSlider", volume)
    slider:SetPos(15, 15)
    slider:SetSize(w - 30, 20)
    slider:SetMin(0)
    slider:SetMax(1)
    slider:SetValue(0.7)
    function slider:OnValueChanged(val)
        self:GetParent():GetParent().volume = val
        net.Start("RADIO_SET_VOLUME")
        net.WriteFloat(val)
        net.SendToServer()
    end
    
    function volume:Paint(w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(35, 35, 50, 200))
        draw.SimpleText("🔊 Volume: " .. math.Round(self:GetParent().volume * 100) .. "%", "DermaDefault", 15, 5, Color(200, 200, 200, 255), TEXT_ALIGN_LEFT)
    end
end

function PANEL:CreatePlaylist()
    local panel = vgui.Create("Panel", self)
    panel:Dock(TOP)
    panel:SetHeight(200)
    
    function panel:Paint(w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(30, 30, 40, 200))
    end
    
    -- Playlist scroll
    local scroll = vgui.Create("DScrollPanel", panel)
    scroll:Dock(FILL)
    scroll:SetPaintBackground(false)
    
    for id, track in ipairs(RADIO_PLAYLIST) do
        local item = vgui.Create("DButton", scroll)
        item:Dock(TOP)
        item:SetHeight(30)
        item:SetText("")
        
        function item:Paint(w, h)
            if self:IsHovered() then
                draw.RoundedBox(4, 2, 2, w-4, h-4, Color(0, 150, 200, 150))
            else
                draw.RoundedBox(4, 2, 2, w-4, h-4, Color(50, 50, 70, 150))
            end
            draw.SimpleText("♫ " .. track.name .. " - " .. track.artist, "DermaDefault", 10, h/2, Color(200, 200, 200, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end
        
        function item:DoClick()
            self:GetParent():GetParent():GetParent().currentTrack = id
            net.Start("RADIO_PLAY_TRACK")
            net.WriteInt(id, 32)
            net.SendToServer()
        end
    end
end

function PANEL:CreateSettings()
    local settings = vgui.Create("Panel", self)
    settings:Dock(BOTTOM)
    settings:SetHeight(60)
    
    function settings:Paint(w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(30, 30, 40, 200))
    end
    
    -- Theme buttons
    local themes = {"dark", "neon", "ocean", "sunset"}
    for i, theme in ipairs(themes) do
        local btn = vgui.Create("DButton", settings)
        btn:SetSize((w-20)/4, 40)
        btn:SetPos(10 + (i-1) * (w-20)/4 + 2, 10)
        btn:SetText(string.upper(theme))
        function btn:Paint(w, h)
            draw.RoundedBox(4, 0, 0, w, h, Color(0, 100, 150, 200))
            self:DrawLabel()
        end
        function btn:DoClick()
            self:GetParent():GetParent():ApplyTheme(theme)
        end
    end
end

function PANEL:ApplyTheme(theme)
    self.currentTheme = theme
    
    local themes = {
        dark = {bg = Color(30, 30, 40), accent = Color(0, 200, 255)},
        neon = {bg = Color(20, 10, 30), accent = Color(255, 0, 150)},
        ocean = {bg = Color(10, 50, 80), accent = Color(0, 150, 255)},
        sunset = {bg = Color(80, 40, 20), accent = Color(255, 150, 0)}
    }
    
    local themeData = themes[theme] or themes.dark
    -- Theme applied
end

function PANEL:Paint(w, h)
    -- Background
    draw.RoundedBox(12, 0, 0, w, h, Color(25, 25, 35, 240))
    -- Border
    draw.RoundedBox(12, 0, 0, w, h, Color(0, 200, 255, 50), false)
end

vgui.Register("RadioPanel", PANEL, "DFrame")

-- Command to open radio
concommand.Add("radio_open", function()
    if not IsValid(g_RadioPanel) then
        g_RadioPanel = vgui.Create("RadioPanel")
    else
        g_RadioPanel:SetVisible(not g_RadioPanel:IsVisible())
    end
end)
