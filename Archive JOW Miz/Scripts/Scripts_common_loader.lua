-- INSTRUCTIONS
-- In the DCS mission do a single trigger, time more (1) that does a DO SCRIPT event
-- Paste this code into the DO SCRIPT:
-- assert(loadfile("C:/HypeMan/Scripts_common_loader.lua"))()

-- Script File Versions
-- MOOSE GITHUB Commit Hash ID: 2022-06-08T18:24:31
-- Mist version 4.3.74
-- HypeMan version II.0
-- Airboss and Spawn scripts no version

scriptPath = "C:\\Hypeman\\"
local theatre = env.mission.theatre
assert(loadfile(scriptPath.."private_api_keys.lua"))()
env.info(theatre)
env.info(SERVERNAME)
local year = env.mission.date.Year

USE_SWAPR = true

assert(loadfile(scriptPath.."mist.lua"))()
assert(loadfile(scriptPath.."MooseOldJOW.lua"))()
assert(loadfile(scriptPath.."HypeMan_flightlog.lua"))()


if theatre == "Caucasus" then
assert(loadfile(scriptPath.."ScriptsBlackSea.lua"))()
assert(loadfile(scriptPath.."SpawnsBlackSea.lua"))()
assert(loadfile(scriptPath.."Scripts_common_carrierSpawns.lua"))()

elseif theatre == "PersianGulf" then
assert(loadfile(scriptPath.."ScriptsPG.lua"))()
assert(loadfile(scriptPath.."SpawnsPG.lua"))()
assert(loadfile(scriptPath.."Scripts_common_carrierSpawns.lua"))()

elseif theatre == "Nevada" then
assert(loadfile(scriptPath.."ScriptsNellis.lua"))()

elseif theatre == "MarianaIslands" then
assert(loadfile(scriptPath.."ScriptsMIslands.lua"))()
assert(loadfile(scriptPath.."SpawnsMI.lua"))()
assert(loadfile(scriptPath.."Scripts_common_carrierSpawns.lua"))()

elseif theatre == "Falklands" then
assert(loadfile(scriptPath.."ScriptsFalklands.lua"))()
assert(loadfile(scriptPath.."SpawnsFalklands.lua"))()
assert(loadfile(scriptPath.."Scripts_common_carrierSpawns.lua"))()
end


if SERVERNAME == "1CAG Backup" then
 assert(loadfile(scriptPath.."Scripts_common_atis.lua"))()
 elseif SERVERNAME == "1CAG - WHISKEY" then
 assert(loadfile(scriptPath.."Scripts_common_atis.lua"))()
 elseif SERVERNAME == "1CAG - EASY" then
 assert(loadfile(scriptPath.."Scripts_common_atis.lua"))()
 elseif SERVERNAME == "1CAG - ABLE" then
 assert(loadfile(scriptPath.."Scripts_common_atis.lua"))()
 end


if USE_SWAPR and theatre ~= "Falklands" then 
function RunSWAPR(ourArgument, time)			
	assert(loadfile(scriptPath.."Scripts_common_swapr.lua"))()
   return nil
end
timer.scheduleFunction(RunSWAPR, 1, timer.getTime() + 15)
end

