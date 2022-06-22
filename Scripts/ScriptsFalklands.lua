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
rescuehelo:SetHomeBase(AIRBASE:FindByName("CVN-73 USS George Washington"))
rescuehelo:SetTakeoffAir()
rescuehelo:SetRescueDuration(1)
rescuehelo:SetRescueHoverSpeed(5)
rescuehelo:SetRescueZone(15)
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
	cutPass()
    if player_wire ==1 then
      myGrade.points = myGrade.points + 1.00
      superCarrier:SetTrapSheet(nil, "Cut_AIRBOSS-trapsheet-"..player_name)
    else
      superCarrier:SetTrapSheet(nil, "Cut_AIRBOSS-trapsheet-"..player_name)
    end
  end

  if player_case == 3 and mygrade.details == nil then
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
  timer.scheduleFunction(resetTrapSheetFileFormat, {}, timer.getTime() + 20)
end

superCarrier:SetMenuRecovery(60, 29, true, 0)
superCarrier:Load()
superCarrier:SetAutoSave()
superCarrier.trapsheet = false
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

------------Create AIRBOSS object------------
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
playerAltForRangeData = "altitudeNotSet!"
playerPitchForRangeData = "pitchNotSet!"
playerHeadingForRangeData = "headingNotSet!"
local weaponUsedRange_Discord_Script = "weapon name not set!"

--Range
RangeJM=RANGE:New("Juan Mazia Range")
RangeJM:SetRangeRadius(20)
RangeJM:AddBombingTargetGroup(GROUP:FindByName("Russian Forces"), 50, false)

function RangeJM:OnAfterImpact(From, Event, To, result, player)  
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
   self:_SaveTargetSheet(_playername, result) 
   
   if result.distance <= 1.52 then
       trigger.action.outSound("Airboss Soundfiles/sureshot.ogg")
   end
end
RangeJM:SetAutosaveOn()
RangeJM:Start()

RangeMPF=RANGE:New("Main Point Farm Range")
RangeMPF:SetRangeRadius(20)
RangeMPF:AddBombingTargetGroup(GROUP:FindByName("Russian Forces-1"), 50, false)

function RangeMPF:OnAfterImpact(From, Event, To, result, player)  
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
RangeMPF:SetAutosaveOn()
RangeMPF:Start()

RangeLR=RANGE:New("Laga Roca Range")
RangeLR:SetRangeRadius(20)
RangeLR:AddBombingTargetGroup(GROUP:FindByName("Russian Forces-2"), 50, false)

function RangeLR:OnAfterImpact(From, Event, To, result, player)  
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
RangeLR:SetAutosaveOn()
RangeLR:Start()
local SetClient = SET_CLIENT:New():FilterCoalitions("blue"):FilterStart()

function CLIENT_IN_STRAFE_PIT_ZONE()
   SetClient:ForEachClient(function(client)
       if (client ~= nil) and (client:IsAlive()) then 
         local clientheading  = client:GetHeading()
         local pitheading   = 001 
         local deltaheading = clientheading-pitheading
         local towardspit   = math.abs(deltaheading)<=90 or math.abs(deltaheading-360)<=90
         local playerName = client:GetPlayerName()
         
         if clientRollingIn == true then 
             env.info('Range_Discord_reporting_script RANGE Script- Roll in Message sent to Discord  ')
           local text = (playerName..' rolling into Strafe Pit ')
           clientRollingIn = false
           timer.scheduleFunction(displayStrafeResults, {}, timer.getTime() + 13)
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
----------------AWACS/big wing Tankers-----------------------
local zoneAWACS=ZONE:New("Zone AWACS")
local zoneTankerNorth=ZONE:New("Zone Tank West")
local zoneTankerSouth=ZONE:New("Zone Tank East")
local zoneTankerLow=ZONE:New("Zone Tank Low")

boomAltitude = 25000
drogueAltitude = 24000
tankerSpeed = 270
tankerTrackLength=15

---AWACS-----
-- E-3A Magic 51 - 32,000' 251.000Mhz
local auftragAWACS=AUFTRAG:NewAWACS(zoneAWACS:GetCoordinate(), 32000, UTILS.KnotsToAltKIAS(300,30000), 125, 40)
auftragAWACS:SetTACAN(29, "DXS") 
auftragAWACS:SetRadio(251.000)      
local fsAWACS=FLIGHTGROUP:New("Magic")
fsAWACS:SetDefaultCallsign(CALLSIGN.AWACS.Magic, 5)
fsAWACS:AddMission(auftragAWACS)

-----West Tankers -----

--KC-135 Shell41 (West) TCN 65Y - 25,000' 265.0MHz (Hornet Ch.11)
local shellWest=AUFTRAG:NewTANKER(zoneTankerNorth:GetCoordinate(), drogueAltitude, UTILS.KnotsToAltKIAS(tankerSpeed,drogueAltitude), 180, tankerTrackLength)
shellWest:SetTACAN(65, "SHN")
shellWest:SetRadio(265)
local shell41=FLIGHTGROUP:New("Shell West")
shell41:SetDefaultCallsign(CALLSIGN.Tanker.Shell, 4)
shell41:Activate()
shell41:AddMission(shellWest)
--KC-135 Texaco31 (West Boom) TCN 61Y - 26,000' 261.0MHz
local texWest=AUFTRAG:NewTANKER(zoneTankerNorth:GetCoordinate(), boomAltitude, UTILS.KnotsToAltKIAS(tankerSpeed,boomAltitude), 180, tankerTrackLength)
texWest:SetTACAN(61, "TXN")
texWest:SetRadio(261)
local tex31=FLIGHTGROUP:New("Texaco West")
tex31:SetDefaultCallsign(CALLSIGN.Tanker.Texaco, 3)
tex31:Activate()
tex31:AddMission(texWest)

-----East Tankers------
--KC-135 Shell21 (East) TCN 63Y - 25,000' 263.0MHz (Hornet Ch.15)
local shellEast=AUFTRAG:NewTANKER(zoneTankerSouth:GetCoordinate(), drogueAltitude, UTILS.KnotsToAltKIAS(tankerSpeed,drogueAltitude), 090, tankerTrackLength)
shellEast:SetTACAN(63, "SHS")
shellEast:SetRadio(263)
local shell21=FLIGHTGROUP:New("Shell East")
shell21:SetDefaultCallsign(CALLSIGN.Tanker.Shell, 2)
shell21:Activate()
shell21:AddMission(shellEast)

--KC-135 Texaco21 (East Boom) TCN 67Y - 26,000' 267.0MHz
local texEast=AUFTRAG:NewTANKER(zoneTankerSouth:GetCoordinate(), boomAltitude, UTILS.KnotsToAltKIAS(tankerSpeed,boomAltitude), 090, tankerTrackLength)
texEast:SetTACAN(67, "TXS")
texEast:SetRadio(267)
local tex21=FLIGHTGROUP:New("Texaco East")
tex21:SetDefaultCallsign(CALLSIGN.Tanker.Texaco, 2)
tex21:Activate()
tex21:AddMission(texEast)

-----Low Tankers------
--KC-135 Texaco51 (Low Boom) TCN 57Y -12,000' 257.0 MHz
local texLow=AUFTRAG:NewTANKER(zoneTankerLow:GetCoordinate(), 12000, UTILS.KnotsToAltKIAS(250,12000), 75, tankerTrackLength)
texLow:SetTACAN(57, "TXS")
texLow:SetRadio(257)
local tex51=FLIGHTGROUP:New("Texaco Low")
tex51:SetDefaultCallsign(CALLSIGN.Tanker.Texaco, 5)
tex51:Activate()
tex51:AddMission(texLow)
 