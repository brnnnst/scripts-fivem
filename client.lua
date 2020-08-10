-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

emP = Tunnel.getInterface("arsenal")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	   
	--Armas
	if data == "utilidades-comprar-glock" then
		TriggerServerEvent("arsenal-comprar","wbody|WEAPON_COMBATPISTOL")
		TriggerServerEvent("arsenal-comprar","wammo|WEAPON_COMBATPISTOL")
	elseif data == "utilidades-comprar-mp5" then
		TriggerServerEvent("arsenal-comprar","wbody|WEAPON_SMG")
		TriggerServerEvent("arsenal-comprar","wammo|WEAPON_SMG")
	elseif data == "utilidades-comprar-parafal" then
		TriggerServerEvent("arsenal-comprar","wbody|WEAPON_SPECIALCARBINE")
		TriggerServerEvent("arsenal-comprar","wammo|WEAPON_SPECIALCARBINE")
	elseif data == "utilidades-comprar-remington" then
		TriggerServerEvent("arsenal-comprar","wbody|WEAPON_PUMPSHOTGUN_MK2")
		TriggerServerEvent("arsenal-comprar","wammo|WEAPON_PUMPSHOTGUN_MK2")
	elseif data == "utilidades-comprar-m4a1" then
		TriggerServerEvent("arsenal-comprar","wbody|WEAPON_CARBINERIFLE")
		TriggerServerEvent("arsenal-comprar","wammo|WEAPON_CARBINERIFLE")


	-- Utilidades
	elseif data == "utilidades-comprar-radio" then
		TriggerServerEvent("arsenal-comprar","radio")
	elseif data == "utilidades-comprar-colete" then
		TriggerServerEvent("arsenal-comprar","colete")
	elseif data == "utilidades-comprar-tazer" then
		TriggerServerEvent("arsenal-comprar","wbody|WEAPON_STUNGUN")
	elseif data == "utilidades-comprar-extintor" then
		TriggerServerEvent("arsenal-comprar","wbody|WEAPON_FIREEXTINGUISHER")
	elseif data == "utilidades-comprar-lanterna" then
		TriggerServerEvent("arsenal-comprar","wbody|WEAPON_FLASHLIGHT")
	elseif data == "utilidades-comprar-cassetete" then
		TriggerServerEvent("arsenal-comprar","wbody|WEAPON_NIGHTSTICK")
	elseif data == "utilidades-comprar-gaz" then
		TriggerServerEvent("comando-comprar","wbody|WEAPON_BZGAS")
	
	--Fechar
	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS(Altere se necessário)
-----------------------------------------------------------------------------------------------------------------------------------------
local marcacoes = {
	{ 458.36,-979.48,30.68 },
	{ -1106.35,-825.77,14.29 },
}

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(5)
		for _,mark in pairs(marcacoes) do
			local x,y,z = table.unpack(mark)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
			if distance <= 1.0 then
				--Forma e cor do blip
				DrawMarker(23,x,y,z-0.93,0,0,0,0.0,0,0,0.5,0.5,0.4,0,0,0,50,0,0,0,1)
				if IsControlJustPressed(0,38) and emP.checkPermissao() then
					ToggleActionMenu()
				end
			end
		end
	end
end)