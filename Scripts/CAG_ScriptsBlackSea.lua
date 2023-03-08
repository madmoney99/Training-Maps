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
hightanker:SetSpeed(350)
hightanker:Start()

rescuehelo=RESCUEHELO:New(UNIT:FindByName(cvnUnitName), "Rescue Helo")
rescuehelo:SetHomeBase(AIRBASE:FindByName("CVN73-3"))
rescuehelo:SetTakeoffAir()
rescuehelo:SetRescueDuration(1)
rescuehelo:SetRescueHoverSpeed(5)
--rescuehelo:SetRescueZone(15)
rescuehelo:SetModex(42)
rescuehelo:__Start(4)

--Recovery Tankers   *Callsign parameters (1=Texaco, 2=Arco, 3=Shell)
tanker=RECOVERYTANKER:New(UNIT:FindByName(cvnUnitName), "Texaco")
tanker:SetTakeoffHot()
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

function tanker:OnAfterStart(From,Event,To)
  superCarrier:SetRecoveryTanker(tanker)
end


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

---Forrestal Airboss---
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

local forrestal=AIRBOSS:New(cvUnitName)
forrestal:SetMenuRecovery(60, 25, true, 0)
forrestal:Load()
forrestal:SetFunkManOn()
forrestal:SetTACAN(58, "X", "ZIP")
forrestal:SetICLS(17,"FOR")
forrestal:SetLSORadio(265,AM)
forrestal:SetMarshalRadio(259, AM)
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
forrestal:Start()


------------Create AIRBOSS object------------

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
Tarawa:SetFunkManOn()
Tarawa:SetTACAN(108, "X", "LHA")
Tarawa:SetICLS(8)
Tarawa:Load()
Tarawa:SetLineupErrorThresholds(.5,-.5,-1,-2,-4,1,2,4)
Tarawa:SetStatusUpdateTime(1)
Tarawa:SetAutoSave()
Tarawa:SetRadioUnitName("UH1H Radio Relay")
Tarawa:SetMarshalRadio(306)
Tarawa:SetLSORadio(306)
Tarawa:SetSoundfilesFolder("Airboss Soundfiles/")
Tarawa:SetDespawnOnEngineShutdown()
Tarawa:SetMenuSingleCarrier()
Tarawa:SetMenuRecovery(60, 20, true)
Tarawa:Start()

-------JTAC Initial Spawn------------
do
Spawn_JTAC1 = SPAWN:New("JTAC1688")
Spawn_JTAC1:InitKeepUnitNames(true)
Spawn_JTAC1:InitLimit(1,0)
Spawn_JTAC1:InitDelayOn()
Spawn_JTAC1:OnSpawnGroup(
  function( SpawnGroup1688 )
	ctld.JTACAutoLase(SpawnGroup1688.GroupName, 1688, false, "all")
  end
)
Spawn_JTAC1:SpawnScheduled( 60,0 )

Spawn_JTAC2 = SPAWN:New("JTAC1588")
Spawn_JTAC2:InitKeepUnitNames(true)
Spawn_JTAC2:InitLimit(1,0)
Spawn_JTAC2:InitDelayOn()
Spawn_JTAC2:OnSpawnGroup(
  function( SpawnGroup1588 )
	ctld.JTACAutoLase(SpawnGroup1588.GroupName, 1588, false, "all")
  end
)
Spawn_JTAC2:SpawnScheduled( 60,0 )
end

--------------DiscordRangeReporting------------

--Range
RangeCau1=RANGE:New("Tuapse Range")
RangeCau1:SetFunkManOn()
RangeCau1:SetRangeRadius(15)
RangeCau1:AddBombingTargetGroup(GROUP:FindByName("Russian Forces"), 50, false)
RangeCau1:Start()

RangeCau2=RANGE:New("X-Airstrip Range")
RangeCau2:SetFunkManOn()
RangeCau2:SetRangeRadius(15)
RangeCau2:AddBombingTargetGroup(GROUP:FindByName("Russian Forces-1"), 50, false)
RangeCau2:Start()

local AAWRtargets={"AAWR Range", "AAWR Range-1", "AAWR Range-2", "AAWR Range-3", "AAWR Range-4", "AAWR Range-5", "AAWR Range-6", "AAWR Range-7", "AAWR Range-8", "AAWR Range-9", "AAWR Range-10", "AAWR Range-11", "AAWR Range-11", "AAWR Range-12", "AAWR Range-13", "AAWR Range-14", "NW Target", "N Target", "NE Target", "SE Target", "S Target", "SW Target"}
local strafepit={"AAWR Strafe Pit"}
AAWR=RANGE:New("AAWR Range")
AAWR:SetFunkManOn()
AAWR:AddBombingTargets(AAWRtargets)
AAWR:SetRangeRadius(15)
AAWR:SetRangeControl(305.000, "RangeRelay")
AAWR:SetInstructorRadio(264.000, "RangeRelay")
AAWR:AddStrafePit(strafepit,3000,300,nil,true,20,fouldist)
AAWR:Start()

----------------AWACS/big wing Tankers-----------------------
local zoneAWACS=ZONE:New("Zone AWACS")
local zoneTankerNorth=ZONE:New("Zone Tank North")
local zoneTankerSouth=ZONE:New("Zone Tank South")
local zoneTankerLow=ZONE:New("Zone Tank Low")


boomAltitude = 25000
drogueAltitude = 24000
tankerSpeed = 270
tankerTrackLength=15

---AWACS-----
-- E-3A Magic 51 - 32,000' 251.000Mhz
local auftragAWACS=AUFTRAG:NewAWACS(zoneAWACS:GetCoordinate(), 32000, 300, 125, 40)
auftragAWACS:SetTACAN(29, "DXS") 
auftragAWACS:SetRadio(251.000)      
local fsAWACS=FLIGHTGROUP:New("Magic")
fsAWACS:SetDefaultCallsign(CALLSIGN.AWACS.Magic, 5)
fsAWACS:AddMission(auftragAWACS)

-----North Tankers -----

--KC-135 Shell41 (North) TCN 65Y - 25,000' 265.0MHz (Hornet Ch.11)
local shellNorth=AUFTRAG:NewTANKER(zoneTankerNorth:GetCoordinate(), drogueAltitude, tankerSpeed, 180, tankerTrackLength)
shellNorth:SetTACAN(65, "SHN")
shellNorth:SetRadio(265)
local shell41=FLIGHTGROUP:New("Shell North")
shell41:SetDefaultCallsign(CALLSIGN.Tanker.Shell, 4)
shell41:Activate()
shell41:AddMission(shellNorth)
--KC-135 Texaco31 (North Boom) TCN 61Y - 26,000' 261.0MHz
local texNorth=AUFTRAG:NewTANKER(zoneTankerNorth:GetCoordinate(), boomAltitude, tankerSpeed, 180, tankerTrackLength)
texNorth:SetTACAN(61, "TXN")
texNorth:SetRadio(261)
local tex31=FLIGHTGROUP:New("Texaco North")
tex31:SetDefaultCallsign(CALLSIGN.Tanker.Texaco, 3)
tex31:Activate()
tex31:AddMission(texNorth)

-----South Tankers------
--KC-135 Shell21 (South) TCN 63Y - 25,000' 263.0MHz (Hornet Ch.15)
local shellSouth=AUFTRAG:NewTANKER(zoneTankerSouth:GetCoordinate(), drogueAltitude, tankerSpeed, 125, tankerTrackLength)
shellSouth:SetTACAN(63, "SHS")
shellSouth:SetRadio(263)
local shell21=FLIGHTGROUP:New("Shell South")
shell21:SetDefaultCallsign(CALLSIGN.Tanker.Shell, 2)
shell21:Activate()
shell21:AddMission(shellSouth)

--KC-135 Texaco21 (South Boom) TCN 67Y - 26,000' 267.0MHz
local texSouth=AUFTRAG:NewTANKER(zoneTankerSouth:GetCoordinate(), boomAltitude, tankerSpeed, 125, tankerTrackLength)
texSouth:SetTACAN(67, "TXS")
texSouth:SetRadio(267)
local tex21=FLIGHTGROUP:New("Texaco South")
tex21:SetDefaultCallsign(CALLSIGN.Tanker.Texaco, 2)
tex21:Activate()
tex21:AddMission(texSouth)

-----Low Tankers------
--KC-135 Texaco51 (Low Boom) TCN 57Y -12,000' 257.0 MHz
local texLow=AUFTRAG:NewTANKER(zoneTankerLow:GetCoordinate(), 12000, 250, 125, tankerTrackLength)
texLow:SetTACAN(57, "TXS")
texLow:SetRadio(257)
local tex51=FLIGHTGROUP:New("Texaco Low")
tex51:SetDefaultCallsign(CALLSIGN.Tanker.Texaco, 5)
tex51:Activate()
tex51:AddMission(texLow)

-----------------Tactical Menu----------------
--mainMenu = MENU_MISSION:New( "Tactical Menu" )
A2A = MENU_MISSION:New( "Air to Air Spawns")
BVR = MENU_MISSION:New( "BVR (Missles) ", A2A)
ACM = MENU_MISSION:New("ACM (Guns Only)", A2A)
Bombers = MENU_MISSION:New("Bomber Intercepts)", A2A)

A2G = MENU_MISSION:New( "Air to Ground Spawns")
SAM = MENU_MISSION:New("SAM Range", A2G)
AR_menu_root = MENU_MISSION:New("Armed Recon",A2G)
RANGE.MenuF10Root=MENU_MISSION:New("Basic Ranges",A2G).MenuPath
menuJTAC = MENU_MISSION:New("JTAC Refresh", A2G)
naval_menu = MENU_MISSION:New("Naval Ops", A2G)

menuFox=MENU_MISSION:New("Fox Trainer")
adminMenu = MENU_MISSION:New( "Admin")

----------------spawn zones------------------
zoneTable= { ZONE:New("DogfightZone"), ZONE:New("BomberZone")}

-------------------BVR aircraft - with missiles -------------------------
bvrTable = {"F-4 BVR", "F-5 BVR","F-15 BVR", "F-16 BVR", "F-18 BVR", "Mig21 BVR","Mig29 BVR" }
numberOfBVRAircraft = 7
redBVR = {}
for i=1,numberOfBVRAircraft do
  redBVR[i] = SPAWN:New(bvrTable[i]):InitLimit(3,0)
end

SpawnBVR = {}
function newBVR(grpname, grpspawn)
  SpawnBVR[grpname] = grpspawn:SpawnInZone(zoneTable[1],true,3000, 6000 ,nil)
  text = grpname
  MESSAGE:New(text.." spawned.",15,Info):ToAll()
end

local function destroyBVR(grpspawn)
for k, v in pairs(SpawnBVR) do
  v:Destroy()
  k = nil
end
end

for i=1,numberOfBVRAircraft do
  MENU_MISSION_COMMAND:New (bvrTable[i], BVR, newBVR, bvrTable[i], redBVR[i])
end
MENU_MISSION_COMMAND:New ("Remove BVR Spawns", BVR, destroyBVR)

--------------------ACM Aircraft - no missiles -------------------
acmTable = {"F-4 ACM", "F-5 ACM", "F-15 ACM" , "F-16 ACM", "F-18 ACM", "Mig21 ACM", "Mig29 ACM"}
numberOfACMAircraft = 7
redACM = {}
for i=1,numberOfACMAircraft do
  redACM[i] = SPAWN:New(acmTable[i]):InitLimit(3,0)
end

SpawnACM = {}
function newACM(grpname, grpspawn)
  SpawnACM[grpname] = grpspawn:SpawnInZone(zoneTable[1],true,3000, 6000 ,nil)
  text = grpname
  MESSAGE:New(text.." spawned.",15,Info):ToAll()
end

local function destroyACM(grpspawn)
for k, v in pairs(SpawnACM) do
  v:Destroy()
  k = nil
end
end

for i=1,numberOfACMAircraft do
  MENU_MISSION_COMMAND:New (acmTable[i], ACM, newACM, acmTable[i], redACM[i])
end
MENU_MISSION_COMMAND:New ("Remove ACM Spawns", ACM, destroyACM)

----------------Bombers--------------------
bombTable = {"TU-22 Blinder", "TU-95 Bear" , "TU-160 Blackjack" , "B-1B", "B-52" }
numberOfBombers = 5
redBomb = {}
for i=1,numberOfBombers do
  redBomb[i] = SPAWN:New(bombTable[i]):InitLimit(3,0)
end

SpawnBomb = {}
function newBomber(grpname, grpspawn)
  SpawnBomb[grpname] = grpspawn:SpawnInZone(zoneTable[2],true,3000, 6000 ,nil)
  text = grpname
  MESSAGE:New("Scramble fighters, "..text.." detected, BRA 320 for 135 at 22,000 from the Anapa TCN",15,Info):ToAll()
end

local function destroyBombers(grpspawn)
for k, v in pairs(SpawnBomb) do
  v:Destroy()
  k = nil
end
end

for i=1,numberOfBombers do
  MENU_MISSION_COMMAND:New (bombTable[i], Bombers, newBomber, bombTable[i], redBomb[i])
end
MENU_MISSION_COMMAND:New ("Remove Spawned Bombers", Bombers, destroyBombers)

------------------SAM Sites----------------------
samTable = { "SA-2", "SA-6", "SA-8", "SA-10", "SA-11", "SA-15"}
--samZoneTable = {ZONE:New("Sam_Zone_2"),ZONE:New("Sam_Zone_3"), ZONE:New("Sam_Zone_4")}
samZoneTable = {ZONE:New("Sam_Zone")}

redSAM = {}
for i=1,6 do
  redSAM[i] = SPAWN:New(samTable[i]):InitLimit(50,0):InitAIOn():InitRandomizeZones(samZoneTable)
end

SAMSpawn = {}
function newSAMSite(grpname, grpspawn)
  SAMSpawn[grpname] = grpspawn:Spawn():OptionAlarmStateRed()
  text = grpname
  MESSAGE:New(text.." Group Spawned",15,Info):ToAll()
end

local function destroySAM(grpspawn)
for k, v in pairs(SAMSpawn) do
  v:Destroy()
  k = nil
end
end

for i=1,6 do
  MENU_MISSION_COMMAND:New (samTable[i], SAM, newSAMSite, samTable[i], redSAM[i])
end
MENU_MISSION_COMMAND:New ("Remove Spawned SAM Sites", SAM, destroySAM)

-------JTAC respawn------------
function launchJTAC1()
  Spawn_JTAC1 = SPAWN:New("JTAC1")
    :InitKeepUnitNames(true)
    :InitLimit(1,0)
    :OnSpawnGroup(
      function( SpawnGroup )
        ctld.JTACAutoLase(SpawnGroup.GroupName, 1388, false, "all")
      end
    )
    :SpawnScheduled( 60,0 )
end
MENU_MISSION_COMMAND:New ("Relaunch JTAC1", menuJTAC, launchJTAC1 )

function launchJTAC2()
  Spawn_JTAC2 = SPAWN:New("JTAC2")
    :InitKeepUnitNames(true)
    :InitLimit(1,0)
    :OnSpawnGroup(
      function( SpawnGroup )
        ctld.JTACAutoLase(SpawnGroup.GroupName, 1388, false, "all")
      end
    )
    :SpawnScheduled( 60,0 )
end
MENU_MISSION_COMMAND:New ("Relaunch JTAC2", menuJTAC, launchJTAC2 )

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

-------------Ranges---------------------------------
--Range 5 Ships--
local function range_5_Ships()
  range_5_menu_Ships:Remove()
  trigger.action.setUserFlag(21500,true)
end

range_5_menu_Ships = MENU_MISSION_COMMAND:New("Activate Naval Targets North",naval_menu,range_5_Ships)

--Range 6 Ships--
local function range_6_Ships()
  range_6_menu_Ships:Remove()
  trigger.action.setUserFlag(21600,true)
end

range_6_menu_Ships = MENU_MISSION_COMMAND:New("Activate Naval Targets South",naval_menu,range_6_Ships)

------------Scud Range------------------------
--Flag is true 20053, then flag set random value --> flag equals 20050, 1, group activate
local function range_1_AR()
  range_1_menu_AR:Remove()
  trigger.action.setUserFlag(20053,true)
  MESSAGE:New("SCUD launchers sighted in the vicinity of Zugdidi",30,Info):ToAll()
  if range_1_menu_AR_Zugdidi_reattack then
  --AR_menu_root:Remove()
  end

end

range_1_menu_AR = MENU_MISSION_COMMAND:New("Activate AR (SCUD hunt Zugdidi)",AR_menu_root,range_1_AR)

local SPAWN_1_1 = SPAWN:New("R1_AR_Recce_1")
local SPAWN_1_2 = SPAWN:New("R1_AR_Recce_2")
local SPAWN_1_3 = SPAWN:New("R1_AR_MBT_PLT1")
local SPAWN_1_4 = SPAWN:New("R1_AR_IFV_PLT2")
local SPAWN_1_5 = SPAWN:New("R1_AR_IFV_PLT3")
local SPAWN_1_6 = SPAWN:New("R1_AR_IFV_PLT4")

local function range_1_AR_Zugdidi_reattack()
  range1_respawn_counter= range1_respawn_counter+1
  if range1_respawn_counter < 4 then
    SPAWN_1_1:Spawn()
    SPAWN_1_2:Spawn()
    SPAWN_1_3:Spawn()
    SPAWN_1_4:Spawn()
    SPAWN_1_5:Spawn()
    SPAWN_1_6:Spawn()
	MESSAGE:New("Armed reconnaissance sighted approaching Zugdidi from Senaki",30,Info):ToAll()
  else if range_1_menu_AR_Zugdidi_reattack  then 
	range_1_menu_AR_Zugdidi_reattack:Remove()
    end
  end
end

local function range_1_AR_Zugdidi()
  range_1_menu_AR_Zugdidi:Remove()
  range_1_menu_AR_Zugdidi_reattack = MENU_MISSION_COMMAND:New("Range 1 AR Attack on Zugdidi, spawn reinforcements",AR_menu_root,range_1_AR_Zugdidi_reattack)
  SPAWN_1_1:Spawn()
  SPAWN_1_2:Spawn()
  SPAWN_1_3:Spawn()
  SPAWN_1_4:Spawn()
  SPAWN_1_5:Spawn()
  SPAWN_1_6:Spawn()
  range1_respawn_counter = 1
  MESSAGE:New("Armed reconnaissance sighted approaching Zugdidi from Senaki",30,Info):ToAll()
end

range_1_menu_AR_Zugdidi = MENU_MISSION_COMMAND:New("Range 1 AR Attack on Zugdidi",AR_menu_root,range_1_AR_Zugdidi)

-----------Range 2 Il'skiy------------------------

local function range_2_AR()
  range_2_menu_AR:Remove()
  trigger.action.setUserFlag(20063,true)
  MESSAGE:New("SCUD launchers sighted in the vicinity of Il'skiy",30,Info):ToAll()
  if range_2_menu_AR_Ilskiy_reattack then
  --AR_menu_root:Remove()
  end

end

range_2_menu_AR = MENU_MISSION_COMMAND:New("Activate AR (SCUD hunt Il'skiy)",AR_menu_root,range_2_AR)

local SPAWN_2_1 = SPAWN:New("R2_AR_Recce_1")
local SPAWN_2_2 = SPAWN:New("R2_AR_Recce_2")
local SPAWN_2_3 = SPAWN:New("R2_AR_MBT_PLT1")
local SPAWN_2_4 = SPAWN:New("R2_AR_IFV_PLT2")
local SPAWN_2_5 = SPAWN:New("R2_AR_IFV_PLT3")
local SPAWN_2_6 = SPAWN:New("R2_AR_IFV_PLT4")

local function range_2_AR_Ilskiy_reattack()
  range2_respawn_counter = range2_respawn_counter+1
  if range2_respawn_counter < 4 then
    SPAWN_2_1:Spawn()
    SPAWN_2_2:Spawn()
    SPAWN_2_3:Spawn()
    SPAWN_2_4:Spawn()
    SPAWN_2_5:Spawn()
    SPAWN_2_6:Spawn()
	MESSAGE:New("Armed reconnaissance sighted approaching Il'skiy from the east",30,Info):ToAll()
  else if range_2_menu_AR_Ilskiy_reattack  then 
	range_2_menu_AR_Ilskiy_reattack:Remove()
    end
  end
end

local function range_2_AR_Ilskiy()
  range_2_menu_AR_Ilskiy:Remove()
  range_2_menu_AR_Ilskiy_reattack = MENU_MISSION_COMMAND:New("Range 2 AR Attack on Il'skiy, spawn reinforcements",AR_menu_root,range_2_AR_Ilskiy_reattack)
  SPAWN_2_1:Spawn()
  SPAWN_2_2:Spawn()
  SPAWN_2_3:Spawn()
  SPAWN_2_4:Spawn()
  SPAWN_2_5:Spawn()
  SPAWN_2_6:Spawn()
  MESSAGE:New("Armed reconnaissance sighted approaching of Ilskiy from the south",30,Info):ToAll()
  range2_respawn_counter = 1
end

range_2_menu_AR_Ilskiy = MENU_MISSION_COMMAND:New("Range 2 AR Attack on Ilskiy",AR_menu_root,range_2_AR_Ilskiy)
