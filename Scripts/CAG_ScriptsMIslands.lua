-------------------------
-- AIRBOSS --
-------------------------
superCarrier = Truman
cvnUnitName = "CVN-75 Harry Truman"

AIRBOSS.MenuF10Root=MENU_MISSION:New("Airboss").MenuPath
_SETTINGS:SetPlayerMenuOff()

local hightanker=RECOVERYTANKER:New(UNIT:FindByName(cvnUnitName), "Arco")
hightanker:SetTakeoffAir()
hightanker:SetRadio(268)
hightanker:SetAltitude(15000)
hightanker:SetCallsign(CALLSIGN.Tanker.Arco, 1)
hightanker:SetRacetrackDistances(25, 8)
hightanker:SetModex(611)
hightanker:SetTACAN(55, "ARC")
hightanker:SetSpeed(350)
hightanker:Start()

rescuehelo=RESCUEHELO:New(UNIT:FindByName(cvnUnitName), "Rescue Helo")
rescuehelo:SetHomeBase(AIRBASE:FindByName("USS Ticonderoga"))
rescuehelo:SetTakeoffAir()
rescuehelo:SetRescueDuration(1)
rescuehelo:SetRescueHoverSpeed(5)
rescuehelo:SetRescueZone(15)
rescuehelo:SetModex(42)
rescuehelo:__Start(4)

tanker=RECOVERYTANKER:New(UNIT:FindByName(cvnUnitName), "Texaco")
tanker:SetTakeoffHot()
tanker:SetCallsign(CALLSIGN.Tanker.Texaco, 1)
tanker:SetRadio(262)
tanker:SetModex(511)
tanker:SetTACAN(60, "TKR")
tanker:__Start(3)

-- local awacs=RECOVERYTANKER:New("CVN73", "Wizard")
-- awacs:SetAWACS()
-- awacs:SetTakeoffAir()
-- awacs:SetRadio(285.65)
-- awacs:SetAltitude(25000)
-- awacs:SetCallsign(CALLSIGN.AWACS.Wizard)
-- awacs:SetRacetrackDistances(30, 15)
-- awacs:SetModex(611)
-- awacs:SetTACAN(52, "WIZ")
-- awacs:__Start(1)

local superCarrier=AIRBOSS:New(cvnUnitName)

local function cutPass()
  trigger.action.outSound("Airboss Soundfiles/GetYourButtsUptoVipersOffice.ogg")
end

local function underlinePass()
  cvn = GROUP:FindByName( cvnUnitName )
  cvnZONE = ZONE_GROUP:New( "ZoneCVN", cvn, 100 )
  cvnZONE:FlareZone( FLARECOLOR.Red, 10, 60 )
  cvnZONE:FlareZone( FLARECOLOR.White, 10, 60 )
  cvnZONE:FlareZone( FLARECOLOR.Green, 10, 60 )
  cvnZONE:FlareZone( FLARECOLOR.Yellow, 10, 60 )
  --trigger.action.outSound("Airboss Soundfiles/ffyrtp.ogg")
end

local function underlinePassSH()
  cvn = GROUP:FindByName( cvnUnitName )
  cvnZONE = ZONE_GROUP:New( "ZoneCVN", cvn, 100 )
  cvnZONE:FlareZone( FLARECOLOR.Red, 10, 60 )
  cvnZONE:FlareZone( FLARECOLOR.White, 10, 60 )
  cvnZONE:FlareZone( FLARECOLOR.Green, 10, 60 )
  cvnZONE:FlareZone( FLARECOLOR.Yellow, 10, 60 )
  --trigger.action.outSound("Airboss Soundfiles/sureshot.ogg")
end

local function resetTrapSheetFileFormat()
  superCarrier:SetTrapSheet()
end

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

superCarrier:SetMenuRecovery(60, 29, true, 0)
superCarrier:Load()
superCarrier:SetAutoSave()
superCarrier:SetTrapSheet()
superCarrier:SetFunkManOn(10042)
superCarrier:SetTACAN(75, "X", "WFR")
superCarrier:SetICLS(15,"GWW")
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

function tanker:OnAfterStart(From,Event,To)
  superCarrier:SetRecoveryTanker(tanker)
end

---Forrestal Airboss---


cvUnitName = "CV-59 USS Forrestal"
forrestalHelo=RESCUEHELO:New(UNIT:FindByName(cvUnitName), "Forrestal Rescue Helo")
forrestalHelo:SetHomeBase(AIRBASE:FindByName("USS Reuben James"))
forrestalHelo:SetTakeoffAir()
forrestalHelo:SetRescueDuration(1)
forrestalHelo:SetRescueHoverSpeed(5)
forrestalHelo:SetRescueZone(15)
forrestalHelo:SetModex(44)
forrestalHelo:__Start(4)

--Recovery Tankers   *Callsign parameters (1=Texaco, 2=Arco, 3=Shell)
forrestalTanker=RECOVERYTANKER:New(UNIT:FindByName(cvUnitName), "Texaco 7-1")
forrestalTanker:SetTakeoffAir()
forrestalTanker:SetCallsign(CALLSIGN.Tanker.Texaco, 7)
forrestalTanker:SetRadio(258)
forrestalTanker:SetModex(712)
forrestalTanker:SetTACAN(61, "TKR")
forrestalTanker:__Start(3)


local forrestal=AIRBOSS:New(cvUnitName)

function forrestal:OnAfterLSOGrade(from, event, to, playerData, myGrade)
    player_name = playerData.name:gsub('[%p]', '')
    --[...] -- do some magic in here, like SH break, etc.
    trapsheet = "AIRBOSS-trapsheet-" .. player_name
    forrestal:SetTrapSheet(nil, trapsheet)
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
forrestal:SetMenuRecovery(60, 29, true, 0)
forrestal:Load()
forrestal:SetAutoSave()
forrestal:SetFunkManOn(10042)
forrestal:SetTACAN(58, "X", "ZIP")
forrestal:SetICLS(17,"FOR")
forrestal:SetLSORadio(265,AM)
forrestal:SetMarshalRadio(254, AM)
forrestal:SetPatrolAdInfinitum()
forrestal:SetAirbossNiceGuy()
forrestal:SetRadioRelayLSO("Forrestal LSO Huey")
forrestal:SetRadioRelayMarshal("Forrestal Huey")
forrestal:SetDefaultPlayerSkill(AIRBOSS.Difficulty.NORMAL)
forrestal:SetMaxSectionSize(4)
forrestal:SetMPWireCorrection(12)
forrestal:SetSoundfilesFolder("Airboss Soundfiles/")
forrestal:SetDespawnOnEngineShutdown()
forrestal:SetMenuSingleCarrier(false)

forrestal:SetExcludeAI(CarrierExcludeSet)

--- Function called when recovery starts.
local function play_recovery_sound()
  trigger.action.outSound("Airboss Soundfiles/BossRecoverAircraft.ogg")
end
function forrestal:OnAfterRecoveryStart(Event, From, To, Case, Offset)
  env.info(string.format("Starting Recovery Case %d ops.", Case))
  timer.scheduleFunction(play_recovery_sound, {}, timer.getTime() + 10)
  spawnsCVOff()
end

-- Start airboss class.
forrestal:Start()

function forrestalTanker:OnAfterStart(From,Event,To)
  forrestal:SetRecoveryTanker(forrestalTanker)
end

------------------Tarawa-----------------------
local Tarawa=AIRBOSS:New("Tarawa")
function Tarawa:OnAfterLSOGrade(from, event, to, playerData, myGrade)
    player_name = playerData.name:gsub('[%p]', '')
    --[...] -- do some magic in here, like SH break, etc.
    trapsheet = "AIRBOSS-trapsheet-" .. player_name
    Tarawa:SetTrapSheet(nil, trapsheet)
    --[...]
    self:_SaveTrapSheet(playerData, myGrade)
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

Tarawa:SetTACAN(108, "X", "LHA")
Tarawa:SetTrapSheet()
Tarawa:SetICLS(8)
Tarawa:Load()
Tarawa:SetAutoSave()
Tarawa:SetFunkManOn(10042)
Tarawa:SetLineupErrorThresholds(.5,-.5,-1,-2,-4,1,2,4)
Tarawa:SetStatusUpdateTime(1)
Tarawa:SetRadioUnitName("UH1H Radio Relay")
Tarawa:SetMarshalRadio(243)
Tarawa:SetLSORadio(265)
Tarawa:SetSoundfilesFolder("Airboss Soundfiles/")
Tarawa:SetDespawnOnEngineShutdown()
Tarawa:SetMenuSingleCarrier()
Tarawa:SetMenuRecovery(60, 20, true)
Tarawa:Start()

-------------------Tanker,AWAC and JTAC objects------------------------
local zoneAWACSblue=ZONE:New("Zone AWACS BLUE")
local zoneAWACSred=ZONE:New("Zone AWACS RED")
local zoneTankerNorth=ZONE:New("Zone Tank North")
local zoneTankerSouth=ZONE:New("Zone Tank South")
local zoneTankerRed=ZONE:New("Zone Tank Red")

boomAltitude = 25000
drogueAltitude = 24000
tankerSpeed = 270
tankerTrackLength=20

-- E-3A Magic 51 - 32,000' 251.000Mhz
local auftragAWACS=AUFTRAG:NewAWACS(zoneAWACSblue:GetCoordinate(), 32000, UTILS.KnotsToAltKIAS(300,30000), 210, 50)
auftragAWACS:SetTACAN(29, "DXS") 
auftragAWACS:SetRadio(251.000)      
local fsAWACS=FLIGHTGROUP:New("Magic")
fsAWACS:SetDefaultCallsign(CALLSIGN.AWACS.Magic, 5)
fsAWACS:AddMission(auftragAWACS)
  
-- E-3A Dakrstar 51 - 32,000' 252.000Mhz
local auftragredAWACS=AUFTRAG:NewAWACS(zoneAWACSred:GetCoordinate(), 32000, UTILS.KnotsToAltKIAS(300,30000), 180, 40)
auftragredAWACS:SetTACAN(30, "DKS") 
auftragredAWACS:SetRadio(252.000)      
local fsRedAWACS=FLIGHTGROUP:New("Darkstar")
fsRedAWACS:SetDefaultCallsign(CALLSIGN.AWACS.Darkstar, 5)
fsRedAWACS:AddMission(auftragredAWACS)

-----North Tankers -----

--KC-135 Shell11 (North) TCN 59Y - 25,000' 259.0MHz (Hornet Ch.11)
local shellNorth=AUFTRAG:NewTANKER(zoneTankerNorth:GetCoordinate(), drogueAltitude, UTILS.KnotsToAltKIAS(tankerSpeed,drogueAltitude), 350, tankerTrackLength)
shellNorth:SetTACAN(59, "SDN")
shellNorth:SetRadio(259)
local shell11=FLIGHTGROUP:New("Shell North")
shell11:SetDefaultCallsign(CALLSIGN.Tanker.Shell, 1)
shell11:Activate()
shell11:AddMission(shellNorth)
--KC-135 Texaco31 (North Boom) TCN 61Y - 26,000' 261.0MHz
local texNorth=AUFTRAG:NewTANKER(zoneTankerNorth:GetCoordinate(), boomAltitude, UTILS.KnotsToAltKIAS(tankerSpeed,boomAltitude), 350, tankerTrackLength)
texNorth:SetTACAN(61, "TXN")
texNorth:SetRadio(261)
local tex31=FLIGHTGROUP:New("Texaco North")
tex31:SetDefaultCallsign(CALLSIGN.Tanker.Texaco, 3)
tex31:Activate()
tex31:AddMission(texNorth)

-----South Tankers------
--KC-135 Shell21 (South) TCN 63Y - 25,000' 263.0MHz (Hornet Ch.15)
local shellSouth=AUFTRAG:NewTANKER(zoneTankerSouth:GetCoordinate(), drogueAltitude, UTILS.KnotsToAltKIAS(tankerSpeed,drogueAltitude), 060, tankerTrackLength)
shellSouth:SetTACAN(63, "SHS")
shellSouth:SetRadio(263)
local shell21=FLIGHTGROUP:New("Shell South")
shell21:SetDefaultCallsign(CALLSIGN.Tanker.Shell, 2)
shell21:Activate()
shell21:AddMission(shellSouth)

--KC-135 Texaco21 (South Boom) TCN 67Y - 26,000' 267.0MHz
local texSouth=AUFTRAG:NewTANKER(zoneTankerSouth:GetCoordinate(), boomAltitude, UTILS.KnotsToAltKIAS(tankerSpeed,boomAltitude), 060, tankerTrackLength)
texSouth:SetTACAN(67, "TXS")
texSouth:SetRadio(267)
local tex21=FLIGHTGROUP:New("Texaco South")
tex21:SetDefaultCallsign(CALLSIGN.Tanker.Texaco, 2)
tex21:Activate()
tex21:AddMission(texSouth)

-----Red Tankers----

--IL-78
local texacoRedOne=AUFTRAG:NewTANKER(zoneTankerRed:GetCoordinate(), drogueAltitude, UTILS.KnotsToAltKIAS(tankerSpeed,drogueAltitude), 260, tankerTrackLength)
texacoRedOne:SetTACAN(57, "RDN")
texacoRedOne:SetRadio(257)
local texaco_51=FLIGHTGROUP:New("Red_Tanker")
texaco_51:SetDefaultCallsign(CALLSIGN.Tanker.Texaco, 5)
texaco_51:Activate()
texaco_51:AddMission(texacoRedOne)

--KC-135 Texaco21 (South Boom) TCN 58Y - 26,000' 258.0MHz
local texacoRedTwo=AUFTRAG:NewTANKER(zoneAWACSred:GetCoordinate(), boomAltitude, UTILS.KnotsToAltKIAS(tankerSpeed,boomAltitude), 180, tankerTrackLength)
texacoRedTwo:SetTACAN(58, "RDS")
texacoRedTwo:SetRadio(258)
local texaco_61=FLIGHTGROUP:New("Red_Tanker-1")
texaco_61:SetDefaultCallsign(CALLSIGN.Tanker.Texaco, 6)
texaco_61:Activate()
texaco_61:AddMission(texacoRedTwo)
 
  
----------------Rota Range---------------------
rotaRange=RANGE:New("Rota Range")
rotaRange:SetFunkManOn(10042)
rotaRange:AddBombingTargetGroup(GROUP:FindByName("Rota Range Bunkers"), 50, false)
rotaRange:AddBombingTargetGroup(GROUP:FindByName("Rota Range Soft Targets"), 50, false)
rotaRange:AddBombingTargetGroup(GROUP:FindByName("Rota Range Armor"), 50, false)
rotaRange:AddBombingTargetGroup(GROUP:FindByName("Rota-Ural-375"), 50, false)
rotaRange:AddBombingTargetGroup(GROUP:FindByName("Rota T-72"), 50, false)
rotaRange:AddBombingTargetGroup(GROUP:FindByName("Rota T-55"), 50, false)
rotaRange:AddBombingTargetGroup(GROUP:FindByName("Rota-ZSU"), 50, false)
rotaRange:AddBombingTargetGroup(GROUP:FindByName("Ground-32"), 50, false)
rotaRange:SetRangeRadius(15)
rotaRange:SetAutosaveOn()
rotaRange:Start()



-----------------Tactical Menu----------------
mainMenu = MENU_MISSION:New( "Tactical Menu" )
adminMenu = MENU_MISSION:New( "Admin Menu" )
SAM = MENU_MISSION:New("SAM Range", mainMenu)
A2A = MENU_MISSION:New("BVR Range", mainMenu)
menuFox=MENU_MISSION:New("Fox Trainer", mainMenu)

------------------Red Naval Units---------------

RedNavalKuz = GROUP:FindByName( "Kuznetsov Strike Group" )
RedNavalKuz:PatrolZones( { ZONE:New( "RedNavy" ) }, 28, "EchelonR" )

------------------SAM Sites----------------------
samTable = {
"SA-2",
"SA-3",
"SA-6",
"SA-8",
"SA-10",
"SA-11",
"SA-15"}
--samZoneTable = {ZONE:New("Sam_Zone")}

redSAM = {}
for i=1,#samTable do
  redSAM[i] = SPAWN:New(samTable[i]):InitLimit(50,0):InitAIOn()--:InitRandomizeZones(samZoneTable)
end

SAMSpawn = {}
function newSAMSite(grpname, grpspawn)
  SAMSpawn[grpname] = grpspawn:Spawn():OptionAlarmStateRed()
  text = grpname
  MESSAGE:New(text.." Spawned",15,Info):ToAll()
end

local function destroySAM(grpspawn)
for k, v in pairs(SAMSpawn) do
  v:Destroy()
  k = nil
end
end

for i=1,7 do
  MENU_MISSION_COMMAND:New (samTable[i], SAM, newSAMSite, samTable[i], redSAM[i])
end
MENU_MISSION_COMMAND:New ("Remove Spawned SAM Sites", SAM, destroySAM)

------------------A2A Threats ATCCA5 MOA----------------------
a2aTable = { 
"Mig-21 Section",
"Mig-21 Division", 
"Mig-23 Section", 
"Mig-23 Division",
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

------------------Fox Missile Trainer-------------
-- Protect all blue AI.

FoxRunning = false
function FoxOn()
  if not FoxRunning then
	local blueset=SET_GROUP:New():FilterCoalitions("blue"):FilterActive():FilterStart()
	foxTrainer = FOX:New()
	foxTrainer:SetProtectedGroupSet(blueset)
	--foxTrainer:AddSafeZone(ZONE:New("Zone_1"))
	--foxTrainer:AddSafeZone(ZONE:New("Zone_2"))
	foxTrainer:SetExplosionDistance(500)
	foxTrainer:SetExplosionPower(.1)
    foxTrainer:Start()
    MESSAGE:New("Fox Trainer On",15,Info):ToAll()
    FoxRunning = true
	env.info(FoxRunning)
	env.info("FoxRunning")
  end
end
MENU_MISSION_COMMAND:New("Fox On", menuFox,FoxOn)

function FoxOff()
  foxTrainer:__Stop(1)
  MESSAGE:New("Fox Trainer Off",15,Info):ToAll()
  FoxRunning = false
  env.info(FoxRunning)
  env.info("FoxOff")
end
MENU_MISSION_COMMAND:New("Fox Off", menuFox,FoxOff)

function SmokeOn()
  foxTrainer:SetDebugOn()
  foxTrainer:SetDefaultLaunchAlerts(true)
  foxTrainer:SetDefaultLaunchMarks(true)
  MESSAGE:New("Smoke and Launch Information On",15,Info):ToAll()
end
MENU_MISSION_COMMAND:New("Smoke and Launch Alerts On", menuFox,SmokeOn)

function SmokeOff()
  foxTrainer:SetDebugOff()
  foxTrainer:SetDefaultLaunchAlerts(false)
  foxTrainer:SetDefaultLaunchMarks(false)
  MESSAGE:New("Smoke and Launch Information Off",15,Info):ToAll()
end
MENU_MISSION_COMMAND:New("Smoke and Launch Alerts Off", menuFox,SmokeOff)