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
bvrTable = {"F-4 BVR", "F-5 BVR","F-14 BVR", "F-15 BVR", "F-16 BVR", "F-18 BVR","Mig21 BVR","Mig29 BVR" }

redBVR = {}
for i=1,8 do
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

for i=1,8 do
  MENU_MISSION_COMMAND:New (bvrTable[i], BVR, newBVR, bvrTable[i], redBVR[i])
end
MENU_MISSION_COMMAND:New ("Remove BVR Spawns", BVR, destroyBVR)

--------------------ACM Aircraft - no missiles -------------------
acmTable = {"F-4 ACM", "F-5 ACM", "F-14 ACM", "F-15 ACM" , "F-16 ACM", "F-18 ACM", "Mig21 ACM", "Mig29 ACM"}

redACM = {}
for i=1,8 do
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

for i=1,8 do
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
  MESSAGE:New("Scramble fighters, "..text.." detected, Inbound to Nellis from Area 51.",15,Info):ToAll()
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
samZoneTable = {ZONE:New("Sam_Zone"),ZONE:New("Sam_Zone_2")}

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
        ctld.JTACAutoLase(SpawnGroup.GroupName, 1488, false, "all")
      end
    )
    :SpawnScheduled( 60,0 )
end
MENU_MISSION_COMMAND:New ("Relaunch JTAC2", menuJTAC, launchJTAC2 )

function launchJTAC3()
  Spawn_JTAC3 = SPAWN:New("JTAC3")
    :InitKeepUnitNames(true)
    :InitLimit(1,0)
    :OnSpawnGroup(
      function( SpawnGroup )
        ctld.JTACAutoLase(SpawnGroup.GroupName, 1588, false, "all")
      end
    )
    :SpawnScheduled( 60,0 )
end
MENU_MISSION_COMMAND:New ("Relaunch JTAC3", menuJTAC, launchJTAC3 )

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

------------------AiD-------------------------
---- Define a SET_GROUP object that builds a collection of groups that define the EWR network.
-- Here we build the network with all the groups that have a name starting with DF CCCP AWACS and DF CCCP EWR.
DetectionSetGroup = SET_GROUP:New()
DetectionSetGroup:FilterPrefixes( { "REDFOR AWACS", "REDFOR EWR" } )
DetectionSetGroup:FilterStart()

Detection = DETECTION_AREAS:New( DetectionSetGroup, 30000 )

-- Setup the A2A dispatcher, and initialize it.
A2ADispatcher = AI_A2A_DISPATCHER:New( Detection )

-- Initialize the dispatcher, setting up a border zone. This is a polygon,
-- which takes the waypoints of a late activated group with the name CCCP Border as the boundaries of the border area.
-- Any enemy crossing this border will be engaged.
REDFORBorderZone = ZONE_POLYGON:New( "REDFOR Border", GROUP:FindByName( "REDFOR Border" ) )
A2ADispatcher:SetBorderZone( REDFORBorderZone )

-- Initialize the dispatcher, setting up a radius of 100km where any airborne friendly
-- without an assignment within 100km radius from a detected target, will engage that target.
A2ADispatcher:SetEngageRadius( 200000 )

-- Setup the squadrons.
A2ADispatcher:SetSquadron( "REDFOR 1", AIRBASE.Nevada.Tonopah_Test_Range_Airfield, "REDFOR 1" )
--A2ADispatcher:SetSquadron( "REDFOR 2", AIRBASE.Nevada.Tonopah_Test_Range_Airfield, "REDFOR 2", 1 )
A2ADispatcher:SetSquadron( "REDFOR 3", AIRBASE.Nevada.Mina_Airport , "REDFOR 3" )

-- Setup the overhead
A2ADispatcher:SetSquadronOverhead( "REDFOR 1", 0.75 )
--A2ADispatcher:SetSquadronOverhead( "REDFOR 2", 0.5 )
A2ADispatcher:SetSquadronOverhead( "REDFOR 3", 0.75 )

-- Setup the Grouping
A2ADispatcher:SetSquadronGrouping( "REDFOR 1", 2 )
--A2ADispatcher:SetSquadronGrouping( "REDFOR 2", 1 )
A2ADispatcher:SetSquadronGrouping( "REDFOR 3", 2 )

--Takeoff
A2ADispatcher:SetSquadronTakeoffInAir( "REDFOR 1" )
--A2ADispatcher:SetSquadronTakeoffInAir( "REDFOR 2" )
A2ADispatcher:SetSquadronTakeoffInAir( "REDFOR 3" )

--GCI
--A2ADispatcher:SetSquadronGci( "REDFOR 2", 900, 1200 )

--CAP
CAPZoneNorth = ZONE_POLYGON:New( "CAP ZONE NORTH", GROUP:FindByName( "CAP ZONE NORTH" ) )
A2ADispatcher:SetSquadronCap( "REDFOR 3", CAPZoneNorth, 4000, 10000, 500, 600, 800, 900, "BARO" )
A2ADispatcher:SetSquadronCapInterval( "REDFOR 3", 1, 300, 600, 1 )


CAPZoneSouth = ZONE_POLYGON:New( "CAP ZONE SOUTH", GROUP:FindByName( "CAP ZONE SOUTH" ) )
A2ADispatcher:SetSquadronCap( "REDFOR 1", CAPZoneSouth, 4000, 10000, 500, 600, 800, 900, "BARO" )
A2ADispatcher:SetSquadronCapInterval( "REDFOR 1", 1, 300, 600, 1 )

--Landing
A2ADispatcher:SetSquadronLandingAtEngineShutdown( "REDFOR 1" )
--A2ADispatcher:SetSquadronLandingAtEngineShutdown( "REDFOR 2" )
A2ADispatcher:SetSquadronLandingAtEngineShutdown( "REDFOR 3" )

function aidNorthOn()
  A2ADispatcher:Start()
end
MENU_MISSION_COMMAND:New("Red Air Defence On", aidMenu,aidNorthOn)

function aidNorthOff()
  A2ADispatcher:Stop()
end
MENU_MISSION_COMMAND:New("Red Air Defence Off", aidMenu,aidNorthOff)

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
restartMenu1 = MENU_MISSION_COMMAND:New("Load PG VFR Misssion", menuRestart,ChangeMap_PGmission)

-- function ChangeMap_NTTRmission()
  -- NTTRFlag:Set(true)
-- end
-- restartMenu2 = MENU_MISSION_COMMAND:New("Load NTTR VFR Misssion", menuRestart,ChangeMap_NTTRmission)

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

------------------Range Script-------------------
bombingRange=RANGE:New("Mercury Range")
bombTargets = {'S1', 'S2', 'N1', 'N2', 'W1', 'W2', 'E1', 'E2'}
bombingRange:AddBombingTargets(bombTargets, 20, false)
strafe_targets_west = {'StrafePitWest'}
strafe_target_east = {'StrafePitEast'}
bombingRange:AddStrafePit(strafe_targets_west, 4000,350, nil, false, 20, 600)
bombingRange:AddStrafePit(strafe_target_east, 4000,350, nil, false, 20, 600)

-- function bombingRange:OnAfterEnterRange(From, Event, To, player)
 -- local text=string.format("%s has entered the %s", player.playername, self.rangename)  
 -- HypeMan.sendBotMessage(text)
-- end

-- function bombingRange:OnAfterExitRange(From, Event, To, player)
 -- local text=string.format("%s has exited the %s Range", player.playername, self.rangename)  
 -- HypeMan.sendBotMessage(text)
-- end

function bombingRange:OnAfterImpact(From, Event, To, result, player)  
   result.messageType = 4
   result.callsign = player.playername
   result.theatre = env.mission.theatre
   result.rangeName = self.rangename
   result.missionType = "1"
   result.mizTime = UTILS.SecondsToClock(timer.getAbsTime())
   result.midate=UTILS.GetDCSMissionDate()
   result.strafeAccuracy = "N/A"
   result.strafeQuality = "N/A"
   result.altitude = playerAltForRangeData*3.28084
   result.pitch = playerPitchForRangeData
   result.heading = playerHeadingForRangeData
   _playername = player.playername 
   result.strafeScore = "N/A"
   result.bombScore = "notSet"

   if result.quality == "SHACK" then
       result.bombScore = "5"
   elseif result.quality == "EXCELLENT" then
       result.bombScore = "4"
   elseif result.quality == "GOOD" then
       result.bombScore = "3"
   elseif result.quality == "INEFFECTIVE" then
       result.bombScore = "2"
   elseif result.quality == "POOR" then
       result.bombScore = "1"	
   end

   HypeMan.sendBotTable(result) --added 4/23/21
   env.info('Range_Discord_reporting_script RANGE Script: SENDING HypeMan.sendBotTable(result)')
   self:_SaveTargetSheet(_playername, result) 
   
   if result.distance <= 1.52 then
       trigger.action.outSound("Airboss Soundfiles/sureshot.ogg")
   end
end

--STRAFING RANGE--
local rollIn_zone_lat_long = COORDINATE:NewFromLLDD(43.803889,44.545)--41 53.062, 41 48.577
local strafe_pit_roll_In_vec2 = rollIn_zone_lat_long:GetVec2()
local strafe_roll_in_zone = ZONE_RADIUS:New("strafe_roll_in_zone", strafe_pit_roll_In_vec2, 700)

local strafezone = ZONE:New("StrafeZone")

function displayStrafeResults()
       local name = Straferesult.player
       local quality = Straferesult.roundsQuality
       
   if  clientStrafed == true then
       result={}
       result.messageType = 4 
       result.callsign = Straferesult.player
       result.airframe = Straferesult.airframe 
       result.theatre = env.mission.theatre
       result.rangeName = Straferesult.rangename
       result.missionType = "1"
       result.mizTime = UTILS.SecondsToClock(timer.getAbsTime())--mist.getClockString()
       result.strafeAccuracy = Straferesult.strafeAccuracy 
       result.midate=UTILS.GetDCSMissionDate()
       result.strafeScore = "notSet"
       result.bombScore = "N/A"
       if invalidStrafe == true then
           result.roundsQuality = "* INVALID - PASSED FOUL LINE *"
           result.strafeScore = "0"
       else
           result.roundsQuality = Straferesult.roundsQuality
           
           if result.roundsQuality == "DEADEYE PASS" then
               result.strafeScore = "5"
               result.roundsQuality = "DEADEYE"
           elseif result.roundsQuality == "EXCELLENT PASS" then
               result.strafeScore = "4"
               result.roundsQuality = "EXCELLENT"
           elseif result.roundsQuality == "GOOD PASS" then
               result.strafeScore = "3"
               result.roundsQuality = "GOOD"
           elseif result.roundsQuality == "INEFFECTIVE PASS" then
               result.strafeScore = "2"
               result.roundsQuality = "INEFFECTIVE"
           elseif result.roundsQuality == "POOR PASS" then
               result.strafeScore = "1"
               result.roundsQuality = "POOR"
           elseif result.roundsQuality == "* INVALID - PASSED FOUL LINE *" then
               result.strafeScore = "0"
           else
               result.strafeScore = "ERROR"
           end
       end

       result.quality = Straferesult.quality 
       result.roundsFired = Straferesult.roundsFired
       result.roundsHit = Straferesult.roundsHit 

       if result.airframe == "FA-18C_hornet" or "F-14A-135-GR" or "F-14B" or "F-16C_50" or "F-15C" or "VSN_F104G" then
            result.weapon = "M61A1 Vulcan"
        elseif result.airframe == "AV8BNA" then
            result.weapon = "GAU-12 Equalizer"
        elseif result.airframe == "M-2000C" then
            result.weapon = "DEFA 554"
        elseif result.airframe == "F-5E-3" then
            result.weapon = "20 mm M39A2 Revolver cannon"
        elseif result.airframe == "A-10C" or "A-10C_2" then
            result.weapon = "GAU-8/A Avenger"
        elseif result.airframe == "UH-1H" then
            result.weapon = "M134 minigun" 
        elseif result.airframe == "P-51D-30-NA" then
            result.weapon = "0.50 caliber AN/M2 Browning machine guns"
        elseif result.airframe == "F-86" then
            result.weapon = "0.50 caliber AN/M3 Browning machine guns"
        elseif result.airframe == "A-4E-C" then
			result.weapon = "Colt Mk 12 cannon"			
        else
            result.weapon = "(unknown) CANNON"
        end
       
       result.radial = 0
       result.distance = 0
       result.altitude = playerAltForRangeData*3.28084
       result.pitch = playerPitchForRangeData
       result.heading = playerHeadingForRangeData --Added 5/21/21
       env.info('Range_Discord_reporting_script RANGE Script: SENDING: HypeMan.sendBotTable(result)')

       HypeMan.sendBotTable(result) --added 4/23/21 --This sends data to hypemanlistener.lua for Discord message creation and data for gsheets
       env.info('Range_Discord_reporting_script RANGE Script: SENT:  HypeMan.sendBotTable(result)')

       if result.strafeAccuracy >= 90 then
           env.info('Range_Discord_reporting_script RANGE Script: STRAFE:  accuracy greater than or equal to 90% ')
           dead_eye()
           trigger.action.outSound("Airboss Soundfiles/sureshot.ogg")
       else
           env.info('Range_Discord_reporting_script RANGE Script: STRAFE:  accuracy less than 75% ')
       end

       result = nil
   else
       env.info('Range_Discord_reporting_script RANGE Script: STRAFE:   NOT SHOWING RESULTS, A FALSE/UNINTENDED STRAFE RUN ')
       trigger.action.outText('STRAFE:  NOT SHOWING RESULTS, A FALSE/UNINTENDED STRAFE RUN ', 5 )

   end
   clientRollingIn = false
   clientStrafed = false
   invalidStrafe = false
end

local SetClient = SET_CLIENT:New():FilterCoalitions("blue"):FilterStart()

function CLIENT_IN_STRAFE_PIT_ZONE()
   SetClient:ForEachClient(function(client)
       if (client ~= nil) and (client:IsAlive()) then 
         local clientheading  = client:GetHeading()
         local pitheading   = 156 --********  Change this to the strafe attack heading!!!!! 
         local deltaheading = clientheading-pitheading
         local towardspit   = math.abs(deltaheading)<=90 or math.abs(deltaheading-360)<=90
         local playerName = client:GetPlayerName()
         
         if client:IsInZone(strafe_roll_in_zone) or clientRollingIn == true then -- edited out strafe_roll_in_zone as an 'or' argument to bug test
             env.info('Range_Discord_reporting_script RANGE Script- Roll in Message sent to Discord  ')
           local text = (playerName..' rolling into Strafe Pit ')
           --HypeMan.sendBotMessage(text)
           clientRollingIn = false
           timer.scheduleFunction(displayStrafeResults, {}, timer.getTime() + 13)
           Straferesult.airframe = client:GetTypeName()
         else
         end

       end
end)
timer.scheduleFunction(CLIENT_IN_STRAFE_PIT_ZONE,nil,timer.getTime() + 3)
end
CLIENT_IN_STRAFE_PIT_ZONE()

GunFireStart = EVENTHANDLER:New():HandleEvent(EVENTS.ShootingStart)
ShootingEvent = EVENTHANDLER:New():HandleEvent(EVENTS.Shot)

function GunFireStart:OnEventShootingStart(EventData)
    if EventData.IniPlayerName ~= nil then 
        local PlayerName = EventData.IniPlayerName
            local PlayerUnit = EventData.IniUnit
            playerAltForRangeData = PlayerUnit:GetAltitude()
            playerPitchForRangeData = PlayerUnit:GetPitch()
            playerHeadingForRangeData = PlayerUnit:GetHeading()
            weaponUsedAdamScript = "cannon rounds"    
    end
end

function ShootingEvent:OnEventShot(EventData)    
    if EventData.IniUnit:GetCoalitionName() == "Blue" then
        if EventData.IniPlayerName ~= nil then 
            local PlayerUnit = EventData.IniUnit
            playerAltForRangeData = PlayerUnit:GetAltitude()
            playerPitchForRangeData = PlayerUnit:GetPitch()
            playerHeadingForRangeData = PlayerUnit:GetHeading()
        end
    elseif EventData.IniUnit:GetCoalitionName() == "Red" then
     
       end
end
bombingRange:SetAutosaveOn()
bombingRange:Start()

---------------AWACS/big wing Tankers---------------------
local zoneAWACSblue=ZONE:New("Zone AWACS BLUE")
local zoneAWACSred=ZONE:New("Zone AWACS RED")
local zoneTankerNorth=ZONE:New("Zone Tank North")
local zoneTankerWest=ZONE:New("Zone Tank West")
local zoneTankerEast=ZONE:New("Zone Tank East")
local zoneTankerLow=ZONE:New("Zone Tank Low")

boomAltitude = 25000
drogueAltitude = 24000
tankerSpeed = 270
tankerTrackLength=15

-- E-3A Magic 51 - 32,000' 251.000Mhz
local auftragAWACS=AUFTRAG:NewAWACS(zoneAWACSblue:GetCoordinate(), 32000, UTILS.KnotsToAltKIAS(300,30000), 360, 40)
auftragAWACS:SetTACAN(29, "DXS") 
auftragAWACS:SetRadio(251.000)      
local fsAWACS=FLIGHTGROUP:New("Magic")
fsAWACS:SetDefaultCallsign(CALLSIGN.AWACS.Magic, 5)
fsAWACS:AddMission(auftragAWACS)
  
-- E-3A Darkstar 51 - 32,000' 252.000Mhz
local auftragredAWACS=AUFTRAG:NewAWACS(zoneAWACSred:GetCoordinate(), 32000, UTILS.KnotsToAltKIAS(300,30000), 360, 40)
auftragredAWACS:SetTACAN(30, "DKS") 
auftragredAWACS:SetRadio(252.000)      
local fsRedAWACS=FLIGHTGROUP:New("Darkstar")
fsRedAWACS:SetDefaultCallsign(CALLSIGN.AWACS.Darkstar, 3)
fsRedAWACS:AddMission(auftragredAWACS)

----------------North Tankers------------------------
--KC-135 Arco (North) TCN 61Y - 25,000' 261.0MHz 
local arcoNorth=AUFTRAG:NewTANKER(zoneTankerNorth:GetCoordinate(), boomAltitude, UTILS.KnotsToAltKIAS(tankerSpeed,boomAltitude), 270, tankerTrackLength)
arcoNorth:SetTACAN(61, "ANB")
arcoNorth:SetRadio(261)
local arco41=FLIGHTGROUP:New("Arco North")
arco41:SetDefaultCallsign(CALLSIGN.Tanker.Arco, 4)
arco41:Activate()
arco41:AddMission(arcoNorth)
--KC-135MPRS Texaco (North) TCN 62Y - 24,000' 262.0MHz
local texNorth=AUFTRAG:NewTANKER(zoneTankerNorth:GetCoordinate(), drogueAltitude, UTILS.KnotsToAltKIAS(tankerSpeed,drogueAltitude), 270, tankerTrackLength)
texNorth:SetTACAN(62, "TND")
texNorth:SetRadio(262)
local tex31=FLIGHTGROUP:New("Texaco North")
tex31:SetDefaultCallsign(CALLSIGN.Tanker.Texaco, 3)
tex31:Activate()
tex31:AddMission(texNorth)

----------------West Tankers------------------------  
  --KC-135 Arco (West) TCN 63Y - 25,000' 263.0MHz 
local arcoWest=AUFTRAG:NewTANKER(zoneTankerWest:GetCoordinate(), boomAltitude, UTILS.KnotsToAltKIAS(tankerSpeed,boomAltitude), 150, tankerTrackLength)
arcoWest:SetTACAN(63, "AWB")
arcoWest:SetRadio(263)
local arco21=FLIGHTGROUP:New("Arco West")
arco21:SetDefaultCallsign(CALLSIGN.Tanker.Arco, 2)
arco21:Activate()
arco21:AddMission(arcoWest)
--KC-135MPRS Texaco (North) TCN 64Y - 24,000' 264.0MHz
local texWest=AUFTRAG:NewTANKER(zoneTankerWest:GetCoordinate(), drogueAltitude, UTILS.KnotsToAltKIAS(tankerSpeed,drogueAltitude), 150, tankerTrackLength)
texWest:SetTACAN(64, "TWD")
texWest:SetRadio(264)
local tex21=FLIGHTGROUP:New("Texaco West")
tex21:SetDefaultCallsign(CALLSIGN.Tanker.Texaco, 2)
tex21:Activate()
tex21:AddMission(texWest)

----------------East Tankers------------------------
--KC-135 Arco (East) TCN 65Y - 25,000' 265.0MHz 
local arcoEast=AUFTRAG:NewTANKER(zoneTankerEast:GetCoordinate(), boomAltitude, UTILS.KnotsToAltKIAS(tankerSpeed,boomAltitude), 180, tankerTrackLength)
arcoEast:SetTACAN(65, "AEB")
arcoEast:SetRadio(265)
local arco31=FLIGHTGROUP:New("Arco East")
arco31:SetDefaultCallsign(CALLSIGN.Tanker.Arco, 3)
arco31:Activate()
arco31:AddMission(arcoEast)
--KC-135MPRS Texaco (East) TCN 66Y - 24,000' 266.0MHz
local texEast=AUFTRAG:NewTANKER(zoneTankerEast:GetCoordinate(), drogueAltitude, UTILS.KnotsToAltKIAS(tankerSpeed,drogueAltitude), 180, tankerTrackLength)
texEast:SetTACAN(66, "TED")
texEast:SetRadio(266)
local tex51=FLIGHTGROUP:New("Texaco East")
tex51:SetDefaultCallsign(CALLSIGN.Tanker.Texaco, 5)
tex51:Activate()
tex51:AddMission(texEast)

--KC-130 Texaco (Low) TCN 55Y -12,000' 255.0 MHz
local shellLow=AUFTRAG:NewTANKER(zoneTankerLow:GetCoordinate(), 12000, UTILS.KnotsToAltKIAS(tankerSpeed,12000), 035, 10)
shellLow:SetTACAN(55, "SHL")
shellLow:SetRadio(255)
local sh51=FLIGHTGROUP:New("Shell")
sh51:SetDefaultCallsign(CALLSIGN.Tanker.Shell, 5)
sh51:Activate()
sh51:AddMission(shellLow)
-------------JTAC initial Spawn--------------

Spawn_JTAC1 = SPAWN:New("JTAC1388")
Spawn_JTAC1:InitKeepUnitNames(true)
Spawn_JTAC1:InitLimit(1,0)
Spawn_JTAC1:InitDelayOn()
Spawn_JTAC1:OnSpawnGroup(
  function( SpawnGroup1 )
	ctld.JTACAutoLase(SpawnGroup1.GroupName, 1388, false, "all")
  end
)
Spawn_JTAC1:SpawnScheduled( 60,0 )

Spawn_JTAC2 = SPAWN:New("JTAC1488")
Spawn_JTAC2:InitKeepUnitNames(true)
Spawn_JTAC2:InitLimit(1,0)
Spawn_JTAC2:InitDelayOn()
Spawn_JTAC2:OnSpawnGroup(
  function( SpawnGroup2 )
	ctld.JTACAutoLase(SpawnGroup2.GroupName, 1488, false, "all")
  end
)
Spawn_JTAC2:SpawnScheduled( 60,0 )

Spawn_JTAC3 = SPAWN:New("JTAC1588")
Spawn_JTAC3:InitKeepUnitNames(true)
Spawn_JTAC3:InitLimit(1,0)
Spawn_JTAC3:InitDelayOn()
Spawn_JTAC3:OnSpawnGroup(
  function( SpawnGroup3 )
	ctld.JTACAutoLase(SpawnGroup3.GroupName, 1588, false, "all")
  end
)
Spawn_JTAC3:SpawnScheduled( 60,0 )
