local Models = {}

CreateThread(function()
	TriggerServerEvent('cdimage-loader:Load')
end)

RegisterNetEvent('cdimage-loader:LoadTable', function(name)
	table.insert(Models, name)
end)

RegisterNetEvent('cdimage-loader:LoadModels', function()
    for i, v in pairs(Config.ModelNames) do
        TriggerEvent('cdimage-loader:LoadTable', v)
	end
	if Config.Debug then
		print("Start loading animals...\n")
	end
	for i, model in ipairs(Models) do
		if not IsModelInCdimage(model) and IsModelValid(model) then
			if Config.Debug then
				print(model .. " hasn't been found (model name isn't the same as the folder name or mispelled in \"Config.ModelNames\").")
			end
		else
			RequestModel(model)
			repeat
				if Config.Debug then
					print("Loading " .. model.."...")
				end
				Wait(500)
			until HasModelLoaded(model)

			if HasModelLoaded(model) then
				if Config.Debug then
					print(model .. " is loaded.\n")
				end
			end
			SetModelAsNoLongerNeeded(model)
		end
	end
	if Config.Debug then
		print("All addon animals are loaded!")
	end
end)