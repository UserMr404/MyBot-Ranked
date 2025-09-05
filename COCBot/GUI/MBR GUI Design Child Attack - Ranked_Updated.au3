; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design Child Attack - Ranked
; Description ...: This file creates the "Ranked Attack" tab under the "Attack Plan" tab
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: MyBot Development Team
; Modified ......: Enhanced with sub-tabs from Train Army and Deadbase Attack
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2025
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

Global $g_hGUI_RANKED = 0

; Main tab control for Ranked
Global $g_hGUI_RANKED_TAB = 0
Global $g_hGUI_RANKED_TAB_ITEM1 = 0 ; Overview & Status
Global $g_hGUI_RANKED_TAB_ITEM2 = 0 ; Army Composition (with Custom/Quick sub-tabs)
Global $g_hGUI_RANKED_TAB_ITEM3 = 0 ; Attack Settings (from Deadbase Attack)

; Sub-GUIs for each tab
Global $g_hGUI_RANKED_OVERVIEW = 0
Global $g_hGUI_RANKED_ARMY = 0
Global $g_hGUI_RANKED_ATTACK = 0

; Army sub-tab (Custom Train / Quick Train)
Global $g_hGUI_RANKED_ARMY_TAB = 0
Global $g_hGUI_RANKED_ARMY_TAB_ITEM1 = 0 ; Custom Train
Global $g_hGUI_RANKED_ARMY_TAB_ITEM2 = 0 ; Quick Train

; GUI Control Handles for Overview
Global $g_hChkRankedEnabled = 0
Global $g_hLblRankedAttacksLeft = 0, $g_hLblRankedResetTime = 0, $g_hLblRankedTotalAttacks = 0

; Separate Ranked Army Variables (to avoid conflict with main army)
Global $g_ahTxtRankedTrainArmyTroopCount[$eTroopCount]
Global $g_ahTxtRankedTrainArmySpellCount[$eSpellCount]
Global $g_ahTxtRankedTrainArmySiegeCount[$eSiegeMachineCount]
Global $g_ahPicRankedTrainArmyTroop[$eTroopCount]
Global $g_ahPicRankedTrainArmySpell[$eSpellCount]
Global $g_ahPicRankedTrainArmySiege[$eSiegeMachineCount]

; Ranked Quick Train Variables
Global $g_ahChkRankedUseQuickTrain[3] = [0, 0, 0]
Global $g_ahChkRankedQuickArmyTroop[3][$eTroopCount]
Global $g_ahChkRankedQuickArmySpell[3][$eSpellCount]

; Ranked Attack Settings Variables (separate from normal attack)
Global $g_hChkRankedDeployKing = 0, $g_hChkRankedDeployQueen = 0, $g_hChkRankedDeployPrince = 0
Global $g_hChkRankedDeployWarden = 0, $g_hChkRankedDeployChampion = 0
Global $g_hCmbRankedDeployOrder = 0
Global $g_hChkRankedUseCCTroops = 0, $g_hChkRankedUseCCSpells = 0, $g_hChkRankedUseCCSiege = 0
Global $g_hChkRankedDropCCFirst = 0
Global $g_ahChkRankedSpells[$eSpellCount] ; Which spells to use in ranked attack

Func CreateAttackRanked()
	$g_hGUI_RANKED = _GUICreate("", $g_iSizeWGrpTab2, $g_iSizeHGrpTab2, 5, 25, BitOR($WS_CHILD, $WS_TABSTOP), -1, $g_hGUI_ATTACK)
	
	; Create the main tab control for Ranked
	$g_hGUI_RANKED_TAB = GUICtrlCreateTab(0, 0, $g_iSizeWGrpTab2, $g_iSizeHGrpTab2, BitOR($TCS_MULTILINE, $TCS_RIGHTJUSTIFY))
	
	; Tab 1: Overview & Status
	$g_hGUI_RANKED_TAB_ITEM1 = GUICtrlCreateTabItem("Overview")
	CreateRankedOverview()
	
	; Tab 2: Army Composition
	$g_hGUI_RANKED_TAB_ITEM2 = GUICtrlCreateTabItem("Army Composition")
	CreateRankedArmy()
	
	; Tab 3: Attack Settings
	$g_hGUI_RANKED_TAB_ITEM3 = GUICtrlCreateTabItem("Attack Settings")
	CreateRankedAttackSettings()
	
	GUICtrlCreateTabItem("")
	
	; Initialize default values
	LoadRankedConfig()
EndFunc   ;==>CreateAttackRanked

Func CreateRankedOverview()
	Local $x = 10, $y = 30
	
	; Enable/Disable Ranked Mode
	GUICtrlCreateGroup("Ranked Mode Status", $x, $y, 420, 100)
		$g_hChkRankedEnabled = GUICtrlCreateCheckbox("Enable Ranked Attack Mode", $x + 10, $y + 20, 200, 17)
			GUICtrlSetOnEvent(-1, "chkRankedEnabled")
			_GUICtrlSetTip(-1, "Enable or disable Ranked Attack mode" & @CRLF & _
							   "When enabled, bot will use separate army and attack settings")
		
		GUICtrlCreateLabel("Daily Attacks:", $x + 10, $y + 45, 80, 17)
		$g_hLblRankedAttacksLeft = GUICtrlCreateLabel("0 / 8", $x + 90, $y + 45, 50, 17)
			GUICtrlSetFont(-1, 9, $FW_BOLD)
			GUICtrlSetColor(-1, $COLOR_SUCCESS)
		
		GUICtrlCreateLabel("Reset Time:", $x + 150, $y + 45, 65, 17)
		$g_hLblRankedResetTime = GUICtrlCreateLabel("00:00:00", $x + 215, $y + 45, 60, 17)
			GUICtrlSetFont(-1, 9, $FW_BOLD)
		
		GUICtrlCreateLabel("Total Ranked Attacks:", $x + 10, $y + 70, 120, 17)
		$g_hLblRankedTotalAttacks = GUICtrlCreateLabel("0", $x + 130, $y + 70, 50, 17)
			GUICtrlSetFont(-1, 9, $FW_BOLD)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	
	$y += 110
	
	; Ranked Mode Information
	GUICtrlCreateGroup("Ranked Mode Information", $x, $y, 420, 150)
		Local $sInfo = "Ranked Attack Mode Features:" & @CRLF & _
					   "• 8 attacks maximum per day (resets at 7 AM)" & @CRLF & _
					   "• No searching - attacks first base found" & @CRLF & _
					   "• Separate army composition from normal attacks" & @CRLF & _
					   "• Independent attack settings and strategies" & @CRLF & _
					   "• All settings saved per profile"
		
		GUICtrlCreateLabel($sInfo, $x + 10, $y + 20, 400, 120)
			GUICtrlSetFont(-1, 9)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	
	$y += 160
	
	; Quick Actions
	GUICtrlCreateGroup("Quick Actions", $x, $y, 420, 60)
		Local $hBtnResetDaily = GUICtrlCreateButton("Reset Daily Counter", $x + 10, $y + 25, 120, 25)
			GUICtrlSetOnEvent(-1, "btnRankedResetDaily")
			_GUICtrlSetTip(-1, "Manually reset the daily attack counter")
		
		Local $hBtnSaveConfig = GUICtrlCreateButton("Save Configuration", $x + 140, $y + 25, 120, 25)
			GUICtrlSetOnEvent(-1, "btnRankedSaveConfig")
			_GUICtrlSetTip(-1, "Save current ranked configuration")
		
		Local $hBtnTestAttack = GUICtrlCreateButton("Test Ranked Attack", $x + 270, $y + 25, 120, 25)
			GUICtrlSetOnEvent(-1, "btnRankedTestAttack")
			_GUICtrlSetTip(-1, "Test ranked attack with current settings")
	GUICtrlCreateGroup("", -99, -99, 1, 1)
EndFunc   ;==>CreateRankedOverview

Func CreateRankedArmy()
	; Create container for army composition with sub-tabs
	Local $iSizeHGrpTab3 = 380
	Local $iSizeWGrpTab3 = 420
	
	; Create sub-tab for Custom/Quick train
	$g_hGUI_RANKED_ARMY_TAB = GUICtrlCreateTab(5, 30, $iSizeWGrpTab3, $iSizeHGrpTab3, BitOR($TCS_FORCELABELLEFT, $TCS_FIXEDWIDTH))
	_GUICtrlTab_SetItemSize($g_hGUI_RANKED_ARMY_TAB, 90, 20)
	
	; Custom Train Tab
	$g_hGUI_RANKED_ARMY_TAB_ITEM1 = GUICtrlCreateTabItem("Custom Train")
	CreateRankedCustomTrain()
	
	; Quick Train Tab  
	$g_hGUI_RANKED_ARMY_TAB_ITEM2 = GUICtrlCreateTabItem("Quick Train")
	CreateRankedQuickTrain()
	
	GUICtrlCreateTabItem("")
EndFunc   ;==>CreateRankedArmy

Func CreateRankedCustomTrain()
	Local $x = 10, $y = 60
	
	; Troops Section
	GUICtrlCreateLabel("Ranked Army Composition", $x, $y, 150, 17)
	GUICtrlSetFont(-1, 9, $FW_BOLD)
	$y += 20
	
	GUICtrlCreateLabel("Troops:", $x, $y, 50, 17)
	$y += 20
	
	; Create troop input grid (simplified - showing first 10 troops)
	Local $xStart = $x
	For $i = 0 To 9
		If $i = 5 Then
			$x = $xStart
			$y += 50
		EndIf
		
		; Troop icon placeholder
		$g_ahPicRankedTrainArmyTroop[$i] = GUICtrlCreateIcon($g_sLibIconPath, $g_aTroopsIcon[$i], $x, $y, 32, 32)
		
		; Troop count input
		$g_ahTxtRankedTrainArmyTroopCount[$i] = GUICtrlCreateInput("0", $x + 5, $y + 33, 25, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
		GUICtrlSetLimit(-1, 3)
		GUICtrlSetOnEvent(-1, "txtRankedTroopCount")
		_GUICtrlSetTip(-1, "Enter amount of " & $g_asTroopNames[$i] & " for ranked army")
		
		$x += 40
	Next
	
	$x = $xStart
	$y += 60
	
	; Spells Section
	GUICtrlCreateLabel("Spells:", $x, $y, 50, 17)
	$y += 20
	
	; Create spell input grid (showing first 5 spells)
	For $i = 0 To 4
		; Spell icon placeholder
		$g_ahPicRankedTrainArmySpell[$i] = GUICtrlCreateIcon($g_sLibIconPath, $g_aSpellsIcon[$i], $x, $y, 32, 32)
		
		; Spell count input
		$g_ahTxtRankedTrainArmySpellCount[$i] = GUICtrlCreateInput("0", $x + 5, $y + 33, 25, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
		GUICtrlSetLimit(-1, 2)
		GUICtrlSetOnEvent(-1, "txtRankedSpellCount")
		_GUICtrlSetTip(-1, "Enter amount of " & $g_asSpellNames[$i] & " for ranked army")
		
		$x += 40
	Next
	
	$x = $xStart
	$y += 60
	
	; Siege Machines Section
	GUICtrlCreateLabel("Siege Machines:", $x, $y, 100, 17)
	$y += 20
	
	Local $hCmbRankedSiege = GUICtrlCreateCombo("", $x, $y, 150, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	Local $sSiegeList = "None"
	For $i = 0 To $eSiegeMachineCount - 1
		$sSiegeList &= "|" & $g_asSiegeMachineNames[$i]
	Next
	GUICtrlSetData(-1, $sSiegeList, "None")
	GUICtrlSetOnEvent(-1, "cmbRankedSiege")
	
	$y += 30
	
	; Army capacity display
	GUICtrlCreateLabel("Army Capacity:", $x, $y, 80, 17)
	Local $hLblRankedArmyCapacity = GUICtrlCreateLabel("0 / 280", $x + 85, $y, 60, 17)
	GUICtrlSetFont(-1, 9, $FW_BOLD)
	GUICtrlSetColor(-1, $COLOR_SUCCESS)
EndFunc   ;==>CreateRankedCustomTrain

Func CreateRankedQuickTrain()
	Local $x = 10, $y = 60
	
	GUICtrlCreateLabel("Quick Train Armies for Ranked Mode", $x, $y, 200, 17)
	GUICtrlSetFont(-1, 9, $FW_BOLD)
	$y += 25
	
	; Quick Train Army 1
	$g_ahChkRankedUseQuickTrain[0] = GUICtrlCreateCheckbox("Quick Army 1", $x, $y, 100, 17)
	GUICtrlSetOnEvent(-1, "chkRankedQuickTrain1")
	
	Local $hBtnEditArmy1 = GUICtrlCreateButton("Edit", $x + 110, $y - 2, 40, 20)
	GUICtrlSetOnEvent(-1, "btnRankedEditQuickArmy1")
	
	Local $hBtnCopyArmy1 = GUICtrlCreateButton("Copy from Normal", $x + 160, $y - 2, 100, 20)
	GUICtrlSetOnEvent(-1, "btnRankedCopyQuickArmy1")
	_GUICtrlSetTip(-1, "Copy Quick Army 1 from normal attack settings")
	
	$y += 30
	
	; Quick Train Army 2
	$g_ahChkRankedUseQuickTrain[1] = GUICtrlCreateCheckbox("Quick Army 2", $x, $y, 100, 17)
	GUICtrlSetOnEvent(-1, "chkRankedQuickTrain2")
	
	Local $hBtnEditArmy2 = GUICtrlCreateButton("Edit", $x + 110, $y - 2, 40, 20)
	GUICtrlSetOnEvent(-1, "btnRankedEditQuickArmy2")
	
	Local $hBtnCopyArmy2 = GUICtrlCreateButton("Copy from Normal", $x + 160, $y - 2, 100, 20)
	GUICtrlSetOnEvent(-1, "btnRankedCopyQuickArmy2")
	_GUICtrlSetTip(-1, "Copy Quick Army 2 from normal attack settings")
	
	$y += 30
	
	; Quick Train Army 3
	$g_ahChkRankedUseQuickTrain[2] = GUICtrlCreateCheckbox("Quick Army 3", $x, $y, 100, 17)
	GUICtrlSetOnEvent(-1, "chkRankedQuickTrain3")
	
	Local $hBtnEditArmy3 = GUICtrlCreateButton("Edit", $x + 110, $y - 2, 40, 20)
	GUICtrlSetOnEvent(-1, "btnRankedEditQuickArmy3")
	
	Local $hBtnCopyArmy3 = GUICtrlCreateButton("Copy from Normal", $x + 160, $y - 2, 100, 20)
	GUICtrlSetOnEvent(-1, "btnRankedCopyQuickArmy3")
	_GUICtrlSetTip(-1, "Copy Quick Army 3 from normal attack settings")
	
	$y += 40
	
	GUICtrlCreateLabel("Quick Train Options:", $x, $y, 120, 17)
	GUICtrlSetFont(-1, 9, $FW_BOLD)
	$y += 20
	
	Local $hChkRankedQuickTrainCycle = GUICtrlCreateCheckbox("Cycle through Quick Armies", $x, $y, 180, 17)
	GUICtrlSetOnEvent(-1, "chkRankedQuickTrainCycle")
	_GUICtrlSetTip(-1, "Automatically cycle through enabled quick armies for each ranked attack")
	
	$y += 25
	
	Local $hChkRankedQuickTrainRandom = GUICtrlCreateCheckbox("Random Quick Army selection", $x, $y, 180, 17)
	GUICtrlSetOnEvent(-1, "chkRankedQuickTrainRandom")
	_GUICtrlSetTip(-1, "Randomly select from enabled quick armies for each ranked attack")
EndFunc   ;==>CreateRankedQuickTrain

Func CreateRankedAttackSettings()
	Local $x = 10, $y = 40
	
	; Deploy Settings Group
	GUICtrlCreateGroup("Ranked Deploy Settings", $x, $y, 210, 180)
		$y += 20
		
		GUICtrlCreateLabel("Deploy Order:", $x + 10, $y, 80, 17)
		$g_hCmbRankedDeployOrder = GUICtrlCreateCombo("", $x + 90, $y - 2, 110, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetData(-1, "Default|Troops-Heroes-CC|Heroes-Troops-CC|CC-Troops-Heroes", "Default")
		GUICtrlSetOnEvent(-1, "cmbRankedDeployOrder")
		
		$y += 30
		GUICtrlCreateLabel("Heroes to Deploy:", $x + 10, $y, 100, 17)
		$y += 20
		
		$g_hChkRankedDeployKing = GUICtrlCreateCheckbox("King", $x + 10, $y, 50, 17)
		GUICtrlSetOnEvent(-1, "chkRankedHero")
		$g_hChkRankedDeployQueen = GUICtrlCreateCheckbox("Queen", $x + 70, $y, 60, 17)
		GUICtrlSetOnEvent(-1, "chkRankedHero")
		$g_hChkRankedDeployPrince = GUICtrlCreateCheckbox("Prince", $x + 140, $y, 60, 17)
		GUICtrlSetOnEvent(-1, "chkRankedHero")
		
		$y += 20
		$g_hChkRankedDeployWarden = GUICtrlCreateCheckbox("Warden", $x + 10, $y, 65, 17)
		GUICtrlSetOnEvent(-1, "chkRankedHero")
		$g_hChkRankedDeployChampion = GUICtrlCreateCheckbox("Champion", $x + 80, $y, 75, 17)
		GUICtrlSetOnEvent(-1, "chkRankedHero")
		
		$y += 25
		GUICtrlCreateLabel("Hero Ability:", $x + 10, $y, 70, 17)
		Local $hCmbRankedHeroAbility = GUICtrlCreateCombo("", $x + 85, $y - 2, 120, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetData(-1, "Auto|Manual|Never|When Health < 50%", "Auto")
		GUICtrlSetOnEvent(-1, "cmbRankedHeroAbility")
		
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	
	$x = 230
	$y = 40
	
	; Clan Castle Settings
	GUICtrlCreateGroup("Ranked Clan Castle", $x, $y, 190, 130)
		$y += 20
		
		$g_hChkRankedUseCCTroops = GUICtrlCreateCheckbox("Use CC Troops", $x + 10, $y, 100, 17)
		GUICtrlSetOnEvent(-1, "chkRankedCC")
		
		$y += 20
		$g_hChkRankedUseCCSpells = GUICtrlCreateCheckbox("Use CC Spells", $x + 10, $y, 100, 17)
		GUICtrlSetOnEvent(-1, "chkRankedCC")
		
		$y += 20
		$g_hChkRankedUseCCSiege = GUICtrlCreateCheckbox("Use CC Siege Machine", $x + 10, $y, 140, 17)
		GUICtrlSetOnEvent(-1, "chkRankedCC")
		
		$y += 25
		$g_hChkRankedDropCCFirst = GUICtrlCreateCheckbox("Drop CC First", $x + 10, $y, 100, 17)
		GUICtrlSetOnEvent(-1, "chkRankedCC")
		_GUICtrlSetTip(-1, "Deploy Clan Castle troops before regular troops")
		
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	
	$x = 10
	$y = 230
	
	; Spell Deployment Settings
	GUICtrlCreateGroup("Ranked Spell Deployment", $x, $y, 410, 120)
		$y += 20
		
		GUICtrlCreateLabel("Spells to use in Ranked attacks:", $x + 10, $y, 180, 17)
		$y += 20
		
		Local $xStart = $x + 10
		$x = $xStart
		
		; Create checkboxes for each spell type (showing first 10)
		For $i = 0 To 9
			If $i = 5 Then
				$x = $xStart
				$y += 25
			EndIf
			
			$g_ahChkRankedSpells[$i] = GUICtrlCreateCheckbox($g_asSpellShortNames[$i], $x, $y, 70, 17)
			GUICtrlSetOnEvent(-1, "chkRankedSpell")
			GUICtrlSetState(-1, $GUI_CHECKED) ; Default to checked
			
			$x += 75
		Next
		
	GUICtrlCreateGroup("", -99, -99, 1, 1)
EndFunc   ;==>CreateRankedAttackSettings

; Event Handler Functions (stubs - implement actual logic as needed)
Func chkRankedEnabled()
	If GUICtrlRead($g_hChkRankedEnabled) = $GUI_CHECKED Then
		$g_bRankedModeEnabled = True
		SetLog("Ranked Attack Mode Enabled", $COLOR_SUCCESS)
	Else
		$g_bRankedModeEnabled = False
		SetLog("Ranked Attack Mode Disabled", $COLOR_WARNING)
	EndIf
	SaveRankedConfig()
EndFunc

Func btnRankedResetDaily()
	$g_iRankedAttacksToday = 0
	GUICtrlSetData($g_hLblRankedAttacksLeft, "0 / 8")
	SetLog("Daily ranked attack counter reset", $COLOR_SUCCESS)
	SaveRankedConfig()
EndFunc

Func btnRankedSaveConfig()
	SaveRankedConfig()
	SetLog("Ranked configuration saved", $COLOR_SUCCESS)
EndFunc

Func btnRankedTestAttack()
	SetLog("Testing ranked attack...", $COLOR_INFO)
	; Implement test attack logic
EndFunc

Func txtRankedTroopCount()
	; Update ranked army composition
	For $i = 0 To $eTroopCount - 1
		If @GUI_CtrlId = $g_ahTxtRankedTrainArmyTroopCount[$i] Then
			$g_aiRankedArmyComp[$i] = GUICtrlRead($g_ahTxtRankedTrainArmyTroopCount[$i])
			ExitLoop
		EndIf
	Next
EndFunc

Func txtRankedSpellCount()
	; Update ranked spell composition
	For $i = 0 To $eSpellCount - 1
		If @GUI_CtrlId = $g_ahTxtRankedTrainArmySpellCount[$i] Then
			$g_aiRankedSpellComp[$i] = GUICtrlRead($g_ahTxtRankedTrainArmySpellCount[$i])
			ExitLoop
		EndIf
	Next
EndFunc

Func chkRankedHero()
	; Update hero deployment settings
	$g_bRankedUseKing = (GUICtrlRead($g_hChkRankedDeployKing) = $GUI_CHECKED)
	$g_bRankedUseQueen = (GUICtrlRead($g_hChkRankedDeployQueen) = $GUI_CHECKED)
	$g_bRankedUsePrince = (GUICtrlRead($g_hChkRankedDeployPrince) = $GUI_CHECKED)
	$g_bRankedUseWarden = (GUICtrlRead($g_hChkRankedDeployWarden) = $GUI_CHECKED)
	$g_bRankedUseChampion = (GUICtrlRead($g_hChkRankedDeployChampion) = $GUI_CHECKED)
EndFunc

; Additional event handlers would go here...