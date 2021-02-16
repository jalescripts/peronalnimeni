ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

function darkboy()

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
  'default', GetCurrentResourceName(), 'civilian_actions',
  {
		title    = 'Licni Dokumenti | 📄',
		elements = {
      {label = 'Pogledaj Ličnu Kartu | 💳', value = 'plicnu'},
      {label = 'Pokaži Ličnu Kartu | 💳', value = 'policnu'},
      {label = 'Pogledaj Vozačku Dozvolu | 🚗', value = 'pvozacku'},
      {label = 'Pokaži Vozačku Dozvolu | 🚗', value = 'povozacku'},
      {label = 'Pogledaj Dozvolu za oružije | 🔫', value = 'poruzije'},
      {label = 'Pokaži Dozvolu za oružije | 🔫', value = 'pooruzije'},
		}
	},
    
    function(data, menu)
	local val = data.current.value

		if val == 'plicnu' then
      TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
		elseif val == 'pvozacku' then
			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
		elseif val == 'poruzije' then
			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
		else
			local player, distance = ESX.Game.GetClosestPlayer()
			
			if distance ~= -1 and distance <= 3.0 then
				if val == 'policnu' then
        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
				elseif val == 'povozacku' then
			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
				elseif val == 'pooruzije' then
			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapon')
				end
			else
			  ESX.ShowNotification('Nema igraca u blizini')
			end
		end
	end,
	function(data, menu)
		menu.close()
	end
)
end

RegisterNetEvent("darkboy:otvoridokumente")
AddEventHandler("darkboy:otvoridokumente", function()
      darkboy()
end)