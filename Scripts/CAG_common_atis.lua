local theatre = env.mission.theatre
local weather = env.mission.weather
local preset = weather.clouds.preset
assert(loadfile(scriptPath.."private_api_keys.lua"))()
print(SERVERNAME)
env.info("ATIS for "..theatre)

if preset == nil then
  preset = ''
elseif preset == 'Preset1' then
  preset = 'FEW/SCT 7/8 (Light Scattered 1)'
elseif preset == 'Preset2' then
  preset ='FEW/SCT 8/10 SCT 23/24 (Light Scattered 2)'
elseif preset == 'Preset3' then
  preset ='SCT 8/9 FEW 21 (High Scattered 1)'
elseif preset == 'Preset4' then
  preset = 'SCT 8/10 FEW/SCT 24/26 (High Scattered 2)'
elseif preset == 'Preset5' then
  preset = 'SCT 8/10 FEW/SCT 24/26 (Scattered 1)'
elseif preset == 'Preset6' then
  preset = 'SCT/BKN 8/10 FEW40 (Scattered 2)'
elseif preset == 'Preset7' then
  preset = 'BKN 7.5/12 SCT/BKN 21/23 SCT 40 (Scattered 3)'
elseif preset == 'Preset8' then
  preset = 'SCT/BKN 18/20 FEW 36/38 FEW 40 (High Scattered 3)'
elseif preset == 'Preset9' then
  preset = 'BKN 7.5/10 SCT 20/22 FEW 41 (Scattered 4)'
elseif preset == 'Preset10' then
  preset = 'SCT/BKN 18/20 FEW 36/38 FEW 40 (Scattered 5)'
elseif preset == 'Preset11' then
  preset = 'BKN 18/20 BKN 32/33 FEW 41 (Scattered 6)'
elseif preset == 'Preset12' then
  preset = 'BKN 12/14 SCT22/23 FEW 41 (Scattered 7)'
elseif preset == 'Preset13' then
  preset = 'BKN 12/14 BKN 26/28 FEW 41 (Broken 1)'
elseif preset == 'Preset14' then
  preset = 'BKN LYR 7/16 FEW 41 (Broken 2)'
elseif preset == 'Preset15' then
  preset = 'SCT/BKN 14/18 BKN 24/27 FEW 40 (Broken 3)'
elseif preset == 'Preset16' then
  preset = 'BKN 14/18 BKN 28/30 FEW 40 (Broken 4)'
elseif preset == 'Preset17' then
  preset = 'BKN/OVC LYR 7/13 20/22 32/34 (Broken 5)'
elseif preset == 'Preset18' then
  preset ='BKN/OVC LYR 13/15 25/29 38/41 (Broken 6)'
elseif preset == 'Preset19' then
  preset = 'OVC 9/16 BKN/OVC LYR 23/24 31/33 (Broken 7)'
elseif preset == 'Preset20' then
  preset = 'BKN/OVC 13/18 BKN 28/30 SCT FEW 38 (Broken 8)'
elseif preset == 'Preset21' then
  preset = 'BKN/OVC LYR 7/8 17/19 (Overcast 1)'
elseif preset == 'Preset22' then
  preset = 'BKN LYR 7/10 17/20 (Overcast 2)'
elseif preset == 'Preset23' then
  preset = 'BKN LYR 11/14 18/25 SCT 32/35 (Overcast 3)'
elseif preset == 'Preset24' then
  preset = 'BKN/OVC 3/7 17/22 BKN 34 (Overcast 4)'
elseif preset == 'Preset25' then
  preset = 'OVC LYR 12/14 22/25 40/42 (Overcast 5)'
elseif preset == 'Preset26' then
  preset = 'OVC 9/15 BKN 23/25 SCT 32 (Overcast 6)'
elseif preset == 'Preset27' then
  preset = 'OVC 8/15 SCT/BKN 25/26 34/36 (Overcast 7)'
elseif preset == 'RainyPreset1' then
  preset = 'VIS 3-5KM RA OVC 3/15 28/30 FEW 40 (Overcast and Rain 1)'
elseif preset == 'RainyPreset2' then
  preset = 'VIS 1-5KM RA BKN/OVC 3/11 SCT 18/29 FEW 40 (Overcast and Rain 2)'
elseif preset == 'RainyPreset3' then
  preset = 'VIS 3-5KM RA OVC LYR 6/18 19/21 SCT 34 (Overcast and Rain 3)'
end

--------------------ATIS to Discord---------------------
if theatre == "Caucasus" then
  atisAnapa=ATIS:New(AIRBASE.Caucasus.Anapa_Vityazevo, 125.400)
  atisAnapa:ReportQNHOnly()
  atisAnapa:ReportZuluTimeOnly()
  atisAnapa:SetZuluTimeDifference(4)
  atisAnapa:SetRadioRelayUnitName("RelayAnapa")
  atisAnapa:SetTowerFrequencies({250, 121, 38.4})
  atisAnapa:AddILS(108.500, "04")
  atisAnapa:AddILS(109.500, "22")
  atisAnapa:SetTACAN(59)
  atisAnapa:SetVOR(112.20)
  atisAnapa:Start()

  function atisAnapa:onafterReport(From, Event, To, Report)
    if Report == nil then
      env.info("Report is nil")
    else
      myReport = {}
	  myReport = '```'..SERVERNAME..' \n'
      myReport = myReport..Report..' \n'
      myReport = myReport..preset..'```'
    end
  end
  atisAnapa:onafterReport()

elseif theatre == "Nevada" then
  atisNellis=ATIS:New(AIRBASE.Nevada.Nellis_AFB, 270.100)
  atisNellis:ReportQNHOnly()
  atisNellis:ReportZuluTimeOnly()
  --atisNellis:SetZuluTimeDifference(4)
  atisNellis:SetRadioRelayUnitName("Radio Relay Nellis")
  atisNellis:SetActiveRunway("03R")
  atisNellis:SetActiveRunway("21L")
  atisNellis:SetTowerFrequencies({327.0, 132.550, 38.7})
  atisNellis:SetTACAN(12)
  atisNellis:AddILS(109.1, "21L")
  atisNellis:Start()

  function atisNellis:onafterReport(From, Event, To, Report)
    if Report == nil then
      env.info("Report is nil")
    else
      myReport = {}
      myReport.messageType=6
	  myReport.messageString = '```'..SERVERNAME..'\n'
      myReport.messageString = myReport.messageString..Report..'\n'
      myReport.messageString = myReport.messageString..preset..'```'
    end

  end
  atisNellis:onafterReport()

elseif theatre == "PersianGulf" then
  atisAlMinhad=ATIS:New(AIRBASE.PersianGulf.Al_Minhad_AB, 126.475)
  atisAlMinhad:SetRadioRelayUnitName("Radio Relay Al Minhad")
  atisAlMinhad:ReportQNHOnly()
  atisAlMinhad:ReportZuluTimeOnly()
  atisAlMinhad:AddILS(110.700, "9")
  atisAlMinhad:AddILS(110.750, "27")
  atisAlMinhad:SetTowerFrequencies({250.1, 121.8, 38.5})
  atisAlMinhad:SetTACAN(99)
  atisAlMinhad:Start()

  function atisAlMinhad:onafterReport(From, Event, To, Report)
    if Report == nil then
      env.info("Report is nil")
    else
      myReport = {}
      myReport.messageType=6
	  myReport.messageString = '```'..SERVERNAME..'\n'
      myReport.messageString = myReport.messageString..Report..'\n'
      myReport.messageString = myReport.messageString..preset..'```'
    end

  end
  atisAlMinhad:onafterReport()
  
elseif theatre == "MarianaIslands" then
  atisAndersen=ATIS:New(AIRBASE.MarianaIslands.Andersen_AFB, 254.325)
  atisAndersen:ReportQNHOnly()
  atisAndersen:ReportZuluTimeOnly()
  atisAndersen:SetZuluTimeDifference(4)
  atisAndersen:SetRadioRelayUnitName("RelayAndersen")
  atisAndersen:SetTowerFrequencies({250.1, 126.2, 38.6})
  atisAndersen:SetRunwayHeadingsMagnetic(24)
  -- atisAndersen:AddILS(109.350, "24R")
  -- atisAndersen:AddILS(110.150, "24L")
  -- atisAndersen:AddILS(109.300, "06R")
  -- atisAndersen:AddILS(110.100, "06L")
  atisAndersen:SetTACAN(54)
  atisAndersen:Start()

  function atisAndersen:onafterReport(From, Event, To, Report)
    if Report == nil then
      env.info("Report is nil")
    else
      myReport = {}
      myReport.messageType=6
	  myReport.messageString = '```'..SERVERNAME..'\n'
      myReport.messageString = myReport.messageString..Report..'\n'
      myReport.messageString = myReport.messageString..preset..'```'
    end
 end
  atisAndersen:onafterReport()

elseif theatre == "Falklands" then
  atisPleasant=ATIS:New(AIRBASE.SouthAtlantic.Mount_Pleasant, 128.55)
  atisPleasant:ReportQNHOnly()
  atisPleasant:ReportZuluTimeOnly()
  --atisPleasant:SetZuluTimeDifference(4)
  atisPleasant:SetRadioRelayUnitName("RelayPleasant")
  atisPleasant:SetActiveRunway("28")

  atisPleasant:SetTowerFrequencies({250.050, 133.350, 38.450})
  atisPleasant:SetTACAN(59)
  atisPleasant:AddILS(111.90, "28")
  atisPleasant:Start()

  function atisPleasant:onafterReport(From, Event, To, Report)
    if Report == nil then
      env.info("Report is nil")
    else
      myReport = {}
      myReport.messageType=6
	  myReport.messageString = '```'..SERVERNAME..'\n'
      myReport.messageString = myReport.messageString..Report..'\n'
      myReport.messageString = myReport.messageString..preset..'```'
    end

  end
  atisPleasant:onafterReport()

elseif theatre == "Syria" then
  atisAkro=ATIS:New(AIRBASE.Syria.Akrotiri, 254.325)
  atisAkro:ReportQNHOnly()
  atisAkro:ReportZuluTimeOnly()
  atisAkro:SetZuluTimeDifference(4)
  atisAkro:SetRadioRelayUnitName("RelayAkro")
  atisAkro:SetTowerFrequencies({251.750, 128.0, 40.2})
  atisAkro:SetRunwayHeadingsMagnetic(24)
  atisAkro:AddILS(109.700, "28")
  -- atisAkro:AddILS(110.150, "24L")
  -- atisAkro:AddILS(109.300, "06R")
  -- atisAkro:AddILS(110.100, "06L")
  atisAkro:SetTACAN(107)
  atisAkro:Start()

  function atisAkro:onafterReport(From, Event, To, Report)
    if Report == nil then
      env.info("Report is nil")
    else
      myReport = {}
      myReport.messageType=6
	  myReport.messageString = '```'..SERVERNAME..'\n'
      myReport.messageString = myReport.messageString..Report..'\n'
      myReport.messageString = myReport.messageString..preset..'```'
    end
 end
  atisAkro:onafterReport()
end

function metar()
  myAtis=SOCKET:New()
  myAtis:SendText(myReport)
end
if theatre == "Caucasus" then
  MENU_MISSION_COMMAND:New ("Send Metar to Discord", adminMenu, metar)
elseif theatre == "Nevada" then
  MENU_MISSION_COMMAND:New ("Send Metar to Discord", mainmenu, metar)
elseif theatre == "PersianGulf" then
  MENU_MISSION_COMMAND:New ("Send Metar to Discord", mainmenu, metar)
elseif theatre == "MarianaIslands" then
  MENU_MISSION_COMMAND:New ("Send Metar to Discord", adminMenu, metar)
elseif theatre == "Falklands" then
  MENU_MISSION_COMMAND:New ("Send Metar to Discord", adminMenu, metar)    
end

weatherTimer = TIMER:New(metar)
weatherTimer:Start(5, 14400)


