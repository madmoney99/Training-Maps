

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
menuRestart=MENU_MISSION:New("Change Mission", adminMenu)

function ChangeMap_PGmission()
  PGFlag:Set(true)
end
restartMenu1 = MENU_MISSION_COMMAND:New("Load PG VFR Misssion", menuRestart,ChangeMap_PGmission)

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
restartMenu5 = MENU_MISSION_COMMAND:New("Load Falklands VFR Mission", menuRestart,ChangeMap_Falklandsmission)
