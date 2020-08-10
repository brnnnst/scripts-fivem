local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
----------------------------------------------------------------------------
-- CONEÇÃO
----------------------------------------------------------------------------
emP = {}
Tunnel.bindInterface("arsenal",emP)
----------------------------------------------------------------------------
-- WEBHOOK
----------------------------------------------------------------------------
local webhookarsenal = "SUA-WEEBHOOK-AQUI"

function SendWebhookMessage(webhook,message)
    if webhook ~= nil and webhook ~= "" then
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
    end
end
---------------------------------------------------------------------------
-- Arma e munições, quantidade e preço de drop
---------------------------------------------------------------------------
local valores = {
	--Armas
	{ item = "wbody|WEAPON_COMBATPISTOL", nome = "Glock", quantidade = 1, compra = 0, venda = 0 }, -- GLOCK
	{ item = "wbody|WEAPON_SMG", nome = "Mp5", quantidade = 1, compra = 0, venda = 0 }, -- MP5
	{ item = "wbody|WEAPON_SPECIALCARBINE", nome = "Parafal", quantidade = 1, compra = 0, venda = 0 }, --parafal
	{ item = "wbody|WEAPON_PUMPSHOTGUN_MK2", nome = "Remington", quantidade = 1, compra = 0, venda = 0 }, -- REMINGTON
	{ item = "wbody|WEAPON_CARBINERIFLE", nome = "M4A1", quantidade = 1, compra = 0, venda = 0 }, -- M4A1
	--Munições
	{ item = "wammo|WEAPON_COMBATPISTOL", nome = "m. glock", quantidade = 250, compra = 0, venda = 0 }, -- GLOCK
	{ item = "wammo|WEAPON_SMG", nome = "m. mp5", quantidade = 250, compra = 0, venda = 0 }, -- MP5
	{ item = "wammo|WEAPON_SPECIALCARBINE", nome = "m. parafal", quantidade = 250, compra = 0, venda = 0 }, --parafal
	{ item = "wammo|WEAPON_PUMPSHOTGUN_MK2", nome = "m. remington", quantidade = 250, compra = 0, venda = 0 }, -- REMINGTON
	{ item = "wammo|WEAPON_CARBINERIFLE", nome = "m. m4a1", quantidade = 250, compra = 0, venda = 0 }, -- M4A1
	--Utilidades
	{ item = "radio", nome = "radio", quantidade = 1, compra = 0, venda = 0 },
	{ item = "colete", nome = "colete", quantidade = 1, compra = 0, venda = 0 },
	{ item = "wbody|WEAPON_STUNGUN", nome = "Tazer", quantidade = 1, compra = 0, venda = 0 }, -- TAZER
	{ item = "wbody|WEAPON_FIREEXTINGUISHER", nome = "Extintor", quantidade = 1, compra = 0, venda = 0 }, -- EXTINTOR
	{ item = "wbody|WEAPON_FLASHLIGHT", nome = "Lanterna", quantidade = 1, compra = 0, venda = 0 }, -- LANTERNA
	{ item = "wbody|WEAPON_NIGHTSTICK", nome = "Cassetete", quantidade = 1, compra = 0, venda = 0 }, -- CASSETETE
	{ item = "wbody|WEAPON_BZGAS", nome = "Granada de Gas", quantidade = 1, compra = 0, venda = 0 }, -- GRANADA DE GAS

}
-------------------------------------------------------------------------
-- Comando
-------------------------------------------------------------------------
RegisterServerEvent("arsenal-comprar")
AddEventHandler("arsenal-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
					if vRP.tryPayment(user_id,parseInt(v.compra)) then
						vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
						TriggerClientEvent("Notify",source,"sucesso","Arma retirada com sucesso!</b>.")
						SendWebhookMessage(webhookarsenal,"```prolog\n[PASSAPORTE]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[PEGAU A ARMA]: "..v.nome.." \n[QUANTIDADE]: "..v.quantidade.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
					end
				else
					TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
				end
			end
		end
	end
end)
------------------------------------------------------------------------
-- Itens com permissão
------------------------------------------------------------------------
RegisterServerEvent("comando-comprar")
AddEventHandler("comando-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.hasPermission(user_id,"admin.permissao") then
				    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
					    if vRP.tryPayment(user_id,parseInt(v.compra)) then
						    vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
							TriggerClientEvent("Notify",source,"sucesso","Arma retirada com sucesso!</b>.")
							SendWebhookMessage(webhookarsenal,"```prolog\n[PASSAPORTE]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[PEGAU A ARMA]: "..v.item.." \n[QUANTIDADE]: "..v.quantidade.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					    else
						    TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
					    end
				    else
					    TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
					end
				else
					TriggerClientEvent("Notify",source,"negado","Você não possui permissão para poder pegar está arma.")
				end
			end
		end
	end
end)
---------------------------------------------------------------------------------------
-- Verificar permissão
---------------------------------------------------------------------------------------
function emP.checkPermissao()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"policia.permissao") then
		return true
	else
		TriggerClientEvent("Notify",source,"negado","Você não possui Permissão para acessar o painel.") 
		return false
    end
end