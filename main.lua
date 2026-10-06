-- =========================================================
-- SECTION 1/15 : LOADING GALAXY + CONFIG + STATE (ONE W GOLD)
-- =========================================================

Players = game:GetService("Players")
UIS = game:GetService("UserInputService")
RunService = game:GetService("RunService")
TweenService = game:GetService("TweenService")
Lighting = game:GetService("Lighting")
ReplicatedStorage = game:GetService("ReplicatedStorage")
VirtualInputManager = game:GetService("VirtualInputManager")
Stats = game:GetService("Stats")
GuiService = game:GetService("GuiService")
SoundService = game:GetService("SoundService")
StarterGui = game:GetService("StarterGui")

LP = Players.LocalPlayer
PG = LP:WaitForChild("PlayerGui")

function getRoot()
    local c = LP.Character
    return c and c:FindFirstChild("HumanoidRootPart")
end

-- =========================================================
-- WARNA GOLD (ONE W THEME)
-- =========================================================
C = {
    BG = Color3.fromRGB(15, 12, 5),
    BG2 = Color3.fromRGB(25, 20, 8),
    PANEL = Color3.fromRGB(40, 32, 12),
    PANEL2 = Color3.fromRGB(55, 45, 18),
    GOLD = Color3.fromRGB(255, 210, 80),
    GOLD_LIGHT = Color3.fromRGB(255, 230, 120),
    GOLD_DARK = Color3.fromRGB(200, 160, 50),
    ORANGE = Color3.fromRGB(255, 180, 60),
    ACC = Color3.fromRGB(255, 210, 80),
    ACC2 = Color3.fromRGB(255, 230, 120),
    ACC3 = Color3.fromRGB(255, 180, 60),
    ACC4 = Color3.fromRGB(255, 200, 80),
    FIRE_BRIGHT = Color3.fromRGB(255, 240, 200),
    TXT = Color3.fromRGB(255, 245, 220),
    DIM = Color3.fromRGB(180, 150, 80),
    GRN = Color3.fromRGB(80, 255, 150),
    RED = Color3.fromRGB(255, 70, 100),
    CYAN = Color3.fromRGB(80, 240, 255),
}

function rnd(o, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 10)
    c.Parent = o
end

function strk(o, col, t, tr)
    local s = Instance.new("UIStroke")
    s.Color = col or C.GOLD
    s.Thickness = t or 1.5
    s.Transparency = tr or 0
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = o
    return s
end

local ToggleSoundId = "rbxassetid://6073491164"
local _toggleSoundInstance = nil
function playToggleSound()
    task.spawn(function()
        pcall(function()
            if not _toggleSoundInstance or not _toggleSoundInstance.Parent then
                _toggleSoundInstance = Instance.new("Sound")
                _toggleSoundInstance.SoundId = ToggleSoundId
                _toggleSoundInstance.Volume = 0.5
                _toggleSoundInstance.Parent = SoundService
            end
            _toggleSoundInstance:Play()
        end)
    end)
end
_G.Roooor_playSound = playToggleSound

-- =========================================================
-- LOADING GOLD GALAXY
-- =========================================================
local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "OneWLoading"
loadingGui.ResetOnSpawn = false
loadingGui.IgnoreGuiInset = true
loadingGui.DisplayOrder = 999999
loadingGui.Parent = PG

local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(8, 6, 2)
bg.BorderSizePixel = 0
bg.Parent = loadingGui

local nebula = Instance.new("Frame")
nebula.Size = UDim2.new(1, 0, 1, 0)
nebula.BackgroundColor3 = Color3.fromRGB(35, 25, 5)
nebula.BorderSizePixel = 0
nebula.BackgroundTransparency = 0.3
nebula.Parent = bg

local nebulaGrad = Instance.new("UIGradient")
nebulaGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(180, 130, 20)),
    ColorSequenceKeypoint.new(0.25, Color3.fromRGB(60, 45, 10)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 200, 80)),
    ColorSequenceKeypoint.new(0.75, Color3.fromRGB(80, 60, 15)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(200, 150, 30)),
})
nebulaGrad.Rotation = 45
nebulaGrad.Parent = nebula

task.spawn(function()
    local t = 0
    while nebula.Parent do
        t = t + 0.005
        nebulaGrad.Rotation = (t * 20) % 360
        task.wait(0.08)
    end
end)

local starContainer = Instance.new("Frame")
starContainer.Size = UDim2.new(1, 0, 1, 0)
starContainer.BackgroundTransparency = 1
starContainer.Parent = bg

local stars = {}
for i = 1, 20 do
    local star = Instance.new("Frame")
    star.Size = UDim2.new(0, math.random(2, 4), 0, math.random(2, 4))
    star.Position = UDim2.new(math.random(), 0, math.random(), 0)
    star.BackgroundColor3 = Color3.fromRGB(math.random(220, 255), math.random(180, 220), math.random(80, 150))
    star.BorderSizePixel = 0
    star.BackgroundTransparency = math.random(20, 60) / 100
    star.Parent = starContainer
    rnd(star, 999)
    table.insert(stars, {
        obj = star,
        speed = math.random(10, 40) / 10000,
        twinkle = math.random() * math.pi * 2
    })
end

task.spawn(function()
    while starContainer.Parent do
        for _, s in ipairs(stars) do
            if s.obj and s.obj.Parent then
                local p = s.obj.Position
                local newY = p.Y.Scale + s.speed
                if newY > 1 then
                    newY = 0
                    s.obj.Position = UDim2.new(math.random(), 0, 0, 0)
                else
                    s.obj.Position = UDim2.new(p.X.Scale, 0, newY, 0)
                end
                s.twinkle = s.twinkle + 0.1
                s.obj.BackgroundTransparency = 0.4 + math.sin(s.twinkle) * 0.3
            end
        end
        task.wait(0.12)
    end
end)

local galaxyHolder = Instance.new("Frame")
galaxyHolder.Size = UDim2.new(0, 400, 0, 400)
galaxyHolder.Position = UDim2.new(0.5, -200, 0.5, -200)
galaxyHolder.BackgroundTransparency = 1
galaxyHolder.Parent = bg

local spiral1 = Instance.new("Frame")
spiral1.Size = UDim2.new(0, 300, 0, 300)
spiral1.Position = UDim2.new(0.5, -150, 0.5, -150)
spiral1.BackgroundTransparency = 1
spiral1.Parent = galaxyHolder

local spiral1Stroke = Instance.new("UIStroke")
spiral1Stroke.Thickness = 60
spiral1Stroke.Transparency = 0.85
spiral1Stroke.Color = Color3.fromRGB(255, 210, 80)
spiral1Stroke.Parent = spiral1
rnd(spiral1, 999)

local spiral1Grad = Instance.new("UIGradient")
spiral1Grad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 180, 60)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 210, 80)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(255, 240, 160)),
})
spiral1Grad.Parent = spiral1Stroke

local spiral2 = Instance.new("Frame")
spiral2.Size = UDim2.new(0, 260, 0, 260)
spiral2.Position = UDim2.new(0.5, -130, 0.5, -130)
spiral2.BackgroundTransparency = 1
spiral2.Parent = galaxyHolder

local spiral2Stroke = Instance.new("UIStroke")
spiral2Stroke.Thickness = 40
spiral2Stroke.Transparency = 0.88
spiral2Stroke.Color = Color3.fromRGB(255, 240, 160)
spiral2Stroke.Parent = spiral2
rnd(spiral2, 999)

local spiral2Grad = Instance.new("UIGradient")
spiral2Grad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 240, 160)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 180, 60)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(255, 210, 80)),
})
spiral2Grad.Rotation = 180
spiral2Grad.Parent = spiral2Stroke

task.spawn(function()
    local t = 0
    while galaxyHolder.Parent do
        t = t + 1
        spiral1.Rotation = t * 0.8
        spiral2.Rotation = -t * 1.1
        spiral1Grad.Rotation = (t * 2) % 360
        spiral2Grad.Rotation = 180 + (t * 1.5) % 360
        task.wait(0.08)
    end
end)

local titleGlow = Instance.new("Frame")
titleGlow.Size = UDim2.new(0, 500, 0, 100)
titleGlow.Position = UDim2.new(0.5, -250, 0.42, -50)
titleGlow.BackgroundColor3 = Color3.fromRGB(255, 210, 80)
titleGlow.BackgroundTransparency = 0.85
titleGlow.BorderSizePixel = 0
titleGlow.Parent = bg
rnd(titleGlow, 999)

local glowGrad = Instance.new("UIGradient")
glowGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 180, 60)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 240, 160)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(255, 210, 80)),
})
glowGrad.Parent = titleGlow

local welcomeTitle = Instance.new("TextLabel")
welcomeTitle.Size = UDim2.new(1, 0, 0, 90)
welcomeTitle.Position = UDim2.new(0, 0, 0.42, -20)
welcomeTitle.BackgroundTransparency = 1
welcomeTitle.Text = "ONE W"
welcomeTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
welcomeTitle.TextSize = 0
welcomeTitle.Font = Enum.Font.GothamBlack
welcomeTitle.TextStrokeTransparency = 0.4
welcomeTitle.TextStrokeColor3 = Color3.fromRGB(255, 210, 80)
welcomeTitle.Parent = bg

local titleGrad = Instance.new("UIGradient")
titleGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 240, 160)),
    ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 210, 80)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 180, 60)),
    ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255, 210, 80)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(255, 240, 160)),
})
titleGrad.Parent = welcomeTitle

task.spawn(function()
    local t = 0
    while welcomeTitle.Parent do
        t = t + 1
        titleGrad.Rotation = (t * 2) % 360
        task.wait(0.08)
    end
end)

TweenService:Create(welcomeTitle, TweenInfo.new(1.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    TextSize = 68,
    TextTransparency = 0
}):Play()

task.spawn(function()
    task.wait(1.2)
    while titleGlow.Parent do
        TweenService:Create(titleGlow, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            BackgroundTransparency = 0.6,
            Size = UDim2.new(0, 560, 0, 120),
            Position = UDim2.new(0.5, -280, 0.42, -60)
        }):Play()
        task.wait(1.3)
        TweenService:Create(titleGlow, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            BackgroundTransparency = 0.85,
            Size = UDim2.new(0, 500, 0, 100),
            Position = UDim2.new(0.5, -250, 0.42, -50)
        }):Play()
        task.wait(1.3)
    end
end)

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, 0, 0, 24)
subtitle.Position = UDim2.new(0, 0, 0.42, 70)
subtitle.BackgroundTransparency = 1
subtitle.Text = "L O A D I N G"
subtitle.TextColor3 = Color3.fromRGB(255, 230, 160)
subtitle.TextSize = 14
subtitle.Font = Enum.Font.GothamBold
subtitle.TextStrokeTransparency = 0.5
subtitle.TextStrokeColor3 = Color3.fromRGB(180, 120, 20)
subtitle.TextTransparency = 1
subtitle.Parent = bg

TweenService:Create(subtitle, TweenInfo.new(1), {TextTransparency = 0}):Play()

task.spawn(function()
    task.wait(1)
    while subtitle.Parent do
        TweenService:Create(subtitle, TweenInfo.new(0.8), {TextTransparency = 0.4}):Play()
        task.wait(0.9)
        TweenService:Create(subtitle, TweenInfo.new(0.8), {TextTransparency = 0}):Play()
        task.wait(0.9)
    end
end)

local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(0, 320, 0, 4)
barBg.Position = UDim2.new(0.5, -160, 0.42, 110)
barBg.BackgroundColor3 = Color3.fromRGB(50, 35, 10)
barBg.BorderSizePixel = 0
barBg.BackgroundTransparency = 0.4
barBg.Parent = bg
rnd(barBg, 999)

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(255, 210, 80)
barFill.BorderSizePixel = 0
barFill.Parent = barBg
rnd(barFill, 999)

local barFillGrad = Instance.new("UIGradient")
barFillGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 180, 60)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 240, 160)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(255, 210, 80)),
})
barFillGrad.Parent = barFill

TweenService:Create(barFill, TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Size = UDim2.new(1, 0, 1, 0)
}):Play()

local barGlow = Instance.new("Frame")
barGlow.Size = UDim2.new(1, 12, 2, 12)
barGlow.Position = UDim2.new(0, -6, 0, -6)
barGlow.BackgroundColor3 = Color3.fromRGB(255, 210, 80)
barGlow.BackgroundTransparency = 0.7
barGlow.BorderSizePixel = 0
barGlow.ZIndex = -1
barGlow.Parent = barBg
rnd(barGlow, 999)

task.delay(1.6, function()
    if not loadingGui then return end
    if bg and bg.Parent then
        TweenService:Create(bg, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1}):Play()
    end
    if welcomeTitle and welcomeTitle.Parent then
        TweenService:Create(welcomeTitle, TweenInfo.new(0.5), {TextTransparency = 1, TextStrokeTransparency = 1}):Play()
    end
    if subtitle and subtitle.Parent then
        TweenService:Create(subtitle, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    end
    if nebula and nebula.Parent then
        TweenService:Create(nebula, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    end
    if titleGlow and titleGlow.Parent then
        TweenService:Create(titleGlow, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    end
    if barBg and barBg.Parent then
        TweenService:Create(barBg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    end
    if barGlow and barGlow.Parent then
        TweenService:Create(barGlow, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    end
    task.wait(0.8)
    if loadingGui then loadingGui:Destroy() end
end)

-- =========================================================
-- STATE LENGKAP
-- =========================================================
_G.RoooorSavedStates = _G.RoooorSavedStates or {}

_G.RoooorS = _G.RoooorS or {
    FireOn = false, FireType = "CosmicFire", FireSize = 5,
    ParryCircle = false, ParryCircleSize = 12,
    WalkSpeed = false, WalkSpeedVal = 16, WalkSpeedBoost = 0,
    SpeedHack = false, SpeedHackVal = 40,
    NoClip = false, NoClipCamera = false,
    Korblox = true, KorbloxType = "Pencil",
    KorbloxYOffset = 0.80, KorbloxScale = 1,
    Headless = true,
    EightBitOn = false, EightBitType = "Royal Crown",
    EightBitSize = 1.24, EightBitHeight = 0.88,
    Trail = false, TrailColor = Color3.fromRGB(255, 210, 80),
    Aura = false, AuraColor = Color3.fromRGB(255, 210, 80),
    KillEffect = false,
    Crosshair = false,
    CrosshairColor = Color3.fromRGB(255, 210, 80),
    CrosshairSize = 8, CrosshairThickness = 2,
    CrosshairStyle = "Plus", CrosshairColorMode = "Solid",
    CrosshairOffsetX = 0, CrosshairOffsetY = 0,
    ZoomOut = false, ZoomOutValue = 500,
    FOV = 90, FOVEnabled = false,
    Fullbright = false, FullbrightVal = 50,
    NoFog = false, UltraHD = false,
    Contrast = false, ContrastVal = 0.3, SaturationVal = 0.2,
    SkyId = "Default",
    SkyAutoApplied = false,
    NoScreenEffects = false, LowGraphics = false, CleanSky = false,
    HDSky = false,
    AntiAFK = false, ShowFPS = false, ShowPing = false,
    Killer_AutoAtk = false, Killer_AtkDelay = 0.35,
    Killer_KillAll = false, MaskedPower = "Cobra",
    InstantInteract = false,
    AutoCarry = false, AutoHook = false, CarryRange = 60,
    HDTexture = false, HDReflection = false, HDBloom = false,
    HDShadow = false, HDWater = false, HDSunRays = false,
    HDDepthField = false, HDAntiAliasing = false,
    FireBeamOn = false, FireBeamType = "Classic Beam",
    FireBeamColor = Color3.fromRGB(255, 210, 80),
    ESPNameMode = "Galaxy", ESPNameSize = 8,
    ESPGenMode = "Bar",
    ESPGenBarSize = 64, ESPGenBarHeight = 8, ESPGenBarTextSize = 10,
    KillFeed = false, StunNotify = false,
    AutoEscapeGate = false, AutoEscapeRange = 50,
    AutoEscapeUseKillerCheck = true, AutoEscapeUseGenCheck = true,
}
S = _G.RoooorS

FPSPingConfig = _G.Roooor_FPSPing or { Size = 1, X = 0, Y = 0 }
_G.Roooor_FPSPing = FPSPingConfig

_G.ToggleStates = _G.ToggleStates or {
    ["ESP Survivor"] = true,
    ["ESP Killer"] = true,
    ["ESP Generator"] = true,
    ["Enable Korblox"] = true,
    ["Headless"] = true,
}
_G.SliderStates = _G.SliderStates or {
    ["Name Size"] = 8,
    ["Bar Width"] = 64,
    ["Bar Height"] = 8,
}
_G.DropdownStates = _G.DropdownStates or {
    ["Generator Mode"] = 2,
    ["Name Mode"] = 2,
}

ESP = _G.Roooor_ESP or {
    Survivor = true, Killer = true, Generator = true,
    Pallet = false, Window = false, SCP = false, Distance = 1000,
}
_G.Roooor_ESP = ESP

ESPStatus = _G.Roooor_ESPStatus or {
    Enabled = false, ShowName = true, ShowDistance = true,
    ShowHealth = true, Radius = 1000,
}
_G.Roooor_ESPStatus = ESPStatus

TeamColors = _G.Roooor_TeamColors or {
    Killer = Color3.fromRGB(255, 60, 60),
    Survivor = Color3.fromRGB(0, 120, 255),
}
_G.Roooor_TeamColors = TeamColors

Hitbox = _G.Roooor_Hitbox or {
    Enabled = false, Size = 70, TextSize = 10,
    ColorKiller = Color3.fromRGB(255, 255, 255),
    ColorSurvivor = Color3.fromRGB(255, 255, 255),
    Mode = "Auto", WallBang = true,
}
_G.Roooor_Hitbox = Hitbox

AutoParry = _G.Roooor_AutoParry or {
    Enabled = false, ParryDistance = 20, ParryDelay = 0,
    Cooldown = 0.5, FaceSensitivity = 0.2, RequireFacing = true,
    Wiggle = false, WiggleSpam = 5,
}
_G.Roooor_AutoParry = AutoParry

AP_CameraFix = { Enabled = true }
AP_ESPCircle = {
    Enabled = false,
    ColorNormal = Color3.fromRGB(0, 255, 100),
    ColorDanger = Color3.fromRGB(255, 50, 50),
    Thickness = 0.4, Segments = 36, YOffset = -2.5
}
AP_PARRY_DEBOUNCE = 0.02
PARRY_DEBOUNCE = 0.1

AimbotSenter = _G.Roooor_AimbotSenter or {
    Enabled = false, Radius = 99999, LockPart = "Head",
    ShowLaser = true, LaserColor = Color3.fromRGB(255, 210, 80),
    Smoothness = 0.5, CurrentTarget = nil, HoldingSenter = false,
    _Hooked = {},
}
_G.Roooor_AimbotSenter = AimbotSenter

SkillCheck = _G.Roooor_SkillCheck or {
    Enabled = false, Mode = "Perfect", HideNeedle = false,
    Success = 0, Total = 0,
}
_G.Roooor_SkillCheck = SkillCheck

Moonwalk = _G.Roooor_Moonwalk or {
    Enabled = false, Locked = false, SpamSpeed = 30,
    Intensity = 35, SlowSpeed = 13, UseSlow = true, ShowButton = true,
}
_G.Roooor_Moonwalk = Moonwalk

FastVault = _G.Roooor_FastVault or {
    Enabled = false, Speed = 1.2,
    ReplaceMap = {
        ["rbxassetid://83873880822918"] = "rbxassetid://136962284480779",
    },
}
_G.Roooor_FastVault = FastVault
VaultTracks = {}

AutoFlee = _G.Roooor_AutoFlee or {
    Enabled = false, DetectDistance = 50, Cooldown = 0.1, LastFlee = 0,
}
_G.Roooor_AutoFlee = AutoFlee

EightBitList = { "Royal Crown" }
EightBitIds = { ["Royal Crown"] = 10138606900 }
KorbloxList = { "Pencil" }
KorbloxIds = { ["Pencil"] = 902942096 }

FireBeamList = {
    "Classic Beam", "Laser Beam", "Rainbow Beam",
    "Fire Wings", "Fire Halo", "Fire Hands",
    "Fire Foot Trail", "Fire Body Aura", "Fire Mouth", "Fire Eyes Glow",
}

GodMode = _G.Roooor_GodMode or { Enabled = false }
_G.Roooor_GodMode = GodMode

Aimlock = _G.RoooorAimlock or {
    Enabled = false, Radius = 80, TargetTeam = "Survivors",
    AimPart = "HumanoidRootPart", Holding = false, CurrentTarget = nil,
}
_G.RoooorAimlock = Aimlock
Aimlock_AttackButtons = {}

HitboxESPObjects = {}
HitboxOriginalSizes = {}

print("✅ [1/15] ONE W - Base + State Loaded (GOLD)")
print("🔦 Aimbot Senter: HOLD = INSTANT LOCK | RELEASE = FREE")-- =========================================================
-- SECTION 2/15 : FIRE CONFIG + SKY + KILLER ANIMS + GRAFIK PRESETS
-- =========================================================

FireList = {
    "Classic","HellFire","IceFire","ToxicFire","VoidFire",
    "GoldenKing","SakuraFire","EmeraldFire","BloodFire","ShadowFire",
    "HolyFire","OceanFire","Firework","Lava","GhostFire",
    "CosmicFire","DragonFire","MysteryFire","RainbowFire","LightningFire",
    "GalaxyFire","NebulaFire","AuroraFire","PhoenixFire","DemonFire",
    "AngelFire","CrystalFire","NeonFire","PlasmaFire","QuantumFire",
    "LegendaryFire","MythicFire","DivineFire","CursedFire","AncientFire",
    "EternalFire","InfernoFire","BifrostFire","ChaosFire","OmegaFire",
    "SolarFire","LunarFire","EclipseFire","SolarFlare","VoidStorm",
    "StarFire","SupernovaFire","BlackHoleFire","MeteorFire","CometFire",
    "FrostFire","BlizzardFire","ThunderFire","StormFire","TornadoFire",
    "SoulFire","SpiritFire","PhantomFire","WraithFire","ReaperFire"
}

FireConfig = {
    Classic = { c1 = Color3.fromRGB(120, 60, 255), c2 = Color3.fromRGB(0, 230, 255) },
    HellFire = { c1 = Color3.fromRGB(180, 0, 0), c2 = Color3.fromRGB(255, 80, 0), smoke = true },
    IceFire = { c1 = Color3.fromRGB(120, 200, 255), c2 = Color3.fromRGB(220, 240, 255), spark = true },
    ToxicFire = { c1 = Color3.fromRGB(0, 255, 50), c2 = Color3.fromRGB(180, 255, 0), smoke = true },
    VoidFire = { c1 = Color3.fromRGB(100, 0, 180), c2 = Color3.fromRGB(220, 50, 255), spark = true },
    GoldenKing = { c1 = Color3.fromRGB(255, 215, 0), c2 = Color3.fromRGB(255, 255, 120), spark = true },
    SakuraFire = { c1 = Color3.fromRGB(255, 150, 200), c2 = Color3.fromRGB(255, 220, 240), spark = true },
    EmeraldFire = { c1 = Color3.fromRGB(0, 220, 100), c2 = Color3.fromRGB(120, 255, 170) },
    BloodFire = { c1 = Color3.fromRGB(220, 0, 0), c2 = Color3.fromRGB(120, 0, 0), smoke = true },
    ShadowFire = { c1 = Color3.fromRGB(30, 30, 40), c2 = Color3.fromRGB(100, 0, 130), smoke = true },
    HolyFire = { c1 = Color3.fromRGB(255, 255, 255), c2 = Color3.fromRGB(255, 255, 220), spark = true },
    OceanFire = { c1 = Color3.fromRGB(0, 120, 255), c2 = Color3.fromRGB(120, 220, 255) },
    Firework = { c1 = Color3.fromRGB(255, 0, 120), c2 = Color3.fromRGB(255, 220, 50), rainbow = true, spark = true },
    Lava = { c1 = Color3.fromRGB(255, 100, 0), c2 = Color3.fromRGB(120, 30, 0), smoke = true },
    GhostFire = { c1 = Color3.fromRGB(200, 200, 255), c2 = Color3.fromRGB(255, 255, 255) },
    CosmicFire = { c1 = Color3.fromRGB(80, 0, 150), c2 = Color3.fromRGB(255, 120, 220), rainbow = true },
    DragonFire = { c1 = Color3.fromRGB(255, 80, 0), c2 = Color3.fromRGB(255, 220, 50), smoke = true },
    MysteryFire = { c1 = Color3.fromRGB(255, 0, 0), c2 = Color3.fromRGB(0, 255, 255), rainbow = true },
    RainbowFire = { c1 = Color3.fromRGB(255, 0, 0), c2 = Color3.fromRGB(0, 255, 255), rainbow = true, spark = true },
    LightningFire = { c1 = Color3.fromRGB(120, 220, 255), c2 = Color3.fromRGB(255, 255, 255), spark = true },
    GalaxyFire = { c1 = Color3.fromRGB(120, 60, 255), c2 = Color3.fromRGB(255, 200, 255), rainbow = true, spark = true },
    NebulaFire = { c1 = Color3.fromRGB(220, 80, 255), c2 = Color3.fromRGB(80, 220, 255), rainbow = true, spark = true },
    AuroraFire = { c1 = Color3.fromRGB(0, 255, 200), c2 = Color3.fromRGB(120, 255, 120), rainbow = true, spark = true },
    PhoenixFire = { c1 = Color3.fromRGB(255, 180, 0), c2 = Color3.fromRGB(255, 80, 0), smoke = true },
    DemonFire = { c1 = Color3.fromRGB(255, 0, 0), c2 = Color3.fromRGB(0, 0, 0), smoke = true },
    AngelFire = { c1 = Color3.fromRGB(255, 255, 220), c2 = Color3.fromRGB(255, 240, 255), spark = true },
    CrystalFire = { c1 = Color3.fromRGB(220, 255, 255), c2 = Color3.fromRGB(220, 220, 255), spark = true },
    NeonFire = { c1 = Color3.fromRGB(0, 255, 120), c2 = Color3.fromRGB(255, 0, 220), rainbow = true },
    PlasmaFire = { c1 = Color3.fromRGB(180, 0, 255), c2 = Color3.fromRGB(0, 220, 255), spark = true },
    QuantumFire = { c1 = Color3.fromRGB(0, 120, 255), c2 = Color3.fromRGB(255, 0, 120), rainbow = true },
    LegendaryFire = { c1 = Color3.fromRGB(255, 215, 0), c2 = Color3.fromRGB(255, 120, 0), spark = true },
    MythicFire = { c1 = Color3.fromRGB(220, 0, 255), c2 = Color3.fromRGB(255, 220, 0), rainbow = true },
    DivineFire = { c1 = Color3.fromRGB(255, 255, 255), c2 = Color3.fromRGB(255, 220, 120), spark = true },
    CursedFire = { c1 = Color3.fromRGB(100, 0, 0), c2 = Color3.fromRGB(220, 0, 220), smoke = true },
    AncientFire = { c1 = Color3.fromRGB(220, 180, 0), c2 = Color3.fromRGB(120, 60, 0), smoke = true },
    EternalFire = { c1 = Color3.fromRGB(255, 120, 220), c2 = Color3.fromRGB(120, 220, 255), rainbow = true },
    InfernoFire = { c1 = Color3.fromRGB(255, 40, 0), c2 = Color3.fromRGB(255, 220, 0), smoke = true },
    BifrostFire = { c1 = Color3.fromRGB(255, 120, 220), c2 = Color3.fromRGB(120, 255, 220), rainbow = true },
    ChaosFire = { c1 = Color3.fromRGB(255, 0, 0), c2 = Color3.fromRGB(0, 0, 255), rainbow = true },
    OmegaFire = { c1 = Color3.fromRGB(255, 215, 0), c2 = Color3.fromRGB(255, 0, 255), rainbow = true },
    SolarFire = { c1 = Color3.fromRGB(255, 180, 0), c2 = Color3.fromRGB(255, 255, 120), spark = true },
    LunarFire = { c1 = Color3.fromRGB(220, 220, 255), c2 = Color3.fromRGB(120, 170, 255), spark = true },
    EclipseFire = { c1 = Color3.fromRGB(80, 0, 120), c2 = Color3.fromRGB(255, 180, 0), spark = true },
    SolarFlare = { c1 = Color3.fromRGB(255, 120, 0), c2 = Color3.fromRGB(255, 255, 220), spark = true },
    VoidStorm = { c1 = Color3.fromRGB(80, 0, 120), c2 = Color3.fromRGB(220, 0, 255), rainbow = true, spark = true },
    StarFire = { c1 = Color3.fromRGB(255, 255, 220), c2 = Color3.fromRGB(255, 220, 120), spark = true },
    SupernovaFire = { c1 = Color3.fromRGB(255, 220, 0), c2 = Color3.fromRGB(255, 0, 220), rainbow = true, spark = true },
    BlackHoleFire = { c1 = Color3.fromRGB(0, 0, 0), c2 = Color3.fromRGB(120, 0, 180), smoke = true },
    MeteorFire = { c1 = Color3.fromRGB(255, 100, 0), c2 = Color3.fromRGB(220, 40, 0), smoke = true },
    CometFire = { c1 = Color3.fromRGB(120, 220, 255), c2 = Color3.fromRGB(220, 255, 255), spark = true },
    FrostFire = { c1 = Color3.fromRGB(220, 240, 255), c2 = Color3.fromRGB(120, 200, 255), spark = true },
    BlizzardFire = { c1 = Color3.fromRGB(240, 250, 255), c2 = Color3.fromRGB(170, 220, 255), spark = true, smoke = true },
    ThunderFire = { c1 = Color3.fromRGB(255, 255, 120), c2 = Color3.fromRGB(120, 120, 255), spark = true },
    StormFire = { c1 = Color3.fromRGB(100, 100, 180), c2 = Color3.fromRGB(220, 220, 255), spark = true, smoke = true },
    TornadoFire = { c1 = Color3.fromRGB(180, 180, 220), c2 = Color3.fromRGB(100, 100, 150), spark = true, smoke = true },
    SoulFire = { c1 = Color3.fromRGB(0, 255, 220), c2 = Color3.fromRGB(180, 255, 255), spark = true },
    SpiritFire = { c1 = Color3.fromRGB(220, 255, 255), c2 = Color3.fromRGB(180, 220, 255), spark = true },
    PhantomFire = { c1 = Color3.fromRGB(120, 0, 180), c2 = Color3.fromRGB(80, 0, 120), smoke = true },
    WraithFire = { c1 = Color3.fromRGB(50, 0, 80), c2 = Color3.fromRGB(180, 0, 220), smoke = true },
    ReaperFire = { c1 = Color3.fromRGB(0, 0, 0), c2 = Color3.fromRGB(255, 0, 0), smoke = true },
}

for _, name in ipairs(FireList) do
    if not FireConfig[name] then
        FireConfig[name] = FireConfig.Classic
    end
end

SkyList = {
    "Default", "Sunset", "Night", "Space",
    "Alien", "Purple", "Galaxy", "Void",
    "GalaxyPurple", "GalaxyBlue", "GalaxyPink", "GalaxyMulticolor",
    "Nebula", "CosmicStorm", "Aurora",
    "SunsetHD", "NightHD", "DeepSpace",
}

SkyIds = {
    Sunset = { Bk = "rbxassetid://169210149", Dn = "rbxassetid://169210108", Ft = "rbxassetid://169210121", Lf = "rbxassetid://169210133", Rt = "rbxassetid://169210143", Up = "rbxassetid://169210149" },
    Night = { Bk = "rbxassetid://18703245834", Dn = "rbxassetid://18703245834", Ft = "rbxassetid://18703245834", Lf = "rbxassetid://18703245834", Rt = "rbxassetid://18703245834", Up = "rbxassetid://18703245834" },
    Space = { Bk = "rbxassetid://17817511804", Dn = "rbxassetid://17817520184", Ft = "rbxassetid://17817511804", Lf = "rbxassetid://17817511804", Rt = "rbxassetid://17817511804", Up = "rbxassetid://17817511804" },
    Alien = { Bk = "rbxassetid://10253172001", Dn = "rbxassetid://10253172001", Ft = "rbxassetid://10253172001", Lf = "rbxassetid://10253172001", Rt = "rbxassetid://10253172001", Up = "rbxassetid://10253172001" },
    Purple = { Bk = "rbxassetid://6021017254", Dn = "rbxassetid://6021011228", Ft = "rbxassetid://6021017254", Lf = "rbxassetid://6021017254", Rt = "rbxassetid://6021017254", Up = "rbxassetid://6021017254" },
    Galaxy = { Bk = "rbxassetid://126146408999925", Dn = "rbxassetid://118112392224589", Ft = "rbxassetid://121253817183621", Lf = "rbxassetid://138429250948648", Rt = "rbxassetid://126146408999925", Up = "rbxassetid://126146408999925" },
    Void = { Bk = "rbxassetid://17817511804", Dn = "rbxassetid://17817520184", Ft = "rbxassetid://17817511804", Lf = "rbxassetid://17817511804", Rt = "rbxassetid://17817511804", Up = "rbxassetid://17817511804" },
    GalaxyPurple = { Bk = "rbxassetid://126146408999925", Dn = "rbxassetid://118112392224589", Ft = "rbxassetid://121253817183621", Lf = "rbxassetid://138429250948648", Rt = "rbxassetid://126146408999925", Up = "rbxassetid://126146408999925" },
    GalaxyBlue = { Bk = "rbxassetid://159454299", Dn = "rbxassetid://159454296", Ft = "rbxassetid://159454293", Lf = "rbxassetid://159454286", Rt = "rbxassetid://159454300", Up = "rbxassetid://159454288" },
    GalaxyPink = { Bk = "rbxassetid://6021017254", Dn = "rbxassetid://6021011228", Ft = "rbxassetid://6021017254", Lf = "rbxassetid://6021017254", Rt = "rbxassetid://6021017254", Up = "rbxassetid://6021017254" },
    GalaxyMulticolor = { Bk = "rbxassetid://126146408999925", Dn = "rbxassetid://118112392224589", Ft = "rbxassetid://121253817183621", Lf = "rbxassetid://138429250948648", Rt = "rbxassetid://126146408999925", Up = "rbxassetid://126146408999925" },
    Nebula = { Bk = "rbxassetid://126146408999925", Dn = "rbxassetid://118112392224589", Ft = "rbxassetid://121253817183621", Lf = "rbxassetid://138429250948648", Rt = "rbxassetid://126146408999925", Up = "rbxassetid://126146408999925" },
    CosmicStorm = { Bk = "rbxassetid://17817511804", Dn = "rbxassetid://17817520184", Ft = "rbxassetid://17817511804", Lf = "rbxassetid://17817511804", Rt = "rbxassetid://17817511804", Up = "rbxassetid://17817511804" },
    Aurora = { Bk = "rbxassetid://159454299", Dn = "rbxassetid://159454296", Ft = "rbxassetid://159454293", Lf = "rbxassetid://159454286", Rt = "rbxassetid://159454300", Up = "rbxassetid://159454288" },
    SunsetHD = { Bk = "rbxassetid://169210149", Dn = "rbxassetid://169210108", Ft = "rbxassetid://169210121", Lf = "rbxassetid://169210133", Rt = "rbxassetid://169210143", Up = "rbxassetid://169210149" },
    NightHD = { Bk = "rbxassetid://18703245834", Dn = "rbxassetid://18703245834", Ft = "rbxassetid://18703245834", Lf = "rbxassetid://18703245834", Rt = "rbxassetid://18703245834", Up = "rbxassetid://18703245834" },
    DeepSpace = { Bk = "rbxassetid://17817511804", Dn = "rbxassetid://17817520184", Ft = "rbxassetid://17817511804", Lf = "rbxassetid://17817511804", Rt = "rbxassetid://17817511804", Up = "rbxassetid://17817511804" },
}

-- KILLER ANIMS (28 ID)
KillerAnims = {}
for _, id in ipairs({
    "105374834496520","113255068724446","118907603246885","129784271201071",
    "117042998468241","122812055447896","78935059863801","74968262036854",
    "78432063483146","132817836308238","133963973694098","111920872708571",
    "80411309607666","98163597193511","82666958311998","110355011987939",
    "139369275981139","135002183282873","121216847022485","130593238885843",
    "117070354890871","106871536134254","138720291317243",
    "127096285501517","112166042383605","123047897844134",
    "126965695851149","135084204086504"
}) do
    KillerAnims["rbxassetid://"..id] = true
end

SkipAnims = {
    ["112166042383605"] = "Break Pallet",
    ["123047897844134"] = "Stun",
    ["126965695851149"] = "WalkCrouch",
    ["135084204086504"] = "WalkCrouch Injured",
    ["127096285501517"] = "Parry Anim",
}

-- =========================================================
-- GRAFIK ULTRA - SOFT CINEMATIC PRESETS (dari Xynoz)
-- =========================================================
GraphicPresets = {
    ["Soft"] = { Brightness = 2.00, Exposure = 0.03, ShadowSoftness = 0.075, Ambient = Color3.fromRGB(42,45,52), OutdoorAmbient = Color3.fromRGB(130,138,155), AtmosphereDensity = 0.055, AtmosphereHaze = 0.025, AtmosphereGlare = 0.08, BloomIntensity = 0.12, BloomSize = 20, BloomThreshold = 0.96, Contrast = 0.18, Saturation = 0.08, ColorBrightness = 0.01, SunRaysIntensity = 0.06, SunRaysSpread = 0.75, DOFNear = 0.01, DOFFar = 0.02, DOFFocus = 45, DOFRadius = 40 },
    ["Cinematic"] = { Brightness = 2.10, Exposure = 0.05, ShadowSoftness = 0.055, Ambient = Color3.fromRGB(32,35,42), OutdoorAmbient = Color3.fromRGB(125,132,150), AtmosphereDensity = 0.075, AtmosphereHaze = 0.045, AtmosphereGlare = 0.12, BloomIntensity = 0.18, BloomSize = 24, BloomThreshold = 0.92, Contrast = 0.24, Saturation = 0.10, ColorBrightness = 0.015, SunRaysIntensity = 0.085, SunRaysSpread = 0.72, DOFNear = 0.025, DOFFar = 0.045, DOFFocus = 45, DOFRadius = 35 },
    ["Ultra Cinematic"] = { Brightness = 2.15, Exposure = 0.07, ShadowSoftness = 0.045, Ambient = Color3.fromRGB(30,32,40), OutdoorAmbient = Color3.fromRGB(135,142,160), AtmosphereDensity = 0.065, AtmosphereHaze = 0.035, AtmosphereGlare = 0.14, BloomIntensity = 0.22, BloomSize = 27, BloomThreshold = 0.89, Contrast = 0.27, Saturation = 0.13, ColorBrightness = 0.02, SunRaysIntensity = 0.10, SunRaysSpread = 0.70, DOFNear = 0.02, DOFFar = 0.04, DOFFocus = 44, DOFRadius = 34 },
    ["Golden Hour"] = { Brightness = 2.20, Exposure = 0.08, ShadowSoftness = 0.065, Ambient = Color3.fromRGB(58,48,38), OutdoorAmbient = Color3.fromRGB(155,135,105), AtmosphereDensity = 0.07, AtmosphereHaze = 0.055, AtmosphereGlare = 0.16, BloomIntensity = 0.20, BloomSize = 26, BloomThreshold = 0.91, Contrast = 0.20, Saturation = 0.16, ColorBrightness = 0.025, SunRaysIntensity = 0.12, SunRaysSpread = 0.76, DOFNear = 0.015, DOFFar = 0.035, DOFFocus = 45, DOFRadius = 38 },
    ["Night Cinema"] = { Brightness = 1.65, Exposure = -0.02, ShadowSoftness = 0.035, Ambient = Color3.fromRGB(20,25,38), OutdoorAmbient = Color3.fromRGB(65,78,110), AtmosphereDensity = 0.085, AtmosphereHaze = 0.065, AtmosphereGlare = 0.06, BloomIntensity = 0.15, BloomSize = 24, BloomThreshold = 0.86, Contrast = 0.30, Saturation = 0.08, ColorBrightness = -0.01, SunRaysIntensity = 0.04, SunRaysSpread = 0.70, DOFNear = 0.025, DOFFar = 0.05, DOFFocus = 48, DOFRadius = 32 },
    ["Deep Shadow"] = { Brightness = 1.90, Exposure = 0.00, ShadowSoftness = 0.035, Ambient = Color3.fromRGB(25,28,35), OutdoorAmbient = Color3.fromRGB(105,112,130), AtmosphereDensity = 0.07, AtmosphereHaze = 0.04, AtmosphereGlare = 0.08, BloomIntensity = 0.14, BloomSize = 22, BloomThreshold = 0.94, Contrast = 0.30, Saturation = 0.08, ColorBrightness = 0.005, SunRaysIntensity = 0.07, SunRaysSpread = 0.74, DOFNear = 0.02, DOFFar = 0.035, DOFFocus = 48, DOFRadius = 34 },
    ["Crystal"] = { Brightness = 2.35, Exposure = 0.10, ShadowSoftness = 0.065, Ambient = Color3.fromRGB(48,52,60), OutdoorAmbient = Color3.fromRGB(150,158,175), AtmosphereDensity = 0.035, AtmosphereHaze = 0.018, AtmosphereGlare = 0.10, BloomIntensity = 0.10, BloomSize = 18, BloomThreshold = 1.00, Contrast = 0.15, Saturation = 0.05, ColorBrightness = 0.025, SunRaysIntensity = 0.055, SunRaysSpread = 0.78, DOFNear = 0.01, DOFFar = 0.025, DOFFocus = 46, DOFRadius = 42 },
    ["Dreamy"] = { Brightness = 2.10, Exposure = 0.06, ShadowSoftness = 0.09, Ambient = Color3.fromRGB(50,48,58), OutdoorAmbient = Color3.fromRGB(140,135,155), AtmosphereDensity = 0.10, AtmosphereHaze = 0.08, AtmosphereGlare = 0.13, BloomIntensity = 0.25, BloomSize = 30, BloomThreshold = 0.88, Contrast = 0.12, Saturation = 0.10, ColorBrightness = 0.025, SunRaysIntensity = 0.08, SunRaysSpread = 0.80, DOFNear = 0.03, DOFFar = 0.055, DOFFocus = 44, DOFRadius = 45 },
    ["Vivid Cinema"] = { Brightness = 2.20, Exposure = 0.06, ShadowSoftness = 0.055, Ambient = Color3.fromRGB(35,40,45), OutdoorAmbient = Color3.fromRGB(135,145,160), AtmosphereDensity = 0.055, AtmosphereHaze = 0.025, AtmosphereGlare = 0.10, BloomIntensity = 0.18, BloomSize = 23, BloomThreshold = 0.91, Contrast = 0.28, Saturation = 0.22, ColorBrightness = 0.015, SunRaysIntensity = 0.09, SunRaysSpread = 0.73, DOFNear = 0.015, DOFFar = 0.035, DOFFocus = 45, DOFRadius = 36 },
    ["Dark Cinema"] = { Brightness = 1.80, Exposure = -0.03, ShadowSoftness = 0.04, Ambient = Color3.fromRGB(18,20,26), OutdoorAmbient = Color3.fromRGB(88,92,110), AtmosphereDensity = 0.075, AtmosphereHaze = 0.05, AtmosphereGlare = 0.05, BloomIntensity = 0.12, BloomSize = 21, BloomThreshold = 0.95, Contrast = 0.34, Saturation = 0.04, ColorBrightness = -0.005, SunRaysIntensity = 0.04, SunRaysSpread = 0.70, DOFNear = 0.025, DOFFar = 0.045, DOFFocus = 48, DOFRadius = 30 },
    ["Cloudy Soft"] = { Brightness = 2.00, Exposure = 0.02, ShadowSoftness = 0.10, Ambient = Color3.fromRGB(55,58,65), OutdoorAmbient = Color3.fromRGB(145,148,158), AtmosphereDensity = 0.11, AtmosphereHaze = 0.09, AtmosphereGlare = 0.07, BloomIntensity = 0.10, BloomSize = 20, BloomThreshold = 0.97, Contrast = 0.10, Saturation = 0.03, ColorBrightness = 0.01, SunRaysIntensity = 0.035, SunRaysSpread = 0.82, DOFNear = 0.025, DOFFar = 0.05, DOFFocus = 46, DOFRadius = 43 },
    ["Film Look"] = { Brightness = 2.05, Exposure = 0.03, ShadowSoftness = 0.06, Ambient = Color3.fromRGB(40,40,42), OutdoorAmbient = Color3.fromRGB(125,125,130), AtmosphereDensity = 0.06, AtmosphereHaze = 0.035, AtmosphereGlare = 0.08, BloomIntensity = 0.09, BloomSize = 19, BloomThreshold = 0.98, Contrast = 0.30, Saturation = -0.02, ColorBrightness = 0.005, SunRaysIntensity = 0.065, SunRaysSpread = 0.74, DOFNear = 0.02, DOFFar = 0.04, DOFFocus = 45, DOFRadius = 37 },
    ["Moonlight"] = { Brightness = 1.70, Exposure = -0.01, ShadowSoftness = 0.03, Ambient = Color3.fromRGB(22,28,45), OutdoorAmbient = Color3.fromRGB(70,88,125), AtmosphereDensity = 0.09, AtmosphereHaze = 0.07, AtmosphereGlare = 0.04, BloomIntensity = 0.17, BloomSize = 25, BloomThreshold = 0.85, Contrast = 0.25, Saturation = 0.06, ColorBrightness = 0.00, SunRaysIntensity = 0.03, SunRaysSpread = 0.68, DOFNear = 0.02, DOFFar = 0.045, DOFFocus = 49, DOFRadius = 34 },
    ["Bright Cinema"] = { Brightness = 2.45, Exposure = 0.12, ShadowSoftness = 0.07, Ambient = Color3.fromRGB(52,55,62), OutdoorAmbient = Color3.fromRGB(165,170,185), AtmosphereDensity = 0.045, AtmosphereHaze = 0.025, AtmosphereGlare = 0.14, BloomIntensity = 0.16, BloomSize = 23, BloomThreshold = 0.95, Contrast = 0.18, Saturation = 0.09, ColorBrightness = 0.035, SunRaysIntensity = 0.10, SunRaysSpread = 0.78, DOFNear = 0.01, DOFFar = 0.025, DOFFocus = 45, DOFRadius = 40 },
    ["Ultra Soft"] = { Brightness = 2.05, Exposure = 0.04, ShadowSoftness = 0.12, Ambient = Color3.fromRGB(58,60,68), OutdoorAmbient = Color3.fromRGB(145,148,160), AtmosphereDensity = 0.08, AtmosphereHaze = 0.065, AtmosphereGlare = 0.08, BloomIntensity = 0.08, BloomSize = 18, BloomThreshold = 1.00, Contrast = 0.08, Saturation = 0.04, ColorBrightness = 0.015, SunRaysIntensity = 0.045, SunRaysSpread = 0.82, DOFNear = 0.025, DOFFar = 0.055, DOFFocus = 45, DOFRadius = 46 },
    ["Performance Cinema"] = { Brightness = 2.00, Exposure = 0.03, ShadowSoftness = 0.08, Ambient = Color3.fromRGB(40,43,50), OutdoorAmbient = Color3.fromRGB(125,132,148), AtmosphereDensity = 0.04, AtmosphereHaze = 0.02, AtmosphereGlare = 0.05, BloomIntensity = 0.07, BloomSize = 16, BloomThreshold = 1.00, Contrast = 0.14, Saturation = 0.06, ColorBrightness = 0.01, SunRaysIntensity = 0.035, SunRaysSpread = 0.75, DOFNear = 0, DOFFar = 0, DOFFocus = 45, DOFRadius = 30 },
}

GraphicPresetOrder = {
    "Soft","Cinematic","Ultra Cinematic","Golden Hour","Night Cinema",
    "Deep Shadow","Crystal","Dreamy","Vivid Cinema","Dark Cinema",
    "Cloudy Soft","Film Look","Moonlight","Bright Cinema","Ultra Soft",
    "Performance Cinema",
}

-- State Grafik Ultra
GraphicState = _G.Roooor_GraphicState or {
    SoftCinematic = false,
    LowGraphics = false,
    FullBright = false,
    NoFog = false,
    NoAnimation = false,
    NoParticle = false,
    NoGrass = false,
    CleanSky = false,
    Time = 18,
    SelectedPreset = "Soft",
}
_G.Roooor_GraphicState = GraphicState

print("✅ [2/15] ONE W - Fire + Sky + KillerAnims + Grafik Ultra Presets Loaded")-- =========================================================
-- SECTION 3/15 : FUNGSI UTAMA + HD SKY + FPS/PING + GRAFIK ULTRA LOGIC
-- =========================================================

function saveState(key, value)
    _G.RoooorSavedStates = _G.RoooorSavedStates or {}
    _G.RoooorSavedStates[key] = value
end

function loadState(key, default)
    _G.RoooorSavedStates = _G.RoooorSavedStates or {}
    return _G.RoooorSavedStates[key] or default
end

task.spawn(function()
    while task.wait(2) do
        _G.RoooorSavedStates = _G.RoooorSavedStates or {}
        _G.RoooorSavedStates.S = S
        _G.RoooorSavedStates.ESP = ESP
        _G.RoooorSavedStates.AutoParry = AutoParry
        _G.RoooorSavedStates.SkillCheck = SkillCheck
        _G.RoooorSavedStates.Moonwalk = Moonwalk
        _G.RoooorSavedStates.Hitbox = Hitbox
        _G.RoooorSavedStates.GodMode = GodMode
        _G.RoooorSavedStates.AutoFlee = AutoFlee
        _G.RoooorSavedStates.FastVault = FastVault
        _G.RoooorSavedStates.GraphicState = GraphicState
    end
end)

-- =========================================================
-- FIRE
-- =========================================================
function clearFire()
    if not LP.Character then return end
    local head = LP.Character:FindFirstChild("Head")
    if not head then return end
    for _, obj in pairs(head:GetChildren()) do
        if obj.Name == "RoooorFire" or obj.Name == "RoooorSmoke" or obj.Name == "RoooorSparkles" then
            obj:Destroy()
        end
    end
end

function applyFire()
    clearFire()
    if not S.FireOn then return end
    local char = LP.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end
    local cfg = FireConfig[S.FireType] or FireConfig.Classic

    local fire = Instance.new("Fire")
    fire.Name = "RoooorFire"
    fire.Size = S.FireSize
    fire.Heat = 15
    fire.Color = cfg.c1
    fire.SecondaryColor = cfg.c2
    fire.Parent = head

    if cfg.smoke then
        local smoke = Instance.new("Smoke")
        smoke.Name = "RoooorSmoke"
        smoke.Size = S.FireSize + 2
        smoke.RiseVelocity = 3
        smoke.Opacity = 0.4
        smoke.Color = cfg.c2
        smoke.Parent = head
    end

    if cfg.spark then
        local spark = Instance.new("Sparkles")
        spark.Name = "RoooorSparkles"
        spark.SparkleColor = cfg.c2
        spark.SparkleSize = 1
        spark.Parent = head
    end
end

task.spawn(function()
    while task.wait(0.8) do
        if S.FireOn and LP.Character then
            local head = LP.Character:FindFirstChild("Head")
            local fire = head and head:FindFirstChild("RoooorFire")
            if fire then
                local cfg = FireConfig[S.FireType] or FireConfig.Classic
                if cfg.rainbow then
                    local t = tick()
                    fire.Color = Color3.fromHSV((t * 0.5) % 1, 1, 1)
                    fire.SecondaryColor = Color3.fromHSV(((t * 0.5) + 0.5) % 1, 1, 1)
                end
            end
        end
    end
end)

-- =========================================================
-- 8-BIT ROYAL CROWN
-- =========================================================
eightBitPart = nil

function clear8Bit()
    if eightBitPart then
        eightBitPart:Destroy()
        eightBitPart = nil
    end
end

function apply8Bit(enable, itemName, size, height)
    clear8Bit()
    if not enable then return end

    local char = LP.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end

    size = size or S.EightBitSize or 1.24
    height = height or S.EightBitHeight or 0.88

    eightBitPart = Instance.new("Part")
    eightBitPart.Name = "Client8Bit"
    eightBitPart.Size = Vector3.new(2, 2, 2) * size
    eightBitPart.CanCollide = false
    eightBitPart.Massless = true
    eightBitPart.Transparency = 0
    eightBitPart.Parent = head

    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.MeshId = "rbxassetid://10138606900"
    mesh.TextureId = "rbxassetid://10138606949"
    mesh.Scale = Vector3.new(1.5, 1.5, 1.5) * size
    mesh.Parent = eightBitPart

    local weld = Instance.new("Weld")
    weld.Part0 = head
    weld.Part1 = eightBitPart
    weld.C0 = CFrame.new(0, height * size, 0)
    weld.Parent = eightBitPart
end

-- =========================================================
-- KORBLOX PENCIL
-- =========================================================
korbloxParts = {}
korbloxOrigData = {}

function clearKorblox()
    for _, part in pairs(korbloxParts) do
        if part and part.Parent then
            part:Destroy()
        end
    end
    korbloxParts = {}

    local char = LP.Character
    if not char then return end
    for legName, data in pairs(korbloxOrigData) do
        local leg = char:FindFirstChild(legName)
        if leg then
            leg.Transparency = data.trans
            leg.CanCollide = data.collide
        end
    end
    korbloxOrigData = {}
end

function applyKorblox(enable, mode, yOffset, scale)
    clearKorblox()
    if not enable then return end

    yOffset = 0.80
    scale = scale or S.KorbloxScale or 1

    local char = LP.Character
    if not char then return end

    local rightLeg = char:FindFirstChild("Right Leg")
    if not rightLeg then return end

    korbloxOrigData["Right Leg"] = {
        trans = rightLeg.Transparency,
        collide = rightLeg.CanCollide,
    }

    rightLeg.Transparency = 1
    rightLeg.CanCollide = false

    local korbloxPart = Instance.new("Part")
    korbloxPart.Name = "ClientKorblox"
    korbloxPart.Size = Vector3.new(1, 2, 1)
    korbloxPart.CanCollide = false
    korbloxPart.Massless = true
    korbloxPart.Transparency = 0
    korbloxPart.Parent = char

    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.MeshId = "rbxassetid://902942096"
    mesh.TextureId = "rbxassetid://902843398"
    mesh.Scale = Vector3.new(1, 1, 1)
    mesh.Offset = Vector3.new(0, yOffset, 0)
    mesh.Parent = korbloxPart

    local weld = Instance.new("Weld")
    weld.Part0 = rightLeg
    weld.Part1 = korbloxPart
    weld.C0 = CFrame.new(0, 0, 0)
    weld.Parent = korbloxPart

    table.insert(korbloxParts, korbloxPart)
end

-- =========================================================
-- HEADLESS
-- =========================================================
function applyHeadless(s)
    local char = LP.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end

    if s then
        head.Transparency = 1
        head.CanCollide = false

        for _, v in pairs(head:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Transparency = 1
                v.CanCollide = false
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            end
        end

        for _, obj in pairs(char:GetChildren()) do
            if obj:IsA("Accessory") then
                for _, part in pairs(obj:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Transparency = 1
                        part.CanCollide = false
                    end
                end
            end
        end
    else
        head.Transparency = 0
        head.CanCollide = true

        for _, v in pairs(head:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Transparency = 0
                v.CanCollide = true
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 0
            end
        end

        for _, obj in pairs(char:GetChildren()) do
            if obj:IsA("Accessory") then
                for _, part in pairs(obj:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Transparency = 0
                        part.CanCollide = true
                    end
                end
            end
        end
    end
end

-- =========================================================
-- HD VISUAL EXTRAS
-- =========================================================
hdExtras = {}

origLighting = {
    FogEnd = Lighting.FogEnd,
    FogStart = Lighting.FogStart,
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient,
}

origSky = nil
for _, v in pairs(Lighting:GetChildren()) do
    if v:IsA("Sky") then origSky = v break end
end

function applyHDSky(s)
    if s then
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("Atmosphere") then v:Destroy() end
        end

        pcall(function()
            Lighting.FogEnd = 100000
            Lighting.FogStart = 0
            Lighting.FogColor = Color3.fromRGB(200, 220, 255)
        end)

        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("Sky") then v:Destroy() end
        end

        local cleanSky = Instance.new("Sky")
        cleanSky.Name = "HDSky_Clean"
        cleanSky.SkyboxBk = "rbxassetid://159454299"
        cleanSky.SkyboxDn = "rbxassetid://159454296"
        cleanSky.SkyboxFt = "rbxassetid://159454293"
        cleanSky.SkyboxLf = "rbxassetid://159454286"
        cleanSky.SkyboxRt = "rbxassetid://159454300"
        cleanSky.SkyboxUp = "rbxassetid://159454288"
        cleanSky.Parent = Lighting

        local lightAtmo = Instance.new("Atmosphere")
        lightAtmo.Name = "HDSky_Light"
        lightAtmo.Density = 0.1
        lightAtmo.Offset = 0.1
        lightAtmo.Color = Color3.fromRGB(220, 230, 255)
        lightAtmo.Decay = Color3.fromRGB(180, 200, 240)
        lightAtmo.Glare = 0
        lightAtmo.Haze = 0
        lightAtmo.Parent = Lighting

        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.Ambient = Color3.fromRGB(150, 160, 180)
        Lighting.OutdoorAmbient = Color3.fromRGB(180, 190, 210)
    else
        local oldSky = Lighting:FindFirstChild("HDSky_Clean")
        if oldSky then oldSky:Destroy() end
        local oldAtmo = Lighting:FindFirstChild("HDSky_Light")
        if oldAtmo then oldAtmo:Destroy() end

        pcall(function()
            Lighting.FogEnd = origLighting.FogEnd or 100000
            Lighting.FogStart = origLighting.FogStart or 0
            Lighting.Brightness = origLighting.Brightness
            Lighting.ClockTime = origLighting.ClockTime
            Lighting.Ambient = origLighting.Ambient
            Lighting.OutdoorAmbient = origLighting.OutdoorAmbient
        end)

        if origSky then
            local existing = Lighting:FindFirstChild("OrigSky_Clone")
            if not existing then
                local c = origSky:Clone()
                c.Name = "OrigSky_Clone"
                c.Parent = Lighting
            end
        end
    end
end

function applyHDTexture(s)
    if s then
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level10
        end)
    end
end

function applyHDReflection(s)
    if s then
        if not hdExtras.Reflection then
            hdExtras.Reflection = Instance.new("ColorCorrectionEffect")
            hdExtras.Reflection.Name = "OneWReflection"
            hdExtras.Reflection.Brightness = 0.05
            hdExtras.Reflection.Contrast = 0.1
            hdExtras.Reflection.Parent = Lighting
        end
    else
        if hdExtras.Reflection then hdExtras.Reflection:Destroy(); hdExtras.Reflection = nil end
    end
end

function applyHDBloom(s)
    if s then
        if not hdExtras.Bloom then
            hdExtras.Bloom = Instance.new("BloomEffect")
            hdExtras.Bloom.Name = "OneWHDBloom"
            hdExtras.Bloom.Intensity = 0.7
            hdExtras.Bloom.Size = 24
            hdExtras.Bloom.Threshold = 0.9
            hdExtras.Bloom.Parent = Lighting
        end
    else
        if hdExtras.Bloom then hdExtras.Bloom:Destroy(); hdExtras.Bloom = nil end
    end
end

function applyHDShadow(s)
    if s then
        Lighting.GlobalShadows = true
    end
end

function applyHDWater(s)
    if s then
        if not hdExtras.Water then
            hdExtras.Water = Instance.new("ColorCorrectionEffect")
            hdExtras.Water.Name = "OneWWater"
            hdExtras.Water.TintColor = Color3.fromRGB(180, 220, 255)
            hdExtras.Water.Parent = Lighting
        end
    else
        if hdExtras.Water then hdExtras.Water:Destroy(); hdExtras.Water = nil end
    end
end

function applyHDSunRays(s)
    if s then
        if not hdExtras.SunRays then
            hdExtras.SunRays = Instance.new("SunRaysEffect")
            hdExtras.SunRays.Name = "OneWSunRays"
            hdExtras.SunRays.Intensity = 0.15
            hdExtras.SunRays.Spread = 1
            hdExtras.SunRays.Parent = Lighting
        end
    else
        if hdExtras.SunRays then hdExtras.SunRays:Destroy(); hdExtras.SunRays = nil end
    end
end

function applyHDDepthField(s)
    if s then
        if not hdExtras.DepthField then
            hdExtras.DepthField = Instance.new("DepthOfFieldEffect")
            hdExtras.DepthField.Name = "OneWDOF"
            hdExtras.DepthField.FarIntensity = 0.15
            hdExtras.DepthField.FocusDistance = 20
            hdExtras.DepthField.InFocusRadius = 15
            hdExtras.DepthField.NearIntensity = 0.1
            hdExtras.DepthField.Parent = Lighting
        end
    else
        if hdExtras.DepthField then hdExtras.DepthField:Destroy(); hdExtras.DepthField = nil end
    end
end

function applyHDAntiAliasing(s)
    if s then
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level10
        end)
    end
end

function applySky(skyName)
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("Sky") then v:Destroy() end
    end

    if not skyName or skyName == "Default" then
        if origSky then
            local c = origSky:Clone()
            c.Name = "OrigSky_Clone"
            c.Parent = Lighting
        end
        return
    end

    local ids = SkyIds[skyName]
    if not ids then
        ids = SkyIds.SunsetHD
    end

    local sky = Instance.new("Sky")
    sky.Name = "OneWSky_" .. skyName
    sky.SkyboxBk = ids.Bk
    sky.SkyboxDn = ids.Dn or ids.Bk
    sky.SkyboxFt = ids.Ft or ids.Bk
    sky.SkyboxLf = ids.Lf or ids.Bk
    sky.SkyboxRt = ids.Rt or ids.Bk
    sky.SkyboxUp = ids.Up or ids.Bk
    sky.Parent = Lighting
end

-- =========================================================
-- FUNGSI VISUAL YANG TADI ERROR (FIX)
-- =========================================================

function applyFullbright(s)
    if s then
        Lighting.Brightness = 2 + (S.FullbrightVal or 50) / 100
        Lighting.Ambient = Color3.fromRGB(180, 180, 180)
        Lighting.OutdoorAmbient = Color3.fromRGB(180, 180, 180)
        Lighting.ExposureCompensation = 0.2
    else
        Lighting.Brightness = origLighting.Brightness
        Lighting.Ambient = origLighting.Ambient
        Lighting.OutdoorAmbient = origLighting.OutdoorAmbient
        Lighting.ExposureCompensation = 0
    end
end

function applyNoFog(s)
    if s then
        Lighting.FogStart = 100000
        Lighting.FogEnd = 100000
    else
        Lighting.FogStart = origLighting.FogStart
        Lighting.FogEnd = origLighting.FogEnd
    end
end

function applyUltraHD()
    if S.UltraHD then
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level10
            Lighting.GlobalShadows = true
        end)
    end
end

function applyContrast()
    if not hdExtras.Contrast then
        hdExtras.Contrast = Instance.new("ColorCorrectionEffect")
        hdExtras.Contrast.Name = "OneWContrast"
        hdExtras.Contrast.Parent = Lighting
    end
    if S.Contrast then
        hdExtras.Contrast.Contrast = S.ContrastVal or 0.3
        hdExtras.Contrast.Saturation = S.SaturationVal or 0.2
    else
        if hdExtras.Contrast then hdExtras.Contrast:Destroy(); hdExtras.Contrast = nil end
    end
end

function applyZoomOut(s, val)
    if s then
        LP.CameraMaxZoomDistance = val or 500
    else
        LP.CameraMaxZoomDistance = 128
    end
end

function applyFOV()
    local cam = workspace.CurrentCamera
    if cam and S.FOVEnabled then
        cam.FieldOfView = S.FOV
    end
end

function applyTrail(s, color)
    local char = LP.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local att0 = hrp:FindFirstChild("TrailAtt0")
    local att1 = hrp:FindFirstChild("TrailAtt1")
    local trail = hrp:FindFirstChild("OneWTrail")

    if s then
        if not att0 then
            att0 = Instance.new("Attachment"); att0.Name = "TrailAtt0"
            att0.Position = Vector3.new(0, 1, 0); att0.Parent = hrp
        end
        if not att1 then
            att1 = Instance.new("Attachment"); att1.Name = "TrailAtt1"
            att1.Position = Vector3.new(0, -1, 0); att1.Parent = hrp
        end
        if not trail then
            trail = Instance.new("Trail")
            trail.Name = "OneWTrail"
            trail.Attachment0 = att0
            trail.Attachment1 = att1
            trail.Lifetime = 1
            trail.MinLength = 0
            trail.Parent = hrp
        end
        trail.Color = ColorSequence.new(color or Color3.fromRGB(255, 210, 80))
    else
        if trail then trail:Destroy() end
        if att0 then att0:Destroy() end
        if att1 then att1:Destroy() end
    end
end

function applyAura(s, color)
    local char = LP.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local aura = hrp:FindFirstChild("OneWAura")

    if s then
        if not aura then
            aura = Instance.new("ParticleEmitter")
            aura.Name = "OneWAura"
            aura.Texture = "rbxasset://textures/particles/sparkles_main.dds"
            aura.Rate = 50
            aura.Lifetime = NumberRange.new(0.5, 1)
            aura.Size = NumberSequence.new(0.5)
            aura.Speed = NumberRange.new(1, 3)
            aura.SpreadAngle = Vector2.new(180, 180)
            aura.Parent = hrp
        end
        aura.Color = ColorSequence.new(color or Color3.fromRGB(255, 210, 80))
    else
        if aura then aura:Destroy() end
    end
end

function applyCrosshair(s, color, size)
    if not crosshairGui then
        crosshairGui = Instance.new("ScreenGui")
        crosshairGui.Name = "OneWCrosshair"
        crosshairGui.ResetOnSpawn = false
        crosshairGui.IgnoreGuiInset = true
        crosshairGui.Parent = PG
    end
    local frame = crosshairGui:FindFirstChild("CrossFrame")
    if s then
        if not frame then
            frame = Instance.new("Frame")
            frame.Name = "CrossFrame"
            frame.BackgroundColor3 = color
            frame.BorderSizePixel = 0
            frame.Parent = crosshairGui
        end
        local sz = size or S.CrosshairSize or 8
        frame.Size = UDim2.new(0, sz, 0, 2)
        frame.Position = UDim2.new(0.5, -sz/2 + (S.CrosshairOffsetX or 0), 0.5, -1 + (S.CrosshairOffsetY or 0))
        frame.BackgroundColor3 = color
    else
        if frame then frame:Destroy() end
    end
end

function spawnKillEffect(pos)
    if not pos then return end
    local p = Instance.new("Part")
    p.Anchored = true
    p.CanCollide = false
    p.Transparency = 0.5
    p.Material = Enum.Material.Neon
    p.Color = Color3.fromRGB(255, 210, 80)
    p.Size = Vector3.new(2, 2, 2)
    p.Position = pos
    p.Parent = workspace
    TweenService:Create(p, TweenInfo.new(0.8), {
        Size = Vector3.new(20, 20, 20),
        Transparency = 1
    }):Play()
    task.delay(1, function() p:Destroy() end)
end

function hitboxClearAll()
    for char, obj in pairs(HitboxESPObjects) do
        if obj and obj.Parent then obj:Destroy() end
    end
    HitboxESPObjects = {}
    for hrp, size in pairs(HitboxOriginalSizes) do
        if hrp and hrp.Parent then hrp.Size = size end
    end
    HitboxOriginalSizes = {}
end

function hitboxCreateText(hrp, size, color)
    if not hrp then return end
    local gui = HitboxESPObjects[hrp]
    if not gui then
        gui = Instance.new("BillboardGui")
        gui.Size = UDim2.new(0, 60, 0, 30)
        gui.AlwaysOnTop = true
        gui.Adornee = hrp
        gui.Parent = hrp
        local lbl = Instance.new("TextLabel")
        lbl.Name = "HitboxText"
        lbl.Size = UDim2.new(1, 0, 1, 0)
        lbl.BackgroundTransparency = 1
        lbl.TextColor3 = color
        lbl.TextStrokeTransparency = 0
        lbl.Font = Enum.Font.GothamBlack
        lbl.TextSize = Hitbox.TextSize or 10
        lbl.Parent = gui
        HitboxESPObjects[hrp] = gui
    end
    local lbl = gui:FindFirstChild("HitboxText")
    if lbl then
        lbl.Text = tostring(math.floor(size))
        lbl.TextColor3 = color
        lbl.TextSize = Hitbox.TextSize or 10
    end
end

function hitboxUpdateVisibility()
    for hrp, gui in pairs(HitboxESPObjects) do
        if gui and gui.Parent then
            local lbl = gui:FindFirstChild("HitboxText")
            if lbl then lbl.TextSize = Hitbox.TextSize or 10 end
        end
    end
end

function teleportToFinishLine()
    local root = getRoot()
    if not root then return end
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            local n = string.lower(obj.Name)
            if n == "fininshline" or n == "finishline"
               or n == "escape" or n == "escapegate"
               or string.find(n, "escape") then
                pcall(function()
                    root.CFrame = obj.CFrame + Vector3.new(0, 5, 0)
                end)
                return
            end
        end
    end
end

function hookVault(char)
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local animator = hum:FindFirstChildOfClass("Animator")
    if not animator then return end
    animator.AnimationPlayed:Connect(function(track)
        if not FastVault.Enabled then return end
        local a = track.Animation
        if not a or not a.AnimationId then return end
        local id = a.AnimationId:match("%d+")
        if FastVault.ReplaceMap and FastVault.ReplaceMap["rbxassetid://" .. id] then
            pcall(function()
                track:AdjustSpeed(FastVault.Speed or 1.2)
            end)
        end
    end)
end

function applyAntiAFK(enable)
    S.AntiAFK = enable
end

function rejoinServer()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
end

-- =========================================================
-- GRAFIK ULTRA - SOFT CINEMATIC LOGIC
-- =========================================================
GraphicCreatedEffects = {}
GraphicPartBackup = {}
GraphicParticleBackup = {}
GraphicTextureBackup = {}
GraphicCloudBackup = {}

function GraphicCreateEffect(className, name)
    local old = Lighting:FindFirstChild(name)
    if old and old.ClassName == className then
        GraphicCreatedEffects[name] = old
        return old
    end
    if old then old:Destroy() end
    local effect = Instance.new(className)
    effect.Name = name
    effect.Parent = Lighting
    GraphicCreatedEffects[name] = effect
    return effect
end

function GraphicRemoveEffects()
    for name, effect in pairs(GraphicCreatedEffects) do
        if effect and effect.Parent then effect:Destroy() end
        GraphicCreatedEffects[name] = nil
    end
end

function GraphicApplyCharacterShadow()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            if GraphicPartBackup[obj] == nil then
                GraphicPartBackup[obj] = obj.CastShadow
            end
            obj.CastShadow = true
        end
    end
end

function GraphicRestorePartShadows()
    for part, oldValue in pairs(GraphicPartBackup) do
        if part and part.Parent then part.CastShadow = oldValue end
    end
    table.clear(GraphicPartBackup)
end

function GraphicApplyAtmosphereState()
    local atmosphere = Lighting:FindFirstChild("OneWGraphic_Atmosphere")
    if not atmosphere then return end
    if GraphicState.NoFog then
        atmosphere.Density = 0
        atmosphere.Haze = 0
        atmosphere.Glare = 0
        return
    end
    if GraphicState.CleanSky then
        atmosphere.Density = 0.015
        atmosphere.Haze = 0.005
        atmosphere.Glare = 0
        return
    end
    local cfg = GraphicPresets[GraphicState.SelectedPreset]
    atmosphere.Density = cfg.AtmosphereDensity
    atmosphere.Haze = cfg.AtmosphereHaze
    atmosphere.Glare = cfg.AtmosphereGlare
end

function GraphicApplySoftCinematic()
    local cfg = GraphicPresets[GraphicState.SelectedPreset]
    if not cfg then return end
    Lighting.Brightness = cfg.Brightness
    Lighting.ExposureCompensation = cfg.Exposure
    Lighting.ShadowSoftness = cfg.ShadowSoftness
    Lighting.Ambient = cfg.Ambient
    Lighting.OutdoorAmbient = cfg.OutdoorAmbient
    Lighting.GlobalShadows = true
    Lighting.EnvironmentDiffuseScale = 0.90
    Lighting.EnvironmentSpecularScale = 1

    local atmosphere = GraphicCreateEffect("Atmosphere", "OneWGraphic_Atmosphere")
    atmosphere.Color = Color3.fromRGB(205,215,235)
    atmosphere.Decay = Color3.fromRGB(100,110,130)

    local bloom = GraphicCreateEffect("BloomEffect", "OneWGraphic_Bloom")
    bloom.Intensity = cfg.BloomIntensity
    bloom.Size = cfg.BloomSize
    bloom.Threshold = cfg.BloomThreshold

    local color = GraphicCreateEffect("ColorCorrectionEffect", "OneWGraphic_ColorCorrection")
    color.Contrast = cfg.Contrast
    color.Saturation = cfg.Saturation
    color.Brightness = cfg.ColorBrightness

    local rays = GraphicCreateEffect("SunRaysEffect", "OneWGraphic_SunRays")
    rays.Intensity = cfg.SunRaysIntensity
    rays.Spread = cfg.SunRaysSpread

    local dof = GraphicCreateEffect("DepthOfFieldEffect", "OneWGraphic_DOF")
    dof.NearIntensity = cfg.DOFNear
    dof.FarIntensity = cfg.DOFFar
    dof.FocusDistance = cfg.DOFFocus
    dof.InFocusRadius = cfg.DOFRadius

    GraphicApplyAtmosphereState()
    GraphicApplyCharacterShadow()
end

function GraphicEnableSoftCinematic()
    if GraphicState.LowGraphics then
        GraphicState.LowGraphics = false
    end
    GraphicState.SoftCinematic = true
    GraphicApplySoftCinematic()
end

function GraphicDisableSoftCinematic()
    GraphicState.SoftCinematic = false
    GraphicRemoveEffects()
    GraphicRestorePartShadows()
    Lighting.Brightness = origLighting.Brightness
    Lighting.ExposureCompensation = 0
    Lighting.ShadowSoftness = 0.2
    Lighting.Ambient = origLighting.Ambient
    Lighting.OutdoorAmbient = origLighting.OutdoorAmbient
    Lighting.GlobalShadows = true
    Lighting.EnvironmentDiffuseScale = 1
    Lighting.EnvironmentSpecularScale = 1
end

function GraphicSelectPreset(name)
    if not GraphicPresets[name] then return end
    GraphicState.SelectedPreset = name
    if GraphicState.SoftCinematic then
        GraphicApplySoftCinematic()
    end
end

function GraphicEnableLowGraphics()
    if GraphicState.SoftCinematic then
        GraphicDisableSoftCinematic()
    end
    GraphicState.LowGraphics = true
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam")
           or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
            if GraphicParticleBackup[obj] == nil then
                GraphicParticleBackup[obj] = obj.Enabled
            end
            obj.Enabled = false
        elseif obj:IsA("Texture") or obj:IsA("Decal") then
            if GraphicTextureBackup[obj] == nil then
                GraphicTextureBackup[obj] = obj.Transparency
            end
            obj.Transparency = math.max(obj.Transparency, 0.5)
        elseif obj:IsA("BasePart") then
            if GraphicPartBackup[obj] == nil then
                GraphicPartBackup[obj] = obj.CastShadow
            end
            obj.CastShadow = false
        end
    end
    Lighting.GlobalShadows = false
    Lighting.EnvironmentDiffuseScale = 0.35
    Lighting.EnvironmentSpecularScale = 0.15
end

function GraphicDisableLowGraphics()
    GraphicState.LowGraphics = false
    for obj, oldValue in pairs(GraphicParticleBackup) do
        if obj and obj.Parent then obj.Enabled = oldValue end
    end
    for obj, oldValue in pairs(GraphicTextureBackup) do
        if obj and obj.Parent then obj.Transparency = oldValue end
    end
    table.clear(GraphicParticleBackup)
    table.clear(GraphicTextureBackup)
    GraphicRestorePartShadows()
    Lighting.GlobalShadows = true
    Lighting.EnvironmentDiffuseScale = 1
    Lighting.EnvironmentSpecularScale = 1
end

function GraphicApplyFullBright()
    if GraphicState.FullBright then
        Lighting.Brightness = 3
        Lighting.ExposureCompensation = 0.25
        Lighting.Ambient = Color3.fromRGB(180,180,180)
        Lighting.OutdoorAmbient = Color3.fromRGB(200,200,200)
    else
        if GraphicState.SoftCinematic then
            GraphicApplySoftCinematic()
        elseif not GraphicState.LowGraphics then
            Lighting.Brightness = origLighting.Brightness
            Lighting.ExposureCompensation = 0
            Lighting.Ambient = origLighting.Ambient
            Lighting.OutdoorAmbient = origLighting.OutdoorAmbient
        end
    end
end

function GraphicApplyNoFog()
    if GraphicState.NoFog then
        Lighting.FogStart = 100000
        Lighting.FogEnd = 100000
    else
        Lighting.FogStart = origLighting.FogStart
        Lighting.FogEnd = origLighting.FogEnd
    end
    if GraphicState.SoftCinematic then
        GraphicApplyAtmosphereState()
    end
end

function GraphicApplyCleanSky()
    if GraphicState.CleanSky then
        for _, obj in ipairs(Lighting:GetChildren()) do
            if obj:IsA("Clouds") then
                if GraphicCloudBackup[obj] == nil then
                    GraphicCloudBackup[obj] = obj.Enabled
                end
                obj.Enabled = false
            end
        end
    else
        for obj, oldValue in pairs(GraphicCloudBackup) do
            if obj and obj.Parent then obj.Enabled = oldValue end
        end
        table.clear(GraphicCloudBackup)
    end
    if GraphicState.SoftCinematic then
        GraphicApplyAtmosphereState()
    end
end

function GraphicApplyNoParticle()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam")
           or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
            if GraphicState.NoParticle then
                if GraphicParticleBackup[obj] == nil then
                    GraphicParticleBackup[obj] = obj.Enabled
                end
                obj.Enabled = false
            else
                if GraphicParticleBackup[obj] ~= nil then
                    obj.Enabled = GraphicParticleBackup[obj]
                    GraphicParticleBackup[obj] = nil
                end
            end
        end
    end
end

function GraphicApplyGrass()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Terrain") then
            obj.Decoration = not GraphicState.NoGrass
        end
    end
end

function GraphicApplyTime()
    Lighting.ClockTime = GraphicState.Time
end

function GraphicReset()
    GraphicState.SoftCinematic = false
    GraphicState.LowGraphics = false
    GraphicState.FullBright = false
    GraphicState.NoFog = false
    GraphicState.NoAnimation = false
    GraphicState.NoParticle = false
    GraphicState.NoGrass = false
    GraphicState.CleanSky = false
    GraphicRemoveEffects()
    GraphicRestorePartShadows()
    for obj, oldValue in pairs(GraphicParticleBackup) do
        if obj and obj.Parent then obj.Enabled = oldValue end
    end
    for obj, oldValue in pairs(GraphicTextureBackup) do
        if obj and obj.Parent then obj.Transparency = oldValue end
    end
    table.clear(GraphicParticleBackup)
    table.clear(GraphicTextureBackup)
    for obj, oldValue in pairs(GraphicCloudBackup) do
        if obj and obj.Parent then obj.Enabled = oldValue end
    end
    table.clear(GraphicCloudBackup)
    Lighting.Brightness = origLighting.Brightness
    Lighting.ExposureCompensation = 0
    Lighting.ShadowSoftness = 0.2
    Lighting.Ambient = origLighting.Ambient
    Lighting.OutdoorAmbient = origLighting.OutdoorAmbient
    Lighting.GlobalShadows = true
    Lighting.EnvironmentDiffuseScale = 1
    Lighting.EnvironmentSpecularScale = 1
    Lighting.FogStart = origLighting.FogStart
    Lighting.FogEnd = origLighting.FogEnd
    GraphicState.Time = 18
    GraphicState.SelectedPreset = "Soft"
    Lighting.ClockTime = GraphicState.Time
end

-- =========================================================
-- FPS + PING GUI
-- =========================================================
fpsPingGui = nil
fpsCounter = 0
fpsLastTime = tick()
currentFPS = 0
currentPing = 0

function createFPSPingGui()
    if fpsPingGui then fpsPingGui:Destroy() end
    fpsPingGui = Instance.new("ScreenGui")
    fpsPingGui.Name = "OneWFPSPing"
    fpsPingGui.ResetOnSpawn = false
    fpsPingGui.IgnoreGuiInset = true
    fpsPingGui.DisplayOrder = 999
    fpsPingGui.Parent = PG

    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.Size = UDim2.new(0, 100, 0, 20)
    frame.Position = UDim2.new(1, -110, 0, 5)
    frame.BackgroundColor3 = Color3.fromRGB(25, 20, 8)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent = fpsPingGui
    rnd(frame, 4)
    strk(frame, C.GOLD, 1, 0.4)

    local label = Instance.new("TextLabel")
    label.Name = "StatsLabel"
    label.Size = UDim2.new(1, -6, 1, 0)
    label.Position = UDim2.new(0, 3, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = "FPS: 0 | Ping: 0"
    label.TextColor3 = C.GOLD
    label.TextSize = 10
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.TextStrokeTransparency = 0.5
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.Parent = frame
end

RunService.RenderStepped:Connect(function()
    fpsCounter = fpsCounter + 1
    if tick() - fpsLastTime >= 1 then
        currentFPS = fpsCounter
        fpsCounter = 0
        fpsLastTime = tick()
        pcall(function()
            currentPing = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if not fpsPingGui or not fpsPingGui.Parent then
            pcall(createFPSPingGui)
        end
        if fpsPingGui then
            local frame = fpsPingGui:FindFirstChild("MainFrame")
            if frame then
                local label = frame:FindFirstChild("StatsLabel")
                if label then
                    local fpsText = S.ShowFPS and tostring(currentFPS) or "OFF"
                    local pingText = S.ShowPing and (tostring(currentPing) .. "ms") or "OFF"
                    label.Text = "FPS: " .. fpsText .. " | Ping: " .. pingText
                    if currentFPS >= 50 then
                        label.TextColor3 = C.GRN
                    elseif currentFPS >= 30 then
                        label.TextColor3 = C.GOLD
                    else
                        label.TextColor3 = C.RED
                    end
                end
            end
        end
    end
end)

function updateFPSPing()
    if fpsPingGui then
        fpsPingGui:Destroy()
        fpsPingGui = nil
    end
    createFPSPingGui()
end
_G.Roooor_updateFPSPing = updateFPSPing

print("✅ [3/15] ONE W - Fungsi Utama + HD Sky + FPS/Ping + Grafik Ultra Logic")
print("🔧 Fixed: applyFullbright, applyNoFog, applyFOV, applyCrosshair, applyTrail, applyAura, applyZoomOut, applyContrast, applyUltraHD, hookVault, hitboxClearAll, hitboxCreateText, hitboxUpdateVisibility, teleportToFinishLine, spawnKillEffect")
print("🎬 Grafik Ultra: 16 preset + shadow + time + reset siap dipakai")-- =========================================================
-- SECTION 4/15 : ESP + AUTO PARRY + AIMBOT SENTER (FIXED v3)
-- =========================================================

ESPObjects = {}
StatusESP = {}
CachedSCP = {}
Cached = { Generators = {}, Windows = {}, Pallets = {} }
GeneratorColor = Color3.fromRGB(255, 170, 0)
PalletColor = Color3.fromRGB(74, 255, 181)
WindowColor = Color3.fromRGB(74, 255, 181)
SCPColor = Color3.fromRGB(255, 0, 0)

function cacheObject(obj)
    if obj.Name == "Generator" then
        Cached.Generators[obj] = true
    elseif obj.Name == "Window" then
        Cached.Windows[obj] = true
    elseif obj.Name == "Pallet" or obj.Name == "Palletwrong" then
        Cached.Pallets[obj] = true
    end
    local name = string.lower(obj.Name)
    if string.find(name, "scp") then
        CachedSCP[obj] = true
    end
end

function removeCache(obj)
    Cached.Generators[obj] = nil
    Cached.Windows[obj] = nil
    Cached.Pallets[obj] = nil
    CachedSCP[obj] = nil
    if ESPObjects[obj] then
        ESPObjects[obj]:Destroy()
        ESPObjects[obj] = nil
    end
end

for _, obj in ipairs(workspace:GetDescendants()) do cacheObject(obj) end
workspace.DescendantAdded:Connect(cacheObject)
workspace.DescendantRemoving:Connect(removeCache)

function createESP(obj, color)
    if not obj then return end
    if ESPObjects[obj] then
        if ESPObjects[obj].FillColor ~= color then
            ESPObjects[obj].FillColor = color
            ESPObjects[obj].OutlineColor = color
        end
        return
    end
    local h = Instance.new("Highlight")
    h.FillColor = color
    h.OutlineColor = color
    h.FillTransparency = 0.9
    h.OutlineTransparency = 0.3
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Parent = obj
    ESPObjects[obj] = h
    obj.AncestryChanged:Connect(function(_, parent)
        if not parent then
            if ESPObjects[obj] then
                ESPObjects[obj]:Destroy()
                ESPObjects[obj] = nil
            end
        end
    end)
end

function removeESP(obj)
    if ESPObjects[obj] then
        ESPObjects[obj]:Destroy()
        ESPObjects[obj] = nil
    end
end

function removeStatusESP(char)
    if StatusESP[char] then
        StatusESP[char]:Destroy()
        StatusESP[char] = nil
    end
end

function createStatusESP(player, char, root)
    if not ESPStatus.Enabled then
        removeStatusESP(char)
        return
    end
    if not root then return end

    local head = char:FindFirstChild("Head")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not head or not hum then return end

    local isDown = hum.Health <= 0 or hum.Health < 2
        or char:GetAttribute("Downed") == true
        or char:GetAttribute("IsDown") == true
        or char:GetAttribute("Knocked") == true

    local dist = (head.Position - root.Position).Magnitude
    if dist > ESPStatus.Radius then
        removeStatusESP(char)
        return
    end

    local text = ""
    if isDown then text = text .. "DOWN\n" end
    if ESPStatus.ShowName then text = text .. player.Name .. "\n" end
    if ESPStatus.ShowDistance then text = text .. string.format("Dist: %.0f\n", dist) end
    if ESPStatus.ShowHealth then text = text .. string.format("HP: %.0f\n", hum.Health) end
    if text == "" then
        removeStatusESP(char)
        return
    end

    local billboard = StatusESP[char]
    local teamColor = Color3.new(1, 1, 1)
    if player.Team then
        if player.Team.Name == "Killer" then
            teamColor = TeamColors.Killer
        elseif player.Team.Name == "Survivors" then
            teamColor = TeamColors.Survivor
        end
    end
    if isDown then teamColor = Color3.fromRGB(255, 0, 0) end

    local mode = S.ESPNameMode or "Text"
    local size = S.ESPNameSize or 12

    if not billboard then
        billboard = Instance.new("BillboardGui")
        billboard.Size = UDim2.new(0, 120, 0, 50)
        billboard.AlwaysOnTop = true
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.TextColor3 = teamColor
        label.TextStrokeTransparency = 0
        label.Font = Enum.Font.GothamBold
        label.TextSize = size
        label.Text = text
        label.Parent = billboard
        billboard.Adornee = head
        billboard.StudsOffset = Vector3.new(0, 2.5, 0)
        billboard.Parent = char
        StatusESP[char] = billboard
    else
        local label = billboard:FindFirstChildOfClass("TextLabel")
        if label then
            if label.Text ~= text then label.Text = text end
            if label.TextColor3 ~= teamColor then label.TextColor3 = teamColor end
            if label.TextSize ~= size then label.TextSize = size end
        end
    end
end

task.spawn(function()
    while task.wait(0.15) do
        if S.ESPNameMode == "Galaxy" then
            for char, billboard in pairs(StatusESP) do
                if not billboard or not billboard.Parent then
                    StatusESP[char] = nil
                    continue
                end
                local label = billboard:FindFirstChildOfClass("TextLabel")
                if label then
                    local grad = label:FindFirstChildOfClass("UIGradient")
                    if not grad then
                        grad = Instance.new("UIGradient")
                        grad.Parent = label
                    end
                    local t = tick()
                    grad.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromHSV((t * 0.5) % 1, 1, 1)),
                        ColorSequenceKeypoint.new(0.33, Color3.fromHSV((t * 0.5 + 0.33) % 1, 1, 1)),
                        ColorSequenceKeypoint.new(0.66, Color3.fromHSV((t * 0.5 + 0.66) % 1, 1, 1)),
                        ColorSequenceKeypoint.new(1, Color3.fromHSV((t * 0.5) % 1, 1, 1)),
                    })
                    grad.Rotation = (t * 120) % 360
                end
            end
        end
    end
end)

function GetGameValue(obj, name)
    if not obj then return nil end
    local attr = obj:GetAttribute(name)
    if attr ~= nil then return attr end
    local child = obj:FindFirstChild(name)
    if child and child:IsA("ValueBase") then
        local ok, val = pcall(function() return child.Value end)
        if ok then return val end
    end
    return nil
end

function GetGeneratorProgress(gen)
    if not gen then return 0 end
    local names = {
        "RepairProgress", "Progress", "Value", "RepairValue",
        "ProgressValue", "GenProgress", "Repaired", "Repair",
        "Percent", "Percentage", "RepairPercent"
    }
    for _, n in ipairs(names) do
        local v = GetGameValue(gen, n)
        if v ~= nil and type(v) == "number" then return v end
    end
    for _, d in ipairs(gen:GetDescendants()) do
        if d:IsA("ValueBase") then
            local ln = string.lower(d.Name)
            if ln:find("progress") or ln:find("repair")
               or ln:find("percent") or ln:find("value") then
                local ok, val = pcall(function() return d.Value end)
                if ok and type(val) == "number" then return val end
            end
        end
    end
    for _, attrName in ipairs(gen:GetAttributes()) do
        local v = gen:GetAttribute(attrName)
        if type(v) == "number" and v >= 0 and v <= 100 then
            local lower = string.lower(attrName)
            if lower:find("progress") or lower:find("repair")
               or lower:find("value") or lower:find("percent") then
                return v
            end
        end
    end
    return 0
end

function ApplyGenHighlight(object, color)
    if not object then return end
    local h = object:FindFirstChild("GenHighlight") or Instance.new("Highlight")
    h.Name = "GenHighlight"
    h.Adornee = object
    h.FillColor = color
    h.OutlineColor = color
    h.FillTransparency = 0.9
    h.OutlineTransparency = 0.3
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Parent = object
end

function UpdateGenerator(generator)
    if not generator or not generator.Parent then return end

    if not ESP.Generator then
        local a = generator:FindFirstChild("GenESP")
        if a then a:Destroy() end
        local b = generator:FindFirstChild("GenESPBar")
        if b then b:Destroy() end
        local h = generator:FindFirstChild("GenHighlight")
        if h then h:Destroy() end
        return
    end

    local percent = GetGeneratorProgress(generator)
    local cp = math.clamp(percent, 0, 100)

    if S.ESPGenMode == "Classic" then
        local oldBar = generator:FindFirstChild("GenESPBar")
        if oldBar then oldBar:Destroy() end

        if percent >= 100 then
            local old = generator:FindFirstChild("GenESP")
            if old then old:Destroy() end
            local h = generator:FindFirstChild("GenHighlight")
            if h then h:Destroy() end
            return
        end

        local color = GeneratorColor:Lerp(Color3.fromRGB(0, 255, 120), cp / 100)
        local text = string.format("[%.0f%%]", percent)

        local billboard = generator:FindFirstChild("GenESP")
        if not billboard then
            billboard = Instance.new("BillboardGui")
            billboard.Name = "GenESP"
            billboard.Size = UDim2.new(0, 100, 0, 30)
            billboard.AlwaysOnTop = true

            local label = Instance.new("TextLabel")
            label.Name = "GenLabel"
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = text
            label.TextColor3 = color
            label.TextStrokeTransparency = 0
            label.Font = Enum.Font.GothamBold
            label.TextSize = 12
            label.Parent = billboard

            billboard.Adornee = generator
            billboard.Parent = generator
        else
            local lbl2 = billboard:FindFirstChild("GenLabel")
            if lbl2 then
                lbl2.Text = text
                lbl2.TextColor3 = color
            end
        end
        ApplyGenHighlight(generator, color)

    elseif S.ESPGenMode == "Bar" then
        local oldClassic = generator:FindFirstChild("GenESP")
        if oldClassic then oldClassic:Destroy() end

        if percent >= 100 then
            local old = generator:FindFirstChild("GenESPBar")
            if old then old:Destroy() end
            local h = generator:FindFirstChild("GenHighlight")
            if h then h:Destroy() end
            return
        end

        local barSize = S.ESPGenBarSize or 64
        local barHeight = S.ESPGenBarHeight or 8
        local textSize = S.ESPGenBarTextSize or 10

        local billboard = generator:FindFirstChild("GenESPBar")
        if not billboard then
            billboard = Instance.new("BillboardGui")
            billboard.Name = "GenESPBar"
            billboard.Size = UDim2.new(0, barSize, 0, barHeight)
            billboard.AlwaysOnTop = true
            billboard.StudsOffset = Vector3.new(0, 1.5, 0)
            billboard.Adornee = generator
            billboard.Parent = generator

            local barBg = Instance.new("Frame")
            barBg.Name = "BarBg"
            barBg.Size = UDim2.new(1, 0, 1, 0)
            barBg.BackgroundColor3 = Color3.fromRGB(15, 10, 30)
            barBg.BorderSizePixel = 0
            barBg.Parent = billboard

            local bbc = Instance.new("UICorner")
            bbc.CornerRadius = UDim.new(1, 0)
            bbc.Parent = barBg

            local barFill = Instance.new("Frame")
            barFill.Name = "BarFill"
            barFill.Size = UDim2.new(0, 0, 1, 0)
            barFill.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
            barFill.BorderSizePixel = 0
            barFill.Parent = barBg

            local bfc = Instance.new("UICorner")
            bfc.CornerRadius = UDim.new(1, 0)
            bfc.Parent = barFill

            local pctText = Instance.new("TextLabel")
            pctText.Name = "PctText"
            pctText.Size = UDim2.new(1, 0, 1, 0)
            pctText.BackgroundTransparency = 1
            pctText.Text = "0%"
            pctText.TextColor3 = Color3.fromRGB(255, 255, 255)
            pctText.TextSize = textSize
            pctText.Font = Enum.Font.GothamBold
            pctText.TextXAlignment = Enum.TextXAlignment.Center
            pctText.TextYAlignment = Enum.TextYAlignment.Center
            pctText.TextStrokeTransparency = 0.2
            pctText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            pctText.ZIndex = 10
            pctText.Parent = barBg
        end

        local barBg = billboard:FindFirstChild("BarBg")
        if barBg then
            local barFill = barBg:FindFirstChild("BarFill")
            local pctText = barBg:FindFirstChild("PctText")
            if barFill then barFill.Size = UDim2.new(cp / 100, 0, 1, 0) end
            if pctText then
                pctText.Text = string.format("%.0f%%", percent)
                pctText.TextSize = textSize
            end
        end

        local color = GeneratorColor:Lerp(Color3.fromRGB(0, 255, 120), cp / 100)
        ApplyGenHighlight(generator, color)
    end
end

function UpdateMapESP(obj, root)
    if not obj or not root then return end
    local pos
    if obj:IsA("Model") then pos = obj:GetPivot().Position
    elseif obj:IsA("BasePart") then pos = obj.Position end
    if not pos then return end
    local distance = (pos - root.Position).Magnitude

    if obj.Name == "Window" then
        if ESP.Window and distance <= ESP.Distance then createESP(obj, WindowColor)
        else removeESP(obj) end
    end

    if obj.Name == "Pallet" or obj.Name == "Palletwrong" then
        if ESP.Pallet and distance <= ESP.Distance then createESP(obj, PalletColor)
        else removeESP(obj) end
    end
end

function UpdateSCPEsp(root)
    if not ESP.SCP then
        for obj in pairs(CachedSCP) do removeESP(obj) end
        return
    end
    for obj in pairs(CachedSCP) do
        if obj and obj.Parent then
            local pos
            if obj:IsA("Model") then pos = obj:GetPivot().Position
            elseif obj:IsA("BasePart") then pos = obj.Position end
            if pos then
                local dist = (pos - root.Position).Magnitude
                if dist <= ESP.Distance then createESP(obj, SCPColor)
                else removeESP(obj) end
            end
        end
    end
end

-- =========================================================
-- AUTO PARRY
-- =========================================================
AP_parryCount = 0
AP_hookedKillers = _G.AP_HookedKillers or {}
_G.AP_HookedKillers = AP_hookedKillers

AP_Config = {
    Debounce = 0.02,
    Radius = 20,
    FaceSensitivity = 0.2,
}

local function AP_GetKillerType(char, player)
    local charName = string.lower(char.Name)
    local displayName = string.lower(player and player.DisplayName or "")
    local isHidden = charName:find("hidden") or displayName:find("hidden") or charName:find("617") or displayName:find("617")
    local isAbyss = charName:find("abyss") or displayName:find("abyss") or charName:find("walker") or displayName:find("walker")
    local isMasked = charName:find("masked") or displayName:find("masked") or charName:find("jacket") or displayName:find("jacket")
    return isHidden, isAbyss, isMasked
end

local function AP_ShouldParry(char, player, killerRoot, myRoot, dist)
    local isHidden, isAbyss, isMasked = AP_GetKillerType(char, player)
    local velocity = killerRoot.AssemblyLinearVelocity
    local toMe = (myRoot.Position - killerRoot.Position).Unit
    local killerLook = killerRoot.CFrame.LookVector
    local faceDot = killerLook:Dot(toMe)
    
    if isHidden then
        if velocity.Magnitude > 20 or dist > 10 then return false, "HIDDEN MARK"
        else return true, "HIDDEN BASIC" end
    end
    if isAbyss then
        if velocity.Magnitude < 20 and dist < 12 and faceDot > 0.3 then return true, "ABYSS SLASH" end
        return false, nil
    end
    if isMasked then
        if velocity.Magnitude > 15 and dist < 15 then return true, "MASKED CHAINSAW" end
        return false, nil
    end
    if velocity.Magnitude < 25 and dist < 12 and faceDot > 0.2 then return true, "BASIC ATTACK" end
    return false, nil
end

local _AP_lastParry = 0
local function AP_TryParry(reason)
    local now = tick()
    local bypass = reason == "BASIC ATTACK" or reason == "ABYSS SLASH" or reason == "MASKED CHAINSAW" or reason == "HIDDEN BASIC" or reason == "PREDICTIVE"
    local debounce = bypass and 0.015 or AP_Config.Debounce
    if now - _AP_lastParry > debounce then
        _AP_lastParry = now
        AP_PressParryButton()
        AP_parryCount = AP_parryCount + 1
        return true
    end
    return false
end

function AP_GetParryButton()
    local current = PG
    for segment in string.gmatch("Survivor-mob.Controls.Gui-mob", "[^%.]+") do
        current = current and current:FindFirstChild(segment)
    end
    return current
end

function AP_FindParryButton()
    local btn = AP_GetParryButton()
    if btn and btn:IsA("GuiObject") and btn.Visible then return btn end
    for _, obj in pairs(PG:GetDescendants()) do
        if obj:IsA("GuiObject") and obj.Visible then
            local n = string.lower(obj.Name)
            if n:find("parry") or n:find("block") or n:find("guard") then
                return obj
            end
        end
    end
    return nil
end

function AP_PressRightClick()
    VirtualInputManager:SendMouseButtonEvent(0, 0, 1, true, game, 0)
    task.wait(0.001)
    VirtualInputManager:SendMouseButtonEvent(0, 0, 1, false, game, 0)
end

function AP_PressParryButton()
    for i = 1, 2 do
        AP_PressRightClick()
        task.wait(0.001)
    end
    
    if UIS.TouchEnabled then
        local btn = AP_FindParryButton()
        if btn and btn:IsA("GuiObject") then
            local pos = btn.AbsolutePosition
            local size = btn.AbsoluteSize
            local inset = GuiService:GetGuiInset()
            local x = pos.X + size.X / 2 + inset.X
            local y = pos.Y + size.Y / 2 + inset.Y
            for i = 1, 2 do
                VirtualInputManager:SendTouchEvent(8823 + i, 0, x, y)
                task.wait(0.001)
                VirtualInputManager:SendTouchEvent(8823 + i, 2, x, y)
                task.wait(0.001)
            end
        end
    end
end

function AP_HookKiller(char)
    if AP_hookedKillers[char] then return end
    AP_hookedKillers[char] = true
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local animator = hum:FindFirstChildOfClass("Animator")
    if not animator then return end
    animator.AnimationPlayed:Connect(function(track)
        if not AutoParry.Enabled then return end
        local a = track.Animation
        if not a or not a.AnimationId then return end
        local id = a.AnimationId:match("%d+")
        if not id then return end
        if SkipAnims and SkipAnims[id] then return end
        if not KillerAnims["rbxassetid://" .. id] then return end
        local myRoot = getRoot()
        local killerRoot = char:FindFirstChild("HumanoidRootPart")
        if not myRoot or not killerRoot then return end
        local dist = (killerRoot.Position - myRoot.Position).Magnitude
        if dist > AP_Config.Radius then return end
        local player = Players:GetPlayerFromCharacter(char)
        local shouldParry, reason = AP_ShouldParry(char, player, killerRoot, myRoot, dist)
        if shouldParry then AP_TryParry(reason) end
    end)
end

for _, p in pairs(Players:GetPlayers()) do
    if p ~= LP and p.Character and p.Team and p.Team.Name == "Killer" then
        task.spawn(function() AP_HookKiller(p.Character) end)
    end
    p.CharacterAdded:Connect(function(c)
        task.wait(1)
        if p.Team and p.Team.Name == "Killer" then AP_HookKiller(c) end
    end)
end

Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function(c)
        task.wait(1)
        if p.Team and p.Team.Name == "Killer" then AP_HookKiller(c) end
    end)
end)

task.spawn(function()
    while task.wait(0.001) do
        if not AutoParry.Enabled then continue end
        local myRoot = getRoot()
        if not myRoot then continue end
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Team and p.Team.Name == "Killer" then
                local killerRoot = p.Character:FindFirstChild("HumanoidRootPart")
                local killerHum = p.Character:FindFirstChildOfClass("Humanoid")
                if killerRoot and killerHum and killerHum.Health > 0 then
                    local dist = (killerRoot.Position - myRoot.Position).Magnitude
                    if dist <= AP_Config.Radius then
                        local isAttacking = false
                        local skipReason = nil
                        local animator = killerHum:FindFirstChildOfClass("Animator")
                        if animator then
                            for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                                local a = track.Animation
                                if a and a.AnimationId then
                                    local id = a.AnimationId:match("%d+")
                                    if SkipAnims and SkipAnims[id] then skipReason = SkipAnims[id] end
                                    if KillerAnims["rbxassetid://" .. id] and (not SkipAnims or not SkipAnims[id]) then isAttacking = true end
                                end
                            end
                        end
                        if skipReason then continue end
                        local velocity = killerRoot.AssemblyLinearVelocity
                        local prevVelocity = p.Character:GetAttribute("LastVelocity") or 0
                        p.Character:SetAttribute("LastVelocity", velocity.Magnitude)
                        local velocitySpike = math.abs(velocity.Magnitude - prevVelocity) > 6
                        if isAttacking or velocitySpike then
                            local shouldParry, reason = AP_ShouldParry(p.Character, p, killerRoot, myRoot, dist)
                            if velocitySpike and not reason then
                                reason = "PREDICTIVE"
                                shouldParry = true
                            end
                            if shouldParry then AP_TryParry(reason) end
                        end
                    end
                end
            end
        end
    end
end)

-- =========================================================
-- AIMBOT SENTER - FIXED v3 (HOLD ONLY, GAK NYANGKUT)
-- =========================================================
AimbotLaserGui = nil
AimbotLaserLines = {}

local function CreateLaserGui()
    if AimbotLaserGui then AimbotLaserGui:Destroy() end
    AimbotLaserGui = Instance.new("ScreenGui")
    AimbotLaserGui.Name = "OneWAimbotLaser"
    AimbotLaserGui.ResetOnSpawn = false
    AimbotLaserGui.IgnoreGuiInset = true
    AimbotLaserGui.Parent = PG
end
CreateLaserGui()

-- Helper: cek apakah player ini killer (team + fallback nama)
function AimbotSenter_IsKiller(p)
    if not p or not p.Character then return false end
    if p.Team and p.Team.Name == "Killer" then return true end
    local charName = string.lower(p.Character.Name)
    local dispName = string.lower(p.DisplayName or "")
    local killerTags = {"killer", "hidden", "abyss", "walker", "masked", "jacket", "617", "jason", "hunter"}
    for _, tag in ipairs(killerTags) do
        if charName:find(tag) or dispName:find(tag) then return true end
    end
    return false
end

-- Scan tombol senter
function ScanSenterButtons()
    local buttons = {}
    for _, obj in pairs(PG:GetDescendants()) do
        if obj:IsA("GuiObject") and obj.Visible then
            local n = string.lower(obj.Name)
            if n:find("flashlight") or n:find("senter") or n:find("light")
               or n:find("torch") or n:find("flash")
               or n:find("dagger") or n:find("knife") or n:find("blade") then
                table.insert(buttons, obj)
            end
        end
    end
    return buttons
end

-- RESET STATE PAS EXECUTE
AimbotSenter.HoldingSenter = false
AimbotSenter.CurrentTarget = nil
AimbotSenter._Hooked = {}

function HookSenterButtons()
    local buttons = ScanSenterButtons()
    for _, obj in ipairs(buttons) do
        if AimbotSenter._Hooked[obj] then continue end
        AimbotSenter._Hooked[obj] = true

        obj.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
               or input.UserInputType == Enum.UserInputType.Touch then
                AimbotSenter.HoldingSenter = true
            end
        end)

        obj.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
               or input.UserInputType == Enum.UserInputType.Touch then
                AimbotSenter.HoldingSenter = false
                AimbotSenter.CurrentTarget = nil
            end
        end)

        obj.MouseLeave:Connect(function()
            AimbotSenter.HoldingSenter = false
            AimbotSenter.CurrentTarget = nil
        end)
    end
end

-- FIX: cek apakah mouse/jari MASIH nempel
local function IsSenterStillPressed()
    -- Kalau touch device → cek jari masih nempel
    if UIS.TouchEnabled then
        local touches = UIS:GetTouches()
        if #touches == 0 then
            -- Fallback: cek mouse button juga
            local mouseDown = false
            pcall(function()
                mouseDown = UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
            end)
            return mouseDown
        end
        return true
    end
    -- Kalau PC → cek mouse button
    local mouseDown = false
    pcall(function()
        mouseDown = UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
    end)
    return mouseDown
end

-- LOOP UTAMA
task.spawn(function()
    while task.wait(0.01) do
        -- FIX: PAKSA RESET kalau fitur OFF
        if not AimbotSenter.Enabled then
            AimbotSenter.HoldingSenter = false
            AimbotSenter.CurrentTarget = nil
            if AimbotLaserGui then
                for _, line in pairs(AimbotLaserLines) do
                    if line then line:Remove() end
                end
                AimbotLaserLines = {}
            end
            continue
        end

        -- FIX: AUTO RESET kalau mouse/jari udah gak nempel
        if AimbotSenter.HoldingSenter then
            if not IsSenterStillPressed() then
                AimbotSenter.HoldingSenter = false
                AimbotSenter.CurrentTarget = nil
            end
        end

        if not AimbotSenter.HoldingSenter then
            AimbotSenter.CurrentTarget = nil
            if AimbotLaserGui then
                for _, line in pairs(AimbotLaserLines) do
                    if line then line:Remove() end
                end
                AimbotLaserLines = {}
            end
            continue
        end

        local myRoot = getRoot()
        if not myRoot then continue end

        -- Cari killer terdekat
        local closest = nil
        local shortest = math.huge
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and AimbotSenter_IsKiller(p) then
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                local targetPart = p.Character:FindFirstChild(AimbotSenter.LockPart or "Head")
                if hum and hum.Health > 0 and targetPart then
                    local dist = (targetPart.Position - myRoot.Position).Magnitude
                    if dist < shortest then
                        shortest = dist
                        closest = targetPart
                    end
                end
            end
        end

        if not closest then
            AimbotSenter.CurrentTarget = nil
            if AimbotLaserGui then
                for _, line in pairs(AimbotLaserLines) do
                    if line then line:Remove() end
                end
                AimbotLaserLines = {}
            end
            continue
        end

        AimbotSenter.CurrentTarget = closest

        -- INSTANT LOCK (langsung set CFrame)
        local cam = workspace.CurrentCamera
        if cam then
            local camPos = cam.CFrame.Position
            local targetPos = closest.Position
            cam.CFrame = CFrame.new(camPos, targetPos)
        end

        -- Laser
        if AimbotSenter.ShowLaser then
            local cam2 = workspace.CurrentCamera
            local screenPoint, onScreen = cam2:WorldToViewportPoint(closest.Position)
            if onScreen then
                if AimbotLaserGui then
                    for _, line in pairs(AimbotLaserLines) do
                        if line then line:Remove() end
                    end
                    AimbotLaserLines = {}
                end
                local centerX = cam2.ViewportSize.X / 2
                local centerY = cam2.ViewportSize.Y / 2
                local line = Drawing.new("Line")
                line.Visible = true
                line.From = Vector2.new(centerX, centerY)
                line.To = Vector2.new(screenPoint.X, screenPoint.Y)
                line.Color = AimbotSenter.LaserColor or Color3.fromRGB(255, 210, 80)
                line.Thickness = 2
                line.Transparency = 0.5
                table.insert(AimbotLaserLines, line)
            end
        end
    end
end)

task.spawn(function()
    while task.wait(2) do
        if AimbotSenter.Enabled then
            pcall(HookSenterButtons)
        end
    end
end)

-- =========================================================
-- AP CIRCLE
-- =========================================================
AP_parryCirclePart = nil
AP_parryCircleAttachments = {}
AP_parryCircleBeams = {}

function AP_ClearCircle()
    if AP_parryCirclePart then
        AP_parryCirclePart:Destroy()
        AP_parryCirclePart = nil
    end
    AP_parryCircleAttachments = {}
    AP_parryCircleBeams = {}
end

function AP_CreateCircle()
    AP_ClearCircle()
    AP_parryCirclePart = Instance.new("Part")
    AP_parryCirclePart.Name = "AP_ParryRingBeam"
    AP_parryCirclePart.Anchored = true
    AP_parryCirclePart.CanCollide = false
    AP_parryCirclePart.CanQuery = false
    AP_parryCirclePart.CanTouch = false
    AP_parryCirclePart.Transparency = 1
    AP_parryCirclePart.Size = Vector3.new(1, 0.1, 1)
    AP_parryCirclePart.Parent = workspace

    local segments = AP_ESPCircle.Segments
    for i = 1, segments do
        local angle = (i / segments) * math.pi * 2
        local att = Instance.new("Attachment")
        att.Position = Vector3.new(math.cos(angle), 0, math.sin(angle))
        att.Parent = AP_parryCirclePart
        table.insert(AP_parryCircleAttachments, att)
    end
    for i = 1, segments do
        local attA = AP_parryCircleAttachments[i]
        local attB = AP_parryCircleAttachments[(i % segments) + 1]
        local beam = Instance.new("Beam")
        beam.Attachment0 = attA
        beam.Attachment1 = attB
        beam.Width0 = AP_ESPCircle.Thickness
        beam.Width1 = AP_ESPCircle.Thickness
        beam.FaceCamera = true
        beam.LightEmission = 1
        beam.LightInfluence = 0
        beam.Segments = 1
        beam.Transparency = NumberSequence.new(0)
        beam.Color = ColorSequence.new(AP_ESPCircle.ColorNormal)
        beam.Parent = AP_parryCirclePart
        table.insert(AP_parryCircleBeams, beam)
    end
end

function AP_UpdateCircle()
    local root = getRoot()
    if not AP_ESPCircle.Enabled or not root then
        if AP_parryCirclePart then AP_ClearCircle() end
        return
    end
    if not AP_parryCirclePart or not AP_parryCirclePart.Parent then
        AP_CreateCircle()
    end

    local radius = AutoParry.ParryDistance
    local myPos = root.Position
    local yOffset = AP_ESPCircle.YOffset

    local killerInside = false
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Team and p.Team.Name == "Killer" then
            local eRoot = p.Character:FindFirstChild("HumanoidRootPart")
            if eRoot then
                local dist = (eRoot.Position - myPos).Magnitude
                if dist <= radius then
                    killerInside = true
                    break
                end
            end
        end
    end

    local ringColor = killerInside and AP_ESPCircle.ColorDanger or AP_ESPCircle.ColorNormal
    AP_parryCirclePart.Position = Vector3.new(myPos.X, myPos.Y + yOffset, myPos.Z)

    for i, att in ipairs(AP_parryCircleAttachments) do
        local angle = (i / AP_ESPCircle.Segments) * math.pi * 2
        att.Position = Vector3.new(math.cos(angle) * radius, 0, math.sin(angle) * radius)
    end
    for _, beam in ipairs(AP_parryCircleBeams) do
        beam.Width0 = AP_ESPCircle.Thickness
        beam.Width1 = AP_ESPCircle.Thickness
        beam.Color = ColorSequence.new(ringColor)
        beam.Transparency = NumberSequence.new(0)
    end
end

print("✅ [4/15] ONE W - ESP + Auto Parry + Aimbot Senter FIXED v3")
print("🔦 Aimbot Senter: HOLD = INSTANT LOCK | LEPAS = BEBAS (GAK NYANGKUT)")-- =========================================================
-- SECTION 5/15 : FITUR AKTIF + LOOP UTAMA
-- =========================================================

RunService.RenderStepped:Connect(function()
    if AutoParry.Enabled then
        pcall(AP_UpdateCircle)
    end

    if S.FOVEnabled then
        local cam = workspace.CurrentCamera
        if cam and math.abs(cam.FieldOfView - S.FOV) > 0.5 then
            pcall(function() cam.FieldOfView = S.FOV end)
        end
    end

    if Moonwalk.Enabled and not ParryActive and not mwIsDowned() then
        local char = LP.Character
        if char and char.Parent then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local cam = workspace.CurrentCamera
            if humanoid and hrp and cam then
                if Moonwalk.UseSlow and humanoid.WalkSpeed ~= Moonwalk.SlowSpeed then
                    humanoid.WalkSpeed = Moonwalk.SlowSpeed
                end
                local look = cam.CFrame.LookVector
                local flatLook = Vector3.new(look.X, 0, look.Z)
                if flatLook.Magnitude > 0 then
                    flatLook = flatLook.Unit
                    local baseCF = CFrame.new(hrp.Position, hrp.Position + flatLook)
                    local angle = math.sin(tick() * Moonwalk.SpamSpeed) * Moonwalk.Intensity
                    hrp.CFrame = baseCF * CFrame.Angles(0, math.rad(angle), 0)
                    humanoid:Move(Vector3.new(0, 0, 1), true)
                end
            end
        end
    end
end)

-- MOONWALK
function mwIsDowned()
    local char = LP.Character
    if not char then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return false end
    return hum.Health <= 0 or hum.Health < 2
end

function mwResetSpeed()
    local char = LP.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = 16 end
end

function setMoonwalk(state)
    if Moonwalk.Locked and state ~= Moonwalk.Enabled then
        return false
    end
    Moonwalk.Enabled = state
    if not state then mwResetSpeed() end
    return true
end

if PG:FindFirstChild("MW_BottomBtn") then
    PG.MW_BottomBtn:Destroy()
end

mwBtnGui = Instance.new("ScreenGui")
mwBtnGui.Name = "MW_BottomBtn"
mwBtnGui.ResetOnSpawn = false
mwBtnGui.IgnoreGuiInset = true
mwBtnGui.Parent = PG

mwBtn = Instance.new("TextButton")
mwBtn.Size = UDim2.fromOffset(60, 60)
mwBtn.Position = UDim2.new(0, 20, 1, -100)
mwBtn.BackgroundColor3 = Color3.fromRGB(40, 32, 12)
mwBtn.Text = "MW"
mwBtn.TextColor3 = Color3.new(1, 1, 1)
mwBtn.TextSize = 16
mwBtn.Font = Enum.Font.GothamBlack
mwBtn.AutoButtonColor = false
mwBtn.Active = true
mwBtn.Draggable = true
mwBtn.Parent = mwBtnGui

local mwBtnCorner = Instance.new("UICorner")
mwBtnCorner.CornerRadius = UDim.new(1, 0)
mwBtnCorner.Parent = mwBtn

local mwBtnStroke = Instance.new("UIStroke")
mwBtnStroke.Thickness = 2
mwBtnStroke.Color = Color3.fromRGB(255, 210, 80)
mwBtnStroke.Transparency = 0.5
mwBtnStroke.Parent = mwBtn

mwLockBtn = Instance.new("TextButton")
mwLockBtn.Size = UDim2.fromOffset(60, 22)
mwLockBtn.Position = UDim2.new(0, 20, 1, -128)
mwLockBtn.BackgroundColor3 = Color3.fromRGB(55, 45, 18)
mwLockBtn.Text = "UNLOCK"
mwLockBtn.TextColor3 = Color3.new(1, 1, 1)
mwLockBtn.TextSize = 10
mwLockBtn.Font = Enum.Font.GothamBold
mwLockBtn.AutoButtonColor = false
mwLockBtn.Parent = mwBtnGui

local mwLockCorner = Instance.new("UICorner")
mwLockCorner.CornerRadius = UDim.new(1, 0)
mwLockCorner.Parent = mwLockBtn

local mwLockStroke = Instance.new("UIStroke")
mwLockStroke.Thickness = 1.5
mwLockStroke.Color = Color3.fromRGB(255, 210, 80)
mwLockStroke.Transparency = 0.5
mwLockStroke.Parent = mwLockBtn

function mwBtnUpdateUI()
    if Moonwalk.Enabled then
        mwBtn.Text = "MW ON"
        mwBtnStroke.Color = Color3.fromRGB(255, 240, 160)
        mwBtn.BackgroundColor3 = Color3.fromRGB(150, 110, 20)
    else
        mwBtn.Text = "MW"
        mwBtnStroke.Color = Color3.fromRGB(255, 210, 80)
        mwBtn.BackgroundColor3 = Color3.fromRGB(40, 32, 12)
    end
    if Moonwalk.Locked then
        mwLockBtn.Text = "LOCKED"
        mwLockBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    else
        mwLockBtn.Text = "UNLOCK"
        mwLockBtn.BackgroundColor3 = Color3.fromRGB(55, 45, 18)
    end
end

mwBtn.MouseButton1Click:Connect(function()
    if Moonwalk.Locked then
        mwBtn.Text = "X"
        task.delay(0.8, mwBtnUpdateUI)
        return
    end
    setMoonwalk(not Moonwalk.Enabled)
    mwBtnUpdateUI()
end)

mwLockBtn.MouseButton1Click:Connect(function()
    Moonwalk.Locked = not Moonwalk.Locked
    mwBtnUpdateUI()
end)

mwBtnUpdateUI()
_G.Roooor_setMoonwalk = setMoonwalk
_G.Roooor_mwBtnUpdateUI = mwBtnUpdateUI

-- SKILL CHECK
function pressSpace()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
    task.wait()
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
end

TouchID = 8822
ActionPath = "Survivor-mob.Controls.action.check"
SkillHeartbeat = nil
busy = false

function GetActionTarget()
    local current = PG
    for segment in string.gmatch(ActionPath, "[^%.]+") do
        current = current and current:FindFirstChild(segment)
    end
    return current
end

function TriggerMobileButton()
    local b = GetActionTarget()
    if b and b:IsA("GuiObject") then
        local p, s, i = b.AbsolutePosition, b.AbsoluteSize, GuiService:GetGuiInset()
        local cx, cy = p.X + (s.X/2) + i.X, p.Y + (s.Y/2) + i.Y
        pcall(function()
            VirtualInputManager:SendTouchEvent(TouchID, 0, cx, cy)
            task.wait(0.01)
            VirtualInputManager:SendTouchEvent(TouchID, 2, cx, cy)
        end)
    end
end

function startSkillCheck()
    if SkillHeartbeat then SkillHeartbeat:Disconnect() end
    SkillHeartbeat = RunService.RenderStepped:Connect(function()
        if not SkillCheck.Enabled or busy then return end
        local prompt = PG:FindFirstChild("SkillCheckPromptGui")
        if not prompt then return end
        local check = prompt:FindFirstChild("Check")
        if not check or not check.Visible then return end
        local line = check:FindFirstChild("Line")
        local goal = check:FindFirstChild("Goal")
        if not line or not goal then return end
        local lr = line.Rotation % 360
        local gr = goal.Rotation % 360

        if SkillCheck.Mode == "Instant" then
            local targetRot = (gr + 109) % 360
            pcall(function() line.Rotation = targetRot end)
            busy = true
            task.spawn(function()
                if UIS.TouchEnabled then TriggerMobileButton() else pressSpace() end
                SkillCheck.Success += 1
                SkillCheck.Total += 1
                task.wait(0.05)
                busy = false
            end)
            return
        end

        if SkillCheck.Mode == "Perfect" then
            local startRange = (gr + 102) % 360
            local endRange   = (gr + 116) % 360
            local success = (startRange > endRange and (lr >= startRange or lr <= endRange)) or (lr >= startRange and lr <= endRange)
            if success then
                busy = true
                task.spawn(function()
                    if UIS.TouchEnabled then TriggerMobileButton() else pressSpace() end
                    SkillCheck.Success += 1
                    SkillCheck.Total += 1
                    task.wait(0.05)
                    busy = false
                end)
            end
            return
        end
    end)
end

task.spawn(function()
    task.wait(1)
    if SkillCheck.Enabled then startSkillCheck() end
end)

-- INSTANT INTERACT
task.spawn(function()
    while task.wait(0.3) do
        if S.InstantInteract and LP.Character then
            local myRoot = getRoot()
            if myRoot then
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") then
                        local parent = obj.Parent
                        local pos
                        if parent:IsA("BasePart") then pos = parent.Position
                        elseif parent:IsA("Model") then pos = parent:GetPivot().Position end
                        if pos and (pos - myRoot.Position).Magnitude <= 12 then
                            pcall(function()
                                obj:InputHoldBegin()
                                task.wait(0.05)
                                obj:InputHoldEnd()
                            end)
                        end
                    end
                end
            end
        end
    end
end)

-- SPEED HACK
task.spawn(function()
    while task.wait(0.2) do
        if S.SpeedHack and LP.Character then
            local hum = LP.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.WalkSpeed ~= S.SpeedHackVal then
                hum.WalkSpeed = S.SpeedHackVal
            end
        end
    end
end)

-- WALK SPEED
task.spawn(function()
    while task.wait(0.2) do
        if S.WalkSpeed and not S.SpeedHack and LP.Character then
            local hum = LP.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                local target = S.WalkSpeedVal + (S.WalkSpeedBoost or 0)
                if hum.WalkSpeed ~= target then
                    hum.WalkSpeed = target
                end
            end
        end
    end
end)

-- ANTI AFK
task.spawn(function()
    while task.wait(120) do
        if S.AntiAFK then
            pcall(function()
                local VirtualUser = game:GetService("VirtualUser")
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end
    end
end)

-- KILL FEED
killFeedGui = Instance.new("ScreenGui")
killFeedGui.Name = "OneWKillFeed"
killFeedGui.ResetOnSpawn = false
killFeedGui.IgnoreGuiInset = true
killFeedGui.Parent = PG

local killFeedFrame = Instance.new("Frame")
killFeedFrame.Size = UDim2.new(0, 250, 0, 200)
killFeedFrame.Position = UDim2.new(1, -260, 0, 50)
killFeedFrame.BackgroundTransparency = 1
killFeedFrame.Parent = killFeedGui

local killFeedLayout = Instance.new("UIListLayout")
killFeedLayout.Padding = UDim.new(0, 4)
killFeedLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
killFeedLayout.Parent = killFeedFrame

function addKillFeed(killerName, survivorName)
    if not S.KillFeed then return end
    local entry = Instance.new("Frame")
    entry.Size = UDim2.new(1, 0, 0, 28)
    entry.BackgroundColor3 = Color3.fromRGB(55, 45, 18)
    entry.BackgroundTransparency = 0.2
    entry.BorderSizePixel = 0
    entry.Parent = killFeedFrame
    rnd(entry, 6)
    strk(entry, C.GOLD, 1, 0.5)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -10, 1, 0)
    lbl.Position = UDim2.new(0, 5, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = killerName .. " > " .. survivorName
    lbl.TextColor3 = Color3.fromRGB(255, 230, 160)
    lbl.TextSize = 11
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = entry

    task.spawn(function()
        task.wait(4)
        TweenService:Create(entry, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
        TweenService:Create(lbl, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
        task.wait(0.6)
        entry:Destroy()
    end)
end

task.spawn(function()
    local lastHealth = {}
    while task.wait(0.5) do
        if not S.KillFeed then continue end
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character then
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                if hum then
                    local prevHP = lastHealth[p] or hum.Health
                    if prevHP > 0 and hum.Health <= 0 then
                        local killerName = "???"
                        if p:GetAttribute("LastAttacker") then
                            killerName = p:GetAttribute("LastAttacker")
                        end
                        addKillFeed(killerName, p.Name)
                    end
                    lastHealth[p] = hum.Health
                end
            end
        end
    end
end)

-- STUN NOTIFY
stunIcons = {}

function createStunIcon(killerChar)
    if stunIcons[killerChar] then return stunIcons[killerChar] end
    local head = killerChar:FindFirstChild("Head")
    if not head then return end
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "OneWStunIcon"
    billboard.Size = UDim2.new(0, 60, 0, 60)
    billboard.AlwaysOnTop = true
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.Adornee = head
    billboard.Parent = head
    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(1, 0, 1, 0)
    icon.BackgroundTransparency = 1
    icon.Text = "STUN"
    icon.TextColor3 = Color3.fromRGB(255, 230, 160)
    icon.TextSize = 20
    icon.Font = Enum.Font.GothamBlack
    icon.TextStrokeTransparency = 0
    icon.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    icon.Parent = billboard
    task.spawn(function()
        while billboard.Parent do
            billboard.StudsOffset = Vector3.new(0, 4 + math.sin(tick() * 5) * 0.5, 0)
            icon.Rotation = math.sin(tick() * 8) * 20
            task.wait(0.08)
        end
    end)
    stunIcons[killerChar] = billboard
    return billboard
end

function removeStunIcon(killerChar)
    if stunIcons[killerChar] then
        stunIcons[killerChar]:Destroy()
        stunIcons[killerChar] = nil
    end
end

task.spawn(function()
    while task.wait(0.3) do
        if not S.StunNotify then continue end
        local myRoot = getRoot()
        if not myRoot then continue end
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Team and p.Team.Name == "Killer" then
                local krp = p.Character:FindFirstChild("HumanoidRootPart")
                if krp then
                    local dist = (krp.Position - myRoot.Position).Magnitude
                    if dist <= 80 then
                        local isStunned = false
                        local khum = p.Character:FindFirstChildOfClass("Humanoid")
                        if khum then
                            local animator = khum:FindFirstChildOfClass("Animator")
                            if animator then
                                for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                                    local a = track.Animation
                                    if a and a.AnimationId then
                                        local id = a.AnimationId:match("%d+")
                                        if id == "123047897844134" then
                                            isStunned = true
                                            break
                                        end
                                    end
                                end
                            end
                        end
                        if isStunned then createStunIcon(p.Character)
                        else removeStunIcon(p.Character) end
                    else
                        removeStunIcon(p.Character)
                    end
                end
            end
        end
    end
end)

-- KILLER AUTO ATTACK
lastAtk = 0
task.spawn(function()
    while task.wait(0.2) do
        if S.Killer_AutoAtk then
            local now = tick()
            if now - lastAtk >= (S.Killer_AtkDelay or 0.35) then
                lastAtk = now
                pcall(function()
                    local r = ReplicatedStorage:FindFirstChild("Remotes")
                    if r then
                        local a = r:FindFirstChild("Attacks")
                        if a then
                            local atk = a:FindFirstChild("BasicAttack")
                            if atk then atk:FireServer(false) end
                        end
                    end
                end)
            end
        end
    end
end)

-- AUTO WIGGLE
task.spawn(function()
    while task.wait(1) do
        if not AutoParry.Wiggle then continue end
        local char = LP.Character
        if not char then continue end
        local carried = (char:FindFirstChild("IsCarried") and char.IsCarried.Value)
            or (char:FindFirstChild("IsCarrying") and char.IsCarrying.Value)
        if not carried then continue end
        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
        if not remotes then continue end
        local carry = remotes:FindFirstChild("Carry")
        if not carry then continue end
        local event = carry:FindFirstChild("SelfUnHookEvent")
        if not event then continue end
        for i = 1, (AutoParry.WiggleSpam or 5) do
            pcall(function() event:FireServer() end)
        end
    end
end)

-- AUTO FLEE
function GetNearestKillerForFlee()
    local root = getRoot()
    if not root then return nil, math.huge end
    local closest, shortest = nil, math.huge
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP and plr.Team and plr.Team.Name == "Killer" and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local dist = (hrp.Position - root.Position).Magnitude
                if dist < shortest then
                    shortest = dist
                    closest = hrp
                end
            end
        end
    end
    return closest, shortest
end

task.spawn(function()
    while task.wait(0.2) do
        if not AutoFlee.Enabled then continue end
        local root = getRoot()
        if not root then continue end
        local killerRoot, distance = GetNearestKillerForFlee()
        if killerRoot and distance <= AutoFlee.DetectDistance
           and tick() - AutoFlee.LastFlee > AutoFlee.Cooldown then
            local point = nil
            local farthest = 0
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and string.match(obj.Name, "^GeneratorPoint%d+$") then
                    local d = (obj.Position - killerRoot.Position).Magnitude
                    if d > farthest then
                        farthest = d
                        point = obj
                    end
                end
            end
            if point then
                AutoFlee.LastFlee = tick()
                pcall(function()
                    root.CFrame = point.CFrame + Vector3.new(0, 5, 0)
                end)
            end
        end
    end
end)

-- FPS BOOST
local ScreenEffectTypes = {
    "ColorCorrectionEffect", "DepthOfFieldEffect", "BlurEffect",
    "SunRaysEffect", "BloomEffect"
}
DisabledEffects = {}

function applyNoScreenEffects()
    if S.NoScreenEffects then
        for _, v in pairs(Lighting:GetChildren()) do
            for _, t in pairs(ScreenEffectTypes) do
                if v:IsA(t) and v.Name ~= "OneWGraphic_Bloom" and v.Name ~= "OneWGraphic_ColorCorrection"
                   and v.Name ~= "OneWGraphic_SunRays" and v.Name ~= "OneWGraphic_DOF" then
                    DisabledEffects[v] = v.Enabled
                    v.Enabled = false
                end
            end
        end
    else
        for obj, state in pairs(DisabledEffects) do
            if obj and obj.Parent then obj.Enabled = state end
        end
        DisabledEffects = {}
    end
end

function applyLowGraphics()
    pcall(function()
        if S.LowGraphics then
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        else
            settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        end
    end)
end

function applyCleanSky()
    if S.CleanSky then
        for _, v in ipairs(Lighting:GetChildren()) do
            if v:IsA("Sky") then v:Destroy() end
        end
    end
end

-- AUTO CARRY + HOOK
KillerBusy = false

function GetDownedSurvivor()
    local root = getRoot()
    if not root then return nil end
    local best, dist = nil, math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.Health > 0 and hum.Health <= hum.MaxHealth * 0.25 then
                local d = (hrp.Position - root.Position).Magnitude
                if d < dist and d <= S.CarryRange then
                    dist = d
                    best = p.Character
                end
            end
        end
    end
    return best
end

function GetHookPoint()
    local root = getRoot()
    if not root then return nil end
    local bestHook, shortestDistance = nil, math.huge
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "HookPoint" and obj:IsA("BasePart") then
            local dist = (obj.Position - root.Position).Magnitude
            if dist < shortestDistance and dist < 400 then
                shortestDistance = dist
                bestHook = obj
            end
        end
    end
    return bestHook
end

task.spawn(function()
    while task.wait(0.2) do
        if not S.AutoCarry or KillerBusy then continue end
        local CarryEvent = ReplicatedStorage:FindFirstChild("Remotes", true)
            and ReplicatedStorage.Remotes:FindFirstChild("Carry", true)
            and ReplicatedStorage.Remotes.Carry:FindFirstChild("CarrySurvivorEvent")
        local HookEvent = ReplicatedStorage:FindFirstChild("Remotes", true)
            and ReplicatedStorage.Remotes:FindFirstChild("Carry", true)
            and ReplicatedStorage.Remotes.Carry:FindFirstChild("HookEvent")
        if not CarryEvent or not HookEvent then continue end
        local target = GetDownedSurvivor()
        local root = getRoot()
        if target and root then
            KillerBusy = true
            local tRoot = target:FindFirstChild("HumanoidRootPart")
            if tRoot then
                root.CFrame = tRoot.CFrame * CFrame.new(0, 3, -2)
                task.wait(0.4)
                for i = 1, 4 do
                    pcall(function() CarryEvent:FireServer(target) end)
                    task.wait(0.2)
                end
                task.wait(0.6)
                if S.AutoHook then
                    local hook = GetHookPoint()
                    if hook then
                        root.CFrame = hook.CFrame * CFrame.new(0, 4, -3)
                        task.wait(0.7)
                        for i = 1, 6 do
                            pcall(function() HookEvent:FireServer(hook) end)
                            task.wait(0.15)
                        end
                    end
                end
            end
            task.delay(2, function() KillerBusy = false end)
        end
    end
end)

-- AUTO ESCAPE GATE
task.spawn(function()
    while task.wait(3) do
        if not S.AutoEscapeGate then continue end
        local root = getRoot()
        if not root then continue end
        local killerNear = false
        if S.AutoEscapeUseKillerCheck then
            local kRoot, kDist = GetNearestKillerForFlee()
            if kRoot and kDist <= (S.AutoEscapeRange or 50) then
                killerNear = true
            end
        end
        local genDone = false
        if S.AutoEscapeUseGenCheck then
            local total, done = 0, 0
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj.Name == "Generator" then
                    total = total + 1
                    local p = obj:GetAttribute("RepairProgress")
                        or obj:GetAttribute("Progress") or 0
                    if p >= 100 then done = done + 1 end
                end
            end
            if total > 0 and done >= total then genDone = true end
        end
        if killerNear or genDone then
            local found = nil
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    local n = string.lower(obj.Name)
                    if n == "fininshline" or n == "finishline"
                       or n == "escape" or n == "escapegate"
                       or string.find(n, "escape") then
                        found = obj
                        break
                    end
                end
            end
            if found then
                pcall(function()
                    root.CFrame = found.CFrame + Vector3.new(0, 5, 0)
                end)
            end
        end
    end
end)

-- MAIN ESP LOOP
local lastESPUpdate = 0
RunService.Heartbeat:Connect(function()
    local root = getRoot()
    if not root then return end
    local now = tick()
    if now - lastESPUpdate >= 0.2 then
        lastESPUpdate = now
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then
                local char = p.Character
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local distance = (hrp.Position - root.Position).Magnitude
                        if distance <= ESP.Distance then
                            if ESP.Survivor and p.Team and p.Team.Name == "Survivors" then
                                createESP(char, TeamColors.Survivor)
                            elseif ESP.Killer and p.Team and p.Team.Name == "Killer" then
                                createESP(char, TeamColors.Killer)
                            else
                                removeESP(char)
                            end
                        else
                            removeESP(char)
                        end
                    end
                    createStatusESP(p, char, root)
                else
                    removeESP(char)
                end
            end
        end
        if ESP.Generator then
            for gen in pairs(Cached.Generators) do
                UpdateGenerator(gen)
            end
        end
        for obj in pairs(Cached.Windows) do UpdateMapESP(obj, root) end
        for obj in pairs(Cached.Pallets) do UpdateMapESP(obj, root) end
        UpdateSCPEsp(root)
        if S.NoScreenEffects then applyNoScreenEffects() end
        if S.LowGraphics then applyLowGraphics() end
        if S.CleanSky then applyCleanSky() end
    end
end)

-- KILL EFFECT LOOP
task.spawn(function()
    while task.wait(2) do
        if S.KillEffect then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LP and p.Character then
                    local hum = p.Character:FindFirstChildOfClass("Humanoid")
                    if hum and hum.Health <= 0 then
                        local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                        if hrp and not p.Character:GetAttribute("OneWKillEffect") then
                            p.Character:SetAttribute("OneWKillEffect", true)
                            spawnKillEffect(hrp.Position)
                        end
                    else
                        if p.Character:GetAttribute("OneWKillEffect") then
                            p.Character:SetAttribute("OneWKillEffect", false)
                        end
                    end
                end
            end
        end
    end
end)

-- NO CLIP CAMERA
task.spawn(function()
    while task.wait(0.2) do
        local cam = workspace.CurrentCamera
        if cam then
            cam.CanCollide = not S.NoClipCamera
        end
    end
end)

print("✅ [5/15] ONE W - Fitur Aktif + Loop Utama Loaded")-- SECTION 6/15 : GUI

gui = Instance.new("ScreenGui")
gui.Name = "OneWHub"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 99999

local ok = pcall(function() gui.Parent = game:GetService("CoreGui") end)
if not ok then gui.Parent = PG end

btnContainer = Instance.new("TextButton")
btnContainer.Size = UDim2.fromOffset(52, 52)
btnContainer.Position = UDim2.fromOffset(20, 120)
btnContainer.BackgroundColor3 = C.PANEL
btnContainer.Text = "W"
btnContainer.TextColor3 = C.GOLD
btnContainer.TextSize = 22
btnContainer.Font = Enum.Font.GothamBlack
btnContainer.BorderSizePixel = 0
btnContainer.AutoButtonColor = false
btnContainer.Active = true
btnContainer.Parent = gui
rnd(btnContainer, 999)

local tStroke = Instance.new("UIStroke")
tStroke.Thickness = 2
tStroke.Color = C.GOLD
tStroke.Parent = btnContainer

local tGlow = Instance.new("UIStroke")
tGlow.Color = C.GOLD_LIGHT
tGlow.Thickness = 6
tGlow.Transparency = 0.7
tGlow.Parent = btnContainer

local tGlow2 = Instance.new("UIStroke")
tGlow2.Color = C.ORANGE
tGlow2.Thickness = 10
tGlow2.Transparency = 0.85
tGlow2.Parent = btnContainer

local tGrad = Instance.new("UIGradient")
tGrad.Color = ColorSequence.new(C.GOLD_DARK, C.GOLD, C.GOLD_LIGHT, C.GOLD, C.GOLD_DARK)
tGrad.Rotation = 45
tGrad.Parent = btnContainer

task.spawn(function()
    local t = 0
    while btnContainer.Parent do
        t = t + 0.03
        tGrad.Rotation = (t * 40) % 360
        tGlow.Transparency = 0.7 - math.abs(math.sin(t * 2)) * 0.4
        tGlow2.Transparency = 0.85 - math.abs(math.sin(t * 1.5)) * 0.3
        btnContainer.TextColor3 = C.GOLD:Lerp(C.GOLD_LIGHT, math.abs(math.sin(t * 2)))
        btnContainer.TextSize = 22 + math.sin(t * 3) * 1.5
        tStroke.Transparency = 0.1 + math.abs(math.sin(t * 2.5)) * 0.3
        task.wait(0.03)
    end
end)

btnContainer.MouseEnter:Connect(function()
    TweenService:Create(btnContainer, TweenInfo.new(0.15), {
        Size = UDim2.fromOffset(58, 58)
    }):Play()
end)

btnContainer.MouseLeave:Connect(function()
    TweenService:Create(btnContainer, TweenInfo.new(0.15), {
        Size = UDim2.fromOffset(52, 52)
    }):Play()
end)

panel = Instance.new("Frame")
panel.Size = UDim2.fromOffset(620, 420)
panel.Position = UDim2.new(0.5, -310, 0.5, -210)
panel.BackgroundColor3 = C.BG
panel.BackgroundTransparency = 0.02
panel.BorderSizePixel = 0
panel.ClipsDescendants = true
panel.Visible = false
panel.Parent = gui
rnd(panel, 14)
strk(panel, C.GOLD, 2, 0.25)

local bgGrad = Instance.new("UIGradient")
bgGrad.Color = ColorSequence.new(C.BG, C.BG2, C.BG)
bgGrad.Rotation = 135
bgGrad.Parent = panel

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 52)
header.BackgroundColor3 = C.PANEL
header.BackgroundTransparency = 0.05
header.BorderSizePixel = 0
header.Parent = panel
rnd(header, 14)

local hPatch = Instance.new("Frame")
hPatch.Size = UDim2.new(1, 0, 0, 26)
hPatch.Position = UDim2.new(0, 0, 1, -26)
hPatch.BackgroundColor3 = C.PANEL
hPatch.BackgroundTransparency = 0.05
hPatch.BorderSizePixel = 0
hPatch.Parent = header

local logo = Instance.new("Frame")
logo.Size = UDim2.fromOffset(32, 32)
logo.Position = UDim2.new(0, 12, 0.5, -16)
logo.BackgroundColor3 = C.PANEL2
logo.BorderSizePixel = 0
logo.Parent = header
rnd(logo, 8)
strk(logo, C.GOLD, 1.5, 0.3)

local logoText = Instance.new("TextLabel")
logoText.Size = UDim2.new(1, 0, 1, 0)
logoText.BackgroundTransparency = 1
logoText.Text = "W"
logoText.TextColor3 = C.GOLD
logoText.TextSize = 18
logoText.Font = Enum.Font.GothamBlack
logoText.Parent = logo

local logoGrad = Instance.new("UIGradient")
logoGrad.Color = ColorSequence.new(C.GOLD, C.GOLD_LIGHT, C.ORANGE)
logoGrad.Parent = logoText

local hTitle = Instance.new("TextLabel")
hTitle.Size = UDim2.new(0, 200, 0, 24)
hTitle.Position = UDim2.new(0, 52, 0, 14)
hTitle.BackgroundTransparency = 1
hTitle.Text = "ONE W"
hTitle.TextColor3 = C.TXT
hTitle.TextSize = 16
hTitle.Font = Enum.Font.GothamBlack
hTitle.TextXAlignment = Enum.TextXAlignment.Left
hTitle.Parent = header

local hTitleGrad = Instance.new("UIGradient")
hTitleGrad.Color = ColorSequence.new(C.GOLD, C.ORANGE)
hTitleGrad.Parent = hTitle

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.fromOffset(26, 26)
minBtn.Position = UDim2.new(1, -62, 0.5, -13)
minBtn.BackgroundColor3 = C.BG
minBtn.BackgroundTransparency = 0.3
minBtn.Text = "—"
minBtn.TextColor3 = C.TXT
minBtn.TextSize = 13
minBtn.Font = Enum.Font.GothamBold
minBtn.BorderSizePixel = 0
minBtn.AutoButtonColor = false
minBtn.Parent = header
rnd(minBtn, 6)
strk(minBtn, C.GOLD, 1, 0.4)

closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.fromOffset(26, 26)
closeBtn.Position = UDim2.new(1, -32, 0.5, -13)
closeBtn.BackgroundColor3 = C.BG
closeBtn.BackgroundTransparency = 0.3
closeBtn.Text = "✕"
closeBtn.TextColor3 = C.RED
closeBtn.TextSize = 11
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.AutoButtonColor = false
closeBtn.Parent = header
rnd(closeBtn, 6)
strk(closeBtn, C.RED, 1, 0.4)

tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, -20, 0, 38)
tabBar.Position = UDim2.new(0, 10, 0, 60)
tabBar.BackgroundColor3 = C.PANEL
tabBar.BackgroundTransparency = 0.3
tabBar.BorderSizePixel = 0
tabBar.Parent = panel
rnd(tabBar, 8)
strk(tabBar, C.GOLD, 1, 0.3)

tabScroll = Instance.new("ScrollingFrame")
tabScroll.Size = UDim2.new(1, -8, 1, -8)
tabScroll.Position = UDim2.new(0, 4, 0, 4)
tabScroll.BackgroundTransparency = 1
tabScroll.BorderSizePixel = 0
tabScroll.ScrollBarThickness = 0
tabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
tabScroll.AutomaticCanvasSize = Enum.AutomaticSize.X
tabScroll.ScrollingDirection = Enum.ScrollingDirection.X
tabScroll.Parent = tabBar

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, 4)
tabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
tabLayout.Parent = tabScroll

contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20, 1, -110)
contentFrame.Position = UDim2.new(0, 10, 0, 105)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = panel

leftCol = Instance.new("Frame")
leftCol.Size = UDim2.new(0.5, -5, 1, 0)
leftCol.BackgroundColor3 = C.BG2
leftCol.BackgroundTransparency = 0.3
leftCol.BorderSizePixel = 0
leftCol.Parent = contentFrame
rnd(leftCol, 10)
strk(leftCol, C.GOLD, 1, 0.3)

rightCol = Instance.new("Frame")
rightCol.Size = UDim2.new(0.5, -5, 1, 0)
rightCol.Position = UDim2.new(0.5, 5, 0, 0)
rightCol.BackgroundColor3 = C.BG2
rightCol.BackgroundTransparency = 0.3
rightCol.BorderSizePixel = 0
rightCol.Parent = contentFrame
rnd(rightCol, 10)
strk(rightCol, C.GOLD, 1, 0.3)

leftScroll = Instance.new("ScrollingFrame")
leftScroll.Size = UDim2.new(1, -12, 1, -12)
leftScroll.Position = UDim2.new(0, 6, 0, 6)
leftScroll.BackgroundTransparency = 1
leftScroll.BorderSizePixel = 0
leftScroll.ScrollBarThickness = 2
leftScroll.ScrollBarImageColor3 = C.GOLD
leftScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
leftScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
leftScroll.Parent = leftCol

local leftLayout = Instance.new("UIListLayout")
leftLayout.Padding = UDim.new(0, 5)
leftLayout.Parent = leftScroll

rightScroll = Instance.new("ScrollingFrame")
rightScroll.Size = UDim2.new(1, -12, 1, -12)
rightScroll.Position = UDim2.new(0, 6, 0, 6)
rightScroll.BackgroundTransparency = 1
rightScroll.BorderSizePixel = 0
rightScroll.ScrollBarThickness = 2
rightScroll.ScrollBarImageColor3 = C.GOLD
rightScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
rightScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
rightScroll.Parent = rightCol

local rightLayout = Instance.new("UIListLayout")
rightLayout.Padding = UDim.new(0, 5)
rightLayout.Parent = rightScroll

cs = leftScroll
_G.Roooor_cs = cs

dragging = false
dragStart = nil
startPos = nil

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = panel.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        panel.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

btnDragging = false
btnDragStart = nil
btnStartPos = nil
btnWasDragged = false

btnContainer.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        btnDragging = true
        btnWasDragged = false
        btnDragStart = input.Position
        btnStartPos = btnContainer.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if btnDragging and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - btnDragStart
        if math.abs(delta.X) > 3 or math.abs(delta.Y) > 3 then
            btnWasDragged = true
        end
        btnContainer.Position = UDim2.new(
            btnStartPos.X.Scale, btnStartPos.X.Offset + delta.X,
            btnStartPos.Y.Scale, btnStartPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        btnDragging = false
    end
end)

isOpen = false

function openPanel()
    if isOpen then return end
    isOpen = true
    panel.Visible = true
    panel.Size = UDim2.fromOffset(80, 80)
    panel.Position = UDim2.new(0.5, -40, 0.5, -40)
    TweenService:Create(panel, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.fromOffset(620, 420),
        Position = UDim2.new(0.5, -310, 0.5, -210),
    }):Play()
end

function closePanel()
    if not isOpen then return end
    isOpen = false
    TweenService:Create(panel, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        Size = UDim2.fromOffset(80, 80),
        Position = UDim2.new(0.5, -40, 0.5, -40),
    }):Play()
    task.wait(0.25)
    panel.Visible = false
end

btnContainer.MouseButton1Click:Connect(function()
    if btnWasDragged then
        btnWasDragged = false
        return
    end
    if isOpen then closePanel() else openPanel() end
    playToggleSound()
end)

closeBtn.MouseButton1Click:Connect(function()
    closePanel()
    playToggleSound()
end)

minBtn.MouseButton1Click:Connect(function()
    closePanel()
    playToggleSound()
end)

UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        if isOpen then closePanel() else openPanel() end
        playToggleSound()
    end
end)-- SECTION 7/15 : KOMPONEN + TAB SURVIVOR/KILLER

function sec(title, icon, parent)
    parent = parent or cs
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -4, 0, 22)
    f.BackgroundTransparency = 1
    f.Parent = parent

    local deco = Instance.new("Frame")
    deco.Size = UDim2.new(0, 3, 0, 14)
    deco.Position = UDim2.new(0, 2, 0.5, -7)
    deco.BackgroundColor3 = C.GOLD
    deco.BorderSizePixel = 0
    deco.Parent = f
    rnd(deco, 2)

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -12, 1, 0)
    l.Position = UDim2.new(0, 10, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = (icon or "•") .. " " .. string.upper(title)
    l.TextColor3 = C.GOLD
    l.TextSize = 9
    l.Font = Enum.Font.GothamBold
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f
end

function lbl(text, color, parent)
    parent = parent or cs
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -4, 0, 16)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = color or C.DIM
    l.TextSize = 8
    l.Font = Enum.Font.Gotham
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = parent
end

function tog(name, def, cb, parent)
    parent = parent or cs
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -4, 0, 28)
    f.BackgroundColor3 = C.PANEL
    f.BackgroundTransparency = 0.4
    f.BorderSizePixel = 0
    f.Parent = parent
    rnd(f, 6)
    local fStrk = strk(f, C.GOLD, 1, 0.4)

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -55, 1, 0)
    l.Position = UDim2.new(0, 10, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = name
    l.TextColor3 = C.TXT
    l.TextSize = 10
    l.Font = Enum.Font.GothamMedium
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f

    local t = Instance.new("Frame")
    t.Size = UDim2.fromOffset(30, 15)
    t.Position = UDim2.new(1, -42, 0.5, -7.5)
    t.BorderSizePixel = 0
    t.Parent = f
    rnd(t, 8)

    local k = Instance.new("Frame")
    k.Size = UDim2.fromOffset(11, 11)
    k.BorderSizePixel = 0
    k.Parent = t
    rnd(k, 6)

    _G.ToggleStates = _G.ToggleStates or {}
    local saved = _G.ToggleStates[name]
    local state
    if saved ~= nil then state = saved else state = def end
    _G.ToggleStates[name] = state

    t.BackgroundColor3 = state and C.GOLD or C.PANEL2
    k.Position = state and UDim2.new(1, -13, 0.5, -5.5) or UDim2.new(0, 2, 0.5, -5.5)
    k.BackgroundColor3 = state and Color3.fromRGB(40, 30, 10) or C.DIM

    local cB = Instance.new("TextButton")
    cB.Size = UDim2.new(1, 0, 1, 0)
    cB.BackgroundTransparency = 1
    cB.Text = ""
    cB.Parent = f

    cB.MouseButton1Click:Connect(function()
        state = not state
        _G.ToggleStates[name] = state
        TweenService:Create(k, TweenInfo.new(0.2, Enum.EasingStyle.Back), {
            Position = state and UDim2.new(1, -13, 0.5, -5.5) or UDim2.new(0, 2, 0.5, -5.5),
            BackgroundColor3 = state and Color3.fromRGB(40, 30, 10) or C.DIM
        }):Play()
        TweenService:Create(t, TweenInfo.new(0.2), {
            BackgroundColor3 = state and C.GOLD or C.PANEL2
        }):Play()
        fStrk.Color = state and C.GOLD_LIGHT or C.GOLD
        playToggleSound()
        if cb then pcall(cb, state) end
    end)
end

function sl(name, min, max, def, cb, parent)
    parent = parent or cs
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -4, 0, 36)
    f.BackgroundColor3 = C.PANEL
    f.BackgroundTransparency = 0.4
    f.BorderSizePixel = 0
    f.Parent = parent
    rnd(f, 6)
    strk(f, C.GOLD, 1, 0.4)

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -60, 0, 14)
    l.Position = UDim2.new(0, 10, 0, 4)
    l.BackgroundTransparency = 1
    l.Text = name
    l.TextColor3 = C.TXT
    l.TextSize = 10
    l.Font = Enum.Font.GothamMedium
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f

    _G.SliderStates = _G.SliderStates or {}
    local curVal = _G.SliderStates[name]
    if curVal == nil then curVal = def end
    _G.SliderStates[name] = curVal

    local v = Instance.new("TextLabel")
    v.Size = UDim2.new(0, 50, 0, 14)
    v.Position = UDim2.new(1, -56, 0, 4)
    v.BackgroundTransparency = 1
    v.Text = tostring(curVal)
    v.TextColor3 = C.GOLD
    v.TextSize = 10
    v.Font = Enum.Font.GothamBold
    v.TextXAlignment = Enum.TextXAlignment.Right
    v.Parent = f

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, -20, 0, 5)
    bg.Position = UDim2.new(0, 10, 1, -10)
    bg.BackgroundColor3 = C.BG
    bg.BorderSizePixel = 0
    bg.Parent = f
    rnd(bg, 3)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((curVal - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = C.GOLD
    fill.BorderSizePixel = 0
    fill.Parent = bg
    rnd(fill, 3)

    local fillGrad = Instance.new("UIGradient")
    fillGrad.Color = ColorSequence.new(C.GOLD_DARK, C.GOLD, C.GOLD_LIGHT)
    fillGrad.Parent = fill

    local kn = Instance.new("Frame")
    kn.Size = UDim2.fromOffset(12, 12)
    kn.Position = UDim2.new((curVal - min) / (max - min), -6, 0.5, -6)
    kn.BackgroundColor3 = C.GOLD_LIGHT
    kn.BorderSizePixel = 0
    kn.ZIndex = 2
    kn.Parent = bg
    rnd(kn, 6)
    strk(kn, C.GOLD, 1.5)

    local drag = false
    local function upd(input)
        local pos = math.clamp((input.Position.X - bg.AbsolutePosition.X) / bg.AbsoluteSize.X, 0, 1)
        local raw = min + (max - min) * pos
        local val
        if (max - min) <= 2 then
            val = math.floor(raw * 100 + 0.5) / 100
        else
            val = math.floor(raw + 0.5)
        end
        _G.SliderStates[name] = val
        fill.Size = UDim2.new(pos, 0, 1, 0)
        kn.Position = UDim2.new(pos, -6, 0.5, -6)
        v.Text = tostring(val)
        if cb then pcall(cb, val) end
    end

    bg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            drag = true
            upd(input)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if drag and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            upd(input)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            drag = false
        end
    end)
end

function cpk(name, def, cb, parent)
    parent = parent or cs
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -4, 0, 28)
    f.BackgroundColor3 = C.PANEL
    f.BackgroundTransparency = 0.4
    f.BorderSizePixel = 0
    f.Parent = parent
    rnd(f, 6)
    strk(f, C.GOLD, 1, 0.4)

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -50, 1, 0)
    l.Position = UDim2.new(0, 10, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = name
    l.TextColor3 = C.TXT
    l.TextSize = 10
    l.Font = Enum.Font.GothamMedium
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f

    local cB = Instance.new("TextButton")
    cB.Size = UDim2.fromOffset(30, 16)
    cB.Position = UDim2.new(1, -38, 0.5, -8)
    cB.BackgroundColor3 = def
    cB.Text = ""
    cB.BorderSizePixel = 0
    cB.Parent = f
    rnd(cB, 4)
    strk(cB, C.GOLD, 1.5)

    local presets = {
        Color3.fromRGB(255, 210, 80),
        Color3.fromRGB(255, 230, 120),
        Color3.fromRGB(255, 180, 60),
        Color3.fromRGB(255, 70, 100),
        Color3.fromRGB(80, 255, 150),
        Color3.fromRGB(74, 255, 181),
        Color3.fromRGB(80, 240, 255),
        Color3.fromRGB(255, 80, 200),
        Color3.fromRGB(255, 255, 255),
    }
    local idx = 1

    cB.MouseButton1Click:Connect(function()
        idx = idx + 1
        if idx > #presets then idx = 1 end
        cB.BackgroundColor3 = presets[idx]
        if cb then pcall(cb, presets[idx]) end
    end)
end

function btn(name, cb, parent)
    parent = parent or cs
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -4, 0, 28)
    b.BackgroundColor3 = C.PANEL
    b.BackgroundTransparency = 0.4
    b.Text = name
    b.TextColor3 = C.TXT
    b.TextSize = 10
    b.Font = Enum.Font.GothamMedium
    b.BorderSizePixel = 0
    b.AutoButtonColor = false
    b.Parent = parent
    rnd(b, 6)
    strk(b, C.GOLD, 1, 0.4)

    b.MouseButton1Click:Connect(function()
        playToggleSound()
        if cb then pcall(cb) end
    end)
end

function drp(name, options, def, cb, parent)
    parent = parent or cs
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -4, 0, 28)
    f.BackgroundColor3 = C.PANEL
    f.BackgroundTransparency = 0.4
    f.BorderSizePixel = 0
    f.Parent = parent
    rnd(f, 6)
    strk(f, C.GOLD, 1, 0.4)

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0.5, 0, 1, 0)
    l.Position = UDim2.new(0, 10, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = name
    l.TextColor3 = C.TXT
    l.TextSize = 10
    l.Font = Enum.Font.GothamMedium
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f

    _G.DropdownStates = _G.DropdownStates or {}
    local savedIdx = _G.DropdownStates[name]
    local idx = savedIdx or 1
    if not savedIdx then
        for i, o in ipairs(options) do
            if o == def then idx = i end
        end
        _G.DropdownStates[name] = idx
    end
    local cur = options[idx]

    local v = Instance.new("TextLabel")
    v.Size = UDim2.new(0.5, -28, 1, 0)
    v.Position = UDim2.new(0.5, 0, 0, 0)
    v.BackgroundTransparency = 1
    v.Text = tostring(cur) .. " ▾"
    v.TextColor3 = C.GOLD
    v.TextSize = 9
    v.Font = Enum.Font.GothamBold
    v.TextXAlignment = Enum.TextXAlignment.Right
    v.Parent = f

    local cB = Instance.new("TextButton")
    cB.Size = UDim2.new(1, 0, 1, 0)
    cB.BackgroundTransparency = 1
    cB.Text = ""
    cB.Parent = f

    cB.MouseButton1Click:Connect(function()
        idx = idx + 1
        if idx > #options then idx = 1 end
        cur = options[idx]
        _G.DropdownStates[name] = idx
        v.Text = tostring(cur) .. " ▾"
        if cb then pcall(cb, cur) end
    end)

    if cb and savedIdx then
        task.defer(function() pcall(cb, cur) end)
    end
end

activeTab = nil

function makeTab(name, icon, order, leftCb, rightCb)
    local b = Instance.new("TextButton")
    b.Size = UDim2.fromOffset(80, 30)
    b.BackgroundColor3 = C.BG
    b.BackgroundTransparency = 1
    b.Text = ""
    b.BorderSizePixel = 0
    b.LayoutOrder = order
    b.AutoButtonColor = false
    b.Parent = tabScroll
    rnd(b, 6)

    local ico = Instance.new("TextLabel")
    ico.Size = UDim2.new(0, 20, 1, 0)
    ico.Position = UDim2.new(0, 8, 0, 0)
    ico.BackgroundTransparency = 1
    ico.Text = icon
    ico.TextColor3 = C.DIM
    ico.TextSize = 13
    ico.Font = Enum.Font.GothamBold
    ico.TextXAlignment = Enum.TextXAlignment.Left
    ico.Parent = b

    local lblT = Instance.new("TextLabel")
    lblT.Size = UDim2.new(1, -30, 1, 0)
    lblT.Position = UDim2.new(0, 26, 0, 0)
    lblT.BackgroundTransparency = 1
    lblT.Text = string.upper(name)
    lblT.TextColor3 = C.DIM
    lblT.TextSize = 8
    lblT.Font = Enum.Font.GothamBold
    lblT.TextXAlignment = Enum.TextXAlignment.Left
    lblT.Parent = b

    b.MouseButton1Click:Connect(function()
        if activeTab == b then return end
        if activeTab then
            TweenService:Create(activeTab, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
            for _, c in pairs(activeTab:GetChildren()) do
                if c:IsA("TextLabel") then
                    TweenService:Create(c, TweenInfo.new(0.2), {TextColor3 = C.DIM}):Play()
                end
            end
        end

        activeTab = b
        TweenService:Create(b, TweenInfo.new(0.2), {BackgroundTransparency = 0.5, BackgroundColor3 = C.GOLD}):Play()
        for _, c in pairs(b:GetChildren()) do
            if c:IsA("TextLabel") then
                TweenService:Create(c, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(40, 30, 10)}):Play()
            end
        end

        for _, c in pairs(leftScroll:GetChildren()) do
            if not c:IsA("UIListLayout") then c:Destroy() end
        end
        for _, c in pairs(rightScroll:GetChildren()) do
            if not c:IsA("UIListLayout") then c:Destroy() end
        end

        if leftCb then pcall(leftCb) end
        if rightCb then pcall(rightCb) end
    end)
end

_G.Roooor_sec = sec
_G.Roooor_lbl = lbl
_G.Roooor_tog = tog
_G.Roooor_sl = sl
_G.Roooor_cpk = cpk
_G.Roooor_btn = btn
_G.Roooor_drp = drp
_G.Roooor_makeTab = makeTab

makeTab("Survivor", "🏃", 1, function()
    sec("Auto Parry", "🛡️")
    tog("Enable Auto Parry", false, function(s)
        AutoParry.Enabled = s
        if s then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LP and p.Character and p.Team and p.Team.Name == "Killer" then
                    task.spawn(function() AP_HookKiller(p.Character) end)
                end
            end
        end
    end)
    sl("Parry Radius", 5, 40, 20, function(v)
        AutoParry.ParryDistance = v
        AP_Config.Radius = v
    end)
    sl("Debounce", 0.01, 0.5, 0.02, function(v)
        AP_PARRY_DEBOUNCE = v
        AP_Config.Debounce = v
    end)
    sl("Circle Height", -5, 15, -2.5, function(v)
        AP_ESPCircle.YOffset = v
    end)
    tog("Show Circle", false, function(s)
        AP_ESPCircle.Enabled = s
        if not s then AP_ClearCircle() end
    end)
    btn("Reset Parry Counter", function()
        AP_parryCount = 0
    end)

    sec("Aimbot Senter", "🔦")
    tog("Enable Aimbot Senter", false, function(s)
        AimbotSenter.Enabled = s
        if s then
            task.spawn(function() pcall(HookSenterButtons) end)
        else
            AimbotSenter.HoldingSenter = false
            AimbotSenter.CurrentTarget = nil
        end
    end)
    drp("Lock Part", {"Head", "HumanoidRootPart", "UpperTorso"}, "Head", function(v)
        AimbotSenter.LockPart = v
    end)
    tog("Show ESP Laser", true, function(s)
        AimbotSenter.ShowLaser = s
    end)
    cpk("Laser Color", Color3.fromRGB(255, 210, 80), function(c)
        AimbotSenter.LaserColor = c
    end)

    sec("Auto Skill Check", "⚡")
    tog("Enable Auto Skill Check", false, function(s)
        SkillCheck.Enabled = s
        if s then startSkillCheck() end
    end)
    drp("Mode", {"Perfect", "Instant"}, "Perfect", function(v)
        SkillCheck.Mode = v
    end)
    tog("Hide Needle", false, function(s)
        SkillCheck.HideNeedle = s
    end)
    btn("Reset Counter", function()
        SkillCheck.Success = 0
        SkillCheck.Total = 0
    end)

    sec("Auto Wiggle", "🔓")
    tog("Enable Auto Wiggle", false, function(s)
        AutoParry.Wiggle = s
    end)
    sl("Wiggle Spam", 1, 20, 5, function(v)
        AutoParry.WiggleSpam = v
    end)

    sec("Auto Flee", "🏃‍♂️")
    tog("Enable Auto Flee", false, function(s)
        AutoFlee.Enabled = s
    end)
    sl("Detect Distance", 10, 150, 50, function(v)
        AutoFlee.DetectDistance = v
    end)
    sl("Cooldown", 0.1, 5, 0.5, function(v)
        AutoFlee.Cooldown = v
    end)

    sec("Fast Vault", "⚡")
    tog("Enable Fast Vault", false, function(s)
        FastVault.Enabled = s
        if s and LP.Character then hookVault(LP.Character) end
    end)
    sl("Animation Speed", 1, 5, 1.2, function(v)
        FastVault.Speed = v
    end)

    sec("Auto Escape", "🚪")
    tog("Enable Auto Escape", false, function(s)
        S.AutoEscapeGate = s
    end)
    tog("Killer Deket", true, function(s)
        S.AutoEscapeUseKillerCheck = s
    end)
    tog("Generator Cukup", true, function(s)
        S.AutoEscapeUseGenCheck = s
    end)
    sl("Killer Range", 10, 150, 50, function(v)
        S.AutoEscapeRange = v
    end)

    sec("God Mode", "🛡️")
    tog("God Mode", false, function(s)
        GodMode.Enabled = s
    end)

    sec("Support", "💊")
    tog("Instant Interact", false, function(s) S.InstantInteract = s end)

    sec("Teleport", "🌀")
    btn("TP Finish Line", function()
        teleportToFinishLine()
    end)
end, nil)

makeTab("Killer", "🔪", 2, function()
    sec("Auto Attack", "⚔️")
    tog("Killer Auto Attack", false, function(s) S.Killer_AutoAtk = s end)
    sl("Attack Delay", 0.1, 1, 0.35, function(v) S.Killer_AtkDelay = v end)

    sec("Kill All", "💀")
    tog("Killer Kill All", false, function(s) S.Killer_KillAll = s end)

    sec("Auto Carry + Hook", "🎒")
    tog("Auto Carry", false, function(s) S.AutoCarry = s end)
    tog("Auto Hook", false, function(s) S.AutoHook = s end)
    sl("Carry Range", 10, 200, 60, function(v) S.CarryRange = v end)
end, function()
    sec("Masked Power", "🎭", rightScroll)
    drp("Select Power", {"Cobra", "Richter", "Brandon", "Rabbit", "Alex"}, "Cobra", function(v)
        S.MaskedPower = v
    end, rightScroll)
    btn("Activate Power", function()
        local Event = ReplicatedStorage:FindFirstChild("Remotes", true)
            and ReplicatedStorage.Remotes:FindFirstChild("Killers", true)
            and ReplicatedStorage.Remotes.Killers:FindFirstChild("Masked", true)
            and ReplicatedStorage.Remotes.Killers.Masked:FindFirstChild("Activatepower")
        if Event then Event:FireServer(S.MaskedPower) end
    end, rightScroll)
    btn("Deactivate Power", function()
        local Event = ReplicatedStorage:FindFirstChild("Remotes", true)
            and ReplicatedStorage.Remotes:FindFirstChild("Killers", true)
            and ReplicatedStorage.Remotes.Killers:FindFirstChild("Masked", true)
            and ReplicatedStorage.Remotes.Killers.Masked:FindFirstChild("Deactivatepower")
        if Event then Event:FireServer() end
    end, rightScroll)

    sec("Target", "🎯", rightScroll)
    tog("Auto Stalk", false, function(s)
        S.AutoStalk = s
    end, rightScroll)
    sl("Stalk Range", 10, 300, 150, function(v)
        S.StalkRange = v
    end, rightScroll)
end)-- SECTION 8/15 : TAB ESP/FIRE/MOONWALK/MISC/VISUAL/HITBOX/GRAFIK ULTRA

makeTab("ESP", "👁️", 3, function()
    sec("Player ESP", "🟢")
    tog("ESP Survivor", true, function(s) ESP.Survivor = s end)
    cpk("Survivor Color", TeamColors.Survivor, function(c) TeamColors.Survivor = c end)
    tog("ESP Killer", true, function(s) ESP.Killer = s end)
    cpk("Killer Color", TeamColors.Killer, function(c) TeamColors.Killer = c end)

    sec("Object ESP", "⚡")
    tog("ESP Generator", true, function(s) ESP.Generator = s end)
    cpk("Gen Color", GeneratorColor, function(c) GeneratorColor = c end)
    tog("ESP Pallet", false, function(s) ESP.Pallet = s end)
    cpk("Pallet Color", PalletColor, function(c) PalletColor = c end)
    tog("ESP Window", false, function(s) ESP.Window = s end)
    cpk("Window Color", WindowColor, function(c) WindowColor = c end)
    tog("ESP SCP", false, function(s) ESP.SCP = s end)
    cpk("SCP Color", SCPColor, function(c) SCPColor = c end)

    sec("ESP Distance", "📏")
    sl("ESP Radius", 10, 1000, 1000, function(v) ESP.Distance = v end)
end, function()
    sec("Generator Mode", "📊", rightScroll)
    drp("Generator Mode", {"Classic", "Bar"}, "Bar", function(v)
        S.ESPGenMode = v
        for gen in pairs(Cached.Generators) do
            local a = gen:FindFirstChild("GenESP")
            if a then a:Destroy() end
            local b = gen:FindFirstChild("GenESPBar")
            if b then b:Destroy() end
        end
    end, rightScroll)
    sl("Bar Width", 40, 200, 64, function(v) S.ESPGenBarSize = v end, rightScroll)
    sl("Bar Height", 8, 40, 8, function(v) S.ESPGenBarHeight = v end, rightScroll)
    sl("Text Size", 6, 30, 10, function(v) S.ESPGenBarTextSize = v end, rightScroll)

    sec("Status ESP", "🟢", rightScroll)
    tog("Enable Status ESP", false, function(s) ESPStatus.Enabled = s end, rightScroll)
    tog("Show Name", true, function(s) ESPStatus.ShowName = s end, rightScroll)
    tog("Show Distance", true, function(s) ESPStatus.ShowDistance = s end, rightScroll)
    tog("Show Health", true, function(s) ESPStatus.ShowHealth = s end, rightScroll)
    sl("Status Radius", 20, 1000, 1000, function(v) ESPStatus.Radius = v end, rightScroll)

    sec("Nama Mode", "✨", rightScroll)
    drp("Name Mode", {"Text", "Galaxy"}, "Galaxy", function(v)
        S.ESPNameMode = v
    end, rightScroll)
    sl("Name Size", 8, 30, 8, function(v)
        S.ESPNameSize = v
    end, rightScroll)
end)

makeTab("Fire", "🔥", 4, function()
    sec("Fire Control", "⚙️")
    tog("Enable Fire", false, function(s)
        S.FireOn = s
        applyFire()
    end)
    sl("Fire Size", 1, 15, 5, function(v)
        S.FireSize = v
        applyFire()
    end)

    sec("Fire Beam", "⚡")
    tog("Fire Beam", false, function(s) S.FireBeamOn = s end)
    drp("Beam Type", FireBeamList, "Classic Beam", function(v)
        S.FireBeamType = v
    end)
    cpk("Beam Color", Color3.fromRGB(255, 210, 80), function(c)
        S.FireBeamColor = c
    end)
end, function()
    sec("Fire Effect", "🔥", rightScroll)
    for i, fireName in ipairs(FireList) do
        local btn2 = Instance.new("TextButton")
        btn2.Size = UDim2.new(1, -4, 0, 24)
        btn2.BackgroundColor3 = C.BG
        btn2.BackgroundTransparency = 0.4
        btn2.BorderSizePixel = 0
        btn2.Text = ""
        btn2.AutoButtonColor = false
        btn2.LayoutOrder = i + 100
        btn2.Parent = rightScroll
        rnd(btn2, 6)
        strk(btn2, C.GOLD, 1, 0.6)

        local btnLbl = Instance.new("TextLabel")
        btnLbl.Size = UDim2.new(1, -10, 1, 0)
        btnLbl.Position = UDim2.new(0, 8, 0, 0)
        btnLbl.BackgroundTransparency = 1
        btnLbl.Text = fireName
        btnLbl.TextColor3 = C.TXT
        btnLbl.TextSize = 9
        btnLbl.Font = Enum.Font.GothamMedium
        btnLbl.TextXAlignment = Enum.TextXAlignment.Left
        btnLbl.Parent = btn2

        if S.FireType == fireName then
            btn2.BackgroundColor3 = C.GOLD
            btn2.BackgroundTransparency = 0
            btnLbl.TextColor3 = Color3.fromRGB(40, 30, 10)
        end

        btn2.MouseButton1Click:Connect(function()
            S.FireType = fireName
            applyFire()
            for _, c in pairs(rightScroll:GetChildren()) do
                if c:IsA("TextButton") and c.LayoutOrder > 100 and c.LayoutOrder < 200 then
                    c.BackgroundColor3 = C.BG
                    c.BackgroundTransparency = 0.4
                    local l = c:FindFirstChildOfClass("TextLabel")
                    if l then l.TextColor3 = C.TXT end
                end
            end
            btn2.BackgroundColor3 = C.GOLD
            btn2.BackgroundTransparency = 0
            btnLbl.TextColor3 = Color3.fromRGB(40, 30, 10)
            playToggleSound()
        end)
    end
end)

makeTab("Moonwalk", "🕺", 5, function()
    sec("Moonwalk", "🕺")
    tog("Enable Moonwalk", false, function(s)
        if setMoonwalk then setMoonwalk(s) else Moonwalk.Enabled = s end
        if _G.Roooor_mwBtnUpdateUI then pcall(_G.Roooor_mwBtnUpdateUI) end
    end)
    tog("Lock Moonwalk", false, function(s)
        Moonwalk.Locked = s
        if _G.Roooor_mwBtnUpdateUI then pcall(_G.Roooor_mwBtnUpdateUI) end
    end)
    tog("Show MW Button", true, function(s)
        Moonwalk.ShowButton = s
        if mwBtnGui then mwBtnGui.Enabled = s end
    end)
    btn("Reset Posisi Tombol MW", function()
        if mwBtn then mwBtn.Position = UDim2.new(0, 20, 1, -100) end
        if mwLockBtn then mwLockBtn.Position = UDim2.new(0, 20, 1, -128) end
    end)
end, function()
    sec("Moonwalk Settings", "⚙️", rightScroll)
    sl("Spam Speed", 1, 50, 30, function(v) Moonwalk.SpamSpeed = v end, rightScroll)
    sl("Intensity", 1, 50, 35, function(v) Moonwalk.Intensity = v end, rightScroll)
    sl("Slow Speed", 5, 20, 13, function(v) Moonwalk.SlowSpeed = v end, rightScroll)
    tog("Use Slow Speed", true, function(s) Moonwalk.UseSlow = s end, rightScroll)
end)

makeTab("Misc", "⚙️", 6, function()
    sec("Movement", "🏃")
    tog("Walk Speed", false, function(s) S.WalkSpeed = s end)
    sl("Walk Speed Value", 16, 100, 16, function(v) S.WalkSpeedVal = v end)
    tog("Speed Hack", false, function(s) S.SpeedHack = s end)
    sl("Speed Hack Value", 20, 200, 40, function(v) S.SpeedHackVal = v end)
    tog("No Clip", false, function(s) S.NoClip = s end)
    tog("No Clip Camera", false, function(s) S.NoClipCamera = s end)

    sec("FOV", "🎥")
    btn("FOV 70", function()
        S.FOV = 70; S.FOVEnabled = true; applyFOV()
    end)
    btn("FOV 90", function()
        S.FOV = 90; S.FOVEnabled = true; applyFOV()
    end)
    btn("FOV 120", function()
        S.FOV = 120; S.FOVEnabled = true; applyFOV()
    end)

    sec("Character", "🎭")
    tog("Headless", true, function(s)
        S.Headless = s
        applyHeadless(s)
    end)

    sec("Utility", "🛠️")
    tog("Anti-AFK", false, function(s)
        S.AntiAFK = s
        applyAntiAFK(s)
    end)
end, function()
    sec("FPS Counter", "📊", rightScroll)
    tog("Show FPS Counter", false, function(s) S.ShowFPS = s end, rightScroll)
    tog("Show Ping Counter", false, function(s) S.ShowPing = s end, rightScroll)

    sec("Notify", "🔔", rightScroll)
    tog("Kill Feed", false, function(s) S.KillFeed = s end, rightScroll)
    tog("Stun Notify", false, function(s) S.StunNotify = s end, rightScroll)

    sec("Server", "🌐", rightScroll)
    btn("Rejoin Server", function() rejoinServer() end, rightScroll)
end)

makeTab("Visual", "✨", 7, function()
    sec("Fullbright & No Fog", "💡")
    tog("Fullbright", false, function(s)
        S.Fullbright = s
        applyFullbright(s)
    end)
    sl("Brightness Level", 10, 200, 100, function(v)
        S.FullbrightVal = v
        if S.Fullbright then applyFullbright(true) end
    end)
    tog("No Fog", false, function(s)
        S.NoFog = s
        applyNoFog(s)
    end)

    sec("HD Sky", "🔷")
    tog("HD Sky (Clean)", false, function(s)
        S.HDSky = s
        applyHDSky(s)
    end)

    sec("HD Visual", "🌟")
    tog("HD Texture", false, function(s) S.HDTexture = s; applyHDTexture(s) end)
    tog("HD Reflection", false, function(s) S.HDReflection = s; applyHDReflection(s) end)
    tog("HD Bloom", false, function(s) S.HDBloom = s; applyHDBloom(s) end)
    tog("HD Shadow", false, function(s) S.HDShadow = s; applyHDShadow(s) end)
    tog("HD Water", false, function(s) S.HDWater = s; applyHDWater(s) end)
    tog("HD Sun Rays", false, function(s) S.HDSunRays = s; applyHDSunRays(s) end)
    tog("HD Depth of Field", false, function(s) S.HDDepthField = s; applyHDDepthField(s) end)
    tog("HD Anti-Aliasing", false, function(s) S.HDAntiAliasing = s; applyHDAntiAliasing(s) end)

    sec("Lighting", "💡")
    tog("Ultra HD", false, function(s) S.UltraHD = s; applyUltraHD() end)
    tog("Contrast Boost", false, function(s) S.Contrast = s; applyContrast() end)
    sl("Contrast", 0, 1, 0.3, function(v) S.ContrastVal = v; applyContrast() end)
    sl("Saturation", 0, 1, 0.2, function(v) S.SaturationVal = v; applyContrast() end)

    sec("Character", "🎭")
    tog("8-Bit Royal Crown", false, function(s)
        S.EightBitOn = s
        apply8Bit(s, "Royal Crown", S.EightBitSize, S.EightBitHeight)
    end)
    sl("Crown Size", 0.3, 3, 1.24, function(v)
        S.EightBitSize = v
        if S.EightBitOn then apply8Bit(true, "Royal Crown", v, S.EightBitHeight) end
    end)
    sl("Crown Height", -1, 4, 0.88, function(v)
        S.EightBitHeight = v
        if S.EightBitOn then apply8Bit(true, "Royal Crown", S.EightBitSize, v) end
    end)
    tog("Enable Korblox", true, function(s)
        S.Korblox = s
        applyKorblox(s, "Pencil", S.KorbloxYOffset, S.KorbloxScale)
    end)
    sl("Korblox Y", -2, 2, 0.80, function(v)
        S.KorbloxYOffset = v
        if S.Korblox then applyKorblox(true, "Pencil", v, S.KorbloxScale) end
    end)
    sl("Korblox Scale", 0.3, 3, 1, function(v)
        S.KorbloxScale = v
        if S.Korblox then applyKorblox(true, "Pencil", S.KorbloxYOffset, v) end
    end)
end, function()
    sec("Sky Preset", "🌌", rightScroll)
    drp("Sky", SkyList, "Default", function(v)
        S.SkyId = v
        applySky(v)
    end, rightScroll)

    sec("Camera", "🎥", rightScroll)
    tog("Zoom Out", false, function(s) S.ZoomOut = s; applyZoomOut(s, S.ZoomOutValue) end, rightScroll)
    sl("Max Zoom Distance", 100, 1000, 500, function(v)
        S.ZoomOutValue = v
        if S.ZoomOut then applyZoomOut(true, v) end
    end, rightScroll)

    sec("Crosshair", "🎯", rightScroll)
    tog("Enable Crosshair", false, function(s)
        S.Crosshair = s
        applyCrosshair(s, S.CrosshairColor, S.CrosshairSize)
    end, rightScroll)
    drp("Style", {"Plus", "Dot", "Circle", "X", "Square", "Diamond", "TShape", "CrossDot"}, "Plus", function(v)
        S.CrosshairStyle = v
        if S.Crosshair then applyCrosshair(true, S.CrosshairColor, S.CrosshairSize) end
    end, rightScroll)
    cpk("Crosshair Color", S.CrosshairColor, function(c)
        S.CrosshairColor = c
        if S.Crosshair then applyCrosshair(true, c, S.CrosshairSize) end
    end, rightScroll)
    sl("Crosshair Size", 4, 30, 8, function(v)
        S.CrosshairSize = v
        if S.Crosshair then applyCrosshair(true, S.CrosshairColor, v) end
    end, rightScroll)

    sec("Character Effects", "✨", rightScroll)
    tog("Fire Trail", false, function(s)
        S.Trail = s
        applyTrail(s, S.TrailColor)
    end, rightScroll)
    cpk("Trail Color", S.TrailColor, function(c)
        S.TrailColor = c
        if S.Trail then applyTrail(true, c) end
    end, rightScroll)
    tog("Aura Fire", false, function(s)
        S.Aura = s
        applyAura(s, S.AuraColor)
    end, rightScroll)
    cpk("Aura Color", S.AuraColor, function(c)
        S.AuraColor = c
        if S.Aura then applyAura(true, c) end
    end, rightScroll)
    tog("Kill Effect", false, function(s) S.KillEffect = s end, rightScroll)

    sec("FPS Boost", "🚀", rightScroll)
    tog("No Screen Effects", false, function(s)
        S.NoScreenEffects = s
        applyNoScreenEffects()
    end, rightScroll)
    tog("Low Graphics", false, function(s)
        S.LowGraphics = s
        applyLowGraphics()
    end, rightScroll)
    tog("Clean Sky", false, function(s)
        S.CleanSky = s
        applyCleanSky()
    end, rightScroll)

    sec("Danger Zone", "⚠️", rightScroll)
    btn("UNLOAD", function()
        pcall(function()
            if gui then gui:Destroy() end
            if killFeedGui then killFeedGui:Destroy() end
            if loadingGui then loadingGui:Destroy() end
            if crosshairGui then crosshairGui:Destroy() end
            if fpsPingGui then fpsPingGui:Destroy() end
            if mwBtnGui then mwBtnGui:Destroy() end
            if Aimlock_Gui then Aimlock_Gui:Destroy() end
            if AimbotLaserGui then AimbotLaserGui:Destroy() end
            clear8Bit()
            clearKorblox()
            AP_ClearCircle()
            hitboxClearAll()
        end)
    end, rightScroll)
end)

makeTab("Hitbox", "📦", 8, function()
    sec("Hitbox Control", "📦")
    tog("Enable Hitbox", false, function(s)
        Hitbox.Enabled = s
        if not s then hitboxClearAll() end
    end)
    sl("Hitbox Size", 10, 70, 70, function(v)
        Hitbox.Size = v
        hitboxUpdateVisibility()
    end)
    sl("Text Size", 5, 30, 10, function(v)
        Hitbox.TextSize = v
        hitboxUpdateVisibility()
    end)
    drp("Mode", {"Auto", "Killer", "Survivor"}, "Auto", function(v)
        Hitbox.Mode = v
    end)
    cpk("Killer Color", Hitbox.ColorKiller, function(c)
        Hitbox.ColorKiller = c
        hitboxUpdateVisibility()
    end)
    cpk("Survivor Color", Hitbox.ColorSurvivor, function(c)
        Hitbox.ColorSurvivor = c
        hitboxUpdateVisibility()
    end)
    tog("Wall Bang", true, function(s)
        Hitbox.WallBang = s
    end)
end, nil)

makeTab("Grafik Ultra", "🎬", 9, function()
    sec("Soft Cinematic", "🎬")
    tog("Soft Cinematic", false, function(s)
        if s then
            GraphicEnableSoftCinematic()
        else
            GraphicDisableSoftCinematic()
        end
    end)
    tog("Low Graphics", false, function(s)
        if s then
            GraphicEnableLowGraphics()
        else
            GraphicDisableLowGraphics()
        end
    end)
    tog("Full Bright", false, function(s)
        GraphicState.FullBright = s
        GraphicApplyFullBright()
    end)
    tog("No Fog", false, function(s)
        GraphicState.NoFog = s
        GraphicApplyNoFog()
    end)
    tog("Clean Sky", false, function(s)
        GraphicState.CleanSky = s
        GraphicApplyCleanSky()
    end)
    tog("No Particle", false, function(s)
        GraphicState.NoParticle = s
        GraphicApplyNoParticle()
    end)
    tog("No Grass", false, function(s)
        GraphicState.NoGrass = s
        GraphicApplyGrass()
    end)

    sec("Shadow", "🌑")
    btn("Soft Shadow", function()
        Lighting.ShadowSoftness = 0.10
        if GraphicState.SoftCinematic then GraphicApplyCharacterShadow() end
    end)
    btn("Balanced Shadow", function()
        Lighting.ShadowSoftness = 0.055
        if GraphicState.SoftCinematic then GraphicApplyCharacterShadow() end
    end)
    btn("Sharp Shadow", function()
        Lighting.ShadowSoftness = 0.025
        if GraphicState.SoftCinematic then GraphicApplyCharacterShadow() end
    end)
    btn("Refresh Character Shadow", function()
        if GraphicState.SoftCinematic then GraphicApplyCharacterShadow() end
    end)
end, function()
    sec("Preset Soft Cinematic", "🎬", rightScroll)
    for _, presetName in ipairs(GraphicPresetOrder) do
        local icon = "🎬"
        if presetName == "Soft" then icon = "🌤️"
        elseif presetName == "Ultra Cinematic" then icon = "✨"
        elseif presetName == "Golden Hour" then icon = "🌅"
        elseif presetName == "Night Cinema" then icon = "🌙"
        elseif presetName == "Deep Shadow" then icon = "🌑"
        elseif presetName == "Crystal" then icon = "💎"
        elseif presetName == "Dreamy" then icon = "🌫️"
        elseif presetName == "Vivid Cinema" then icon = "🔥"
        elseif presetName == "Dark Cinema" then icon = "🖤"
        elseif presetName == "Cloudy Soft" then icon = "☁️"
        elseif presetName == "Film Look" then icon = "🎞️"
        elseif presetName == "Moonlight" then icon = "🌌"
        elseif presetName == "Bright Cinema" then icon = "☀️"
        elseif presetName == "Ultra Soft" then icon = "👑"
        elseif presetName == "Performance Cinema" then icon = "⚡"
        end

        local btn2 = Instance.new("TextButton")
        btn2.Size = UDim2.new(1, -4, 0, 28)
        btn2.BackgroundColor3 = C.PANEL
        btn2.BackgroundTransparency = 0.4
        btn2.BorderSizePixel = 0
        btn2.Text = icon .. "  " .. presetName
        btn2.TextColor3 = C.TXT
        btn2.TextSize = 10
        btn2.Font = Enum.Font.GothamMedium
        btn2.TextXAlignment = Enum.TextXAlignment.Left
        btn2.AutoButtonColor = false
        btn2.Parent = rightScroll
        rnd(btn2, 6)
        strk(btn2, C.GOLD, 1, 0.4)
        btn2:SetAttribute("IsPreset", true)

        local pad = Instance.new("UIPadding")
        pad.PaddingLeft = UDim.new(0, 10)
        pad.Parent = btn2

        if GraphicState.SelectedPreset == presetName then
            btn2.BackgroundColor3 = C.GOLD
            btn2.BackgroundTransparency = 0
            btn2.TextColor3 = Color3.fromRGB(40, 30, 10)
        end

        btn2.MouseButton1Click:Connect(function()
            GraphicSelectPreset(presetName)
            for _, c in pairs(rightScroll:GetChildren()) do
                if c:IsA("TextButton") and c:GetAttribute("IsPreset") then
                    c.BackgroundColor3 = C.PANEL
                    c.BackgroundTransparency = 0.4
                    c.TextColor3 = C.TXT
                end
            end
            btn2.BackgroundColor3 = C.GOLD
            btn2.BackgroundTransparency = 0
            btn2.TextColor3 = Color3.fromRGB(40, 30, 10)
            playToggleSound()
        end)
    end

    sec("Time", "🕐", rightScroll)
    btn("🌅 Morning 07:00", function() GraphicState.Time = 7; GraphicApplyTime() end, rightScroll)
    btn("☀️ Day 12:00", function() GraphicState.Time = 12; GraphicApplyTime() end, rightScroll)
    btn("🌇 Sunset 17:30", function() GraphicState.Time = 17.5; GraphicApplyTime() end, rightScroll)
    btn("🌆 Evening 18:00", function() GraphicState.Time = 18; GraphicApplyTime() end, rightScroll)
    btn("🌙 Night 22:00", function() GraphicState.Time = 22; GraphicApplyTime() end, rightScroll)
    btn("🌌 Midnight 00:00", function() GraphicState.Time = 0; GraphicApplyTime() end, rightScroll)

    sec("System", "🔄", rightScroll)
    btn("🔄 Reset Graphics", function()
        GraphicReset()
        for _, c in pairs(rightScroll:GetChildren()) do
            if c:IsA("TextButton") and c:GetAttribute("IsPreset") then
                if c.Text:find("Soft") and not c.Text:find("Ultra") and not c.Text:find("Cloudy") then
                    c.BackgroundColor3 = C.GOLD
                    c.BackgroundTransparency = 0
                    c.TextColor3 = Color3.fromRGB(40, 30, 10)
                else
                    c.BackgroundColor3 = C.PANEL
                    c.BackgroundTransparency = 0.4
                    c.TextColor3 = C.TXT
                end
            end
        end
    end, rightScroll)
end)-- SECTION 9/15 : KEYBIND + CAMERA FIX + ANTI-ILANG

UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.V then
        if Moonwalk.Locked then
            pcall(function()
                StarterGui:SetCore("SendNotification", {
                    Title = "Moonwalk",
                    Text = "LOCKED!",
                    Duration = 1
                })
            end)
            return
        end
        setMoonwalk(not Moonwalk.Enabled)
        if _G.Roooor_mwBtnUpdateUI then pcall(_G.Roooor_mwBtnUpdateUI) end
    end
end)

UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.K then
        local cam = workspace.CurrentCamera
        local char = LP.Character
        if cam and char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                pcall(function()
                    cam.CameraType = Enum.CameraType.Custom
                    cam.CameraSubject = hum
                    cam.Focus = CFrame.new(cam.CFrame.Position)
                    GuiService.SelectedObject = nil
                end)
            end
        end
    end
end)

AP_LastCamFix = 0

task.spawn(function()
    while task.wait(0.05) do
        local cam = workspace.CurrentCamera
        local char = LP.Character
        if not cam or not char then continue end

        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then continue end

        if AimbotSenter.Enabled and AimbotSenter.HoldingSenter then continue end
        if GuiService.SelectedObject then continue end

        local needFix = false
        if cam.CameraType ~= Enum.CameraType.Custom then needFix = true end
        if cam.CameraSubject ~= hum then needFix = true end

        local state = hum:GetState()
        if state == Enum.HumanoidStateType.FallingDown
            or state == Enum.HumanoidStateType.Ragdoll
            or state == Enum.HumanoidStateType.PlatformStanding then
            needFix = true
        end

        if needFix then
            local now = tick()
            if now - AP_LastCamFix > 0.05 then
                AP_LastCamFix = now
                pcall(function()
                    cam.CameraType = Enum.CameraType.Custom
                    cam.CameraSubject = hum
                    cam.CameraMode = Enum.CameraMode.Classic
                    cam.Focus = CFrame.new(cam.CFrame.Position)
                end)
            end
        end
    end
end)

local function hookKillerParryAnim(char)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local animator = hum:FindFirstChildOfClass("Animator")
    if not animator then return end

    animator.AnimationPlayed:Connect(function(track)
        local a = track.Animation
        if not a or not a.AnimationId then return end
        local id = a.AnimationId:match("%d+")
        if id == "127096285501517" or id == "123047897844134" or id == "112166042383605" then
            task.delay(0.1, function()
                local cam = workspace.CurrentCamera
                local myChar = LP.Character
                if cam and myChar then
                    local myHum = myChar:FindFirstChildOfClass("Humanoid")
                    if myHum and not (AimbotSenter.Enabled and AimbotSenter.HoldingSenter) then
                        pcall(function()
                            cam.CameraType = Enum.CameraType.Custom
                            cam.CameraSubject = myHum
                        end)
                    end
                end
            end)
        end
    end)
end

for _, p in pairs(Players:GetPlayers()) do
    if p ~= LP and p.Character and p.Team and p.Team.Name == "Killer" then
        task.spawn(function() hookKillerParryAnim(p.Character) end)
    end
    p.CharacterAdded:Connect(function(c)
        task.wait(1)
        if p.Team and p.Team.Name == "Killer" then
            hookKillerParryAnim(c)
        end
    end)
end

Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function(c)
        task.wait(1)
        if p.Team and p.Team.Name == "Killer" then
            hookKillerParryAnim(c)
        end
    end)
end)

local function forceAllGuiResetOnSpawnFalse()
    for _, g in ipairs(PG:GetChildren()) do
        if g:IsA("ScreenGui") then
            pcall(function()
                g.ResetOnSpawn = false
                g.Enabled = true
            end)
        end
    end
end

task.spawn(function()
    while task.wait(0.2) do
        pcall(forceAllGuiResetOnSpawnFalse)

        if not gui or not gui.Parent then
            local existing = PG:FindFirstChild("OneWHub")
                or (game:GetService("CoreGui") and game:GetService("CoreGui"):FindFirstChild("OneWHub"))
            if existing then
                gui = existing
                gui.ResetOnSpawn = false
                gui.Enabled = true
            end
        end

        if not fpsPingGui or not fpsPingGui.Parent then
            local existing = PG:FindFirstChild("OneWFPSPing")
            if existing then
                fpsPingGui = existing
                fpsPingGui.ResetOnSpawn = false
            else
                pcall(createFPSPingGui)
            end
        end

        if not mwBtnGui or not mwBtnGui.Parent then
            local existing = PG:FindFirstChild("MW_BottomBtn")
            if existing then
                mwBtnGui = existing
                mwBtnGui.ResetOnSpawn = false
            end
        end

        if not killFeedGui or not killFeedGui.Parent then
            local existing = PG:FindFirstChild("OneWKillFeed")
            if existing then
                killFeedGui = existing
                killFeedGui.ResetOnSpawn = false
            end
        end

        if not AimbotLaserGui or not AimbotLaserGui.Parent then
            local existing = PG:FindFirstChild("OneWAimbotLaser")
            if existing then
                AimbotLaserGui = existing
                AimbotLaserGui.ResetOnSpawn = false
            end
        end
    end
end)

LP.CharacterAdded:Connect(function(char)
    task.wait(1)
    pcall(forceAllGuiResetOnSpawnFalse)
end)

task.spawn(function()
    task.wait(3)
    pcall(createFPSPingGui)
end)

Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function(char)
        task.wait(1)
        if AutoParry.Enabled then
            if p.Team and p.Team.Name == "Killer" then
                AP_HookKiller(char)
            end
        end
    end)
end)

task.spawn(function()
    while task.wait(1) do
        if AutoParry.Enabled then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LP and p.Character and p.Team and p.Team.Name == "Killer" then
                    AP_HookKiller(p.Character)
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(2) do
        if AimbotSenter.Enabled then
            pcall(HookSenterButtons)
        end
    end
end)-- SECTION 10/15 : LOGIC FITUR BARU

task.spawn(function()
    while task.wait(1) do
        if not AutoParry.Wiggle then continue end
        local char = LP.Character
        if not char then continue end
        local carried = (char:FindFirstChild("IsCarried") and char.IsCarried.Value)
            or (char:FindFirstChild("IsCarrying") and char.IsCarrying.Value)
        if not carried then continue end
        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
        if not remotes then continue end
        local carry = remotes:FindFirstChild("Carry")
        if not carry then continue end
        local event = carry:FindFirstChild("SelfUnHookEvent")
        if not event then continue end
        for i = 1, (AutoParry.WiggleSpam or 5) do
            pcall(function() event:FireServer() end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.2) do
        if not AutoFlee.Enabled then continue end
        local root = getRoot()
        if not root then continue end
        local killerRoot, distance = GetNearestKillerForFlee()
        if killerRoot and distance <= AutoFlee.DetectDistance
           and tick() - AutoFlee.LastFlee > AutoFlee.Cooldown then
            local point = nil
            local farthest = 0
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and string.match(obj.Name, "^GeneratorPoint%d+$") then
                    local d = (obj.Position - killerRoot.Position).Magnitude
                    if d > farthest then
                        farthest = d
                        point = obj
                    end
                end
            end
            if point then
                AutoFlee.LastFlee = tick()
                pcall(function()
                    root.CFrame = point.CFrame + Vector3.new(0, 5, 0)
                end)
            end
        end
    end
end)

task.spawn(function()
    while task.wait(3) do
        if not S.AutoEscapeGate then continue end
        local root = getRoot()
        if not root then continue end

        local killerNear = false
        if S.AutoEscapeUseKillerCheck then
            local kRoot, kDist = GetNearestKillerForFlee()
            if kRoot and kDist <= (S.AutoEscapeRange or 50) then
                killerNear = true
            end
        end

        local genDone = false
        if S.AutoEscapeUseGenCheck then
            local total, done = 0, 0
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj.Name == "Generator" then
                    total = total + 1
                    local p = obj:GetAttribute("RepairProgress")
                        or obj:GetAttribute("Progress") or 0
                    if p >= 100 then done = done + 1 end
                end
            end
            if total > 0 and done >= total then genDone = true end
        end

        if killerNear or genDone then
            local found = nil
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    local n = string.lower(obj.Name)
                    if n == "fininshline" or n == "finishline"
                       or n == "escape" or n == "escapegate"
                       or string.find(n, "escape") then
                        found = obj
                        break
                    end
                end
            end
            if found then
                pcall(function()
                    root.CFrame = found.CFrame + Vector3.new(0, 5, 0)
                end)
            end
        end
    end
end)

LP.CharacterAdded:Connect(function(char)
    task.wait(1)
    if FastVault.Enabled then
        pcall(function() hookVault(char) end)
    end
end)

if LP.Character then
    pcall(function() hookVault(LP.Character) end)
end

task.spawn(function()
    while task.wait(0.2) do
        if not S.AutoCarry or KillerBusy then continue end

        local CarryEvent = ReplicatedStorage:FindFirstChild("Remotes", true)
            and ReplicatedStorage.Remotes:FindFirstChild("Carry", true)
            and ReplicatedStorage.Remotes.Carry:FindFirstChild("CarrySurvivorEvent")
        local HookEvent = ReplicatedStorage:FindFirstChild("Remotes", true)
            and ReplicatedStorage.Remotes:FindFirstChild("Carry", true)
            and ReplicatedStorage.Remotes.Carry:FindFirstChild("HookEvent")

        if not CarryEvent or not HookEvent then continue end

        local target = GetDownedSurvivor()
        local root = getRoot()

        if target and root then
            KillerBusy = true
            local tRoot = target:FindFirstChild("HumanoidRootPart")
            if tRoot then
                root.CFrame = tRoot.CFrame * CFrame.new(0, 3, -2)
                task.wait(0.4)
                for i = 1, 4 do
                    pcall(function() CarryEvent:FireServer(target) end)
                    task.wait(0.2)
                end
                task.wait(0.6)
                if S.AutoHook then
                    local hook = GetHookPoint()
                    if hook then
                        root.CFrame = hook.CFrame * CFrame.new(0, 4, -3)
                        task.wait(0.7)
                        for i = 1, 6 do
                            pcall(function() HookEvent:FireServer(hook) end)
                            task.wait(0.15)
                        end
                    end
                end
            end
            task.delay(2, function() KillerBusy = false end)
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if S.NoScreenEffects then applyNoScreenEffects() end
        if S.LowGraphics then applyLowGraphics() end
        if S.CleanSky then applyCleanSky() end
    end
end)

task.spawn(function()
    while task.wait(8) do
        if S.SkyId and S.SkyId ~= "Default" then
            local currentSky = nil
            for _, v in pairs(Lighting:GetChildren()) do
                if v:IsA("Sky") then
                    currentSky = v
                    break
                end
            end
            if not currentSky or not currentSky.Name:find("OneWSky_") then
                pcall(function() applySky(S.SkyId) end)
            end
        end
        if S.FireOn and LP.Character then
            local head = LP.Character:FindFirstChild("Head")
            if head and not head:FindFirstChild("RoooorFire") then
                pcall(applyFire)
            end
        end
    end
end)

task.spawn(function()
    RunService.RenderStepped:Connect(function()
        if S.FOVEnabled then
            local cam = workspace.CurrentCamera
            if cam and math.abs(cam.FieldOfView - S.FOV) > 0.5 then
                pcall(function()
                    cam.FieldOfView = S.FOV
                end)
            end
        end
    end)
end)

task.spawn(function()
    while task.wait(0.3) do
        if not Hitbox.Enabled then
            hitboxClearAll()
            continue
        end

        local myRoot = getRoot()
        if not myRoot then continue end
        local myTeam = LP.Team and LP.Team.Name or ""

        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then
                local targetTeam = p.Team and p.Team.Name or ""
                local shouldHit = false

                if Hitbox.Mode == "Auto" then
                    if myTeam == "Survivors" and targetTeam == "Killer" then
                        shouldHit = true
                    elseif myTeam == "Killer" and targetTeam == "Survivors" then
                        shouldHit = true
                    end
                elseif Hitbox.Mode == "Killer" and targetTeam == "Killer" then
                    shouldHit = true
                elseif Hitbox.Mode == "Survivor" and targetTeam == "Survivors" then
                    shouldHit = true
                end

                if shouldHit then
                    local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                    local hum = p.Character:FindFirstChildOfClass("Humanoid")
                    if hrp and hum and hum.Health > 0 then
                        local dist = (hrp.Position - myRoot.Position).Magnitude
                        if not HitboxOriginalSizes[hrp] then
                            HitboxOriginalSizes[hrp] = hrp.Size
                        end
                        if dist <= Hitbox.Size then
                            hrp.Size = Vector3.new(Hitbox.Size, Hitbox.Size, Hitbox.Size)
                            hrp.Transparency = 1
                            hrp.CanCollide = not Hitbox.WallBang
                        end

                        local color = (targetTeam == "Killer")
                            and Hitbox.ColorKiller
                            or Hitbox.ColorSurvivor

                        hitboxCreateText(hrp, Hitbox.Size, color)
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(5) do
        if GraphicState.SoftCinematic then
            local hasEffects = Lighting:FindFirstChild("OneWGraphic_Bloom")
            if not hasEffects then
                pcall(GraphicApplySoftCinematic)
            end
        end
    end
end)

workspace.DescendantAdded:Connect(function(obj)
    task.defer(function()
        if GraphicState.SoftCinematic and obj:IsA("BasePart") then
            if GraphicPartBackup[obj] == nil then
                GraphicPartBackup[obj] = obj.CastShadow
            end
            obj.CastShadow = true
        end
    end)
end)

LP.CharacterAdded:Connect(function(char)
    task.wait(1.5)
    if GraphicState.SoftCinematic then
        pcall(GraphicApplyCharacterShadow)
    end
end)-- SECTION 11/15 : PRINT FINAL

task.wait(0.5)

print("╔══════════════════════════╗")
print("║        ONE W             ║")
print("║   SEMUA FITUR LOADED     ║")
print("╠══════════════════════════╣")
print("║   RightShift = Menu      ║")
print("║   V = Moonwalk           ║")
print("║   K = Unlock Camera      ║")
print("╚══════════════════════════╝")-- SECTION 12/15 : AIMBOT TAB

Aimlock_AttackButtons = Aimlock_AttackButtons or {}

local function isAttackButton(obj)
    if not obj:IsA("GuiObject") then return false end
    local n = string.lower(obj.Name)
    if n:find("attack") or n:find("slash") or n:find("swing") or n:find("hit") then
        return true
    end
    return false
end

function Aimlock_ScanAttackButtons()
    table.clear(Aimlock_AttackButtons)
    for _, obj in pairs(PG:GetDescendants()) do
        if isAttackButton(obj) and obj.Visible then
            table.insert(Aimlock_AttackButtons, obj)
        end
    end
end

function Aimlock_HookAttackButtons()
    Aimlock_ScanAttackButtons()
    for _, btnObj in ipairs(Aimlock_AttackButtons) do
        if not btnObj:GetAttribute("AimlockHooked") then
            btnObj:SetAttribute("AimlockHooked", true)
            btnObj.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch
                   or input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Aimlock.Holding = true
                end
            end)
            btnObj.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch
                   or input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Aimlock.Holding = false
                end
            end)
        end
    end
end

task.spawn(function()
    while task.wait(5) do
        if Aimlock.Enabled then
            Aimlock_HookAttackButtons()
        end
    end
end)

function Aimlock_GetClosestSurvivor()
    local myRoot = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end
    local closest = nil
    local shortest = Aimlock.Radius
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local isTarget = false
            if p.Team and p.Team.Name == Aimlock.TargetTeam then
                isTarget = true
            end
            if isTarget then
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                local targetPart = p.Character:FindFirstChild(Aimlock.AimPart)
                local isDowned = false
                if hum then
                    isDowned = hum.Health <= 0
                        or hum.Health < 2
                        or p.Character:GetAttribute("Downed") == true
                        or p.Character:GetAttribute("IsDown") == true
                        or p.Character:GetAttribute("Knocked") == true
                        or hum:GetState() == Enum.HumanoidStateType.Dead
                        or hum:GetState() == Enum.HumanoidStateType.Physics
                end
                if not isDowned and hum and hum.Health > 0 and targetPart then
                    local dist = (targetPart.Position - myRoot.Position).Magnitude
                    if dist < shortest then
                        shortest = dist
                        closest = targetPart
                    end
                end
            end
        end
    end
    return closest
end

Aimlock_CameraConn = nil

function Aimlock_StartLoop()
    if Aimlock_CameraConn then return end
    Aimlock_CameraConn = RunService.RenderStepped:Connect(function()
        if not Aimlock.Enabled then return end
        if not Aimlock.Holding then return end
        local cam = workspace.CurrentCamera
        if not cam then return end
        local target = Aimlock_GetClosestSurvivor()
        if not target then return end
        Aimlock.CurrentTarget = target
        local camPos = cam.CFrame.Position
        local targetPos = target.Position
        cam.CFrame = CFrame.new(camPos, targetPos)
    end)
end

function Aimlock_StopLoop()
    if Aimlock_CameraConn then
        Aimlock_CameraConn:Disconnect()
        Aimlock_CameraConn = nil
    end
    Aimlock.CurrentTarget = nil
    local cam = workspace.CurrentCamera
    local char = LP.Character
    if cam and char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            pcall(function()
                cam.CameraType = Enum.CameraType.Custom
                cam.CameraSubject = hum
            end)
        end
    end
end

Aimlock_Gui = nil
Aimlock_FloatingBtn = nil
Aimlock_FloatingPanel = nil

function Aimlock_CreateFloatingGUI()
    if Aimlock_Gui then Aimlock_Gui:Destroy() end
    Aimlock_Gui = Instance.new("ScreenGui")
    Aimlock_Gui.Name = "OneWAimlockFloating"
    Aimlock_Gui.ResetOnSpawn = false
    Aimlock_Gui.IgnoreGuiInset = true
    Aimlock_Gui.Parent = PG

    Aimlock_FloatingBtn = Instance.new("TextButton")
    Aimlock_FloatingBtn.Size = UDim2.new(0, 45, 0, 45)
    Aimlock_FloatingBtn.Position = UDim2.new(0, 20, 0, 90)
    Aimlock_FloatingBtn.BackgroundColor3 = Color3.fromRGB(80, 60, 15)
    Aimlock_FloatingBtn.Text = "A"
    Aimlock_FloatingBtn.TextSize = 20
    Aimlock_FloatingBtn.Font = Enum.Font.GothamBlack
    Aimlock_FloatingBtn.TextColor3 = C.GOLD
    Aimlock_FloatingBtn.BorderSizePixel = 0
    Aimlock_FloatingBtn.AutoButtonColor = false
    Aimlock_FloatingBtn.Draggable = true
    Aimlock_FloatingBtn.Active = true
    Aimlock_FloatingBtn.Parent = Aimlock_Gui

    local corner1 = Instance.new("UICorner")
    corner1.CornerRadius = UDim.new(1, 0)
    corner1.Parent = Aimlock_FloatingBtn

    local stroke1 = Instance.new("UIStroke")
    stroke1.Thickness = 2
    stroke1.Color = C.GOLD
    stroke1.Parent = Aimlock_FloatingBtn

    Aimlock_FloatingPanel = Instance.new("Frame")
    Aimlock_FloatingPanel.Size = UDim2.new(0, 240, 0, 140)
    Aimlock_FloatingPanel.Position = UDim2.new(0.5, -120, 0.5, -70)
    Aimlock_FloatingPanel.BackgroundColor3 = C.BG
    Aimlock_FloatingPanel.BackgroundTransparency = 0.05
    Aimlock_FloatingPanel.BorderSizePixel = 0
    Aimlock_FloatingPanel.Visible = false
    Aimlock_FloatingPanel.Parent = Aimlock_Gui

    local corner2 = Instance.new("UICorner")
    corner2.CornerRadius = UDim.new(0, 14)
    corner2.Parent = Aimlock_FloatingPanel

    local stroke2 = Instance.new("UIStroke")
    stroke2.Thickness = 2
    stroke2.Color = C.GOLD
    stroke2.Parent = Aimlock_FloatingPanel

    local hdr = Instance.new("Frame")
    hdr.Size = UDim2.new(1, 0, 0, 28)
    hdr.BackgroundColor3 = C.PANEL2
    hdr.BorderSizePixel = 0
    hdr.Parent = Aimlock_FloatingPanel

    local hdrCorner = Instance.new("UICorner")
    hdrCorner.CornerRadius = UDim.new(0, 14)
    hdrCorner.Parent = hdr

    local hdrPatch = Instance.new("Frame")
    hdrPatch.Size = UDim2.new(1, 0, 0, 14)
    hdrPatch.Position = UDim2.new(0, 0, 1, -14)
    hdrPatch.BackgroundColor3 = C.PANEL2
    hdrPatch.BorderSizePixel = 0
    hdrPatch.Parent = hdr

    local ttl = Instance.new("TextLabel")
    ttl.Size = UDim2.new(1, -40, 1, 0)
    ttl.Position = UDim2.new(0, 10, 0, 0)
    ttl.BackgroundTransparency = 1
    ttl.Text = "AIMLOCK"
    ttl.TextColor3 = C.GOLD
    ttl.TextSize = 11
    ttl.Font = Enum.Font.GothamBlack
    ttl.TextXAlignment = Enum.TextXAlignment.Left
    ttl.Parent = hdr

    local clsBtn = Instance.new("TextButton")
    clsBtn.Size = UDim2.new(0, 20, 0, 20)
    clsBtn.Position = UDim2.new(1, -26, 0.5, -10)
    clsBtn.BackgroundColor3 = C.BG
    clsBtn.Text = "X"
    clsBtn.TextColor3 = C.RED
    clsBtn.TextSize = 10
    clsBtn.Font = Enum.Font.GothamBlack
    clsBtn.BorderSizePixel = 0
    clsBtn.Parent = hdr

    local clsCorner = Instance.new("UICorner")
    clsCorner.CornerRadius = UDim.new(0, 5)
    clsCorner.Parent = clsBtn

    local radLbl = Instance.new("TextLabel")
    radLbl.Name = "RadiusLabel"
    radLbl.Size = UDim2.new(1, -20, 0, 14)
    radLbl.Position = UDim2.new(0, 10, 0, 60)
    radLbl.BackgroundTransparency = 1
    radLbl.Text = string.format("Radius: %.0f", Aimlock.Radius)
    radLbl.TextColor3 = C.TXT
    radLbl.TextSize = 9
    radLbl.Font = Enum.Font.GothamMedium
    radLbl.TextXAlignment = Enum.TextXAlignment.Left
    radLbl.Parent = Aimlock_FloatingPanel

    Aimlock_FloatingBtn.MouseButton1Click:Connect(function()
        Aimlock_FloatingPanel.Visible = not Aimlock_FloatingPanel.Visible
    end)

    clsBtn.MouseButton1Click:Connect(function()
        Aimlock_FloatingPanel.Visible = false
    end)
end

function Aimlock_RemoveFloatingGUI()
    if Aimlock_Gui then
        Aimlock_Gui:Destroy()
        Aimlock_Gui = nil
        Aimlock_FloatingBtn = nil
        Aimlock_FloatingPanel = nil
    end
end

makeTab("Aimbot", "🎯", 10, function()
    sec("Aimbot", "🎯")
    tog("Enable Aimbot", false, function(s)
        Aimlock.Enabled = s
        if s then
            Aimlock_HookAttackButtons()
            Aimlock_StartLoop()
        else
            Aimlock.Holding = false
            Aimlock_StopLoop()
        end
    end)

    sec("Floating GUI", "👁️")
    tog("Show Aimbot GUI", false, function(s)
        if s then
            Aimlock_CreateFloatingGUI()
        else
            Aimlock_RemoveFloatingGUI()
        end
    end)

    sec("Radius", "📏")
    sl("Aimbot Radius", 5, 100, 80, function(v)
        Aimlock.Radius = v
        if Aimlock_FloatingPanel then
            local radLbl = Aimlock_FloatingPanel:FindFirstChild("RadiusLabel")
            if radLbl then
                radLbl.Text = string.format("Radius: %.0f", v)
            end
        end
    end)
end, function()
    sec("Target", "🎯", rightScroll)
    drp("Aim Part", {"HumanoidRootPart", "Head", "UpperTorso"}, "HumanoidRootPart", function(v)
        Aimlock.AimPart = v
    end, rightScroll)

    sec("Test", "🔧", rightScroll)
    btn("Scan Attack Buttons", function()
        Aimlock_ScanAttackButtons()
    end, rightScroll)
    btn("Toggle Floating GUI", function()
        if Aimlock_Gui then Aimlock_RemoveFloatingGUI()
        else Aimlock_CreateFloatingGUI() end
    end, rightScroll)
end)-- =========================================================
-- SECTION 13/15 : ANTI-ILANG MENU + AUTO RECOVERY
-- =========================================================

pcall(function()
    if gui then gui.ResetOnSpawn = false end
    if killFeedGui then killFeedGui.ResetOnSpawn = false end
    if mwBtnGui then mwBtnGui.ResetOnSpawn = false end
    if crosshairGui then crosshairGui.ResetOnSpawn = false end
    if fpsPingGui then fpsPingGui.ResetOnSpawn = false end
    if loadingGui then loadingGui.ResetOnSpawn = false end
    if Aimlock_Gui then Aimlock_Gui.ResetOnSpawn = false end
    if AimbotLaserGui then AimbotLaserGui.ResetOnSpawn = false end
end)

local function ForceResetOnSpawnFalse()
    for _, g in ipairs(PG:GetChildren()) do
        if g:IsA("ScreenGui") then
            pcall(function()
                g.ResetOnSpawn = false
                g.Enabled = true
            end)
        end
    end
end

task.spawn(function()
    while task.wait(0.2) do
        pcall(ForceResetOnSpawnFalse)
    end
end)

print("[ANTI-HILANG] Force ResetOnSpawn = false aktif")

-- =========================================================
-- SCRIPT URL (buat re-execute kalau GUI ilang total)
-- =========================================================
local SCRIPT_URL = "https://raw.githubusercontent.com/tiarkenn-dev/one-W/main/main.lua"

function RecreateAllGUI()
    local coreGui = game:GetService("CoreGui")

    if not gui or not gui.Parent then
        local existing = PG:FindFirstChild("OneWHub")
            or (coreGui and coreGui:FindFirstChild("OneWHub"))
        if existing then
            gui = existing
            gui.ResetOnSpawn = false
            gui.Enabled = true
            print("[RECOVERY] OneWHub recovered")
        else
            warn("[RECOVERY] OneWHub ilang total, re-execute SC...")
            task.spawn(function()
                pcall(function()
                    loadstring(game:HttpGet(SCRIPT_URL))()
                end)
            end)
        end
    end

    if not fpsPingGui or not fpsPingGui.Parent then
        local existing = PG:FindFirstChild("OneWFPSPing")
        if existing then
            fpsPingGui = existing
            fpsPingGui.ResetOnSpawn = false
        else
            pcall(createFPSPingGui)
        end
    end

    if not mwBtnGui or not mwBtnGui.Parent then
        local existing = PG:FindFirstChild("MW_BottomBtn")
        if existing then
            mwBtnGui = existing
            mwBtnGui.ResetOnSpawn = false
        end
    end

    if not killFeedGui or not killFeedGui.Parent then
        local existing = PG:FindFirstChild("OneWKillFeed")
        if existing then
            killFeedGui = existing
            killFeedGui.ResetOnSpawn = false
        end
    end

    if crosshairGui and not crosshairGui.Parent then
        crosshairGui = nil
    end

    if Aimlock_Gui and not Aimlock_Gui.Parent then
        Aimlock_Gui = nil
    end

    if AimbotLaserGui and not AimbotLaserGui.Parent then
        AimbotLaserGui = nil
    end
end

task.spawn(function()
    while task.wait(0.5) do
        pcall(RecreateAllGUI)
    end
end)

LP.CharacterAdded:Connect(function(char)
    task.wait(1)
    print("[RESPAWN] Menu restored - fitur manual")
    task.wait(0.3)
    pcall(RecreateAllGUI)
    pcall(ForceResetOnSpawnFalse)
    print("[RESPAWN] Selesai!")
end)

-- =========================================================
-- DETEKSI PINDAH PLACE
-- =========================================================
local _lastPlaceId = game.PlaceId
task.spawn(function()
    while task.wait(2) do
        pcall(function()
            if game.PlaceId ~= _lastPlaceId then
                print("[PLACE-CHANGE] Pindah place!")
                print("  Old:", _lastPlaceId, "-> New:", game.PlaceId)
                _lastPlaceId = game.PlaceId
                task.wait(3)
                pcall(RecreateAllGUI)
                pcall(ForceResetOnSpawnFalse)
                print("[PLACE-CHANGE] Menu restored")
            end
        end)
    end
end)

print("")
print("═══════════════════════════════════════════")
print("  SECTION 13 - ANTI-ILANG MENU (ONE W)")
print("═══════════════════════════════════════════")
print("  ✅ ResetOnSpawn = false (semua GUI)")
print("  ✅ Force loop tiap 0.2 detik")
print("  ✅ Recovery loop tiap 0.5 detik")
print("  ✅ Cek PG + CoreGui")
print("  ✅ Auto re-execute kalo GUI ilang total")
print("  ✅ Menu restored pas respawn")
print("  ✅ Menu restored pas pindah place")
print("═══════════════════════════════════════════")
print("✅ [13/15] ANTI-ILANG MENU LOADED")
print("")
print("🎯 Klik tombol W / RightShift untuk buka menu")
print("🛡️ Auto Parry: Tab Survivor")
print("🔦 Aimbot Senter: HOLD = INSTANT LOCK ke Head Killer")
print("🎬 Grafik Ultra: Tab baru (16 preset)")
print("")-- =========================================================
-- SECTION 14/15 : FINAL FIX (AUTO PARRY + CAMERA + MENU)
-- =========================================================

-- ============================================
-- 14.1 AUTO PARRY - TRIPLE LAYER DETECTION
-- ============================================
AP_v14_Count = 0
AP_v14_LastParry = 0
AP_v14_Config = {
    Debounce = 0.015,
    Radius = 25,
    MinVelocity = 6,
    SpamTap = 4,
}

function AP_v14_PressParry()
    for i = 1, 2 do
        VirtualInputManager:SendMouseButtonEvent(0, 0, 1, true, game, 0)
        task.wait(0.001)
        VirtualInputManager:SendMouseButtonEvent(0, 0, 1, false, game, 0)
        task.wait(0.001)
    end

    local parryBtn = AP_FindParryButton()
    if parryBtn and parryBtn:IsA("GuiObject") then
        local pos = parryBtn.AbsolutePosition
        local size = parryBtn.AbsoluteSize
        local inset = GuiService:GetGuiInset()
        local x = pos.X + size.X / 2 + inset.X
        local y = pos.Y + size.Y / 2 + inset.Y
        for i = 1, AP_v14_Config.SpamTap do
            VirtualInputManager:SendTouchEvent(9900 + i, 0, x, y)
            task.wait(0.001)
            VirtualInputManager:SendTouchEvent(9900 + i, 2, x, y)
            task.wait(0.001)
        end
    end

    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
    task.wait(0.001)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
end

function AP_v14_IsAttacking(killerChar, killerHum)
    local animator = killerHum:FindFirstChildOfClass("Animator")
    if animator then
        for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
            local a = track.Animation
            if a and a.AnimationId then
                local id = a.AnimationId:match("%d+")
                if SkipAnims and SkipAnims[id] then
                    return false
                end
                if KillerAnims["rbxassetid://" .. id] then
                    return true
                end
            end
        end
    end

    local root = killerChar:FindFirstChild("HumanoidRootPart")
    if root then
        if root.AssemblyLinearVelocity.Magnitude > AP_v14_Config.MinVelocity then
            return true
        end
    end

    if killerChar:GetAttribute("Attacking") == true then return true end
    if killerChar:GetAttribute("IsAttacking") == true then return true end

    return false
end

task.spawn(function()
    while task.wait(0.001) do
        if not AutoParry.Enabled then continue end

        local myRoot = getRoot()
        if not myRoot then continue end
        local myHum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
        if not myHum or myHum.Health <= 0 then continue end

        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Team and p.Team.Name == "Killer" then
                local kRoot = p.Character:FindFirstChild("HumanoidRootPart")
                local kHum = p.Character:FindFirstChildOfClass("Humanoid")

                if kRoot and kHum and kHum.Health > 0 then
                    local dist = (kRoot.Position - myRoot.Position).Magnitude
                    if dist <= AP_v14_Config.Radius then
                        if AP_v14_IsAttacking(p.Character, kHum) then
                            local now = tick()
                            if now - AP_v14_LastParry > AP_v14_Config.Debounce then
                                AP_v14_LastParry = now
                                AP_v14_PressParry()
                                AP_v14_Count = AP_v14_Count + 1
                            end
                        end
                    end
                end
            end
        end
    end
end)

print("✅ [14/15] Auto Parry - Triple Layer Loaded (ONE W)")

-- ============================================
-- 14.2 NO CAMERA LOCK - FORCE UNLOCK
-- ============================================
task.spawn(function()
    while task.wait(0.03) do
        local cam = workspace.CurrentCamera
        local char = LP.Character
        if not cam or not char then continue end

        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then continue end

        if AimbotSenter.Enabled and AimbotSenter.HoldingSenter then
            continue
        end

        pcall(function()
            if cam.CameraType ~= Enum.CameraType.Custom then
                cam.CameraType = Enum.CameraType.Custom
            end
            if cam.CameraSubject ~= hum then
                cam.CameraSubject = hum
            end
        end)
    end
end)

local function ForceUnlockV14()
    task.spawn(function()
        task.wait(0.05)
        local cam = workspace.CurrentCamera
        local char = LP.Character
        if cam and char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum and not (AimbotSenter.Enabled and AimbotSenter.HoldingSenter) then
                pcall(function()
                    cam.CameraType = Enum.CameraType.Custom
                    cam.CameraSubject = hum
                    cam.CameraMode = Enum.CameraMode.Classic
                end)
            end
        end
    end)
end

local function HookKillerUnlockV14(char)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local animator = hum:FindFirstChildOfClass("Animator")
    if not animator then return end

    animator.AnimationPlayed:Connect(function(track)
        local a = track.Animation
        if not a or not a.AnimationId then return end
        local id = a.AnimationId:match("%d+")
        if id == "127096285501517" or id == "123047897844134" or id == "112166042383605" then
            ForceUnlockV14()
        end
    end)
end

for _, p in pairs(Players:GetPlayers()) do
    if p ~= LP and p.Character and p.Team and p.Team.Name == "Killer" then
        task.spawn(function() HookKillerUnlockV14(p.Character) end)
    end
    p.CharacterAdded:Connect(function(c)
        task.wait(1)
        if p.Team and p.Team.Name == "Killer" then
            HookKillerUnlockV14(c)
        end
    end)
end

LP.CharacterAdded:Connect(function(char)
    task.wait(1)
    local cam = workspace.CurrentCamera
    local hum = char:WaitForChild("Humanoid", 5)
    if cam and hum then
        pcall(function()
            cam.CameraType = Enum.CameraType.Custom
            cam.CameraSubject = hum
        end)
    end
end)

print("✅ [14/15] No Camera Lock Loaded (ONE W)")

-- ============================================
-- 14.3 MENU PERMANEN - FORCE RECREATE
-- ============================================
local function ForceGUIV14()
    for _, g in ipairs(PG:GetChildren()) do
        if g:IsA("ScreenGui") then
            pcall(function()
                g.ResetOnSpawn = false
                g.Enabled = true
            end)
        end
    end
end

task.spawn(function()
    while task.wait(0.15) do
        pcall(ForceGUIV14)

        local coreGui = game:GetService("CoreGui")

        if not gui or not gui.Parent then
            local existing = PG:FindFirstChild("OneWHub")
                or (coreGui and coreGui:FindFirstChild("OneWHub"))
            if existing then
                gui = existing
                gui.ResetOnSpawn = false
                gui.Enabled = true
            end
        end

        if not fpsPingGui or not fpsPingGui.Parent then
            local existing = PG:FindFirstChild("OneWFPSPing")
            if existing then
                fpsPingGui = existing
                fpsPingGui.ResetOnSpawn = false
            else
                pcall(createFPSPingGui)
            end
        end

        if not mwBtnGui or not mwBtnGui.Parent then
            local existing = PG:FindFirstChild("MW_BottomBtn")
            if existing then
                mwBtnGui = existing
                mwBtnGui.ResetOnSpawn = false
            end
        end

        if not killFeedGui or not killFeedGui.Parent then
            local existing = PG:FindFirstChild("OneWKillFeed")
            if existing then
                killFeedGui = existing
                killFeedGui.ResetOnSpawn = false
            end
        end

        if not AimbotLaserGui or not AimbotLaserGui.Parent then
            local existing = PG:FindFirstChild("OneWAimbotLaser")
            if existing then
                AimbotLaserGui = existing
                AimbotLaserGui.ResetOnSpawn = false
            end
        end
    end
end)

LP.CharacterAdded:Connect(function(char)
    task.wait(0.3)
    pcall(ForceGUIV14)
end)

print("✅ [14/15] Menu Permanen Loaded (ONE W)")

print("")
print("═══════════════════════════════════════════")
print("  ✅ [14/15] SECTION 14 LOADED (ONE W)")
print("  🛡️ Auto Parry: TRIPLE LAYER")
print("  📷 No Camera Lock: FORCE UNLOCK")
print("  🖥️  Menu Permanen: FORCE RECREATE")
print("═══════════════════════════════════════════")
print("")-- =========================================================
-- SECTION 15/15 : AUTO-ON FITUR + PRINT FINAL
-- =========================================================
-- NOTE: Aimbot Senter logic ada di Section 4 (cuma 1 handler)

task.spawn(function()
    task.wait(3)

    ESP.Killer = true
    _G.ToggleStates["ESP Killer"] = true

    ESP.Generator = true
    _G.ToggleStates["ESP Generator"] = true

    ESP.Survivor = true
    _G.ToggleStates["ESP Survivor"] = true

    S.ESPGenMode = "Bar"
    _G.DropdownStates["Generator Mode"] = 2

    S.ESPGenBarSize = 64
    _G.SliderStates["Bar Width"] = 64

    S.ESPGenBarHeight = 8
    _G.SliderStates["Bar Height"] = 8

    S.ESPNameSize = 8
    _G.SliderStates["Name Size"] = 8

    S.ESPNameMode = "Galaxy"
    _G.DropdownStates["Name Mode"] = 2

    S.Korblox = true
    _G.ToggleStates["Enable Korblox"] = true
    task.wait(0.3)
    pcall(function() applyKorblox(true, "Pencil", 0.80, 1) end)

    S.Headless = true
    _G.ToggleStates["Headless"] = true
    task.wait(0.3)
    pcall(function() applyHeadless(true) end)

    print("[AUTO-ON] ✅ Selesai!")
    print("[AUTO-ON] - ESP Killer: ON")
    print("[AUTO-ON] - ESP Generator: ON (Bar Mode)")
    print("[AUTO-ON] - ESP Survivor: ON")
    print("[AUTO-ON] - Bar Width: 64 | Bar Height: 8")
    print("[AUTO-ON] - Name Size: 8")
    print("[AUTO-ON] - Name Mode: Galaxy")
    print("[AUTO-ON] - Korblox: ON")
    print("[AUTO-ON] - Headless: ON")
end)

print("✅ [15/15] Auto-ON Fitur Loaded")

print("")
print("═══════════════════════════════════════════")
print("  ✅ [15/15] SECTION 15 LOADED (ONE W)")
print("  ⚡ Auto-ON: ESP + Korblox + Headless")
print("  🔦 Aimbot Senter: Section 4 (1 handler)")
print("═══════════════════════════════════════════")
print("")
print("╔══════════════════════════════════════════╗")
print("║   🎉 ONE W - GOLD PREMIUM HUB 🎉         ║")
print("║   SEMUA SECTION LOADED!                  ║")
print("╠══════════════════════════════════════════╣")
print("║   ⌨️  RightShift = Buka Menu             ║")
print("║   ⌨️  V = Moonwalk                       ║")
print("║   ⌨️  K = Unlock Camera                  ║")
print("╠══════════════════════════════════════════╣")
print("║   🎯 Tab yang tersedia:                  ║")
print("║      1. Survivor   (Auto Parry, dll)     ║")
print("║      2. Killer     (Auto Attack, dll)    ║")
print("║      3. ESP        (Highlight + Status)  ║")
print("║      4. Fire       (60 efek + Beam)      ║")
print("║      5. Moonwalk   (Tombol MW)           ║")
print("║      6. Misc       (Speed, FOV, dll)     ║")
print("║      7. Visual     (HD, Korblox, dll)    ║")
print("║      8. Hitbox     (Text Angka)          ║")
print("║      9. Grafik Ultra (Soft Cinematic)    ║")
print("║      10. Aimbot    (Aimlock Killer)      ║")
print("╠══════════════════════════════════════════╣")
print("║   🔦 Aimbot Senter: HOLD = LOCK          ║")
print("║      LEPAS = BEBAS (FIXED, GAK NYANGKUT) ║")
print("║   🎨 Tombol W pakai gambar               ║")
print("║   💰 Theme: GOLD PREMIUM                 ║")
print("╚══════════════════════════════════════════╝")
print("")
print("✅ SEMUA SECTION 1-15 SELESAI!")
print("🎯 Klik tombol W atau RightShift untuk buka menu")
