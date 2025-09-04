; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design Child Attack - Ranked
; Description ...: This file creates the "Ranked Attack" tab under the "Attack Plan" tab
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: MyBot Development Team
; Modified ......: Created for Ranked Attack System Implementation
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2025
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

Global $g_hGUI_RANKED = 0

; GUI Control Handles
Global $g_hGrpRankedStatus = 0, $g_hGrpRankedArmy = 0, $g_hGrpRankedSpells = 0, $g_hGrpRankedStrategy = 0, $g_hGrpRankedHeroes = 0
Global $g_hBtnRankedReset = 0, $g_hChkRankedEnabled = 0
Global $g_hCmbRankedStrategy = 0, $g_hLblRankedCSV = 0, $g_hCmbRankedCSV = 0, $g_hCmbRankedSiege = 0, $g_hChkRankedAlwaysSiege = 0

Func CreateAttackRanked()
	$g_hGUI_RANKED = _GUICreate("", $g_iSizeWGrpTab2, $g_iSizeHGrpTab2, 5, 25, BitOR($WS_CHILD, $WS_TABSTOP), -1, $g_hGUI_ATTACK)
	
	Local $x = 10, $y = 10

	; Ranked Mode Enable/Disable
	$g_hChkRankedEnabled = GUICtrlCreateCheckbox("Enable Ranked Attack Mode", $x, $y, 200, 17)
		GUICtrlSetState(-1, $g_bRankedModeEnabled ? $GUI_CHECKED : $GUI_UNCHECKED)
		GUICtrlSetOnEvent(-1, "chkRankedEnabled")
		_GUICtrlSetTip(-1, "Enable/Disable the ranked attack system entirely")
		GUICtrlSetFont(-1, 9, 600)
	
	$y += 25

	; Attack Status Group
	$g_hGrpRankedStatus = GUICtrlCreateGroup("Ranked Attack Status", $x, $y, 430, 90)
		$g_hLblRankedAttacksLeft = GUICtrlCreateLabel("Attacks Remaining: 8/8", $x + 15, $y + 25, 250, 20)
			GUICtrlSetFont(-1, 10, 600)
			GUICtrlSetColor(-1, $COLOR_GREEN)
		$g_hLblRankedResetTime = GUICtrlCreateLabel("Next reset: Today at 7:00 AM", $x + 15, $y + 45, 250, 17)
			GUICtrlSetFont(-1, 8)
		
		; Manual reset button for testing
		$g_hBtnRankedReset = GUICtrlCreateButton("Reset Counter", $x + 330, $y + 25, 80, 25)
			GUICtrlSetOnEvent(-1, "btnRankedReset")
			_GUICtrlSetTip(-1, "Manual reset for testing - will auto reset daily at 7 AM")
		
		; Warning label
		GUICtrlCreateLabel("⚠ WARNING: Ranked mode attacks first base found - no searching allowed!", $x + 15, $y + 65, 400, 17)
			GUICtrlSetColor(-1, $COLOR_RED)
			GUICtrlSetFont(-1, 8, 600)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$y += 100

	; Ranked Army Composition Group
	$g_hGrpRankedArmy = GUICtrlCreateGroup("Ranked Army Composition", $x, $y, 430, 200)
		; Troop selection grid
		Local $iTroopX = $x + 15, $iTroopY = $y + 25
		Local $iTroopCount = 0
		
		; Create troop input controls in a grid layout
		For $i = 0 To $eTroopCount - 1
			If $iTroopCount > 0 And Mod($iTroopCount, 8) = 0 Then
				$iTroopX = $x + 15
				$iTroopY += 40
			EndIf
			
			; Create label for troop name (shortened)
			Local $sTroopShortName = StringLeft($g_asTroopNames[$i], 4)
			GUICtrlCreateLabel($sTroopShortName, $iTroopX, $iTroopY - 12, 35, 12)
				GUICtrlSetFont(-1, 7)
			
			; Troop count input
			$g_ahTxtRankedTroops[$i] = GUICtrlCreateInput("0", $iTroopX, $iTroopY, 35, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
				GUICtrlSetOnEvent(-1, "txtRankedTroop")
				_GUICtrlSetTip(-1, $g_asTroopNames[$i] & " count for ranked attacks")
				GUICtrlSetLimit(-1, 3) ; Max 3 digits
			
			$iTroopX += 50
			$iTroopCount += 1
		Next
		
		; Quick army presets
		GUICtrlCreateLabel("Quick Presets:", $x + 15, $iTroopY + 35, 80, 17)
			GUICtrlSetFont(-1, 8, 600)
		Local $g_hBtnRankedPreset1 = GUICtrlCreateButton("GoWiPe", $x + 100, $iTroopY + 32, 50, 25)
			GUICtrlSetOnEvent(-1, "btnRankedPreset1")
			_GUICtrlSetTip(-1, "Load GoWiPe army composition")
		Local $g_hBtnRankedPreset2 = GUICtrlCreateButton("LaLoon", $x + 155, $iTroopY + 32, 50, 25)
			GUICtrlSetOnEvent(-1, "btnRankedPreset2")
			_GUICtrlSetTip(-1, "Load LavaLoon army composition")
		Local $g_hBtnRankedPreset3 = GUICtrlCreateButton("Hybrid", $x + 210, $iTroopY + 32, 50, 25)
			GUICtrlSetOnEvent(-1, "btnRankedPreset3")
			_GUICtrlSetTip(-1, "Load Hybrid army composition")
		Local $g_hBtnRankedClearArmy = GUICtrlCreateButton("Clear", $x + 265, $iTroopY + 32, 45, 25)
			GUICtrlSetOnEvent(-1, "btnRankedClearArmy")
			_GUICtrlSetTip(-1, "Clear all troops")
		Local $g_hBtnRankedCopyNormal = GUICtrlCreateButton("Copy Normal", $x + 315, $iTroopY + 32, 75, 25)
			GUICtrlSetOnEvent(-1, "btnRankedCopyNormal")
			_GUICtrlSetTip(-1, "Copy army composition from normal mode")
			
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$y += 210

	; Ranked Spells Group
	$g_hGrpRankedSpells = GUICtrlCreateGroup("Ranked Spells & Siege", $x, $y, 430, 100)
		Local $iSpellX = $x + 15, $iSpellY = $y + 25
		
		; Create spell input controls
		For $i = 0 To $eSpellCount - 1
			If $i > 0 And Mod($i, 6) = 0 Then
				$iSpellX = $x + 15
				$iSpellY += 35
			EndIf
			
			; Create label for spell name (shortened)
			Local $sSpellShortName = StringLeft($g_asSpellNames[$i], 4)
			GUICtrlCreateLabel($sSpellShortName, $iSpellX, $iSpellY - 12, 35, 12)
				GUICtrlSetFont(-1, 7)
			
			; Spell count input
			$g_ahTxtRankedSpells[$i] = GUICtrlCreateInput("0", $iSpellX, $iSpellY, 35, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
				GUICtrlSetOnEvent(-1, "txtRankedSpell")
				_GUICtrlSetTip(-1, $g_asSpellNames[$i] & " count for ranked attacks")
				GUICtrlSetLimit(-1, 2) ; Max 2 digits
			
			$iSpellX += 65
		Next
		
		; Siege Machine settings
		GUICtrlCreateLabel("Siege Machine:", $x + 15, $iSpellY + 25, 85, 17)
			GUICtrlSetFont(-1, 8, 600)
		$g_hCmbRankedSiege = GUICtrlCreateCombo("", $x + 105, $iSpellY + 22, 120, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, "None|Wall Wrecker|Battle Blimp|Stone Slammer|Siege Barracks|Log Launcher|Flame Flinger|Battle Drill", "Wall Wrecker")
			GUICtrlSetOnEvent(-1, "cmbRankedSiege")
		
		$g_hChkRankedAlwaysSiege = GUICtrlCreateCheckbox("Always use Siege", $x + 235, $iSpellY + 24, 120, 17)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetOnEvent(-1, "chkRankedAlwaysSiege")
			_GUICtrlSetTip(-1, "Always deploy siege machine in ranked attacks")
			
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$y += 110

	; Heroes & Strategy Group
	$g_hGrpRankedHeroes = GUICtrlCreateGroup("Heroes & Strategy", $x, $y, 430, 120)
		; Heroes checkboxes
		GUICtrlCreateLabel("Use Heroes:", $x + 15, $y + 25, 70, 17)
			GUICtrlSetFont(-1, 8, 600)
		$g_ahChkRankedHeroes[0] = GUICtrlCreateCheckbox("King", $x + 90, $y + 23, 50, 17)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetOnEvent(-1, "chkRankedHero")
		$g_ahChkRankedHeroes[1] = GUICtrlCreateCheckbox("Queen", $x + 145, $y + 23, 50, 17)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetOnEvent(-1, "chkRankedHero")
		$g_ahChkRankedHeroes[2] = GUICtrlCreateCheckbox("Prince", $x + 200, $y + 23, 50, 17)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetOnEvent(-1, "chkRankedHero")
		$g_ahChkRankedHeroes[3] = GUICtrlCreateCheckbox("Warden", $x + 255, $y + 23, 55, 17)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetOnEvent(-1, "chkRankedHero")
		$g_ahChkRankedHeroes[4] = GUICtrlCreateCheckbox("Champion", $x + 315, $y + 23, 70, 17)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetOnEvent(-1, "chkRankedHero")
		
		; Attack Strategy
		GUICtrlCreateLabel("Attack Strategy:", $x + 15, $y + 50, 85, 17)
			GUICtrlSetFont(-1, 8, 600)
		$g_hCmbRankedStrategy = GUICtrlCreateCombo("", $x + 105, $y + 47, 100, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, "Standard|Scripted", "Standard")
			GUICtrlSetOnEvent(-1, "cmbRankedStrategy")
			_GUICtrlSetTip(-1, "Select ranked attack strategy type")
		
		; CSV File selection (hidden by default)
		$g_hLblRankedCSV = GUICtrlCreateLabel("CSV File:", $x + 215, $y + 50, 50, 17)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetFont(-1, 8, 600)
		$g_hCmbRankedCSV = GUICtrlCreateCombo("", $x + 270, $y + 47, 140, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetOnEvent(-1, "cmbRankedCSV")
		
		; Additional settings
		GUICtrlCreateLabel("Attack Timeout:", $x + 15, $y + 75, 85, 17)
			GUICtrlSetFont(-1, 8, 600)
		Global $g_hTxtRankedTimeout = GUICtrlCreateInput("300", $x + 105, $y + 72, 50, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetOnEvent(-1, "txtRankedTimeout")
			_GUICtrlSetTip(-1, "Attack timeout in seconds (default: 300)")
		GUICtrlCreateLabel("seconds", $x + 160, $y + 75, 40, 17)
		
		; Statistics display
		GUICtrlCreateLabel("Total Ranked Attacks:", $x + 220, $y + 75, 120, 17)
			GUICtrlSetFont(-1, 8, 600)
		Global $g_hLblRankedTotalAttacks = GUICtrlCreateLabel("0", $x + 345, $y + 75, 50, 17)
			GUICtrlSetFont(-1, 8)
		
		; Info label
		GUICtrlCreateLabel("ℹ Ranked attacks use separate army composition and strategy from normal attacks", $x + 15, $y + 95, 400, 17)
			GUICtrlSetColor(-1, $COLOR_BLUE)
			GUICtrlSetFont(-1, 8)
			
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	; Initialize GUI state
	UpdateRankedGUIState()
	PopulateCSVFiles()
	UpdateRankedStatus()

EndFunc   ;==>CreateAttackRanked

; ============================================================================================================
; EVENT HANDLERS
; ============================================================================================================

Func chkRankedEnabled()
	$g_bRankedModeEnabled = (GUICtrlRead($g_hChkRankedEnabled) = $GUI_CHECKED)
	UpdateRankedGUIState()
	SetLog("Ranked mode " & ($g_bRankedModeEnabled ? "enabled" : "disabled"), $COLOR_INFO)
EndFunc

Func UpdateRankedGUIState()
	; Enable/disable all ranked controls based on ranked mode status
	Local $iState = $g_bRankedModeEnabled ? $GUI_ENABLE : $GUI_DISABLE
	
	; Enable/disable all group controls
	If $g_hGrpRankedStatus <> 0 Then GUICtrlSetState($g_hGrpRankedStatus, $iState)
	If $g_hGrpRankedArmy <> 0 Then GUICtrlSetState($g_hGrpRankedArmy, $iState)
	If $g_hGrpRankedSpells <> 0 Then GUICtrlSetState($g_hGrpRankedSpells, $iState)
	If $g_hGrpRankedStrategy <> 0 Then GUICtrlSetState($g_hGrpRankedStrategy, $iState)
	If $g_hGrpRankedHeroes <> 0 Then GUICtrlSetState($g_hGrpRankedHeroes, $iState)
EndFunc

Func btnRankedReset()
	If $g_bRankedModeEnabled Then
		$g_iRankedAttacksToday = 0
		$g_sLastRankedResetDate = @YEAR & "/" & @MON & "/" & @MDAY
		$g_sLastRankedResetTime = @YEAR & "/" & @MON & "/" & @MDAY & " " & $g_iRankedResetHour & ":00:00"
		UpdateRankedStatus()
		SaveRankedConfig()
		SetLog("Ranked attack counter manually reset", $COLOR_INFO)
	Else
		SetLog("Ranked mode is disabled", $COLOR_ERROR)
	EndIf
EndFunc

Func UpdateRankedStatus()
	If $g_hLblRankedAttacksLeft = 0 Or $g_hLblRankedResetTime = 0 Then Return
	
	Local $iAttacksLeft = $g_iMaxRankedAttacks - $g_iRankedAttacksToday
	GUICtrlSetData($g_hLblRankedAttacksLeft, "Attacks Remaining: " & $iAttacksLeft & "/" & $g_iMaxRankedAttacks)
	
	; Set color based on attacks left
	If $iAttacksLeft = 0 Then
		GUICtrlSetColor($g_hLblRankedAttacksLeft, $COLOR_RED)
	ElseIf $iAttacksLeft <= 2 Then
		GUICtrlSetColor($g_hLblRankedAttacksLeft, $COLOR_ORANGE)
	Else
		GUICtrlSetColor($g_hLblRankedAttacksLeft, $COLOR_GREEN)
	EndIf
	
	; Calculate time until next 7 AM reset
	Local $sResetTime = CalculateNext7AMReset()
	GUICtrlSetData($g_hLblRankedResetTime, "Next reset: " & $sResetTime)
	
	; Update total attacks counter
	If $g_hLblRankedTotalAttacks <> 0 Then
		GUICtrlSetData($g_hLblRankedTotalAttacks, $g_iTotalRankedAttacksAllTime)
	EndIf
EndFunc

Func CalculateNext7AMReset()
	; Calculate time until next 7 AM
	Local $iCurrentHour = @HOUR
	Local $iCurrentMin = @MIN
	Local $iCurrentSec = @SEC
	
	Local $sResetTime = ""
	
	If $iCurrentHour < $g_iRankedResetHour Then
		; Reset is today at 7 AM
		Local $iHoursLeft = $g_iRankedResetHour - $iCurrentHour - 1
		Local $iMinutesLeft = 60 - $iCurrentMin
		If $iCurrentMin = 0 Then
			$iHoursLeft += 1
			$iMinutesLeft = 0
		EndIf
		$sResetTime = "Today in " & $iHoursLeft & "h " & $iMinutesLeft & "m"
	Else
		; Reset is tomorrow at 7 AM
		Local $iHoursLeft = (24 - $iCurrentHour) + $g_iRankedResetHour - 1
		Local $iMinutesLeft = 60 - $iCurrentMin
		If $iCurrentMin = 0 Then
			$iHoursLeft += 1
			$iMinutesLeft = 0
		EndIf
		$sResetTime = "Tomorrow in " & $iHoursLeft & "h " & $iMinutesLeft & "m"
	EndIf
	
	Return $sResetTime
EndFunc

Func cmbRankedStrategy()
	If GUICtrlRead($g_hCmbRankedStrategy) = "Scripted" Then
		; Show CSV file selection
		GUICtrlSetState($g_hLblRankedCSV, $GUI_SHOW)
		GUICtrlSetState($g_hCmbRankedCSV, $GUI_SHOW)
		$g_iRankedAttackStrategy = 1
	Else
		; Hide CSV file selection
		GUICtrlSetState($g_hLblRankedCSV, $GUI_HIDE)
		GUICtrlSetState($g_hCmbRankedCSV, $GUI_HIDE)
		$g_iRankedAttackStrategy = 0
	EndIf
	SetLog("Ranked attack strategy set to: " & GUICtrlRead($g_hCmbRankedStrategy), $COLOR_INFO)
EndFunc

Func cmbRankedCSV()
	$g_sRankedCSVFile = GUICtrlRead($g_hCmbRankedCSV)
	SetLog("Ranked CSV file set to: " & $g_sRankedCSVFile, $COLOR_INFO)
EndFunc

Func PopulateCSVFiles()
	; Populate CSV combo with available attack scripts
	If $g_hCmbRankedCSV = 0 Then Return
	
	Local $aFiles = _FileListToArray(@ScriptDir & "\CSV\Attack\", "*.csv", $FLTA_FILES)
	If IsArray($aFiles) And $aFiles[0] > 0 Then
		Local $sFileList = ""
		For $i = 1 To $aFiles[0]
			$sFileList &= StringTrimRight($aFiles[$i], 4) & "|"
		Next
		GUICtrlSetData($g_hCmbRankedCSV, StringTrimRight($sFileList, 1))
	EndIf
EndFunc

; Army preset functions
Func btnRankedPreset1()
	; GoWiPe preset
	ClearRankedArmy()
	; Set troops (example - adjust based on actual troop indices)
	GUICtrlSetData($g_ahTxtRankedTroops[$eTroopGolem], "2")
	GUICtrlSetData($g_ahTxtRankedTroops[$eTroopWizard], "8")
	GUICtrlSetData($g_ahTxtRankedTroops[$eTroopPekka], "3")
	GUICtrlSetData($g_ahTxtRankedTroops[$eTroopWallBreaker], "6")
	; Set spells
	GUICtrlSetData($g_ahTxtRankedSpells[$eSpellRage], "2")
	GUICtrlSetData($g_ahTxtRankedSpells[$eSpellHeal], "2")
	GUICtrlSetData($g_ahTxtRankedSpells[$eSpellJump], "1")
	SetLog("Loaded GoWiPe army preset for ranked attacks", $COLOR_SUCCESS)
EndFunc

Func btnRankedPreset2()
	; LaLoon preset  
	ClearRankedArmy()
	GUICtrlSetData($g_ahTxtRankedTroops[$eTroopLavaHound], "2")
	GUICtrlSetData($g_ahTxtRankedTroops[$eTroopBalloon], "20")
	GUICtrlSetData($g_ahTxtRankedTroops[$eTroopMinion], "8")
	GUICtrlSetData($g_ahTxtRankedSpells[$eSpellRage], "3")
	GUICtrlSetData($g_ahTxtRankedSpells[$eSpellHaste], "2")
	SetLog("Loaded LavaLoon army preset for ranked attacks", $COLOR_SUCCESS)
EndFunc

Func btnRankedPreset3()
	; Hybrid preset
	ClearRankedArmy()
	GUICtrlSetData($g_ahTxtRankedTroops[$eTroopMiner], "8")
	GUICtrlSetData($g_ahTxtRankedTroops[$eTroopHogRider], "12")
	GUICtrlSetData($g_ahTxtRankedTroops[$eTroopValkyrie], "2")
	GUICtrlSetData($g_ahTxtRankedSpells[$eSpellHeal], "3")
	GUICtrlSetData($g_ahTxtRankedSpells[$eSpellRage], "1")
	SetLog("Loaded Hybrid army preset for ranked attacks", $COLOR_SUCCESS)
EndFunc

Func btnRankedClearArmy()
	ClearRankedArmy()
	SetLog("Cleared ranked army composition", $COLOR_INFO)
EndFunc

Func ClearRankedArmy()
	; Clear all troop counts
	For $i = 0 To $eTroopCount - 1
		If $g_ahTxtRankedTroops[$i] <> 0 Then
			GUICtrlSetData($g_ahTxtRankedTroops[$i], "0")
			$g_aiRankedArmyComp[$i] = 0
		EndIf
	Next
	
	; Clear all spell counts
	For $i = 0 To $eSpellCount - 1
		If $g_ahTxtRankedSpells[$i] <> 0 Then
			GUICtrlSetData($g_ahTxtRankedSpells[$i], "0")
			$g_aiRankedSpellComp[$i] = 0
		EndIf
	Next
EndFunc

Func btnRankedCopyNormal()
	; Copy army composition from normal mode (would need to be implemented based on normal army storage)
	SetLog("Copy from normal mode not yet implemented", $COLOR_WARNING)
EndFunc

; Input validation functions
Func txtRankedTroop()
	; Validate and update troop counts
	For $i = 0 To $eTroopCount - 1
		If $g_ahTxtRankedTroops[$i] <> 0 Then
			$g_aiRankedArmyComp[$i] = Number(GUICtrlRead($g_ahTxtRankedTroops[$i]))
			If $g_aiRankedArmyComp[$i] < 0 Then
				$g_aiRankedArmyComp[$i] = 0
				GUICtrlSetData($g_ahTxtRankedTroops[$i], "0")
			EndIf
		EndIf
	Next
EndFunc

Func txtRankedSpell()
	; Validate and update spell counts
	For $i = 0 To $eSpellCount - 1
		If $g_ahTxtRankedSpells[$i] <> 0 Then
			$g_aiRankedSpellComp[$i] = Number(GUICtrlRead($g_ahTxtRankedSpells[$i]))
			If $g_aiRankedSpellComp[$i] < 0 Then
				$g_aiRankedSpellComp[$i] = 0
				GUICtrlSetData($g_ahTxtRankedSpells[$i], "0")
			EndIf
		EndIf
	Next
EndFunc

Func chkRankedHero()
	; Update hero usage flags
	$g_bRankedUseKing = (GUICtrlRead($g_ahChkRankedHeroes[0]) = $GUI_CHECKED)
	$g_bRankedUseQueen = (GUICtrlRead($g_ahChkRankedHeroes[1]) = $GUI_CHECKED)
	$g_bRankedUsePrince = (GUICtrlRead($g_ahChkRankedHeroes[2]) = $GUI_CHECKED)
	$g_bRankedUseWarden = (GUICtrlRead($g_ahChkRankedHeroes[3]) = $GUI_CHECKED)
	$g_bRankedUseChampion = (GUICtrlRead($g_ahChkRankedHeroes[4]) = $GUI_CHECKED)
EndFunc

Func cmbRankedSiege()
	Local $sSiegeSelection = GUICtrlRead($g_hCmbRankedSiege)
	
	Switch $sSiegeSelection
		Case "None"
			$g_iRankedSiegeType = -1
		Case "Wall Wrecker"
			$g_iRankedSiegeType = $eSiegeWallWrecker
		Case "Battle Blimp"
			$g_iRankedSiegeType = $eSiegeBattleBlimp
		Case "Stone Slammer"
			$g_iRankedSiegeType = $eSiegeStoneSlammer
		Case "Siege Barracks"
			$g_iRankedSiegeType = $eSiegeBarracks
		Case "Log Launcher"
			$g_iRankedSiegeType = $eSiegeLogLauncher
		Case "Flame Flinger"
			$g_iRankedSiegeType = $eSiegeFlameFlinger
		Case "Battle Drill"
			$g_iRankedSiegeType = $eSiegeBattleDrill
		Case Else
			$g_iRankedSiegeType = $eSiegeWallWrecker
	EndSwitch
	
	SetLog("Ranked siege machine set to: " & $sSiegeSelection, $COLOR_INFO)
EndFunc

Func chkRankedAlwaysSiege()
	$g_bRankedAlwaysUseSiege = (GUICtrlRead($g_hChkRankedAlwaysSiege) = $GUI_CHECKED)
	SetLog("Ranked always use siege: " & ($g_bRankedAlwaysUseSiege ? "enabled" : "disabled"), $COLOR_INFO)
EndFunc

Func txtRankedTimeout()
	$g_iRankedAttackTimeout = Number(GUICtrlRead($g_hTxtRankedTimeout)) * 1000 ; Convert to milliseconds
	If $g_iRankedAttackTimeout < 60000 Then ; Minimum 60 seconds
		$g_iRankedAttackTimeout = 60000
		GUICtrlSetData($g_hTxtRankedTimeout, "60")
	ElseIf $g_iRankedAttackTimeout > 600000 Then ; Maximum 600 seconds (10 minutes)
		$g_iRankedAttackTimeout = 600000
		GUICtrlSetData($g_hTxtRankedTimeout, "600")
	EndIf
EndFunc