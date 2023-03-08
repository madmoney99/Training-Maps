-- INSTRUCTIONS
-- In the DCS mission do a single trigger, time more (1) that does a DO SCRIPT event
-- Paste this code into the DO SCRIPT:
-- assert(loadfile("C:/HypeMan/common_script_loader.lua"))()

-- Script File Versions
-- MOOSE GITHUB Commit Hash ID: 2021-06-14
-- Mist version 4.3.74
-- HypeMan version II.0
-- Airboss and Spawn scripts no version

scriptPath = "C:\\Hypeman\\"
local theatre = env.mission.theatre
assert(loadfile(scriptPath.."private_api_keys.lua"))()

env.info(SERVERNAME)

USE_SWAPR = true

assert(loadfile(scriptPath.."mist.lua"))()
assert(loadfile(scriptPath.."Moose.lua"))()
theDate = UTILS.GetDCSMissionDate(date)
env.info(theDate)
assert(loadfile(scriptPath.."HypeMan_flightlog.lua"))()


if theatre == "Caucasus" then
assert(loadfile(scriptPath.."BlackSea2Airboss_Tanker.lua"))()
assert(loadfile(scriptPath.."BlackSeaSpawnMenu.lua"))()
assert(loadfile(scriptPath.."common_carrierSpawns.lua"))()

elseif theatre == "PersianGulf" then
assert(loadfile(scriptPath.."PG_Airboss_Tanker.lua"))()
assert(loadfile(scriptPath.."PGSpawnMenu.lua"))()
assert(loadfile(scriptPath.."common_carrierSpawns.lua"))()
--assert(loadfile(scriptPath.."PG_AiD_A2Av1.lua"))()

elseif theatre == "Nevada" then
assert(loadfile(scriptPath.."Nellis_scripts.lua"))()

elseif theatre == "MarianaIslands" then
assert(loadfile(scriptPath.."MIslandsAirboss_Tanker.lua"))()
assert(loadfile(scriptPath.."common_carrierSpawns.lua"))()

end


if SERVERNAME == "JOW NAVY" then
 assert(loadfile(scriptPath.."common_atis.lua"))()
 elseif SERVERNAME == "JOW WHISKEY" then
 assert(loadfile(scriptPath.."common_atis.lua"))()
 elseif SERVERNAME == "JOW EASY" then
 assert(loadfile(scriptPath.."common_atis.lua"))()
 elseif SERVERNAME == "JOW ABLE" then
 assert(loadfile(scriptPath.."common_atis.lua"))()
 end


if USE_SWAPR then 
function RunSWAPR(ourArgument, time)			
	assert(loadfile(scriptPath.."common_swapr.lua"))()
   return nil
end
timer.scheduleFunction(RunSWAPR, 1, timer.getTime() + 15)
end

