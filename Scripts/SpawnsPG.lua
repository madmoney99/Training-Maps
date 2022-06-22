-----------------Tactical Menu----------------
--mainMenu = MENU_MISSION:New( "Tactical Menu" )

A2A = MENU_MISSION:New( "Air to Air Spawns")
BVR = MENU_MISSION:New( "BVR (Missles) ", A2A)
ACM = MENU_MISSION:New("ACM (Guns Only)", A2A)
Bombers = MENU_MISSION:New("Bomber Intercepts)", A2A)


A2G = MENU_MISSION:New( "Air to Ground Spawns")
SAM = MENU_MISSION:New("SAM Range", A2G)
--AR_menu_root = MENU_MISSION:New("Armed Recon",A2G)
RANGE.MenuF10Root=MENU_MISSION:New("Basic Ranges",A2G).MenuPath
menuJTAC = MENU_MISSION:New("JTAC Refresh", A2G)

--naval_menu = MENU_MISSION:New("Naval Ops")
--alertLaunch = MENU_MISSION_COMMAND:New ("Launch the Alert Aircraft", mainMenu, launchEvent )
menuFox=MENU_MISSION:New("Fox Trainer")
----------------spawn zones------------------
zoneTable= { ZONE:New("DogfightZone"), ZONE:New("BomberZone")}

-------------------BVR aircraft - with missiles -------------------------
bvrTable = {"F-4 BVR", "F-5 BVR","F-15 BVR", "F-16 BVR", "F-18 BVR", "Mig21 BVR","Mig29 BVR" }

redBVR = {}
for i=1,7 do
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

for i=1,7 do
  MENU_MISSION_COMMAND:New (bvrTable[i], BVR, newBVR, bvrTable[i], redBVR[i])
end
MENU_MISSION_COMMAND:New ("Remove BVR Spawns", BVR, destroyBVR)

--------------------ACM Aircraft - no missiles -------------------
acmTable = {"F-4 ACM", "F-5 ACM", "F-15 ACM" , "F-16 ACM", "F-18 ACM", "Mig21 ACM", "Mig29 ACM"}

redACM = {}
for i=1,7 do
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

for i=1,7 do
  MENU_MISSION_COMMAND:New (acmTable[i], ACM, newACM, acmTable[i], redACM[i])
end
MENU_MISSION_COMMAND:New ("Remove ACM Spawns", ACM, destroyACM)

----------------Bombers--------------------
bombTable = {"TU-22 Blinder", "TU-95 Bear" , "TU-160 Blackjack" , "B-1B", "B-52" }

redBomb = {}
for i=1,5 do
  redBomb[i] = SPAWN:New(bombTable[i]):InitLimit(3,0)
end

SpawnBomb = {}
function newBomber(grpname, grpspawn)
  SpawnBomb[grpname] = grpspawn:SpawnInZone(zoneTable[2],true,3000, 6000 ,nil)
  text = grpname
  MESSAGE:New(text.." Inbound to Al Minhad from Bandar Abbas",15,Info):ToAll()
end

local function destroyBombers(grpspawn)
for k, v in pairs(SpawnBomb) do
  v:Destroy()
  k = nil
end
end

for i=1,5 do
  MENU_MISSION_COMMAND:New (bombTable[i], Bombers, newBomber, bombTable[i], redBomb[i])
end
MENU_MISSION_COMMAND:New ("Remove Spawned Bombers", Bombers, destroyBombers)

------------------SAM Sites----------------------
samTable = { "SA-2", "SA-6", "SA-8", "SA-10", "SA-11", "SA-15"}
samZoneTable = {ZONE:New("Sam_Zone_3")}

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
  Spawn_JTAC1 = SPAWN:New("JTAC1388")
    :InitKeepUnitNames(true)
    :InitLimit(1,0)
    :OnSpawnGroup(
      function( SpawnGroup )
        ctld.JTACAutoLase(SpawnGroup.GroupName, 1388, false, "all")
      end
    )
    :SpawnScheduled( 60,0 )
end
MENU_MISSION_COMMAND:New ("Relaunch JTAC1388", menuJTAC, launchJTAC1 )

function launchJTAC2()
  Spawn_JTAC2 = SPAWN:New("JTAC1688")
    :InitKeepUnitNames(true)
    :InitLimit(1,0)
    :OnSpawnGroup(
      function( SpawnGroup )
        ctld.JTACAutoLase(SpawnGroup.GroupName, 1688, false, "all")
      end
    )
    :SpawnScheduled( 60,0 )
end
MENU_MISSION_COMMAND:New ("Relaunch JTAC1688", menuJTAC, launchJTAC2 )

------------------Fox Missile Trainer-------------

FoxRunning = false
function FoxOn()
  if not FoxRunning then
	-- Protect all blue AI.
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
  end
end
MENU_MISSION_COMMAND:New("Fox On", menuFox,FoxOn)

function FoxOff()
  foxTrainer:__Stop(1)
  MESSAGE:New("Fox Trainer Off",15,Info):ToAll()
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
--Range 1 Ships--
local function range_1_Ships()
  range_1_menu_Ships:Remove()
  trigger.action.setUserFlag(56,true)
  MESSAGE:New("Enemy cargo ships spotted 35NM NW of Al Minhad",30,Info):ToAll()
end

range_1_menu_Ships = MENU_MISSION_COMMAND:New("Activate ship targets in Range 1",A2G,range_1_Ships)


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

-- function ChangeMap_PGmission()
  -- PGFlag:Set(true)
-- end
-- restartMenu1 = MENU_MISSION_COMMAND:New("Load PG Day Misssion", menuRestart,ChangeMap_PGmission)

function ChangeMap_NTTRmission()
  NTTRFlag:Set(true)
end
restartMenu2 = MENU_MISSION_COMMAND:New("Load NTTR VFR Misssion", menuRestart,ChangeMap_NTTRmission)

function ChangeMap_BlackSea_mission()
  BlackSeaFlag:Set(true)
end
restartMenu3 = MENU_MISSION_COMMAND:New("Load Caucasus VFR Misssion", menuRestart,ChangeMap_BlackSea_mission)

function ChangeMap_Marianas_mission()
  MarianasFlag:Set(true)
end
restartMenu4 = MENU_MISSION_COMMAND:New("Load Marianas VFR Misssion", menuRestart,ChangeMap_Marianas_mission)

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
