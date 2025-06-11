-------------------------
-- AIRBOSS --
-------------------------
superCarrier = Washington
cvnUnitName = "CVN-73 USS George Washington"

AIRBOSS.MenuF10Root=MENU_MISSION:New("Airboss").MenuPath
_SETTINGS:SetPlayerMenuOff()

local hightanker=RECOVERYTANKER:New(UNIT:FindByName(cvnUnitName), "Arco")
hightanker:SetTakeoffAir()
hightanker:SetRadio(268)
hightanker:SetAltitude(15000)
hightanker:SetRacetrackDistances(25, 8)
hightanker:SetModex(611)
hightanker:SetTACAN(55, "ARC")
hightanker:SetSpeed(325)
hightanker:Start()

rescuehelo=RESCUEHELO:New(UNIT:FindByName(cvnUnitName), "Rescue Helo")
rescuehelo:SetHomeBase(AIRBASE:FindByName("CVN-73 USS George Washington-3"))
rescuehelo:SetTakeoffAir()
rescuehelo:SetRescueDuration(1)
rescuehelo:SetRescueHoverSpeed(5)
--rescuehelo:SetRescueZone(15)
rescuehelo:SetModex(42)
rescuehelo:__Start(4)

--Recovery Tankers   *Callsign parameters (1=Texaco, 2=Arco, 3=Shell)
tanker=RECOVERYTANKER:New(UNIT:FindByName(cvnUnitName), "Texaco")
tanker:SetTakeoffAir()
tanker:SetCallsign(CALLSIGN.Tanker.Texaco, 1)
tanker:SetRadio(262)
tanker:SetModex(511)
tanker:SetTACAN(60, "TKR")
tanker:__Start(3)

local awacs=RECOVERYTANKER:New(cvnUnitName, "Wizard")
awacs:SetAWACS()
awacs:SetTakeoffAir()
awacs:SetRadio(285.65)
awacs:SetAltitude(25000)
awacs:SetCallsign(CALLSIGN.AWACS.Wizard)
awacs:SetRacetrackDistances(30, 15)
awacs:SetModex(611)
awacs:SetTACAN(52, "WIZ")
awacs:__Start(1)

local superCarrier=AIRBOSS:New(cvnUnitName)

function superCarrier:OnAfterLSOGrade(from, event, to, playerData, myGrade)
    player_name = playerData.name:gsub('[%p]', '')
    --[...] -- do some magic in here, like SH break, etc.
    trapsheet = "AIRBOSS-trapsheet-" .. player_name
    superCarrier:SetTrapSheet(nil, trapsheet)
    --[...]
    self:_SaveTrapSheet(playerData, myGrade)
		if playerData.wire == 1 then
		myGrade.points = myGrade.points -1.00
		oneWireMessage = {}
		oneWireMessage = ('**'..player_name..' almost had a rampstrike with that 1-wire!**')
		-- dcsbot.sendBotTable(oneWireMessage)
		oneWireMessageSocket=SOCKET:New()
		oneWireMessageSocket:SendText(oneWireMessage)
		end	
    msg = {}
    msg.command = "onMissionEvent"
    msg.eventName = "S_EVENT_AIRBOSS"
    msg.initiator = {}
    msg.initiator.name = playerData.name
    msg.place = {}
    msg.place.name = myGrade.carriername
    msg.points = myGrade.points
    msg.grade = myGrade.grade
    msg.details = myGrade.details
    msg.wire = playerData.wire
    msg.trapsheet = trapsheet
    msg.time = timer.getTime()
    dcsbot.sendBotTable(msg)
end 
-- function superCarrier:OnAfterLSOGrade(From, Event, To, playerData, myGrade)
  -- local string_grade = myGrade.grade
  -- local player_callsign = playerData.callsign
  -- local unit_name = playerData.unitname
  -- local player_name = playerData.name
  -- local player_wire = playerData.wire
  -- local player_case = playerData.case
  -- local player_Tgroove = playerData.Tgroove
  -- player_name = player_name:gsub('[%p]', '')
  -- myGrade.messageType = 2
  -- myGrade.callsign = playerData.callsign
  -- myGrade.name = playerData.name
  -- if playerData.wire == 1 then
    -- myGrade.points = myGrade.points -1.00
    -- oneWireMessage = {}
	-- oneWireMessage.messageType=5
	-- oneWireMessage.messageString = ('**'..player_name..' almost had a rampstrike with that 1-wire!**')
	-- --HypeMan.sendBotTable(oneWireMessage)
  -- end
  -- --HypeMan.sendBotTable(myGrade)
-- end

superCarrier:SetMenuRecovery(60, 25, true, 0)
superCarrier:Load()
superCarrier:SetFunkManOn()
superCarrier:SetAutoSave()
superCarrier:SetTACAN(73, "X", "WFR")
superCarrier:SetICLS(13,"GWW")
superCarrier:SetLSORadio(265,AM)
superCarrier:SetMarshalRadio(264, AM)
superCarrier:SetPatrolAdInfinitum()
superCarrier:SetAirbossNiceGuy()
superCarrier:SetRadioRelayLSO("LSO Huey")
superCarrier:SetRadioRelayMarshal("Marshal Huey")
superCarrier:SetDefaultPlayerSkill(AIRBOSS.Difficulty.NORMAL)
superCarrier:SetMaxSectionSize(4)
superCarrier:SetMPWireCorrection(12)
superCarrier:SetSoundfilesFolder("Airboss Soundfiles/")
superCarrier:SetDespawnOnEngineShutdown()
superCarrier:SetMenuSingleCarrier(false)
local CarrierExcludeSet=SET_GROUP:New():FilterPrefixes("Arco"):FilterStart()
superCarrier:SetExcludeAI(CarrierExcludeSet)

--- Function called when recovery starts.
local function play_recovery_sound()
  trigger.action.outSound("Airboss Soundfiles/BossRecoverAircraft.ogg")
end
function superCarrier:OnAfterRecoveryStart(Event, From, To, Case, Offset)
  env.info(string.format("Starting Recovery Case %d ops.", Case))
  timer.scheduleFunction(play_recovery_sound, {}, timer.getTime() + 10)
  spawnsAllOff()
end

-- Start airboss class.
superCarrier:Start()

-- ------------------Range Script-------------------
-- bombingRange=RANGE:New("Mercury Range")
-- bombingRange:SetFunkManOn()
-- bombTargets = {'S1', 'S2', 'N1', 'N2', 'W1', 'W2', 'E1', 'E2'}
-- bombingRange:AddBombingTargets(bombTargets, 20, false)
-- strafe_targets_west = {'StrafePitWest'}
-- strafe_target_east = {'StrafePitEast'}
-- bombingRange:AddStrafePit(strafe_targets_west, 4000,350, nil, false, 20, 600)
-- bombingRange:AddStrafePit(strafe_target_east, 4000,350, nil, false, 20, 600)
-- bombingRange:SetAutosaveOn()
-- bombingRange:Start()

thalfangRange=RANGE:New("Thalfang Range N49.45.0E7.0.0")
thalfangRange:SetFunkManOn()
thalfangRange:AddBombingTargetGroup(GROUP:FindByName("Russian Targets"), 50, false)
-- thalfangRange:AddBombingTargetGroup(GROUP:FindByName("HARD TGT #002"), 50, false)
-- thalfangRange:AddBombingTargetGroup(GROUP:FindByName("HARD TGT"), 50, false)
thalfangRange:SetRangeRadius(15)
thalfangRange:SetAutosaveOn()
thalfangRange:Start()

-----------------Tactical Menu----------------
mainMenu = MENU_MISSION:New( "Tactical Menu" )
adminMenu = MENU_MISSION:New( "Admin Menu" )

A2A = MENU_MISSION:New( "Air to Air Spawns", mainMenu)
-- BVR = MENU_MISSION:New( "BVR (Missles) ", A2A)
-- ACM = MENU_MISSION:New("ACM (Guns Only)", A2A)
-- Bombers = MENU_MISSION:New("Bomber Intercepts)", A2A)


A2G = MENU_MISSION:New( "Air to Ground Spawns", mainMenu)
-- SAM = MENU_MISSION:New("SAM Range", A2G)
--RANGE.MenuF10Root=MENU_MISSION:New("Basic Ranges",A2G).MenuPath
-- menuJTAC = MENU_MISSION:New("JTAC Refresh", A2G)

--naval_menu = MENU_MISSION:New("Naval Ops")
--alertLaunch = MENU_MISSION_COMMAND:New ("Launch the Alert Aircraft", mainMenu, launchEvent )
menuFox=MENU_MISSION:New("Fox Trainer", mainMenu)

-- ----------------spawn zones------------------
-- zoneTable= { ZONE:New("DogfightZone"), ZONE:New("BomberZone")}

------------------A2A Threats Adelsheim MOA----------------------
a2aTable = { 
"Mig-21 Section",
"Mig-21 Division", 
"F-4 Section", 
"F-4 Division",
"Mig-29 Section", 
"Mig-29 Division"
}

redAIR = {}
for i=1,#a2aTable do
  redAIR[i] = SPAWN
  :New(a2aTable[i])
  :InitLimit(50,0)
  :InitAIOn()
  :OnSpawnGroup(
  function ( SpawnGroup1 )
        PatrolZone1 = ZONE:New( "PatrolZone1" )
        AICapZone1 = AI_CAP_ZONE:New( PatrolZone1, UTILS.FeetToMeters(15000), UTILS.FeetToMeters(25000), UTILS.KnotsToKmph(300), UTILS.KnotsToKmph(600), "BARO" ) -- min alt ,ax alt, min speed, max speed
        EngageZoneGroup1 = GROUP:FindByName( "EngageZone1" )
        CapEngageZone1 = ZONE:New( "EngageZone1", EngageZoneGroup1 )
        AICapZone1:SetControllable( SpawnGroup1 )
        AICapZone1:ManageFuel( 0.2, 0 ) -- 20% no loiter time
        AICapZone1:SetEngageZone( CapEngageZone1 )
        AICapZone1:SetEngageRange(150000)
        AICapZone1:Start() 
      end
   )
end

A2ASpawn = {}
function newA2A(grpname, grpspawn)
  A2ASpawn[grpname] = grpspawn:Spawn()
  text = grpname
  MESSAGE:New(text.." Group Spawned",15,Info):ToAll()
end

local function destroyA2A(grpspawn)
for k, v in pairs(A2ASpawn) do
  v:Destroy()
  k = nil
end
end

for i=1,#a2aTable do
  MENU_MISSION_COMMAND:New (a2aTable[i], A2A, newA2A, a2aTable[i], redAIR[i])
end
MENU_MISSION_COMMAND:New ("Remove Spawned Air Threats", A2A, destroyA2A)
-- bombTable = {"TU-22 Blinder", "TU-95 Bear" , "TU-160 Blackjack" , "B-1B", "B-52" }

-- redBomb = {}
-- for i=1,5 do
  -- redBomb[i] = SPAWN:New(bombTable[i]):InitLimit(3,0)
-- end

-- SpawnBomb = {}
-- function newBomber(grpname, grpspawn)
  -- SpawnBomb[grpname] = grpspawn:SpawnInZone(zoneTable[2],true,3000, 6000 ,nil)
  -- text = grpname
  -- MESSAGE:New("Scramble fighters, "..text.." detected, Inbound to Nellis from Area 51.",15,Info):ToAll()
-- end

-- local function destroyBombers(grpspawn)
-- for k, v in pairs(SpawnBomb) do
  -- v:Destroy()
  -- k = nil
-- end
-- end

-- for i=1,5 do
  -- MENU_MISSION_COMMAND:New (bombTable[i], Bombers, newBomber, bombTable[i], redBomb[i])
-- end
-- MENU_MISSION_COMMAND:New ("Remove Spawned Bombers", Bombers, destroyBombers)

-- ------------------SAM Sites----------------------
-- samTable = { "SA-2", "SA-6", "SA-8", "SA-10", "SA-11", "SA-15"}
-- samZoneTable = {ZONE:New("Sam_Zone"),ZONE:New("Sam_Zone_2")}

-- redSAM = {}
-- for i=1,6 do
  -- redSAM[i] = SPAWN:New(samTable[i]):InitLimit(50,0):InitAIOn():InitRandomizeZones(samZoneTable)
-- end

-- SAMSpawn = {}
-- function newSAMSite(grpname, grpspawn)
  -- SAMSpawn[grpname] = grpspawn:Spawn():OptionAlarmStateRed()
  -- text = grpname
  -- MESSAGE:New(text.." Group Spawned",15,Info):ToAll()
-- end

-- local function destroySAM(grpspawn)
-- for k, v in pairs(SAMSpawn) do
  -- v:Destroy()
  -- k = nil
-- end
-- end

-- for i=1,6 do
  -- MENU_MISSION_COMMAND:New (samTable[i], SAM, newSAMSite, samTable[i], redSAM[i])
-- end
-- MENU_MISSION_COMMAND:New ("Remove Spawned SAM Sites", SAM, destroySAM)

-- -------JTAC respawn------------
-- function launchJTAC1()
  -- Spawn_JTAC1 = SPAWN:New("JTAC1")
    -- :InitKeepUnitNames(true)
    -- :InitLimit(1,0)
    -- :OnSpawnGroup(
      -- function( SpawnGroup )
        -- ctld.JTACAutoLase(SpawnGroup.GroupName, 1388, false, "all")
      -- end
    -- )
    -- :SpawnScheduled( 60,0 )
-- end
-- MENU_MISSION_COMMAND:New ("Relaunch JTAC1", menuJTAC, launchJTAC1 )

-- function launchJTAC2()
  -- Spawn_JTAC2 = SPAWN:New("JTAC2")
    -- :InitKeepUnitNames(true)
    -- :InitLimit(1,0)
    -- :OnSpawnGroup(
      -- function( SpawnGroup )
        -- ctld.JTACAutoLase(SpawnGroup.GroupName, 1488, false, "all")
      -- end
    -- )
    -- :SpawnScheduled( 60,0 )
-- end
-- MENU_MISSION_COMMAND:New ("Relaunch JTAC2", menuJTAC, launchJTAC2 )

-- function launchJTAC3()
  -- Spawn_JTAC3 = SPAWN:New("JTAC3")
    -- :InitKeepUnitNames(true)
    -- :InitLimit(1,0)
    -- :OnSpawnGroup(
      -- function( SpawnGroup )
        -- ctld.JTACAutoLase(SpawnGroup.GroupName, 1588, false, "all")
      -- end
    -- )
    -- :SpawnScheduled( 60,0 )
-- end
-- MENU_MISSION_COMMAND:New ("Relaunch JTAC3", menuJTAC, launchJTAC3 )

-- ------------------Fox Missile Trainer-------------

-- FoxRunning = false
-- function FoxOn()
  -- if not FoxRunning then
	-- -- Protect all blue AI.
	-- local blueset=SET_GROUP:New():FilterCoalitions("blue"):FilterActive():FilterStart()
	-- foxTrainer = FOX:New()
	-- foxTrainer:SetProtectedGroupSet(blueset)
	-- --foxTrainer:AddSafeZone(ZONE:New("Zone_1"))
	-- --foxTrainer:AddSafeZone(ZONE:New("Zone_2"))
	-- foxTrainer:SetExplosionDistance(500)
	-- foxTrainer:SetExplosionPower(.1)
    -- foxTrainer:Start()
    -- MESSAGE:New("Fox Trainer On",15,Info):ToAll()
    -- FoxRunning = true
  -- end
-- end
-- MENU_MISSION_COMMAND:New("Fox On", menuFox,FoxOn)

-- function FoxOff()
  -- foxTrainer:__Stop(1)
  -- MESSAGE:New("Fox Trainer Off",15,Info):ToAll()
-- end
-- MENU_MISSION_COMMAND:New("Fox Off", menuFox,FoxOff)

-- function SmokeOn()
  -- foxTrainer:SetDebugOn()
  -- foxTrainer:SetDefaultLaunchAlerts(true)
  -- foxTrainer:SetDefaultLaunchMarks(true)
  -- MESSAGE:New("Smoke and Launch Information On",15,Info):ToAll()
-- end
-- MENU_MISSION_COMMAND:New("Smoke and Launch Alerts On", menuFox,SmokeOn)

-- function SmokeOff()
  -- foxTrainer:SetDebugOff()
  -- foxTrainer:SetDefaultLaunchAlerts(false)
  -- foxTrainer:SetDefaultLaunchMarks(false)
  -- MESSAGE:New("Smoke and Launch Information Off",15,Info):ToAll()
-- end
-- MENU_MISSION_COMMAND:New("Smoke and Launch Alerts Off", menuFox,SmokeOff)

-- ------------------AiD-------------------------
-- ---- Define a SET_GROUP object that builds a collection of groups that define the EWR network.
-- -- Here we build the network with all the groups that have a name starting with DF CCCP AWACS and DF CCCP EWR.
-- DetectionSetGroup = SET_GROUP:New()
-- DetectionSetGroup:FilterPrefixes( { "REDFOR AWACS", "REDFOR EWR" } )
-- DetectionSetGroup:FilterStart()

-- Detection = DETECTION_AREAS:New( DetectionSetGroup, 30000 )

-- -- Setup the A2A dispatcher, and initialize it.
-- A2ADispatcher = AI_A2A_DISPATCHER:New( Detection )

-- -- Initialize the dispatcher, setting up a border zone. This is a polygon,
-- -- which takes the waypoints of a late activated group with the name CCCP Border as the boundaries of the border area.
-- -- Any enemy crossing this border will be engaged.
-- REDFORBorderZone = ZONE_POLYGON:New( "REDFOR Border", GROUP:FindByName( "REDFOR Border" ) )
-- A2ADispatcher:SetBorderZone( REDFORBorderZone )

-- -- Initialize the dispatcher, setting up a radius of 100km where any airborne friendly
-- -- without an assignment within 100km radius from a detected target, will engage that target.
-- A2ADispatcher:SetEngageRadius( 200000 )

-- -- Setup the squadrons.
-- A2ADispatcher:SetSquadron( "REDFOR 1", AIRBASE.Nevada.Tonopah_Test_Range , "REDFOR 1" )
-- --A2ADispatcher:SetSquadron( "REDFOR 2", AIRBASE.Nevada.Tonopah_Test_Range, "REDFOR 2", 1 )
-- A2ADispatcher:SetSquadron( "REDFOR 3", AIRBASE.Nevada.Mina , "REDFOR 3" )

-- -- Setup the overhead
-- A2ADispatcher:SetSquadronOverhead( "REDFOR 1", 0.75 )
-- --A2ADispatcher:SetSquadronOverhead( "REDFOR 2", 0.5 )
-- A2ADispatcher:SetSquadronOverhead( "REDFOR 3", 0.75 )

-- -- Setup the Grouping
-- A2ADispatcher:SetSquadronGrouping( "REDFOR 1", 2 )
-- --A2ADispatcher:SetSquadronGrouping( "REDFOR 2", 1 )
-- A2ADispatcher:SetSquadronGrouping( "REDFOR 3", 2 )

-- --Takeoff
-- A2ADispatcher:SetSquadronTakeoffInAir( "REDFOR 1" )
-- --A2ADispatcher:SetSquadronTakeoffInAir( "REDFOR 2" )
-- A2ADispatcher:SetSquadronTakeoffInAir( "REDFOR 3" )

-- --GCI
-- --A2ADispatcher:SetSquadronGci( "REDFOR 2", 900, 1200 )

-- --CAP
-- CAPZoneNorth = ZONE_POLYGON:New( "CAP ZONE NORTH", GROUP:FindByName( "CAP ZONE NORTH" ) )
-- A2ADispatcher:SetSquadronCap( "REDFOR 3", CAPZoneNorth, 4000, 10000, 500, 600, 800, 900, "BARO" )
-- A2ADispatcher:SetSquadronCapInterval( "REDFOR 3", 1, 300, 600, 1 )


-- CAPZoneSouth = ZONE_POLYGON:New( "CAP ZONE SOUTH", GROUP:FindByName( "CAP ZONE SOUTH" ) )
-- A2ADispatcher:SetSquadronCap( "REDFOR 1", CAPZoneSouth, 4000, 10000, 500, 600, 800, 900, "BARO" )
-- A2ADispatcher:SetSquadronCapInterval( "REDFOR 1", 1, 300, 600, 1 )

-- --Landing
-- A2ADispatcher:SetSquadronLandingAtEngineShutdown( "REDFOR 1" )
-- --A2ADispatcher:SetSquadronLandingAtEngineShutdown( "REDFOR 2" )
-- A2ADispatcher:SetSquadronLandingAtEngineShutdown( "REDFOR 3" )

-- function aidNorthOn()
  -- A2ADispatcher:Start()
-- end
-- MENU_MISSION_COMMAND:New("Red Air Defence On", aidMenu,aidNorthOn)

-- function aidNorthOff()
  -- A2ADispatcher:Stop()
-- end
-- MENU_MISSION_COMMAND:New("Red Air Defence Off", aidMenu,aidNorthOff)




---------------AWACS/big wing Tankers---------------------
local zoneAWACSblue=ZONE:New("Zone AWACS BLUE")
-- local zoneAWACSred=ZONE:New("Zone AWACS RED")
local zoneTankerNorth=ZONE:New("Zone Tank North")
local zoneTankerWest=ZONE:New("Zone Tank West")
local zoneTankerSouth=ZONE:New("Zone Tank South")
local zoneTankerLow=ZONE:New("Zone Tank Low")

boomAltitude = 25000
drogueAltitude = 24000
tankerSpeed = 270
AWACSSpeed = 300
tankerTrackLength=15

-- E-3A Magic 51 - 32,000' 251.000Mhz
local auftragAWACS=AUFTRAG:NewAWACS(zoneAWACSblue:GetCoordinate(), 32000, AWACSSpeed, 360, 40)
auftragAWACS:SetTACAN(29, "DXS") 
auftragAWACS:SetRadio(251.000)      
local fsAWACS=FLIGHTGROUP:New("Magic")
fsAWACS:SetDefaultCallsign(CALLSIGN.AWACS.Magic, 5)
fsAWACS:AddMission(auftragAWACS)
  
-- -- E-3A Darkstar 51 - 32,000' 252.000Mhz
-- local auftragredAWACS=AUFTRAG:NewAWACS(zoneAWACSred:GetCoordinate(), 32000, AWACSSpeed, 360, 40)
-- auftragredAWACS:SetTACAN(30, "DKS") 
-- auftragredAWACS:SetRadio(252.000)      
-- local fsRedAWACS=FLIGHTGROUP:New("Darkstar")
-- fsRedAWACS:SetDefaultCallsign(CALLSIGN.AWACS.Darkstar, 3)
-- fsRedAWACS:AddMission(auftragredAWACS)

----------------North Tankers------------------------
--KC-135 Arco (North) TCN 61Y - 25,000' 261.0MHz 
local arcoNorth=AUFTRAG:NewTANKER(zoneTankerNorth:GetCoordinate(), boomAltitude, tankerSpeed, 030, tankerTrackLength)
arcoNorth:SetTACAN(61, "ANB")
arcoNorth:SetRadio(261)
local arco41=FLIGHTGROUP:New("Arco North")
arco41:SetDefaultCallsign(CALLSIGN.Tanker.Arco, 4)
arco41:Activate()
arco41:AddMission(arcoNorth)
--KC-135MPRS Texaco (North) TCN 62Y - 24,000' 262.0MHz
local texNorth=AUFTRAG:NewTANKER(zoneTankerNorth:GetCoordinate(), drogueAltitude, tankerSpeed, 030, tankerTrackLength)
texNorth:SetTACAN(62, "TND")
texNorth:SetRadio(262)
local tex31=FLIGHTGROUP:New("Texaco North")
tex31:SetDefaultCallsign(CALLSIGN.Tanker.Texaco, 3)
tex31:Activate()
tex31:AddMission(texNorth)

----------------West Tankers------------------------  
  --KC-135 Arco (West) TCN 63Y - 25,000' 263.0MHz 
local arcoWest=AUFTRAG:NewTANKER(zoneTankerWest:GetCoordinate(), boomAltitude, tankerSpeed, 350, tankerTrackLength)
arcoWest:SetTACAN(63, "AWB")
arcoWest:SetRadio(263)
local arco21=FLIGHTGROUP:New("Arco West")
arco21:SetDefaultCallsign(CALLSIGN.Tanker.Arco, 2)
arco21:Activate()
arco21:AddMission(arcoWest)
--KC-135MPRS Texaco (North) TCN 64Y - 24,000' 264.0MHz
local texWest=AUFTRAG:NewTANKER(zoneTankerWest:GetCoordinate(), drogueAltitude, tankerSpeed, 350, tankerTrackLength)
texWest:SetTACAN(64, "TWD")
texWest:SetRadio(264)
local tex21=FLIGHTGROUP:New("Texaco West")
tex21:SetDefaultCallsign(CALLSIGN.Tanker.Texaco, 2)
tex21:Activate()
tex21:AddMission(texWest)

----------------South Tankers------------------------
--KC-135 Arco (East) TCN 65Y - 25,000' 265.0MHz 
local arcoEast=AUFTRAG:NewTANKER(zoneTankerSouth:GetCoordinate(), boomAltitude, tankerSpeed, 300, tankerTrackLength)
arcoEast:SetTACAN(65, "AEB")
arcoEast:SetRadio(265)
local arco31=FLIGHTGROUP:New("Arco South")
arco31:SetDefaultCallsign(CALLSIGN.Tanker.Arco, 3)
arco31:Activate()
arco31:AddMission(arcoEast)
--KC-135MPRS Texaco (East) TCN 66Y - 24,000' 266.0MHz
local texEast=AUFTRAG:NewTANKER(zoneTankerSouth:GetCoordinate(), drogueAltitude, tankerSpeed, 300, tankerTrackLength)
texEast:SetTACAN(66, "TED")
texEast:SetRadio(266)
local tex51=FLIGHTGROUP:New("Texaco South")
tex51:SetDefaultCallsign(CALLSIGN.Tanker.Texaco, 5)
tex51:Activate()
tex51:AddMission(texEast)

--KC-130 Texaco (Low) TCN 55Y -12,000' 255.0 MHz
local shellLow=AUFTRAG:NewTANKER(zoneTankerLow:GetCoordinate(), 12000, tankerSpeed, 035, 10)
shellLow:SetTACAN(67, "TCC")
shellLow:SetRadio(255)
local sh51=FLIGHTGROUP:New("Texaco")
sh51:SetDefaultCallsign(CALLSIGN.Tanker.Texaco, 4)
sh51:Activate()
sh51:AddMission(shellLow)
-------------JTAC initial Spawn--------------

-- Spawn_JTAC1 = SPAWN:New("JTAC1388")
-- Spawn_JTAC1:InitKeepUnitNames(true)
-- Spawn_JTAC1:InitLimit(1,0)
-- Spawn_JTAC1:InitDelayOn()
-- Spawn_JTAC1:OnSpawnGroup(
  -- function( SpawnGroup1 )
	-- ctld.JTACAutoLase(SpawnGroup1.GroupName, 1388, false, "all")
  -- end
-- )
-- Spawn_JTAC1:SpawnScheduled( 60,0 )

-- Spawn_JTAC2 = SPAWN:New("JTAC1488")
-- Spawn_JTAC2:InitKeepUnitNames(true)
-- Spawn_JTAC2:InitLimit(1,0)
-- Spawn_JTAC2:InitDelayOn()
-- Spawn_JTAC2:OnSpawnGroup(
  -- function( SpawnGroup2 )
	-- ctld.JTACAutoLase(SpawnGroup2.GroupName, 1488, false, "all")
  -- end
-- )
-- Spawn_JTAC2:SpawnScheduled( 60,0 )

-- Spawn_JTAC3 = SPAWN:New("JTAC1588")
-- Spawn_JTAC3:InitKeepUnitNames(true)
-- Spawn_JTAC3:InitLimit(1,0)
-- Spawn_JTAC3:InitDelayOn()
-- Spawn_JTAC3:OnSpawnGroup(
  -- function( SpawnGroup3 )
	-- ctld.JTACAutoLase(SpawnGroup3.GroupName, 1588, false, "all")
  -- end
-- )
-- Spawn_JTAC3:SpawnScheduled( 60,0 )
