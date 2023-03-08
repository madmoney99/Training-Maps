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

function superCarrier:OnAfterLSOGrade(From, Event, To, playerData, myGrade)
  local string_grade = myGrade.grade
  local player_callsign = playerData.callsign
  local unit_name = playerData.unitname
  local player_name = playerData.name
  local player_wire = playerData.wire
  local player_case = playerData.case
  local player_detail = myGrade.details
  local player_Tgroove = playerData.Tgroove
  player_name = player_name:gsub('[%p]', '')

  --local gradeForFile
  if  string_grade == "_OK_" then
    --if  string_grade == "_OK_" and player_wire == "3" and player_Tgroove >=15 and player_Tgroove <19 then
    timer.scheduleFunction(underlinePass, {}, timer.getTime() + 5)
    if shFlag:Get() == 1 then
      myGrade.grade = "_OK_<SH>"
      myGrade.points = myGrade.points
      shFlag:Set(0)
      superCarrier:SetTrapSheet(nil, "SH_unicorn_AIRBOSS-trapsheet-"..player_name)
      timer.scheduleFunction(underlinePassSH, {}, timer.getTime() + 5)
    else
      superCarrier:SetTrapSheet(nil, "unicorn_AIRBOSS-trapsheet-"..player_name)
    end
  elseif string_grade == "OK" and player_wire >1 then
    if shFlag:Get() == 1 then
      myGrade.grade = "OK<SH>"
      myGrade.points = myGrade.points + 0.5
      shFlag:Set(0)
      superCarrier:SetTrapSheet(nil, "SH_AIRBOSS-trapsheet-"..player_name)
    else
      superCarrier:SetTrapSheet(nil, "AIRBOSS-trapsheet-"..player_name)
    end
  elseif string_grade == "(OK)" and player_wire >1 then
    superCarrier:SetTrapSheet(nil, "AIRBOSS-trapsheet-"..player_name)
    if shFlag:Get() == 1 then
      myGrade.grade = "(OK)<SH>"
      myGrade.points = myGrade.points + 1.00
      shFlag:Set(0)
      superCarrier:SetTrapSheet(nil, "SH_AIRBOSS-trapsheet-"..player_name)
    else
      superCarrier:SetTrapSheet(nil, "AIRBOSS-trapsheet-"..player_name)
    end
  elseif string_grade == "--" and player_wire >1 then
    if shFlag:Get() == 1 then
      myGrade.grade = "--<SH>"
      myGrade.points = myGrade.points + 1.00
      shFlag:Set(0)
      superCarrier:SetTrapSheet(nil, "SH_AIRBOSS-trapsheet-"..player_name)
    else
      superCarrier:SetTrapSheet(nil, "AIRBOSS-trapsheet-"..player_name)
    end

  elseif string_grade == "-- (BOLTER)" then
    superCarrier:SetTrapSheet(nil, "Bolter_AIRBOSS-trapsheet-"..player_name)
  elseif string_grade == "WOFD" then
    superCarrier:SetTrapSheet(nil, "WOFD_AIRBOSS-trapsheet-"..player_name)
  elseif string_grade == "WOP" then
    superCarrier:SetTrapSheet(nil, "WOP_AIRBOSS-trapsheet-"..player_name)
  elseif string_grade == "WO" then
    superCarrier:SetTrapSheet(nil, "WO_AIRBOSS-trapsheet-"..player_name)
  elseif string_grade == "OWO" then
    superCarrier:SetTrapSheet(nil, "OWO_AIRBOSS-trapsheet-"..player_name)
  elseif string_grade == "CUT" then
    if player_wire ==1 then
      myGrade.points = myGrade.points + 1.00
      superCarrier:SetTrapSheet(nil, "Cut_AIRBOSS-trapsheet-"..player_name)
    else
      superCarrier:SetTrapSheet(nil, "Cut_AIRBOSS-trapsheet-"..player_name)
    end
  end

  if player_case == 3 and player_detail == "    " then
    if player_wire >1 then
      superCarrier:SetTrapSheet(nil, "NIGHT5_AIRBOSS-trapsheet-"..player_name)
      myGrade.grade = "_OK_"
      myGrade.points = 5.0
    else
      superCarrier:SetTrapSheet(nil, "AIRBOSS-trapsheet-"..player_name)
    end
  end

  myGrade.messageType = 2
  myGrade.callsign = playerData.callsign
  myGrade.name = playerData.name
  if playerData.wire == 1 then
    myGrade.points = myGrade.points -1.00
    oneWireMessage = {}
	oneWireMessage.messageType=5
	oneWireMessage.messageString = ('**'..player_name..' almost had a rampstrike with that 1-wire!**')
	HypeMan.sendBotTable(oneWireMessage)
  end
  self:_SaveTrapSheet(playerData, mygrade)
  HypeMan.sendBotTable(myGrade)
  timer.scheduleFunction(resetTrapSheetFileFormat, {}, timer.getTime() + 10)
end

superCarrier:SetMenuRecovery(60, 29, true, 0)
superCarrier:Load()
superCarrier:SetAutoSave()
superCarrier.trapsheet = false
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

local cvnGroup = GROUP:FindByName( cvnUnitName )
local CVN_GROUPZone = ZONE_GROUP:New('cvnGroupZone', cvnGroup, 1111)
local BlueCVNClients = SET_CLIENT:New():FilterCoalitions("blue"):FilterStart()

Scheduler, SchedulerID = SCHEDULER:New( nil,
  function ()
    local clientData={}
    local player_name
    BlueCVNClients:ForEachClientInZone( CVN_GROUPZone,
      function( MooseClient )
        local function resetFlag()
          cvZoneFlag:Set(0)
        end

        local player_velocity = MooseClient:GetVelocityKNOTS()
        local player_name = MooseClient:GetPlayerName()
        local player_alt = MooseClient:GetAltitude()
        local player_type = MooseClient:GetTypeName()

        alt2feet = player_alt * 3.28
        alt2feet = alt2feet/10
        alt2feet = math.floor(alt2feet)*10

        velocity_round = player_velocity/10
        velocity_round = math.floor(velocity_round)*10

        local shSound = USERSOUND:New( "Airboss Soundfiles/GreatBallsOfFire.ogg" )
        if cvZoneFlag == nil then
          cvZoneFlag = USERFLAG:New(MooseClient:GetClientGroupID() + 10000000)
        else
        end

        if shFlag == nil then
          shFlag = USERFLAG:New(MooseClient:GetClientGroupID() + 100000000)
        else
        end

        if cvZoneFlag:Get() == 0 and player_velocity > 475 and player_alt < 213 then
          trigger.action.outText(player_name..' performing a Sierra Hotel Break at '..velocity_round..' knots and '..alt2feet..' feet!', 10)
		  shMessage = {}
		  shMessage.messageType=5
		  shMessage.messageString = ('**'..player_name..' is performing a Sierra Hotel Break at '..velocity_round..' knots and '..alt2feet..' feet in a '..player_type..'!**')
		  HypeMan.sendBotTable(shMessage)
          shSound:ToAll()
          cvZoneFlag:Set(1)
          shFlag:Set(1)
          timer.scheduleFunction(resetFlag, {}, timer.getTime() + 10)
        else
        end
      end
    )

  end, {}, 2, 1
)


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

local function cutPassForrestal()
  trigger.action.outSound("Airboss Soundfiles/GetYourButtsUptoVipersOffice.ogg")
end

local function underlinePassForrestal()
  cv = GROUP:FindByName( cvUnitName )
  cvZONE = ZONE_GROUP:New( "ZoneCV", cv, 100 )
  cvZONE:FlareZone( FLARECOLOR.Red, 10, 60 )
  cvZONE:FlareZone( FLARECOLOR.White, 10, 60 )
  cvZONE:FlareZone( FLARECOLOR.Green, 10, 60 )
  cvZONE:FlareZone( FLARECOLOR.Yellow, 10, 60 )
  --trigger.action.outSound("Airboss Soundfiles/ffyrtp.ogg")
end

local function underlinePassSHForrestal()
  cv = GROUP:FindByName( cvUnitName )
  cvZONE = ZONE_GROUP:New( "ZoneCV", cv, 100 )
  cvZONE:FlareZone( FLARECOLOR.Red, 10, 60 )
  cvZONE:FlareZone( FLARECOLOR.White, 10, 60 )
  cvZONE:FlareZone( FLARECOLOR.Green, 10, 60 )
  cvZONE:FlareZone( FLARECOLOR.Yellow, 10, 60 )
  --trigger.action.outSound("Airboss Soundfiles/sureshot.ogg")
end

local function resetTrapSheetFileFormatForrestal()
  forrestal:SetTrapSheet()
end

function forrestal:OnAfterLSOGrade(From, Event, To, playerData, myGrade)
  local string_grade = myGrade.grade
  local player_callsign = playerData.callsign
  local unit_name = playerData.unitname
  local player_name = playerData.name
  local player_wire = playerData.wire
  player_name = player_name:gsub('[%p]', '')

  --local gradeForFile
  if  string_grade == "_OK_" then
    --if  string_grade == "_OK_" and player_wire == "3" and player_Tgroove >=15 and player_Tgroove <19 then
    timer.scheduleFunction(underlinePass, {}, timer.getTime() + 5)
    if shFlagForrestal:Get() == 1 then
      myGrade.grade = "_OK_<SH>"
      myGrade.points = myGrade.points
      shFlagForrestal:Set(0)
      forrestal:SetTrapSheet(nil, "SH_unicorn_AIRBOSS-trapsheet-"..player_name)
      timer.scheduleFunction(underlinePassSH, {}, timer.getTime() + 5)
    else
      forrestal:SetTrapSheet(nil, "unicorn_AIRBOSS-trapsheet-"..player_name)
    end
  elseif string_grade == "OK" and player_wire >1 then
    if shFlagForrestal:Get() == 1 then
      myGrade.grade = "OK<SH>"
      myGrade.points = myGrade.points + 0.5
      shFlagForrestal:Set(0)
      forrestal:SetTrapSheet(nil, "SH_AIRBOSS-trapsheet-"..player_name)
    else
      forrestal:SetTrapSheet(nil, "AIRBOSS-trapsheet-"..player_name)
    end
  elseif string_grade == "(OK)" and player_wire >1 then
    forrestal:SetTrapSheet(nil, "AIRBOSS-trapsheet-"..player_name)
    if shFlagForrestal:Get() == 1 then
      myGrade.grade = "(OK)<SH>"
      myGrade.points = myGrade.points + 1.00
      shFlagForrestal:Set(0)
      forrestal:SetTrapSheet(nil, "SH_AIRBOSS-trapsheet-"..player_name)
    else
      forrestal:SetTrapSheet(nil, "AIRBOSS-trapsheet-"..player_name)
    end
  elseif string_grade == "--" and player_wire >1 then
    if shFlagForrestal:Get() == 1 then
      myGrade.grade = "--<SH>"
      myGrade.points = myGrade.points + 1.00
      shFlagForrestal:Set(0)
      forrestal:SetTrapSheet(nil, "SH_AIRBOSS-trapsheet-"..player_name)
    else
      forrestal:SetTrapSheet(nil, "AIRBOSS-trapsheet-"..player_name)
    end

  elseif string_grade == "-- (BOLTER)" then
    forrestal:SetTrapSheet(nil, "Bolter_AIRBOSS-trapsheet-"..player_name)
  elseif string_grade == "WOFD" then
    forrestal:SetTrapSheet(nil, "WOFD_AIRBOSS-trapsheet-"..player_name)
  elseif string_grade == "WOP" then
    forrestal:SetTrapSheet(nil, "WOP_AIRBOSS-trapsheet-"..player_name)
elseif string_grade == "WO" then
    forrestal:SetTrapSheet(nil, "WO_AIRBOSS-trapsheet-"..player_name)
  elseif string_grade == "OWO" then
    forrestal:SetTrapSheet(nil, "OWO_AIRBOSS-trapsheet-"..player_name)
  elseif string_grade == "CUT" then
    if player_wire ==1 then
      myGrade.points = myGrade.points + 1.00
      forrestal:SetTrapSheet(nil, "Cut_AIRBOSS-trapsheet-"..player_name)
    else
      forrestal:SetTrapSheet(nil, "Cut_AIRBOSS-trapsheet-"..player_name)
    end
  end

  if player_case == 3 and player_detail == "    " then
    if player_wire >1 then
      forrestal:SetTrapSheet(nil, "NIGHT5_AIRBOSS-trapsheet-"..player_name)
      myGrade.grade = "_OK_"
      myGrade.points = 5.0
    else
      forrestal:SetTrapSheet(nil, "AIRBOSS-trapsheet-"..player_name)
    end
  end

  myGrade.messageType = 2
  myGrade.callsign = playerData.callsign
  myGrade.name = playerData.name
  if playerData.wire == 1 then
    myGrade.points = myGrade.points -1.00
    oneWireMessage = {}
	oneWireMessage.messageType=5
	oneWireMessage.messageString = ('**'..player_name..' almost had a rampstrike with that 1-wire!**')
	HypeMan.sendBotTable(oneWireMessage)
  end
  self:_SaveTrapSheet(playerData, mygrade)
  HypeMan.sendBotTable(myGrade)
  timer.scheduleFunction(resetTrapSheetFileFormatForrestal, {}, timer.getTime() + 10)
end

forrestal:SetMenuRecovery(60, 29, true, 0)
forrestal:Load()
forrestal:SetAutoSave()
forrestal.trapsheet = false
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

local cvGroup = GROUP:FindByName( cvUnitName )
local CV_GROUPZone = ZONE_GROUP:New('cvGroupZone', cvGroup, 1112)
local BlueCVClients = SET_CLIENT:New():FilterCoalitions("blue"):FilterStart()

Scheduler, SchedulerID = SCHEDULER:New( nil,
  function ()
    local clientData={}
    local player_name
    BlueCVClients:ForEachClientInZone( CV_GROUPZone,
      function( MooseClient )
        local function resetFlag()
          cvZoneFlagForrestal:Set(0)
        end

        local player_velocity = MooseClient:GetVelocityKNOTS()
        local player_name = MooseClient:GetPlayerName()
        local player_alt = MooseClient:GetAltitude()
        local player_type = MooseClient:GetTypeName()

        alt2feet = player_alt * 3.28
        alt2feet = alt2feet/10
        alt2feet = math.floor(alt2feet)*10

        velocity_round = player_velocity/10
        velocity_round = math.floor(velocity_round)*10

        local shSound = USERSOUND:New( "Airboss Soundfiles/GreatBallsOfFire.ogg" )
        if cvZoneFlagForrestal == nil then
          cvZoneFlagForrestal = USERFLAG:New(MooseClient:GetClientGroupID() + 10000001)
        else
        end

        if shFlagForrestal == nil then
          shFlagForrestal = USERFLAG:New(MooseClient:GetClientGroupID() + 100000001)
        else
        end

        if cvZoneFlagForrestal:Get() == 0 and player_velocity > 475 and player_alt < 213 then
          trigger.action.outText(player_name..' performing a Sierra Hotel Break!', 10)
		  shMessage = {}
		  shMessage.messageType=5
		  shMessage.messageString = ('**'..player_name..' is performing a Sierra Hotel Break at '..velocity_round..' knots and '..alt2feet..' feet in a '..player_type..'!**')
		  HypeMan.sendBotTable(shMessage)
          shSound:ToAll()
          cvZoneFlagForrestal:Set(1)
          shFlagForrestal:Set(1)
          timer.scheduleFunction(resetFlag, {}, timer.getTime() + 10)
        else
        end
      end
    )

  end, {}, 2, 1
)
------------------Tarawa-----------------------
local Tarawa=AIRBOSS:New("Tarawa")

function Tarawa:OnAfterLSOGrade(From, Event, To, playerData, myGrade)
  myGrade.messageType = 2
  myGrade.callsign = playerData.callsign
  myGrade.name = playerData.name
  HypeMan.sendBotTable(myGrade)
end

Tarawa:SetTACAN(108, "X", "LHA")
Tarawa:SetTrapSheet()
Tarawa:SetICLS(8)
Tarawa:Load()
Tarawa:SetTrapSheet()
Tarawa:SetAutoSave()
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
rotaRange:AddBombingTargetGroup(GROUP:FindByName("Rota Range Bunkers"), 50, false)
rotaRange:AddBombingTargetGroup(GROUP:FindByName("Rota Range Soft Targets"), 50, false)
rotaRange:AddBombingTargetGroup(GROUP:FindByName("Rota Range Armor"), 50, false)
rotaRange:AddBombingTargetGroup(GROUP:FindByName("Rota-Ural-375"), 50, false)
rotaRange:AddBombingTargetGroup(GROUP:FindByName("Rota T-72"), 50, false)
rotaRange:AddBombingTargetGroup(GROUP:FindByName("Rota T-55"), 50, false)
rotaRange:AddBombingTargetGroup(GROUP:FindByName("Rota-ZSU"), 50, false)
rotaRange:AddBombingTargetGroup(GROUP:FindByName("Ground-32"), 50, false)
rotaRange:SetRangeRadius(15)

function rotaRange:OnAfterImpact(From, Event, To, result, player)  
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

   HypeMan.sendBotTable(result)
   self:_SaveTargetSheet(_playername, result) 
   
   if result.distance <= 1.52 then
       trigger.action.outSound("Airboss Soundfiles/sureshot.ogg")
   end
end

ShootingEvent = EVENTHANDLER:New():HandleEvent(EVENTS.Shot)
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
rotaRange:SetAutosaveOn()
rotaRange:Start()



