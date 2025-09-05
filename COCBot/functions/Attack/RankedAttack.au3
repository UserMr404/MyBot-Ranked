; #FUNCTION# ====================================================================================================================
; Name ..........: RankedAttack
; Description ...: Handles ranked attack mode with daily limits and separate army composition
; Syntax ........: RankedAttack()
; Parameters ....: None
; Return values .: True if attack successful, False otherwise
; Author ........: MyBot Team
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2025
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func RankedAttack()
	SetLog("========== RANKED ATTACK MODE ==========", $COLOR_INFO)
	
	; Check for 7 AM reset first
	CheckRankedDailyReset()
	
	; Check daily limit
	If $g_iRankedAttacksRemaining <= 0 Then
		SetLog("Daily ranked attack limit reached (0/6 remaining)", $COLOR_WARNING)
		Return False
	EndIf
	
	SetLog("Ranked Attack - " & $g_iRankedAttacksRemaining & " attacks remaining today", $COLOR_INFO)
	
	; Prepare for attack (no search in ranked mode)
	Local $bReadyForAttack = False
	
	; Find and click the Ranked Attack button
	Local $bRankedMode = True
	If PrepareSearch($bRankedMode) Then
		SetLog("Ranked attack button found and clicked", $COLOR_SUCCESS)
		$bReadyForAttack = True
	Else
		SetLog("Could not find ranked attack button", $COLOR_ERROR)
		Return False
	EndIf
	
	If $bReadyForAttack Then
		; Attack will start immediately without search
		SetLog("Starting ranked attack on first base...", $COLOR_ACTION)
		
		; Increment attack counter
		$g_iRankedAttacksToday += 1
		$g_iTotalRankedAttacksAllTime += 1
		
		; Execute the attack based on strategy
		Local $bAttackSuccess = False
		If $g_iRankedAttackStrategy = 1 And $g_sRankedCSVFile <> "" Then
			; CSV Scripted Attack
			SetLog("Executing CSV scripted ranked attack", $COLOR_INFO)
			$bAttackSuccess = ExecuteRankedCSVAttack()
		Else
			; Standard Attack using existing bot functions
			SetLog("Executing standard ranked attack", $COLOR_INFO)
			$bAttackSuccess = ExecuteRankedStandardAttack()
		EndIf
		
		If $bAttackSuccess Then
			; Wait for battle to end
			WaitForRankedBattleEnd()
			
			; Process results using existing AttackReport
			ProcessRankedAttackResults()
			
			SetLog("Ranked attack completed successfully", $COLOR_SUCCESS)
			
			; Update GUI
			GUICtrlSetData($g_hLblRankedAttacksLeft, $g_iMaxRankedAttacks - $g_iRankedAttacksToday)
			
			; Save progress
			SaveRankedConfig()
			
			; Return home
			ReturnHome(False, False)
			
			Return True
		Else
			SetLog("Ranked attack failed to execute", $COLOR_ERROR)
		EndIf
	EndIf
	
	Return False
EndFunc   ;==>RankedAttack

Func ExecuteRankedStandardAttack()
	; Execute standard attack using existing bot attack functions
	SetLog("Deploying ranked army (Standard Attack)", $COLOR_INFO)
	
	; Get attack bar information
	Local $aAttackBar = $g_avAttackTroops ; Use the global attack troops array directly
	If Not IsArray($aAttackBar) Then
		SetLog("Failed to read attack bar", $COLOR_ERROR)
		Return False
	EndIf
	
	; Deploy troops using existing LaunchTroop2 function
	; This function handles all troops, spells, heroes, and CC
	Local $iCC = -1, $iKing = -1, $iQueen = -1, $iPrince = -1, $iWarden = -1, $iChampion = -1
	
	; Find hero positions based on ranked settings
	For $i = 0 To UBound($aAttackBar) - 1
		Switch $aAttackBar[$i][0]
			Case $eHeroKing
				If $g_bRankedUseKing Then $iKing = $i
			Case $eHeroQueen
				If $g_bRankedUseQueen Then $iQueen = $i
			Case $eHeroPrince
				If $g_bRankedUsePrince Then $iPrince = $i
			Case $eHeroWarden
				If $g_bRankedUseWarden Then $iWarden = $i
			Case $eHeroChampion
				If $g_bRankedUseChampion Then $iChampion = $i
		EndSwitch
	Next
	
	; Build deployment list based on ranked composition
	Local $listInfoDeploy[0][5]
	For $i = 0 To UBound($aAttackBar) - 1
		Local $iTroopIndex = $aAttackBar[$i][0]
		If $iTroopIndex < $eTroopCount And $g_aiRankedArmyComp[$iTroopIndex] > 0 Then
			; Add troop to deployment list
			Local $aAdd[1][5] = [[$iTroopIndex, $i, $g_aiRankedArmyComp[$iTroopIndex], 0, "RANDOM"]]
			_ArrayAdd($listInfoDeploy, $aAdd)
		EndIf
	Next
	
	; Use existing LaunchTroop2 to deploy everything
	LaunchTroop2($listInfoDeploy, $iCC, $iKing, $iQueen, $iPrince, $iWarden, $iChampion)
	
	Return True
EndFunc   ;==>ExecuteRankedStandardAttack

Func ExecuteRankedCSVAttack()
	; Execute CSV scripted attack using existing CSV system
	Local $sCSVPath = $g_sRankedCSVFile
	
	; Validate CSV file exists
	If Not FileExists($sCSVPath) Then
		SetLog("CSV file not found: " & $sCSVPath, $COLOR_ERROR)
		Return False
	EndIf
	
	; Use existing CSV attack system
	; The AttackCSV function from the main bot handles everything
	Return AttackCSV($sCSVPath)
EndFunc   ;==>ExecuteRankedCSVAttack

Func CheckRankedArmyReady()
	; Check if ranked army is ready for attack
	SetLog("Checking if ranked army is ready...", $COLOR_INFO)
	
	; Open army overview to check
	If Not OpenArmyOverview(True, "CheckRankedArmyReady()") Then
		Return False
	EndIf
	
	; Check if we have the required troops
	Local $bReady = True
	Local $aTroopCounts = getArmyTroops(True, False, False)
	
	For $i = 0 To $eTroopCount - 1
		If $g_aiRankedArmyComp[$i] > 0 Then
			Local $iCurrentCount = 0
			For $j = 0 To UBound($aTroopCounts) - 1
				If $aTroopCounts[$j][0] = $i Then
					$iCurrentCount = $aTroopCounts[$j][1]
					ExitLoop
				EndIf
			Next
			
			If $iCurrentCount < $g_aiRankedArmyComp[$i] Then
				SetLog($g_asTroopNames[$i] & ": " & $iCurrentCount & "/" & $g_aiRankedArmyComp[$i], $COLOR_WARNING)
				$bReady = False
			EndIf
		EndIf
	Next
	
	ClickAway()
	Return $bReady
EndFunc   ;==>CheckRankedArmyReady

Func TrainRankedArmy()
	; Train the ranked army composition using existing training system
	SetLog("Training ranked army...", $COLOR_INFO)
	
	; Open army window
	If Not OpenArmyOverview(True, "TrainRankedArmy()") Then
		SetLog("Failed to open army window", $COLOR_ERROR)
		Return False
	EndIf
	
	; Clear existing army if needed
	If IsQueueEmpty("Troops", False, False) = False Then
		SetLog("Clearing existing queue", $COLOR_ACTION)
		; Clear queue logic here
	EndIf
	
	; Train troops using existing TrainIt function
	For $i = 0 To $eTroopCount - 1
		If $g_aiRankedArmyComp[$i] > 0 Then
			SetLog("Training " & $g_aiRankedArmyComp[$i] & " x " & $g_asTroopNames[$i], $COLOR_INFO)
			TrainIt($i, $g_aiRankedArmyComp[$i])
			If _Sleep(500) Then Return
		EndIf
	Next
	
	; Switch to spell tab and train spells
	If OpenSpellTab() Then
		For $i = 0 To $eSpellCount - 1
			If $g_aiRankedSpellComp[$i] > 0 Then
				SetLog("Training " & $g_aiRankedSpellComp[$i] & " x " & $g_asSpellNames[$i], $COLOR_INFO)
				TrainIt($eTroopCount + $i, $g_aiRankedSpellComp[$i])
				If _Sleep(500) Then Return
			EndIf
		Next
	EndIf
	
	; Train siege machine if enabled using existing TrainSiege function
	If $g_bRankedAlwaysUseSiege And $g_iRankedSiegeType >= 0 Then
		SetLog("Training siege machine", $COLOR_INFO)
		TrainSiege() ; Call existing function
	EndIf
	
	ClickAway()
	SetLog("Ranked army training completed", $COLOR_SUCCESS)
	Return True
EndFunc   ;==>TrainRankedArmy

Func WaitForRankedBattleEnd()
	; Wait for battle to end with timeout
	SetLog("Waiting for ranked battle to end...", $COLOR_INFO)
	
	Local $iMaxWaitTime = 180000 ; 3 minutes max
	Local $hTimer = __TimerInit()
	
	While __TimerDiff($hTimer) < $iMaxWaitTime
		; Check if battle has ended
		If _CheckPixel($aEndFightSceneAvl, True) Then
			SetLog("Battle ended", $COLOR_SUCCESS)
			ExitLoop
		EndIf
		
		If _Sleep(2000) Then Return
	WEnd
	
	; Force return if timeout
	If __TimerDiff($hTimer) >= $iMaxWaitTime Then
		SetLog("Battle timeout, forcing return", $COLOR_WARNING)
		ReturnHome(False, False)
	EndIf
EndFunc   ;==>WaitForRankedBattleEnd

Func ProcessRankedAttackResults()
	; Process attack results using existing AttackReport function
	SetLog("Processing ranked attack results...", $COLOR_INFO)
	
	; Call existing AttackReport to read results
	AttackReport()
	
	; Get the results from global variables set by AttackReport
	Local $aResults[4]
	$aResults[0] = $g_iStatsLastAttack[$eLootTrophy] ; Stars/trophies
	$aResults[1] = $g_iStatsLastAttack[$eLootGold]
	$aResults[2] = $g_iStatsLastAttack[$eLootElixir]
	$aResults[3] = $g_iStatsLastAttack[$eLootDarkElixir]
	
	; Store in ranked attack results array
	Local $iAttackIndex = $g_iRankedAttacksToday - 1
	If $iAttackIndex >= 0 And $iAttackIndex < 8 Then
		$g_aiRankedAttackResults[$iAttackIndex] = $aResults[0] & "|" & $aResults[1] & "|" & $aResults[2] & "|" & $aResults[3]
	EndIf
	
	; Update attack log
	Local $sLogEntry = @MDAY & "/" & @MON & " " & @HOUR & ":" & @MIN & " - Attack #" & $g_iRankedAttacksToday & ": " & _
					   "Trophies: " & $aResults[0] & ", Gold: " & $aResults[1] & ", Elixir: " & $aResults[2] & ", Dark: " & $aResults[3]
	$g_sRankedAttackLog &= $sLogEntry & @CRLF
	
	SetLog("Results: " & $sLogEntry, $COLOR_SUCCESS)
	
	Return $aResults
EndFunc   ;==>ProcessRankedAttackResults

; ============================================================================================================
; DAILY RESET AND CONFIGURATION FUNCTIONS  
; ============================================================================================================

Func CheckRankedDailyReset()
	; Check if it's past 7 AM and reset is needed
	Local $iCurrentHour = @HOUR
	Local $sCurrentDate = @YEAR & @MON & @MDAY
	
	; Check if we've passed 7 AM and haven't reset today
	If $iCurrentHour >= $g_iRankedResetHour And $g_sLastRankedResetDate <> $sCurrentDate Then
		; Reset daily counter
		$g_iRankedAttacksToday = 0
		$g_iRankedAttacksRemaining = 6  ; Reset to 6 attacks
		$g_sLastRankedResetDate = $sCurrentDate
		$g_sLastRankedResetTime = @HOUR & ":" & @MIN
		
		; Clear today's results
		For $i = 0 To 5  ; Changed to 6 attacks max
			$g_aiRankedAttackResults[$i] = ""
		Next
		
		SetLog("Ranked attacks reset for new day (7 AM reset)", $COLOR_SUCCESS)
		SaveRankedConfig()
		
		; Update GUI
		If $g_hTxtRankedAttacksRemaining <> 0 Then
			GUICtrlSetData($g_hTxtRankedAttacksRemaining, $g_iRankedAttacksRemaining)
		EndIf
		UpdateTimeToResetDisplay()
	EndIf
EndFunc   ;==>CheckRankedDailyReset

Func GetTimeToRankedReset()
	; Calculate time remaining until 7 AM reset
	Local $iCurrentHour = @HOUR
	Local $iCurrentMin = @MIN
	
	Local $iHoursToReset = 0
	Local $iMinsToReset = 0
	
	If $iCurrentHour < $g_iRankedResetHour Then
		; Reset is later today
		$iHoursToReset = $g_iRankedResetHour - $iCurrentHour - 1
		$iMinsToReset = 60 - $iCurrentMin
	Else
		; Reset is tomorrow
		$iHoursToReset = 24 - $iCurrentHour + $g_iRankedResetHour - 1
		$iMinsToReset = 60 - $iCurrentMin
	EndIf
	
	If $iMinsToReset = 60 Then
		$iMinsToReset = 0
		$iHoursToReset += 1
	EndIf
	
	Return StringFormat("%02d:%02d", $iHoursToReset, $iMinsToReset)
EndFunc   ;==>GetTimeToRankedReset

Func UpdateTimeToResetDisplay()
	; Update the GUI display showing time until reset
	If $g_hLblRankedResetTime <> 0 Then
		Local $sTimeToReset = GetTimeToRankedReset()
		GUICtrlSetData($g_hLblRankedResetTime, "Reset in: " & $sTimeToReset)
	EndIf
EndFunc   ;==>UpdateTimeToResetDisplay

Func SaveRankedConfig()
	; Save ranked configuration to INI file
	IniWrite($g_sProfileConfigPath, "ranked", "enabled", $g_bRankedModeEnabled ? 1 : 0)
	IniWrite($g_sProfileConfigPath, "ranked", "attacks_today", $g_iRankedAttacksToday)
	IniWrite($g_sProfileConfigPath, "ranked", "last_reset_date", $g_sLastRankedResetDate)
	IniWrite($g_sProfileConfigPath, "ranked", "total_attacks", $g_iTotalRankedAttacksAllTime)
	IniWrite($g_sProfileConfigPath, "ranked", "strategy", $g_iRankedAttackStrategy)
	IniWrite($g_sProfileConfigPath, "ranked", "csv_file", $g_sRankedCSVFile)
	
	; Save army composition
	For $i = 0 To $eTroopCount - 1
		IniWrite($g_sProfileConfigPath, "ranked_army", $g_asTroopShortNames[$i], $g_aiRankedArmyComp[$i])
	Next
	
	; Save spell composition  
	For $i = 0 To $eSpellCount - 1
		IniWrite($g_sProfileConfigPath, "ranked_spells", $g_asSpellShortNames[$i], $g_aiRankedSpellComp[$i])
	Next
	
	; Save hero settings
	IniWrite($g_sProfileConfigPath, "ranked_heroes", "king", $g_bRankedUseKing ? 1 : 0)
	IniWrite($g_sProfileConfigPath, "ranked_heroes", "queen", $g_bRankedUseQueen ? 1 : 0)
	IniWrite($g_sProfileConfigPath, "ranked_heroes", "prince", $g_bRankedUsePrince ? 1 : 0)
	IniWrite($g_sProfileConfigPath, "ranked_heroes", "warden", $g_bRankedUseWarden ? 1 : 0)
	IniWrite($g_sProfileConfigPath, "ranked_heroes", "champion", $g_bRankedUseChampion ? 1 : 0)
	
	; Save siege settings
	IniWrite($g_sProfileConfigPath, "ranked_siege", "always_use", $g_bRankedAlwaysUseSiege ? 1 : 0)
	IniWrite($g_sProfileConfigPath, "ranked_siege", "type", $g_iRankedSiegeType)
EndFunc   ;==>SaveRankedConfig

Func LoadRankedConfig()
	; Load ranked configuration from INI file
	$g_bRankedModeEnabled = IniRead($g_sProfileConfigPath, "ranked", "enabled", 0) = 1
	$g_iRankedAttacksToday = IniRead($g_sProfileConfigPath, "ranked", "attacks_today", 0)
	$g_sLastRankedResetDate = IniRead($g_sProfileConfigPath, "ranked", "last_reset_date", "")
	$g_iTotalRankedAttacksAllTime = IniRead($g_sProfileConfigPath, "ranked", "total_attacks", 0)
	$g_iRankedAttackStrategy = IniRead($g_sProfileConfigPath, "ranked", "strategy", 0)
	$g_sRankedCSVFile = IniRead($g_sProfileConfigPath, "ranked", "csv_file", "")
	
	; Load army composition
	For $i = 0 To $eTroopCount - 1
		$g_aiRankedArmyComp[$i] = IniRead($g_sProfileConfigPath, "ranked_army", $g_asTroopShortNames[$i], 0)
	Next
	
	; Load spell composition
	For $i = 0 To $eSpellCount - 1
		$g_aiRankedSpellComp[$i] = IniRead($g_sProfileConfigPath, "ranked_spells", $g_asSpellShortNames[$i], 0)
	Next
	
	; Load hero settings
	$g_bRankedUseKing = IniRead($g_sProfileConfigPath, "ranked_heroes", "king", 1) = 1
	$g_bRankedUseQueen = IniRead($g_sProfileConfigPath, "ranked_heroes", "queen", 1) = 1
	$g_bRankedUsePrince = IniRead($g_sProfileConfigPath, "ranked_heroes", "prince", 1) = 1
	$g_bRankedUseWarden = IniRead($g_sProfileConfigPath, "ranked_heroes", "warden", 1) = 1
	$g_bRankedUseChampion = IniRead($g_sProfileConfigPath, "ranked_heroes", "champion", 1) = 1
	
	; Load siege settings
	$g_bRankedAlwaysUseSiege = IniRead($g_sProfileConfigPath, "ranked_siege", "always_use", 1) = 1
	$g_iRankedSiegeType = IniRead($g_sProfileConfigPath, "ranked_siege", "type", 0)
	
	; Check for daily reset
	CheckRankedDailyReset()
EndFunc   ;==>LoadRankedConfig

; ============================================================================================================
; HELPER FUNCTIONS - These integrate with existing bot functions
; ============================================================================================================

Func OpenSpellTab()
	; Open spell tab in army window
	Click(275, 540) ; Click on spell tab
	If _Sleep(500) Then Return False
	Return True
EndFunc   ;==>OpenSpellTab

Func AttackCSV($sCSVPath)
	; Call the existing CSV attack function
	; This needs to be linked to the actual CSV attack system
	Return Algorithm_AttackCSV(False, False)
EndFunc   ;==>AttackCSV