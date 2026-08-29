

if not LPH_OBFUSCATED then
    LPH_JIT_MAX = function(...) return ... end
    LPH_NO_VIRTUALIZE = function(...) return ... end
    LPH_ENCSTR = function(...) return ... end
    LPH_NO_UPVALUES = function(...) return ... end
    LPH_JIT = function(...) return ... end
end

-- > ( bypass )

LPH_JIT_MAX(function()
    if not getgenv().done then
        local reg = getreg()

        local callbacks = {}

        for _, connection in getconnections(game:GetService("ScriptContext")["Error"]) do
            local callback = connection["Function"]
            if callback then
                callbacks[#callbacks + 1] = callback
            end
        end

        for _, connection in getconnections(game:GetService("LogService")["MessageOut"]) do
            local callback = connection["Function"]
            if callback then
                callbacks[#callbacks + 1] = callback
            end
        end

        for _, v in reg do
            if typeof(v) == "function" and islclosure(v) then
                for i = 1, #callbacks do
                    if callbacks[i] == v then
                        reg[_] = function() end
                        break
                    end
                end
            end
        end

        getgenv().done = true
    end
end)()







--========================================================--
--  LOAD LIBRARY
--========================================================--

library = loadstring(game:HttpGet("https://raw.githubusercontent.com/jojosbytes/Library/refs/heads/main/MainLib.lua"))()

flags = library.flags

--========================================================--
--  WINDOW SETUP
--========================================================--

MarketPlaceService = game:GetService("MarketplaceService")
GameName = MarketPlaceService:GetProductInfoAsync(game.PlaceId).Name

window = library:window({
    name = "ERME - " .. tostring(GameName) .. " | universal" ,
    size = UDim2.fromOffset(550, 650),
})


window.toggle_playerlist(false)
window.toggle_watermark(false)
library:update_theme("accent", Color3.fromRGB(255, 143, 229))

--========================================================--
--  CONFIGURATION
--========================================================--
local Config = {
	AimKey = Enum.KeyCode.Q,
	AimPart = "Torso",
	CamLockActive = false,
	CFrame_Speed = false,
	CFrame_Speed_Amount = 1,
	CurrentStompList = {},
	DesyncV2Enabled = false,
	Desyncenabled = false,
	DropDownUpdate = nil,
	Enabled = false,
	FovFiled = false,
	FovSize = 100,
	FovTransparency = 0,
	GunType = '[Revolver]',
	HitChance = 100,
	Ignore_Grabing = false,
	KillMethod = "Knife",
	KnockCheck = false,
	Mode = "random",
	MultiTargets = {},
	OrbitDistance = 10,
	OrbitEnabled = false,
	OrbitHeight = 3,
	OrbitSpeed = 5,
	Resolver = false,
	ShowFov = false,
	FovSegments = 64,
	Smoothness = 1,
	CurveStyle = "linear",
	CurvePower = 1,
	JitterAmount = 0,
	UsePrediction = false,
	Prediction = 0.125,
	Skin = 'Galaxy',
	StompEffectClient = 'Mario',
	StompEffectServer = 'goku',
	Stomp_Aura = false,
	StickyTarget = true,
	TargetList = {},
	UseFov = false,
	UseHitChance = true,
	WallCheck = false,
	TeamCheck = false,
	anti_stomp_enabled = false,
	auto_apply_skin = false,
	autoarmor = false,
	autoarmor_loop = nil,
	autoarmor_min = 50,
	breaklooop = false,
	db_skins = {},
	infjump = nil,
	orbitLoop = nil,
	rev_skins = {},
	stomp_type = "Client",
	stompfunc = nil,
	target = nil,
	targeting = nil,
	timeChoke = 0.105,
	timeRelease = 0.005,
	velMax = (128 ^ 2),
	view_connection = false,
	
	
    ESP = {
	Enabled = false,
	BoxESP = false,
	BoxStyle = "Corner",
	BoxFilled = false,
	BoxFillTransparency = 0.5,
	BoxThickness = 1,
	TracerESP = false,
	TracerOrigin = "Bottom",
	TracerThickness = 1,
	HealthESP = false,
	HealthStyle = "Bar",
	HealthTextSuffix = "HP",
	NameESP = false,
	NameMode = "DisplayName",
	ShowDistance = false,
	ToolESP = false,
	DistanceUnit = "studs",
	TextSize = 14,
	TextFont = "Plex",
	GradientEnabled = false,
	GradientA = Color3.fromRGB(255, 120, 120),
	GradientB = Color3.fromRGB(120, 200, 255),
	GradientAngle = 45,
	MaxDistance = 1000,
	MaxDistanceCheck = true,
	RefreshRate = 1/144,
	TeamCheck = false,
	TargetNPCs = true,
	ChamsEnabled = false,
	ChamsTransparency = 0.5,
	XrayEnabled = false,
	XrayActive = false,
	XrayKey = Enum.KeyCode.X,
	XrayMapTransparency = 0.7,
	SkeletonESP = false,
	SkeletonThickness = 1.5,
	SkeletonTransparency = 1,
	RadarEnabled = false,
	RadarSize = 200,
	RadarPositionX = 100,
	RadarPositionY = 100,
	RadarScale = 1,
	RadarBackgroundTransparency = 0.3,
	RadarBorderThickness = 2,
	RadarBackgroundColor = Color3.fromRGB(20, 20, 20),
	RadarBorderColor = Color3.fromRGB(255, 255, 255),
	RadarLocalPlayerColor = Color3.fromRGB(255, 255, 255),
	RadarEnemyColor = Color3.fromRGB(255, 25, 25),
	RadarAvatarBackgroundColor = Color3.fromRGB(255, 255, 255),
	RadarDotSize = 4,
	RadarRange = 500,
	RadarShowCrosshair = true,
	RadarSegments = 64,
	DirectionalArrowsEnabled = false,
	DirectionalArrowsDistance = 100,
	DirectionalArrowsSize = 20,
	DirectionalArrowsOffset = 150,
	DirectionalArrowsThickness = 2,
	DirectionalArrowsTransparency = 1,
	DirectionalArrowsShowDistance = true,
	DirectionalArrowsDistanceTextSize = 14,
	Colors = {
		Box = Color3.fromRGB(255, 255, 255),
		Tracer = Color3.fromRGB(255, 255, 255),
		Text = Color3.fromRGB(255, 255, 255),
		Health = Color3.fromRGB(0, 255, 0),
		Skeleton = Color3.fromRGB(255, 255, 255),
		Chams = Color3.fromRGB(255, 0, 0),
		Arrow = Color3.fromRGB(255, 255, 255),
		Distance = Color3.fromRGB(200, 200, 200),
		HealthLow = Color3.fromRGB(255, 0, 0),
		HealthMedium = Color3.fromRGB(255, 255, 0),
		HealthHigh = Color3.fromRGB(0, 255, 0),
	},
}
}

Config.crosshair = {
	enabled = false,
	follow_mouse = false,
	follow_lerp = 0,
	style = "cross",
	size = 10,
	thickness = 2,
	gap = 4,
	outline_thickness = 1,
	use_gradient = false,
	color = Color3.fromRGB(255, 255, 255),
	gradient_a = Color3.fromRGB(255, 0, 128),
	gradient_b = Color3.fromRGB(0, 200, 255),
	gradient_angle = 0,
	outline_color = Color3.fromRGB(0, 0, 0),
	opacity = 1,
	outline_opacity = 0.8,
	show_outline = true,
	show_center_dot = false,
	center_dot_size = 3,
	center_dot_color = Color3.fromRGB(255, 255, 255),
	center_dot_gradient = false,
	dot_filled = true,
	dot_radius = 4,
	circle_radius = 20,
	circle_segments = 64,
	sniper_gap_scale = 2,
	dynamic_spread = false,
	spread_multiplier = 1,
	anim_style = "none",
	anim_speed = 1,
	anim_intensity = 1,
}
Config.fov = {
	follow_mouse = true,
	follow_lerp = 0,
	use_gradient = false,
	gradient_a = Color3.fromRGB(255, 100, 0),
	gradient_b = Color3.fromRGB(255, 0, 200),
	gradient_angle = 0,
	segments = 64,
	shape = "circle",
	shape_rotation = 0,
	dashed = false,
	dash_count = 16,
	dash_gap = 0.4,
	double_ring = false,
	double_ring_offset = 10,
	double_ring_opacity = 0.4,
	anim_style = "none",
	anim_speed = 1,
	anim_intensity = 1,
	markers = false,
	marker_count = 4,
	marker_length = 6,
	marker_color = Color3.fromRGB(255, 255, 255),
	marker_opacity = 1,
	color = Color3.fromRGB(255, 255, 255),
}

--========================================================--
--  SERVICES & VARIABLES
--========================================================--

LocalPlayer = game:GetService('Players').LocalPlayer
Players = game:GetService("Players")
UserInputService = game:GetService("UserInputService")
RunService = game:GetService("RunService")
UserInputService = game:GetService("UserInputService")
Workspace = game:GetService("Workspace")
GameID = game.GameId
CurrentCamera = Workspace.CurrentCamera
Camera = CurrentCamera
lighting = game:FindFirstChildOfClass("Lighting")

Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	CurrentCamera = Workspace.CurrentCamera
	Camera = CurrentCamera
end)

LocalPlayer = Players.LocalPlayer

lockedTarget = nil
locked = false
lastValidTarget = nil
orbitAngle = 0

getrawmetatable = getrawmetatable
setreadonly = setreadonly
getnamecallmethod = getnamecallmethod
Drawing = Drawing
fireclickdetector = fireclickdetector
setfflag = setfflag
lastHitChanceRoll = 100
hitChanceHistory = {}

VisibleDot = false
HideMousePos = false
lastValidTargetPlayer = nil

local SKELETON_UPDATE_INTERVAL = 1 / 90
local CHAMS_UPDATE_INTERVAL = 1 / 60

MAX_FOV_SEG = 256

desyncRunning = false
desyncConnections = {}
desyncLoop = nil

Property, Wait = sethiddenproperty, wait
Radian, Random, Ceil = math.rad, math.random, math.ceil
Angle = CFrame.Angles
Vector = Vector3.new
Service = game.GetService

FLYING,QEfly,iyflyspeed,vehicleflyspeed=false,false,5,5

--========================================================--
--  UI SETUP
--========================================================--

local Aim = window:tab({ name = "combat" })
local Extra = window:tab({ name = "extra" })
local Lighting = window:tab({ name = "world" })
local Configs = window:tab({ name = "configs" })

--AIMBOT
local setup = Aim:section({ name = "setup" })
local fov = Aim:section({ name = "fov", side = "right" })
local aimpart = Aim:section({ name = "aim part" })
local checks = Aim:section({ name = "checks", side = "right" })

--EXTRA
local ESPControls = Extra:section({ name = "esp", side = "right" })
local ESPColors = Extra:section({ name = "esp colors" })
local Misc = Extra:section({ name = "misc" })
local crosshair_section = Extra:section({ name = "crosshair" })
local crosshair_col_section = Extra:section({ name = "crosshair colors", side = "right" })
local fov_ext_section = Extra:section({ name = "fov style" })
local fov_col_section = Extra:section({ name = "fov colors", side = "right" })

-- LIGHTING
local lighting_core_section = Lighting:section({ name = "lighting core" })
local sunrays_section = Lighting:section({ name = "sun rays" })
local bloom_section = Lighting:section({ name = "bloom", side = "right" })
local colorcorrection_section = Lighting:section({ name = "color correction", side = "right" })
local dof_section = Lighting:section({ name = "depth of field" })
local blur_section = Lighting:section({ name = "blur", side = "right" })
local weather_section = Lighting:section({ name = "weather" })
local fogsettings = Lighting:section({ name = "fog", side = "right" })
local skysettings = Lighting:section({ name = "sky", side = "right" })
local atmosphere_section = Lighting:section({ name = "atmosphere", side = "right" })

local function safeSection(section)
	if section and type(section) == "table" then
		return section
	end
	return setmetatable({}, { __index = function() return function() end end })
end

setup = safeSection(setup)
checks = safeSection(checks)
fov = safeSection(fov)
aimpart = safeSection(aimpart)
triggerbot_section = safeSection(triggerbot_section)
ESPControls = safeSection(ESPControls)
ESPColors = safeSection(ESPColors)
lighting_core_section = safeSection(lighting_core_section)
sunrays_section = safeSection(sunrays_section)
bloom_section = safeSection(bloom_section)
colorcorrection_section = safeSection(colorcorrection_section)
dof_section = safeSection(dof_section)
blur_section = safeSection(blur_section)
weather_section = safeSection(weather_section)
fogsettings = safeSection(fogsettings)
skysettings = safeSection(skysettings)
atmosphere_section = safeSection(atmosphere_section)

local function safeDrawingNew(typeName)
	if not Drawing or type(Drawing.new) ~= "function" then
		return nil
	end
	local ok, obj = pcall(Drawing.new, typeName)
	if ok then
		return obj
	end
	return nil
end

--========================================================--
--  LIGHTING
--========================================================--

weather_part = nil
weather_particle = nil
atmosphere = nil
sunrays_effect = nil
bloom_effect = nil
color_correction = nil
dof_effect = nil
blur_effect = nil

WeatherConfig = {
    Enabled = false,
    Type = "rain",
    RainVolume = 0.8,
    ThunderVolume = 0.8,
    RainMuted = false,
    ThunderMuted = false,
    Rate = 600,
    Color = Color3.fromRGB(255, 255, 255),
}

weatherPart = nil
weatherParticle = nil
rainSound = nil
thunderSound = nil
thunderLoop = nil

local EffectInfo = {
	SunRays = { ClassName = "SunRaysEffect", Properties = { "Intensity", "Spread" } },
	Bloom = { ClassName = "BloomEffect", Properties = { "Intensity", "Size", "Threshold" } },
	ColorCorrection = { ClassName = "ColorCorrectionEffect", Properties = { "Brightness", "Contrast", "Saturation", "TintColor" } },
	DepthOfField = { ClassName = "DepthOfFieldEffect", Properties = { "FarIntensity", "FocusDistance", "InFocusRadius", "NearIntensity" } },
	Blur = { ClassName = "BlurEffect", Properties = { "Size" } },
	Atmosphere = { ClassName = "Atmosphere", Properties = { "Color", "Decay", "Glare", "Haze", "Offset", "Density" } }
}

local Defaults
local CreatedEffects = {}

local function captureeffectdefaults(effectkey)
	local info = EffectInfo[effectkey]
	if not info then
		return nil
	end
	local effect = lighting:FindFirstChildOfClass(info.ClassName)
	if not effect then
		return nil
	end
	local defaults = {}
	if effect:IsA("PostEffect") then
		defaults.Enabled = effect.Enabled
	end
	for _, prop in ipairs(info.Properties) do
		defaults[prop] = effect[prop]
	end
	return defaults
end

local function ensureeffect(effectkey)
	local info = EffectInfo[effectkey]
	if not info then
		return nil
	end
	local effect = lighting:FindFirstChildOfClass(info.ClassName)
	if not effect then
		effect = Instance.new(info.ClassName)
		effect.Name = "\0"
		effect.Parent = lighting
		CreatedEffects[effectkey] = true
	end
	return effect
end

local function restoreeffectdefaults(effectkey)
	local info = EffectInfo[effectkey]
	if not info then
		return
	end
	local effect = lighting:FindFirstChildOfClass(info.ClassName)
	if not effect then
		return
	end
	local defaults = Defaults.Effects and Defaults.Effects[effectkey]
	if defaults then
		if effect:IsA("PostEffect") and defaults.Enabled ~= nil then
			effect.Enabled = defaults.Enabled
		end
		for _, prop in ipairs(info.Properties) do
			if defaults[prop] ~= nil then
				effect[prop] = defaults[prop]
			end
		end
	else
		if CreatedEffects[effectkey] then
			effect:Destroy()
			CreatedEffects[effectkey] = nil
		elseif effect:IsA("PostEffect") then
			effect.Enabled = false
		end
	end
end

Defaults = {
	Lighting = {},
	Sky = {},
	Effects = {}
}

local function lightingdefault()
    Defaults.Lighting = {
        Ambient = lighting.Ambient,
        Brightness = lighting.Brightness,
        ColorShift_Bottom = lighting.ColorShift_Bottom,
        ColorShift_Top = lighting.ColorShift_Top,
        EnvironmentDiffuseScale = lighting.EnvironmentDiffuseScale,
        EnvironmentSpecularScale = lighting.EnvironmentSpecularScale,
        ExposureCompensation = lighting.ExposureCompensation,
        FogStart = lighting.FogStart,
        FogEnd = lighting.FogEnd,
        FogColor = lighting.FogColor,
        GeographicLatitude = lighting.GeographicLatitude,
        OutdoorAmbient = lighting.OutdoorAmbient,
        ShadowSoftness = lighting.ShadowSoftness,
        ClockTime = lighting.ClockTime,
        GlobalShadows = lighting.GlobalShadows,
        Technology = lighting.Technology
    }

    if lighting:FindFirstChildOfClass("Sky") then
        local sky = lighting:FindFirstChildOfClass("Sky")
        Defaults.Sky = {
            CelestialBodiesShown = sky.CelestialBodiesShown,
            MoonAngularSize = sky.MoonAngularSize,
            MoonTextureId = sky.MoonTextureId,
            SkyboxBk = sky.SkyboxBk,
            SkyboxDn = sky.SkyboxDn,
            SkyboxFt = sky.SkyboxFt,
            SkyboxLf = sky.SkyboxLf,
            SkyboxRt = sky.SkyboxRt,
            SkyboxUp = sky.SkyboxUp,
            StarCount = sky.StarCount,
            SunAngularSize = sky.SunAngularSize,
            SunTextureId = sky.SunTextureId
        }
    end

	Defaults.Effects = {
		SunRays = captureeffectdefaults("SunRays"),
		Bloom = captureeffectdefaults("Bloom"),
		ColorCorrection = captureeffectdefaults("ColorCorrection"),
		DepthOfField = captureeffectdefaults("DepthOfField"),
		Blur = captureeffectdefaults("Blur"),
		Atmosphere = captureeffectdefaults("Atmosphere")
	}
end

lightingdefault()

local lightingen = false
local LightingTechnologyNames = {}
for _, tech in ipairs(Enum.Technology:GetEnumItems()) do
	table.insert(LightingTechnologyNames, tech.Name)
end
table.sort(LightingTechnologyNames)
local SkyboxPresets = {
	["Default"] = {
		SkyboxBk = Defaults.Sky.SkyboxBk or "",
		SkyboxDn = Defaults.Sky.SkyboxDn or "",
		SkyboxFt = Defaults.Sky.SkyboxFt or "",
		SkyboxLf = Defaults.Sky.SkyboxLf or "",
		SkyboxRt = Defaults.Sky.SkyboxRt or "",
		SkyboxUp = Defaults.Sky.SkyboxUp or ""
	},
	["Space Nebula"] = {
		SkyboxBk = "http://www.roblox.com/asset/?id=159454299",
		SkyboxDn = "http://www.roblox.com/asset/?id=159454296",
		SkyboxFt = "http://www.roblox.com/asset/?id=159454293",
		SkyboxLf = "http://www.roblox.com/asset/?id=159454286",
		SkyboxRt = "http://www.roblox.com/asset/?id=159454300",
		SkyboxUp = "http://www.roblox.com/asset/?id=159454288"
	},
	["stormy"] = {
		SkyboxUp = "http://www.roblox.com/asset/?id=18703232671",
		SkyboxBk = "http://www.roblox.com/asset/?id=18703245834",
		SkyboxLf = "http://www.roblox.com/asset/?id=18703237556",
		SkyboxDn = "http://www.roblox.com/asset/?id=18703243349",
		SkyboxFt = "http://www.roblox.com/asset/?id=18703240532",
		SkyboxRt = "http://www.roblox.com/asset/?id=18703235430",
	},
	["blue space"] = {
		SkyboxLf = "rbxassetid://15536114370",
		SkyboxUp = "rbxassetid://15536117282",
		SkyboxRt = "rbxassetid://15536118762",
		SkyboxFt = "rbxassetid://15536116141",
		SkyboxDn = "rbxassetid://15536112543",
		SkyboxBk = "rbxassetid://15536110634",
	},
	["pink"] = {
		SkyboxUp = "rbxassetid://12216108877",
		SkyboxLf = "rbxassetid://12216110170",
		SkyboxRt = "rbxassetid://12216110471",
		SkyboxFt = "rbxassetid://12216109489",
		SkyboxBk = "rbxassetid://12216109205",
		SkyboxDn = "rbxassetid://12216109875",
	},
	["black storm"] = {
		SkyboxLf = "rbxassetid://15502507918",
		SkyboxUp = "rbxassetid://15502511911",
		SkyboxRt = "rbxassetid://15502509398",
		SkyboxFt = "rbxassetid://15502510289",
		SkyboxDn = "rbxassetid://15502508460",
		SkyboxBk = "rbxassetid://15502511288",
	},
	["realistic"] = {
		SkyboxUp = "rbxassetid://653719321",
		SkyboxDn = "rbxassetid://653718790",
		SkyboxLf = "rbxassetid://653719190",
		SkyboxFt = "rbxassetid://653719067",
		SkyboxRt = "rbxassetid://653718931",
		SkyboxBk = "rbxassetid://653719502",
	},
	["Space Sky"] = {
		SkyboxUp = "rbxassetid://16262366016",
		SkyboxDn = "rbxassetid://16262358026",
		SkyboxLf = "rbxassetid://16262362003",
		SkyboxFt = "rbxassetid://16262360469",
		SkyboxRt = "rbxassetid://16262363873",
		SkyboxBk = "rbxassetid://16262356578",
	},
	["Fire Sky"] = {
		SkyboxUp = "rbxassetid://1014449",
		SkyboxDn = "rbxassetid://1012891",
		SkyboxLf = "rbxassetid://1012889",
		SkyboxFt = "rbxassetid://1012887",
		SkyboxRt = "rbxassetid://1012888",
		SkyboxBk = "rbxassetid://1012890",
	},
	["Nebulous Night Sky"] = {
		SkyboxUp = "rbxassetid://131036626982613",
		SkyboxDn = "rbxassetid://92862258103959",
		SkyboxLf = "rbxassetid://126542804346203",
		SkyboxFt = "rbxassetid://107665368823185",
		SkyboxRt = "rbxassetid://103716549795832",
		SkyboxBk = "rbxassetid://95020137072033",
	},
	["Bart Sky"] = {
		SkyboxUp = "rbxassetid://10705312118",
		SkyboxDn = "rbxassetid://10705312118",
		SkyboxLf = "rbxassetid://10705312118",
		SkyboxFt = "rbxassetid://10705312118",
		SkyboxRt = "rbxassetid://10705312118",
		SkyboxBk = "rbxassetid://10705312118",
	},
	["Sponge bob Sky"] = {
		SkyboxUp = "rbxassetid://10287767597",
		SkyboxDn = "rbxassetid://10287766382",
		SkyboxLf = "rbxassetid://10287763421",
		SkyboxFt = "rbxassetid://10287764626",
		SkyboxRt = "rbxassetid://10287764626",
		SkyboxBk = "rbxassetid://10287764626",
	}
	
}

local weather_types_v2 = {
    ["rain"] = {
        Speed = NumberRange.new(60, 60),
        LockedToPart = true,
        Rate = 600,
        Texture = "rbxassetid://1822883048",
        EmissionDirection = Enum.NormalId.Bottom,
        Transparency = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.25, 0.7842668294906616),
            NumberSequenceKeypoint.new(0.75, 0.7842668294906616),
            NumberSequenceKeypoint.new(1, 1)
        },
        Lifetime = NumberRange.new(0.8, 0.8),
        LightEmission = 0.05,
        LightInfluence = 0.9,
        Orientation = Enum.ParticleOrientation.FacingCameraWorldUp,
        Size = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 10),
            NumberSequenceKeypoint.new(1, 10)
        },
        HasRainSound = true,
        HasThunder = false,
        ThunderInterval = nil,
    },
    ["thunderstorm"] = {
        Speed = NumberRange.new(80, 100),
        LockedToPart = true,
        Rate = 800,
        Texture = "rbxassetid://1822883048",
        EmissionDirection = Enum.NormalId.Bottom,
        Transparency = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.2, 0.6),
            NumberSequenceKeypoint.new(0.8, 0.6),
            NumberSequenceKeypoint.new(1, 1)
        },
        Lifetime = NumberRange.new(0.6, 0.7),
        LightEmission = 0.1,
        LightInfluence = 0.7,
        Orientation = Enum.ParticleOrientation.FacingCameraWorldUp,
        Size = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 12),
            NumberSequenceKeypoint.new(1, 12)
        },
        HasRainSound = true,
        HasThunder = true,
        ThunderInterval = {min = 60, max = 120},
    },
    ["strong thunderstorm"] = {
        Speed = NumberRange.new(100, 130),
        LockedToPart = true,
        Rate = 1000,
        Texture = "rbxassetid://1822883048",
        EmissionDirection = Enum.NormalId.Bottom,
        Transparency = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.15, 0.5),
            NumberSequenceKeypoint.new(0.85, 0.5),
            NumberSequenceKeypoint.new(1, 1)
        },
        Lifetime = NumberRange.new(0.5, 0.6),
        LightEmission = 0.15,
        LightInfluence = 0.6,
        Orientation = Enum.ParticleOrientation.FacingCameraWorldUp,
        Size = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 14),
            NumberSequenceKeypoint.new(1, 14)
        },
        HasRainSound = true,
        HasThunder = true,
        ThunderInterval = {min = 60, max = 120},
    },
    ["snow"] = {
        Transparency = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 0.737),
            NumberSequenceKeypoint.new(0.973, 0.768),
            NumberSequenceKeypoint.new(1, 1)
        },
        Texture = "http://www.roblox.com/asset/?id=99851851",
        SpreadAngle = Vector2.new(50, 50),
        Speed = NumberRange.new(30, 30),
        LightEmission = 0.5,
        Rate = 1000,
        EmissionDirection = Enum.NormalId.Bottom,
        Size = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 0.33),
            NumberSequenceKeypoint.new(0.551, 0.40),
            NumberSequenceKeypoint.new(1, 0.33)
        },
        HasRainSound = false,
        HasThunder = false,
        ThunderInterval = nil,
    },
}

function StopThunderLoop()
    if thunderLoop then
        thunderLoop:Disconnect()
        thunderLoop = nil
    end
    if thunderSound then
        thunderSound:Stop()
    end
end

function StartThunderLoop(interval)
    StopThunderLoop()
    if not thunderSound then return end

    local function scheduleThunder()
        local delay = math.random(interval.min, interval.max)
        task.delay(delay, function()
            if thunderLoop == nil then return end
            if not WeatherConfig.ThunderMuted then
                thunderSound.Volume = WeatherConfig.ThunderVolume
                thunderSound:Play()
            end
            scheduleThunder()
        end)
    end
    thunderLoop = RunService.Heartbeat:Connect(function() end)
    scheduleThunder()
end

function StopWeather()
    StopThunderLoop()

    if rainSound then
        rainSound:Stop()
        rainSound:Destroy()
        rainSound = nil
    end
    if thunderSound then
        thunderSound:Destroy()
        thunderSound = nil
    end
    if weatherParticle then
        weatherParticle:Destroy()
        weatherParticle = nil
    end
    if weatherPart then
        weatherPart:Destroy()
        weatherPart = nil
    end
end

function StartWeather(typeName)
    StopWeather()

    local data = weather_types_v2[typeName]
    if not data then return end

    weatherPart = Instance.new("Part")
    weatherPart.Size = Vector3.new(40, 40, 85)
    weatherPart.CanCollide = false
    weatherPart.Massless = true
    weatherPart.CastShadow = false
    weatherPart.Transparency = 1
    weatherPart.Anchored = true
    weatherPart.Name = "\0"
    weatherPart.Parent = workspace

    weatherParticle = Instance.new("ParticleEmitter")
    local skipProps = {HasRainSound = true, HasThunder = true, ThunderInterval = true, Color = true}
    for prop, val in pairs(data) do
        if not skipProps[prop] then
            pcall(function() weatherParticle[prop] = val end)
        end
    end
    weatherParticle.Color = ColorSequence.new(WeatherConfig.Color)
    weatherParticle.Rate = WeatherConfig.Rate
    weatherParticle.Parent = weatherPart

    RunService.RenderStepped:Connect(function()
        if weatherPart and weatherPart.Parent then
            weatherPart.CFrame = CFrame.new(Camera.CFrame.Position) + Vector3.new(0, 20, 0)
        end
    end)

    if data.HasRainSound then
        rainSound = Instance.new("Sound")
        rainSound.SoundId = "rbxassetid://97373672133070"
        rainSound.Looped = true
        rainSound.Volume = WeatherConfig.RainMuted and 0 or WeatherConfig.RainVolume
        rainSound.Parent = workspace
        rainSound:Play()
    end

    if data.HasThunder then
        thunderSound = Instance.new("Sound")
        thunderSound.SoundId = "rbxassetid://118195482769396"
        thunderSound.Looped = false
        thunderSound.Volume = WeatherConfig.ThunderMuted and 0 or WeatherConfig.ThunderVolume
        thunderSound.Parent = workspace
        StartThunderLoop(data.ThunderInterval)
    end
end

--========================================================--
--  ESP FUNCTIONS
--========================================================--

_G.ESPDrawings = {}
_G.ESPHighlights = {}
_G.ESPRadarComponents = {}
_G.ESPDirectionalArrows = {}
_G.ESPSettings = Config.ESP
local EncryptedNameCache = {}
local GetLocalRootPartForESP
local GetBestBasePart
local GetEncryptedEnemyModels
local GetModelHealthValues
local GetEncryptedHeadPart
local GetEncryptedEnemyModelsCached

local PLAYER_LIST_CACHE_TTL = 0.1
local ENCRYPTED_MODEL_CACHE_TTL = 1 / 30
local CHARACTER_CACHE_TTL = 0.2

local PlayersListCache = { List = nil, Stamp = 0 }
local EncryptedModelsCache = { Models = nil, Stamp = 0, TeamCheck = nil }
local CharacterDataCache = setmetatable({}, { __mode = "k" })
local xraymapcache = {}
local xraymapconnection = nil

local CHAMS_PART_NAMES = {
	"Head", "UpperTorso", "LowerTorso",
	"LeftUpperArm", "LeftLowerArm", "LeftHand",
	"RightUpperArm", "RightLowerArm", "RightHand",
	"LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
	"RightUpperLeg", "RightLowerLeg", "RightFoot"
}

local SKELETON_CONNECTION_KEYS = {
	{"Head", "UpperTorso"},
	{"UpperTorso", "LowerTorso"},
	{"UpperTorso", "LeftUpperArm"},
	{"LeftUpperArm", "LeftLowerArm"},
	{"LeftLowerArm", "LeftHand"},
	{"UpperTorso", "RightUpperArm"},
	{"RightUpperArm", "RightLowerArm"},
	{"RightLowerArm", "RightHand"},
	{"LowerTorso", "LeftUpperLeg"},
	{"LeftUpperLeg", "LeftLowerLeg"},
	{"LeftLowerLeg", "LeftFoot"},
	{"LowerTorso", "RightUpperLeg"},
	{"RightUpperLeg", "RightLowerLeg"},
	{"RightLowerLeg", "RightFoot"}
}

local CHAMS_FACES = {
	{1,2,3,4},
	{5,6,7,8},
	{1,2,6,5},
	{2,3,7,6},
	{3,4,8,7},
	{4,1,5,8}
}

local function GetPlayersListCached()
	local now = tick()
	if (now - PlayersListCache.Stamp) >= PLAYER_LIST_CACHE_TTL or not PlayersListCache.List then
		PlayersListCache.List = Players:GetPlayers()
		PlayersListCache.Stamp = now
	end
	return PlayersListCache.List
end

local function GetCharacterDataCache(character)
	if not character then return nil end
	local cache = CharacterDataCache[character]
	if not cache then
		cache = {}
		CharacterDataCache[character] = cache
	end
	return cache
end

local function RefreshCharacterCoreCache(character)
	local cache = GetCharacterDataCache(character)
	if not cache then return nil end

	local now = tick()
	if not cache.CoreStamp or (now - cache.CoreStamp) >= CHARACTER_CACHE_TTL then
		cache.Humanoid = character:FindFirstChildOfClass("Humanoid")
		cache.RootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("HumanoidRootPart", true)
		cache.HeadPart = character:FindFirstChild("Head") or character:FindFirstChild("Head", true)
		cache.CoreStamp = now
	end

	if cache.RootPart and not cache.RootPart:IsDescendantOf(character) then
		cache.RootPart = nil
	end
	if cache.HeadPart and not cache.HeadPart:IsDescendantOf(character) then
		cache.HeadPart = nil
	end
	if cache.Humanoid and not cache.Humanoid:IsDescendantOf(character) then
		cache.Humanoid = nil
	end

	return cache
end

local function RefreshCharacterSkeletonCache(character)
	local cache = GetCharacterDataCache(character)
	if not cache then return nil end

	local now = tick()
	if cache.SkeletonStamp and (now - cache.SkeletonStamp) < CHARACTER_CACHE_TTL and cache.SkeletonData then
		return cache.SkeletonData
	end

	local bones = {
		Head = character:FindFirstChild("Head"),
		UpperTorso = character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso"),
		LowerTorso = character:FindFirstChild("LowerTorso") or character:FindFirstChild("Torso"),
		LeftUpperArm = character:FindFirstChild("LeftUpperArm") or character:FindFirstChild("Left Arm"),
		LeftLowerArm = character:FindFirstChild("LeftLowerArm") or character:FindFirstChild("Left Arm"),
		LeftHand = character:FindFirstChild("LeftHand") or character:FindFirstChild("Left Arm"),
		RightUpperArm = character:FindFirstChild("RightUpperArm") or character:FindFirstChild("Right Arm"),
		RightLowerArm = character:FindFirstChild("RightLowerArm") or character:FindFirstChild("Right Arm"),
		RightHand = character:FindFirstChild("RightHand") or character:FindFirstChild("Right Arm"),
		LeftUpperLeg = character:FindFirstChild("LeftUpperLeg") or character:FindFirstChild("Left Leg"),
		LeftLowerLeg = character:FindFirstChild("LeftLowerLeg") or character:FindFirstChild("Left Leg"),
		LeftFoot = character:FindFirstChild("LeftFoot") or character:FindFirstChild("Left Leg"),
		RightUpperLeg = character:FindFirstChild("RightUpperLeg") or character:FindFirstChild("Right Leg"),
		RightLowerLeg = character:FindFirstChild("RightLowerLeg") or character:FindFirstChild("Right Leg"),
		RightFoot = character:FindFirstChild("RightFoot") or character:FindFirstChild("Right Leg")
	}

	local skeletonData = { Bones = bones, GenericPairs = nil }
	if not (bones.Head and bones.UpperTorso) then
		local root = GetBestBasePart(character, "HumanoidRootPart")
		local high, low, left, right = nil, nil, nil, nil
		for _, obj in ipairs(character:GetDescendants()) do
			if obj:IsA("BasePart") then
				if not high or obj.Position.Y > high.Position.Y then high = obj end
				if not low or obj.Position.Y < low.Position.Y then low = obj end
				if not left or obj.Position.X < left.Position.X then left = obj end
				if not right or obj.Position.X > right.Position.X then right = obj end
			end
		end
		skeletonData.GenericPairs = {
			{high, root},
			{root, low},
			{root, left},
			{root, right}
		}
	end

	cache.SkeletonData = skeletonData
	cache.SkeletonStamp = now
	return skeletonData
end

local function RefreshCharacterChamsPartCache(character)
	local cache = GetCharacterDataCache(character)
	if not cache then return nil, false end

	local now = tick()
	if cache.ChamsStamp and (now - cache.ChamsStamp) < CHARACTER_CACHE_TTL and cache.ChamsEntries then
		return cache.ChamsEntries, cache.ChamsHasNamed
	end

	local entries = {}
	local hasNamedPart = false

	for _, partName in ipairs(CHAMS_PART_NAMES) do
		local part = character:FindFirstChild(partName)
		if part and part:IsA("BasePart") then
			hasNamedPart = true
			entries[#entries + 1] = { key = partName, part = part }
		end
	end

	if not hasNamedPart then
		local count = 0
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") and part.Transparency < 1 and part.Size.Magnitude > 0.2 then
				count = count + 1
				if count > 30 then break end
				entries[#entries + 1] = { key = part, part = part }
			end
		end
	end

	cache.ChamsEntries = entries
	cache.ChamsHasNamed = hasNamedPart
	cache.ChamsStamp = now
	return entries, hasNamedPart
end

local function GetTeamFolderFromCharacter(character)
    if not character or not character.Parent then return nil end
    local parent = character.Parent
    if parent and parent.Parent and parent.Parent.Name == "Players" and parent ~= game then
        return parent
    end
    return nil
end

function IsPlayerEnemy(targetPlayer)
    if not targetPlayer or targetPlayer == LocalPlayer then
        return false
    end

    local redTagColor = Color3.fromRGB(255, 10, 20)
    local colorTolerance = 0.02

    if LocalPlayer.TeamColor and targetPlayer.TeamColor then
        return LocalPlayer.TeamColor ~= targetPlayer.TeamColor
    end

    if LocalPlayer.Team and targetPlayer.Team then
        return LocalPlayer.Team ~= targetPlayer.Team
    end

    local targetChar = targetPlayer.Character
    if targetChar then
        local tinyHead = GetEncryptedHeadPart and GetEncryptedHeadPart(targetChar)
        if tinyHead then
            local tag = tinyHead:FindFirstChild("PlayerTag", true)
            if tag and tag:IsA("TextLabel") then
                return ColorNear(tag.TextColor3, redTagColor, colorTolerance)
            end
        end
    end

    local myChar = LocalPlayer.Character
    local myTeamFolder = GetTeamFolderFromCharacter(myChar)
    local targetTeamFolder = GetTeamFolderFromCharacter(targetChar)
    if myTeamFolder and targetTeamFolder then
        return myTeamFolder ~= targetTeamFolder
    end

    return false
end

local function InitRadar()
	_G.ESPRadarComponents = {
		Background = safeDrawingNew("Circle") or { Visible = false },
		Border = safeDrawingNew("Circle") or { Visible = false },
		LocalPlayerDot = safeDrawingNew("Circle") or { Visible = false },
		CrosshairH = safeDrawingNew("Line") or { Visible = false },
		CrosshairV = safeDrawingNew("Line") or { Visible = false },
		Circles = {},
		PlayerDots = {}
	}
	
	local radar = _G.ESPRadarComponents
	
	if radar.Background then
		radar.Background.Visible = false
		radar.Background.Filled = true
		radar.Background.Color = Config.ESP.RadarBackgroundColor
		radar.Background.Transparency = Config.ESP.RadarBackgroundTransparency
		radar.Background.NumSides = Config.ESP.RadarSegments
		radar.Background.Radius = Config.ESP.RadarSize / 2
	end
	
	if radar.Border then
		radar.Border.Visible = false
		radar.Border.Filled = false
		radar.Border.Color = Config.ESP.RadarBorderColor
		radar.Border.Thickness = Config.ESP.RadarBorderThickness
		radar.Border.Transparency = 1
		radar.Border.NumSides = Config.ESP.RadarSegments
		radar.Border.Radius = Config.ESP.RadarSize / 2
	end
	
	if radar.LocalPlayerDot then
		radar.LocalPlayerDot.Visible = false
		radar.LocalPlayerDot.Filled = true
		radar.LocalPlayerDot.Color = Config.ESP.RadarLocalPlayerColor
		radar.LocalPlayerDot.Radius = Config.ESP.RadarDotSize
		radar.LocalPlayerDot.NumSides = 30
		radar.LocalPlayerDot.Transparency = 1
	end
	
	if radar.CrosshairH then
		radar.CrosshairH.Visible = false
		radar.CrosshairH.Color = Color3.fromRGB(100, 100, 100)
		radar.CrosshairH.Thickness = 1
		radar.CrosshairH.Transparency = 0.5
	end
	
	if radar.CrosshairV then
		radar.CrosshairV.Visible = false
		radar.CrosshairV.Color = Color3.fromRGB(100, 100, 100)
		radar.CrosshairV.Thickness = 1
		radar.CrosshairV.Transparency = 0.5
	end
	
	for i = 1, 3 do
		local circle = safeDrawingNew("Circle") or { Visible = false }
		circle.Visible = false
		circle.Filled = false
		circle.Color = Color3.fromRGB(80, 80, 80)
		circle.Thickness = 1
		circle.Transparency = 0.3
		circle.NumSides = Config.ESP.RadarSegments
		radar.Circles[i] = circle
	end
end

local function CreateArrow(player)
	if player == LocalPlayer then return end
	
	local arrow = {
		Triangle = Drawing.new("Triangle"),
		DistanceText = Drawing.new("Text")
	}
	
	arrow.Triangle.Visible = false
	arrow.Triangle.Color = Config.ESP.Colors.Arrow
	arrow.Triangle.Filled = true
	arrow.Triangle.Thickness = Config.ESP.DirectionalArrowsThickness
	arrow.Triangle.Transparency = Config.ESP.DirectionalArrowsTransparency
	
	arrow.DistanceText.Visible = false
	arrow.DistanceText.Color = Config.ESP.Colors.Arrow
	arrow.DistanceText.Size = Config.ESP.DirectionalArrowsDistanceTextSize
	arrow.DistanceText.Center = true
	arrow.DistanceText.Outline = true
	arrow.DistanceText.Font = 2
	
	_G.ESPDirectionalArrows[player] = arrow
end

local function RemoveArrow(player)
	local arrow = _G.ESPDirectionalArrows[player]
	if arrow then
		pcall(function() arrow.Triangle:Remove() end)
		pcall(function() arrow.DistanceText:Remove() end)
		_G.ESPDirectionalArrows[player] = nil
	end
end

local function UpdateArrows()
	if not Config.ESP.DirectionalArrowsEnabled then
		for _, arrow in pairs(_G.ESPDirectionalArrows) do
			arrow.Triangle.Visible = false
			arrow.DistanceText.Visible = false
		end
		return
	end
	
	local localRoot = GetLocalRootPartForESP()
	if not localRoot then return end
	
	local localPos = localRoot.Position
	local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
	local seenModelArrows = {}

	local function hideArrowFor(key)
		local arrow = _G.ESPDirectionalArrows[key]
		if arrow then
			arrow.Triangle.Visible = false
			arrow.DistanceText.Visible = false
		end
	end

	local function updateArrowFor(key, targetPos)
		if not _G.ESPDirectionalArrows[key] then
			CreateArrow(key)
		end
		local arrow = _G.ESPDirectionalArrows[key]
		if not arrow then return end

		local distance = (targetPos - localPos).Magnitude
		if distance > Config.ESP.DirectionalArrowsDistance then
			hideArrowFor(key)
			return
		end

		local targetScreenPos, onScreen = Camera:WorldToViewportPoint(targetPos)
		if onScreen and targetScreenPos.Z > 0 then
			local targetPos2D = Vector2.new(targetScreenPos.X, targetScreenPos.Y)
			local distanceFromCenter = (targetPos2D - screenCenter).Magnitude
			if distanceFromCenter < Config.ESP.DirectionalArrowsOffset then
				hideArrowFor(key)
				return
			end
		end

		local directionTo3D = targetPos - localPos
		if directionTo3D.Magnitude <= 0.001 then
			hideArrowFor(key)
			return
		end

		local cameraRight = Camera.CFrame.RightVector
		local cameraUp = Camera.CFrame.UpVector
		local screenX = directionTo3D:Dot(cameraRight)
		local screenY = -directionTo3D:Dot(cameraUp)
		local angleOnScreen = math.atan2(screenY, screenX)

		local arrowBaseX = screenCenter.X + math.cos(angleOnScreen) * Config.ESP.DirectionalArrowsOffset
		local arrowBaseY = screenCenter.Y + math.sin(angleOnScreen) * Config.ESP.DirectionalArrowsOffset
		local arrowBase = Vector2.new(arrowBaseX, arrowBaseY)

		local arrowSize = Config.ESP.DirectionalArrowsSize
		local tipOffset = arrowSize * 0.8
		local tip = Vector2.new(
			arrowBase.X + math.cos(angleOnScreen) * tipOffset,
			arrowBase.Y + math.sin(angleOnScreen) * tipOffset
		)

		local baseWidth = arrowSize * 0.5
		local perpAngle1 = angleOnScreen + math.rad(90)
		local perpAngle2 = angleOnScreen - math.rad(90)
		local base1 = Vector2.new(
			arrowBase.X + math.cos(perpAngle1) * baseWidth,
			arrowBase.Y + math.sin(perpAngle1) * baseWidth
		)
		local base2 = Vector2.new(
			arrowBase.X + math.cos(perpAngle2) * baseWidth,
			arrowBase.Y + math.sin(perpAngle2) * baseWidth
		)

		arrow.Triangle.PointA = tip
		arrow.Triangle.PointB = base1
		arrow.Triangle.PointC = base2
		arrow.Triangle.Color = Config.ESP.Colors.Arrow
		arrow.Triangle.Transparency = Config.ESP.DirectionalArrowsTransparency
		arrow.Triangle.Visible = true

		if Config.ESP.DirectionalArrowsShowDistance then
			arrow.DistanceText.Text = math.floor(distance) .. "m"
			arrow.DistanceText.Position = Vector2.new(
				arrowBase.X + math.cos(angleOnScreen) * (tipOffset + 15),
				arrowBase.Y + math.sin(angleOnScreen) * (tipOffset + 15)
			)
			arrow.DistanceText.Color = Config.ESP.Colors.Arrow
			arrow.DistanceText.Size = Config.ESP.DirectionalArrowsDistanceTextSize
			arrow.DistanceText.Visible = true
		else
			arrow.DistanceText.Visible = false
		end
	end
	
	for _, player in ipairs(GetPlayersListCached()) do
		if player == LocalPlayer then continue end

        if Config.ESP.TeamCheck and not IsPlayerEnemy(player) then
            hideArrowFor(player)
            continue
        end

		local character = player.Character
		
		if not character then
			hideArrowFor(player)
			continue
		end
		
		local core = RefreshCharacterCoreCache(character)
		local rootPart = core and core.RootPart
		if not rootPart then
			hideArrowFor(player)
			continue
		end
		
		local humanoid = core and core.Humanoid
		if not humanoid or humanoid.Health <= 0 then
			hideArrowFor(player)
			continue
		end
		
		updateArrowFor(player, rootPart.Position)
	end

	for _, model in ipairs(GetEncryptedEnemyModelsCached(Config.ESP.TeamCheck)) do
		seenModelArrows[model] = true

		local aimPart = nil
		if GetEncryptedHeadPart then
			aimPart = GetEncryptedHeadPart(model)
		end
		if not aimPart then
			aimPart = GetBestBasePart(model, "HumanoidRootPart")
		end

		if not aimPart then
			hideArrowFor(model)
			continue
		end

		local hp = GetModelHealthValues(model)
		if hp and hp <= 0 then
			hideArrowFor(model)
			continue
		end

		updateArrowFor(model, aimPart.Position)
	end

	for key, _ in pairs(_G.ESPDirectionalArrows) do
		if typeof(key) == "Instance" and key:IsA("Model") and not seenModelArrows[key] then
			hideArrowFor(key)
		end
	end

end

local function ColorNear(a, b, tolerance)
	return math.abs(a.R - b.R) <= tolerance
		and math.abs(a.G - b.G) <= tolerance
		and math.abs(a.B - b.B) <= tolerance
end

local function IsTinyHeadPart(part)
	if not part or not part:IsA("BasePart") then return false end
	local size = part.Size
	return math.abs(size.X - 0.001) <= 0.0005
		and math.abs(size.Y - 0.001) <= 0.0005
		and math.abs(size.Z - 0.001) <= 0.0005
end

local function UpdateRadar()
	if not Config.ESP.RadarEnabled then
		if _G.ESPRadarComponents then
			_G.ESPRadarComponents.Background.Visible = false
			_G.ESPRadarComponents.Border.Visible = false
			_G.ESPRadarComponents.LocalPlayerDot.Visible = false
			_G.ESPRadarComponents.CrosshairH.Visible = false
			_G.ESPRadarComponents.CrosshairV.Visible = false
			for _, circle in ipairs(_G.ESPRadarComponents.Circles) do
				circle.Visible = false
			end
			for _, dot in pairs(_G.ESPRadarComponents.PlayerDots or {}) do
				if dot.Visible ~= nil then
					dot.Visible = false
				end
			end
		end
		return
	end
	
	if not _G.ESPRadarComponents then return end
	
	local radarCenter = Vector2.new(
		Config.ESP.RadarPositionX + Config.ESP.RadarSize / 2,
		Config.ESP.RadarPositionY + Config.ESP.RadarSize / 2
	)
	local radarRadius = Config.ESP.RadarSize / 2
	
	_G.ESPRadarComponents.Background.NumSides = Config.ESP.RadarSegments
	_G.ESPRadarComponents.Background.Radius = radarRadius
	_G.ESPRadarComponents.Background.Position = radarCenter
	_G.ESPRadarComponents.Background.Color = Config.ESP.RadarBackgroundColor
	_G.ESPRadarComponents.Background.Transparency = Config.ESP.RadarBackgroundTransparency
	_G.ESPRadarComponents.Background.Visible = true
	
	_G.ESPRadarComponents.Border.NumSides = Config.ESP.RadarSegments
	_G.ESPRadarComponents.Border.Radius = radarRadius
	_G.ESPRadarComponents.Border.Position = radarCenter
	_G.ESPRadarComponents.Border.Color = Config.ESP.RadarBorderColor
	_G.ESPRadarComponents.Border.Thickness = Config.ESP.RadarBorderThickness
	_G.ESPRadarComponents.Border.Visible = true
	
	_G.ESPRadarComponents.LocalPlayerDot.Position = radarCenter
	_G.ESPRadarComponents.LocalPlayerDot.Color = Config.ESP.RadarLocalPlayerColor
	_G.ESPRadarComponents.LocalPlayerDot.Radius = Config.ESP.RadarDotSize
	_G.ESPRadarComponents.LocalPlayerDot.Visible = true

	if Config.ESP.RadarShowCrosshair then
		_G.ESPRadarComponents.CrosshairH.From = Vector2.new(radarCenter.X - radarRadius, radarCenter.Y)
		_G.ESPRadarComponents.CrosshairH.To = Vector2.new(radarCenter.X + radarRadius, radarCenter.Y)
		_G.ESPRadarComponents.CrosshairH.Visible = true
		
		_G.ESPRadarComponents.CrosshairV.From = Vector2.new(radarCenter.X, radarCenter.Y - radarRadius)
		_G.ESPRadarComponents.CrosshairV.To = Vector2.new(radarCenter.X, radarCenter.Y + radarRadius)
		_G.ESPRadarComponents.CrosshairV.Visible = true
	else
		_G.ESPRadarComponents.CrosshairH.Visible = false
		_G.ESPRadarComponents.CrosshairV.Visible = false
	end

	if Config.ESP.RadarShowCircles then
		for i = 1, 3 do
			local radius = radarRadius * (i / 3)
			_G.ESPRadarComponents.Circles[i].NumSides = Config.ESP.RadarSegments
			_G.ESPRadarComponents.Circles[i].Radius = radius
			_G.ESPRadarComponents.Circles[i].Position = radarCenter
			_G.ESPRadarComponents.Circles[i].Visible = true
		end
	else
		for _, circle in ipairs(_G.ESPRadarComponents.Circles) do
			circle.Visible = false
		end
	end

	local localRoot = GetLocalRootPartForESP()
	if not localRoot then return end
	
	local localPos = localRoot.Position

	if not _G.ESPRadarComponents.PlayerDots then
		_G.ESPRadarComponents.PlayerDots = {}
	end

	for _, player in ipairs(GetPlayersListCached()) do
		if player == LocalPlayer then continue end

		if Config.ESP.TeamCheck and not IsPlayerEnemy(player) then
			if _G.ESPRadarComponents.PlayerDots[player] then
				_G.ESPRadarComponents.PlayerDots[player].Visible = false
			end
			continue
		end
		
		local character = player.Character
		if not character then
			if _G.ESPRadarComponents.PlayerDots[player] then
				_G.ESPRadarComponents.PlayerDots[player].Visible = false
			end
			continue
		end
		
		local core = RefreshCharacterCoreCache(character)
		local rootPart = core and core.RootPart
		if not rootPart then
			if _G.ESPRadarComponents.PlayerDots[player] then
				_G.ESPRadarComponents.PlayerDots[player].Visible = false
			end
			continue
		end
		
		local humanoid = core and core.Humanoid
		if not humanoid or humanoid.Health <= 0 then
			if _G.ESPRadarComponents.PlayerDots[player] then
				_G.ESPRadarComponents.PlayerDots[player].Visible = false
			end
			continue
		end

		local distance = (rootPart.Position - localPos).Magnitude
		if distance > Config.ESP.RadarRange then
			if _G.ESPRadarComponents.PlayerDots[player] then
				_G.ESPRadarComponents.PlayerDots[player].Visible = false
			end
			continue
		end

		if not _G.ESPRadarComponents.PlayerDots[player] then
			local dot = Drawing.new("Circle")
			dot.Filled = true
			dot.Radius = Config.ESP.RadarDotSize
			dot.NumSides = 30
			dot.Transparency = 1
			_G.ESPRadarComponents.PlayerDots[player] = dot
		end
		
		local dot = _G.ESPRadarComponents.PlayerDots[player]

		local relativePos = rootPart.Position - localPos

		local cameraCFrame = Camera.CFrame
		local lookVector = cameraCFrame.LookVector
		local rightVector = cameraCFrame.RightVector

		local flatRelative = Vector3.new(relativePos.X, 0, relativePos.Z)
		local flatLook = Vector3.new(lookVector.X, 0, lookVector.Z).Unit
		local flatRight = Vector3.new(rightVector.X, 0, rightVector.Z).Unit

		local radarX = flatRelative:Dot(flatRight)
		local radarZ = flatRelative:Dot(flatLook)
		
		local rotatedPos = Vector3.new(radarX, 0, radarZ)
		
		local scale = radarRadius / Config.ESP.RadarRange
		local radarXPos = rotatedPos.X * scale
		local radarYPos = -rotatedPos.Z * scale

		local dotDistance = math.sqrt(radarXPos * radarXPos + radarYPos * radarYPos)
		if dotDistance > radarRadius - Config.ESP.RadarDotSize then
			local angle = math.atan2(radarYPos, radarXPos)
			radarXPos = math.cos(angle) * (radarRadius - Config.ESP.RadarDotSize)
			radarYPos = math.sin(angle) * (radarRadius - Config.ESP.RadarDotSize)
		end

        dot.Position = Vector2.new(radarCenter.X + radarXPos, radarCenter.Y + radarYPos)
        dot.Color = Config.ESP.RadarEnemyColor
        dot.Radius = Config.ESP.RadarDotSize * Config.ESP.RadarScale
        dot.Visible = true
	end

	local seenModelDots = {}
	for _, model in ipairs(GetEncryptedEnemyModelsCached(Config.ESP.TeamCheck)) do
		local rootPart = GetBestBasePart(model, "HumanoidRootPart")
		if not rootPart then
			if _G.ESPRadarComponents.PlayerDots[model] then
				_G.ESPRadarComponents.PlayerDots[model].Visible = false
			end
			continue
		end

		local hp = GetModelHealthValues(model)
		if hp and hp <= 0 then
			if _G.ESPRadarComponents.PlayerDots[model] then
				_G.ESPRadarComponents.PlayerDots[model].Visible = false
			end
			continue
		end

		local distance = (rootPart.Position - localPos).Magnitude
		if distance > Config.ESP.RadarRange then
			if _G.ESPRadarComponents.PlayerDots[model] then
				_G.ESPRadarComponents.PlayerDots[model].Visible = false
			end
			continue
		end

		seenModelDots[model] = true
		if not _G.ESPRadarComponents.PlayerDots[model] then
			local dot = Drawing.new("Circle")
			dot.Filled = true
			dot.Radius = Config.ESP.RadarDotSize
			dot.NumSides = 30
			dot.Transparency = 1
			_G.ESPRadarComponents.PlayerDots[model] = dot
		end

		local dot = _G.ESPRadarComponents.PlayerDots[model]
		local relativePos = rootPart.Position - localPos
		local cameraCFrame = Camera.CFrame
		local lookVector = cameraCFrame.LookVector
		local rightVector = cameraCFrame.RightVector
		local flatRelative = Vector3.new(relativePos.X, 0, relativePos.Z)
		local flatLook = Vector3.new(lookVector.X, 0, lookVector.Z).Unit
		local flatRight = Vector3.new(rightVector.X, 0, rightVector.Z).Unit

		local radarX = flatRelative:Dot(flatRight)
		local radarZ = flatRelative:Dot(flatLook)
		local rotatedPos = Vector3.new(radarX, 0, radarZ)
		local scale = radarRadius / Config.ESP.RadarRange
		local radarXPos = rotatedPos.X * scale
		local radarYPos = -rotatedPos.Z * scale

		local dotDistance = math.sqrt(radarXPos * radarXPos + radarYPos * radarYPos)
		if dotDistance > radarRadius - Config.ESP.RadarDotSize then
			local angle = math.atan2(radarYPos, radarXPos)
			radarXPos = math.cos(angle) * (radarRadius - Config.ESP.RadarDotSize)
			radarYPos = math.sin(angle) * (radarRadius - Config.ESP.RadarDotSize)
		end

		dot.Position = Vector2.new(radarCenter.X + radarXPos, radarCenter.Y + radarYPos)
		dot.Color = Config.ESP.RadarEnemyColor
		dot.Radius = Config.ESP.RadarDotSize * Config.ESP.RadarScale
		dot.Visible = true
	end

	for key, dot in pairs(_G.ESPRadarComponents.PlayerDots) do
		if typeof(key) == "Instance" and key:IsA("Model") and not seenModelDots[key] then
			dot.Visible = false
		end
	end
end

function UpdateESPSettings()
	for key, value in pairs(Config.ESP) do
		_G.ESPSettings[key] = value
	end
end

function ToggleESP(enabled)
	Config.ESP.Enabled = enabled
	
	if enabled then
		for _, player in ipairs(GetPlayersListCached()) do
			if player ~= LocalPlayer then
				if not _G.ESPDrawings[player] then
					CreateESP(player)
				end
			end
		end
	else
		for _, player in ipairs(GetPlayersListCached()) do
			if _G.ESPDrawings[player] then
				local esp = _G.ESPDrawings[player]
				if esp.Box then
					for _, line in pairs(esp.Box) do
						line.Visible = false
					end
				end
				if esp.BoxFill then
					esp.BoxFill.Visible = false
				end

				if esp.Tracer then
					esp.Tracer.Visible = false
				end

				if esp.HealthBar then
					esp.HealthBar.Outline.Visible = false
					esp.HealthBar.Fill.Visible = false
					esp.HealthBar.Text.Visible = false
				end

				if esp.Info then
					esp.Info.Name.Visible = false
					esp.Info.Distance.Visible = false
				end

				if esp.Skeleton then
					for _, line in pairs(esp.Skeleton) do
						line.Visible = false
					end
				end
			end

			if _G.ESPHighlights[player] then
				_G.ESPHighlights[player].Enabled = false
			end
		end
	end
end

function GetHealthColor(health, maxHealth)
	local percentage = health / maxHealth
	if percentage > 0.5 then
		return Config.ESP.Colors.HealthHigh
	elseif percentage > 0.2 then
		return Config.ESP.Colors.HealthMedium
	else
		return Config.ESP.Colors.HealthLow
	end
end

local function LerpColor3(a, b, t)
	return Color3.new(
		a.R + (b.R - a.R) * t,
		a.G + (b.G - a.G) * t,
		a.B + (b.B - a.B) * t
	)
end

local function GetESPThemeColor(rootPart, boxPosition, boxSize, fallback)
	if not Config.ESP.GradientEnabled then
		return fallback
	end
	return LerpColor3(Config.ESP.GradientA, Config.ESP.GradientB, 0.5)
end

local function GetESPThemeColorAtPoint(localPos, fallback)
	if not Config.ESP.GradientEnabled then
		return fallback
	end
	local nx = localPos.X
	local ny = localPos.Y
	local angle = math.rad(Config.ESP.GradientAngle or 0)
	local dir = Vector2.new(math.cos(angle), math.sin(angle))
	local t = math.clamp((nx * dir.X + ny * dir.Y) + 0.5, 0, 1)
	return LerpColor3(Config.ESP.GradientA, Config.ESP.GradientB, t)
end

function GetTracerOrigin()
	local viewportSize = Camera.ViewportSize
	
	if Config.ESP.TracerOrigin == "Bottom" then
		return Vector2.new(viewportSize.X / 2, viewportSize.Y)
	elseif Config.ESP.TracerOrigin == "Top" then
		return Vector2.new(viewportSize.X / 2, 0)
	elseif Config.ESP.TracerOrigin == "Mouse" then
		local mousePos = UserInputService:GetMouseLocation()
		return mousePos
	else
		return Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
	end
end

function CreateBoxes(player)
	if player == LocalPlayer then return end
	
	if not _G.ESPDrawings[player] then
		_G.ESPDrawings[player] = {}
	end
	
	_G.ESPDrawings[player].Box = {
		TopLeft = Drawing.new("Line"),
		TopRight = Drawing.new("Line"),
		BottomLeft = Drawing.new("Line"),
		BottomRight = Drawing.new("Line"),
		Top = Drawing.new("Line"),
		Bottom = Drawing.new("Line"),
		Left = Drawing.new("Line"),
		Right = Drawing.new("Line")
	}
	_G.ESPDrawings[player].BoxFill = Drawing.new("Square")
	
	for _, line in pairs(_G.ESPDrawings[player].Box) do
		line.Visible = false
		line.Color = Config.ESP.Colors.Box
		line.Thickness = Config.ESP.BoxThickness
	end

	_G.ESPDrawings[player].BoxFill.Visible = false
	_G.ESPDrawings[player].BoxFill.Filled = true
	_G.ESPDrawings[player].BoxFill.Color = Config.ESP.Colors.Box
	_G.ESPDrawings[player].BoxFill.Transparency = Config.ESP.BoxFillTransparency
end

function CreateTracers(player)
	if player == LocalPlayer then return end
	
	if not _G.ESPDrawings[player] then
		_G.ESPDrawings[player] = {}
	end
	
	_G.ESPDrawings[player].Tracer = Drawing.new("Line")
	_G.ESPDrawings[player].Tracer.Visible = false
	_G.ESPDrawings[player].Tracer.Color = Config.ESP.Colors.Tracer
	_G.ESPDrawings[player].Tracer.Thickness = Config.ESP.TracerThickness
end

function CreateHealthBars(player)
	if player == LocalPlayer then return end
	
	if not _G.ESPDrawings[player] then
		_G.ESPDrawings[player] = {}
	end
	
	_G.ESPDrawings[player].HealthBar = {
		Outline = Drawing.new("Square"),
		Fill = Drawing.new("Square"),
		Text = Drawing.new("Text")
	}
	
	_G.ESPDrawings[player].HealthBar.Outline.Visible = false
	_G.ESPDrawings[player].HealthBar.Outline.Color = Color3.fromRGB(0, 0, 0)
	_G.ESPDrawings[player].HealthBar.Outline.Filled = true
	_G.ESPDrawings[player].HealthBar.Outline.Thickness = 1
	
	_G.ESPDrawings[player].HealthBar.Fill.Visible = false
	_G.ESPDrawings[player].HealthBar.Fill.Color = Config.ESP.Colors.Health
	_G.ESPDrawings[player].HealthBar.Fill.Filled = true
	
	_G.ESPDrawings[player].HealthBar.Text.Visible = false
	_G.ESPDrawings[player].HealthBar.Text.Color = Color3.fromRGB(255, 255, 255)
	_G.ESPDrawings[player].HealthBar.Text.Size = Config.ESP.TextSize
	_G.ESPDrawings[player].HealthBar.Text.Outline = true
	_G.ESPDrawings[player].HealthBar.Text.Center = true
end

function CreateNames(player)
	if player == LocalPlayer then return end
	
	if not _G.ESPDrawings[player] then
		_G.ESPDrawings[player] = {}
	end
	
	_G.ESPDrawings[player].Info = {
		Name = Drawing.new("Text"),
		Distance = Drawing.new("Text")
	}
	
	_G.ESPDrawings[player].Info.Name.Visible = false
	_G.ESPDrawings[player].Info.Name.Center = true
	_G.ESPDrawings[player].Info.Name.Size = Config.ESP.TextSize
	_G.ESPDrawings[player].Info.Name.Color = Config.ESP.Colors.Text
	_G.ESPDrawings[player].Info.Name.Outline = true
	
	_G.ESPDrawings[player].Info.Distance.Visible = false
	_G.ESPDrawings[player].Info.Distance.Center = true
	_G.ESPDrawings[player].Info.Distance.Size = Config.ESP.TextSize
	_G.ESPDrawings[player].Info.Distance.Color = Config.ESP.Colors.Distance
	_G.ESPDrawings[player].Info.Distance.Outline = true
end

function CreateSkeleton(player)
	if player == LocalPlayer then return end
	
	if not _G.ESPDrawings[player] then
		_G.ESPDrawings[player] = {}
	end
	
	_G.ESPDrawings[player].Skeleton = {}
	
	local skeletonConnections = {
		"Head", "UpperSpine", "LeftShoulder", "LeftUpperArm", "LeftLowerArm",
		"RightShoulder", "RightUpperArm", "RightLowerArm",
		"LeftHip", "LeftUpperLeg", "LeftLowerLeg",
		"RightHip", "RightUpperLeg", "RightLowerLeg"
	}
	
	for i = 1, 14 do
		local line = Drawing.new("Line")
		line.Visible = false
		line.Color = Config.ESP.Colors.Skeleton
		line.Thickness = Config.ESP.SkeletonThickness
		line.Transparency = Config.ESP.SkeletonTransparency
		_G.ESPDrawings[player].Skeleton[i] = line
	end
end

local function NewQuad(color)
    local quad = Drawing.new("Quad")
    quad.Visible = false
    quad.PointA = Vector2.new(0,0)
    quad.PointB = Vector2.new(0,0)
    quad.PointC = Vector2.new(0,0)
    quad.PointD = Vector2.new(0,0)
    quad.Color = color
    quad.Filled = true
    quad.Thickness = 1
    quad.Transparency = 0
    return quad
end

function CreateChams(player)
    if player == LocalPlayer then return end
    if not _G.ESPDrawings[player] then
        _G.ESPDrawings[player] = {}
    end
    _G.ESPDrawings[player].ChamsQuads = {}
end

function CreateESP(player)
	if player == LocalPlayer then return end
	
	CreateBoxes(player)
	CreateTracers(player)
	CreateHealthBars(player)
	CreateNames(player)
	CreateSkeleton(player)
	CreateChams(player)
	CreateArrow(player)
	
end

local function isxraymappart(part)
	if not part or not part:IsA("BasePart") then
		return false
	end
	if LocalPlayer.Character and part:IsDescendantOf(LocalPlayer.Character) then
		return false
	end
	local model = part:FindFirstAncestorOfClass("Model")
	if model and model:FindFirstChildOfClass("Humanoid") then
		return false
	end
	return true
end

local function applyxraymappart(part)
	if not isxraymappart(part) then
		return
	end
	if not xraymapcache[part] then
		xraymapcache[part] = part.LocalTransparencyModifier
	end
	part.LocalTransparencyModifier = Config.ESP.XrayMapTransparency
end

local function enablexraymap()
	for _, descendant in ipairs(workspace:GetDescendants()) do
		if isxraymappart(descendant) then
			applyxraymappart(descendant)
		end
	end
	if xraymapconnection then
		xraymapconnection:Disconnect()
		xraymapconnection = nil
	end
	xraymapconnection = workspace.DescendantAdded:Connect(function(descendant)
		if Config.ESP.XrayEnabled and Config.ESP.XrayActive and isxraymappart(descendant) then
			applyxraymappart(descendant)
		end
	end)
end

local function disablexraymap()
	if xraymapconnection then
		xraymapconnection:Disconnect()
		xraymapconnection = nil
	end
	for part, original in pairs(xraymapcache) do
		if part and part.Parent then
			part.LocalTransparencyModifier = original
		end
	end
	table.clear(xraymapcache)
end

local function HideESPDrawings(esp)
	if not esp then return end
	if esp.Box then for _, line in pairs(esp.Box) do line.Visible = false end end
	if esp.BoxFill then esp.BoxFill.Visible = false end
	if esp.Tracer then esp.Tracer.Visible = false end
	if esp.HealthBar then
		esp.HealthBar.Outline.Visible = false
		esp.HealthBar.Fill.Visible = false
		esp.HealthBar.Text.Visible = false
	end
	if esp.Info then
		esp.Info.Name.Visible = false
		esp.Info.Distance.Visible = false
	end
	if esp.Skeleton then
		for _, line in pairs(esp.Skeleton) do line.Visible = false end
	end
	if esp.ChamsQuads then
		for _, quads in pairs(esp.ChamsQuads) do
			for _, quad in ipairs(quads) do
				quad.Visible = false
			end
		end
	end
end

local function EnsureESPKey(key)
	if _G.ESPDrawings[key] then return end
	CreateBoxes(key)
	CreateTracers(key)
	CreateHealthBars(key)
	CreateNames(key)
	CreateSkeleton(key)
	CreateChams(key)
end

local function GetLocalWorkspaceTeamFolder()
	local playersFolder = Workspace:FindFirstChild("Players")
	if not playersFolder then return nil end

	local subject = Camera and Camera.CameraSubject
	if subject then
		local model = nil
		if subject:IsA("Humanoid") then
			model = subject.Parent
		elseif subject:IsA("BasePart") then
			model = subject:FindFirstAncestorOfClass("Model")
		end
		if model and model.Parent and model.Parent.Parent == playersFolder then
			return model.Parent
		end
	end

	local myChar = LocalPlayer.Character
	if myChar and myChar.Parent and myChar.Parent.Parent == playersFolder then
		return myChar.Parent
	end

	return nil
end

GetLocalRootPartForESP = function()
	local myChar = LocalPlayer.Character
	if myChar then
		local root = myChar:FindFirstChild("HumanoidRootPart") or myChar:FindFirstChild("HumanoidRootPart", true)
		if root and root:IsA("BasePart") then
			return root
		end
	end

	local subject = Camera and Camera.CameraSubject
	if subject then
		if subject:IsA("Humanoid") and subject.Parent then
			local root = subject.Parent:FindFirstChild("HumanoidRootPart") or subject.Parent:FindFirstChildWhichIsA("BasePart", true)
			if root and root:IsA("BasePart") then
				return root
			end
		elseif subject:IsA("BasePart") then
			return subject
		end
	end

	return nil
end

GetBestBasePart = function(model, preferredName)
	local named = model:FindFirstChild(preferredName, true)
	if named and named:IsA("BasePart") then
		return named
	end

	local firstPart = nil
	for _, obj in ipairs(model:GetDescendants()) do
		if obj:IsA("BasePart") then
			firstPart = obj
			break
		end
	end
	return firstPart
end

local function GetHighestPart(model, fallbackPart)
	local highest = nil
	for _, obj in ipairs(model:GetDescendants()) do
		if obj:IsA("BasePart") then
			if not highest or obj.Position.Y > highest.Position.Y then
				highest = obj
			end
		end
	end
	return highest or fallbackPart
end

GetEncryptedEnemyModels = function(useTeamCheck)
	local shouldTeamCheck = useTeamCheck == true
	local playersFolder = Workspace:FindFirstChild("Players")
	if not playersFolder then return {} end
	local playersList = GetPlayersListCached()
	local playersByUserId = {}
	local playersByName = {}
	for _, plr in ipairs(playersList) do
		playersByUserId[plr.UserId] = plr
		playersByName[plr.Name] = plr
		playersByName[plr.DisplayName] = plr
	end

	local localTeamFolder = GetLocalWorkspaceTeamFolder()
	local redTagColor = Color3.fromRGB(255, 10, 20)
	local colorTolerance = 0.02

	local function FindPlayerForEncryptedModel(model)
		if not model then return nil end

		local candidateIds = {
			model:GetAttribute("UserId"),
			model:GetAttribute("userId"),
			model:GetAttribute("userid"),
			model:GetAttribute("PlayerId"),
			model:GetAttribute("playerId")
		}

		for _, id in ipairs(candidateIds) do
			if typeof(id) == "number" then
				local mapped = playersByUserId[id]
				if mapped then
					return mapped
				end
			end
		end

		return playersByName[model.Name]
	end

	local function IsLikelyLocalWorkspaceModel(model)
		if not model then return false end
		if LocalPlayer.Character and model == LocalPlayer.Character then
			return true
		end
		local subject = Camera and Camera.CameraSubject
		if subject then
			if subject:IsA("Humanoid") and subject.Parent == model then
				return true
			elseif subject:IsA("BasePart") and subject:IsDescendantOf(model) then
				return true
			end
		end
		return false
	end

	local function IsEncryptedModelEnemy(model)
		if not model then return false end
		if localTeamFolder and model.Parent == localTeamFolder then
			return false
		end

		local mappedPlayer = FindPlayerForEncryptedModel(model)
		if mappedPlayer and mappedPlayer ~= LocalPlayer then
			if LocalPlayer.TeamColor and mappedPlayer.TeamColor then
				return LocalPlayer.TeamColor ~= mappedPlayer.TeamColor
			end
			if LocalPlayer.Team and mappedPlayer.Team then
				return LocalPlayer.Team ~= mappedPlayer.Team
			end
		end

		local tinyHead = GetEncryptedHeadPart and GetEncryptedHeadPart(model)
		if tinyHead then
			local tag = tinyHead:FindFirstChild("PlayerTag", true)
			if tag and tag:IsA("TextLabel") then
				return ColorNear(tag.TextColor3, redTagColor, colorTolerance)
			end
		end

		if localTeamFolder and model.Parent then
			return model.Parent ~= localTeamFolder
		end

		return false
	end

	local models = {}

	for _, teamFolder in ipairs(playersFolder:GetChildren()) do
		for _, model in ipairs(teamFolder:GetChildren()) do
			if model:IsA("Model") and not IsLikelyLocalWorkspaceModel(model) then
				if not shouldTeamCheck or IsEncryptedModelEnemy(model) then
					table.insert(models, model)
				end
			end
		end
	end

	return models
end

GetEncryptedEnemyModelsCached = function(useTeamCheck)
	local shouldTeamCheck = useTeamCheck == true
	local now = tick()
	if EncryptedModelsCache.Models
		and EncryptedModelsCache.TeamCheck == shouldTeamCheck
		and (now - EncryptedModelsCache.Stamp) < ENCRYPTED_MODEL_CACHE_TTL then
		return EncryptedModelsCache.Models
	end

	local models = GetEncryptedEnemyModels(shouldTeamCheck)
	EncryptedModelsCache.Models = models
	EncryptedModelsCache.TeamCheck = shouldTeamCheck
	EncryptedModelsCache.Stamp = now
	return models
end

GetEncryptedHeadPart = function(model)
	if not model then return nil end

	local preferred = model:FindFirstChild("Head", true)
	if IsTinyHeadPart(preferred) then
		return preferred
	end

	local redTagColor = Color3.fromRGB(255, 10, 20)
	local tolerance = 0.02

	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") and IsTinyHeadPart(part) then
			local tag = part:FindFirstChild("PlayerTag", true)
			if tag and tag:IsA("TextLabel") and ColorNear(tag.TextColor3, redTagColor, tolerance) then
				return part
			end
		end
	end

	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") and IsTinyHeadPart(part) then
			return part
		end
	end

	return nil
end

local function ResolveEncryptedName(model)
	if not model then return "unknown" end
	if EncryptedNameCache[model] then
		return EncryptedNameCache[model]
	end
	local playersList = GetPlayersListCached()

	local function cacheAndReturn(name)
		EncryptedNameCache[model] = name
		return name
	end

	local candidateIds = {
		model:GetAttribute("UserId"),
		model:GetAttribute("userId"),
		model:GetAttribute("userid"),
		model:GetAttribute("PlayerId"),
		model:GetAttribute("playerId")
	}
	for _, id in ipairs(candidateIds) do
		if typeof(id) == "number" then
			for _, plr in ipairs(playersList) do
				if plr.UserId == id then
					return cacheAndReturn(plr.DisplayName)
				end
			end
		end
	end

	for _, obj in ipairs(model:GetDescendants()) do
		if obj:IsA("StringValue") then
			local lowerName = string.lower(obj.Name)
			if lowerName:find("name") or lowerName:find("player") then
				local txt = tostring(obj.Value)
				for _, plr in ipairs(playersList) do
					if txt == plr.Name or txt == plr.DisplayName then
						return cacheAndReturn(plr.DisplayName)
					end
				end
			end
		elseif obj:IsA("TextLabel") then
			local txt = tostring(obj.Text)
			for _, plr in ipairs(playersList) do
				if txt == plr.Name or txt == plr.DisplayName then
					return cacheAndReturn(plr.DisplayName)
				end
			end
		end
	end

	return cacheAndReturn(model.Name)
end

GetModelHealthValues = function(model)
	local humanoid = model:FindFirstChildOfClass("Humanoid")
	if humanoid then
		return humanoid.Health, humanoid.MaxHealth
	end

	local healthValue = nil
	local maxValue = nil
	for _, obj in ipairs(model:GetDescendants()) do
		local lower = string.lower(obj.Name)
		if (obj:IsA("NumberValue") or obj:IsA("IntValue")) and lower:find("health") then
			if lower:find("max") then
				maxValue = obj.Value
			else
				healthValue = obj.Value
			end
		end
	end

	if healthValue then
		return healthValue, maxValue or 100
	end

	return nil, nil
end

function RemoveESP(player)
	if _G.ESPDrawings[player] then
		if _G.ESPDrawings[player].Box then
			for _, line in pairs(_G.ESPDrawings[player].Box) do
				pcall(function() line:Remove() end)
			end
		end
		if _G.ESPDrawings[player].BoxFill then
			pcall(function() _G.ESPDrawings[player].BoxFill:Remove() end)
		end
		
		if _G.ESPDrawings[player].Tracer then
			pcall(function() _G.ESPDrawings[player].Tracer:Remove() end)
		end

		if _G.ESPDrawings[player] and _G.ESPDrawings[player].ChamsQuads then
			for partName, quads in pairs(_G.ESPDrawings[player].ChamsQuads) do
				for _, quad in ipairs(quads) do
					pcall(function() quad:Remove() end)
				end
			end
			_G.ESPDrawings[player].ChamsQuads = nil
    	end
		
		if _G.ESPDrawings[player].HealthBar then
			pcall(function() _G.ESPDrawings[player].HealthBar.Outline:Remove() end)
			pcall(function() _G.ESPDrawings[player].HealthBar.Fill:Remove() end)
			pcall(function() _G.ESPDrawings[player].HealthBar.Text:Remove() end)
		end
		
		if _G.ESPDrawings[player].Info then
			pcall(function() _G.ESPDrawings[player].Info.Name:Remove() end)
			pcall(function() _G.ESPDrawings[player].Info.Distance:Remove() end)
		end
		
		if _G.ESPDrawings[player].Skeleton then
			for _, line in pairs(_G.ESPDrawings[player].Skeleton) do
				pcall(function() line:Remove() end)
			end
		end
		
		_G.ESPDrawings[player] = nil
	end
	
	if _G.ESPHighlights[player] then
		pcall(function() _G.ESPHighlights[player]:Destroy() end)
		_G.ESPHighlights[player] = nil
	end
	
	RemoveArrow(player)
end

function UpdateBoxes(player, esp, character, humanoid, rootPart, forcedHead)
	
	local head = forcedHead or character:FindFirstChild("Head") or character:FindFirstChild("Head", true)
	if not head then
		head = GetHighestPart(character, rootPart)
	end
	if not head then
		if esp.Box then
			for _, line in pairs(esp.Box) do
				line.Visible = false
			end
		end
		if esp.BoxFill then
			esp.BoxFill.Visible = false
		end
		return nil, nil
	end
	
	local headPos, headOnScreen = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
	local rootPos, rootOnScreen = Camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 3, 0))
	
	if not (headOnScreen and rootOnScreen) or headPos.Z < 0 or rootPos.Z < 0 then
		if esp.Box then
			for _, line in pairs(esp.Box) do
				line.Visible = false
			end
		end
		if esp.BoxFill then
			esp.BoxFill.Visible = false
		end
		return nil, nil 
	end
	
	local screenHeight = math.abs(headPos.Y - rootPos.Y)
	local screenWidth = screenHeight * 0.5
	
	local boxPosition = Vector2.new(
		headPos.X - screenWidth / 2,
		headPos.Y
	)
	local boxSize = Vector2.new(screenWidth, screenHeight)
	local themeColor = GetESPThemeColor(rootPart, boxPosition, boxSize, Config.ESP.Colors.Box)
	local leftColor = GetESPThemeColorAtPoint(Vector2.new(-0.5, 0), themeColor)
	local rightColor = GetESPThemeColorAtPoint(Vector2.new(0.5, 0), themeColor)
	local topColor = GetESPThemeColorAtPoint(Vector2.new(0, -0.5), themeColor)
	local bottomColor = GetESPThemeColorAtPoint(Vector2.new(0, 0.5), themeColor)
	local centerColor = GetESPThemeColorAtPoint(Vector2.new(0, 0), themeColor)

	if esp.BoxFill then
		if Config.ESP.BoxESP and Config.ESP.BoxFilled then
			esp.BoxFill.Position = boxPosition
			esp.BoxFill.Size = boxSize
			esp.BoxFill.Color = centerColor
			esp.BoxFill.Filled = true
			esp.BoxFill.Transparency = Config.ESP.BoxFillTransparency
			esp.BoxFill.Visible = true
		else
			esp.BoxFill.Visible = false
		end
	end
	if Config.ESP.BoxESP and esp.Box then
        if Config.ESP.BoxStyle == "Corner" then
            local cornerSize = screenWidth * 0.25
            
            esp.Box.TopLeft.From = boxPosition
            esp.Box.TopLeft.To = boxPosition + Vector2.new(0, cornerSize)
            esp.Box.TopLeft.Color = leftColor
            esp.Box.TopLeft.Thickness = Config.ESP.BoxThickness
            esp.Box.TopLeft.Visible = true
            
            esp.Box.TopRight.From = boxPosition + Vector2.new(boxSize.X, 0)
            esp.Box.TopRight.To = boxPosition + Vector2.new(boxSize.X, cornerSize)
            esp.Box.TopRight.Color = rightColor
            esp.Box.TopRight.Thickness = Config.ESP.BoxThickness
            esp.Box.TopRight.Visible = true
            
            esp.Box.BottomLeft.From = boxPosition + Vector2.new(0, boxSize.Y)
            esp.Box.BottomLeft.To = boxPosition + Vector2.new(0, boxSize.Y - cornerSize)
            esp.Box.BottomLeft.Color = leftColor
            esp.Box.BottomLeft.Thickness = Config.ESP.BoxThickness
            esp.Box.BottomLeft.Visible = true

            esp.Box.BottomRight.From = boxPosition + Vector2.new(boxSize.X, boxSize.Y)
            esp.Box.BottomRight.To = boxPosition + Vector2.new(boxSize.X, boxSize.Y - cornerSize)
            esp.Box.BottomRight.Color = rightColor
            esp.Box.BottomRight.Thickness = Config.ESP.BoxThickness
            esp.Box.BottomRight.Visible = true

            esp.Box.Top.From = boxPosition
            esp.Box.Top.To = boxPosition + Vector2.new(cornerSize, 0)
            esp.Box.Top.Color = topColor
            esp.Box.Top.Thickness = Config.ESP.BoxThickness
            esp.Box.Top.Visible = true

            esp.Box.Bottom.From = boxPosition + Vector2.new(0, boxSize.Y)
            esp.Box.Bottom.To = boxPosition + Vector2.new(cornerSize, boxSize.Y)
            esp.Box.Bottom.Color = bottomColor
            esp.Box.Bottom.Thickness = Config.ESP.BoxThickness
            esp.Box.Bottom.Visible = true
            
            esp.Box.Left.From = boxPosition + Vector2.new(boxSize.X - cornerSize, 0)
            esp.Box.Left.To = boxPosition + Vector2.new(boxSize.X, 0)
            esp.Box.Left.Color = topColor
            esp.Box.Left.Thickness = Config.ESP.BoxThickness
            esp.Box.Left.Visible = true
            
            esp.Box.Right.From = boxPosition + Vector2.new(boxSize.X - cornerSize, boxSize.Y)
            esp.Box.Right.To = boxPosition + Vector2.new(boxSize.X, boxSize.Y)
            esp.Box.Right.Color = bottomColor
            esp.Box.Right.Thickness = Config.ESP.BoxThickness
            esp.Box.Right.Visible = true
        else
            for _, line in pairs(esp.Box) do
                line.Visible = false
            end
            esp.Box.Left.From = boxPosition
            esp.Box.Left.To = boxPosition + Vector2.new(0, boxSize.Y)
            esp.Box.Left.Color = leftColor
            esp.Box.Left.Thickness = Config.ESP.BoxThickness
            esp.Box.Left.Visible = true
            
            esp.Box.Right.From = boxPosition + Vector2.new(boxSize.X, 0)
            esp.Box.Right.To = boxPosition + Vector2.new(boxSize.X, boxSize.Y)
            esp.Box.Right.Color = rightColor
            esp.Box.Right.Thickness = Config.ESP.BoxThickness
            esp.Box.Right.Visible = true
            
            esp.Box.Top.From = boxPosition
            esp.Box.Top.To = boxPosition + Vector2.new(boxSize.X, 0)
            esp.Box.Top.Color = topColor
            esp.Box.Top.Thickness = Config.ESP.BoxThickness
            esp.Box.Top.Visible = true
            
            esp.Box.Bottom.From = boxPosition + Vector2.new(0, boxSize.Y)
            esp.Box.Bottom.To = boxPosition + Vector2.new(boxSize.X, boxSize.Y)
            esp.Box.Bottom.Color = bottomColor
            esp.Box.Bottom.Thickness = Config.ESP.BoxThickness
            esp.Box.Bottom.Visible = true
            
            esp.Box.TopLeft.Visible = false
            esp.Box.TopRight.Visible = false
            esp.Box.BottomLeft.Visible = false
            esp.Box.BottomRight.Visible = false
        end
    else
		if esp.Box then
			for _, line in pairs(esp.Box) do
				line.Visible = false
			end
		end
		if esp.BoxFill then
			esp.BoxFill.Visible = false
		end
	end
	return boxPosition, boxSize
end

function UpdateTracers(player, esp, rootPart)
	if not Config.ESP.TracerESP or not esp.Tracer then
		if esp.Tracer then
			esp.Tracer.Visible = false
		end
		return
	end
	
	local pos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
	if not onScreen or pos.Z < 0 then
		esp.Tracer.Visible = false
		return
	end
	
	local tracerOrigin = GetTracerOrigin()
	local tracerColor = GetESPThemeColor(rootPart, nil, nil, Config.ESP.Colors.Tracer)
	esp.Tracer.From = tracerOrigin
	esp.Tracer.To = Vector2.new(pos.X, pos.Y)
	esp.Tracer.Color = tracerColor
	esp.Tracer.Thickness = Config.ESP.TracerThickness
	esp.Tracer.Visible = true
end

function UpdateHealthBars(player, esp, character, humanoid, boxPosition, boxSize, screenHeight)
	if not Config.ESP.HealthESP or not esp.HealthBar then
		if esp.HealthBar then
			esp.HealthBar.Outline.Visible = false
			esp.HealthBar.Fill.Visible = false
			esp.HealthBar.Text.Visible = false
		end
		return
	end
	
	local health = humanoid.Health
	local maxHealth = humanoid.MaxHealth
	local healthPercent = math.clamp(health / maxHealth, 0, 1)
	local themeColor = GetESPThemeColor(nil, boxPosition, boxSize, Config.ESP.Colors.Health)
	
	local barHeight = screenHeight * 0.9
	local barWidth = 4
	local barPos = Vector2.new(
		boxPosition.X - barWidth - 4,
		boxPosition.Y + (screenHeight - barHeight) / 2
	)

	esp.HealthBar.Outline.Size = Vector2.new(barWidth + 2, barHeight + 2)
	esp.HealthBar.Outline.Position = barPos - Vector2.new(1, 1)
	esp.HealthBar.Outline.Color = Color3.fromRGB(0, 0, 0)
	esp.HealthBar.Outline.Filled = true
	esp.HealthBar.Outline.Visible = true

	local fillHeight = barHeight * healthPercent
	esp.HealthBar.Fill.Size = Vector2.new(barWidth, fillHeight)
	esp.HealthBar.Fill.Position = Vector2.new(barPos.X, barPos.Y + barHeight - fillHeight)
	esp.HealthBar.Fill.Color = Config.ESP.GradientEnabled and themeColor or GetHealthColor(health, maxHealth)
	esp.HealthBar.Fill.Filled = true
	esp.HealthBar.Fill.Visible = true

	if Config.ESP.HealthStyle == "Both" or Config.ESP.HealthStyle == "Text" then
		esp.HealthBar.Text.Text = math.floor(health) .. (Config.ESP.HealthTextSuffix or "")
		esp.HealthBar.Text.Position = Vector2.new(barPos.X - 15, barPos.Y + barHeight / 2)
		esp.HealthBar.Text.Color = themeColor
		esp.HealthBar.Text.Size = Config.ESP.TextSize
		esp.HealthBar.Text.Visible = true
	else
		esp.HealthBar.Text.Visible = false
	end
end

function UpdateNames(player, esp, character, rootPart, boxPosition, boxSize)
	if not esp.Info then return end
	local themeColor = GetESPThemeColor(rootPart, boxPosition, boxSize, Config.ESP.Colors.Text)

	if Config.ESP.NameESP and esp.Info.Name then
		local nameText = Config.ESP.NameMode == "UserName" and player.Name or player.DisplayName
		esp.Info.Name.Text = nameText
		esp.Info.Name.Position = Vector2.new(
			boxPosition.X + boxSize.X / 2,
			boxPosition.Y - 18
		)
		esp.Info.Name.Color = themeColor
		esp.Info.Name.Size = Config.ESP.TextSize
		esp.Info.Name.Visible = true
	elseif esp.Info.Name then
		esp.Info.Name.Visible = false
	end

	if esp.Info.Distance then
		esp.Info.Distance.Visible = false
	end
end

function UpdateSkeleton(player, esp, character)
	if not Config.ESP.SkeletonESP or not esp.Skeleton then
		esp._lastSkeletonUpdate = nil
		if esp.Skeleton then
			for _, line in pairs(esp.Skeleton) do
				line.Visible = false
			end
		end
		return
	end

	local now = tick()
	if esp._lastSkeletonUpdate and (now - esp._lastSkeletonUpdate) < SKELETON_UPDATE_INTERVAL then
		return
	end
	esp._lastSkeletonUpdate = now

	local skeletonData = RefreshCharacterSkeletonCache(character)
	if not skeletonData then return end

	if skeletonData.GenericPairs then
		for i = 1, #esp.Skeleton do
			local line = esp.Skeleton[i]
			local pair = skeletonData.GenericPairs[i]
			if pair and pair[1] and pair[2] then
				local fromPos, fromOnScreen = Camera:WorldToViewportPoint(pair[1].Position)
				local toPos, toOnScreen = Camera:WorldToViewportPoint(pair[2].Position)
				if fromOnScreen and toOnScreen and fromPos.Z > 0 and toPos.Z > 0 then
					line.From = Vector2.new(fromPos.X, fromPos.Y)
					line.To = Vector2.new(toPos.X, toPos.Y)
					line.Color = Config.ESP.Colors.Skeleton
					line.Thickness = Config.ESP.SkeletonThickness
					line.Transparency = Config.ESP.SkeletonTransparency
					line.Visible = true
				else
					line.Visible = false
				end
			else
				line.Visible = false
			end
		end
		return
	end

	local bones = skeletonData.Bones
	for i, keys in ipairs(SKELETON_CONNECTION_KEYS) do
		local from, to = bones[keys[1]], bones[keys[2]]
		local line = esp.Skeleton[i]
		
		if from and to and line and from:IsDescendantOf(character) and to:IsDescendantOf(character) then
			local fromPos, fromOnScreen = Camera:WorldToViewportPoint(from.Position)
			local toPos, toOnScreen = Camera:WorldToViewportPoint(to.Position)
			
			if fromOnScreen and toOnScreen and fromPos.Z > 0 and toPos.Z > 0 then
				line.From = Vector2.new(fromPos.X, fromPos.Y)
				line.To = Vector2.new(toPos.X, toPos.Y)
				line.Color = Config.ESP.Colors.Skeleton
				line.Thickness = Config.ESP.SkeletonThickness
				line.Transparency = Config.ESP.SkeletonTransparency
				line.Visible = true
			else
				line.Visible = false
			end
		elseif line then
			line.Visible = false
		end
	end
end

function UpdateChams(player, character)
    if not Config.ESP.ChamsEnabled then
        if _G.ESPDrawings[player] then
            _G.ESPDrawings[player]._lastChamsUpdate = nil
        end
        if _G.ESPDrawings[player] and _G.ESPDrawings[player].ChamsQuads then
            for partName, quads in pairs(_G.ESPDrawings[player].ChamsQuads) do
                for _, quad in ipairs(quads) do
                    quad.Visible = false
                end
            end
        end
        return
    end
    
    if player == LocalPlayer or not character then return end
    
    local core = RefreshCharacterCoreCache(character)
    local humanoid = core and core.Humanoid
    if humanoid and humanoid.Health <= 0 then
        if _G.ESPDrawings[player] and _G.ESPDrawings[player].ChamsQuads then
            for partName, quads in pairs(_G.ESPDrawings[player].ChamsQuads) do
                for _, quad in ipairs(quads) do
                    quad.Visible = false
                end
            end
        end
        return
    end
    
    local fillColor = Config.ESP.Colors.Chams
    local transparency = Config.ESP.ChamsTransparency
    
    local esp = _G.ESPDrawings[player]
    if not esp then
        esp = {}
        _G.ESPDrawings[player] = esp
    end
    if not esp.ChamsQuads then
        esp.ChamsQuads = {}
    end

    local now = tick()
    if esp._lastChamsUpdate and (now - esp._lastChamsUpdate) < CHAMS_UPDATE_INTERVAL then
        return
    end
    esp._lastChamsUpdate = now

    local quadsForPlayer = esp.ChamsQuads

    local rootPart = core and core.RootPart
    if rootPart then
        local distance = (rootPart.Position - Camera.CFrame.Position).Magnitude
        if distance > Config.ESP.MaxDistance then
            for partName, quads in pairs(quadsForPlayer) do
                for _, quad in ipairs(quads) do
                    quad.Visible = false
                end
            end
            return
        end
    end
    local ViewportSize = Camera.ViewportSize
    local chamsEntries = RefreshCharacterChamsPartCache(character)
    for _, entry in ipairs(chamsEntries) do
        local partKey = entry.key
        local part = entry.part
        if part and part:IsA("BasePart") and part:IsDescendantOf(character) then
            if not quadsForPlayer[partKey] then
                local quads = {}
                for i = 1, 6 do
                    quads[i] = NewQuad(fillColor)
                end
                quadsForPlayer[partKey] = quads
            end

            local quads = quadsForPlayer[partKey]
            local size = part.Size
            local cf = part.CFrame
            local hx, hy, hz = size.X * 0.5, size.Y * 0.5, size.Z * 0.5
            local corners = {
                cf * Vector3.new(-hx,  hy, -hz),
                cf * Vector3.new(-hx,  hy,  hz),
                cf * Vector3.new( hx,  hy,  hz),
                cf * Vector3.new( hx,  hy, -hz),
                cf * Vector3.new(-hx, -hy, -hz),
                cf * Vector3.new(-hx, -hy,  hz),
                cf * Vector3.new( hx, -hy,  hz),
                cf * Vector3.new( hx, -hy, -hz)
            }

            local points = {}
            local anyCornerVisible = false
            local allCornersBehind = true

            for i = 1, 8 do
                local pos, _ = Camera:WorldToViewportPoint(corners[i])
                points[i] = Vector2.new(pos.X, pos.Y)
                if pos.Z > 0 then
                    allCornersBehind = false
                    if pos.X >= 0 and pos.X <= ViewportSize.X and pos.Y >= 0 and pos.Y <= ViewportSize.Y then
                        anyCornerVisible = true
                    end
                end
            end

            if allCornersBehind or not anyCornerVisible then
                for i = 1, 6 do
                    quads[i].Visible = false
                end
            else
                for i, face in ipairs(CHAMS_FACES) do
                    local quad = quads[i]
                    quad.PointA = points[face[1]]
                    quad.PointB = points[face[2]]
                    quad.PointC = points[face[3]]
                    quad.PointD = points[face[4]]
                    quad.Color = fillColor
                    quad.Transparency = transparency
                    quad.Visible = true
                end
            end
        end
    end

    for partKey, quads in pairs(quadsForPlayer) do
        local keepVisible = false
        if typeof(partKey) == "Instance" then
            keepVisible = partKey.Parent and partKey:IsDescendantOf(character)
        else
            keepVisible = character:FindFirstChild(partKey) ~= nil
        end
        if not keepVisible then
            for _, quad in ipairs(quads) do
                quad.Visible = false
            end
        end
    end
end

function UpdateESP(player)
	if not Config.ESP.Enabled then
		if _G.ESPDrawings[player] then
			HideESPDrawings(_G.ESPDrawings[player])
		end
		return
	end
	
	local esp = _G.ESPDrawings[player]
	if not esp then return end

	local function HideAllESP() HideESPDrawings(esp) end
	
	if player == LocalPlayer or not player.Character then 
		HideAllESP()
		return 
	end

    if Config.ESP.TeamCheck and not IsPlayerEnemy(player) then
        HideAllESP()
        return
    end
	
	local character = player.Character
	local core = RefreshCharacterCoreCache(character)
	local humanoid = core and core.Humanoid
	local rootPart = core and core.RootPart
	
	if not (humanoid and rootPart and humanoid.Health > 0) then 
		HideAllESP()
		return 
	end
	
	local distance = (rootPart.Position - Camera.CFrame.Position).Magnitude

	if distance > Config.ESP.MaxDistance then 
		HideAllESP()
		return 
	end

	local headPart = core and core.HeadPart
	local boxPosition, boxSize = UpdateBoxes(player, esp, character, humanoid, rootPart, headPart)

	if not boxPosition or not boxSize then
		HideAllESP()
		return
	end
	
	local screenHeight = boxSize.Y
	UpdateTracers(player, esp, rootPart)
	UpdateHealthBars(player, esp, character, humanoid, boxPosition, boxSize, screenHeight)
	UpdateNames(player, esp, character, rootPart, boxPosition, boxSize)
	
	UpdateSkeleton(player, esp, character)
	UpdateChams(player, character)
end

function UpdateEncryptedModelESP(model)
	if not Config.ESP.Enabled then return end
	if not model or not model.Parent then return end

	EnsureESPKey(model)
	local esp = _G.ESPDrawings[model]
	if not esp then return end

	local humanoid = model:FindFirstChildOfClass("Humanoid")
	local rootPart = GetBestBasePart(model, "HumanoidRootPart")
	if not rootPart then
		HideESPDrawings(esp)
		return
	end

	if humanoid and humanoid.Health <= 0 then
		HideESPDrawings(esp)
		return
	end

	local distance = (rootPart.Position - Camera.CFrame.Position).Magnitude
	if distance > Config.ESP.MaxDistance then
		HideESPDrawings(esp)
		return
	end

	local headPart = model:FindFirstChild("Head", true) or GetHighestPart(model, rootPart)
	local hp, maxHp = GetModelHealthValues(model)
	local dummyHumanoid = humanoid or (hp and {Health = hp, MaxHealth = maxHp}) or {Health = 100, MaxHealth = 100}
	local boxPosition, boxSize = UpdateBoxes(model, esp, model, dummyHumanoid, rootPart, headPart)
	if not boxPosition or not boxSize then
		HideESPDrawings(esp)
		return
	end

	UpdateTracers(model, esp, rootPart)
	if humanoid then
		UpdateHealthBars(model, esp, model, humanoid, boxPosition, boxSize, boxSize.Y)
	elseif hp then
		UpdateHealthBars(model, esp, model, {Health = hp, MaxHealth = maxHp}, boxPosition, boxSize, boxSize.Y)
	elseif esp.HealthBar then
		esp.HealthBar.Outline.Visible = false
		esp.HealthBar.Fill.Visible = false
		esp.HealthBar.Text.Visible = false
	end

	local resolvedName = ResolveEncryptedName(model)
	local pseudoPlayer = {Name = resolvedName, DisplayName = resolvedName}
	UpdateNames(pseudoPlayer, esp, model, rootPart, boxPosition, boxSize)
	UpdateSkeleton(model, esp, model)
	UpdateChams(model, model)
end

function UpdateEncryptedTargets()
	local models = GetEncryptedEnemyModelsCached(Config.ESP.TeamCheck)
	local seenModels = {}

	for _, model in ipairs(models) do
		seenModels[model] = true
		UpdateEncryptedModelESP(model)
	end

	for key, esp in pairs(_G.ESPDrawings) do
		if typeof(key) == "Instance" and key:IsA("Model") then
			if not key.Parent or not seenModels[key] then
				HideESPDrawings(esp)
			end
		end
	end
end

function ToggleRadar(enabled)
	Config.ESP.RadarEnabled = enabled
	if enabled and not _G.ESPRadarComponents.Background then
		InitRadar()
	end
end

function ToggleDirectionalArrows(enabled)
	Config.ESP.DirectionalArrowsEnabled = enabled
	if not enabled then
		for player, arrow in pairs(_G.ESPDirectionalArrows) do
			arrow.Triangle.Visible = false
			arrow.DistanceText.Visible = false
		end
	end
end

InitRadar()

local lastESPUpdate = 0
local lastRadarUpdate = 0
local lastArrowUpdate = 0

RunService.RenderStepped:Connect(function()
	local currentTime = tick()

	if Config.ESP.Enabled and (currentTime - lastESPUpdate) >= Config.ESP.RefreshRate then
		for _, player in ipairs(GetPlayersListCached()) do
			if player ~= LocalPlayer then
				if not _G.ESPDrawings[player] then
					CreateESP(player)
				end
				UpdateESP(player)
			end
		end
		UpdateEncryptedTargets()
		lastESPUpdate = currentTime
	elseif not Config.ESP.Enabled then
		for _, player in ipairs(GetPlayersListCached()) do
			if _G.ESPDrawings[player] then
				HideESPDrawings(_G.ESPDrawings[player])
			end
			if _G.ESPHighlights[player] then
				_G.ESPHighlights[player].Enabled = false
			end
		end
		for key, esp in pairs(_G.ESPDrawings) do
			if typeof(key) == "Instance" and key:IsA("Model") then
				HideESPDrawings(esp)
			end
		end
	end

	if (currentTime - lastRadarUpdate) >= (1/30) then
		UpdateRadar()
		lastRadarUpdate = currentTime
	end

	if (currentTime - lastArrowUpdate) >= (1/30) then
		UpdateArrows()
		lastArrowUpdate = currentTime
	end
end)

Players.PlayerAdded:Connect(function(player)
	if player ~= LocalPlayer then
		CreateESP(player)
	end
end)

Players.PlayerRemoving:Connect(RemoveESP)

for _, player in ipairs(GetPlayersListCached()) do
	if player ~= LocalPlayer then
		CreateESP(player)
	end
end

--========================================================--
--  DRAWING + VELOCITY VIEWER
--========================================================--

local function new_line()
	local l = Drawing.new("Line")
	l.Visible = false
	l.ZIndex = 5
	return l
end

local function new_circle()
	local c = Drawing.new("Circle")
	c.Visible = false
	c.ZIndex = 5
	return c
end

local function new_square()
	local s = Drawing.new("Square")
	s.Visible = false
	s.ZIndex = 5
	return s
end

local function new_triangle()
	local t = Drawing.new("Triangle")
	t.Visible = false
	t.ZIndex = 5
	return t
end

local ch_drawings = {
	lines = {},
	outlines = {},
	dot = nil,
	dot_outline = nil,
	center_dot = nil,
	center_dot_outline = nil,
	circle = nil,
	circle_outline = nil,
	square = nil,
	square_outline = nil,
	triangle = nil,
	triangle_outline = nil,
}

local fov_lines = {}
local fov_double_lines = {}
local fov_dash_lines = {}
local fov_markers = {}
local anim_t = 0
local smoothed_crosshair_center = nil
local smoothed_fov_center = nil

for i = 1, 8 do
	ch_drawings.lines[i] = new_line()
	ch_drawings.outlines[i] = new_line()
end

ch_drawings.dot = new_circle()
ch_drawings.dot_outline = new_circle()
ch_drawings.center_dot = new_circle()
ch_drawings.center_dot_outline = new_circle()
ch_drawings.circle = new_circle()
ch_drawings.circle_outline = new_circle()
ch_drawings.square = new_square()
ch_drawings.square_outline = new_square()
ch_drawings.triangle = new_triangle()
ch_drawings.triangle_outline = new_triangle()

local circle = new_circle()
circle.ZIndex = 4

for i = 1, MAX_FOV_SEG do
	fov_lines[i] = new_line()
	fov_double_lines[i] = new_line()
	fov_double_lines[i].Thickness = 1
end
for i = 1, 32 do
	fov_dash_lines[i] = new_line()
	fov_dash_lines[i].Thickness = 2
	fov_markers[i] = new_line()
	fov_markers[i].Thickness = 2
end

local VelocityViewer = game:GetObjects("rbxassetid://139278105250787")[1]
VelocityViewer.Parent = workspace
VelocityViewer.Anchored = true
VelocityViewer.Size = Vector3.new(0, 0, 0)
VelocityViewer.CanTouch = false
VelocityViewer.CanCollide = false
VelocityViewer.Massless = true
VelocityViewer.CanQuery = false

--========================================================--
--  Silent hit chance
--========================================================--

local function ShouldHit()
    if not Config.UseHitChance then return true end
    local chance = Config.HitChance
    local roll = math.random(1, 100)
    lastHitChanceRoll = roll
    table.insert(hitChanceHistory, {chance = chance, roll = roll, hit = roll <= chance, time = tick()})
    if #hitChanceHistory > 10 then table.remove(hitChanceHistory, 1) end
    return roll <= chance
end

--========================================================--
--  AIMBOT
--========================================================--

local function isValidTarget(character)
	if not character or not character.Parent then
		return false
	end

	if Config.TeamCheck then
		local targetPlayer = Players:GetPlayerFromCharacter(character)
		if targetPlayer then
			if not IsPlayerEnemy(targetPlayer) then
				return false
			end
		else
			local targetTeamFolder = character.Parent
			local localTeamFolder = GetLocalWorkspaceTeamFolder()
			if localTeamFolder and targetTeamFolder == localTeamFolder then
				return false
			end
		end
	end

	if Config.WallCheck then
		local origin = Camera.CFrame.Position
		local targetPart = character:FindFirstChild("HumanoidRootPart")
			or (GetEncryptedHeadPart and GetEncryptedHeadPart(character))
			or GetBestBasePart(character, "HumanoidRootPart")
		if not targetPart then
			return false
		end
		local targetPos = targetPart.Position
		local dir = targetPos - origin

		local params = RaycastParams.new()
		params.FilterType = Enum.RaycastFilterType.Exclude
		params.FilterDescendantsInstances = {LocalPlayer.Character}
		params.IgnoreWater = true

		local result = workspace:Raycast(origin, dir.Unit * dir.Magnitude, params)
		if result and not result.Instance:IsDescendantOf(character) then
			return false
		end
	end

	return true
end

local function getMousePos()
	local success, pos = pcall(function()
		return UserInputService:GetMouseLocation()
	end)

	if success and pos then
		return Vector2.new(pos.X, pos.Y)
	else
		return Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
	end
end

local function getScreenPos(character)
	if not character then return nil end
	local root = character:FindFirstChild("HumanoidRootPart")
		or (GetEncryptedHeadPart and GetEncryptedHeadPart(character))
		or GetBestBasePart(character, "HumanoidRootPart")
	if not root then return nil end
	local pos, onScreen = Camera:WorldToViewportPoint(root.Position)
	if not onScreen then return nil end
	return Vector2.new(pos.X, pos.Y)
end

local function isInsideCircle(point, center, radius)
	if not point or not center then return false end
	return (point - center).Magnitude <= radius
end

local function getClosestPlayerInFov()
	local mousePos = getMousePos()
	local closestTarget = nil
	local closestDistance = math.huge
	local enforceFov = Config.UseFov == true
	local fovRadius = Config.FovSize

	for _, player in ipairs(GetPlayersListCached()) do
		if player ~= LocalPlayer and player.Character then
			local screenPos = getScreenPos(player.Character)
			if screenPos then
				local distance = (screenPos - mousePos).Magnitude
				if (not enforceFov) or isInsideCircle(screenPos, mousePos, fovRadius) then
					if distance < closestDistance then
						if isValidTarget(player.Character) then
							closestDistance = distance
							closestTarget = player.Character
						end
					end
				end
			end
		end
	end

	for _, model in ipairs(GetEncryptedEnemyModelsCached(Config.TeamCheck)) do
		local head = nil
		if GetEncryptedHeadPart then
			head = GetEncryptedHeadPart(model)
		end
		head = head or GetBestBasePart(model, "HumanoidRootPart")
		if head then
			local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
			if onScreen and screenPos.Z > 0 then
				local pos2D = Vector2.new(screenPos.X, screenPos.Y)
				local distance = (pos2D - mousePos).Magnitude
				if ((not enforceFov) or isInsideCircle(pos2D, mousePos, fovRadius)) and distance < closestDistance then
					if isValidTarget(model) then
						closestDistance = distance
						closestTarget = model
					end
				end
			end
		end
	end

	return closestTarget
end

local function getClosestPartToMouse(character, useFov)
	if not character then return nil end

	local closestPart = nil
	local closestDistance = math.huge
	local mousePos = getMousePos()
	local fovRadius = Config.FovSize

	if useFov == nil then
		useFov = Config.UseFov
	end

	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") then
			local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
			if onScreen and screenPos.Z > 0 then
				local screenPos2D = Vector2.new(screenPos.X, screenPos.Y)
				local distance = (screenPos2D - mousePos).Magnitude

				if not useFov or isInsideCircle(screenPos2D, mousePos, fovRadius) then
					if distance < closestDistance then
						closestDistance = distance
						closestPart = part
					end
				end
			end
		end
	end

	return closestPart
end

local function GetSelectedAimPart(character, selectedPart)
	if not character or not selectedPart or selectedPart == "Closest Part" then
		return nil
	end

	local aliases = {
		Head = {"Head"},
		Torso = {"Torso", "UpperTorso", "LowerTorso", "HumanoidRootPart"},
		["Left Arm"] = {"Left Arm", "LeftUpperArm", "LeftLowerArm", "LeftHand"},
		["Right Arm"] = {"Right Arm", "RightUpperArm", "RightLowerArm", "RightHand"},
		["Left Leg"] = {"Left Leg", "LeftUpperLeg", "LeftLowerLeg", "LeftFoot"},
		["Right Leg"] = {"Right Leg", "RightUpperLeg", "RightLowerLeg", "RightFoot"},
		HumanoidRootPart = {"HumanoidRootPart", "Torso", "UpperTorso"},
		UpperTorso = {"UpperTorso", "Torso"},
		LowerTorso = {"LowerTorso", "Torso"}
	}

	local nameList = aliases[selectedPart] or {selectedPart}
	for _, partName in ipairs(nameList) do
		local part = character:FindFirstChild(partName, true)
		if part and part:IsA("BasePart") then
			return part
		end
	end

	local allParts = {}
	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") then
			table.insert(allParts, part)
		end
	end
	if #allParts == 0 then
		return nil
	end

	local root = GetBestBasePart(character, "HumanoidRootPart") or allParts[1]
	if not root then
		return allParts[1]
	end

	if selectedPart == "Head" then
		local encryptedHead = GetEncryptedHeadPart and GetEncryptedHeadPart(character)
		if encryptedHead then
			return encryptedHead
		end

		local highestPart = allParts[1]
		for i = 2, #allParts do
			local p = allParts[i]
			if p.Position.Y > highestPart.Position.Y then
				highestPart = p
			end
		end
		return highestPart
	end

	local bestPart = nil
	local bestScore = -math.huge
	for _, part in ipairs(allParts) do
		local relative = root.CFrame:PointToObjectSpace(part.Position)
		local score = -math.huge

		if selectedPart == "Torso" then
			local rootDist = (part.Position - root.Position).Magnitude
			score = -rootDist - math.abs(relative.X) * 0.25 - math.abs(relative.Y) * 0.1
		elseif selectedPart == "Left Arm" then
			if relative.X < 0 then
				score = (-relative.X * 2) + (math.max(relative.Y, 0) * 0.75) - (math.abs(relative.Z) * 0.1)
			end
		elseif selectedPart == "Right Arm" then
			if relative.X > 0 then
				score = (relative.X * 2) + (math.max(relative.Y, 0) * 0.75) - (math.abs(relative.Z) * 0.1)
			end
		elseif selectedPart == "Left Leg" then
			if relative.X < 0 then
				score = (-relative.X * 1.5) + (math.max(-relative.Y, 0) * 2) - (math.abs(relative.Z) * 0.1)
			end
		elseif selectedPart == "Right Leg" then
			if relative.X > 0 then
				score = (relative.X * 1.5) + (math.max(-relative.Y, 0) * 2) - (math.abs(relative.Z) * 0.1)
			end
		end

		if score > bestScore then
			bestScore = score
			bestPart = part
		end
	end

	if bestPart then
		return bestPart
	end

	return nil
end

local function ToggleCamLockInput()
	if Config.Enabled ~= true then
		return
	end

	if Config.CamLockActive then
		Config.CamLockActive = false
		lockedTarget = nil
		locked = false
		lastValidTarget = nil
		lastValidTargetPlayer = nil
		return
	end

	Config.CamLockActive = true
	local closestPlayer = getClosestPlayerInFov()
	if closestPlayer and isValidTarget(closestPlayer) then
		lockedTarget = closestPlayer
		locked = true
		lastValidTarget = closestPlayer
		lastValidTargetPlayer = Players:GetPlayerFromCharacter(closestPlayer)
	end
end

local function Togglexrayinput()
	Config.ESP.XrayActive = not Config.ESP.XrayActive
	if Config.ESP.XrayActive then
		enablexraymap()
	else
		disablexraymap()
	end
end

local function MainAimInit()
	if not Config.Enabled then
		Config.CamLockActive = false
		lockedTarget = nil
		locked = false
		lastValidTarget = nil
		lastValidTargetPlayer = nil
		VelocityViewer.BillboardGui.Enabled = false
		is_setting_mouse_pos = false
		silent_target_position = nil
		mouse_position = nil
		return
	end

	if not Config.CamLockActive then
		lockedTarget = nil
		locked = false
		VelocityViewer.BillboardGui.Enabled = false
		is_setting_mouse_pos = false
		silent_target_position = nil
		mouse_position = nil
		return
	end

	if Config.StickyTarget and lastValidTarget and lastValidTarget.Parent and isValidTarget(lastValidTarget) then
		lockedTarget = lastValidTarget
		locked = true
	elseif Config.StickyTarget and lastValidTargetPlayer then
		local player = lastValidTargetPlayer
		local character = player and player.Parent and player.Character or nil
		if character and character.Parent and isValidTarget(character) then
			lockedTarget = character
			locked = true
		else
			lastValidTargetPlayer = nil
			lastValidTarget = nil
			lockedTarget = nil
			locked = false
		end
	end

	if not locked then
		local closestPlayer = getClosestPlayerInFov()
		if closestPlayer then
			lockedTarget = closestPlayer
			locked = true
			lastValidTarget = closestPlayer
			local plr = Players:GetPlayerFromCharacter(closestPlayer)
			lastValidTargetPlayer = plr
		else
			lockedTarget = nil
			locked = false
		end
	end

    if lockedTarget and locked then
		if Config.UseHitChance and type(ShouldHit) == "function" and not ShouldHit() then
            is_setting_mouse_pos = false   
            silent_target_position = nil
            mouse_position = nil
            return
        end
        local partToAim = nil
        if Config.AimPart == "Closest Part" then
            partToAim = getClosestPartToMouse(lockedTarget)
        else
            partToAim = GetSelectedAimPart(lockedTarget, Config.AimPart)
        end

        if not partToAim and GetEncryptedHeadPart then
            partToAim = GetEncryptedHeadPart(lockedTarget)
        end
        if not partToAim then
            partToAim = getClosestPartToMouse(lockedTarget, Config.UseFov)
        end
        if not partToAim then
            is_setting_mouse_pos = false
            silent_target_position = nil
            mouse_position = nil
            return
        end

        local predictionVelocity = partToAim.AssemblyLinearVelocity or partToAim.Velocity or Vector3.new(0, 0, 0)
        local predictionAmount = (Config.UsePrediction and tonumber(Config.Prediction)) or 0
        local predicted = (partToAim.Position + predictionVelocity * predictionAmount) + Vector3.new(0, 0.001, 0)

        is_setting_mouse_pos = true
        local screenPos, onScreen = Camera:WorldToViewportPoint(predicted)
        if onScreen and screenPos.Z > 0 then
            local mousePos = getMousePos()
            local delta = Vector2.new(screenPos.X - mousePos.X, screenPos.Y - mousePos.Y)
            local smooth = tonumber(Config.Smoothness) or 1
            if smooth < 1 then smooth = 1 end
            local lerpAlpha = math.clamp(1 / smooth, 0, 1)
            local curve = Config.CurveStyle
            local power = tonumber(Config.CurvePower) or 1
            if curve == "smoothstep" then
                lerpAlpha = lerpAlpha * lerpAlpha * (3 - 2 * lerpAlpha)
            elseif curve == "easein" then
                lerpAlpha = lerpAlpha ^ power
            elseif curve == "easeout" then
                lerpAlpha = 1 - (1 - lerpAlpha) ^ power
            elseif curve == "easeinout" then
                if lerpAlpha < 0.5 then
                    lerpAlpha = 0.5 * (2 * lerpAlpha) ^ power
                else
                    lerpAlpha = 1 - 0.5 * (2 * (1 - lerpAlpha)) ^ power
                end
            end

            local jitterAmt = tonumber(Config.JitterAmount) or 0
            if jitterAmt > 0 then
                local jx = (math.random() * 2 - 1) * jitterAmt
                local jy = (math.random() * 2 - 1) * jitterAmt
                predicted = predicted + Vector3.new(jx, jy, 0)
                delta = delta + Vector2.new(jx, jy)
            end

            local baseGain = (Config.CFrame_Speed and Config.CFrame_Speed_Amount) or 1
            local gain = baseGain * lerpAlpha

            if mousemoverel then
                mousemoverel(delta.X * gain, delta.Y * gain)
            elseif mousemoveabs then
                mousemoveabs(mousePos.X + (delta.X * gain), mousePos.Y + (delta.Y * gain))
            else
                local camPos = Camera.CFrame.Position
                local targetCFrame = CFrame.lookAt(camPos, predicted)
                if smooth > 1 then
                    Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, lerpAlpha)
                else
                    Camera.CFrame = targetCFrame
                end
            end

            silent_target_position = nil
            mouse_position = nil
        else
            is_setting_mouse_pos = false
            silent_target_position = nil
            mouse_position = nil
        end

        if VisibleDot then
            VelocityViewer.BillboardGui.Enabled = true
            VelocityViewer.Position = predicted
        else
            VelocityViewer.Position = Vector3.new(0,0,0)
            VelocityViewer.BillboardGui.Enabled = false
        end
    else
        VelocityViewer.BillboardGui.Enabled = false
        is_setting_mouse_pos = false
        silent_target_position = nil
        mouse_position = nil
    end
end

--========================================================--
--  CROSSHAIR & FOV DRAWING
--========================================================--

local function lerp_color(a, b, t)
	return Color3.new(
		a.R + (b.R - a.R) * t,
		a.G + (b.G - a.G) * t,
		a.B + (b.B - a.B) * t
	)
end

local function smooth_follow(prev, target, slow)
	if not prev then return target end
	local s = math.max(0, slow or 0)
	local alpha = math.clamp(1 / (1 + s * 4), 0.02, 1)
	return prev:Lerp(target, alpha)
end

local function hide_ch()
	for i = 1, 8 do
		ch_drawings.lines[i].Visible = false
		ch_drawings.outlines[i].Visible = false
	end
	ch_drawings.dot.Visible = false
	ch_drawings.dot_outline.Visible = false
	ch_drawings.center_dot.Visible = false
	ch_drawings.center_dot_outline.Visible = false
	ch_drawings.circle.Visible = false
	ch_drawings.circle_outline.Visible = false
	ch_drawings.square.Visible = false
	ch_drawings.square_outline.Visible = false
	ch_drawings.triangle.Visible = false
	ch_drawings.triangle_outline.Visible = false
end

local function hide_fov_extra()
	for i = 1, MAX_FOV_SEG do
		fov_lines[i].Visible = false
		fov_double_lines[i].Visible = false
	end
	for i = 1, 32 do
		fov_dash_lines[i].Visible = false
		fov_markers[i].Visible = false
	end
end

local function ch_anim_offset()
	local c = Config.crosshair
	local s, intensity = c.anim_speed, c.anim_intensity
	if c.anim_style == "pulse" then return math.sin(anim_t * s * math.pi * 2) * intensity * 3 end
	if c.anim_style == "breathe" then return (math.sin(anim_t * s) * 0.5 + 0.5) * intensity * 4 end
	if c.anim_style == "expand" then return math.abs(math.sin(anim_t * s)) * intensity * 5 end
	if c.anim_style == "wave" then return math.sin(anim_t * s * 2) * intensity * 2 end
	return 0
end

local function fov_anim_offset()
	local f = Config.fov
	local s, intensity = f.anim_speed, f.anim_intensity
	if f.anim_style == "pulse" then return math.sin(anim_t * s * math.pi * 2) * intensity * 8 end
	if f.anim_style == "breathe" then return (math.sin(anim_t * s) * 0.5 + 0.5) * intensity * 10 end
	if f.anim_style == "wave" then return math.sin(anim_t * s * 2) * intensity * 5 end
	return 0
end

local function fov_anim_angle()
	local f = Config.fov
	if f.anim_style == "spin" then
		return anim_t * f.anim_speed * math.pi * 2
	end
	return 0
end

local function ch_get_color(t)
	local c = Config.crosshair
	if not c.use_gradient then return c.color end
	local adjusted = ((t or 0.5) + c.gradient_angle / 360) % 1
	return lerp_color(c.gradient_a, c.gradient_b, adjusted)
end

local function set_line(line, outline, from, to, center)
	local c = Config.crosshair
	local col = c.color
	if c.use_gradient then
		local mid = (from + to) * 0.5
		local dir = mid - center
		local t = ((math.atan2(dir.Y, dir.X) / (math.pi * 2)) + 0.5 + (c.gradient_angle / 360)) % 1
		col = lerp_color(c.gradient_a, c.gradient_b, t)
	end

	line.From = from
	line.To = to
	line.Color = col
	line.Thickness = c.thickness
	line.Transparency = c.opacity
	line.Visible = true

	if c.show_outline then
		outline.From = from
		outline.To = to
		outline.Color = c.outline_color
		outline.Thickness = c.thickness + c.outline_thickness * 2
		outline.Transparency = c.outline_opacity
		outline.ZIndex = line.ZIndex - 1
		outline.Visible = true
	else
		outline.Visible = false
	end
end

local function get_spread()
	local c = Config.crosshair
	if not c.dynamic_spread then return 0 end
	local char = LocalPlayer.Character
	if not char then return 0 end
	local hum = char:FindFirstChildOfClass("Humanoid")
	local root = char:FindFirstChild("HumanoidRootPart")
	if not hum or not root then return 0 end
	local speed = Vector3.new(root.Velocity.X, 0, root.Velocity.Z).Magnitude
	return math.clamp(speed / hum.WalkSpeed, 0, 1) * c.spread_multiplier * 8
end

local function draw_crosshair()
	local c = Config.crosshair
	if not c.enabled then
		hide_ch()
		return
	end

	local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
	if c.follow_mouse and getMousePos then
		local target = getMousePos()
		smoothed_crosshair_center = smooth_follow(smoothed_crosshair_center, target, c.follow_lerp)
		center = smoothed_crosshair_center
	else
		smoothed_crosshair_center = nil
	end

	local style = c.style
	local anim_off = ch_anim_offset()
	local size = math.max(1, c.size + anim_off)
	local gap = math.max(0, c.gap + get_spread() + anim_off * 0.5)
	local thick = c.thickness
	local used_lines = 0

	ch_drawings.dot.Visible = false
	ch_drawings.dot_outline.Visible = false
	ch_drawings.center_dot.Visible = false
	ch_drawings.center_dot_outline.Visible = false
	ch_drawings.circle.Visible = false
	ch_drawings.circle_outline.Visible = false
	ch_drawings.square.Visible = false
	ch_drawings.square_outline.Visible = false
	ch_drawings.triangle.Visible = false
	ch_drawings.triangle_outline.Visible = false

	if style == "cross" or style == "t-style" then
		local ln = {
			{ from = center + Vector2.new(gap, 0), to = center + Vector2.new(gap + size, 0), t0 = 0.5, t1 = 0.75 },
			{ from = center - Vector2.new(gap, 0), to = center - Vector2.new(gap + size, 0), t0 = 0.25, t1 = 0 },
			{ from = center - Vector2.new(0, gap), to = center - Vector2.new(0, gap + size), t0 = 0.75, t1 = 1 },
		}
		if style ~= "t-style" then
			table.insert(ln, { from = center + Vector2.new(0, gap), to = center + Vector2.new(0, gap + size), t0 = 0.25, t1 = 0 })
		end
		for i, l in ipairs(ln) do
			set_line(ch_drawings.lines[i], ch_drawings.outlines[i], l.from, l.to, center)
			used_lines = i
		end

	elseif style == "x" then
		local d, s2 = gap * 0.707, size * 0.707
		local ln = {
			{ from = center + Vector2.new(d, d), to = center + Vector2.new(d + s2, d + s2), t0 = 0.5, t1 = 0.75 },
			{ from = center - Vector2.new(d, d), to = center - Vector2.new(d + s2, d + s2), t0 = 0.25, t1 = 0 },
			{ from = center + Vector2.new(-d, d), to = center + Vector2.new(-d - s2, d + s2), t0 = 0.5, t1 = 0.25 },
			{ from = center - Vector2.new(-d, d), to = center - Vector2.new(-d - s2, d + s2), t0 = 0.75, t1 = 1 },
		}
		for i, l in ipairs(ln) do
			set_line(ch_drawings.lines[i], ch_drawings.outlines[i], l.from, l.to, center)
			used_lines = i
		end

	elseif style == "dot" then
		local r = c.dot_radius + anim_off * 0.5
		ch_drawings.dot.Position = center
		ch_drawings.dot.Radius = r
		ch_drawings.dot.Color = ch_get_color(0.5)
		ch_drawings.dot.Filled = c.dot_filled
		ch_drawings.dot.Transparency = c.opacity
		ch_drawings.dot.NumSides = 30
		ch_drawings.dot.Visible = true
		if c.show_outline then
			ch_drawings.dot_outline.Position = center
			ch_drawings.dot_outline.Radius = r + c.outline_thickness
			ch_drawings.dot_outline.Color = c.outline_color
			ch_drawings.dot_outline.Filled = false
			ch_drawings.dot_outline.Transparency = c.outline_opacity
			ch_drawings.dot_outline.NumSides = 30
			ch_drawings.dot_outline.ZIndex = ch_drawings.dot.ZIndex - 1
			ch_drawings.dot_outline.Visible = true
		end

	elseif style == "circle" then
		local r = c.circle_radius + anim_off
		ch_drawings.circle.Position = center
		ch_drawings.circle.Radius = r
		ch_drawings.circle.Color = ch_get_color(0.5)
		ch_drawings.circle.Filled = false
		ch_drawings.circle.Thickness = thick
		ch_drawings.circle.Transparency = c.opacity
		ch_drawings.circle.NumSides = c.circle_segments
		ch_drawings.circle.Visible = true
		if c.show_outline then
			ch_drawings.circle_outline.Position = center
			ch_drawings.circle_outline.Radius = r + c.outline_thickness
			ch_drawings.circle_outline.Color = c.outline_color
			ch_drawings.circle_outline.Filled = false
			ch_drawings.circle_outline.Thickness = thick + c.outline_thickness * 2
			ch_drawings.circle_outline.Transparency = c.outline_opacity
			ch_drawings.circle_outline.NumSides = c.circle_segments
			ch_drawings.circle_outline.ZIndex = ch_drawings.circle.ZIndex - 1
			ch_drawings.circle_outline.Visible = true
		end

	elseif style == "sniper" then
		local sg = gap * c.sniper_gap_scale
		local ss = size * 1.5
		local ln = {
			{ from = center + Vector2.new(sg, 0), to = center + Vector2.new(sg + ss, 0), t0 = 0.5, t1 = 0.75 },
			{ from = center - Vector2.new(sg, 0), to = center - Vector2.new(sg + ss, 0), t0 = 0.25, t1 = 0 },
			{ from = center - Vector2.new(0, sg), to = center - Vector2.new(0, sg + ss), t0 = 0.75, t1 = 1 },
			{ from = center + Vector2.new(0, sg), to = center + Vector2.new(0, sg + ss), t0 = 0.25, t1 = 0 },
		}
		for i, l in ipairs(ln) do
			set_line(ch_drawings.lines[i], ch_drawings.outlines[i], l.from, l.to, center)
			used_lines = i
		end
		ch_drawings.center_dot.Position = center
		ch_drawings.center_dot.Radius = 1.5
		ch_drawings.center_dot.Color = ch_get_color(0.5)
		ch_drawings.center_dot.Filled = true
		ch_drawings.center_dot.Transparency = c.opacity
		ch_drawings.center_dot.NumSides = 10
		ch_drawings.center_dot.Visible = true

	elseif style == "arrow" then
		local tip = center - Vector2.new(0, gap + size * 0.6)
		local left = center + Vector2.new(-size, -gap)
		local right = center + Vector2.new(size, -gap)
		set_line(ch_drawings.lines[1], ch_drawings.outlines[1], tip, left, center)
		set_line(ch_drawings.lines[2], ch_drawings.outlines[2], tip, right, center)
		used_lines = 2

	elseif style == "triangle" then
		local r2 = size + gap
		local p1 = center + Vector2.new(math.cos(math.rad(-90)) * r2, math.sin(math.rad(-90)) * r2)
		local p2 = center + Vector2.new(math.cos(math.rad(30)) * r2, math.sin(math.rad(30)) * r2)
		local p3 = center + Vector2.new(math.cos(math.rad(150)) * r2, math.sin(math.rad(150)) * r2)
		set_line(ch_drawings.lines[1], ch_drawings.outlines[1], p1, p2, center)
		set_line(ch_drawings.lines[2], ch_drawings.outlines[2], p2, p3, center)
		set_line(ch_drawings.lines[3], ch_drawings.outlines[3], p3, p1, center)
		used_lines = 3

	elseif style == "square" then
		local r2 = size + gap
		ch_drawings.square.Size = Vector2.new(r2 * 2, r2 * 2)
		ch_drawings.square.Position = center - Vector2.new(r2, r2)
		ch_drawings.square.Color = ch_get_color(0.5)
		ch_drawings.square.Filled = false
		ch_drawings.square.Thickness = thick
		ch_drawings.square.Transparency = c.opacity
		ch_drawings.square.Visible = true
		if c.show_outline then
			local ot = c.outline_thickness
			ch_drawings.square_outline.Size = Vector2.new(r2 * 2 + ot * 2, r2 * 2 + ot * 2)
			ch_drawings.square_outline.Position = center - Vector2.new(r2 + ot, r2 + ot)
			ch_drawings.square_outline.Color = c.outline_color
			ch_drawings.square_outline.Filled = false
			ch_drawings.square_outline.Thickness = thick + ot * 2
			ch_drawings.square_outline.Transparency = c.outline_opacity
			ch_drawings.square_outline.ZIndex = ch_drawings.square.ZIndex - 1
			ch_drawings.square_outline.Visible = true
		end
	end

	if c.show_center_dot and style ~= "dot" and style ~= "sniper" then
		local col = c.center_dot_gradient and ch_get_color(0.5) or c.center_dot_color
		ch_drawings.center_dot.Position = center
		ch_drawings.center_dot.Radius = c.center_dot_size
		ch_drawings.center_dot.Color = col
		ch_drawings.center_dot.Filled = true
		ch_drawings.center_dot.Transparency = c.opacity
		ch_drawings.center_dot.NumSides = 20
		ch_drawings.center_dot.Visible = true
		if c.show_outline then
			ch_drawings.center_dot_outline.Position = center
			ch_drawings.center_dot_outline.Radius = c.center_dot_size + c.outline_thickness
			ch_drawings.center_dot_outline.Color = c.outline_color
			ch_drawings.center_dot_outline.Filled = false
			ch_drawings.center_dot_outline.Transparency = c.outline_opacity
			ch_drawings.center_dot_outline.NumSides = 20
			ch_drawings.center_dot_outline.ZIndex = ch_drawings.center_dot.ZIndex - 1
			ch_drawings.center_dot_outline.Visible = true
		end
	end

	for i = used_lines + 1, 8 do
		ch_drawings.lines[i].Visible = false
		ch_drawings.outlines[i].Visible = false
	end
end

local function draw_fov()
	local f = Config.fov
	local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
	if f.follow_mouse and getMousePos then
		local target = getMousePos()
		smoothed_fov_center = smooth_follow(smoothed_fov_center, target, f.follow_lerp)
		center = smoothed_fov_center
	else
		smoothed_fov_center = nil
	end
	local radius = math.max(1, Config.FovSize + fov_anim_offset())
	local rot_off = math.rad(f.shape_rotation) + fov_anim_angle() + math.rad(f.gradient_angle)
	local segments = math.min(f.segments, MAX_FOV_SEG)

	circle.Position = center
	circle.Radius = Config.FovSize
	circle.Transparency = Config.FovTransparency
	circle.Filled = Config.FovFiled
	circle.NumSides = Config.FovSegments
	circle.Color = f.color

	if not Config.ShowFov then
		circle.Visible = false
		hide_fov_extra()
		return
	end

	local use_custom = f.use_gradient or f.dashed or f.shape ~= "circle" or f.double_ring
		or f.markers or f.anim_style ~= "none"

	circle.Visible = not use_custom and Config.ShowFov

	if not use_custom then
		hide_fov_extra()
		return
	end

	circle.Visible = false

	local function shape_point(angle, r)
		local sh = f.shape
		if sh == "circle" then
			return center + Vector2.new(math.cos(angle) * r, math.sin(angle) * r)
		elseif sh == "square" then
			local a = ((angle % (math.pi * 2)) + math.pi * 2) % (math.pi * 2)
			local q = math.floor(a / (math.pi / 2))
			local t2 = (a % (math.pi / 2)) / (math.pi / 2) * 2 - 1
			local nx, ny
			if q == 0 then nx, ny = r, t2 * r
			elseif q == 1 then nx, ny = -t2 * r, r
			elseif q == 2 then nx, ny = -r, -t2 * r
			else nx, ny = t2 * r, -r end
			return center + Vector2.new(nx, ny)
		elseif sh == "diamond" then
			local a = ((angle % (math.pi * 2)) + math.pi * 2) % (math.pi * 2)
			local q = math.floor(a / (math.pi / 2))
			local t2 = (a % (math.pi / 2)) / (math.pi / 2)
			if q == 0 then return center + Vector2.new(r * (1 - t2), r * t2)
			elseif q == 1 then return center + Vector2.new(-r * t2, r * (1 - t2))
			elseif q == 2 then return center + Vector2.new(-r * (1 - t2), -r * t2)
			else return center + Vector2.new(r * t2, -r * (1 - t2)) end
		elseif sh == "hexagon" then
			local sides = 6
			local slice = math.pi * 2 / sides
			local norm_a = ((angle + rot_off) % (math.pi * 2) + math.pi * 2) % (math.pi * 2)
			local q = math.floor(norm_a / slice)
			local t2 = (norm_a - q * slice) / slice
			local a1 = q * slice - rot_off
			local a2 = (q + 1) * slice - rot_off
			local p1 = center + Vector2.new(math.cos(a1) * r, math.sin(a1) * r)
			local p2 = center + Vector2.new(math.cos(a2) * r, math.sin(a2) * r)
			return p1:Lerp(p2, t2)
		end
		return center + Vector2.new(math.cos(angle) * r, math.sin(angle) * r)
	end

	local function get_fov_color(t)
		if f.use_gradient then
			local adjusted = ((t or 0) + (f.gradient_angle / 360)) % 1
			return lerp_color(f.gradient_a, f.gradient_b, adjusted)
		end
		return f.color
	end

	if f.dashed then
		for i = 1, MAX_FOV_SEG do
			fov_lines[i].Visible = false
		end
		local count = math.min(f.dash_count, 32)
		for i = 1, count do
			local sa = rot_off + (i - 1) * (math.pi * 2 / count)
			local ea = sa + (math.pi * 2 / count) * (1 - f.dash_gap)
			fov_dash_lines[i].From = shape_point(sa, radius)
			fov_dash_lines[i].To = shape_point(ea, radius)
			fov_dash_lines[i].Color = get_fov_color((i - 0.5) / count)
			fov_dash_lines[i].Thickness = 2
			fov_dash_lines[i].Transparency = Config.FovTransparency
			fov_dash_lines[i].Visible = true
		end
		for i = count + 1, 32 do
			fov_dash_lines[i].Visible = false
		end
	else
		for i = 1, 32 do
			fov_dash_lines[i].Visible = false
		end
		local prev = shape_point(rot_off, radius)
		for i = 1, segments do
			local angle = rot_off + (i / segments) * math.pi * 2
			local nxt = shape_point(angle, radius)
			fov_lines[i].From = prev
			fov_lines[i].To = nxt
			fov_lines[i].Color = get_fov_color((i - 0.5) / segments)
			fov_lines[i].Thickness = 2
			fov_lines[i].Transparency = Config.FovTransparency
			fov_lines[i].Visible = true
			prev = nxt
		end
		for i = segments + 1, MAX_FOV_SEG do
			fov_lines[i].Visible = false
		end
	end

	if f.double_ring then
		local r2 = radius + f.double_ring_offset
		local prev = shape_point(rot_off, r2)
		for i = 1, segments do
			local angle = rot_off + (i / segments) * math.pi * 2
			local nxt = shape_point(angle, r2)
			fov_double_lines[i].From = prev
			fov_double_lines[i].To = nxt
			fov_double_lines[i].Color = get_fov_color((i - 0.5) / segments)
			fov_double_lines[i].Thickness = 1
			fov_double_lines[i].Transparency = f.double_ring_opacity
			fov_double_lines[i].Visible = true
			prev = nxt
		end
		for i = segments + 1, MAX_FOV_SEG do
			fov_double_lines[i].Visible = false
		end
	else
		for i = 1, MAX_FOV_SEG do
			fov_double_lines[i].Visible = false
		end
	end

	if f.markers then
		local count = math.min(f.marker_count, 32)
		for i = 1, count do
			local angle = rot_off + (i - 1) * (math.pi * 2 / count)
			fov_markers[i].From = shape_point(angle, radius - f.marker_length)
			fov_markers[i].To = shape_point(angle, radius + f.marker_length)
			fov_markers[i].Color = f.marker_color
			fov_markers[i].Thickness = 2
			fov_markers[i].Transparency = f.marker_opacity
			fov_markers[i].Visible = true
		end
		for i = count + 1, 32 do
			fov_markers[i].Visible = false
		end
	else
		for i = 1, 32 do
			fov_markers[i].Visible = false
		end
	end
end

--========================================================--
--  MAIN LOOP
--========================================================--

RunService.RenderStepped:Connect(function(dt)
	anim_t = anim_t + (dt or 0)
	if Config.Enabled then
		MainAimInit()
	end
	draw_crosshair()
	draw_fov()
end)

--========================================================--
--  UI ELEMENTS
--========================================================--

setup:toggle({
	name = "enabled",
	flag = "aim_enabled",
	default = false,
	callback = function(value)
		Config.Enabled = value
		if not value then
			Config.CamLockActive = false
		end
		circle.Visible = Config.Enabled
		VelocityViewer.BillboardGui.Enabled = Config.Enabled
	end
})

setup:keybind({
	name = "cam lock key",
	flag = "aim_keybind",
	default = Enum.KeyCode.Q,
	callback = function(value)
		if typeof(value) == "EnumItem" then
			Config.AimKey = value
			return
		end

		ToggleCamLockInput()
	end
})

setup:toggle({
	name = "sticky target",
	flag = "aim_sticky",
	default = true,
	callback = function(value)
		Config.StickyTarget = value
	end
})

setup:toggle({
	name = "use fov",
	flag = "aim_use_fov",
	default = false,
	callback = function(value)
		Config.UseFov = value
	end
})

setup:slider({
	name = "smoothness",
	flag = "aim_smoothness",
	default = 1,
	min = 1,
	max = 20,
	interval = 1,
	callback = function(value)
		Config.Smoothness = value
	end
})

setup:dropdown({
	name = "curve style",
	flag = "aim_curve_style",
	items = {"linear","smoothstep","easein","easeout","easeinout"},
	default = "linear",
	callback = function(value)
		Config.CurveStyle = value
	end
})

setup:slider({
	name = "curve power",
	flag = "aim_curve_power",
	default = 1,
	min = 0.1,
	max = 5,
	interval = 0.1,
	callback = function(value)
		Config.CurvePower = value
	end
})

setup:slider({
	name = "jitter amount",
	flag = "aim_jitter_amount",
	default = 0,
	min = 0,
	max = 50,
	interval = 0.5,
	callback = function(value)
		Config.JitterAmount = value
	end
})

checks:toggle({
	name = "use prediction",
	flag = "prediction_enabled",
	default = false,
	callback = function(value)
		Config.UsePrediction = value
	end
})

checks:slider({
	name = "prediction amount",
	flag = "prediction_amount",
	default = 0.125,
	min = 0,
	max = 1,
	interval = 0.001,
	callback = function(value)
		Config.Prediction = value
	end
})

checks:toggle({
	name = "team check",
	flag = "aim_team_check",
	default = false,
	callback = function(value)
		Config.TeamCheck = value
	end
})

checks:toggle({
	name = "wall check",
	flag = "aim_wall_check",
	default = false,
	callback = function(value)
		Config.WallCheck = value
	end
})

checks:slider({
	name = "hit chance",
	suffix = "%",
	flag = "prediction_hit_chance",
	default = 100,
	min = 0,
	max = 100,
	callback = function(value)
		Config.HitChance = value
	end
})

fov:toggle({
	name = "visible",
	flag = "fov_visible",
	default = false,
	callback = function(value)
		Config.ShowFov = value
	end
})

fov:slider({
	name = "size",
	flag = "fov_size",
	default = 100,
	min = 20,
	max = 1000,
	interval = 0.01,
	callback = function(value)
		Config.FovSize = value
	end
})

fov:toggle({
	name = "filled",
	flag = "fov_filled",
	default = false,
	callback = function(value)
		Config.FovFiled = value
	end
})

fov:slider({
	name = "transparency",
	flag = "fov_transparency",
	default = 1,
	min = 0,
	max = 1,
	interval = 0.01,
	callback = function(value)
		Config.FovTransparency = value
	end
})

fov:slider({
    name = "segments",
    flag = "fov_segments",
    default = 64,
    min = 4,
    max = 128,
    callback = function(value)
        Config.FovSegments = value
    end
})

aimpart:dropdown({
	name = "part",
	flag = "aimpart_part",
	items = {"Head","Torso","Left Arm","Right Arm","Left Leg","Right Leg","Closest Part"},
	default = "Torso",
	multi = false,
	callback = function(value)
		Config.AimPart = value
	end
})

ESPControls:toggle({
	name = "enabled",
	flag = "esp_enabled",
	default = false,
	callback = function(value)
		ToggleESP(value)
	end
})

ESPControls:toggle({
	name = "team check",
	flag = "esp_team_check",
	default = false,
	callback = function(value)
		Config.ESP.TeamCheck = value
		UpdateESPSettings()
	end
})

ESPControls:toggle({
	name = "boxes",
	flag = "esp_boxes",
	default = false,
	callback = function(value)
		Config.ESP.BoxESP = value
		UpdateESPSettings()
	end
})

ESPControls:dropdown({
	name = "box style",
	flag = "esp_box_style",
	items = {"Corner", "Full", "ThreeD"},
	default = "Corner",
	multi = false,
	callback = function(value)
		Config.ESP.BoxStyle = value
		UpdateESPSettings()
	end
})

ESPControls:slider({
	name = "box thickness",
	flag = "esp_box_thickness",
	default = 1,
	min = 1,
	max = 5,
	callback = function(value)
		Config.ESP.BoxThickness = value
		UpdateESPSettings()
	end
})

ESPControls:toggle({
	name = "box fill",
	flag = "esp_box_fill",
	default = false,
	callback = function(value)
		Config.ESP.BoxFilled = value
		UpdateESPSettings()
	end
})

ESPControls:slider({
	name = "box fill opacity",
	flag = "esp_box_fill_opacity",
	default = 50,
	min = 0,
	max = 100,
	callback = function(value)
		Config.ESP.BoxFillTransparency = value / 100
		UpdateESPSettings()
	end
})

ESPControls:toggle({
	name = "tracers",
	flag = "esp_tracers",
	default = false,
	callback = function(value)
		Config.ESP.TracerESP = value
		UpdateESPSettings()
	end
})

ESPControls:dropdown({
	name = "tracer origin",
	flag = "esp_tracer_origin",
	items = {"Bottom", "Top", "Mouse", "Center"},
	default = "Bottom",
	multi = false,
	callback = function(value)
		Config.ESP.TracerOrigin = value
		UpdateESPSettings()
	end
})

ESPControls:slider({
	name = "tracer thickness",
	flag = "esp_tracer_thickness",
	default = 1,
	min = 1,
	max = 5,
	callback = function(value)
		Config.ESP.TracerThickness = value
		UpdateESPSettings()
	end
})

ESPControls:toggle({
	name = "health",
	flag = "esp_health",
	default = false,
	callback = function(value)
		Config.ESP.HealthESP = value
		UpdateESPSettings()
	end
})

ESPControls:dropdown({
	name = "health style",
	flag = "esp_health_style",
	items = {"Bar", "Text", "Both"},
	default = "Bar",
	multi = false,
	callback = function(value)
		Config.ESP.HealthStyle = value
		UpdateESPSettings()
	end
})

ESPControls:toggle({
	name = "names",
	flag = "esp_names",
	default = false,
	callback = function(value)
		Config.ESP.NameESP = value
		UpdateESPSettings()
	end
})

ESPControls:dropdown({
	name = "name mode",
	flag = "esp_name_mode",
	items = {"DisplayName", "UserName"},
	default = "DisplayName",
	multi = false,
	callback = function(value)
		Config.ESP.NameMode = value
		UpdateESPSettings()
	end
})

ESPControls:toggle({
	name = "skeleton",
	flag = "esp_skeleton",
	default = false,
	callback = function(value)
		Config.ESP.SkeletonESP = value
		UpdateESPSettings()
	end
})

ESPControls:slider({
	name = "skeleton thickness",
	flag = "esp_skeleton_thickness",
	default = 1.5,
	min = 1,
	max = 5,
	interval = 0.1,
	callback = function(value)
		Config.ESP.SkeletonThickness = value
		UpdateESPSettings()
	end
})

ESPControls:toggle({
	name = "chams",
	flag = "esp_chams",
	default = false,
	callback = function(value)
		Config.ESP.ChamsEnabled = value
		UpdateESPSettings()
	end
})

ESPControls:slider({
	name = "chams transparency",
	flag = "esp_chams_transparency",
	default = 0.5,
	min = 0,
	max = 1,
	interval = 0.01,
	callback = function(value)
		Config.ESP.ChamsTransparency = value
		UpdateESPSettings()
	end
})

ESPControls:toggle({
	name = "radar",
	flag = "esp_radar",
	default = false,
	callback = function(value)
		ToggleRadar(value)
	end
})

ESPControls:slider({
	name = "radar size",
	flag = "esp_radar_size",
	default = 200,
	min = 100,
	max = 500,
	callback = function(value)
		Config.ESP.RadarSize = value
		UpdateESPSettings()
	end
})

ESPControls:slider({
	name = "radar range",
	flag = "esp_radar_range",
	default = 500,
	min = 100,
	max = 2000,
	callback = function(value)
		Config.ESP.RadarRange = value
		UpdateESPSettings()
	end
})

ESPControls:slider({
	name = "radar x position",
	flag = "esp_radar_x",
	default = 100,
	min = 0,
	max = 1725,
	callback = function(value)
		Config.ESP.RadarPositionX = value
		UpdateESPSettings()
	end
})

ESPControls:slider({
	name = "radar y position",
	flag = "esp_radar_y",
	default = 100,
	min = 0,
	max = 815,
	callback = function(value)
		Config.ESP.RadarPositionY = value
		UpdateESPSettings()
	end
})

ESPControls:slider({
	name = "radar segments",
	flag = "esp_radar_segments",
	default = 64,
	min = 4,
	max = 128,
	callback = function(value)
		Config.ESP.RadarSegments = value
		UpdateRadar()
		UpdateESPSettings()
	end
})

ESPControls:toggle({
	name = "radar circles",
	flag = "esp_radar_circles",
	default = false,
	callback = function(value)
		Config.ESP.RadarShowCircles = value
		UpdateESPSettings()
	end
})

ESPControls:toggle({
	name = "OOF Arrows",
	flag = "esp_arrows",
	default = false,
	callback = function(value)
		ToggleDirectionalArrows(value)
	end
})

ESPControls:slider({
	name = "arrow distance",
	flag = "esp_arrow_distance",
	default = 100,
	min = 50,
	max = 1000,
	callback = function(value)
		Config.ESP.DirectionalArrowsDistance = value
		UpdateESPSettings()
	end
})

ESPControls:slider({
	name = "arrow size",
	flag = "esp_arrow_size",
	default = 20,
	min = 10,
	max = 100,
	callback = function(value)
		Config.ESP.DirectionalArrowsSize = value
		UpdateESPSettings()
	end
})

ESPControls:slider({
	name = "arrow offset",
	flag = "esp_arrow_offset",
	default = 150,
	min = 50,
	max = 300,
	callback = function(value)
		Config.ESP.DirectionalArrowsOffset = value
		UpdateESPSettings()
	end
})

ESPControls:slider({
	name = "text size",
	flag = "esp_text_size",
	default = 14,
	min = 8,
	max = 32,
	callback = function(value)
		Config.ESP.TextSize = value
		UpdateESPSettings()
	end
})

ESPControls:slider({
	name = "max distance",
	flag = "esp_max_distance",
	default = 1000,
	min = 100,
	max = 99999,
	callback = function(value)
		Config.ESP.MaxDistance = value
		UpdateESPSettings()
	end
})

ESPColors:toggle({
	name = "use gradient",
	flag = "esp_gradient",
	default = false,
	callback = function(value)
		Config.ESP.GradientEnabled = value
		UpdateESPSettings()
	end
})

ESPColors:colorpicker({
	name = "gradient start",
	flag = "esp_gradient_a",
	color = Color3.fromRGB(255, 120, 120),
	callback = function(color)
		Config.ESP.GradientA = color
		UpdateESPSettings()
	end
})

ESPColors:colorpicker({
	name = "gradient end",
	flag = "esp_gradient_b",
	color = Color3.fromRGB(120, 200, 255),
	callback = function(color)
		Config.ESP.GradientB = color
		UpdateESPSettings()
	end
})

ESPColors:slider({
	name = "gradient angle",
	flag = "esp_gradient_angle",
	default = 45,
	min = 0,
	max = 360,
	callback = function(value)
		Config.ESP.GradientAngle = value
		UpdateESPSettings()
	end
})

ESPColors:colorpicker({
	name = "box color",
	flag = "esp_color_box",
	color = Color3.fromRGB(255, 255, 255),
	callback = function(color)
		Config.ESP.Colors.Box = color
		UpdateESPSettings()
	end
})

ESPColors:colorpicker({
	name = "tracer color",
	flag = "esp_color_tracer",
	color = Color3.fromRGB(255, 255, 255),
	callback = function(color)
		Config.ESP.Colors.Tracer = color
		UpdateESPSettings()
	end
})

ESPColors:colorpicker({
	name = "text color",
	flag = "esp_color_text",
	color = Color3.fromRGB(255, 255, 255),
	callback = function(color)
		Config.ESP.Colors.Text = color
		UpdateESPSettings()
	end
})

ESPColors:colorpicker({
	name = "skeleton color",
	flag = "esp_color_skeleton",
	color = Color3.fromRGB(255, 255, 255),
	callback = function(color)
		Config.ESP.Colors.Skeleton = color
		Config.ESP.Colors.SkeletonColor = color
		UpdateESPSettings()
	end
})

ESPColors:colorpicker({
	name = "chams fill",
	flag = "esp_color_chams_fill",
	color = Color3.fromRGB(255, 0, 0),
	callback = function(color)
		Config.ESP.Colors.Chams = color
		Config.ESP.Colors.ChamsFillColor = color
		UpdateESPSettings()
	end
})

ESPColors:colorpicker({
	name = "arrow color",
	flag = "esp_color_arrow",
	color = Color3.fromRGB(255, 255, 255),
	callback = function(color)
		Config.ESP.Colors.Arrow = color
		Config.ESP.Colors.DirectionalArrowsColor = color
		UpdateESPSettings()
	end
})

crosshair_section:toggle({
	name = "enabled", flag = "ch_enabled", default = false,
	callback = function(v)
		Config.crosshair.enabled = v
		UserInputService.MouseIconEnabled = not v
		if not v then hide_ch() end
	end
})

crosshair_section:toggle({
	name = "follow mouse", flag = "ch_follow_mouse", default = false,
	callback = function(v) Config.crosshair.follow_mouse = v end
})

crosshair_section:slider({
	name = "follow lerp", flag = "ch_follow_lerp",
	default = 0, min = 0, max = 5, interval = 0.01,
	callback = function(v) Config.crosshair.follow_lerp = v end
})

crosshair_section:dropdown({
	name = "style", flag = "ch_style",
	items = { "cross", "t-style", "x", "dot", "circle", "sniper", "arrow", "triangle", "square" },
	default = "cross", multi = false,
	callback = function(v) Config.crosshair.style = v end
})

crosshair_section:slider({
	name = "size", flag = "ch_size",
	default = 10, min = 5, max = 50,
	callback = function(v) Config.crosshair.size = v end
})

crosshair_section:slider({
	name = "gap", flag = "ch_gap",
	default = 4, min = 0, max = 30,
	callback = function(v) Config.crosshair.gap = v end
})

crosshair_section:slider({
	name = "thickness", flag = "ch_thickness",
	default = 2, min = 1, max = 10,
	callback = function(v) Config.crosshair.thickness = v end
})

crosshair_section:slider({
	name = "opacity", flag = "ch_opacity",
	default = 100, min = 0, max = 100,
	callback = function(v) Config.crosshair.opacity = v / 100 end
})

crosshair_section:toggle({
	name = "outline", flag = "ch_outline", default = true,
	callback = function(v) Config.crosshair.show_outline = v end
})

crosshair_section:slider({
	name = "outline thickness", flag = "ch_outline_thickness",
	default = 1, min = 1, max = 5,
	callback = function(v) Config.crosshair.outline_thickness = v end
})

crosshair_section:slider({
	name = "outline opacity", flag = "ch_outline_opacity",
	default = 80, min = 0, max = 100,
	callback = function(v) Config.crosshair.outline_opacity = v / 100 end
})

crosshair_section:toggle({
	name = "center dot", flag = "ch_center_dot", default = false,
	callback = function(v) Config.crosshair.show_center_dot = v end
})

crosshair_section:slider({
	name = "center dot size", flag = "ch_center_dot_size",
	default = 3, min = 1, max = 10,
	callback = function(v) Config.crosshair.center_dot_size = v end
})

crosshair_section:toggle({
	name = "dot filled", flag = "ch_dot_filled", default = true,
	callback = function(v) Config.crosshair.dot_filled = v end
})

crosshair_section:slider({
	name = "dot radius", flag = "ch_dot_radius",
	default = 4, min = 1, max = 20,
	callback = function(v) Config.crosshair.dot_radius = v end
})

crosshair_section:slider({
	name = "circle radius", flag = "ch_circle_radius",
	default = 20, min = 5, max = 100,
	callback = function(v) Config.crosshair.circle_radius = v end
})

crosshair_section:slider({
	name = "circle segments", flag = "ch_circle_segs",
	default = 64, min = 4, max = 128,
	callback = function(v) Config.crosshair.circle_segments = v end
})

crosshair_section:slider({
	name = "sniper gap scale", flag = "ch_sniper_gap",
	default = 2, min = 1, max = 8, interval = 0.1,
	callback = function(v) Config.crosshair.sniper_gap_scale = v end
})

crosshair_section:toggle({
	name = "dynamic spread", flag = "ch_dynamic_spread", default = false,
	callback = function(v) Config.crosshair.dynamic_spread = v end
})

crosshair_section:slider({
	name = "spread multiplier", flag = "ch_spread_mult",
	default = 1, min = 1, max = 5, interval = 0.1,
	callback = function(v) Config.crosshair.spread_multiplier = v end
})

crosshair_section:dropdown({
	name = "animation", flag = "ch_anim",
	items = { "none", "pulse", "breathe", "expand", "wave" },
	default = "none", multi = false,
	callback = function(v) Config.crosshair.anim_style = v end
})

crosshair_col_section:toggle({
	name = "use gradient", flag = "ch_gradient", default = false,
	callback = function(v) Config.crosshair.use_gradient = v end
})

crosshair_col_section:colorpicker({
	name = "color", flag = "ch_color",
	color = Color3.fromRGB(255, 255, 255),
	callback = function(v) Config.crosshair.color = v end
})

crosshair_col_section:colorpicker({
	name = "gradient start", flag = "ch_grad_a",
	color = Color3.fromRGB(255, 0, 128),
	callback = function(v) Config.crosshair.gradient_a = v end
})

crosshair_col_section:colorpicker({
	name = "gradient end", flag = "ch_grad_b",
	color = Color3.fromRGB(0, 200, 255),
	callback = function(v) Config.crosshair.gradient_b = v end
})

crosshair_col_section:slider({
	name = "gradient angle", flag = "ch_grad_angle",
	default = 0, min = 0, max = 360,
	callback = function(v) Config.crosshair.gradient_angle = v end
})

crosshair_col_section:colorpicker({
	name = "outline color", flag = "ch_outline_color",
	color = Color3.fromRGB(0, 0, 0),
	callback = function(v) Config.crosshair.outline_color = v end
})

crosshair_col_section:colorpicker({
	name = "center dot color", flag = "ch_center_dot_color",
	color = Color3.fromRGB(255, 255, 255),
	callback = function(v) Config.crosshair.center_dot_color = v end
})

crosshair_col_section:toggle({
	name = "center dot gradient", flag = "ch_center_dot_grad", default = false,
	callback = function(v) Config.crosshair.center_dot_gradient = v end
})

fov_ext_section:dropdown({
	name = "shape", flag = "fov_shape",
	items = { "circle", "square", "diamond", "hexagon" },
	default = "circle", multi = false,
	callback = function(v) Config.fov.shape = v end
})

fov_ext_section:toggle({
	name = "follow mouse", flag = "fov_follow_mouse", default = true,
	callback = function(v) Config.fov.follow_mouse = v end
})

fov_ext_section:slider({
	name = "follow lerp", flag = "fov_follow_lerp",
	default = 0, min = 0, max = 5, interval = 0.01,
	callback = function(v) Config.fov.follow_lerp = v end
})

fov_ext_section:slider({
	name = "shape rotation", flag = "fov_shape_rot",
	default = 0, min = 0, max = 360,
	callback = function(v) Config.fov.shape_rotation = v end
})

fov_ext_section:slider({
	name = "segments", flag = "fov_ext_segs",
	default = 64, min = 8, max = 256,
	callback = function(v) Config.fov.segments = math.min(v, MAX_FOV_SEG) end
})

fov_ext_section:toggle({
	name = "dashed", flag = "fov_dashed", default = false,
	callback = function(v) Config.fov.dashed = v end
})

fov_ext_section:slider({
	name = "dash count", flag = "fov_dash_count",
	default = 16, min = 2, max = 32,
	callback = function(v) Config.fov.dash_count = v end
})

fov_ext_section:slider({
	name = "dash gap", flag = "fov_dash_gap",
	default = 40, min = 0, max = 90,
	callback = function(v) Config.fov.dash_gap = v / 100 end
})

fov_ext_section:toggle({
	name = "double ring", flag = "fov_double_ring", default = false,
	callback = function(v) Config.fov.double_ring = v end
})

fov_ext_section:slider({
	name = "double ring offset", flag = "fov_double_offset",
	default = 10, min = 2, max = 50,
	callback = function(v) Config.fov.double_ring_offset = v end
})

fov_ext_section:slider({
	name = "double ring opacity", flag = "fov_double_opacity",
	default = 40, min = 0, max = 100,
	callback = function(v) Config.fov.double_ring_opacity = v / 100 end
})

fov_ext_section:toggle({
	name = "markers", flag = "fov_markers", default = false,
	callback = function(v) Config.fov.markers = v end
})

fov_ext_section:slider({
	name = "marker count", flag = "fov_marker_count",
	default = 4, min = 2, max = 16,
	callback = function(v) Config.fov.marker_count = v end
})

fov_ext_section:slider({
	name = "marker length", flag = "fov_marker_length",
	default = 6, min = 2, max = 20,
	callback = function(v) Config.fov.marker_length = v end
})

fov_ext_section:dropdown({
	name = "animation", flag = "fov_anim",
	items = { "none", "spin", "pulse", "breathe", "wave" },
	default = "none", multi = false,
	callback = function(v) Config.fov.anim_style = v end
})

fov_ext_section:slider({
	name = "anim speed", flag = "fov_anim_speed",
	default = 10, min = 1, max = 50, interval = 1,
	callback = function(v) Config.fov.anim_speed = v / 10 end
})

fov_ext_section:slider({
	name = "anim intensity", flag = "fov_anim_intensity",
	default = 10, min = 1, max = 50, interval = 1,
	callback = function(v) Config.fov.anim_intensity = v / 10 end
})

fov_col_section:toggle({
	name = "use gradient", flag = "fov_gradient", default = false,
	callback = function(v) Config.fov.use_gradient = v end
})

fov_col_section:colorpicker({
	name = "color", flag = "fov_color",
	color = Color3.fromRGB(255, 255, 255),
	callback = function(v)
		Config.fov.color = v
		circle.Color = v
	end
})

fov_col_section:colorpicker({
	name = "gradient start", flag = "fov_grad_a",
	color = Color3.fromRGB(255, 100, 0),
	callback = function(v) Config.fov.gradient_a = v end
})

fov_col_section:colorpicker({
	name = "gradient end", flag = "fov_grad_b",
	color = Color3.fromRGB(255, 0, 200),
	callback = function(v) Config.fov.gradient_b = v end
})

fov_col_section:slider({
	name = "gradient angle", flag = "fov_grad_angle",
	default = 0, min = 0, max = 360,
	callback = function(v) Config.fov.gradient_angle = v end
})

fov_col_section:colorpicker({
	name = "marker color", flag = "fov_marker_color",
	color = Color3.fromRGB(255, 255, 255),
	callback = function(v) Config.fov.marker_color = v end
})

fov_col_section:slider({
	name = "marker opacity", flag = "fov_marker_opacity",
	default = 100, min = 0, max = 100,
	callback = function(v) Config.fov.marker_opacity = v / 100 end
})

lighting_core_section:toggle({
	name = "lighting",
	flag = "lighting_enabled",
	default = false,
	callback = function(value)
		lightingen = value
		if not value then
			for property, val in pairs(Defaults.Lighting) do
				lighting[property] = val
			end
			restoreeffectdefaults("SunRays")
			restoreeffectdefaults("Bloom")
			restoreeffectdefaults("ColorCorrection")
			restoreeffectdefaults("DepthOfField")
			restoreeffectdefaults("Blur")
			restoreeffectdefaults("Atmosphere")
		end
	end
})

ESPControls:toggle({
	name = "xray",
	flag = "xray_enabled",
	default = false,
	callback = function(value)
		Config.ESP.XrayEnabled = value
		if not value then
			Config.ESP.XrayActive = false
			disablexraymap()
		end
		UpdateESPSettings()
	end
})

ESPControls:keybind({
	name = "xray key",
	flag = "xray_keybind",
	default = Enum.KeyCode.X,
	callback = function(value)
		if typeof(value) == "EnumItem" then
			Config.ESP.XrayKey = value
			return
		end

		if Config.ESP.XrayEnabled then
			Togglexrayinput()
		end
	end
})

sunrays_section:toggle({
	name = "sun rays",
	flag = "sunrays_enabled",
	default = false,
	callback = function(value)
		if not lightingen then
			return
		end
		if value then
			sunrays_effect = ensureeffect("SunRays")
			sunrays_effect.Enabled = true
			sunrays_effect.Intensity = flags["sunrays_intensity"] or (Defaults.Effects.SunRays and Defaults.Effects.SunRays.Intensity) or 0.25
			sunrays_effect.Spread = flags["sunrays_spread"] or (Defaults.Effects.SunRays and Defaults.Effects.SunRays.Spread) or 0.85
		else
			restoreeffectdefaults("SunRays")
		end
	end
})

sunrays_section:slider({
	name = "sun rays intensity",
	flag = "sunrays_intensity",
	default = (Defaults.Effects.SunRays and Defaults.Effects.SunRays.Intensity) or 0.25,
	min = 0,
	max = 1,
	interval = 0.01,
	callback = function(value)
		if lightingen and flags["sunrays_enabled"] then
			sunrays_effect = ensureeffect("SunRays")
			sunrays_effect.Intensity = value
		end
	end
})

sunrays_section:slider({
	name = "sun rays spread",
	flag = "sunrays_spread",
	default = (Defaults.Effects.SunRays and Defaults.Effects.SunRays.Spread) or 0.85,
	min = 0,
	max = 1,
	interval = 0.01,
	callback = function(value)
		if lightingen and flags["sunrays_enabled"] then
			sunrays_effect = ensureeffect("SunRays")
			sunrays_effect.Spread = value
		end
	end
})

bloom_section:toggle({
	name = "bloom",
	flag = "bloom_enabled",
	default = false,
	callback = function(value)
		if not lightingen then
			return
		end
		if value then
			bloom_effect = ensureeffect("Bloom")
			bloom_effect.Enabled = true
			bloom_effect.Intensity = flags["bloom_intensity"] or (Defaults.Effects.Bloom and Defaults.Effects.Bloom.Intensity) or 0.15
			bloom_effect.Size = flags["bloom_size"] or (Defaults.Effects.Bloom and Defaults.Effects.Bloom.Size) or 15
			bloom_effect.Threshold = flags["bloom_threshold"] or (Defaults.Effects.Bloom and Defaults.Effects.Bloom.Threshold) or 0.94
		else
			restoreeffectdefaults("Bloom")
		end
	end
})

bloom_section:slider({
	name = "bloom intensity",
	flag = "bloom_intensity",
	default = (Defaults.Effects.Bloom and Defaults.Effects.Bloom.Intensity) or 0.15,
	min = 0,
	max = 5,
	interval = 0.01,
	callback = function(value)
		if lightingen and flags["bloom_enabled"] then
			bloom_effect = ensureeffect("Bloom")
			bloom_effect.Intensity = value
		end
	end
})

bloom_section:slider({
	name = "bloom size",
	flag = "bloom_size",
	default = (Defaults.Effects.Bloom and Defaults.Effects.Bloom.Size) or 15,
	min = 0,
	max = 100,
	interval = 0.1,
	callback = function(value)
		if lightingen and flags["bloom_enabled"] then
			bloom_effect = ensureeffect("Bloom")
			bloom_effect.Size = value
		end
	end
})

bloom_section:slider({
	name = "bloom threshold",
	flag = "bloom_threshold",
	default = (Defaults.Effects.Bloom and Defaults.Effects.Bloom.Threshold) or 0.94,
	min = 0,
	max = 1,
	interval = 0.01,
	callback = function(value)
		if lightingen and flags["bloom_enabled"] then
			bloom_effect = ensureeffect("Bloom")
			bloom_effect.Threshold = value
		end
	end
})

lighting_core_section:slider({
	name = "brightness",
	flag = "lighting_brightness",
	default = Defaults.Lighting.Brightness,
	min = 0,
	max = 10,
	interval = 0.01,
	callback = function(value)
		if lightingen then
			lighting.Brightness = value
		end
	end
})

lighting_core_section:slider({
	name = "time of day",
	flag = "lighting_time",
	default = Defaults.Lighting.ClockTime,
	min = 0,
	max = 24,
	interval = 0.1,
	callback = function(value)
		if lightingen then
			lighting.ClockTime = value
		end
	end
})

lighting_core_section:colorpicker({
	name = "ambient color",
	flag = "lighting_ambient",
	color = Defaults.Lighting.Ambient,
	callback = function(color)
		if lightingen then
			lighting.Ambient = color
		end
	end
})

lighting_core_section:colorpicker({
	name = "outdoor ambient",
	flag = "lighting_outdoor_ambient",
	color = Defaults.Lighting.OutdoorAmbient,
	callback = function(color)
		if lightingen then
			lighting.OutdoorAmbient = color
		end
	end
})

lighting_core_section:slider({
	name = "exposure",
	flag = "lighting_exposure",
	default = Defaults.Lighting.ExposureCompensation,
	min = -5,
	max = 5,
	interval = 0.01,
	callback = function(value)
		if lightingen then
			lighting.ExposureCompensation = value
		end
	end
})

lighting_core_section:toggle({
	name = "global shadows",
	flag = "lighting_global_shadows",
	default = Defaults.Lighting.GlobalShadows,
	callback = function(value)
		if lightingen then
			lighting.GlobalShadows = value
		end
	end
})

lighting_core_section:dropdown({
	name = "shadow technology",
	flag = "lighting_technology",
	items = LightingTechnologyNames,
	default = Defaults.Lighting.Technology and Defaults.Lighting.Technology.Name or "Compatibility",
	multi = false,
	callback = function(value)
		if lightingen then
			local tech = Enum.Technology[value]
			if tech then
				lighting.Technology = tech
			end
		end
	end
})

lighting_core_section:slider({
	name = "shadow softness",
	flag = "lighting_shadow_softness",
	default = Defaults.Lighting.ShadowSoftness,
	min = 0,
	max = 1,
	interval = 0.01,
	callback = function(value)
		if lightingen then
			lighting.ShadowSoftness = value
		end
	end
})

lighting_core_section:colorpicker({
	name = "color shift top",
	flag = "lighting_color_shift_top",
	color = Defaults.Lighting.ColorShift_Top,
	callback = function(color)
		if lightingen then
			lighting.ColorShift_Top = color
		end
	end
})

lighting_core_section:colorpicker({
	name = "color shift bottom",
	flag = "lighting_color_shift_bottom",
	color = Defaults.Lighting.ColorShift_Bottom,
	callback = function(color)
		if lightingen then
			lighting.ColorShift_Bottom = color
		end
	end
})

lighting_core_section:slider({
	name = "diffuse scale",
	flag = "lighting_diffuse_scale",
	default = Defaults.Lighting.EnvironmentDiffuseScale,
	min = 0,
	max = 1,
	interval = 0.01,
	callback = function(value)
		if lightingen then
			lighting.EnvironmentDiffuseScale = value
		end
	end
})

lighting_core_section:slider({
	name = "specular scale",
	flag = "lighting_specular_scale",
	default = Defaults.Lighting.EnvironmentSpecularScale,
	min = 0,
	max = 1,
	interval = 0.01,
	callback = function(value)
		if lightingen then
			lighting.EnvironmentSpecularScale = value
		end
	end
})

lighting_core_section:slider({
	name = "latitude",
	flag = "lighting_latitude",
	default = Defaults.Lighting.GeographicLatitude,
	min = -90,
	max = 90,
	interval = 0.1,
	callback = function(value)
		if lightingen then
			lighting.GeographicLatitude = value
		end
	end
})

if colorcorrection_section and type(colorcorrection_section.toggle) == "function" then
	colorcorrection_section:toggle({
		name = "color correction",
		flag = "color_correction_enabled",
		default = false,
		callback = function(value)
			if not lightingen then
				return
			end
			if value then
				color_correction = ensureeffect("ColorCorrection")
				color_correction.Enabled = true
				color_correction.Brightness = flags["cc_brightness"] or (Defaults.Effects.ColorCorrection and Defaults.Effects.ColorCorrection.Brightness) or 0
				color_correction.Contrast = flags["cc_contrast"] or (Defaults.Effects.ColorCorrection and Defaults.Effects.ColorCorrection.Contrast) or 0
				color_correction.Saturation = flags["cc_saturation"] or (Defaults.Effects.ColorCorrection and Defaults.Effects.ColorCorrection.Saturation) or 0
				local tintColor = flags["cc_tint_color"] or (Defaults.Effects.ColorCorrection and Defaults.Effects.ColorCorrection.TintColor) or Color3.fromRGB(255, 255, 255)
				color_correction.TintColor = tintColor
			else
				restoreeffectdefaults("ColorCorrection")
			end
		end
	})
end

if colorcorrection_section and type(colorcorrection_section.slider) == "function" then
	colorcorrection_section:slider({
		name = "cc brightness",
		flag = "cc_brightness",
		default = (Defaults.Effects.ColorCorrection and Defaults.Effects.ColorCorrection.Brightness) or 0,
		min = -1,
		max = 1,
		interval = 0.02,
		callback = function(value)
			if lightingen and flags["color_correction_enabled"] then
				color_correction = ensureeffect("ColorCorrection")
				color_correction.Brightness = value
			end
		end
	})

	colorcorrection_section:slider({
		name = "cc contrast",
		flag = "cc_contrast",
		default = (Defaults.Effects.ColorCorrection and Defaults.Effects.ColorCorrection.Contrast) or 0,
		min = -1,
		max = 1,
		interval = 0.02,
		callback = function(value)
			if lightingen and flags["color_correction_enabled"] then
				color_correction = ensureeffect("ColorCorrection")
				color_correction.Contrast = value
			end
		end
	})

	colorcorrection_section:slider({
		name = "cc saturation",
		flag = "cc_saturation",
		default = (Defaults.Effects.ColorCorrection and Defaults.Effects.ColorCorrection.Saturation) or 0,
		min = -1,
		max = 1,
		interval = 0.02,
		callback = function(value)
			if lightingen and flags["color_correction_enabled"] then
				color_correction = ensureeffect("ColorCorrection")
				color_correction.Saturation = value
			end
		end
	})
end

if colorcorrection_section and type(colorcorrection_section.colorpicker) == "function" then
	colorcorrection_section:colorpicker({
		name = "cc tint color",
		flag = "cc_tint_color",
		color = (Defaults.Effects.ColorCorrection and Defaults.Effects.ColorCorrection.TintColor) or Color3.fromRGB(255, 255, 255),
		callback = function(color)
			if lightingen and flags["color_correction_enabled"] then
				color_correction = ensureeffect("ColorCorrection")
				color_correction.TintColor = color
			end
		end
	})
end

dof_section:toggle({
	name = "depth of field",
	flag = "dof_enabled",
	default = false,
	callback = function(value)
		if not lightingen then
			return
		end
		if value then
			dof_effect = ensureeffect("DepthOfField")
			dof_effect.Enabled = true
			dof_effect.FarIntensity = flags["dof_far_intensity"] or (Defaults.Effects.DepthOfField and Defaults.Effects.DepthOfField.FarIntensity) or 0.75
			dof_effect.FocusDistance = flags["dof_focus_distance"] or (Defaults.Effects.DepthOfField and Defaults.Effects.DepthOfField.FocusDistance) or 10
			dof_effect.InFocusRadius = flags["dof_in_focus_radius"] or (Defaults.Effects.DepthOfField and Defaults.Effects.DepthOfField.InFocusRadius) or 20
			dof_effect.NearIntensity = flags["dof_near_intensity"] or (Defaults.Effects.DepthOfField and Defaults.Effects.DepthOfField.NearIntensity) or 0.75
		else
			restoreeffectdefaults("DepthOfField")
		end
	end
})

dof_section:slider({
	name = "dof far intensity",
	flag = "dof_far_intensity",
	default = (Defaults.Effects.DepthOfField and Defaults.Effects.DepthOfField.FarIntensity) or 0.75,
	min = 0,
	max = 1,
	interval = 0.01,
	callback = function(value)
		if lightingen and flags["dof_enabled"] then
			dof_effect = ensureeffect("DepthOfField")
			dof_effect.FarIntensity = value
		end
	end
})

dof_section:slider({
	name = "dof focus distance",
	flag = "dof_focus_distance",
	default = (Defaults.Effects.DepthOfField and Defaults.Effects.DepthOfField.FocusDistance) or 10,
	min = 0.1,
	max = 200,
	interval = 0.1,
	callback = function(value)
		if lightingen and flags["dof_enabled"] then
			dof_effect = ensureeffect("DepthOfField")
			dof_effect.FocusDistance = value
		end
	end
})

dof_section:slider({
	name = "dof in focus radius",
	flag = "dof_in_focus_radius",
	default = (Defaults.Effects.DepthOfField and Defaults.Effects.DepthOfField.InFocusRadius) or 20,
	min = 0.1,
	max = 200,
	interval = 0.1,
	callback = function(value)
		if lightingen and flags["dof_enabled"] then
			dof_effect = ensureeffect("DepthOfField")
			dof_effect.InFocusRadius = value
		end
	end
})

dof_section:slider({
	name = "dof near intensity",
	flag = "dof_near_intensity",
	default = (Defaults.Effects.DepthOfField and Defaults.Effects.DepthOfField.NearIntensity) or 0.75,
	min = 0,
	max = 1,
	interval = 0.01,
	callback = function(value)
		if lightingen and flags["dof_enabled"] then
			dof_effect = ensureeffect("DepthOfField")
			dof_effect.NearIntensity = value
		end
	end
})

blur_section:toggle({
	name = "blur",
	flag = "blur_enabled",
	default = false,
	callback = function(value)
		if not lightingen then
			return
		end
		if value then
			blur_effect = ensureeffect("Blur")
			blur_effect.Enabled = true
			blur_effect.Size = flags["blur_size"] or (Defaults.Effects.Blur and Defaults.Effects.Blur.Size) or 8
		else
			restoreeffectdefaults("Blur")
		end
	end
})

blur_section:slider({
	name = "blur size",
	flag = "blur_size",
	default = (Defaults.Effects.Blur and Defaults.Effects.Blur.Size) or 8,
	min = 0,
	max = 56,
	interval = 0.1,
	callback = function(value)
		if lightingen and flags["blur_enabled"] then
			blur_effect = ensureeffect("Blur")
			blur_effect.Size = value
		end
	end
})

atmosphere_section:toggle({
	name = "atmosphere",
	flag = "atmosphere_enabled",
	default = false,
	callback = function(value)
		if value then
			atmosphere = ensureeffect("Atmosphere")
			local atmColor = flags["atmosphere_color"] or (Defaults.Effects.Atmosphere and Defaults.Effects.Atmosphere.Color) or Color3.fromRGB(255, 255, 255)
			local atmDecay = flags["atmosphere_decay"] or (Defaults.Effects.Atmosphere and Defaults.Effects.Atmosphere.Decay) or Color3.fromRGB(120, 120, 120)
			atmosphere.Color = atmColor
			atmosphere.Decay = atmDecay
			atmosphere.Glare = flags["atmosphere_glare"] or (Defaults.Effects.Atmosphere and Defaults.Effects.Atmosphere.Glare) or 10
			atmosphere.Haze = flags["atmosphere_haze"] or (Defaults.Effects.Atmosphere and Defaults.Effects.Atmosphere.Haze) or 1
			atmosphere.Offset = flags["atmosphere_offset"] or (Defaults.Effects.Atmosphere and Defaults.Effects.Atmosphere.Offset) or 0
			atmosphere.Density = flags["atmosphere_density"] or (Defaults.Effects.Atmosphere and Defaults.Effects.Atmosphere.Density) or 0.35
		else
			restoreeffectdefaults("Atmosphere")
			atmosphere = lighting:FindFirstChildOfClass("Atmosphere")
		end
	end
})

atmosphere_section:colorpicker({
	name = "atmosphere color",
	flag = "atmosphere_color",
	color = (Defaults.Effects.Atmosphere and Defaults.Effects.Atmosphere.Color) or Color3.fromRGB(255, 255, 255),
	callback = function(color)
		if atmosphere then
			atmosphere.Color = color
		end
	end
})

atmosphere_section:colorpicker({
	name = "atmosphere decay",
	flag = "atmosphere_decay",
	color = (Defaults.Effects.Atmosphere and Defaults.Effects.Atmosphere.Decay) or Color3.fromRGB(120, 120, 120),
	callback = function(color)
		if atmosphere then
			atmosphere.Decay = color
		end
	end
})

atmosphere_section:slider({
	name = "atmosphere glare",
	flag = "atmosphere_glare",
	default = (Defaults.Effects.Atmosphere and Defaults.Effects.Atmosphere.Glare) or 10,
	min = 0,
	max = 10,
	interval = 0.1,
	callback = function(value)
		if atmosphere then
			atmosphere.Glare = value
		end
	end
})

atmosphere_section:slider({
	name = "atmosphere haze",
	flag = "atmosphere_haze",
	default = (Defaults.Effects.Atmosphere and Defaults.Effects.Atmosphere.Haze) or 1,
	min = 0,
	max = 10,
	interval = 0.1,
	callback = function(value)
		if atmosphere then
			atmosphere.Haze = value
		end
	end
})

atmosphere_section:slider({
	name = "atmosphere offset",
	flag = "atmosphere_offset",
	default = (Defaults.Effects.Atmosphere and Defaults.Effects.Atmosphere.Offset) or 0,
	min = 0,
	max = 1,
	interval = 0.01,
	callback = function(value)
		if atmosphere then
			atmosphere.Offset = value
		end
	end
})

atmosphere_section:slider({
	name = "atmosphere density",
	flag = "atmosphere_density",
	default = (Defaults.Effects.Atmosphere and Defaults.Effects.Atmosphere.Density) or 0.35,
	min = 0,
	max = 1,
	interval = 0.01,
	callback = function(value)
		if atmosphere then
			atmosphere.Density = value
		end
	end
})

weather_section:toggle({
	name = "weather",
	flag = "weather_enabled",
	default = false,
	callback = function(value)
		WeatherConfig.Enabled = value
		if value then
			StartWeather(WeatherConfig.Type)
		else
			StopWeather()
		end
	end
})

weather_section:dropdown({
	name = "weather type",
	flag = "weather_type",
	items = {"rain", "thunderstorm", "strong thunderstorm", "snow"},
	default = "rain",
	multi = false,
	callback = function(value)
		WeatherConfig.Type = value
		if WeatherConfig.Enabled then
			StartWeather(value)
		end
	end
})

weather_section:colorpicker({
	name = "weather color",
	flag = "weather_color",
	color = Color3.fromRGB(255, 255, 255),
	callback = function(color)
		WeatherConfig.Color = color
		if weatherParticle then
			weatherParticle.Color = ColorSequence.new(color)
		end
	end
})

weather_section:slider({
	name = "weather rate",
	flag = "weather_rate",
	default = 600,
	min = 100,
	max = 2000,
	callback = function(value)
		WeatherConfig.Rate = value
		if weatherParticle then
			weatherParticle.Rate = value
		end
	end
})

weather_section:slider({
	name = "rain volume",
	flag = "weather_rain_volume",
	default = 0.8,
	min = 0,
	max = 1,
	interval = 0.1,
	callback = function(value)
		WeatherConfig.RainVolume = value
		if rainSound then
			rainSound.Volume = WeatherConfig.RainMuted and 0 or value
		end
	end
})

weather_section:slider({
	name = "thunder volume",
	flag = "weather_thunder_volume",
	default = 0.8,
	min = 0,
	max = 1,
	interval = 0.1,
	callback = function(value)
		WeatherConfig.ThunderVolume = value
		if thunderSound then
			thunderSound.Volume = WeatherConfig.ThunderMuted and 0 or value
		end
	end
})

weather_section:toggle({
	name = "mute rain",
	flag = "weather_rain_muted",
	default = false,
	callback = function(value)
		WeatherConfig.RainMuted = value
		if rainSound then
			rainSound.Volume = value and 0 or WeatherConfig.RainVolume
		end
	end
})

weather_section:toggle({
	name = "mute thunder",
	flag = "weather_thunder_muted",
	default = false,
	callback = function(value)
		WeatherConfig.ThunderMuted = value
		if thunderSound then
			thunderSound.Volume = value and 0 or WeatherConfig.ThunderVolume
		end
	end
})

local FogEnabled = false

fogsettings:toggle({
	name = "fog",
	flag = "fog_enabled",
	default = false,
	callback = function(value)
		FogEnabled = value
		if value then
			-- Will be set by the sliders
		else
			lighting.FogStart = Defaults.Lighting.FogStart
			lighting.FogEnd = Defaults.Lighting.FogEnd
			lighting.FogColor = Defaults.Lighting.FogColor
		end
	end
})

fogsettings:colorpicker({
	name = "fog color",
	flag = "fog_color",
	color = Defaults.Lighting.FogColor,
	callback = function(color)
		if FogEnabled then
			lighting.FogColor = color
		end
	end
})

fogsettings:slider({
	name = "fog start",
	flag = "fog_start",
	default = Defaults.Lighting.FogStart,
	min = 0,
	max = 1000,
	callback = function(value)
		if FogEnabled then
			lighting.FogStart = value
		end
	end
})

fogsettings:slider({
	name = "fog end",
	flag = "fog_end",
	default = Defaults.Lighting.FogEnd,
	min = 10,
	max = 10000,
	callback = function(value)
		if FogEnabled then
			lighting.FogEnd = value
		end
	end
})

local cske = false

skysettings:toggle({
	name = "sky",
	flag = "sky_enabled",
	default = false,
	callback = function(value)
		cske = value
		if not value and Defaults.Sky then
			local sky = lighting:FindFirstChildOfClass("Sky")
			if sky then
				for property, val in pairs(Defaults.Sky) do
					sky[property] = val
				end
			end
		end
	end
})

skysettings:slider({
	name = "star count",
	flag = "sky_star_count",
	default = Defaults.Sky.StarCount or 3000,
	min = 0,
	max = 10000,
	callback = function(value)
		if cske then
			local sky = lighting:FindFirstChildOfClass("Sky")
			if sky then
				sky.StarCount = value
			end
		end
	end
})

skysettings:slider({
	name = "sun size",
	flag = "sky_sun_size",
	default = Defaults.Sky.SunAngularSize or 21,
	min = 1,
	max = 100,
	callback = function(value)
		if cske then
			local sky = lighting:FindFirstChildOfClass("Sky")
			if sky then
				sky.SunAngularSize = value
			end
		end
	end
})

skysettings:slider({
	name = "moon size",
	flag = "sky_moon_size",
	default = Defaults.Sky.MoonAngularSize or 11,
	min = 1,
	max = 100,
	callback = function(value)
		if cske then
			local sky = lighting:FindFirstChildOfClass("Sky")
			if sky then
				sky.MoonAngularSize = value
			end
		end
	end
})

local skyboxPresetNames = {}
for presetName, _ in pairs(SkyboxPresets) do
    table.insert(skyboxPresetNames, presetName)
end
table.sort(skyboxPresetNames)

skysettings:dropdown({
    name = "skybox preset",
    flag = "sky_preset",
    items = skyboxPresetNames,
    default = "Default",
    multi = false,
    callback = function(value)
        local sky = lighting:FindFirstChildOfClass("Sky")
        if not sky then
            sky = Instance.new("Sky")
            sky.Parent = lighting
        end
        
        local preset = SkyboxPresets[value]
        if preset then
            sky.SkyboxBk = preset.SkyboxBk
            sky.SkyboxDn = preset.SkyboxDn
            sky.SkyboxFt = preset.SkyboxFt
            sky.SkyboxLf = preset.SkyboxLf
            sky.SkyboxRt = preset.SkyboxRt
            sky.SkyboxUp = preset.SkyboxUp
        end
        cske = true
        if library.flags then
            library.flags["sky_enabled"] = true
        end
    end
})

skysettings:button({
	name = "remove skybox",
	callback = function()
		local sky = lighting:FindFirstChildOfClass("Sky")
		if sky then
			sky:Destroy()
		end
	end
})

function library:config_list_update()
	local dir = self.directory .. "/configs/"
	if not isfolder(dir) then
		makefolder(dir)
	end
	local files = {}
	for _, file in ipairs(listfiles(dir)) do
		if file:sub(-4) == ".cfg" then
			local name = file:sub(#dir + 1, -5)
			table.insert(files, name)
		end
	end
	if self.config_holder and self.config_holder.refresh_options then
		self.config_holder:refresh_options(files)
	end
	if self.autoload_holder and self.autoload_holder.refresh_options then
		self.autoload_holder:refresh_options(files)
	end
end


local configs_section = Configs:section({ name = "configuration system" })
local ui_section = Configs:section({ name = "ui settings", side = "right" })

local dir = library.directory .. "/configs/"
library:config_list_update()
library.config_holder = configs_section:dropdown({
	name = "Configs",
	items = {},
	flag = "config_name_list"
})

configs_section:textbox({
	name = "config name",
	flag = "config_name_text_box",
	default = ""
})

configs_section:button({
	name = "create config",
	callback = function()
		writefile(dir .. flags["config_name_text_box"] .. ".cfg", library:get_config())
		library:config_list_update()
	end
})

configs_section:button({
	name = "delete config",
	callback = function()
		library:panel({
			name = "Are you sure you want to delete " .. flags["config_name_list"] .. " ?",
			options = { "Yes", "No" },
			callback = function(option)
				if option == "Yes" then
					delfile(dir .. flags["config_name_list"] .. ".cfg")
					library:config_list_update()
				end
			end,
		})
	end
})

configs_section:button({
	name = "load config",
	callback = function()
		library:load_config(readfile(dir .. flags["config_name_list"] .. ".cfg"))
	end
})

configs_section:button({
	name = "save config",
	callback = function()
		writefile(dir .. flags["config_name_text_box"] .. ".cfg", library:get_config())
		library:config_list_update()
	end
})

configs_section:button({
	name = "refresh config list",
	callback = function()
		library:config_list_update()
	end
})

configs_section:button({
	name = "unload menu",
	callback = function()
		library:unload()
	end
})

local autoload_dir = library.directory .. "/autoload.cfg"

configs_section:toggle({
	name = "autoload enabled",
	flag = "autoload_enabled",
	default = isfile(autoload_dir),
	callback = function(v)
		if not v and isfile(autoload_dir) then
			delfile(autoload_dir)
		end
	end
})

library.autoload_holder = configs_section:dropdown({
	name = "autoload selection",
	items = {},
	flag = "autoload_config_name",
	callback = function(v)
		if v and flags["autoload_enabled"] then
			writefile(autoload_dir, v)
		end
	end
})

configs_section:button({
	name = "apply autoload",
	callback = function()
		local configName = flags["autoload_config_name"]
		if configName and configName ~= "" then
			writefile(autoload_dir, configName)
		end
	end
})

ui_section:toggle({
	name = "keybind list",
	flag = "ui_keybind_list",
	default = false,
	callback = function(bool)
		window.toggle_list(bool)
	end
})

ui_section:toggle({
	name = "watermark",
	flag = "ui_watermark",
	default = false,
	callback = function(bool)
		window.toggle_watermark(bool)
	end
})

ui_section:keybind({
	name = "ui toggle",
	flag = "ui_toggle_keybind",
	default = Enum.KeyCode.Tab,
	callback = window.set_menu_visibility
})

ui_section:colorpicker({
	name = "accent color",
	flag = "ui_accent",
	color = Color3.fromRGB(255, 143, 229),
	callback = function(color)
		library:update_theme("accent", color)
	end
})

ui_section:button({
	name = "copy job id",
	callback = function()
		setclipboard(game.JobId)
	end
})

ui_section:button({
	name = "copy game id",
	callback = function()
		setclipboard(game.GameId)
	end
})

ui_section:button({
	name = "copy join script",
	callback = function()
		setclipboard(
			'game:GetService("TeleportService"):TeleportToPlaceInstance('
				.. game.PlaceId
				.. ', "'
				.. game.JobId
				.. '", game.Players.LocalPlayer)'
		)
	end
})

ui_section:button({
	name = "rejoin server",
	callback = function()
		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
	end
})

local function SoftUnlockAll()
	local ok, actors = pcall(function()
		return getdeletedactors()
	end)

	if not ok then
		if LocalPlayer and typeof(LocalPlayer.Kick) == "function" then
			LocalPlayer:Kick("your executer doesnt support this shit.")
		end
		return
	end

	for _, actor in next, actors or {} do
		pcall(function()
			run_on_actor(actor, [[
				local r = getrenv().shared.require

				local data = r('PlayerDataUtils')
    
				local weaponFunc = data.ownsWeapon
				if not isfunctionhooked(weaponFunc) then
					hookfunction(weaponFunc, newcclosure(function() return true end))
				end

				for i,v in next, getgc(true) do
					if typeof(v) == 'table' and rawget(v, 'ownsBlueprint') then
						local ownsBlueprint = v.ownsBlueprint
						if not isfunctionhooked(ownsBlueprint) then
							hookfunction(ownsBlueprint, newcclosure(function() return true end))
						end
					end
				end

				local ownsAttachment = data.ownsAttachment
				if not isfunctionhooked(ownsAttachment) then
					hookfunction(ownsAttachment, newcclosure(function() return true end))
				end

				local camodatabase = require(game:GetService("ReplicatedStorage"):WaitForChild("Content"):WaitForChild("ProductionContent"):WaitForChild("CamoDatabase"))
				if not isfunctionhooked(data.getInventoryData) then
					local oldinventory
					oldinventory = hookfunction(data.getInventoryData, newcclosure(function(pd)
						local inv = oldinventory(pd)
						for skinname, skindata in next, camodatabase do
							local casename = skindata.Case
							if casename then
								if not inv[casename] then
									inv[casename] = { Cases = { Count = 0, Assigned = {} }, Keys = 0, Skins = {} }
								end
								if not inv[casename].Skins[skinname] then
									inv[casename].Skins[skinname] = {}
								end
								inv[casename].Skins[skinname].ALL = true
							end
						end
						return inv
					end))
				end

				for i,v in next, getgc() do
					if typeof(v) == 'function' and islclosure(v) and debug.info(v, 'n'):find("updateWeaponList") then
						v()
					end
				end
			]])
		end)
	end
end

Misc:button({
	name = "soft unlock all",
	callback = SoftUnlockAll
})

library:config_list_update()

Aim.open_tab()



















