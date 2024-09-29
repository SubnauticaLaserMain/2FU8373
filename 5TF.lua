repeat
	task.wait(0.2)
until (game:IsLoaded() or game:GetService("RunService"):IsRunning())


local function GetAPI_Placement()
	local a, b = pcall(function()
		local C = game:GetService("RobloxReplicatedStorage")

		if C.ClassName == 'RobloxReplicatedStorage' then
			return C
		end
	end)

	if a and b then
		return b
	end


	a, b = pcall(function()
		local C = game:GetService("CorePackages")


		if C.ClassName == 'CorePackages' then
			return C
		end
	end)

	if a and b then
		return b
	end



	a, b = pcall(function()
		local C = game:GetService("CoreGui")

		if C.ClassName == 'CoreGui' then
			return C
		end
	end)

	if a and b then
		return b
	end



	a, b = pcall(function()
		local G = game:GetService("StarterGui")


		if G and G.ClassName == 'StarterGui' then
			return G
		end
	end)

	if a and b then
		return b
	end


	a, b = pcall(function()
		local S = game:GetService("StarterPack")


		if S and S.ClassName == 'StarterPack' then
			return S
		end
	end)


	if a and b then
		return b
	end


	error('Your Executor is Hot Garbadge, cant even find a placement lol')
end


local placement = GetAPI_Placement()


local function genRandomName(length)
	local characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	local key = ""

	for i = 1, length do
		local randomIndex = math.random(1, #characters)
		key = key .. characters:sub(randomIndex, randomIndex)
	end

	return key
end


if shared.IsAPILoaded == true and shared.Name then
	placement:FindFirstChild(shared.Name):Destroy()
	print('API Is Already loaded in the CoreGui!')
end



shared.Name = genRandomName(20)
shared.IsAPILoaded = true







local function GiveOwnGlobals(Func, Script)
	local Fenv = {}
    local RealFenv = {script = Script}
    local FenvMt = {}
    function FenvMt:__index(b)
        if RealFenv[b] == nil then
            return getfenv()[b]
        else
            return RealFenv[b]
        end
    end
	
	function FenvMt:__newindex(b, c)
        if RealFenv[b] == nil then
            getfenv()[b] = c
        else
            RealFenv[b] = c
        end
    end
        
	setmetatable(Fenv, FenvMt)

	print(Func, Fenv)

	print(Func, Fenv)

    setfenv(Func, Fenv)

    return Func
end


function loadScript(script)
	if script then
		if typeof(script) == 'Instance' and (script.ClassName == 'LocalScript' or script.ClassName == 'Script') then
			local Func = assert(loadstring(script.Source, '=' .. script:GetFullName()))
			print(tostring(Func), tostring(script))
			local OwnGlobal = GiveOwnGlobals(Func, script);


			PerformScriptSourceCleanup(script)

			return task.spawn(OwnGlobal)
		end
	end
end


function PerformScriptSourceCleanup(script)
	if script then
		if typeof(script) == 'Instance' and (script.ClassName == 'LocalScript' or script.ClassName == 'Script') then
			script.Source = ''
		end
	end
end




local API_Folder = Instance.new("Folder", placement)
API_Folder.Name = shared.Name

local BreakIn2_Lobby = Instance.new("Folder", API_Folder)
BreakIn2_Lobby.Name = 'BreakIn2-Lobby'


local GiveRoleEventFunction = Instance.new("BindableEvent", BreakIn2_Lobby)
GiveRoleEventFunction.Name = 'EquipRole'


local BreakIn2_Components = Instance.new("Folder", API_Folder)
BreakIn2_Components.Name = 'BreakIn2_Components'


local GetEventsFolder = Instance.new("BindableFunction", BreakIn2_Components)
GetEventsFolder.Name = 'GetEventsFolder'




local BreakIn2_Controllers = Instance.new("Folder", BreakIn2_Components)
BreakIn2_Controllers.Name = 'Controllers'




local GetEventsFolderController = Instance.new("Script", BreakIn2_Controllers)
GetEventsFolderController.Name = 'GetEventsFolderController'
GetEventsFolderController.Source = [[
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = script.Parent.Parent:WaitForChild('GetEventsFolder')


Remote.OnInvoke = function()
	local Folder = nil


	if game.PlaceId == 13864661000 then
		Folder = ReplicatedStorage:WaitForChild('RemoteEvents')
	else
		Folder = ReplicatedStorage:WaitForChild('Events')
	end

	return Folder
end
]]

loadScript(GetEventsFolderController)




local GiveRoleController = Instance.new("LocalScript", BreakIn2_Controllers)
GiveRoleController.Name = 'GiveRoleController'
GiveRoleController.Source = [[
local EventsFolder = script.Parent.Parent:WaitForChild('GetEventsFolder'):Invoke()


script.Parent.Parent.Parent:WaitForChild('BreakIn2-Lobby').EquipRole.Event:Connect(function(role)
	local RoleSortingByNames = {
		['The Hyper'] = {'Lollipop', true, false},
		['The Sporty'] = {'Bottle', true, false},
		['The Nerd'] = {'Book', true, false},
		
		['The Protector'] = {'Bat', false, false},
		['The Medic'] = {'MedKit', false, false},
		['The Hacker'] = {'Phone', false, false},
	}


	if role == 'The Hacker' then
		local o = RoleSortingByNames[role]

		EventsFolder:WaitForChild('OutsideRole'):FireServer(table.unpack({
			[1] = o[1],
			[2] = o[3]
		}))
	end

	EventsFolder:WaitForChild('MakeRole'):FireServer(table.unpack(RoleSortingByNames[role]))
end)
]]

loadScript(GiveRoleController)



local API_SourceFiles = Instance.new("Folder", API_Folder)
API_SourceFiles.Name = 'API-SourceFiles'



local ControllersForAPI_Sources = Instance.new("Folder", API_SourceFiles)
ControllersForAPI_Sources.Name = 'API-SourceScripts'



local FireMouseButton1Down = Instance.new("BindableEvent", API_SourceFiles)
FireMouseButton1Down.Name = 'FireMouseButton1Down'



local FireMouseButton1DownCoreScript = Instance.new("Script", ControllersForAPI_Sources)
FireMouseButton1DownCoreScript.Name = 'API-CoreScript/FireMouseButton'
FireMouseButton1DownCoreScript.Source = [[
local VirtualInputManager = game:GetService("VirtualInputManager")
local UserInputService = game:GetService("UserInputService")


script.Parent.Parent:WaitForChild('FireMouseButton1Down').Event:Connect(function(button)
	if button and typeof(button) == 'Instance' and (button.ClassName == 'TextButton' or button.ClassName == 'ImageButton') then
		local buttonPosition = button.AbsolutePosition
    	local buttonSize = button.AbsoluteSize

		local clickPosition = buttonPosition + (buttonSize / 2)


		
		local platform = UserInputService:GetPlatform()

		if (platform == Enum.Platform.Windows or platform == Enum.Platform.UWP) and UserInputService.MouseEnabled == true then
			VirtualInputManager:SendMouseButtonEvent(clickPosition.X, clickPosition.Y, 0, true, game, 0)
			VirtualInputManager:SendMouseButtonEvent(clickPosition.X, clickPosition.Y, 0, false, game, 0)
		end

		if (platform == Enum.Platform.IOS or platform == Enum.Platform.Android) then
			VirtualInputManager:SendTouchEvent({clickPosition}, {Enum.UserInputState.Begin}, false)

			task.wait(0.1)


			VirtualInputManager:SendTouchEvent({clickPosition}, {Enum.UserInputState.End}, false)
		end
	end
end)
]]

loadScript(FireMouseButton1DownCoreScript)




local TexturesForBreakIn2 = Instance.new("BindableFunction", API_SourceFiles)
TexturesForBreakIn2.Name = 'BreakIn2-New-Textures'



local TextureManager = Instance.new("LocalScript", ControllersForAPI_Sources)
TextureManager.Name = 'BreakIn2-HTTP-TextureManager'
TextureManager.Source = [[
local HttpService = game:GetService("HttpService")


script.Parent.Parent:WaitForChild('BreakIn2-New-Textures').OnInvoke = function()
	local TexturesJSON = HttpService:JSONDecode(game:HttpGet('https://raw.githubusercontent.com/ffunnybro/BlueBat/refs/heads/main/bluebat.json'))

	return TexturesJSON
end
]]

loadScript(TextureManager)



getgenv().SecureMode = true
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()



local Keys = game:GetService('HttpService'):JSONDecode(game:HttpGet('https://raw.githubusercontent.com/ffunnybro/key/refs/heads/main/IU2U90823089U8398U98%20SD738IYHD8WSE87U8923.json'))



local KeysTable = {}



for i, v in Keys['keys'] do
	-- print(i, v)
	table.insert(KeysTable, v)
end



local Players = game:GetService("Players")
local lplr = Players:GetPlayers()[1] or Players.LocalPlayer


local isKeySystemEnabled = true


if lplr and lplr.UserId == 1954895908 then
	isKeySystemEnabled = false
end




local Window = Rayfield:CreateWindow({
	Name = "Rayfield Example Window",
	LoadingTitle = "Rayfield Interface Suite",
	LoadingSubtitle = "by Sirius",
	ConfigurationSaving = {
	   Enabled = true,
	   FolderName = nil, -- Create a custom folder for your hub/game
	   FileName = "Big Hub"
	},
	--Discord = {
	--   Enabled = false,
	--   Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
	--   RememberJoins = true -- Set this to false to make them join the discord every time they load it up
	--},
	KeySystem = isKeySystemEnabled, -- Set this to true to use our key system
	KeySettings = {
	   Title = "Key System",
	   Subtitle = "",
	   Note = "Speak to a Manager LOL",
	   FileName = "NothingHere", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
	   SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
	   GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
	   Key = KeysTable -- {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
	}
 })




if lplr and lplr.UserId == 1954895908 then
	local AdminPanelTab = Window:CreateTab('Admin Panel')


	local amountOfKeys = 20
	local amountPerKey = 40


	AdminPanelTab:CreateButton({
		Name = 'Generate Keys JSON (Generate Keys for Key System)',
		Callback = function()
			local function generateKey(length)
				local characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
				local key = ""

				for i = 1, length do
					local randomIndex = math.random(1, #characters)
					key = key .. characters:sub(randomIndex, randomIndex)
				end

				return key
			end

			-- Example usage:


			local JSONScript = [[{"keys":[]]

			for i = 0, amountOfKeys do
				local generatedKey = generateKey(amountPerKey)
			--	print("Generated Key: " .. generatedKey)
				
				
				if i == amountOfKeys then
					JSONScript = JSONScript .. '\n "' .. generatedKey .. '"'
					break
				end
				JSONScript = JSONScript .. '\n "' .. generatedKey .. '",'
			end

			JSONScript = JSONScript .. "\n]}"

		--	print('setting clipboard: ' .. JSONScript)
			setclipboard(JSONScript)
		end
	})


	AdminPanelTab:CreateSection('Key Settings')


	AdminPanelTab:CreateSlider({
		Name = 'Amount of Keys',
		Range = {1, 1000},
		Increment = 1,
		CurrentValue = 20,
		Callback = function(val)
			amountOfKeys = val
		end
	})

	AdminPanelTab:CreateSlider({
		Name = 'Lenght Per Key',
		Range = {1, 100},
		Increment = 1,
		CurrentValue = 20,
		Callback = function(val)
			amountPerKey = val
		end
	})
end



local function ReplaceMeshPart(MeshToCopy, newMeshID)
	local AssetService = game:GetService("AssetService")
end


--- Break In 2 - Lobby
if game.PlaceId == 13864661000 then
	local RolesTab = Window:CreateTab('Roles')
	local ItemsTab = Window:CreateTab('Items')	


	local Roles = {'The Hyper', 'The Sporty', 'The Nerd', 'The Protector', 'The Medic', 'The Hacker'}


	for i, v in pairs(Roles) do
		if i and v then
			RolesTab:CreateButton({
				Name = v,
				Callback = function()
					local EquipRole = placement:WaitForChild(shared.Name):WaitForChild('BreakIn2-Lobby').EquipRole

					EquipRole:Fire(v)
				end
			})
		end
	end


	ItemsTab:CreateToggle({
		Name = 'Applie New Textures',
		CurrentValue = false,
		Flag = 'BreakIn2-NewTextures',
		Callback = function(val)
			local textures = placement:WaitForChild(shared.Name):WaitForChild('API-SourceFiles'):WaitForChild('BreakIn2-New-Textures'):Invoke()
			

			-- print(textures)


			--for i, v in textures['BreakIn2'] do
			--	print(i, v)
			--end


			if val == true then
				for i, v in ipairs(game:GetService("Players").LocalPlayer:WaitForChild('Backpack'):GetChildren()) do
					local texture = textures['BreakIn2'][v.Name]

					if texture then
						local meshPart = v:FindFirstChildOfClass('MeshPart')
						local ItemsInside 

						
						if meshPart then
							return
						end

						local spesialMesh = v:WaitForChild('Handle'):FindFirstChildOfClass('SpecialMesh')


						for a, b in texture do
							print(a, b)
						end

						if spesialMesh then
							spesialMesh.MeshId = texture['Mesh']
							spesialMesh.TextureId = texture['Texture']

							return
						end
					end
				end


				for i, v in ipairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
					local texture = textures['BreakIn2'][v.Name]

					if texture and v.ClassName == 'Tool' then
						local meshPart = v:FindFirstChildOfClass('MeshPart')
						local ItemsInside 

						
						if meshPart then
							return
						end

						local spesialMesh = v:WaitForChild('Handle'):FindFirstChildOfClass('SpecialMesh')


						for a, b in texture do
							print(a, b)
						end

						if spesialMesh then
							spesialMesh.MeshId = texture['Mesh']
							spesialMesh.TextureId = texture['Texture']

							return
						end
					end
				end
			end
		end
	})
end


-- loadstring(game:HttpGet('https://raw.githubusercontent.com/SubnauticaLaserMain/2FU8373/refs/heads/main/5TF.lua', true))()
