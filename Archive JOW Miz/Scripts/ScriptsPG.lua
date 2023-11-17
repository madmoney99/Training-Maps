-------------------------
-- AIRBOSS --
-------------------------
superCarrier = Roosevelt
cvUnitName = "CVN71"

AIRBOSS.MenuF10Root=MENU_MISSION:New("Airboss").MenuPath
_SETTINGS:SetPlayerMenuOff()

local hightanker=RECOVERYTANKER:New(UNIT:FindByName(cvUnitName), "Arco")
hightanker:SetTakeoffAir()
hightanker:SetCallsign(CALLSIGN.Tanker.Arco, 7)
hightanker:SetRadio(268)
hightanker:SetAltitude(15000)
hightanker:SetRacetrackDistances(25, 8)
hightanker:SetModex(611)
hightanker:SetTACAN(55, "ARC")
hightanker:SetSpeed(350)
hightanker:Start()

rescuehelo=RESCUEHELO:New(UNIT:FindByName(cvUnitName), "Rescue Helo")
rescuehelo:SetHomeBase(AIRBASE:FindByName("USS Ticonderoga"))
rescuehelo:SetTakeoffAir()

rescuehelo:SetRescueDuration(1)
rescuehelo:SetRescueHoverSpeed(5)
rescuehelo:SetRescueZone(15)
rescuehelo:SetModex(42)
rescuehelo:__Start(4)

tanker=RECOVERYTANKER:New(UNIT:FindByName(cvUnitName), "Texaco")
tanker:SetTakeoffHot()
tanker:SetCallsign(CALLSIGN.Tanker.Texaco, 6)
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

local superCarrier=AIRBOSS:New(cvUnitName)

local function cutPass()
  trigger.action.outSound("Airboss Soundfiles/GetYourButtsUptoVipersOffice.ogg")
end

local function underlinePass()
  cvn = GROUP:FindByName( cvUnitName )
  cvnZONE = ZONE_GROUP:New( "ZoneCVN", cvn, 100 )
  cvnZONE:FlareZone( FLARECOLOR.Red, 10, 60 )
  cvnZONE:FlareZone( FLARECOLOR.White, 10, 60 )
  cvnZONE:FlareZone( FLARECOLOR.Green, 10, 60 )
  cvnZONE:FlareZone( FLARECOLOR.Yellow, 10, 60 )
  --trigger.action.outSound("Airboss Soundfiles/ffyrtp.ogg")
end

local function underlinePassSH()
  cvn = GROUP:FindByName( cvUnitName )
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

  if player_case == 3 and player_detail == nil then
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

superCarrier:SetMenuRecovery(60, 25, true, 0)
superCarrier:Load()
superCarrier:SetAutoSave()
superCarrier.trapsheet = false
superCarrier:SetTACAN(71, "X", "RHR")
superCarrier:SetICLS(11,"RRI")
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

local cvnGroup = GROUP:FindByName( cvUnitName )
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
          trigger.action.outText(player_name..' performing a Sierra Hotel Break!', 10)
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

forrestal:SetMenuRecovery(60, 25, true, 0)
forrestal:Load()
forrestal:SetAutoSave()
forrestal.trapsheet = false
forrestal:SetTACAN(59, "X", "ZIP")
forrestal:SetICLS(9,"FOR")
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

----------------AWACS/big wing Tankers-----------------------
local zoneAWACS=ZONE:New("Zone AWACS")
local zoneTankerNorth=ZONE:New("Zone Tank North")
local zoneTankerSouth=ZONE:New("Zone Tank South")

boomAltitude = 26000
drogueAltitude = 25000
tankerSpeed = 270
tankerTrackLength=20
  
  -- E-3A Magic 51 - 32,000' 291.875Mhz
local auftragAWACS=AUFTRAG:NewAWACS(zoneAWACS:GetCoordinate(), 32000, UTILS.KnotsToAltKIAS(300,30000), 030, tankerTrackLength)
auftragAWACS:SetTACAN(29, "DXS") 
auftragAWACS:SetRadio(291.875)      
local fsAWACS=FLIGHTGROUP:New("Magic")
fsAWACS:SetDefaultCallsign(CALLSIGN.AWACS.Magic, 5)
fsAWACS:AddMission(auftragAWACS)

-----North Tankers -----

--KC-135 Shell41 (North) TCN 59Y - 25,000' 259.0MHz (Hornet Ch.11)
local shellNorth=AUFTRAG:NewTANKER(zoneTankerNorth:GetCoordinate(), drogueAltitude, UTILS.KnotsToAltKIAS(tankerSpeed,drogueAltitude), 030, tankerTrackLength)
shellNorth:SetTACAN(59, "SDN")
shellNorth:SetRadio(259)
local shell41=FLIGHTGROUP:New("Shell North")
shell41:SetDefaultCallsign(CALLSIGN.Tanker.Shell, 4)
shell41:Activate()
shell41:AddMission(shellNorth)
--KC-135 Texaco31 (North Boom) TCN 61X - 26,000' 261.0MHz
local texNorth=AUFTRAG:NewTANKER(zoneTankerNorth:GetCoordinate(), boomAltitude, UTILS.KnotsToAltKIAS(tankerSpeed,boomAltitude), 030, tankerTrackLength)
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

-----Low Tankers------
--KC-135 Texaco51 (Low Boom) TCN 57Y -12,000' 257.0 MHz
local texLow=AUFTRAG:NewTANKER(zoneTankerSouth:GetCoordinate(), 12000, UTILS.KnotsToAltKIAS(250,12000), 060, tankerTrackLength)
texLow:SetTACAN(57, "TXS")
texLow:SetRadio(257)
local tex51=FLIGHTGROUP:New("Texaco Low")
tex51:SetDefaultCallsign(CALLSIGN.Tanker.Texaco, 5)
tex51:Activate()
tex51:AddMission(texLow)

-- --------------------JTAC initial Spawn-------------------
-- do
  -- Spawn_JTAC1 = SPAWN:New("JTAC1388")
    -- :InitKeepUnitNames(true)
    -- :InitLimit(1,0)
    -- :InitDelayOn()
    -- :OnSpawnGroup(
      -- function( SpawnGroup )
        -- ctld.JTACAutoLase(SpawnGroup.GroupName, 1388, false, "all")
      -- end
    -- )
    -- :SpawnScheduled( 60,0 )

  -- Spawn_JTAC2 = SPAWN:New("JTAC1688")
    -- :InitKeepUnitNames(true)
    -- :InitLimit(1,0)
    -- :InitDelayOn()
    -- :OnSpawnGroup(
      -- function( SpawnGroup )
        -- ctld.JTACAutoLase(SpawnGroup.GroupName, 1688, false, "all")
      -- end
    -- )
    -- :SpawnScheduled( 60,0 )
-- end

-------------------Range script Sabakh-----------------
RangeSabakh=RANGE:New("Sabakh Range")
RangeSabakh:AddBombingTargetGroup(GROUP:FindByName("Sabakh"), 50, false)
bombTargetsSabakh = {'North-West Circle', 'North-East Circle', 'South-West Circle', 'South-East Circle'}
RangeSabakh:AddBombingTargets(bombTargetsSabakh, 20, false)

function RangeSabakh:OnAfterImpact(From, Event, To, result, player)  
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
RangeSabakh:Start()

-------------------Range script-----------------
RangeEMAL=RANGE:New("EMAL Range")
RangeEMAL:AddBombingTargetGroup(GROUP:FindByName("Plinking TGTS"), 50, false)

function RangeEMAL:OnAfterImpact(From, Event, To, result, player)  
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
RangeEMAL:Start()

-------------------Sirri Range script-----------------
RangeSirri=RANGE:New("Sirri Range")
RangeSirri:AddBombingTargetGroup(GROUP:FindByName("Iran Forces"), 50, false)
RangeSirri:AddBombingTargetGroup(GROUP:FindByName("Iran Forces #001"), 50, false)
RangeSirri:AddBombingTargetGroup(GROUP:FindByName("Iran Forces #002"), 50, false)
RangeSirri:AddBombingTargetGroup(GROUP:FindByName("Iran Forces #003"), 50, false)
RangeSirri:AddBombingTargetGroup(GROUP:FindByName("Iran Forces #004"), 50, false)

function RangeSirri:OnAfterImpact(From, Event, To, result, player)  
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
RangeSirri:Start()

------------------ Laser Range script-----------------
RangeLaserRange=RANGE:New("Laser Range")
RangeLaserRange:AddBombingTargetGroup(GROUP:FindByName("Target1"), 50, false)
RangeLaserRange:AddBombingTargetGroup(GROUP:FindByName("Target1 #001"), 50, false)
RangeLaserRange:AddBombingTargetGroup(GROUP:FindByName("Target1 #002"), 50, false)
RangeLaserRange:AddBombingTargetGroup(GROUP:FindByName("Target1 #003"), 50, false)
RangeLaserRange:AddBombingTargetGroup(GROUP:FindByName("Moving Tgts #001"), 50, false)

function RangeLaserRange:OnAfterImpact(From, Event, To, result, player)  
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
RangeLaserRange:Start()

-------------------Range script-----------------
bombingRange=RANGE:New("Abu Al Abyad Range")
bombTargets = {'target #001', 'target #002', 'target #003', 'target #004', 'target #005', 'target #006', 'target #007', 'target #008'}
bombingRange:AddBombingTargets(bombTargets, 20, false)
strafe_target_west = {'Strafe pit West'}
strafe_target_east = {'Strafe pit East'}
bombingRange:AddStrafePit(strafe_target_west, 4000,350,180, false, 20)
bombingRange:AddStrafePit(strafe_target_east, 4000,350,360, false, 20)


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

   HypeMan.sendBotTable(result)
   self:_SaveTargetSheet(_playername, result) 
   
   if result.distance <= 1.52 then
       trigger.action.outSound("Airboss Soundfiles/sureshot.ogg")
   end
end

--STRAFING RANGE--
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
       result.heading = playerHeadingForRangeData 
       HypeMan.sendBotTable(result)

       if result.strafeAccuracy >= 90 then
           dead_eye()
           trigger.action.outSound("Airboss Soundfiles/sureshot.ogg")
       else
           env.info('Range_Discord_reporting_script RANGE Script: STRAFE:  accuracy less than 75% ')
       end

       result = nil
   else
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
         local pitheading   = 001 
         local deltaheading = clientheading-pitheading
         local towardspit   = math.abs(deltaheading)<=90 or math.abs(deltaheading-360)<=90
         local playerName = client:GetPlayerName()
         
         if clientRollingIn == true then
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
bombingRange:SetAutosaveOn()
bombingRange:Start()
