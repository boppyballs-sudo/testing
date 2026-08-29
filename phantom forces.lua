--========================================================--
--  LOAD LIBRARY
--========================================================--

library = loadstring(game:HttpGet("https://raw.githubusercontent.com/i77lhm/vaderpaste/refs/heads/main/library.lua"))()
local flags = library.flags


--========================================================--
--  WINDOW SETUP
--========================================================--
local targetDropdown
local targetDropdownReference = nil

local MarketPlaceService = game:GetService("MarketplaceService")
local GameName = MarketPlaceService:GetProductInfoAsync(game.PlaceId).Name

local window = library:window({
	name = "ERME - " .. tostring(GameName),
	size = UDim2.fromOffset(550, 650),
})


library:update_theme("accent", Color3.fromRGB(255, 143, 229))

game.Players.LocalPlayer:WaitForChild("Information",100)


--========================================================--
--  CONFIGURATION
--========================================================--
local ReplicatedStorage = game:GetService('ReplicatedStorage')

local Config = {
	AimKey = Enum.KeyCode.Q,
	AimPart = "UpperTorso",
	AutoPrediction = false,
	CFrame_Speed = false,
	CFrame_Speed_Amount = 1,
	CurrentStompList = {},
	DesyncV2Enabled = false,
	Desyncenabled = false,
	DropDownUpdate = nil,
	Enabled = false,
	FovFiled = false,
	FovSize = 100,
	closestpoint = false,
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
	Prediction = 0.125,
	Resolver = false,
	ShowFov = false,
	FovSegments = 64,
	Skin = 'Galaxy',
	StompEffectClient = 'Mario',
	StompEffectServer = 'goku',
	Stomp_Aura = false,
	StickyTarget = true,
	Smoothing = 0.5,
	TargetList = {},
	UseFov = false,
	UseHitChance = true,
	WallCheck = false,
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
		BoxOutline = true,
		BoxFilled = false,
		BoxFillTransparency = 0.5,
		BoxThickness = 1,

		TracerESP = false,
		TracerOrigin = "Bottom",
		TracerStyle = "Line",
		TracerThickness = 1,

		HealthESP = false,
		HealthStyle = "Bar",
		HealthBarSide = "Left",
		HealthTextSuffix = "HP",

		NameESP = false,
		NameMode = "DisplayName",

		ShowDistance = true,
		DistanceUnit = "studs",

		TextSize = 14,
		TextFont = 2,

		MaxDistance = 1000,
		RefreshRate = 1/144,

		ChamsEnabled = false,
		ChamsOutlineColor = Color3.fromRGB(255, 255, 255),
		ChamsFillColor = Color3.fromRGB(255, 0, 0),
		ChamsOccludedColor = Color3.fromRGB(150, 0, 0),
		ChamsTransparency = 0.5,
		ChamsOutlineTransparency = 0,
		ChamsOutlineThickness = 0.1,

		SkeletonESP = false,
		SkeletonColor = Color3.fromRGB(255, 255, 255),
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
		RadarAllyColor = Color3.fromRGB(25, 255, 25),
		RadarDotSize = 4,
		RadarRange = 500,
		RadarShowCrosshair = true,
		RadarShowCircles = true,
		RadarSegments = 64,

		DirectionalArrowsEnabled = false,
		DirectionalArrowsDistance = 100,
		DirectionalArrowsSize = 20,
		DirectionalArrowsOffset = 150,
		DirectionalArrowsColor = Color3.fromRGB(255, 255, 255),
		DirectionalArrowsAllyColor = Color3.fromRGB(255, 255, 255),
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
			ChamsOutline = Color3.fromRGB(255, 255, 255),
			Arrow = Color3.fromRGB(255, 255, 255),
			Distance = Color3.fromRGB(200, 200, 200),
			HealthLow = Color3.fromRGB(255, 0, 0),
			HealthMedium = Color3.fromRGB(255, 255, 0),
			HealthHigh = Color3.fromRGB(0, 255, 0)
		}
	}
}






--========================================================--
--  SERVICES & VARIABLES
--========================================================--

Players = game:GetService("Players")
UserInputService = game:GetService("UserInputService")
RunService = game:GetService("RunService")

Camera = workspace.CurrentCamera
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

VisibleDot = false
HideMousePos = false
lastValidTargetPlayer = nil

aim_type = "silent aim"
use_pred = false

desyncRunning = false
desyncConnections = {}
desyncLoop = nil

anti_aim_connection,anii_aim_vector = false,Vector3.new(0,0,0)
Property, Wait = sethiddenproperty, wait
Radian, Random, Ceil = math.rad, math.random, math.ceil
Angle = CFrame.Angles
Vector = Vector3.new
Service = game.GetService

Run = Service(game, 'RunService')
statPing = Service(game, 'Stats').PerformanceStats.Ping

ReplicatedStorage = game:GetService('ReplicatedStorage')

FLYING,QEfly,iyflyspeed,vehicleflyspeed=false,false,5,5

Shop = workspace.Ignored.Shop
Armor = Shop:FindFirstChild("Armor")
Guns = Shop:FindFirstChild("Guns")
Other = Shop:FindFirstChild("Others")

Guns_Table = {}
Armor_Table = {}
Other_Table = {}

buy_type = 'gun'
gun_buy = ''
armor_buy = ''
other_buy = ''

lastSafePosition = nil
lastPositionUpdate = 0
isTeleporting = false

lastHitChanceRoll = 100
hitChanceHistory = {}

KillTestVarible = false
Noclipping = nil
currentTargetIndex = 1 
killLoopActive = false
originalEnabled = false
originalStickyTarget = false
originalUseFov = false
wasDesyncEnabled = false
loopKillConnection = nil
deathHandling = false
targetWasAlive = {}
isReloading = false
reloadStartTime = 0
lastForceFieldWarning = 0
isShooting = false
isStomping = false
originalTargetList = {}
hasOriginalTargetGrabbed = false
currentGrabbedTarget = nil
originalTargetEntry = nil
killGrabberState = false
savedTargetState = {}

resolverEnabled = false
successfulPredictions = {}
resolverRunning = false

if Guns then
	Guns_Table = {
		"[AA12] - $4000",
		"[AUG] - $1550",
		"[Deagle] - $750",
		"[Drum Glock] - $275",
		"[DrumGun] - $1350",
		"[Famas] - $3800",
		"[Flamethrower] - $7550",
		"[Flintlock] - $1421",
		"[Glock] - $275",
		"[Golden AK47] - $5250",
		"[Grenade Launcher] - $10000",
		"[Homing Launcher] - $12000",
		"[LMG] - $4250",
		"[R8] - $2800",
		"[RPG] - $6000",
		"[Ray Gun] - $9500",
		"[SMG] - $700",
		"[SSHG] - $7999",
		"[ScarH] - $2850",
		"[Silencer] - $550",
		"[Sniper] - $2000",
		"[XM8] - $5550"
	}
end

if Armor then
	Armor_Table = {
		"[High Armor] - $550"
	}
end

if Other then
	Other_Table = {
		"[Adrenaline-Shot] - $280",
		"[Bat] - $275",
		"[Chicken] - $5",
		"[Chips] - $5",
		"[Da Milk] - $8",
		"[Donut] - $5",
		"[Flashbang] - $550",
		"[Grenade] - $550",
		"[HotDog] - $8",
		"[Katana] - $1200",
		"[Lemonade] - $3",
		"[Lettuce] - $7",
		"[Lolipop] - $1",
		"[Meat] - $8",
		"[Mask] - $25",
		"[Molotov] - $850",
		"[Parachute] - $1950",
		"[Smoke Grenade] - $650",
		"[Starblox Latte] - $5",
		"[StopSign] - $300",
		"[Taco] - $4"
	}
end


local function GetLockedPlayerName()
	if lockedTarget and locked then
		local player = Players:GetPlayerFromCharacter(lockedTarget)
		if player then
			return player.Name
		end
	end
	return "None"
end

--========================================================--
--  CLICKDETECTOR FIXER
--========================================================--

local function clickdt()
	local Shop = workspace.Ignored.Shop
	local cts = {"Guns", "Armor", "Others"}
	for _, ctname in ipairs(cts) do
		local cts = Shop:FindFirstChild(ctname)
		if cts then
			for _, item in ipairs(cts:GetChildren()) do
				local clickDetector = item:FindFirstChildOfClass("ClickDetector")
				if not clickDetector then
					for _, child in ipairs(item:GetDescendants()) do
						if child:IsA("ClickDetector") then
							clickDetector = child
							break
						end
					end
				end
				if clickDetector then
					pcall(function()
						clickDetector.MaxActivationDistance = math.huge
					end)
				end
			end
		end
	end
end

clickdt() -- make it run whenever tf cus why not

--========================================================--
--  MOUSE METATABLE HOOK
--========================================================--

local is_setting_mouse_pos = false
local mouse_position

local mouse = LocalPlayer:GetMouse()
local grmt = getrawmetatable(mouse)
setreadonly(grmt, false)

local old_mouse_index = grmt.__index
grmt.__index = function(self, key)
	if key == "Hit" and is_setting_mouse_pos and aim_type == "silent aim" then
		return mouse_position
	end
	return old_mouse_index(self, key)
end

--========================================================--
--  NAMECALL HOOK
--========================================================--

local mt = getrawmetatable(game)
setreadonly(mt, false)
local old_namecall = mt.__namecall

mt.__namecall = function(self, ...)
	local method = getnamecallmethod()

	if tostring(self) == "MainRemote" and method == "FireServer" then
		local args = {...}
		if args[1] == "MousePosDHM" and HideMousePos then
			return old_namecall(self, "MousePosDHM", LocalPlayer.Character.Head.Position)
		end
	end
	return old_namecall(self, ...)
end

--========================================================--
--  Silent hit chance
--========================================================--

local function ShouldHit()
	if not Config.UseHitChance then
		return true
	end

	local chance = Config.HitChance

	local roll = math.random(1, 100)
	lastHitChanceRoll = roll

	table.insert(hitChanceHistory, {
		chance = chance,
		roll = roll,
		hit = roll <= chance,
		time = tick()
	})

	if #hitChanceHistory > 10 then
		table.remove(hitChanceHistory, 1)
	end

	return roll <= chance
end

local function GetHitChanceStats()
	if #hitChanceHistory == 0 then
		return "No shots fired"
	end

	local hits = 0
	local total = #hitChanceHistory

	for _, entry in ipairs(hitChanceHistory) do
		if entry.hit then
			hits = hits + 1
		end
	end

	local percentage = math.floor((hits / total) * 100)
	return string.format("%d/%d (%.0f%%)", hits, total, percentage)
end

--========================================================--
--  DESYNC
--========================================================--
local function AntiAim()
	local abc = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
	game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = anii_aim_vector
	RunService.RenderStepped:Wait()
	game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = abc
end

local function getroot()
	local character = game:GetService('Players').LocalPlayer.Character
	if character then
		Root = character:FindFirstChild('HumanoidRootPart')
	end
	return Root
end

local function Sleep()
	local root = getroot()
	if root then
		return Property(root, 'NetworkIsSleeping', true)
	end
end

local function ToggleDesyncV2(enabled)
	setfflag("NextGenReplicatorEnabledWrite4", enabled)
	return enabled
end

local function InitRandom()
	local root = getroot()
	if not root then return end

	local rootVel = root.Velocity
	local rootAng = Random(-180, 180)
	local rootOffset do
		local X = Random(-Config.velMax, Config.velMax)
		local Y = Random(0, Config.velMax)
		local Z = Random(-Config.velMax, Config.velMax)
		rootOffset = Vector(X, -Y, Z)
	end

	root.CFrame *= Angle(0, Radian(rootAng), 0)
	root.Velocity = rootOffset

	Run.RenderStepped:Wait()

	root.CFrame *= Angle(0, Radian(-rootAng), 0)
	root.Velocity = rootVel
end

local function InitVoid()
	local root = getroot()
	if not root then return end

	local rootVel = root.Velocity

	root.Velocity = Vector(0, math.huge, 0)

	local bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.Velocity = Vector(0, math.huge, 0)
	bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
	bodyVelocity.P = 100000
	bodyVelocity.Parent = root

	Run.RenderStepped:Wait()


	if bodyVelocity then
		bodyVelocity:Destroy()
	end


	root.Velocity = rootVel
end

local function StartDesync()
	if desyncRunning then return end


	desyncRunning = true
	getroot()

	if not Root then
		desyncRunning = false
		return
	end


	if Config.DesyncV2Enabled then
		ToggleDesyncV2(true)
	end

	local runRen, runBeat = Run.RenderStepped, Run.Heartbeat
	local runRenWait, runRenCon = runRen.Wait, runRen.Connect
	local runBeatCon = runBeat.Connect
	local Ping = statPing.GetValue


	local initFunc
	if Config.Mode == "void" then
		initFunc = InitVoid
	elseif Config.Mode == "desync v2" then
		initFunc = function()
			if Config.DesyncV2Enabled then
				ToggleDesyncV2(true)
			end
			InitRandom()
		end
	else
		initFunc = InitRandom
	end


	local beatConnection = runBeatCon(runBeat, initFunc)
	table.insert(desyncConnections, beatConnection)


	desyncLoop = task.spawn(function()
		while desyncRunning and Config.Desyncenabled do

			local chokeClient = runBeatCon(runBeat, Sleep)
			local chokeServer = runRenCon(runRen, Sleep)
			Wait(Config.timeChoke)


			chokeClient:Disconnect()
			chokeServer:Disconnect()
			Wait(Config.timeRelease)
		end
	end)
end

local function StopDesync()
	desyncRunning = false

	if Config.DesyncV2Enabled then
		ToggleDesyncV2(false)
	end


	for _, conn in ipairs(desyncConnections) do
		if conn then
			pcall(function() conn:Disconnect() end)
		end
	end
	table.clear(desyncConnections)


	if desyncLoop then
		task.cancel(desyncLoop)
		desyncLoop = nil
	end
end

local function RespawnPlayer()

	repeat wait() until LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

	LocalPlayer.Character:WaitForChild('Humanoid'):UnequipTools()
end

--========================================================--
--  Teleport buy function
--==========================================================


local function tpbuy(itemType, itemName, delay)
	if isTeleporting then 
		return false 
	end

	isTeleporting = true


	local wasDesyncRunning = desyncRunning
	local wasLoopkillActive = killLoopActive

	if desyncRunning then
		StopDesync()
	end

	if killLoopActive then
		killLoopActive = false
		KillTestVarible = false
	end

	local player = game:GetService("Players").LocalPlayer
	local character = player.Character
	if not character then
		return false
	end

	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then
		return false
	end

	local bodyEffects = character:FindFirstChild("BodyEffects")
	if bodyEffects then
		local ko = bodyEffects:FindFirstChild("K.O")
		if ko and ko.Value then
			lastSafePosition = nil
			return false
		end
	end

	local targetType = itemType or buy_type
	local targetName = itemName or ""

	if targetName == "" then
		if targetType == 'gun' then
			targetName = gun_buy
		elseif targetType == 'armor' then
			targetName = armor_buy
		elseif targetType == 'other' then
			targetName = other_buy
		end
	end

	local cleanItemName = targetName
	if cleanItemName then
		cleanItemName = string.gsub(cleanItemName, "%s%-%s%$%d+$", "")
	end

	if targetName == "" or targetName == nil then
		warn("No item selected for purchase")
		return false
	end

	local itemFolder
	if targetType == 'gun' then
		itemFolder = Guns
	elseif targetType == 'armor' then
		itemFolder = Armor
	elseif targetType == 'other' then
		itemFolder = Other
	else
		warn("Invalid item type: " .. tostring(targetType))
		return false
	end

	if not itemFolder then
		warn("Item folder not found: " .. targetType)
		return false
	end

	local item = itemFolder:FindFirstChild(targetName)
	if not item then
		warn("Item not found: " .. targetName .. " in " .. targetType)
		return false
	end

	local clickDetector = item:FindFirstChildOfClass("ClickDetector")
	local head = item:FindFirstChild("Head") or item:FindFirstChild("Part")

	if not clickDetector or not head then
		warn("Item missing ClickDetector or Head/Part: " .. targetName)
		return false
	end

	delay = delay or 0.05

	local currentTime = tick()
	local distanceToItem = (humanoidRootPart.Position - head.Position).Magnitude

	if distanceToItem > 50 and (currentTime - lastPositionUpdate > 1) then
		lastSafePosition = humanoidRootPart.CFrame
		lastPositionUpdate = currentTime
	end

	if targetType == 'armor' then
		local playerStats = player:FindFirstChild("DataFolder") or player:FindFirstChild("Information")
		local armorValue = 0

		if playerStats then
			if playerStats:FindFirstChild("Armor") and playerStats.Armor:IsA("NumberValue") then
				armorValue = playerStats.Armor.Value
			elseif playerStats:FindFirstChild("Information") and playerStats.Information:FindFirstChild("Armor") then
				armorValue = playerStats.Information.Armor.Value
			elseif player:FindFirstChild("Armor") then
				armorValue = player.Armor.Value
			end
		end

		local maxArmor = 100
		if armorValue >= maxArmor then
			return true
		end
	end

	isTeleporting = true
	local wasDesyncRunning = desyncRunning
	if desyncRunning then
		StopDesync()
	end

	local originalCFrame = humanoidRootPart.CFrame

	local OFFSET = CFrame.new(0, 0, 0)


	local function checkItemInBackpack()
		if targetType == 'armor' then
			local playerStats = player:FindFirstChild("DataFolder") or player:FindFirstChild("Information")
			local newArmorValue = 0

			if playerStats then
				if playerStats:FindFirstChild("Armor") and playerStats.Armor:IsA("NumberValue") then
					newArmorValue = playerStats.Armor.Value
				elseif playerStats:FindFirstChild("Information") and playerStats.Information:FindFirstChild("Armor") then
					newArmorValue = playerStats.Information.Armor.Value
				elseif player:FindFirstChild("Armor") then
					newArmorValue = player.Armor.Value
				end
			end

			return newArmorValue > 0
		else

			local backpack = player.Backpack
			local characterItems = character:GetChildren()


			if backpack:FindFirstChild(cleanItemName) then
				return true
			end

			for _, item in ipairs(characterItems) do
				if item.Name == cleanItemName then
					return true
				end
			end

			return false
		end
	end


	humanoidRootPart.CFrame = head.CFrame * OFFSET

	task.wait(delay)

	local success = false
	while not success do
		pcall(function()
			fireclickdetector(clickDetector)
		end)
		if checkItemInBackpack() then
			success = true
			break
		end
		wait()
	end

	task.wait(0.02)

	humanoidRootPart.CFrame = originalCFrame

	if wasDesyncRunning and Config and Config.Desyncenabled then
		StartDesync()
	end

	isTeleporting = false

	if targetType == 'armor' then
		local playerStats = player:FindFirstFirstChild("DataFolder") or player:FindFirstChild("Information")
		local newArmorValue = 0

		if playerStats then
			if playerStats:FindFirstChild("Armor") and playerStats.Armor:IsA("NumberValue") then
				newArmorValue = playerStats.Armor.Value
			elseif playerStats:FindFirstChild("Information") and playerStats.Information:FindFirstChild("Armor") then
				newArmorValue = playerStats.Information.Armor.Value
			elseif player:FindFirstChild("Armor") then
				newArmorValue = player.Armor.Value
			end
		end

		return newArmorValue > 0
	end
	if wasDesyncRunning and Config and Config.Desyncenabled then
		StartDesync()
	end

	if wasLoopkillActive then
		killLoopActive = true
		KillTestVarible = true


	end

	isTeleporting = false
	return true
end

--========================================================--
--  Buy helpers
--==========================================================
local function buyGun(gunName, delay)
	gun_buy = gunName
	buy_type = 'gun'
	return tpbuy('gun', gunName, delay)
end

local function buyArmor(armorName, delay)
	armor_buy = armorName
	buy_type = 'armor'
	return tpbuy('armor', armorName, delay)
end

local function buyOther(itemName, delay)
	other_buy = itemName
	buy_type = 'other'
	return tpbuy('other', itemName, delay)
end

--========================================================--
--  ORBIT LOGIC
--==========================================================

local function startOrbit()
	if Config.orbitLoop then
		Config.orbitLoop:Disconnect()
		Config.orbitLoop = nil
	end

	Config.orbitLoop = game:GetService("RunService").Heartbeat:Connect(function()
		if not Config.OrbitEnabled then return end

		local targetChar = lockedTarget
		if not targetChar or not targetChar.Parent then return end

		local rootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
		if not rootPart or not targetRoot then return end

		orbitAngle = orbitAngle + (Config.OrbitSpeed * 0.05)
		if orbitAngle > (math.pi * 2) then
			orbitAngle = orbitAngle - (math.pi * 2)
		end

		local x = math.cos(orbitAngle) * Config.OrbitDistance
		local z = math.sin(orbitAngle) * Config.OrbitDistance

		local newPosition = Vector3.new(
			targetRoot.Position.X + x,
			targetRoot.Position.Y + Config.OrbitHeight,
			targetRoot.Position.Z + z
		)

		rootPart.CFrame = CFrame.new(newPosition, targetRoot.Position)
	end)
end

local function toggleOrbit()
	Config.OrbitEnabled = not Config.OrbitEnabled

	if Config.OrbitEnabled then
		if lockedTarget and lockedTarget.Parent then
			startOrbit()
		else
			Config.OrbitEnabled = false
		end
	else
		if Config.orbitLoop then
			Config.orbitLoop:Disconnect()
			Config.orbitLoop = nil
		end
	end
end
--========================================================--
--  autoarmor logic shit
--========================================================--

local function autoarmor()

	if isTeleporting then 
		return false 
	end

	local armorPad = game:GetService("Workspace").Ignored.Shop.Armor["[High Armor] - $550"]

	if not armorPad then
		return false
	end

	local clickDetector = armorPad:FindFirstChildOfClass("ClickDetector")
	if not clickDetector then
		return false
	end

	local player = game:GetService("Players").LocalPlayer
	local character = player.Character
	if not character then
		return false
	end

	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then
		return false
	end

	local armorPart = armorPad:FindFirstChild("Head") or armorPad:FindFirstChild("Part")
	if not armorPart then
		return false
	end

	local bodyEffects = character:FindFirstChild("BodyEffects")
	if bodyEffects then
		local ko = bodyEffects:FindFirstChild("K.O")
		if ko and ko.Value then
			lastSafePosition = nil
			return false
		end
	end

	local distanceToArmor = (humanoidRootPart.Position - armorPart.Position).Magnitude
	local currentTime = tick()

	if distanceToArmor > 50 and (currentTime - lastPositionUpdate > 1) then
		lastSafePosition = humanoidRootPart.CFrame
		lastPositionUpdate = currentTime
	end

	local playerStats = player:FindFirstChild("DataFolder") or player:FindFirstChild("Information")
	local armorValue = 0

	if playerStats then
		if playerStats:FindFirstChild("Armor") and playerStats.Armor:IsA("NumberValue") then
			armorValue = playerStats.Armor.Value
		elseif playerStats:FindFirstChild("Information") and playerStats.Information:FindFirstChild("Armor") then
			armorValue = playerStats.Information.Armor.Value
		elseif player:FindFirstChild("Armor") then
			armorValue = player.Armor.Value
		end
	end

	local maxArmor = 100
	if armorValue >= maxArmor then
		return true
	end

	if armorValue < Config.autoarmor_min then
		isTeleporting = true
		local wasDesyncRunning = desyncRunning
		if desyncRunning then
			StopDesync()
		end


		local currentPosition = humanoidRootPart.CFrame


		humanoidRootPart.CFrame = CFrame.new(armorPart.Position + Vector3.new(0, 2, 0))

		task.wait(0.05)

		if fireclickdetector then
			fireclickdetector(clickDetector)
		end

		task.wait(0.02)


		humanoidRootPart.CFrame = currentPosition

		if wasDesyncRunning and Config.Desyncenabled then
			StartDesync()
		end

		isTeleporting = false


		local newArmorValue = 0
		if playerStats then
			if playerStats:FindFirstChild("Armor") and playerStats.Armor:IsA("NumberValue") then
				newArmorValue = playerStats.Armor.Value
			elseif playerStats:FindFirstChild("Information") and playerStats.Information:FindFirstChild("Armor") then
				newArmorValue = playerStats.Information.Armor.Value
			end
		end

		return newArmorValue > armorValue
	end

	return false
end

local function toggleAutoArmor()
	if Config.autoarmor then
		Config.autoarmor = false
		if Config.autoarmor_loop then
			Config.autoarmor_loop:Disconnect()
			Config.autoarmor_loop = nil
		end
	else
		Config.autoarmor = true
		Config.autoarmor_loop = game:GetService("RunService").Heartbeat:Connect(function()
			if Config.autoarmor then
				autoarmor()
			end
		end)
	end
end

local function GetSkinFolder(weaponName, skinName)
	for _, folder in ipairs(SkinDump:GetChildren()) do
		local parts = string.split(folder.Name, "/")
		if parts[1] == weaponName and parts[2] == skinName then
			return folder
		end
	end
	return nil
end

local function GiveSkin(tool,skin)
	local gun = LocalPlayer.Backpack:FindFirstChild(tool) or LocalPlayer.Character:FindFirstChild(tool)
	if not gun then return end

	local skinFolder = GetSkinFolder(tool, skin)
	if skinFolder then
		for _,obj in pairs(gun.Handle:GetChildren()) do
			obj:Destroy()
		end
		for _,obj in pairs(skinFolder.Handle:GetChildren()) do
			obj:Clone().Parent = gun.Handle
		end
		gun.Handle:SetAttribute("SkinName",skin)
		if gun.Handle:FindFirstChild("Skin") then
			local Skin = gun.Handle:FindFirstChild("Skin")

			if Skin:FindFirstChild('Weld') then
				Skin.Weld.Part0 = gun.Handle
			end
		end
		for i,sound in pairs(gun:GetDescendants()) do
			if sound:IsA("Sound") then
				if sound:FindFirstChild("Temp") then
					sound.SoundId = sound.Temp.Value
				end
			end
		end
	end
end

LocalPlayer.CharacterAdded:Connect(function()
	lastSafePosition = nil
	isTeleporting = false

	if Config.auto_apply_skin then
		wait(1)
		GiveSkin("[Revolver]",Skin)
		GiveSkin("[Double Barrel SG]",Skin)
	end
end)


--========================================================--
--  ESP FUNCTIONS
--========================================================--

_G.ESPDrawings = {}
_G.ESPHighlights = {}
_G.ESPRadarComponents = {}
_G.ESPDirectionalArrows = {}
_G.ESPSettings = Config.ESP

local function InitRadar()
	_G.ESPRadarComponents = {
		Background = Drawing.new("Circle"),
		Border = Drawing.new("Circle"),
		LocalPlayerDot = Drawing.new("Circle"),
		CrosshairH = Drawing.new("Line"),
		CrosshairV = Drawing.new("Line"),
		Circles = {},
		PlayerDots = {}
	}

	local radar = _G.ESPRadarComponents

	radar.Background.Visible = false
	radar.Background.Filled = true
	radar.Background.Color = Config.ESP.RadarBackgroundColor
	radar.Background.Transparency = Config.ESP.RadarBackgroundTransparency
	radar.Background.NumSides = Config.ESP.RadarSegments
	radar.Background.Radius = Config.ESP.RadarSize / 2

	radar.Border.Visible = false
	radar.Border.Filled = false
	radar.Border.Color = Config.ESP.RadarBorderColor
	radar.Border.Thickness = Config.ESP.RadarBorderThickness
	radar.Border.Transparency = 1
	radar.Border.NumSides = Config.ESP.RadarSegments
	radar.Border.Radius = Config.ESP.RadarSize / 2

	radar.LocalPlayerDot.Visible = false
	radar.LocalPlayerDot.Filled = true
	radar.LocalPlayerDot.Color = Config.ESP.RadarLocalPlayerColor
	radar.LocalPlayerDot.Radius = Config.ESP.RadarDotSize
	radar.LocalPlayerDot.NumSides = 30
	radar.LocalPlayerDot.Transparency = 1

	radar.CrosshairH.Visible = false
	radar.CrosshairH.Color = Color3.fromRGB(100, 100, 100)
	radar.CrosshairH.Thickness = 1
	radar.CrosshairH.Transparency = 0.5

	radar.CrosshairV.Visible = false
	radar.CrosshairV.Color = Color3.fromRGB(100, 100, 100)
	radar.CrosshairV.Thickness = 1
	radar.CrosshairV.Transparency = 0.5

	for i = 1, 3 do
		local circle = Drawing.new("Circle")
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

	local localChar = LocalPlayer.Character
	if not localChar then return end

	local localRoot = localChar:FindFirstChild("HumanoidRootPart")
	if not localRoot then return end

	local localPos = localRoot.Position
	local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

	for _, player in ipairs(Players:GetPlayers()) do
		if player == LocalPlayer then continue end

		if not _G.ESPDirectionalArrows[player] then
			CreateArrow(player)
		end

		local arrow = _G.ESPDirectionalArrows[player]
		local character = player.Character

		if not character then
			arrow.Triangle.Visible = false
			arrow.DistanceText.Visible = false
			continue
		end

		local rootPart = character:FindFirstChild("HumanoidRootPart")
		if not rootPart then
			arrow.Triangle.Visible = false
			arrow.DistanceText.Visible = false
			continue
		end

		local humanoid = character:FindFirstChild("Humanoid")
		if not humanoid or humanoid.Health <= 0 then
			arrow.Triangle.Visible = false
			arrow.DistanceText.Visible = false
			continue
		end

		local distance = (rootPart.Position - localPos).Magnitude

		if distance > Config.ESP.DirectionalArrowsDistance then
			arrow.Triangle.Visible = false
			arrow.DistanceText.Visible = false
			continue
		end

		local targetScreenPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)

		if onScreen and targetScreenPos.Z > 0 then
			local targetPos2D = Vector2.new(targetScreenPos.X, targetScreenPos.Y)
			local distanceFromCenter = (targetPos2D - screenCenter).Magnitude

			if distanceFromCenter < Config.ESP.DirectionalArrowsOffset then
				arrow.Triangle.Visible = false
				arrow.DistanceText.Visible = false
				continue
			end
		end

		local directionTo3D = (rootPart.Position - localPos)

		local cameraLook = Camera.CFrame.LookVector
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
	_G.ESPRadarComponents.Background.Radius = radarRadius   -- force redraw
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

	local localChar = LocalPlayer.Character
	if not localChar then return end
	local localRoot = localChar:FindFirstChild("HumanoidRootPart")
	if not localRoot then return end

	local localPos = localRoot.Position

	if not _G.ESPRadarComponents.PlayerDots then
		_G.ESPRadarComponents.PlayerDots = {}
	end

	for _, player in ipairs(Players:GetPlayers()) do
		if player == LocalPlayer then continue end

		local character = player.Character
		if not character then
			if _G.ESPRadarComponents.PlayerDots[player] then
				_G.ESPRadarComponents.PlayerDots[player].Visible = false
			end
			continue
		end

		local rootPart = character:FindFirstChild("HumanoidRootPart")
		if not rootPart then
			if _G.ESPRadarComponents.PlayerDots[player] then
				_G.ESPRadarComponents.PlayerDots[player].Visible = false
			end
			continue
		end

		local humanoid = character:FindFirstChild("Humanoid")
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

		dot.Position = radarCenter + Vector2.new(radarXPos, radarYPos)

		dot.Color = Config.ESP.RadarEnemyColor
		dot.Radius = Config.ESP.RadarDotSize * Config.ESP.RadarScale
		dot.Visible = true
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
		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= LocalPlayer then
				if not _G.ESPDrawings[player] then
					CreateESP(player)
				end
			end
		end
	else
		for _, player in ipairs(Players:GetPlayers()) do
			if _G.ESPDrawings[player] then
				local esp = _G.ESPDrawings[player]
				if esp.Box then
					for _, line in pairs(esp.Box) do
						line.Visible = false
					end
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

	for _, line in pairs(_G.ESPDrawings[player].Box) do
		line.Visible = false
		line.Color = Config.ESP.Colors.Box
		line.Thickness = Config.ESP.BoxThickness
	end
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

function RemoveESP(player)
	if _G.ESPDrawings[player] then
		if _G.ESPDrawings[player].Box then
			for _, line in pairs(_G.ESPDrawings[player].Box) do
				pcall(function() line:Remove() end)
			end
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

function UpdateBoxes(player, esp, character, humanoid, rootPart)

	local head = character:FindFirstChild("Head")
	if not head then
		if esp.Box then
			for _, line in pairs(esp.Box) do
				line.Visible = false
			end
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
		return nil, nil 
	end

	local screenHeight = math.abs(headPos.Y - rootPos.Y)
	local screenWidth = screenHeight * 0.5

	local boxPosition = Vector2.new(
		headPos.X - screenWidth / 2,
		headPos.Y
	)
	local boxSize = Vector2.new(screenWidth, screenHeight)
	if Config.ESP.BoxESP and esp.Box then
		if Config.ESP.BoxStyle == "Corner" then
			local cornerSize = screenWidth * 0.25

			esp.Box.TopLeft.From = boxPosition
			esp.Box.TopLeft.To = boxPosition + Vector2.new(0, cornerSize)
			esp.Box.TopLeft.Color = Config.ESP.Colors.Box
			esp.Box.TopLeft.Thickness = Config.ESP.BoxThickness
			esp.Box.TopLeft.Visible = true

			esp.Box.TopRight.From = boxPosition + Vector2.new(boxSize.X, 0)
			esp.Box.TopRight.To = boxPosition + Vector2.new(boxSize.X, cornerSize)
			esp.Box.TopRight.Color = Config.ESP.Colors.Box
			esp.Box.TopRight.Thickness = Config.ESP.BoxThickness
			esp.Box.TopRight.Visible = true

			esp.Box.BottomLeft.From = boxPosition + Vector2.new(0, boxSize.Y)
			esp.Box.BottomLeft.To = boxPosition + Vector2.new(0, boxSize.Y - cornerSize)
			esp.Box.BottomLeft.Color = Config.ESP.Colors.Box
			esp.Box.BottomLeft.Thickness = Config.ESP.BoxThickness
			esp.Box.BottomLeft.Visible = true

			esp.Box.BottomRight.From = boxPosition + Vector2.new(boxSize.X, boxSize.Y)
			esp.Box.BottomRight.To = boxPosition + Vector2.new(boxSize.X, boxSize.Y - cornerSize)
			esp.Box.BottomRight.Color = Config.ESP.Colors.Box
			esp.Box.BottomRight.Thickness = Config.ESP.BoxThickness
			esp.Box.BottomRight.Visible = true

			esp.Box.Top.From = boxPosition
			esp.Box.Top.To = boxPosition + Vector2.new(cornerSize, 0)
			esp.Box.Top.Color = Config.ESP.Colors.Box
			esp.Box.Top.Thickness = Config.ESP.BoxThickness
			esp.Box.Top.Visible = true

			esp.Box.Bottom.From = boxPosition + Vector2.new(0, boxSize.Y)
			esp.Box.Bottom.To = boxPosition + Vector2.new(cornerSize, boxSize.Y)
			esp.Box.Bottom.Color = Config.ESP.Colors.Box
			esp.Box.Bottom.Thickness = Config.ESP.BoxThickness
			esp.Box.Bottom.Visible = true

			esp.Box.Left.From = boxPosition + Vector2.new(boxSize.X - cornerSize, 0)
			esp.Box.Left.To = boxPosition + Vector2.new(boxSize.X, 0)
			esp.Box.Left.Color = Config.ESP.Colors.Box
			esp.Box.Left.Thickness = Config.ESP.BoxThickness
			esp.Box.Left.Visible = true

			esp.Box.Right.From = boxPosition + Vector2.new(boxSize.X - cornerSize, boxSize.Y)
			esp.Box.Right.To = boxPosition + Vector2.new(boxSize.X, boxSize.Y)
			esp.Box.Right.Color = Config.ESP.Colors.Box
			esp.Box.Right.Thickness = Config.ESP.BoxThickness
			esp.Box.Right.Visible = true
		else
			for _, line in pairs(esp.Box) do
				line.Visible = false
			end
			esp.Box.Left.From = boxPosition
			esp.Box.Left.To = boxPosition + Vector2.new(0, boxSize.Y)
			esp.Box.Left.Color = Config.ESP.Colors.Box
			esp.Box.Left.Thickness = Config.ESP.BoxThickness
			esp.Box.Left.Visible = true

			esp.Box.Right.From = boxPosition + Vector2.new(boxSize.X, 0)
			esp.Box.Right.To = boxPosition + Vector2.new(boxSize.X, boxSize.Y)
			esp.Box.Right.Color = Config.ESP.Colors.Box
			esp.Box.Right.Thickness = Config.ESP.BoxThickness
			esp.Box.Right.Visible = true

			esp.Box.Top.From = boxPosition
			esp.Box.Top.To = boxPosition + Vector2.new(boxSize.X, 0)
			esp.Box.Top.Color = Config.ESP.Colors.Box
			esp.Box.Top.Thickness = Config.ESP.BoxThickness
			esp.Box.Top.Visible = true

			esp.Box.Bottom.From = boxPosition + Vector2.new(0, boxSize.Y)
			esp.Box.Bottom.To = boxPosition + Vector2.new(boxSize.X, boxSize.Y)
			esp.Box.Bottom.Color = Config.ESP.Colors.Box
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
	esp.Tracer.From = tracerOrigin
	esp.Tracer.To = Vector2.new(pos.X, pos.Y)
	esp.Tracer.Color = Config.ESP.Colors.Tracer
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
	esp.HealthBar.Fill.Color = GetHealthColor(health, maxHealth)
	esp.HealthBar.Fill.Filled = true
	esp.HealthBar.Fill.Visible = true

	if Config.ESP.HealthStyle == "Both" or Config.ESP.HealthStyle == "Text" then
		esp.HealthBar.Text.Text = math.floor(health) .. (Config.ESP.HealthTextSuffix or "")
		esp.HealthBar.Text.Position = Vector2.new(barPos.X - 15, barPos.Y + barHeight / 2)
		esp.HealthBar.Text.Color = Color3.fromRGB(255, 255, 255)
		esp.HealthBar.Text.Size = Config.ESP.TextSize
		esp.HealthBar.Text.Visible = true
	else
		esp.HealthBar.Text.Visible = false
	end
end

function UpdateNames(player, esp, character, rootPart, boxPosition, boxSize)
	if not esp.Info then return end

	if Config.ESP.NameESP and esp.Info.Name then
		local nameText = Config.ESP.NameMode == "UserName" and player.Name or player.DisplayName
		esp.Info.Name.Text = nameText
		esp.Info.Name.Position = Vector2.new(
			boxPosition.X + boxSize.X / 2,
			boxPosition.Y - 18
		)
		esp.Info.Name.Color = Config.ESP.Colors.Text
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
		if esp.Skeleton then
			for _, line in pairs(esp.Skeleton) do
				line.Visible = false
			end
		end
		return
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

	if not (bones.Head and bones.UpperTorso) then
		for _, line in pairs(esp.Skeleton) do
			line.Visible = false
		end
		return
	end

	local connections = {
		{bones.Head, bones.UpperTorso},
		{bones.UpperTorso, bones.LowerTorso},
		{bones.UpperTorso, bones.LeftUpperArm},
		{bones.LeftUpperArm, bones.LeftLowerArm},
		{bones.LeftLowerArm, bones.LeftHand},
		{bones.UpperTorso, bones.RightUpperArm},
		{bones.RightUpperArm, bones.RightLowerArm},
		{bones.RightLowerArm, bones.RightHand},
		{bones.LowerTorso, bones.LeftUpperLeg},
		{bones.LeftUpperLeg, bones.LeftLowerLeg},
		{bones.LeftLowerLeg, bones.LeftFoot},
		{bones.LowerTorso, bones.RightUpperLeg},
		{bones.RightUpperLeg, bones.RightLowerLeg},
		{bones.RightLowerLeg, bones.RightFoot}
	}

	for i, connection in ipairs(connections) do
		local from, to = connection[1], connection[2]
		local line = esp.Skeleton[i]

		if from and to and line then
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

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health <= 0 then
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
	local quadsForPlayer = esp.ChamsQuads

	local partNames = {
		"Head", "UpperTorso", "LowerTorso", 
		"LeftUpperArm", "LeftLowerArm", "LeftHand",
		"RightUpperArm", "RightLowerArm", "RightHand", 
		"LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
		"RightUpperLeg", "RightLowerLeg", "RightFoot"
	}
	local rootPart = character:FindFirstChild("HumanoidRootPart")
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

	for _, partName in ipairs(partNames) do
		local part = character:FindFirstChild(partName)
		if part and part:IsA("BasePart") then
			if not quadsForPlayer[partName] then
				local quads = {}
				for i = 1, 6 do
					quads[i] = NewQuad(fillColor)
				end
				quadsForPlayer[partName] = quads
			end
			local quads = quadsForPlayer[partName]
			local size = part.Size
			local cf = part.CFrame
			local corners = {
				cf * CFrame.new(-size.X/2,  size.Y/2, -size.Z/2),
				cf * CFrame.new(-size.X/2,  size.Y/2,  size.Z/2),
				cf * CFrame.new( size.X/2,  size.Y/2,  size.Z/2),
				cf * CFrame.new( size.X/2,  size.Y/2, -size.Z/2),
				cf * CFrame.new(-size.X/2, -size.Y/2, -size.Z/2),
				cf * CFrame.new(-size.X/2, -size.Y/2,  size.Z/2),
				cf * CFrame.new( size.X/2, -size.Y/2,  size.Z/2),
				cf * CFrame.new( size.X/2, -size.Y/2, -size.Z/2)
			}
			local points = {}
			local anyCornerVisible = false
			local allCornersBehind = true

			for i, corner in ipairs(corners) do
				local cornerPosition = nil
				if typeof(corner) == "CFrame" then
					cornerPosition = corner.Position
				elseif typeof(corner) == "Vector3" then
					cornerPosition = corner
				end

				if not cornerPosition then
					allCornersBehind = true
					anyCornerVisible = false
					break
				end

				local pos, onScreen = Camera:WorldToViewportPoint(cornerPosition)
				points[i] = Vector2.new(pos.X, pos.Y)
				if pos.Z > 0 then
					allCornersBehind = false
					if pos.X >= 0 and pos.X <= ViewportSize.X 
						and pos.Y >= 0 and pos.Y <= ViewportSize.Y then
						anyCornerVisible = true
					end
				end
			end
			local faces = {
				{1,2,3,4},
				{5,6,7,8},
				{1,2,6,5}, 
				{2,3,7,6},
				{3,4,8,7}, 
				{4,1,5,8} 
			}
			if allCornersBehind or not anyCornerVisible then
				for i = 1, 6 do
					quads[i].Visible = false
				end
			else
				for i, face in ipairs(faces) do
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
		else
			if quadsForPlayer[partName] then
				for _, quad in ipairs(quadsForPlayer[partName]) do
					quad.Visible = false
				end
			end
		end
	end
	for partName, quads in pairs(quadsForPlayer) do
		if not character:FindFirstChild(partName) then
			for _, quad in ipairs(quads) do
				quad.Visible = false
			end
		end
	end
end

function UpdateESP(player)
	if not Config.ESP.Enabled then
		if _G.ESPDrawings[player] then
			local esp = _G.ESPDrawings[player]
			if esp.Box then for _, line in pairs(esp.Box) do line.Visible = false end end
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
				for partName, quads in pairs(esp.ChamsQuads) do
					for _, quad in ipairs(quads) do
						quad.Visible = false
					end
				end
			end
		end
		if _G.ESPHighlights[player] then
			_G.ESPHighlights[player].Enabled = false
		end
		return
	end

	local esp = _G.ESPDrawings[player]
	if not esp then return end

	local function HideAllESP()
		if esp.Box then for _, line in pairs(esp.Box) do line.Visible = false end end
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
			for partName, quads in pairs(esp.ChamsQuads) do
				for _, quad in ipairs(quads) do
					quad.Visible = false
				end
			end
		end
	end

	if player == LocalPlayer or not player.Character then 
		HideAllESP()
		return 
	end

	local character = player.Character
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local rootPart = character:FindFirstChild("HumanoidRootPart")

	if not (humanoid and rootPart and humanoid.Health > 0) then 
		HideAllESP()
		return 
	end

	local distance = (rootPart.Position - Camera.CFrame.Position).Magnitude

	if distance > Config.ESP.MaxDistance then 
		HideAllESP()
		return 
	end

	local boxPosition, boxSize = UpdateBoxes(player, esp, character, humanoid, rootPart)

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
		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= LocalPlayer then
				if not _G.ESPDrawings[player] then
					CreateESP(player)
				end
				UpdateESP(player)
			end
		end
		lastESPUpdate = currentTime
	elseif not Config.ESP.Enabled then
		for _, player in ipairs(Players:GetPlayers()) do
			if _G.ESPDrawings[player] then
				local esp = _G.ESPDrawings[player]
				if esp.Box then for _, line in pairs(esp.Box) do line.Visible = false end end
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
					for partName, quads in pairs(esp.ChamsQuads) do
						for _, quad in ipairs(quads) do
							quad.Visible = false
						end
					end
				end
			end
			if _G.ESPHighlights[player] then
				_G.ESPHighlights[player].Enabled = false
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
	if flags["targeting_aim_view_all"] then
		UpdateAimView()
	end
end)

Players.PlayerRemoving:Connect(function(player)
	if flags["targeting_aim_view_all"] then
		UpdateAimView()
	end
end)

Players.PlayerAdded:Connect(function(player)
	if player ~= LocalPlayer then
		CreateESP(player)
	end
end)

Players.PlayerRemoving:Connect(RemoveESP)

for _, player in ipairs(Players:GetPlayers()) do
	if player ~= LocalPlayer then
		CreateESP(player)
	end
end

--========================================================--
--  DRAWING + VELOCITY VIEWER
--========================================================--

local circle = Drawing.new("Circle")
circle.Radius = 50
circle.Color = Color3.fromRGB(255, 255, 255)
circle.Filled = false
circle.Thickness = 1
circle.Visible = false


--========================================================--
--  UTILITY FUNCTIONS
--========================================================--

local function PlayAudio(method,id)
	LocalPlayer.Character:FindFirstChild('Humanoid'):UnequipTools()
	local boombox = LocalPlayer.Backpack:FindFirstChild('[Boombox]')
	if boombox.Grip ~= CFrame.new(0.600000024, 200, 0, 0.00426799059, -0, -0.999991, 0, 1, -0, 0.999991, 0, 0.00426799059) then
		boombox.Grip = CFrame.new(0.600000024, 200, 0, 0.00426799059, -0, -0.999991, 0, 1, -0, 0.999991, 0, 0.00426799059)
	end
	boombox.Parent = LocalPlayer.Character
	ReplicatedStorage:FindFirstChild('MainRemote'):FireServer(method,id) wait(0.03)
	boombox.Parent = LocalPlayer.Backpack
end

local function CalculateAbsolutePosition(player)
	local root = player.Character[Config.AimPart]
	local p1, t1 = root.Position, tick()
	task.wait()
	local p2, t2 = root.Position, tick()
	return (p2 - p1) / (t2 - t1)
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


local function isInsideCircle(point, center, radius)
	if not point or not center then return false end
	return (point - center).Magnitude <= radius
end

local function getScreenPos(character)
	if not character then return nil end
	local root = character:FindFirstChild("HumanoidRootPart")
	if not root then return nil end
	local pos, onScreen = Camera:WorldToViewportPoint(root.Position)
	if not onScreen then return nil end
	return Vector2.new(pos.X, pos.Y)
end

local function isValidTarget(character)
	if not character or not character.Parent then
		return false
	end


	if Config.KnockCheck then
		local bodyEffects = character:FindFirstChild("BodyEffects")
		if bodyEffects then
			local ko = bodyEffects:FindFirstChild("K.O")
			if ko and ko.Value then
				return false
			end
		end
	end


	if Config.WallCheck then
		local origin = Camera.CFrame.Position
		local targetPos = character.HumanoidRootPart.Position
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

local function getClosestPlayerInFov()
	local mousePos = getMousePos()
	local closestPlayer = nil
	local closestDistance = math.huge

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character then
			if isValidTarget(player.Character) then
				local screenPos = getScreenPos(player.Character)
				if screenPos then
					local distance = (screenPos - mousePos).Magnitude

					if Config.UseFov then
						if isInsideCircle(screenPos, mousePos, circle.Radius) then
							if distance < closestDistance then
								closestDistance = distance
								closestPlayer = player.Character
							end
						end
					else
						-- Closest to cursor even without FOV check
						if distance < closestDistance then
							closestDistance = distance
							closestPlayer = player.Character
						end
					end
				end
			end
		end
	end

	return closestPlayer
end

local function getClosestPointOnPart(part)
	
	if Config.closestpoint ~= true then
		return part.Position
	end
	
	if not part then return nil end
	local mousePos = getMousePos()
	local ray = Camera:ViewportPointToRay(mousePos.X, mousePos.Y)

	local rayOrigin = ray.Origin
	local rayDirection = ray.Direction.Unit
	local partPosition = part.Position
	local relativePos = partPosition - rayOrigin
	local projection = relativePos:Dot(rayDirection)
	local closestPointOnRay = rayOrigin + (rayDirection * projection)

	local localPoint = part.CFrame:PointToObjectSpace(closestPointOnRay)
	local size = part.Size / 2
	local clampedPoint = Vector3.new(
		math.clamp(localPoint.X, -size.X, size.X),
		math.clamp(localPoint.Y, -size.Y, size.Y),
		math.clamp(localPoint.Z, -size.Z, size.Z)
	)

	return part.CFrame * clampedPoint
end

local function getClosestPartToMouse(character, useFov)
	if not character then return nil end

	local closestPart = nil
	local closestDistance = math.huge
	local mousePos = getMousePos()


	local partsToCheck = {
		"Head",
		"UpperTorso", 
		"LowerTorso",
		"HumanoidRootPart",
		"LeftHand",
		"RightHand",
		"LeftFoot",
		"RightFoot",
		"LeftUpperArm",
		"LeftLowerArm",
		"RightUpperArm",
		"RightLowerArm",
		"LeftUpperLeg",
		"LeftLowerLeg",
		"RightUpperLeg",
		"RightLowerLeg",
		"Left Arm",
		"Right Arm",
		"Left Leg",
		"Right Leg",
		"Torso"
	}

	for _, partName in ipairs(partsToCheck) do
		local part = character:FindFirstChild(partName)
		if part then
			local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
			if onScreen then
				local screenPos2D = Vector2.new(screenPos.X, screenPos.Y)
				local distance = (screenPos2D - mousePos).Magnitude


				if useFov then
					if isInsideCircle(screenPos2D, mousePos, circle.Radius) and distance < closestDistance then
						closestDistance = distance
						closestPart = part
					end
				else

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

local resolverPredictionDisplay = Drawing.new("Text")
resolverPredictionDisplay.Size = 16
resolverPredictionDisplay.Center = true
resolverPredictionDisplay.Outline = true
resolverPredictionDisplay.Color = Color3.fromRGB(255, 255, 255)
resolverPredictionDisplay.Visible = false
resolverPredictionDisplay.Font = 2

local resolverPredictions = {}
local lockedResolverPredictions = {}
local lastTargetHealth = {}
local resolverHitTimers = {}
local lastShotTime = {} 
local currentResolverTarget = nil
local hitKeepTime = 1.0
local predictionIncrement = 0.01

local function RecordShot(targetPlayer)
	if targetPlayer then
		local playerName = targetPlayer.Name
		lastShotTime[playerName] = tick()
	end
end

local function ApplyResolverPrediction(targetCharacter, gunPosition, targetPosition)
	if not resolverEnabled or not targetCharacter then
		return targetPosition
	end

	local targetPlayer = Players:GetPlayerFromCharacter(targetCharacter)
	if not targetPlayer then
		return targetPosition
	end

	local velocity = CalculateVelocity(targetCharacter)
	local resolverPred = GetResolverPrediction(targetPlayer, targetCharacter)

	return targetPosition + (velocity * resolverPred)
end


local function GetCurrentPredictionOffset(playerName)
	if playerName and IsHitStillValid(playerName) and successfulPredictions[playerName] then
		return successfulPredictions[playerName]
	end

	return currentPredictionOffset or 0
end


local function IsHitStillValid(playerName)
	if not playerName or not resolverHitTimers[playerName] then
		return false
	end

	local currentTime = tick()
	local timeSinceHit = currentTime - resolverHitTimers[playerName]
	return timeSinceHit <= hitKeepTime
end


local function CalculateVelocity(targetCharacter)
	if not targetCharacter or not targetCharacter:FindFirstChild("HumanoidRootPart") then
		return Vector3.new(0, 0, 0)
	end

	local rootPart = targetCharacter.HumanoidRootPart
	local playerName = targetCharacter.Parent.Name

	if not lastPositions[playerName] then
		lastPositions[playerName] = {
			positions = {},
			times = {},
			count = 0
		}
	end

	local playerHistory = lastPositions[playerName]
	local currentTime = tick()
	local currentPosition = rootPart.Position

	table.insert(playerHistory.positions, currentPosition)
	table.insert(playerHistory.times, currentTime)
	playerHistory.count = playerHistory.count + 1

	if #playerHistory.positions > 10 then
		table.remove(playerHistory.positions, 1)
		table.remove(playerHistory.times, 1)
		playerHistory.count = 10
	end

	if #playerHistory.positions < 2 then
		return Vector3.new(0, 0, 0)
	end

	local totalVelocity = Vector3.new(0, 0, 0)
	local totalTime = 0

	for i = 2, #playerHistory.positions do
		local deltaPos = playerHistory.positions[i] - playerHistory.positions[i-1]
		local deltaTime = playerHistory.times[i] - playerHistory.times[i-1]

		if deltaTime > 0 then
			totalVelocity = totalVelocity + (deltaPos / deltaTime)
			totalTime = totalTime + 1
		end
	end

	if totalTime > 0 then
		return totalVelocity / totalTime
	end

	return Vector3.new(0, 0, 0)
end

local function CheckHealthChange(targetPlayer, targetCharacter)
	if not targetPlayer or not targetCharacter then
		return false
	end

	local humanoid = targetCharacter:FindFirstChild("Humanoid")
	if not humanoid then
		return false
	end

	local playerName = targetPlayer.Name
	local currentHealth = humanoid.Health


	if not lastTargetHealth[playerName] then
		lastTargetHealth[playerName] = currentHealth
		return false
	end

	if not lastShotTime[playerName] then
		lastTargetHealth[playerName] = currentHealth
		return false
	end

	local timeSinceShot = tick() - lastShotTime[playerName]

	if timeSinceShot > 0.5 then
		lastTargetHealth[playerName] = currentHealth
		return false
	end

	if currentHealth < lastTargetHealth[playerName] then
		local healthLost = lastTargetHealth[playerName] - currentHealth

		lockedResolverPredictions[playerName] = resolverPredictions[playerName] or Config.Prediction
		resolverHitTimers[playerName] = tick()
		lastTargetHealth[playerName] = currentHealth
		lastShotTime[playerName] = nil
		return true

	elseif currentHealth == lastTargetHealth[playerName] then
		if not resolverPredictions[playerName] then
			resolverPredictions[playerName] = Config.Prediction
		end
		resolverPredictions[playerName] = resolverPredictions[playerName] + predictionIncrement
		lastTargetHealth[playerName] = currentHealth
		lastShotTime[playerName] = nil
		return false
	end

	lastTargetHealth[playerName] = currentHealth
	return false
end

local function ResetResolver()
	resolverPredictions = {}
	lockedResolverPredictions = {}
	lastTargetHealth = {}
	lastPositions = {}
	resolverHitTimers = {}
	lastShotTime = {}
	currentResolverTarget = nil
end

local function ResetResolverForTarget(playerName)
	if playerName then
		resolverPredictions[playerName] = Config.Prediction
		lastTargetHealth[playerName] = nil
		lastPositions[playerName] = nil
		resolverHitTimers[playerName] = nil
		lockedResolverPredictions[playerName] = nil
		lastShotTime[playerName] = nil
	end
end

local function GetResolverPrediction(targetPlayer, targetCharacter)
	if not resolverEnabled or not targetPlayer or not targetCharacter then
		return Config.Prediction
	end

	local playerName = targetPlayer.Name
	if lockedResolverPredictions[playerName] and IsHitStillValid(playerName) then
		return lockedResolverPredictions[playerName]
	else
		if lockedResolverPredictions[playerName] and not IsHitStillValid(playerName) then
			lockedResolverPredictions[playerName] = nil
			resolverHitTimers[playerName] = nil
		end

		if not resolverPredictions[playerName] then
			resolverPredictions[playerName] = Config.Prediction
		end

		return resolverPredictions[playerName]
	end
end

local function StartResolverTimer()
	if resolverRunning then
		resolverRunning = false
		RunService.RenderStepped:Wait()
	end

	resolverRunning = true

	task.spawn(function()
		local startTime = tick()

		while resolverRunning and killLoopActive do
			local elapsed = tick() - startTime

			if elapsed >= resetTimer then
				ResetResolver()
				startTime = tick()
			end

			RunService.RenderStepped:Wait()
		end
	end)
end

local function ShootWithResolver(targetCharacter, gun)
	if not targetCharacter or not gun then
		return
	end

	local targetPlayer = Players:GetPlayerFromCharacter(targetCharacter)
	if not targetPlayer then
		return
	end

	local gunPosition = LocalPlayer.Character.HumanoidRootPart.Position
	local partToAim = targetCharacter:FindFirstChild(Config.AimPart) or targetCharacter:FindFirstChild("UpperTorso")

	if not partToAim then
		return
	end

	local targetPosition = getClosestPointOnPart(partToAim)
	local resolverPred = GetResolverPrediction(targetPlayer, targetCharacter)
	local velocity = CalculateVelocity(targetCharacter)
	local predictedPosition = targetPosition + (velocity * resolverPred)

	is_setting_mouse_pos = true
	mouse_position = CFrame.new(predictedPosition)
	RecordShot(targetPlayer)

	gun:Activate()
	task.spawn(function()
		CheckHealthChange(targetPlayer, targetCharacter)
	end)
end


local current_smoothed_pos = nil


local function MainAimInit()
	-- FOV Circle
	circle.Visible = Config.ShowFov
	circle.Radius = Config.FovSize
	circle.Transparency = Config.FovTransparency
	circle.Filled = Config.FovFiled
	circle.Position = getMousePos()
	circle.NumSides = Config.FovSegments	
	-- Auto Prediction
	if Config.AutoPrediction then
		local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
		-- your ping table stays unchanged
		if ping then
			if ping < 5 then
				Config.Prediction = 0.1
			elseif ping < 20 then
				Config.Prediction = 0.157
			elseif ping < 30 then
				Config.Prediction = 0.155
			elseif ping < 40 then
				Config.Prediction = 0.145
			elseif ping < 50 then
				Config.Prediction = 0.143
			elseif ping < 60 then
				Config.Prediction = 0.140
			elseif ping < 70 then
				Config.Prediction = 0.136
			elseif ping < 80 then
				Config.Prediction = 0.133
			elseif ping < 90 then
				Config.Prediction = 0.130
			elseif ping < 105 then
				Config.Prediction = 0.127
			elseif ping < 110 then
				Config.Prediction = 0.124
			elseif ping < 120 then
				Config.Prediction = 0.120
			elseif ping < 130 then
				Config.Prediction = 0.116
			elseif ping < 140 then
				Config.Prediction = 0.113
			elseif ping < 150 then
				Config.Prediction = 0.110
			elseif ping < 160 then
				Config.Prediction = 0.18
			elseif ping < 170 then
				Config.Prediction = 0.15
			elseif ping < 180 then
				Config.Prediction = 0.12
			elseif ping < 190 then
				Config.Prediction = 0.10
			elseif ping < 205 then
				Config.Prediction = 1.0
			elseif ping < 215 then
				Config.Prediction = 1.2
			elseif ping < 225 then
				Config.Prediction = 1.4
			end
		end
	end

	if not use_pred then
		Config.Prediction = 0
	end

	if not Config.Enabled then
		lockedTarget = nil
		locked = false
		lastValidTarget = nil

		is_setting_mouse_pos = false
		return
	end

	if Config.StickyTarget and lastValidTargetPlayer then
		local player = lastValidTargetPlayer
		if player and player.Parent then
			local character = player.Character
			if character and character.Parent and isValidTarget(character) then
				lockedTarget = character
				locked = true
			else
				lockedTarget = nil
				locked = false
				if player.CharacterAdded then
					player.CharacterAdded:Wait()
					task.wait(0.1)
				end
			end
		else
			lastValidTargetPlayer = nil
			lockedTarget = nil
			locked = false
		end
	end


	if Config.Enabled and not Config.StickyTarget then
		local closestPlayer = getClosestPlayerInFov()
		if closestPlayer then
			lockedTarget = closestPlayer
			locked = true
		else
			lockedTarget = nil
			locked = false
		end
	end

	if lockedTarget and locked then
		if Config.UseHitChance and not ShouldHit() then
			is_setting_mouse_pos = false   
			return
		end
		local partToAim = nil
		if Config.AimPart == "Closest Part" then
			partToAim = getClosestPartToMouse(lockedTarget)
		else
			partToAim = lockedTarget:FindFirstChild(Config.AimPart)
		end

		if not partToAim then
			partToAim = lockedTarget:FindFirstChild("UpperTorso")
		end

		if partToAim then
			local targetPoint = getClosestPointOnPart(partToAim)
			local velocity = partToAim.Velocity
			local targetPlayer = Players:GetPlayerFromCharacter(lockedTarget)

			if Config.Resolver and targetPlayer then
				velocity = CalculateAbsolutePosition(targetPlayer)
			end

			local predicted
			if resolverEnabled and targetPlayer then
				if currentResolverTarget ~= targetPlayer.Name then
					ResetResolverForTarget(currentResolverTarget)
					currentResolverTarget = targetPlayer.Name
				end

				local resolverPred = GetResolverPrediction(targetPlayer, lockedTarget)
				predicted = targetPoint + (velocity * resolverPred)

				task.spawn(function()
					CheckHealthChange(targetPlayer, lockedTarget)
				end)
			else
				predicted = (targetPoint + velocity * Config.Prediction) + Vector3.new(0,0.001,0)
			end
			is_setting_mouse_pos = true

			if aim_type == "silent aim" then
				if not current_smoothed_pos then
					-- Temporarily disable hook to get the actual mouse position for start of lerp
					is_setting_mouse_pos = false
					current_smoothed_pos = mouse.Hit.Position
					is_setting_mouse_pos = true
				end

				-- Smoothly interpolate towards the predicted target
				current_smoothed_pos = current_smoothed_pos:Lerp(predicted, Config.Smoothing)
				mouse_position = CFrame.new(current_smoothed_pos)

				-- Proactively fire the remote to ensure the "glide" is visible to others (Aimview protection)
				if Config.Smoothing < 1 then
					local mainRemote = ReplicatedStorage:FindFirstChild("MainRemote")
					if mainRemote then
						mainRemote:FireServer("MousePosDHM", current_smoothed_pos)
					end
				end
			elseif aim_type == "cam lock" then
				Camera.CFrame = CFrame.new(Camera.CFrame.Position, predicted)
			end


		end
	else
		current_smoothed_pos = nil
		is_setting_mouse_pos = false
	end
end

local function sFLY(vfly)
	local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		repeat task.wait() until LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	end

	if flyKeyDown or flyKeyUp then
		flyKeyDown:Disconnect()
		flyKeyUp:Disconnect()
	end

	local T = LocalPlayer.Character:WaitForChild('HumanoidRootPart')
	local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local SPEED = 0

	local function FLY()
		FLYING = true
		local BG = Instance.new('BodyGyro')
		local BV = Instance.new('BodyVelocity')
		BG.P = 9e4
		BG.Parent = T
		BV.Parent = T
		BG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
		BG.CFrame = T.CFrame
		BV.Velocity = Vector3.new(0, 0, 0)
		BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
		task.spawn(function()
			repeat task.wait()
				local camera = workspace.CurrentCamera
				if not vfly and humanoid then
					humanoid.PlatformStand = true
				end

				if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
					SPEED = 50
				elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
					SPEED = 0
				end
				if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
					BV.Velocity = ((camera.CFrame.LookVector * (CONTROL.F + CONTROL.B)) + ((camera.CFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).Position) - game.Workspace.Camera.CFrame.Position)) * SPEED
					lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
				elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
					BV.Velocity = ((camera.CFrame.LookVector * (lCONTROL.F + lCONTROL.B)) + ((camera.CFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).Position) - game.Workspace.Camera.CFrame.Position)) * SPEED
				else
					BV.Velocity = Vector3.new(0, 0, 0)
				end
				BG.CFrame = camera.CFrame
			until not FLYING
			CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			SPEED = 0
			BG:Destroy()
			BV:Destroy()

			if humanoid then humanoid.PlatformStand = false end
		end)
	end

	flyKeyDown = game:GetService('UserInputService').InputBegan:Connect(function(input, processed)
		if input.KeyCode == Enum.KeyCode.W then
			CONTROL.F = (vfly and vehicleflyspeed or iyflyspeed)
		elseif input.KeyCode == Enum.KeyCode.S then
			CONTROL.B = - (vfly and vehicleflyspeed or iyflyspeed)
		elseif input.KeyCode == Enum.KeyCode.A then
			CONTROL.L = - (vfly and vehicleflyspeed or iyflyspeed)
		elseif input.KeyCode == Enum.KeyCode.D then
			CONTROL.R = (vfly and vehicleflyspeed or iyflyspeed)
		elseif input.KeyCode == Enum.KeyCode.E and QEfly then
			CONTROL.Q = (vfly and vehicleflyspeed or iyflyspeed)*2
		elseif input.KeyCode == Enum.KeyCode.Q and QEfly then
			CONTROL.E = -(vfly and vehicleflyspeed or iyflyspeed)*2
		end
		pcall(function() camera.CameraType = Enum.CameraType.Track end)
	end)

	flyKeyUp = game:GetService('UserInputService').InputEnded:Connect(function(input, processed)
		if input.KeyCode == Enum.KeyCode.W then
			CONTROL.F = 0
		elseif input.KeyCode == Enum.KeyCode.S then
			CONTROL.B = 0
		elseif input.KeyCode == Enum.KeyCode.A then
			CONTROL.L = 0
		elseif input.KeyCode == Enum.KeyCode.D then
			CONTROL.R = 0
		elseif input.KeyCode == Enum.KeyCode.E then
			CONTROL.Q = 0
		elseif input.KeyCode == Enum.KeyCode.Q then
			CONTROL.E = 0
		end
	end)
	FLY()
end

local function NOFLY()
	FLYING = false
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end
	if game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
		game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
	end
	pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
end

local function TeleportSpeed() 
	local delta = RunService.Heartbeat:Wait()
	if LocalPlayer.Character:FindFirstChild('Humanoid').MoveDirection.Magnitude > 0 then
		if Config.CFrame_Speed_Amount then
			LocalPlayer.Character:TranslateBy(LocalPlayer.Character:FindFirstChild('Humanoid').MoveDirection * tonumber(Config.CFrame_Speed_Amount) * delta * 10)
		else
			LocalPlayer.Character:TranslateBy(LocalPlayer.Character:FindFirstChild('Humanoid').MoveDirection * delta * 10)
		end
	end
end

local function GetUsernameFromEntry(entry)
	if not entry then return "" end
	local username = entry:match("@([^)]+)")
	if username then
		return username
	end

	for _, player in pairs(Players:GetPlayers()) do
		if player.DisplayName == entry or player.Name == entry then
			return player.Name
		end
	end

	return entry
end

local function PlayAudio(method,id)
	LocalPlayer.Character:FindFirstChild('Humanoid'):UnequipTools()
	local boombox = LocalPlayer.Backpack:FindFirstChild('[Boombox]')
	if boombox.Grip ~= CFrame.new(0.600000024, 200, 0, 0.00426799059, -0, -0.999991, 0, 1, -0, 0.999991, 0, 0.00426799059) then
		boombox.Grip = CFrame.new(0.600000024, 200, 0, 0.00426799059, -0, -0.999991, 0, 1, -0, 0.999991, 0, 0.00426799059)
	end
	boombox.Parent = LocalPlayer.Character
	ReplicatedStorage:FindFirstChild('MainRemote'):FireServer(method,id) wait(0.03)
	boombox.Parent = LocalPlayer.Backpack
end

local function UpdateTargetList()
	local newTargetList = {}
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			table.insert(newTargetList, string.format("%s (@%s)", player.DisplayName, player.Name))
		end
	end
	Config.TargetList = newTargetList
	if targetDropdown and targetDropdown.refresh_options then
		local currentSelections = Config.MultiTargets or {}
		targetDropdown:refresh_options(newTargetList)
		if #currentSelections > 0 then
			local validSelections = {}
			for _, selected in ipairs(currentSelections) do
				if table.find(newTargetList, selected) then
					table.insert(validSelections, selected)
				end
			end
			if #validSelections > 0 then
				targetDropdown:set(validSelections)
			end
			Config.MultiTargets = validSelections
		end
	end
end

Players.PlayerAdded:Connect(UpdateTargetList)
Players.PlayerRemoving:Connect(UpdateTargetList)
UpdateTargetList()

local function GetSkinFolder(weaponName, skinName)
	for _, folder in ipairs(SkinDump:GetChildren()) do
		local parts = string.split(folder.Name, "/")
		if parts[1] == weaponName and parts[2] == skinName then
			return folder
		end
	end
	return nil
end

local function GiveSkin(tool,skin)
	local gun = LocalPlayer.Backpack:FindFirstChild(tool) or LocalPlayer.Character:FindFirstChild(tool)
	if not gun then return end

	local skinFolder = GetSkinFolder(tool, skin)
	if skinFolder then
		for _,obj in pairs(gun.Handle:GetChildren()) do
			obj:Destroy()
		end
		for _,obj in pairs(skinFolder.Handle:GetChildren()) do
			obj:Clone().Parent = gun.Handle
		end
		gun.Handle:SetAttribute("SkinName",skin)
		if gun.Handle:FindFirstChild("Skin") then
			local Skin = gun.Handle:FindFirstChild("Skin")

			if Skin:FindFirstChild('Weld') then
				Skin.Weld.Part0 = gun.Handle
			end
		end
		for i,sound in pairs(gun:GetDescendants()) do
			if sound:IsA("Sound") then
				if sound:FindFirstChild("Temp") then
					sound.SoundId = sound.Temp.Value
				end
			end
		end
	end
end

--========================================================--
--  INPUT HANDLING (LOCK TARGET)
--========================================================--

local function BindKeybind()
	if not Config.Enabled then return end

	if Config.UseFov then
		if not Config.StickyTarget then
			Config.StickyTarget = true
			if lockedTarget then
				local player = Players:GetPlayerFromCharacter(lockedTarget)
				if player then
					lastValidTargetPlayer = player
				end
			end

			return
		else
			lockedTarget, locked = nil, false
			lastValidTargetPlayer = nil
			Config.StickyTarget = false

			return
		end
	end

	if locked then
		lockedTarget, locked = nil, false
		lastValidTargetPlayer = nil

		return
	end

	local mousePos = getMousePos()
	local closestChar, closestDist = nil, math.huge
	local closestplayerobj = nil

	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer and plr.Character then
			local screenPos = getScreenPos(plr.Character)
			if screenPos then
				local dist = (screenPos - mousePos).Magnitude
				if dist < closestDist then
					closestDist = dist
					closestChar = plr.Character
					closestplayerobj = plr
				end
			end
		end
	end

	if not closestChar then return end

	if not isValidTarget(closestChar) then
		return
	end

	lockedTarget, locked = closestChar, true
	lastValidTargetPlayer = closestplayerobj
end

--========================================================--
--  MAIN LOOP
--========================================================--

RunService.RenderStepped:Connect(function()
	if Config.Enabled then
		MainAimInit()

		-- Update resolver display
		if resolverEnabled and lockedTarget then
			local targetPlayer = Players:GetPlayerFromCharacter(lockedTarget)
			if targetPlayer then
				local playerName = targetPlayer.Name
				local isLocked = lockedResolverPredictions[playerName] and IsHitStillValid(playerName)

				local predText
				if isLocked then
					local timeLeft = hitKeepTime - (tick() - resolverHitTimers[playerName])
					predText = string.format("LOCKED: %.4f (%.1fs)", lockedResolverPredictions[playerName], timeLeft)
				else
					local currentPred = resolverPredictions[playerName] or Config.Prediction
					predText = string.format("TRACKING: %.4f", currentPred)
				end

				resolverPredictionDisplay.Text = "[RESOLVER] " .. predText
				resolverPredictionDisplay.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y - 50)
				resolverPredictionDisplay.Color = isLocked and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 0)
				resolverPredictionDisplay.Visible = true
			else
				resolverPredictionDisplay.Visible = false
			end
		else
			resolverPredictionDisplay.Visible = false
		end
	else
		resolverPredictionDisplay.Visible = false
	end

	if Config.CFrame_Speed then
		TeleportSpeed()
	end
	if anti_aim_connection then
		AntiAim()
	end
end)

--========================================================--
--  LIGHTING
--========================================================--

local lighting = game:GetService("Lighting")
weather_part = nil
weather_particle = nil
atmosphere = nil

local function startlighting()
	if not atmosphere then
		atmosphere = lighting:FindFirstChildOfClass("Atmosphere") or Instance.new("Atmosphere", lighting)
	end
	if not lighting:FindFirstChildOfClass("ColorCorrectionEffect") then
		color_correction = Instance.new("ColorCorrectionEffect", lighting)
		color_correction.Name = "\0"
	else
		color_correction = lighting:FindFirstChildOfClass("ColorCorrectionEffect")
	end
end

startlighting()

lighting.DescendantRemoving:Connect(function(descendant)
	if descendant == atmosphere or descendant == color_correction then
		startlighting()
	end
end)

local Defaults = {
	Lighting = {},
	Sky = {}
}

local function lightingdf()
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
end

lightingdf()

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
	}
}

local weather_types = {
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
		Lifetime = NumberRange.new(0.800000011920929, 0.800000011920929),
		LightEmission = 0.05000000074505806,
		LightInfluence = 0.8999999761581421,
		Orientation = Enum.ParticleOrientation.FacingCameraWorldUp,
		Size = NumberSequence.new{
			NumberSequenceKeypoint.new(0, 10),
			NumberSequenceKeypoint.new(1, 10)
		}
	},
	["snow"] = {
		Transparency = NumberSequence.new{
			NumberSequenceKeypoint.new(0, 0.7374999523162842),
			NumberSequenceKeypoint.new(0.973, 0.768750011920929),
			NumberSequenceKeypoint.new(1, 1)
		},
		Texture = "http://www.roblox.com/asset/?id=99851851",
		SpreadAngle = Vector2.new(50, 50),
		Speed = NumberRange.new(30, 30),
		LightEmission = 0.5,
		Rate = 1000,
		EmissionDirection = Enum.NormalId.Bottom,
		Size = NumberSequence.new{
			NumberSequenceKeypoint.new(0, 0.33096909523010254),
			NumberSequenceKeypoint.new(0.551, 0.40189146995544434),
			NumberSequenceKeypoint.new(1, 0.33096909523010254)
		}
	},
	["light rain"] = {
		LockedToPart = true,
		Rate = 500,
		Squash = NumberSequence.new{
			NumberSequenceKeypoint.new(0, 3),
			NumberSequenceKeypoint.new(1, 3)
		},
		LightInfluence = 0.30000001192092896,
		Transparency = NumberSequence.new{
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(0.435, 0),
			NumberSequenceKeypoint.new(1, 1)
		},
		Texture = "rbxasset://textures/particles/sparkles_main.dds",
		Speed = NumberRange.new(30, 50),
		Lifetime = NumberRange.new(9, 9),
		LightEmission = 0.5,
		Brightness = 2,
		EmissionDirection = Enum.NormalId.Bottom,
		Orientation = Enum.ParticleOrientation.FacingCameraWorldUp,
		Size = NumberSequence.new{
			NumberSequenceKeypoint.new(0, 0.20000000298023224),
			NumberSequenceKeypoint.new(1, 0.20000000298023224)
		}
	}
}



--========================================================--
--  PLAYER TARGET
--========================================================--

local function UpdateTargetList()
	local newTargetList = {}
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			table.insert(newTargetList, string.format("%s (@%s)", player.DisplayName, player.Name))
		end
	end
	Config.TargetList = newTargetList
	if targetDropdown and targetDropdown.refresh_options then
		local currentSelections = Config.MultiTargets or {}
		targetDropdown:refresh_options(newTargetList)
		if #currentSelections > 0 then
			local validSelections = {}
			for _, selected in ipairs(currentSelections) do
				if table.find(newTargetList, selected) then
					table.insert(validSelections, selected)
				end
			end
			if #validSelections > 0 then
				targetDropdown:set(validSelections)
			end
			Config.MultiTargets = validSelections
		end
	end
end
Players.PlayerAdded:Connect(UpdateTargetList)
Players.PlayerRemoving:Connect(UpdateTargetList)

UpdateTargetList()

local function NoclipLoop()
	if LocalPlayer.Character then
		for _, child in pairs(LocalPlayer.Character:GetDescendants()) do
			if child:IsA("BasePart") and child.CanCollide then
				child.CanCollide = false
			end
		end
	end
end

--========================================================--
--  UI SETUP
--========================================================--

local Main = window:tab({ name = "misc" })
local Aim = window:tab({ name = "combat" })
local Extra = window:tab({ name = "extra" })
local Lighting = window:tab({ name = "world" })
local Configs = window:tab({ name = "configs" })

-- MISC
local movement = Main:section({ name = "movement" })
local stomps = Main:section({ name = "stomps", side = "right" })
local gunskins = Main:section({ name = "gun skins", side = "right" })
local targeting = Main:section({ name = "player targetting" })
local tools = Main:section({ name = "tools" })
local streak = Main:section({ name = "streak",side = "right"})
local otherstuff = Main:section({ name = "other stuff",side = "right"})

--AIMBOT
local setup = Aim:section({ name = "setup" })
local prediction = Aim:section({ name = "prediction", side = "right" })
local fov = Aim:section({ name = "fov", side = "right" })
local aimpart = Aim:section({ name = "aim part" })
local resolver_section = Aim:section({ name = "resolver" })
local checks = Aim:section({ name = "checks", side = "right" })
local orbitSection = Aim:section({ name = "orbit", side = "right" })
local other = Aim:section({ name = "misc" })

--EXTRA
local ESPControls = Extra:section({ name = "esp", side = "right" })
local AutoBuy = Extra:section({ name = "auto buy" })
local teleports = Extra:section({ name = "teleports" })
local VelocityAnti = Extra:section({ name = "velocity anti" })
local ESPColors = Extra:section({ name = "esp colors" })
local ChatSection = Extra:section({ name = "chat", side = "right" })

-- LIGHTING
local lightingtb = Lighting:section({ name = "lighting" })
local fogsettings = Lighting:section({ name = "fog", side = "right" })
local skysettings = Lighting:section({ name = "sky", side = "right" })
local atmosphere_section = Lighting:section({ name = "atmosphere", side = "right" })
local weather_section = Lighting:section({ name = "weather" })
--========================================================--
--  UI ELEMENTS
--========================================================--

movement:toggle({
	name = "speed",
	flag = "movement_speed",
	default = false,
	callback = function(value)
		Config.CFrame_Speed = value
	end
})

movement:slider({
	name = "speed multiplier",
	flag = "movement_speed_multiplier",
	default = 4,
	min = 0,
	max = 30,
	callback = function(value)
		Config.CFrame_Speed_Amount = value
	end
})

movement:dropdown({
	name = "loop type",
	flag = "movement_loop_type",
	items = {'fps','non fps'},
	default = 'fps',
	multi = false
})

movement:toggle({
	name = "infinite jump",
	flag = "movement_inf_jump",
	default = false,
	callback = function(value)
		if value == true then
			if LocalPlayer.Character:FindFirstChild('BodyEffects'):FindFirstChild('Stamina') then
				LocalPlayer.Character:FindFirstChild('BodyEffects'):FindFirstChild('Stamina'):Destroy()
			end
			Config.infjump = UserInputService.JumpRequest:Connect(function()
				LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
			end)
		elseif value == false then
			if Config.infjump then Config.infjump:Disconnect() end
		end
	end
})

movement:slider({
	name = "jump power",
	flag = "movement_jump_power",
	default = 50,
	min = 50,
	max = 500,
	callback = function(value)
		LocalPlayer.Character:FindFirstChild('Humanoid').JumpPower = value
		if LocalPlayer.Character:FindFirstChild('Humanoid').UseJumpPower == false then
			LocalPlayer.Character:FindFirstChild('Humanoid').UseJumpPower = true
		end
	end
})

movement:toggle({
	name = "fly",
	flag = "movement_fly",
	default = false,
	callback = function(value)
		if value then
			sFLY()
		else 
			NOFLY()
		end
	end
})

movement:slider({
	name = "fly speed",
	flag = "movement_fly_speed",
	default = 5,
	min = 0,
	max = 100,
	callback = function(value)
		iyflyspeed = value
		vehicleflyspeed = value
	end
})

stomps:toggle({
	name = "stomp changer",
	flag = "stomps_changer",
	default = false,
	callback = function(value)
		if value then
			local Character = LocalPlayer.Character
			Config.stompfunc = ReplicatedStorage.MainRemote.OnClientEvent:Connect(function(...)
				local tabl = {...}

				if tabl[1] == "FX_KILL" and tabl[4] == LocalPlayer then
					local targetCharacter = tabl[3].Parent
					local targetHead = targetCharacter:FindFirstChild("Head")
					local targetTorso = targetCharacter:FindFirstChild("UpperTorso") or targetCharacter:FindFirstChild("Torso")
					print(Config.stomp_type,Config.StompEffectServer,Config.StompEffectClient)

					if Config.stomp_type == 'client' then
						if targetHead and targetTorso then

							if Config.StompEffectClient == 'Road Roller' or Config.StompEffectClient == 'RoadRoller' then
								local rr = loadstring(game:HttpGet("https://aries-industries.vercel.app/modules/roadroller.lua"))()
								rr.StompFX(targetCharacter)
							end

							local succ,err = pcall(function()
								require(ReplicatedStorage.KillFX:FindFirstChild(Config.StompEffectClient)).RunStompFx(Config.StompEffectClient,targetHead,LocalPlayer,targetTorso.CFrame)
							end)

							if err then
								warn('ur executor doesnt support require function and or bad decompiler, error:',err)
							end
						end
					elseif Config.stomp_type == 'server' then
						if targetHead and targetTorso then

							local succ,err = pcall(function()
								if Config.StompEffectServer == 'goku' then

									local Charge_Animation = Instance.new('Animation')
									Charge_Animation.AnimationId = 'http://www.roblox.com/asset/?id=14777168343'
									local Blast_Animation = Instance.new('Animation')
									Blast_Animation.AnimationId = 'http://www.roblox.com/asset/?id=14777179747'

									for i,v in pairs(Character.Humanoid:GetPlayingAnimationTracks()) do
										v:Stop()
									end

									local Charge = Character.Humanoid:LoadAnimation(Charge_Animation)
									local Blast = Character.Humanoid:LoadAnimation(Blast_Animation)
									Charge:Play(0.3)
									PlayAudio('Play','8918040963')

									local BodyPosition = Instance.new("BodyPosition")
									BodyPosition.Parent = targetTorso
									BodyPosition.Position = Character.HumanoidRootPart.Position + (Character.HumanoidRootPart.CFrame.LookVector * 4)

									BodyPosition.MaxForce = Vector3.new(1e5, 1e5, 1e5)
									BodyPosition.P = 20000
									task.wait(1.9)
									Charge:Stop(0.2)
									Blast:Play(0.2)
									PlayAudio('Play','8899285496')
									wait(0.1)
									BodyPosition.P = 30000
									BodyPosition.Position = Character.HumanoidRootPart.Position + (Character.HumanoidRootPart.CFrame.LookVector * 500)
									task.wait(0.7)
									Blast:Stop(0.3)

								elseif Config.StompEffectServer == 'scorpion' then
									local Throw_Animation = Instance.new('Animation')
									Throw_Animation.AnimationId = 'http://www.roblox.com/asset/?id=14776867339'
									local Pull_Back_Animation = Instance.new('Animation')
									Pull_Back_Animation.AnimationId = 'http://www.roblox.com/asset/?id=14776862180'
									local Swing_Animation = Instance.new('Animation')
									Swing_Animation.AnimationId = 'http://www.roblox.com/asset/?id=16778131702'

									local Throw = Character.Humanoid:LoadAnimation(Throw_Animation)
									local Pull_Back = Character.Humanoid:LoadAnimation(Pull_Back_Animation)
									local Swing = Character.Humanoid:LoadAnimation(Swing_Animation)

									for i,v in pairs(Character.Humanoid:GetPlayingAnimationTracks()) do
										v:Stop(0.2)
									end

									wait(0.3)

									local BodyPosition = Instance.new("BodyPosition")
									BodyPosition.Parent = targetTorso

									BodyPosition.Position = Character.HumanoidRootPart.Position + Vector3.new(0,10,0) + (Character.HumanoidRootPart.CFrame.LookVector * 25)
									BodyPosition.MaxForce = Vector3.new(1e5, 1e5, 1e5)
									BodyPosition.P = 25000

									Throw:Play()
									PlayAudio('Play','507150998')
									wait(0.8)
									PlayAudio('Play','203773793')
									Pull_Back:Play()
									Pull_Back:AdjustSpeed(1.2)
									wait(0.6)
									BodyPosition.Position = Character.HumanoidRootPart.Position + (Character.HumanoidRootPart.CFrame.LookVector * 2)
									BodyPosition.P = 15000
									wait(0.8)
									PlayAudio('Play','6808975002')
									Swing:Play() wait(0.2)
									BodyPosition.Position = Character.HumanoidRootPart.Position + Vector3.new(0,-10,0) + (Character.HumanoidRootPart.CFrame.LookVector * 150)


								elseif Config.StompEffectServer == 'over heaven' then
									local TargetPosition = Instance.new("BodyPosition")
									TargetPosition.Parent = targetTorso
									TargetPosition.Position = targetTorso.Position + Vector3.new(0,10,0)
									TargetPosition.MaxForce = Vector3.new(1e5, 1e5, 1e5)
									TargetPosition.P = 5000
									PlayAudio('Play','8033655853')
									wait(1)
									TargetPosition.Position = targetTorso.Position + Vector3.new(0,300,0)
								elseif Config.StompEffectServer == 'saitama' then

									local Saitama_Idle_Animation = Instance.new('Animation')
									Saitama_Idle_Animation.AnimationId = 'http://www.roblox.com/asset/?id=112562301455194'

									local Saitama_Awaken_Animation = Instance.new('Animation')
									Saitama_Awaken_Animation.AnimationId = 'http://www.roblox.com/asset/?id=14777206653'

									local Saitama_Glide_Animation = Instance.new('Animation')
									Saitama_Glide_Animation.AnimationId = 'http://www.roblox.com/asset/?id=14777211236'

									local Saitama_Hit_Animation = Instance.new('Animation')
									Saitama_Hit_Animation.AnimationId = 'http://www.roblox.com/asset/?id=16778131702'


									local SaitamaIdle = Character.Humanoid:LoadAnimation(Saitama_Idle_Animation)
									local SaitamaAwaken = Character.Humanoid:LoadAnimation(Saitama_Awaken_Animation)
									local SaitamaGlide = Character.Humanoid:LoadAnimation(Saitama_Glide_Animation)
									local SaitamaHit = Character.Humanoid:LoadAnimation(Saitama_Hit_Animation)

									for i,v in pairs(Character.Humanoid:GetPlayingAnimationTracks()) do
										v:Stop()
									end

									PlayAudio('Play','5687191726')
									SaitamaIdle:Play()			

									Character:MoveTo(Character.HumanoidRootPart.Position + (Character.HumanoidRootPart.CFrame.LookVector * -5))

									local PlrPosition = Instance.new("BodyPosition")
									PlrPosition.Parent = Character.HumanoidRootPart

									PlrPosition.Position = Character.HumanoidRootPart.Position
									PlrPosition.MaxForce = Vector3.new(1e5, 1e5, 1e5)
									PlrPosition.P = 15000

									Character.Humanoid.AutoRotate = false

									wait(1)
									SaitamaIdle:Stop()
									SaitamaAwaken:Play()
									SaitamaAwaken:AdjustSpeed(0.9)

									wait(0.2)

									local BodyPosition = Instance.new("BodyPosition")
									BodyPosition.Parent = targetTorso

									--/ anim start

									BodyPosition.Position = Character.HumanoidRootPart.Position + Vector3.new(0,5,0) + (Character.HumanoidRootPart.CFrame.LookVector * 5)
									BodyPosition.MaxForce = Vector3.new(1e5, 1e5, 1e5)
									BodyPosition.P = 1e5

									wait(0.25)
									Character:MoveTo(Character.HumanoidRootPart.Position + Vector3.new(0,20,0) + (Character.HumanoidRootPart.CFrame.LookVector * -35))
									PlrPosition.Position = Character.HumanoidRootPart.Position
									wait(0.25)

									SaitamaAwaken:Stop()
									SaitamaGlide:Play()
									SaitamaGlide:AdjustSpeed(0.85)
									PlrPosition.Position = BodyPosition.Position + Vector3.new(0,-1.5,0) + (Character.HumanoidRootPart.CFrame.LookVector * -3)

									SaitamaGlide.Stopped:Connect(function()
										SaitamaHit:Play()
										PlayAudio('Play','18179518411')
										wait(0.2)
										BodyPosition.Position = Character.HumanoidRootPart.Position + Vector3.new(0,-20,0) + (Character.HumanoidRootPart.CFrame.LookVector * 300)
										wait(1)

										PlrPosition:Destroy()
										Character.Humanoid.AutoRotate = true
									end)

								elseif Config.StompEffectServer == 'ground pound' then
									local GroundSlam_Animation = Instance.new('Animation')
									GroundSlam_Animation.AnimationId = 'http://www.roblox.com/asset/?id=14777200153'
									local Teleport_Animation = Instance.new('Animation')
									Teleport_Animation.AnimationId = 'http://www.roblox.com/asset/?id=14777144752'
									local KickSlam_Animation = Instance.new('Animation')
									KickSlam_Animation.AnimationId = 'http://www.roblox.com/asset/?id=14777189609'

									local GroundSlam = Character.Humanoid:LoadAnimation(GroundSlam_Animation)
									local Teleport = Character.Humanoid:LoadAnimation(Teleport_Animation)
									local KickSlam = Character.Humanoid:LoadAnimation(KickSlam_Animation)

									for i,v in pairs(Character.Humanoid:GetPlayingAnimationTracks()) do
										v:Stop()
									end

									Character:MoveTo(Character.HumanoidRootPart.Position + (Character.HumanoidRootPart.CFrame.LookVector * -5))

									GroundSlam:Play()

									wait(0.75)

									PlayAudio('Play','115426499441465')

									local BodyPosition = Instance.new("BodyPosition")
									BodyPosition.Parent = targetTorso

									--/ anim start

									BodyPosition.Position = Character.HumanoidRootPart.Position + Vector3.new(0,20,0) + (Character.HumanoidRootPart.CFrame.LookVector * 15)
									BodyPosition.MaxForce = Vector3.new(1e5, 1e5, 1e5)
									BodyPosition.P = 25000

									wait(0.5)
									GroundSlam:Stop()
									Teleport:Play()

									local BodyPosition2 = Instance.new("BodyPosition")
									BodyPosition2.Parent = Character.UpperTorso
									BodyPosition2.MaxForce = Vector3.new(1e5,1e5,1e5)
									BodyPosition2.P = 1e5

									BodyPosition2.Position = BodyPosition.Position + Vector3.new(0,2.5,0) + (Character.HumanoidRootPart.CFrame.LookVector * -2)

									PlayAudio('Play','9758530498')

									task.wait(1)

									PlayAudio('Play','1058693352')

									Teleport:Stop()
									KickSlam:Play()
									wait(0.25)
									BodyPosition.Position = Character.HumanoidRootPart.Position + Vector3.new(0,-60,0) + (Character.HumanoidRootPart.CFrame.LookVector * 50)
									BodyPosition.P = 20000
									task.wait(1)
									BodyPosition2:Destroy()
								elseif Config.StompEffectServer == 'barrage' then

									local GroundSlam_Animation = Instance.new('Animation')
									GroundSlam_Animation.AnimationId = 'http://www.roblox.com/asset/?id=14777200153'
									local Barrage_Animation = Instance.new('Animation')
									Barrage_Animation.AnimationId = 'http://www.roblox.com/asset/?id=14776972669'

									local GroundSlam = Character.Humanoid:LoadAnimation(GroundSlam_Animation)
									local Barrage = Character.Humanoid:LoadAnimation(Barrage_Animation)

									Character:MoveTo(Character.HumanoidRootPart.Position + (Character.HumanoidRootPart.CFrame.LookVector * -5))
									local FlingPos = Character.HumanoidRootPart.CFrame.LookVector

									local PlrPosition = Instance.new("BodyPosition")
									PlrPosition.Parent = Character.HumanoidRootPart

									PlrPosition.Position = Character.HumanoidRootPart.Position
									PlrPosition.MaxForce = Vector3.new(1e5, 1e5, 1e5)
									PlrPosition.P = 50000

									for i,v in pairs(Character.Humanoid:GetPlayingAnimationTracks()) do
										v:Stop()
									end

									Character.Humanoid.AutoRotate = false

									PlayAudio('Play','8285346587')
									GroundSlam:Play()

									wait(0.7)

									local BodyPosition = Instance.new("BodyPosition")
									BodyPosition.Parent = targetTorso

									--/ anim start

									BodyPosition.Position = Character.HumanoidRootPart.Position + Vector3.new(0,5,0) + (Character.HumanoidRootPart.CFrame.LookVector * 25)
									BodyPosition.MaxForce = Vector3.new(1e5, 1e5, 1e5)
									BodyPosition.P = 1e5

									wait(0.3)

									PlayAudio('Play','5641877325')
									Barrage:Play(0.5)

									PlrPosition.Position = BodyPosition.Position + Vector3.new(0,-1,0) + (Character.HumanoidRootPart.CFrame.LookVector * -3.5)

									wait(1.6)
									Barrage:Stop(0.25)
									wait(0.3)

									BodyPosition.Position = Character.HumanoidRootPart.Position + Vector3.new(0,-2,0) + (FlingPos * 300)
									wait(1)

									PlrPosition.Position = PlrPosition.Position + Vector3.new(0,-5,0)
									wait(0.2)
									PlrPosition:Destroy()
									Character.Humanoid.AutoRotate = true
								elseif Config.StompEffectServer == 'skyfall' then

									local Skyfall_Animation = Instance.new('Animation')
									Skyfall_Animation.AnimationId = 'http://www.roblox.com/asset/?id=14775812675'

									local Skyfall = Character.Humanoid:LoadAnimation(Skyfall_Animation)

									Skyfall:Play()
									Skyfall.TimePosition = 1
									PlayAudio('Play','13047753222')

									local RightHand = Character:FindFirstChild("RightHand")

									local bp = Instance.new("BodyPosition")
									bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge) 
									bp.P = 1e5 
									bp.D = 1e3 
									bp.Position = RightHand.Position 
									bp.Parent = targetTorso.Parent:FindFirstChild('Head')

									local Connection = nil

									Character:MoveTo(Character.HumanoidRootPart.Position + (Character.HumanoidRootPart.CFrame.LookVector * -5))

									Character.HumanoidRootPart.Anchored = true

									Connection = game:GetService('RunService').Heartbeat:Connect(function()
										if RightHand and targetTorso.Parent.Head then
											bp.Position = RightHand.Position
											for i,v in pairs(targetTorso.Parent:GetChildren()) do
												if v:IsA("BasePart") then
													v.CanCollide = false
													v.Massless = true
													v.CanTouch = false
													v.CanQuery = false
												end
											end
										end
									end)

									task.spawn(function()

										wait(1.95)
										Connection:Disconnect()
										bp.D = 1250
										bp.P = 30000
										bp.MaxForce = Vector3.new(1e5,1e5,1e5)
										bp.Position = Character.HumanoidRootPart.Position + Vector3.new(0,300,0)
										wait(0.5)
										Skyfall:Stop(0.5)
										Character.HumanoidRootPart.Anchored = false
									end)

									if targetTorso.Parent:FindFirstChild('Humanoid') then
										targetTorso.Parent:FindFirstChild('Humanoid').Died:Connect(function()
											if not Connection then return end
											Connection:Disconnect()
										end)
									end
								end
							end)

							if err then
								warn('an error has accoured while running server stomps, error:',err)
							end
						end
					end
				end
			end)
		else
			if Config.stompfunc then Config.stompfunc:Disconnect() end
		end
	end
})
stomps:dropdown({
	name = "stomp type",
	flag = "stomps_type",
	items = {'client','server'},
	default = 'client',
	multi = false,
	callback = function(value)
		Config.stomp_type = tostring(value)
	end
})

stomps:dropdown({
	name = "client stomps",
	flag = "stomps_client",
	items = Config.CurrentStompList,
	default = 'Mario',
	multi = false,
	callback = function(value)
		Config.StompEffectClient = value
	end
})

stomps:dropdown({
	name = "server stomps",
	flag = "stomps_server",
	items = {'goku','scorpion','over heaven','saitama','ground pound','barrage','skyfall'},
	default = 'goku',
	multi = false,
	callback = function(value)
		Config.StompEffectServer = value
	end
})

stomps:toggle({
	name = "stomp aura",
	flag = "stomps_aura",
	default = false,
	callback = function(value)
		Config.Stomp_Aura = value
	end
})

stomps:toggle({
	name = "ignore picked up",
	flag = "stomps_ignore_grabbed",
	default = false,
	callback = function(value)
		Config.Ignore_Grabing = value
	end
})

stomps:toggle({
	name = "anti stomp",
	flag = "stomps_anti",
	default = false,
	callback = function(value)
		Config.anti_stomp_enabled = value
	end
})

gunskins:toggle({
	name = "auto apply",
	flag = "gunskins_auto_apply",
	default = false,
	callback = function(value)
		Config.auto_apply_skin = value
	end
})

gunskins:dropdown({
	name = "gun type",
	flag = "gunskins_gun_type",
	items = {"[Revolver]","[Double Barrel SG]","set"},
	default = "[Revolver]",
	multi = false,
	callback = function(value)
		GunType = value
	end
})

gunskins:dropdown({
	name = "rev skins",
	flag = "gunskins_rev_skins",
	items = Config.rev_skins,
	default = 'Galaxy',
	multi = false,
	callback = function(value)
		Skin = value
	end
})

gunskins:dropdown({
	name = "db skins",
	flag = "gunskins_db_skins",
	items = Config.db_skins,
	default = 'Galaxy',
	multi = false,
	callback = function(value)
		Skin = value
	end
})

gunskins:button({
	name = "apply skins",
	callback = function()
		if GunType == "set" then
			GiveSkin("[Revolver]",Skin)
			GiveSkin("[Double Barrel SG]",Skin)
		else
			GiveSkin(GunType,Skin)
		end
	end
})

targetDropdown = targeting:dropdown({
	name = "targets",
	flag = "targeting_targets",
	items = {},
	multi = true,
	callback = function(selected)
		Config.MultiTargets = selected
	end
})

targeting:toggle({
	name = "view target",
	flag = "targeting_view",
	default = false,
	callback = function(value)
		Config.view_connection = value
		if value then
			RunService:BindToRenderStep("ViewTarget", 1, function()
				if lockedTarget then
					Camera.CameraSubject = lockedTarget:FindFirstChild("Humanoid") or lockedTarget
				else
					Camera.CameraSubject = LocalPlayer.Character:FindFirstChild("Humanoid") or LocalPlayer.Character
				end
			end)
		else
			RunService:UnbindFromRenderStep("ViewTarget")
			Camera.CameraSubject = LocalPlayer.Character:FindFirstChild("Humanoid") or LocalPlayer.Character
		end
	end
})

targeting:button({
	name = "teleport to target",
	callback = function()
		if Config.target then
			local position = Config.target.Character:FindFirstChild("HumanoidRootPart").CFrame
			LocalPlayer.Character.HumanoidRootPart.CFrame = position
		end
	end
})

targeting:slider({
	name = "hit time",
	flag = "targeting_hit_time",
	default = 1.0,
	min = 0.5,
	max = 5.0,
	interval = 0.5,
	callback = function(value)
		hitKeepTime = value
	end
})

local function StopLoopKill()
	KillTestVarible = false
	killLoopActive = false
	resolverRunning = false

	if Noclipping then
		Noclipping:Disconnect()
		Noclipping = nil
	end

	if loopKillConnection then
		loopKillConnection:Disconnect()
		loopKillConnection = nil
	end

	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		local BodyV = LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity")
		if BodyV then
			BodyV:Destroy()
		end
	end

	if Config.KillMethod == "Gun" then
		Config.Enabled = originalEnabled
		Config.StickyTarget = originalStickyTarget
		Config.UseFov = originalUseFov
		lockedTarget = nil
		locked = false
		lastValidTargetPlayer = nil
		is_setting_mouse_pos = false
	end

	if wasDesyncEnabled and Config.Desyncenabled then
		StartDesync()
	end
end

local function IsLocalPlayerDead()
	local character = LocalPlayer.Character
	if not character then return true end

	local humanoid = character:FindFirstChild("Humanoid")
	if not humanoid then return true end

	local bodyEffects = character:FindFirstChild("BodyEffects")
	if bodyEffects then
		local ko = bodyEffects:FindFirstChild("K.O")
		if ko and ko.Value then
			return true
		end
	end

	return humanoid.Health <= 0
end

local function RespawnPlayer()

	repeat wait() until LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

	LocalPlayer.Character:WaitForChild('Humanoid'):UnequipTools()
end

local function GetWeapon(killMethod)
	if killMethod == "Knife" then
		local equippedKnife = LocalPlayer.Character:FindFirstChild('[Knife]')
		if equippedKnife then
			return equippedKnife
		end

		local backpackKnife = LocalPlayer.Backpack:FindFirstChild('[Knife]')
		if backpackKnife then
			return backpackKnife
		end

		local Original_CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
		local Knife = workspace.Ignored.Shop.Others['[Knife] - $125']
		LocalPlayer.Character.HumanoidRootPart.CFrame = Knife.Head.CFrame * CFrame.new(0,3,0)
		repeat 
			wait(0.1)
			fireclickdetector(Knife.ClickDetector)
		until LocalPlayer.Backpack:FindFirstChild('[Knife]')
		LocalPlayer.Character.HumanoidRootPart.CFrame = Original_CFrame

		return LocalPlayer.Backpack:FindFirstChild('[Knife]')

	elseif killMethod == "Gun" then
		local character = LocalPlayer.Character
		if character then
			for _, tool in ipairs(character:GetChildren()) do
				if tool:IsA("Tool") then
					if tool.Name:match("%[.*%]") then
						return tool
					end
				end
			end
		end

		local gunTable = {
			"[TacticalShotgun]", "[Revolver]", "[Double Barrel SG]", "[AA12]", "[AUG]", "[Deagle]", 
			"[Drum Glock]", "[DrumGun]", "[Famas]", "[Flamethrower]", "[Flintlock]", "[Glock]", 
			"[Golden AK47]", "[Grenade Launcher]", "[Homing Launcher]", "[LMG]", "[R8]", "[RPG]", 
			"[Ray Gun]", "[SMG]", "[SSHG]", "[ScarH]", "[Silencer]", "[Sniper]", "[XM8]"
		}

		for _, gunName in ipairs(gunTable) do
			local gun = LocalPlayer.Backpack:FindFirstChild(gunName)
			if gun then
				return gun
			end
		end
		local Original_CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
		local Tact = workspace.Ignored.Shop.Guns['[TacticalShotgun] - $1300']
		LocalPlayer.Character.HumanoidRootPart.CFrame = Tact.Head.CFrame * CFrame.new(0,3,0)
		repeat 
			fireclickdetector(Tact.ClickDetector)
		until LocalPlayer.Backpack:FindFirstChild('[TacticalShotgun]')
		LocalPlayer.Character.HumanoidRootPart.CFrame = Original_CFrame

		return LocalPlayer.Backpack:FindFirstChild('[TacticalShotgun]')
	end
	return nil
end

local function SetupLoopKill()
	local KNOCK_MODE = Config.KillMethod or "Knife"
	wasDesyncEnabled = desyncRunning

	if KNOCK_MODE == "Knife" then
		local Knife = GetWeapon("Knife")

		local BodyV = Instance.new("BodyVelocity")
		BodyV.Velocity = Vector3.new(0,0,0)
		BodyV.MaxForce = Vector3.new(1e6,1e6,1e6)
		BodyV.Parent = LocalPlayer.Character.HumanoidRootPart

		Noclipping = RunService.Stepped:Connect(NoclipLoop)

		if Knife.Name == "[Knife]" then
			Knife.Handle.Size = Vector3.new(20,20,20)
			Knife.Handle.Transparency = 0.67
			Knife.Handle.MeshId = ""
			Knife.Handle.TextureID = ""
		end

		if Knife.Parent == LocalPlayer.Backpack then
			Knife.Parent = LocalPlayer.Character
		end

		return true

	elseif KNOCK_MODE == "Gun" then
		local Gun = GetWeapon("Gun")

		local BodyV = Instance.new("BodyVelocity")
		BodyV.Velocity = Vector3.new(0,0,0)
		BodyV.MaxForce = Vector3.new(1e6,1e6,1e6)
		BodyV.Parent = LocalPlayer.Character.HumanoidRootPart

		Noclipping = RunService.Stepped:Connect(NoclipLoop)

		if Gun.Parent == LocalPlayer.Backpack then
			Gun.Parent = LocalPlayer.Character
		end

		originalEnabled = Config.Enabled
		originalStickyTarget = Config.StickyTarget
		originalUseFov = Config.UseFov

		Config.Enabled = true
		Config.StickyTarget = true
		Config.UseFov = false
		if resolverEnabled then
			StartResolverTimer()
		end

		return true
	end

	return false
end




targeting:toggle({
	name = "loop kill",
	flag = "targeting_loop_kill",
	default = false,
	callback = function(value)
		if value then
			if #Config.MultiTargets == 0 then

				return
			end

			KillTestVarible = true
			killLoopActive = true
			currentTargetIndex = 1

			if not SetupLoopKill() then
				KillTestVarible = false
				killLoopActive = false

				return
			end

			local function saveTargetState()
				savedTargetState = {
					targetWasAlive = table.clone(targetWasAlive),
					currentTargetIndex = currentTargetIndex,
					ConfigMultiTargets = table.clone(Config.MultiTargets)
				}
			end

			local function restoreTargetState()
				if savedTargetState.targetWasAlive then
					targetWasAlive = savedTargetState.targetWasAlive
				end
				if savedTargetState.currentTargetIndex then
					currentTargetIndex = savedTargetState.currentTargetIndex
				end
				if savedTargetState.ConfigMultiTargets then
					Config.MultiTargets = savedTargetState.ConfigMultiTargets
				end
			end

			for _, name in ipairs(Config.MultiTargets) do
				targetWasAlive[name] = true
			end

			originalTargetList = table.clone(Config.MultiTargets)

			loopKillConnection = RunService.Heartbeat:Connect(function()
				if not KillTestVarible or not killLoopActive then
					return
				end

				if IsLocalPlayerDead() and not deathHandling then
					deathHandling = true

					pcall(function()
						if desyncRunning then StopDesync() end
						if Noclipping then Noclipping:Disconnect() Noclipping = nil end
					end)

					pcall(function()
						for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
							if part:IsA("BodyVelocity") then part:Destroy() end
						end
					end)

					task.spawn(function()
						LocalPlayer.Character:WaitForChild('Humanoid'):UnequipTools()
						LocalPlayer.CharacterAdded:Wait()

						repeat RunService.Heartbeat:Wait() 
						until LocalPlayer.Character 
							and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") 
							and LocalPlayer.Character:FindFirstChild("Humanoid")
							and LocalPlayer.Character.Humanoid.Health > 0

						task.wait(0.3)
						SetupLoopKill()
						task.wait(0.2)

						isReloading = false
						isShooting = false
						isStomping = false
						deathHandling = false

					end)

					return
				end

				if deathHandling then return end

				if isReloading then
					if tick() - reloadStartTime > 1 then
						isReloading = false
					end
					return
				end

				isShooting = false
				isStomping = false

				if not Config.MultiTargets or #Config.MultiTargets == 0 then
					return
				end

				if currentTargetIndex < 1 then currentTargetIndex = 1 end
				if currentTargetIndex > #Config.MultiTargets then
					currentTargetIndex = 1
				end

				local targetEntry = Config.MultiTargets[currentTargetIndex]
				if not targetEntry then
					currentTargetIndex = 1
					return
				end

				local targetName = GetUsernameFromEntry(targetEntry)

				local targetPlayer = Players:FindFirstChild(targetName)
				if not targetPlayer then
					if desyncRunning then StopDesync() end

					if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
						local currentPos = LocalPlayer.Character.HumanoidRootPart.Position
						local TP_Position = currentPos + Vector3.new(
							math.random(-999999, 999999),
							math.random(0, 999999),
							math.random(-999999, 999999)
						)
						pcall(function()
							LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(TP_Position)
						end)
					end

					currentTargetIndex = currentTargetIndex + 1
					if currentTargetIndex > #Config.MultiTargets then
						currentTargetIndex = 1
					end
					return
				end

				Config.target = targetPlayer
				local TargetCharacter = targetPlayer.Character
				if not TargetCharacter or not TargetCharacter.Parent then
					return
				end

				local targetRoot = TargetCharacter:FindFirstChild("HumanoidRootPart")
				local targetHumanoid = TargetCharacter:FindFirstChild("Humanoid")
				local targetHead = TargetCharacter:FindFirstChild("Head")

				if not targetRoot or not targetHumanoid or not targetHead then
					return
				end

				local hasForceField = TargetCharacter:FindFirstChildOfClass("ForceField")
				if hasForceField then
					local currentTime = tick()
					if currentTime - lastForceFieldWarning > 2 then

						lastForceFieldWarning = currentTime
					end

					if not desyncRunning then
						StartDesync()
					end

					if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
						local TP_Position = targetRoot.Position + Vector3.new(
							math.random(-999999, 999999),
							math.random(0, 999999),
							math.random(-999999, 999999)
						)
						pcall(function()
							LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(TP_Position)
						end)
					end

					return
				end
				local Ragdoll = TargetCharacter:FindFirstChild("RagdollConstraints")
				local hasRagdollConstraints = false

				if Ragdoll then
					local WaistRagdollConstraint = Ragdoll:FindFirstChild("WaistRagdollConstraint")
					hasRagdollConstraints = WaistRagdollConstraint ~= nil
				end
				if not hasRagdollConstraints then
					if not desyncRunning then
						StartDesync()
					end

					if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
						local TP_Position = targetRoot.Position + Vector3.new(
							math.random(-999999, 999999),
							math.random(0, 999999),
							math.random(-999999, 999999)
						)
						pcall(function()
							LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(TP_Position)
						end)
					end
					return
				end
				if not killGrabberState then
					local bodyEffects = TargetCharacter:FindFirstChild("BodyEffects")
					if not bodyEffects then return end

					local Grabber = bodyEffects:FindFirstChild("Grabber")
					local grabberPlayer = nil

					if Grabber and Grabber.Value ~= nil then
						local grabberName = Grabber.Value
						grabberPlayer = Players:FindFirstChild(grabberName)
						if grabberPlayer and grabberPlayer ~= LocalPlayer then
							saveTargetState()
							originalTargetEntry = targetEntry
							currentGrabbedTarget = targetPlayer
							killGrabberState = true
							hasOriginalTargetGrabbed = true

							Config.MultiTargets = {grabberPlayer.Name}
							currentTargetIndex = 1

							targetWasAlive = {}
							targetWasAlive[grabberPlayer.Name] = true

							targetPlayer = grabberPlayer
							TargetCharacter = targetPlayer.Character

							if not TargetCharacter or not TargetCharacter.Parent then
								restoreTargetState()
								killGrabberState = false
								hasOriginalTargetGrabbed = false
								return
							end

							targetRoot = TargetCharacter:FindFirstChild("HumanoidRootPart")
							targetHumanoid = TargetCharacter:FindFirstChild("Humanoid")
							targetHead = TargetCharacter:FindFirstChild("Head")

							if not targetRoot or not targetHumanoid or not targetHead then
								restoreTargetState()
								killGrabberState = false
								hasOriginalTargetGrabbed = false
								return
							end
						end
					end
				end

				local bodyEffects = TargetCharacter:FindFirstChild("BodyEffects")
				if not bodyEffects then 
					if killGrabberState then
						restoreTargetState()
						killGrabberState = false
						hasOriginalTargetGrabbed = false

					end
					return 
				end

				if killGrabberState then
					local Grabber = bodyEffects:FindFirstChild("Grabber")
					if not Grabber or Grabber.Value == nil then
						restoreTargetState()
						killGrabberState = false
						hasOriginalTargetGrabbed = false

						return
					end
				end
				local hasSkull = targetHead:FindFirstChild("Skull") ~= nil
				local isDead = targetHumanoid.Health <= 0

				if (hasSkull or isDead) then
					if killGrabberState then
						restoreTargetState()
						killGrabberState = false
						hasOriginalTargetGrabbed = false

						if originalTargetEntry then
							targetWasAlive[originalTargetEntry] = true
						end

						for i, name in ipairs(Config.MultiTargets) do
							if name == originalTargetEntry then
								currentTargetIndex = i
								break
							end
						end

						return
					else
						if targetWasAlive[targetEntry] then
							targetWasAlive[targetEntry] = false
						end

						if desyncRunning then StopDesync() end

						if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
							local currentPos = LocalPlayer.Character.HumanoidRootPart.Position
							local TP_Position = currentPos + Vector3.new(
								math.random(-999999, 999999),
								math.random(0, 999999),
								math.random(-999999, 999999)
							)
							pcall(function()
								LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(TP_Position)
							end)
						end

						currentTargetIndex = currentTargetIndex + 1
						if currentTargetIndex > #Config.MultiTargets then
							currentTargetIndex = 1

							for _, name in ipairs(Config.MultiTargets) do
								targetWasAlive[name] = true
							end
						end
						return
					end
				end

				if not hasSkull and not isDead and not targetWasAlive[targetEntry] then
					targetWasAlive[targetEntry] = true
				end

				local KOED = bodyEffects:FindFirstChild("K.O")
				if not KOED then return end

				local KNOCK_MODE = Config.KillMethod or "Knife"

				if KNOCK_MODE == "Knife" then
					if KOED.Value then
						isStomping = true
						if desyncRunning then StopDesync() end

						local upperTorso = TargetCharacter:FindFirstChild("UpperTorso")
						if upperTorso then
							pcall(function()
								LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(upperTorso.Position + Vector3.new(0, 1, 0))
							end)

							ReplicatedStorage.MainRemote:FireServer("Stomp")
						end
					else
						if not desyncRunning then StartDesync() end
						if LocalPlayer.Character:FindFirstChild('HoldingHighLight') then
							if desyncRunning then StopDesync() end
							TP_Position = targetRoot.Position + Vector3.new(0, -8.5, 0)
						else
							TP_Position = targetRoot.Position + Vector3.new(
								math.random(-999999, 999999),
								math.random(0, 999999),
								math.random(-999999, 999999)
							)
						end
						local Knife = LocalPlayer.Character:FindFirstChild('[Knife]')
						if not Knife then
							Knife = LocalPlayer.Backpack:FindFirstChild('[Knife]')
							if Knife then
								Knife.Parent = LocalPlayer.Character
								if Knife.Name == "[Knife]" then
									Knife.Handle.Size = Vector3.new(20, 20, 20)
									Knife.Handle.Transparency = 0.67
									Knife.Handle.MeshId = ""
									Knife.Handle.TextureID = ""
								end
							end
						end

						if Knife then
							isShooting = true
							Knife:Activate()
						end

						if not isShooting then
							pcall(function()
								LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(TP_Position)
							end)
						end
					end
				elseif KNOCK_MODE == "Gun" then
					lockedTarget = TargetCharacter
					locked = true
					lastValidTargetPlayer = targetPlayer

					-- basically lets u choose the gun u want to loop with
					local currentGun = nil
					for _, tool in ipairs(LocalPlayer.Character:GetChildren()) do
						if tool:IsA("Tool") and tool.Name:match("%[.*%]") then
							currentGun = tool
							break
						end
					end

					--gets random guns but it lowkey js uses tac so wtv
					if not currentGun then
						local gunNames = {
							"[TacticalShotgun]", "[Revolver]", "[Double Barrel SG]",
							"[Glock]", "[Silencer]", "[SMG]"
						}

						for _, gunName in ipairs(gunNames) do
							local gun = LocalPlayer.Backpack:FindFirstChild(gunName)
							if gun then
								gun.Parent = LocalPlayer.Character
								currentGun = gun
								break
							end
						end
					end
					--this is like the reload state
					if currentGun and currentGun:FindFirstChild("Ammo") then
						if currentGun.Ammo.Value < 1 then
							if not desyncRunning then
								StartDesync()
							end
							local TP_Position = targetRoot.Position + Vector3.new(
								math.random(-999999, 999999),
								math.random(0, 999999),
								math.random(-999999, 999999)
							)

							pcall(function()
								LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(TP_Position)
							end)

							ReplicatedStorage.MainRemote:FireServer("Reload")
							isReloading = true
							reloadStartTime = tick()
							return
						end
					end
					if KOED.Value then
						isStomping = true
						if desyncRunning then StopDesync() end

						local upperTorso = TargetCharacter:FindFirstChild("UpperTorso")
						if upperTorso then
							pcall(function()
								LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(upperTorso.Position + Vector3.new(0, 1.7, 0))
							end)

							ReplicatedStorage.MainRemote:FireServer("Stomp")
						end
					else
						if not desyncRunning then StartDesync() end
						if currentGun then
							isShooting = true
							is_setting_mouse_pos = true

							if resolverEnabled then
								ShootWithResolver(TargetCharacter, currentGun)
							else
								currentGun:Activate()
							end

							local TP_Position = targetRoot.Position + Vector3.new(0, 0, 5)
							pcall(function()
								LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(TP_Position)
							end)
						else
							local TP_Position = targetRoot.Position + Vector3.new(
								math.random(-999999, 999999),
								math.random(0, 999999),
								math.random(-999999, 999999)
							)
							pcall(function()
								LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(TP_Position)
							end)
						end
					end
				end
			end)

		else
			KillTestVarible = false
			killLoopActive = false

			if loopKillConnection then
				loopKillConnection:Disconnect()
				loopKillConnection = nil
			end

			StopLoopKill()
		end
	end
})
targeting:dropdown({
	name = "kill method",
	flag = "targeting_kill_method",
	items = {"Knife", "Gun"},
	default = "Knife",
	multi = false,
	callback = function(value)
		Config.KillMethod = value
	end
})

targeting:toggle({
	name = "resolver",
	flag = "targeting_resolver",
	default = false,
	callback = function(value)
		resolverEnabled = value
	end
})

targeting:slider({
	name = "forgiveness",
	flag = "targeting_forgiveness",
	default = 0.01,
	min = -5,
	max = 20,
	interval = 0.01,
	callback = function(value)
		predictionIncrement = value
	end
})

targeting:slider({
	name = "prediction reset",
	flag = "targeting_pred_reset",
	default = 5,
	min = 0.5,
	max = 10,
	interval = 0.5,
	callback = function(value)
		resetTimer = value
	end
})

targeting:button({
	name = "reset prediction",
	callback = function()
		ResetResolver()
	end
})

targeting:button({
	name = "fling target",
	callback = function()
		if Config.target then
			fling_Module.Fling(Config.Target)
		end
	end
})

local aimview_connections = {}
local aimview_beams = {}
local aimview_parts = {}

local function UpdateAimView()
	for _, conn in pairs(aimview_connections) do
		conn:Disconnect()
	end
	aimview_connections = {}

	for _, beam in pairs(aimview_beams) do
		beam:Destroy()
	end
	aimview_beams = {}

	for _, part in pairs(aimview_parts) do
		part:Destroy()
	end
	aimview_parts = {}

	if not flags["targeting_aim_view"] and not flags["targeting_aim_view_all"] then return end

	local playersToView = {}
	if flags["targeting_aim_view_all"] then
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= LocalPlayer then
				table.insert(playersToView, p)
			end
		end
	else
		for _, targetEntry in pairs(Config.MultiTargets) do
			local targetName = GetUsernameFromEntry(targetEntry)
			local targetPlayer = Players:FindFirstChild(targetName)
			if targetPlayer then
				table.insert(playersToView, targetPlayer)
			end
		end
	end

	for _, targetPlayer in ipairs(playersToView) do
		local targetName = targetPlayer.Name
		if targetPlayer and targetPlayer.Character then
			local character = targetPlayer.Character

			coroutine.wrap(function()
				repeat task.wait() until character:FindFirstChild("BodyEffects")

				local bodyEffects = character:WaitForChild("BodyEffects")
				local aiming = bodyEffects:WaitForChild("MousePos")

				if aiming then
					local beam = Instance.new('Beam', workspace)
					beam.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
					beam.Width0 = 0.25
					beam.Width1 = 0.25
					beam.FaceCamera = true
					beam.Name = 'Beam_' .. targetName

					local head = character:FindFirstChild("Head")
					if head then
						local faceAttachment = head:FindFirstChild("FaceCenterAttachment")
						if not faceAttachment then
							faceAttachment = Instance.new("Attachment", head)
							faceAttachment.Name = "FaceCenterAttachment"
							faceAttachment.Position = Vector3.new(0, 0, -0.5)
						end
						beam.Attachment0 = faceAttachment
					end

					local aimPart = Instance.new("Part", workspace)
					aimPart.CanCollide = false
					aimPart.CanTouch = false
					aimPart.CanQuery = false
					aimPart.Transparency = 1
					aimPart.Anchored = true
					aimPart.Size = Vector3.new(0, 0, 0)
					aimPart.Name = "AimPart_" .. targetName

					local aimAttachment = Instance.new("Attachment", aimPart)
					beam.Attachment1 = aimAttachment

					table.insert(aimview_beams, beam)
					table.insert(aimview_parts, aimPart)

					local conn = game:GetService("RunService").RenderStepped:Connect(function()
						if not character or not character.Parent then return end
						local humanoid = character:FindFirstChild("Humanoid")
						if not humanoid or humanoid.Health <= 0 then 
							beam.Enabled = false
							return 
						end

						local tool = character:FindFirstChildOfClass("Tool")
						local isVisible = false

						if tool and aiming and aiming.Value then
							-- Standard check for weapons in this game style
							if tool:FindFirstChild("Handle") or string.find(tool.Name, "[") then
								isVisible = true
								aimPart.Position = aiming.Value
							end
						end

						beam.Enabled = isVisible
					end)
					table.insert(aimview_connections, conn)
				end
			end)()
		end
	end
end

local aimViewToggle, aimViewAllToggle
local aimViewSyncing = false

aimViewToggle = targeting:toggle({
	name = "aim view",
	flag = "targeting_aim_view",
	default = false,
	callback = function(value)
		if aimViewSyncing then return end
		if value and aimViewAllToggle and flags["targeting_aim_view_all"] then
			aimViewSyncing = true
			aimViewAllToggle.enabled = false
			aimViewAllToggle:set(false)
			aimViewSyncing = false
		end
		UpdateAimView()
	end
})

aimViewAllToggle = targeting:toggle({
	name = "aim view all",
	flag = "targeting_aim_view_all",
	default = false,
	callback = function(value)
		if aimViewSyncing then return end
		if value and aimViewToggle and flags["targeting_aim_view"] then
			aimViewSyncing = true
			aimViewToggle.enabled = false
			aimViewToggle:set(false)
			aimViewSyncing = false
		end
		UpdateAimView()
	end
})

setup:dropdown({
	name = "type",
	flag = "aim_type",
	items = {"silent aim","cam lock"},
	default = "silent aim",
	multi = false,
	callback = function(value)
		aim_type = value
	end
})

setup:keybind({
	name = "keybind",
	flag = "aim_keybind",
	default = Enum.KeyCode.Q,
	callback = function(value)
		Config.AimKey = value
		BindKeybind()
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
	name = "smoothing",
	flag = "aim_smoothing",
	default = 1,
	min = 0.01,
	max = 1,
	interval = 0.01,
	callback = function(value)
		Config.Smoothing = value
	end
})

prediction:toggle({
	name = "use prediction",
	flag = "prediction_enabled",
	default = false,
	callback = function(value)
		use_pred = value
	end
})

prediction:slider({
	name = "prediction amount",
	flag = "prediction_amount",
	default = 0.125,
	min = 0,
	max = 2,
	interval = 0.01,
	callback = function(value)
		Config.Prediction = value
	end
})

prediction:toggle({
	name = "auto prediction",
	flag = "prediction_auto",
	default = false,
	callback = function(value)
		Config.AutoPrediction = value
	end
})

prediction:slider({
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

fov:colorpicker({
	name = "color",
	flag = "fov_color",
	default = Color3.fromRGB(255, 255, 255),
	callback = function(value)
		circle.Color = value
	end
})

aimpart:dropdown({
	name = "part",
	flag = "aimpart_part",
	items = {"Head","UpperTorso","HumanoidRootPart","LowerTorso","Closest Part"},
	default = "UpperTorso",
	multi = false,
	callback = function(value)
		Config.AimPart = value
	end
})

aimpart:toggle({
	name = "use closest point",
	flag = "closest_point_used",
	default = false,
	callback = function(value)
		Config.closestpoint = value
	end
})

resolver_section:toggle({
	name = "enabled",
	flag = "resolver_enabled",
	default = false,
	callback = function(value)
		Config.Resolver = value
		resolverEnabled = value
		if not value then
			ResetResolver()
			resolverPredictionDisplay.Visible = false
		end
	end
})

resolver_section:dropdown({
	name = "type",
	flag = "resolver_type",
	items = {"y velocity","x velocity","z velocity","no velocity"},
	default = "y velocity",
	multi = false
})

checks:toggle({
	name = "wall check",
	flag = "checks_wall",
	default = false,
	callback = function(value)
		Config.WallCheck = value
	end
})

checks:toggle({
	name = "knock check",
	flag = "checks_knock",
	default = false,
	callback = function(value)
		Config.KnockCheck = value
	end
})

orbitSection:toggle({
	name = "orbit",
	flag = "orbit_enabled",
	default = false,
	callback = function(value)
		Config.OrbitEnabled = value
		if value then
			if lockedTarget and lockedTarget.Parent then
				startOrbit()

			else
				Config.OrbitEnabled = false
			end
		else
			if Config.orbitLoop then
				Config.orbitLoop:Disconnect()
				Config.orbitLoop = nil
			end
		end
	end
})

orbitSection:slider({
	name = "distance",
	flag = "orbit_distance",
	default = 10,
	min = 3,
	max = 50,
	callback = function(value)
		Config.OrbitDistance = value
	end
})

orbitSection:slider({
	name = "height",
	flag = "orbit_height",
	default = 3,
	min = -10,
	max = 20,
	callback = function(value)
		Config.OrbitHeight = value
	end
})

orbitSection:slider({
	name = "speed",
	flag = "orbit_speed",
	default = 5,
	min = 1,
	max = 20,
	callback = function(value)
		Config.OrbitSpeed = value
	end
})

other:toggle({
	name = "velocity dot",
	flag = "misc_velocity_dot",
	default = false,
	callback = function(value)
		VisibleDot = value
	end
})



other:toggle({
	name = "hide mouse pos",
	flag = "misc_hide_mouse",
	default = false,
	callback = function(value)
		HideMousePos = value
	end
})

other:toggle({
	name = "desync",
	flag = "misc_desync",
	default = false,
	callback = function(value)
		Config.Desyncenabled = value
		if value then
			StartDesync()
		else
			StopDesync()
		end
	end
})

other:dropdown({
	name = "desync type",
	flag = "misc_desync_type",
	items = {"random", "void", "desync v2"},
	default = "random",
	multi = false,
	callback = function(value)
		Config.Mode = value
		if value == "desync v2" then
			Config.DesyncV2Enabled = true
		else
			Config.DesyncV2Enabled = false
		end
		if desyncRunning then
			StopDesync()
			task.wait(0.1)
			StartDesync()
		end
	end
})

other:slider({
	name = "release time",
	flag = "misc_release_time",
	default = 0.015,
	min = 0.001,
	max = 1,
	interval = 0.001,
	callback = function(value)
		Config.timeRelease = value
	end
})

other:slider({
	name = "choke time",
	flag = "misc_choke_time",
	default = 0.105,
	min = 0.001,
	max = 1,
	interval = 0.001,
	callback = function(value)
		Config.timeChoke = value
	end
})

other:slider({
	name = "vel max",
	flag = "misc_vel_max",
	default = 16384,
	min = 1000,
	max = 10000000,
	callback = function(value)
		Config.velMax = value
	end
})

tools:toggle({
	name = "autoarmor",
	flag = "tools_autoarmor",
	default = false,
	callback = function(value)
		Config.autoarmor = value
		if value then
			Config.autoarmor_loop = game:GetService("RunService").Heartbeat:Connect(function()
				if Config.autoarmor then
					autoarmor()
				end
			end)
		else
			if Config.autoarmor_loop then
				Config.autoarmor_loop:Disconnect()
				Config.autoarmor_loop = nil
			end
		end
	end
})

tools:slider({
	name = "armor threshold",
	flag = "tools_armor_threshold",
	default = 50,
	min = 0,
	max = 100,
	callback = function(value)
		Config.autoarmor_min = value
	end
})

streak:dropdown({
	name = "select tag",
	flag = "selectedtag",
	items = streaktags,
	default = game:GetService("Players").LocalPlayer.Information.Tag.Value,
	callback = function(value)
		if value ~= nil then
			game:GetService("Players").LocalPlayer.Information.Tag.Value = value
		end
	end,
})

streak:slider({
	name = "streak amount",
	flag = "streak_amount",
	default = LocalPlayer.Information.Streaks.Value,
	min = 0,
	max = 99999,
	callback = function(value)
		LocalPlayer.Information.Streaks.Value = tonumber(value)
	end
})

otherstuff:colorpicker({
	name = "bullet color",
	flag = "bullet_color",
	color = LocalPlayer.Information.RayColor.Value, -- FIXED
	callback = function(value)
		LocalPlayer.Information.RayColor.Value = value -- FIXED
	end
})


otherstuff:toggle({
	name = "dark chat",
	flag = "dark_chat",
	default = false,
	callback = function(value)
		LocalPlayer.Information.DarkChat.Value = value
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

AutoBuy:button({
	name = "buy",
	callback = function()
		tpbuy()
	end
})

AutoBuy:dropdown({
	name = "item type",
	flag = "autobuy_type",
	items = {'gun','armor','other'},
	default = 'gun',
	multi = false,
	callback = function(value)
		buy_type = value
	end
})

AutoBuy:dropdown({
	name = "guns",
	flag = "autobuy_guns",
	items = Guns_Table,
	multi = false,
	callback = function(value)
		gun_buy = value
	end
})

AutoBuy:dropdown({
	name = "armor",
	flag = "autobuy_armor",
	items = Armor_Table,
	multi = false,
	callback = function(value)
		armor_buy = value
	end
})

AutoBuy:dropdown({
	name = "other",
	flag = "autobuy_other",
	items = Other_Table,
	multi = false,
	callback = function(value)
		other_buy = value
	end
})

AutoBuy:keybind({
	name = "keybind",
	flag = "autobuy_keybind",
	default = Enum.KeyCode.B,
	callback = function(value)
		buy_bind = value
	end
})

teleports:button({
	name = "teleport",
	callback = function()
		cf = Tp_Places[tp_place]
		if cf then
			LocalPlayer.Character:MoveTo(cf.Position)
		end
	end
})

Tp_Places = {
	["bank"] = CFrame.new(-417.848694, 331.889954, -79.8929749, -0.0184935872, 7.89289203e-08, -0.999828994, -5.60497107e-08, 1, 7.99791593e-08, 0.999828994, 5.75192267e-08, -0.0184935872),
	["gun shop"] = CFrame.new(-549.428223, 317.115356, -509.083252, -0.99950099, 3.67034803e-09, -0.0315869525, 3.46313955e-09, 1, 6.61465061e-09, 0.0315869525, 6.50195986e-09, -0.99950099),
	["rev"] = CFrame.new(-629.677612, 332.172302, 92.2749939, -0.0505704395, 3.4613695e-08, 0.998720467, -3.28748442e-08, 1, -3.6322664e-08, -0.998720467, -3.46696325e-08, -0.0505704395),
	["school"] = CFrame.new(-640.900391, 330.757843, 482.60022, -0.999917567, -8.57108091e-08, -0.0128402347, -8.64896919e-08, 1, 6.01041492e-08, 0.0128402347, 6.12097395e-08, -0.999917567),
	['military'] = CFrame.new(-12.3546286, 334.385956, -692.423767, -0.983450592, 1.16787806e-08, -0.181176648, 1.18099868e-08, 1, 3.54583918e-10, 0.181176648, -1.79097803e-09, -0.983450592),
	['warehouse'] = CFrame.new(429.017548, 357.174347, 220.194519, -0.991522193, -4.14561967e-08, -0.129937485, -4.09012522e-08, 1, -6.93946411e-09, 0.129937485, -1.56602653e-09, -0.991522193),
	['armor'] = CFrame.new(553.478821, 359.405121, -429.045319, -0.0185577478, -1.7660311e-09, 0.999827802, -1.99242809e-08, 1, 1.39652179e-09, -0.999827802, -1.98949337e-08, -0.0185577478),
	['motel'] = CFrame.new(-920.361755, 343.3349, -282.502136, 0.999511182, 3.64311283e-08, 0.0312640108, -3.57107268e-08, 1, -2.36008955e-08, -0.0312640108, 2.24728964e-08, 0.999511182)
}

local placeList = {}
for name,_ in pairs(Tp_Places) do
	table.insert(placeList, name)
end

teleports:dropdown({
	name = "place",
	flag = "teleport_place",
	items = placeList,
	default = "bank",
	multi = false,
	callback = function(value)
		tp_place = value
	end
})

VelocityAnti:toggle({
	name = "enabled",
	flag = "velocity_anti_enabled",
	default = false,
	callback = function(value)
		anti_aim_connection = value
	end
})

VelocityAnti:textbox({
	name = "amount",
	flag = "velocity_anti_amount",
	default = "0,0,0",
	callback = function(value)
		local parts = string.split(value, ",")
		local x = tonumber(parts[1]) or 0
		local y = tonumber(parts[2]) or 0
		local z = tonumber(parts[3]) or 0
		anii_aim_vector = Vector3.new(x, y, z)
	end
})

ChatSection:toggle({
	name = "show chat",
	flag = "extra_show_chat",
	default = true,
	callback = function(value)
		local text_chat_service = game:GetService("TextChatService")
		local chat = LocalPlayer.PlayerGui:FindFirstChild("Chat")

		if chat and chat:FindFirstChild("Frame") then
			local frame = chat.Frame
			if frame:FindFirstChild("ChatChannelParentFrame") then
				frame.ChatChannelParentFrame.Visible = value
			end
			if frame:FindFirstChild("ChatBarParentFrame") then
				frame.ChatBarParentFrame.Position = value and UDim2.new(0, 0, 1, -44) or UDim2.new(0,0,0,0)
			end
		else
			pcall(function()
				text_chat_service.ChatWindowConfiguration.Enabled = value
			end)
		end
	end
})

local lighting = game:GetService("Lighting")

local lightingen = false

lightingtb:toggle({
	name = "lighting",
	flag = "lighting_enabled",
	default = false,
	callback = function(value)
		lightingen = value
		if not value then
			for property, val in pairs(Defaults.Lighting) do
				lighting[property] = val
			end
		end
	end
})

lightingtb:slider({
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

lightingtb:slider({
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

lightingtb:colorpicker({
	name = "ambient color",
	flag = "lighting_ambient",
	color = Defaults.Lighting.Ambient,
	callback = function(color)
		if lightingen then
			lighting.Ambient = color
		end
	end
})

lightingtb:colorpicker({
	name = "outdoor ambient",
	flag = "lighting_outdoor_ambient",
	color = Defaults.Lighting.OutdoorAmbient,
	callback = function(color)
		if lightingen then
			lighting.OutdoorAmbient = color
		end
	end
})

lightingtb:slider({
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

lightingtb:toggle({
	name = "global shadows",
	flag = "lighting_global_shadows",
	default = false,
	callback = function(value)
		if lightingen then
			lighting.GlobalShadows = value
		end
	end
})

lightingtb:slider({
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

lightingtb:colorpicker({
	name = "color shift top",
	flag = "lighting_color_shift_top",
	color = Defaults.Lighting.ColorShift_Top,
	callback = function(color)
		if lightingen then
			lighting.ColorShift_Top = color
		end
	end
})

lightingtb:colorpicker({
	name = "color shift bottom",
	flag = "lighting_color_shift_bottom",
	color = Defaults.Lighting.ColorShift_Bottom,
	callback = function(color)
		if lightingen then
			lighting.ColorShift_Bottom = color
		end
	end
})

lightingtb:slider({
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

lightingtb:slider({
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

lightingtb:slider({
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

skysettings:button({
	name = "remove skybox",
	callback = function()
		local sky = lighting:FindFirstChildOfClass("Sky")
		if sky then
			sky:Destroy()
		end
	end
})

local function ApplySkyboxPreset(name)
	local preset = SkyboxPresets[name]
	if not preset then return end

	local sky = lighting:FindFirstChildOfClass("Sky")
	if not sky then
		sky = Instance.new("Sky", lighting)
	end

	for property, value in pairs(preset) do
		sky[property] = value
	end
end

skysettings:dropdown({
	name = "skybox presets",
	flag = "sky_presets",
	items = (function()
		local keys = {}
		for k in pairs(SkyboxPresets) do table.insert(keys, k) end
		table.sort(keys)
		return keys
	end)(),
	default = "Default",
	callback = ApplySkyboxPreset
})

atmosphere_section:slider({
	name = "density",
	flag = "atm_density",
	default = 0.3,
	min = 0,
	max = 1,
	interval = 0.01,
	callback = function(v) atmosphere.Density = v end
})

atmosphere_section:slider({
	name = "offset",
	flag = "atm_offset",
	default = 0,
	min = 0,
	max = 1,
	interval = 0.01,
	callback = function(v) atmosphere.Offset = v end
})

atmosphere_section:colorpicker({
	name = "color",
	flag = "atm_color",
	color = Color3.fromRGB(199, 199, 199),
	callback = function(c) atmosphere.Color = c end
})

atmosphere_section:colorpicker({
	name = "decay",
	flag = "atm_decay",
	color = Color3.fromRGB(106, 106, 106),
	callback = function(c) atmosphere.Decay = c end
})

atmosphere_section:slider({
	name = "glare",
	flag = "atm_glare",
	default = 0,
	min = 0,
	max = 10,
	interval = 0.01,
	callback = function(v) atmosphere.Glare = v end
})

atmosphere_section:slider({
	name = "haze",
	flag = "atm_haze",
	default = 0,
	min = 0,
	max = 10,
	interval = 0.01,
	callback = function(v) atmosphere.Haze = v end
})

local function UpdateWeather(type, enabled)
	if weather_particle then weather_particle:Destroy() end
	if not enabled then return end

	if not weather_part then
		weather_part = Instance.new("Part", workspace)
		weather_part.Name = "WeatherPart"
		weather_part.Anchored = true
		weather_part.CanCollide = false
		weather_part.CanQuery = false
		weather_part.CanTouch = false
		weather_part.Transparency = 1
		weather_part.Size = Vector3.new(200, 1, 200)

		RunService.RenderStepped:Connect(function()
			if weather_part and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
				weather_part.Position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 50, 0)
			end
		end)
	end

	local props = weather_types[type]
	if props then
		local particle = Instance.new("ParticleEmitter", weather_part)
		for property, value in pairs(props) do
			particle[property] = value
		end
		weather_particle = particle
	end
end

local current_weather = "rain"
local weather_enabled = false

weather_section:dropdown({
	name = "weather type",
	flag = "weather_type",
	items = {"rain", "snow", "light rain"},
	default = "rain",
	callback = function(v)
		current_weather = v
		UpdateWeather(current_weather, weather_enabled)
	end
})

weather_section:toggle({
	name = "enable weather",
	flag = "weather_enabled",
	default = false,
	callback = function(v)
		weather_enabled = v
		UpdateWeather(current_weather, weather_enabled)
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
window.toggle_list(false)

ui_section:toggle({
	name = "watermark",
	flag = "ui_watermark",
	default = false,
	callback = function(bool)
		window.toggle_watermark(bool)
	end
})
window.toggle_watermark(false)

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


library:config_list_update()

UpdateTargetList()
window.toggle_playerlist(false)

-- Silent Autoload: detect before open_tab so menu never flashes visible
local _autoload_dir = library.directory .. "/autoload.cfg"
local _configs_dir = library.directory .. "/configs/"
local _isSilentLoad = false

if isfile(_autoload_dir) then
	local _configName = readfile(_autoload_dir)
	if _configName and _configName ~= "" and isfile(_configs_dir .. _configName .. ".cfg") then
		library:load_config(readfile(_configs_dir .. _configName .. ".cfg"))
		_isSilentLoad = true
	end
end

-- Always call open_tab (required to init UI tab state)
Main.open_tab()

-- Hide menu immediately after if this was a silent load
if _isSilentLoad then
	window.set_menu_visibility(false)
end
