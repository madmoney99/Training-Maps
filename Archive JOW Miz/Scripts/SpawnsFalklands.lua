-----------------Tactical Menu----------------
--mainMenu = MENU_MISSION:New( "Tactical Menu" )
A2A = MENU_MISSION:New( "Air to Air Spawns")
--BVR = MENU_MISSION:New( "BVR (Missles) ", A2A)
--ACM = MENU_MISSION:New("ACM (Guns Only)", A2A)
Bombers = MENU_MISSION:New("Bomber Intercepts")

A2G = MENU_MISSION:New( "Air to Ground Spawns")
SAM = MENU_MISSION:New("SAM Range", A2G)
-- menuJTAC = MENU_MISSION:New("JTAC Refresh", A2G)


menuFox=MENU_MISSION:New("Fox Trainer")
adminMenu = MENU_MISSION:New( "Admin")


--------------------ACM Aircraft - no missiles -------------------
a2aTable = {"F-5 ACM", "F-15 ACM" , "F-16 ACM", "Mig21 ACM", "F-4 BVR", "F-15 BVR", "F-16 BVR", "F-18 BVR", "Mig21 BVR","Mig29 BVR"}
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

----------------Bombers--------------------
bombTable = {"TU-22 Blinder", "TU-95 Bear" , "TU-160 Blackjack" , "B-1B", "B-52" }
bombZone =ZONE:New("BomberZone")
redBomb = {}
for i=1,#bombTable do
  redBomb[i] = SPAWN:New(bombTable[i]):InitLimit(3,0)
end

SpawnBomb = {}
function newBomber(grpname, grpspawn)
  SpawnBomb[grpname] = grpspawn:SpawnInZone(bombZone,true,3000, 6000 ,nil)
  text = grpname
  MESSAGE:New("Scramble fighters, "..text.." detected, BRA 125 for 35 at 22,000 from the Mount Pleasant TCN",15,Info):ToAll()
end

local function destroyBombers(grpspawn)
for k, v in pairs(SpawnBomb) do
  v:Destroy()
  k = nil
end
end

for i=1,#bombTable do
  MENU_MISSION_COMMAND:New (bombTable[i], Bombers, newBomber, bombTable[i], redBomb[i])
end
MENU_MISSION_COMMAND:New ("Remove Spawned Bombers", Bombers, destroyBombers)

------------------SAM Sites----------------------
samTable = { "SA-2", "SA-6", "SA-8", "SA-10", "SA-11", "SA-15"}
--samZoneTable = {ZONE:New("Sam_Zone_2"),ZONE:New("Sam_Zone_3"), ZONE:New("Sam_Zone_4")}
samZoneTable = {ZONE:New("Sam_Zone")}

redSAM = {}
for i=1,#samTable do
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

for i=1,#samTable do
  MENU_MISSION_COMMAND:New (samTable[i], SAM, newSAMSite, samTable[i], redSAM[i])
end
MENU_MISSION_COMMAND:New ("Remove Spawned SAM Sites", SAM, destroySAM)

--Ships
Ship1 = GROUP:FindByName( "ComNav-1" )
Ship1:PatrolZones( { ZONE:New( "NWShippingLane" ) }, 120, "Vee" )
Ship2 = GROUP:FindByName( "ComNav-2" )
Ship2:PatrolZones( { ZONE:New( "SShippingLane" ) }, 120, "Vee" )


-- -------JTAC respawn------------
-- function launchJTAC1()
  -- Spawn_JTAC1 = SPAWN:New("JTAC1688")
    -- :InitKeepUnitNames(true)
    -- :InitLimit(1,0)
    -- :OnSpawnGroup(
      -- function( SpawnGroup )
        -- ctld.JTACAutoLase(SpawnGroup.GroupName, 1688, false, "all")
      -- end
    -- )
    -- :SpawnScheduled( 60,0 )
-- end
-- MENU_MISSION_COMMAND:New ("Relaunch JTAC1", menuJTAC, launchJTAC1 )

-- function launchJTAC2()
  -- Spawn_JTAC2 = SPAWN:New("JTAC1588")
    -- :InitKeepUnitNames(true)
    -- :InitLimit(1,0)
    -- :OnSpawnGroup(
      -- function( SpawnGroup )
        -- ctld.JTACAutoLase(SpawnGroup.GroupName, 1588, false, "all")
      -- end
    -- )
    -- :SpawnScheduled( 60,0 )
-- end
-- MENU_MISSION_COMMAND:New ("Relaunch JTAC2", menuJTAC, launchJTAC2 )

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


----------------Restart menu---------------------
PGFlag = USERFLAG:New("16000")
NTTRFlag = USERFLAG:New("16001")
BlackSeaFlag = USERFLAG:New("16002")
MarianasFlag = USERFLAG:New("16003")
FalklandsFlag = USERFLAG:New("16004")

dayFlag = USERFLAG:New("16005")
lowIFRFlag = USERFLAG:New("16010")
lightIFRFlag = USERFLAG:New("16015")
nightFlag = USERFLAG:New("16020")
local menuRestart=MENU_MISSION:New("Change Mission")

function ChangeMap_PGmission()
  PGFlag:Set(true)
end
restartMenu1 = MENU_MISSION_COMMAND:New("Load PG VFR Mission", menuRestart,ChangeMap_PGmission)

function ChangeMap_NTTRmission()
  NTTRFlag:Set(true)
end
restartMenu2 = MENU_MISSION_COMMAND:New("Load NTTR VFR Mission", menuRestart,ChangeMap_NTTRmission)

-- function ChangeMap_BlackSea_mission()
  -- BlackSeaFlag:Set(true)
-- end
-- restartMenu3 = MENU_MISSION_COMMAND:New("Load Caucasus VFR Mission", menuRestart,ChangeMap_BlackSea_mission)

function ChangeMap_Marianas_mission()
  MarianasFlag:Set(true)
end
restartMenu4 = MENU_MISSION_COMMAND:New("Load Marianas VFR Mission", menuRestart,ChangeMap_Marianas_mission)

function ChangeMap_Falklandsmission()
  FalklandsFlag:Set(true)
end
restartMenu9 = MENU_MISSION_COMMAND:New("Load Falklands VFR Mission", menuRestart,ChangeMap_Falklandsmission)

function load_Day_mission()
  dayFlag:Set(true)
end
restartMenu5 = MENU_MISSION_COMMAND:New("Load VFR Mission", menuRestart,load_Day_mission)

function load_HardIFR_mission()
  lowIFRFlag:Set(true)
end
restartMenu6 = MENU_MISSION_COMMAND:New("Load IFR Mission", menuRestart,load_HardIFR_mission)

function load_LightIFR_mission()
  lightIFRFlag:Set(true)
end
restartMenu7 = MENU_MISSION_COMMAND:New("Load MVFR Mission", menuRestart,load_LightIFR_mission)

function load_Night_mission()
  nightFlag:Set(true)
end
restartMenu8 = MENU_MISSION_COMMAND:New("Load Night Mission", menuRestart,load_Night_mission)
