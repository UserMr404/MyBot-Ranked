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
#include <File.au3>
#include <ComboConstants.au3>

Global $g_hGUI_RANKED = 0
Global $g_hGUI_RANKED_TAB = 0, $g_hGUI_RANKED_TAB_ITEM1 = 0, $g_hGUI_RANKED_TAB_ITEM2 = 0, $g_hGUI_RANKED_TAB_ITEM3 = 0, $g_hGUI_RANKED_TAB_ITEM4 = 0

; Sub GUI windows
Global $g_hGUI_RANKED_ARMY = 0, $g_hGUI_RANKED_ATTACK = 0, $g_hGUI_RANKED_STATUS = 0, $g_hGUI_RANKED_OPTIONS = 0

; Train Type sub-tab
Global $g_hGUI_RANKED_TRAINTYPE = 0
Global $g_hGUI_RANKED_TRAINTYPE_TAB = 0, $g_hGUI_RANKED_TRAINTYPE_TAB_ITEM1 = 0, $g_hGUI_RANKED_TRAINTYPE_TAB_ITEM2 = 0

; Ranked Status Controls  
Global $g_hChkRankedEnabled = 0, $g_hLblRankedAttacksLeft = 0, $g_hLblRankedResetTime = 0, $g_hTxtRankedAttacksRemaining = 0
Global $g_hGrpRankedStatus = 0

; Ranked Army Controls - Custom Train
Global $g_hRadRankedCustomTrain = 0, $g_hRadRankedQuickTrain = 0
Global $g_ahTxtRankedTrainArmyTroopCount[$eTroopCount] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
Global $g_ahTxtRankedTrainArmySpellCount[$eSpellCount] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
Global $g_ahTxtRankedTrainArmySiegeCount[$eSiegeMachineCount] = [0, 0, 0, 0, 0, 0, 0, 0]
Global $g_ahPicRankedTrainArmyTroop[$eTroopCount] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
Global $g_ahPicRankedTrainArmySpell[$eSpellCount] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
Global $g_ahPicRankedTrainArmySiege[$eSiegeMachineCount] = [0, 0, 0, 0, 0, 0, 0, 0]
Global $g_hTxtRankedFullTroop = 0, $g_hChkRankedTotalCampForced = 0, $g_hTxtRankedTotalCampForced = 0
Global $g_hChkRankedDoubleTrain = 0, $g_hChkRankedPreciseArmy = 0
Global $g_hLblRankedTotalTimeCamp = 0, $g_hLblRankedElixirCostCamp = 0, $g_hLblRankedDarkCostCamp = 0
Global $g_hBtnRankedElixirTroops = 0, $g_hBtnRankedDarkElixirTroops = 0, $g_hBtnRankedSuperTroops = 0, $g_hBtnRankedSpells = 0, $g_hBtnRankedSieges = 0
Global $g_hCalRankedTotalTroops = 0, $g_hLblRankedCountTotal = 0
Global $g_hCalRankedTotalSpells = 0, $g_hLblRankedCountTotalSpells = 0

; Ranked Army Controls - Quick Train
Global $g_ahChkRankedUseInGameArmy[3], $g_ahPicRankedTotalQTroop[3], $g_ahPicRankedTotalQSpell[3]
Global $g_ahLblRankedTotalQTroop[3], $g_ahLblRankedTotalQSpell[3]
Global $g_ahBtnRankedEditArmy[3], $g_ahLblRankedEditArmy[3]
Global $g_ahPicRankedQuickTroop[3][22], $g_ahLblRankedQuickTroop[3][22]
Global $g_ahPicRankedQuickSpell[3][11], $g_ahLblRankedQuickSpell[3][11]
Global $g_ahLblRankedQuickTrainNote[3], $g_ahLblRankedUseInGameArmyNote[3]
Global $g_ahChkRankedArmy[3] = [0, 0, 0]

; Ranked Attack Controls
Global $g_hCmbRankedAlgorithm = 0, $g_hCmbRankedSelectTroop = 0
Global $g_hChkRankedKingAttack = 0, $g_hChkRankedQueenAttack = 0, $g_hChkRankedPrinceAttack = 0
Global $g_hChkRankedWardenAttack = 0, $g_hChkRankedChampionAttack = 0
Global $g_hPicRankedKingAttack = 0, $g_hPicRankedQueenAttack = 0, $g_hPicRankedPrinceAttack = 0
Global $g_hPicRankedWardenAttack = 0, $g_hPicRankedChampionAttack = 0
Global $g_hCmbRankedWardenMode = 0, $g_hCmbRankedSiege = 0
Global $g_hChkRankedDropCC = 0, $g_hPicRankedDropCC = 0
Global $g_hChkRankedLightSpell = 0, $g_hChkRankedHealSpell = 0, $g_hChkRankedRageSpell = 0
Global $g_hChkRankedJumpSpell = 0, $g_hChkRankedFreezeSpell = 0, $g_hChkRankedCloneSpell = 0
Global $g_hChkRankedInvisibilitySpell = 0, $g_hChkRankedRecallSpell = 0, $g_hChkRankedReviveSpell = 0
Global $g_hChkRankedPoisonSpell = 0, $g_hChkRankedEarthquakeSpell = 0, $g_hChkRankedHasteSpell = 0
Global $g_hChkRankedSkeletonSpell = 0, $g_hChkRankedBatSpell = 0, $g_hChkRankedOvergrowthSpell = 0
Global $g_hPicRankedLightSpell = 0, $g_hPicRankedHealSpell = 0, $g_hPicRankedRageSpell = 0
Global $g_hPicRankedJumpSpell = 0, $g_hPicRankedFreezeSpell = 0, $g_hPicRankedCloneSpell = 0
Global $g_hPicRankedInvisibilitySpell = 0, $g_hPicRankedRecallSpell = 0, $g_hPicRankedReviveSpell = 0
Global $g_hPicRankedPoisonSpell = 0, $g_hPicRankedEarthquakeSpell = 0, $g_hPicRankedHasteSpell = 0
Global $g_hPicRankedSkeletonSpell = 0, $g_hPicRankedBatSpell = 0, $g_hPicRankedOvergrowthSpell = 0

; Scripted attack controls
Global $g_hGrpRankedScriptedAttack = 0, $g_hLblRankedScriptName = 0, $g_hCmbRankedScriptName = 0
Global $g_hBtnRankedEditScript = 0, $g_hBtnRankedNewScript = 0, $g_hBtnRankedDuplicateScript = 0
Global $g_hBtnRankedDeleteScript = 0, $g_hLblRankedScriptInfo = 0
Global $g_sRankedScriptName = ""

; Standard attack controls
Global $g_hGrpRankedStandardAttack = 0, $g_hLblRankedStandardSettings = 0
Global $g_hChkRankedSmartAttackRedArea = 0, $g_hChkRankedSmartAttackGoldMines = 0
Global $g_hChkRankedSmartAttackElixirCollectors = 0, $g_hChkRankedSmartAttackDEDrills = 0
Global $g_hBtnRankedApplySettings = 0
Global $g_hLblRankedAttacksToday = 0

Func CreateAttackRanked()
	; Create main GUI container
	$g_hGUI_RANKED = _GUICreate("", $g_iSizeWGrpTab2, $g_iSizeHGrpTab2, 5, 25, BitOR($WS_CHILD, $WS_TABSTOP), -1, $g_hGUI_ATTACK)
	
	; Create sub-GUIs first
	CreateRankedStatus()
	CreateRankedArmy()
	CreateRankedAttackSettings()
	CreateRankedOptions()
	
	GUISwitch($g_hGUI_RANKED)
	
	; Create main tab control
	$g_hGUI_RANKED_TAB = GUICtrlCreateTab(0, 0, $g_iSizeWGrpTab2, $g_iSizeHGrpTab2, BitOR($TCS_MULTILINE, $TCS_RIGHTJUSTIFY))
	GUICtrlSetOnEvent(-1, "tabRanked")
	
	$g_hGUI_RANKED_TAB_ITEM1 = GUICtrlCreateTabItem(GetTranslatedFileIni("MBR Main GUI", "Tab_03_STab_03_STab_01", "Status"))
	$g_hGUI_RANKED_TAB_ITEM2 = GUICtrlCreateTabItem(GetTranslatedFileIni("MBR Main GUI", "Tab_03_STab_03_STab_02", "Train Army"))
	$g_hGUI_RANKED_TAB_ITEM3 = GUICtrlCreateTabItem(GetTranslatedFileIni("MBR Main GUI", "Tab_03_STab_03_STab_03", "Attack Settings"))
	$g_hGUI_RANKED_TAB_ITEM4 = GUICtrlCreateTabItem(GetTranslatedFileIni("MBR Main GUI", "Tab_03_STab_03_STab_04", "Options"))
	
	GUICtrlCreateTabItem("")
	
	GUISetState(@SW_HIDE, $g_hGUI_RANKED)
EndFunc

Func CreateRankedStatus()
	$g_hGUI_RANKED_STATUS = _GUICreate("", $g_iSizeWGrpTab3, $g_iSizeHGrpTab3, 5, 25, BitOR($WS_CHILD, $WS_TABSTOP), -1, $g_hGUI_RANKED)
	
	Local $x = 10, $y = 10
	
	; Enable/Disable Ranked Mode
	$g_hChkRankedEnabled = GUICtrlCreateCheckbox("Enable Ranked Attack Mode", $x, $y, 200, 17)
		GUICtrlSetState(-1, $g_bRankedModeEnabled ? $GUI_CHECKED : $GUI_UNCHECKED)
		GUICtrlSetOnEvent(-1, "chkRankedEnabled")
		_GUICtrlSetTip(-1, "Enable/Disable the ranked attack system entirely")
		GUICtrlSetFont(-1, 9, 600)
	
	$y += 30
	
	; Status Group
	$g_hGrpRankedStatus = GUICtrlCreateGroup("Ranked Attack Status", $x, $y, 430, 100)
		GUICtrlCreateLabel("Attacks Remaining:", $x + 15, $y + 25, 120, 20)
			GUICtrlSetFont(-1, 10, 600)
		$g_hTxtRankedAttacksRemaining = GUICtrlCreateInput("6", $x + 140, $y + 23, 30, 22, BitOR($ES_CENTER, $ES_NUMBER))
			GUICtrlSetLimit(-1, 1)
			GUICtrlSetOnEvent(-1, "txtRankedAttacksRemaining")
			_GUICtrlSetTip(-1, "Set number of ranked attacks remaining (0-6)")
		GUICtrlCreateLabel("/6", $x + 175, $y + 25, 20, 20)
			GUICtrlSetFont(-1, 10, 600)
			GUICtrlSetColor(-1, $COLOR_GREEN)
		GUICtrlCreateLabel("Attacks today:", $x + 220, $y + 25, 90, 20)
			GUICtrlSetFont(-1, 10, 600)
		Global $g_hLblRankedAttacksToday = GUICtrlCreateLabel($g_iRankedAttacksToday, $x + 315, $y + 25, 30, 20)
			GUICtrlSetFont(-1, 10, 600)
			GUICtrlSetColor(-1, $COLOR_BLUE)
		$g_hLblRankedResetTime = GUICtrlCreateLabel("Next reset: Today at 7:00 AM", $x + 15, $y + 50, 400, 17)
			GUICtrlSetFont(-1, 8)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	
	$y += 120
	
	; Information
	GUICtrlCreateLabel("Ranked Mode Information:", $x, $y, 200, 20)
		GUICtrlSetFont(-1, 9, 600)
	$y += 20
	GUICtrlCreateLabel("• Maximum 6 attacks per day", $x + 10, $y, 400, 17)
	$y += 18
	GUICtrlCreateLabel("• Daily reset at 7:00 AM", $x + 10, $y, 400, 17)
	$y += 18
	GUICtrlCreateLabel("• No searching - must attack first base found", $x + 10, $y, 400, 17)
	$y += 18
	GUICtrlCreateLabel("• Separate army and attack configurations", $x + 10, $y, 400, 17)
EndFunc

Func CreateRankedArmy()
	$g_hGUI_RANKED_ARMY = _GUICreate("", $g_iSizeWGrpTab3, $g_iSizeHGrpTab3, 5, 25, BitOR($WS_CHILD, $WS_TABSTOP), -1, $g_hGUI_RANKED)
	GUISetBkColor($COLOR_WHITE, $g_hGUI_RANKED_ARMY)
	
	; Top controls - same as normal train army
	Local $x = 12
	Local $y = 5
	
	_GUICtrlCreateIcon($g_sLibIconPath, $eIcnResetButton, $x - 12, $y - 2, 24, 24)
	GUICtrlSetOnEvent(-1, "RemoveRankedCamp")
	
	$g_hChkRankedTotalCampForced = GUICtrlCreateCheckbox(GetTranslatedFileIni("MBR GUI Design Child Attack - Troops", "ChkTotalCampForced", "Force Army Camp") & ":", $x + 25, $y, -1, -1)
	GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlSetOnEvent(-1, "chkRankedTotalCampForced")
	_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Attack - Troops", "ChkTotalCampForced_Info_01", "If not detected set army camp values (instead ask)"))
	$g_hTxtRankedTotalCampForced = GUICtrlCreateInput("280", $x + 134, $y + 3, 30, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetOnEvent(-1, "SetRankedComboTroopComp")
	GUICtrlSetLimit(-1, 3)
	
	GUICtrlCreateLabel(GetTranslatedFileIni("MBR GUI Design Child Attack - Troops", "LblFullTroop", "'Full' Camp") & " " & ChrW(8805), $x + 170, $y + 5, 70, 17, $SS_RIGHT)
	$g_hTxtRankedFullTroop = GUICtrlCreateInput("100", $x + 242, $y + 3, 30, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetOnEvent(-1, "SetRankedComboTroopComp")
	_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Attack - Troops", "TxtFullTroop_Info_01", "Army camps are 'Full' when reaching this %, then start attack."))
	GUICtrlSetLimit(-1, 3)
	GUICtrlCreateLabel("%", $x + 273, $y + 5, -1, 17)
	
	GUICtrlCreateLabel(GetTranslatedFileIni("MBR GUI Design Child Attack - Troops", "SpellCapacity", "Spell Capacity") & ":", $x + 288, $y + 5, 90, 17, $SS_RIGHT)
	$g_hTxtRankedTotalCountSpell = GUICtrlCreateCombo("", $x + 380, $y + 1, 35, 16, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Attack - Troops", "TxtTotalCountSpell_Info_01", "Enter the No. of Spells Capacity."))
	GUICtrlSetData(-1, "0|2|4|6|7|8|9|10|11", "11")
	
	; Create Train Type sub-tab
	$g_hGUI_RANKED_TRAINTYPE_TAB = GUICtrlCreateTab(0, 30, $g_iSizeWGrpTab3, $g_iSizeHGrpTab3 - 30, BitOR($TCS_FORCELABELLEFT, $TCS_FIXEDWIDTH))
	_GUICtrlTab_SetItemSize($g_hGUI_RANKED_TRAINTYPE_TAB, 90, 20)
	GUICtrlSetOnEvent(-1, "tabRankedTrainType")
	
	$g_hGUI_RANKED_TRAINTYPE_TAB_ITEM1 = GUICtrlCreateTabItem(GetTranslatedFileIni("MBR Main GUI", "Tab_03_STab_01_STab_01_STab_01", "Custom Train"))
	CreateRankedCustomTrain()
	
	$g_hGUI_RANKED_TRAINTYPE_TAB_ITEM2 = GUICtrlCreateTabItem(GetTranslatedFileIni("MBR Main GUI", "Tab_03_STab_01_STab_01_STab_02", "Quick Train"))
	CreateRankedQuickTrain()
	
	GUICtrlCreateTabItem("")
	
	GUISetState(@SW_HIDE, $g_hGUI_RANKED_ARMY)
EndFunc

Func CreateRankedCustomTrain()
	Local $iStartX = 4, $iStartY = 200
	Local $x = $iStartX, $y = 75
	
	; Train Troops Group - display area at top
	GUICtrlCreateGroup(GetTranslatedFileIni("MBR GUI Design Child Attack - Troops", "TrainTroops", "Train Troops"), $x, $y - 15, $g_iSizeWGrpTab3 - 150, 85)
	Local $x1 = 39, $xx = 10
	For $i = 0 To UBound($g_ahPicRankedTrainArmyTroopTmp) - 1
		$g_ahPicRankedTrainArmyTroopTmp[$i] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnBarbarian, $xx + ($x1 * $i), $y, 38, 38)
		$g_ahLblRankedTrainArmyTroopTmp[$i] = GUICtrlCreateLabel("0", $xx + ($x1 * $i) + 1, $y + 37, 40, 12, $SS_CENTER)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $COLOR_BLUE)
		GUICtrlSetFont(-1, 9, 900)
	Next
	$g_hCalRankedTotalTroops = GUICtrlCreateProgress($x + 5, $y + 53, 235, 10)
	$g_hLblRankedCountTotal = GUICtrlCreateLabel(0, $x + 245, $y + 51, 35, 15, $SS_CENTER)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	
	; Train Sieges Group
	GUICtrlCreateGroup(GetTranslatedFileIni("MBR GUI Design Child Attack - Troops", "TrainSieges", "Train Sieges"), $g_iSizeWGrpTab3 - 140, $y - 15, 130, 75)
	Local $x1 = 39, $xx = $g_iSizeWGrpTab3 - 133
	For $i = 0 To UBound($g_ahPicRankedTrainArmySiegeTmp) - 1
		$g_ahPicRankedTrainArmySiegeTmp[$i] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnWallW, $xx + ($x1 * $i), $y, 38, 38)
		$g_ahLblRankedTrainArmySiegeTmp[$i] = GUICtrlCreateLabel("0", $xx + ($x1 * $i) + 1, $y + 37, 40, 12, $SS_CENTER)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $COLOR_BLUE)
		GUICtrlSetFont(-1, 9, 900)
	Next
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	
	; Train Spells Group
	$y += 98
	GUICtrlCreateGroup(GetTranslatedFileIni("MBR GUI Design Child Attack - Troops", "TrainSpells", "Train Spells"), $x, $y - 15, $g_iSizeWGrpTab3 - 150, 85)
	Local $x1 = 39, $xx = 10
	For $i = 0 To UBound($g_ahPicRankedTrainArmySpellTmp) - 1
		$g_ahPicRankedTrainArmySpellTmp[$i] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnPoisonSpell, $xx + ($x1 * $i), $y, 38, 38)
		$g_ahLblRankedTrainArmySpellTmp[$i] = GUICtrlCreateLabel("0", $xx + ($x1 * $i) + 1, $y + 37, 40, 12, $SS_CENTER)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $COLOR_BLUE)
		GUICtrlSetFont(-1, 9, 900)
	Next
	$g_hCalRankedTotalSpells = GUICtrlCreateProgress($x + 5, $y + 53, 235, 10)
	$g_hLblRankedCountTotalSpells = GUICtrlCreateLabel(0, $x + 245, $y + 51, 35, 15, $SS_CENTER)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	
	; Selection buttons on the right
	$x = $iStartX + 290
	$y -= 35
	$g_hBtnRankedElixirTroops = GUICtrlCreateButton("Elixir Troops", $x, $y, 130, 21)
	GUICtrlSetOnEvent(-1, "BtnRankedElixirTroops")
	$y += 22
	$g_hBtnRankedDarkElixirTroops = GUICtrlCreateButton("Dark Elixir Troops", $x, $y, 130, 21)
	GUICtrlSetOnEvent(-1, "BtnRankedDarkElixirTroops")
	$y += 22
	$g_hBtnRankedSuperTroops = GUICtrlCreateButton("Super Troops", $x, $y, 130, 21)
	GUICtrlSetOnEvent(-1, "BtnRankedSuperTroops")
	$y += 22
	$g_hBtnRankedSpells = GUICtrlCreateButton("Spells", $x, $y, 130, 21)
	GUICtrlSetOnEvent(-1, "BtnRankedSpells")
	$y += 22
	$g_hBtnRankedSieges = GUICtrlCreateButton("Sieges", $x, $y, 130, 21)
	GUICtrlSetOnEvent(-1, "BtnRankedSieges")
	
	; Input controls at bottom - Create all troops at exact positions like normal mode
	$iStartY += 55
	Local $xsplit = 42, $ysplit = 60
	$x = $iStartX
	$y = $iStartY
	Local $sTxtSetPerc = GetTranslatedFileIni("MBR GUI Design Child Attack - Troops", "TxtSetTroop_Info_01", "Enter the No. of")
	Local $sTxtSetPerc2 = GetTranslatedFileIni("MBR GUI Design Child Attack - Troops", "TxtSetTroop_Info_02", "to make.")
	
	; ELIXIR TROOPS - First Row
	; Barbarians
	$g_ahPicRankedTrainArmyTroop[$eTroopBarbarian] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnBarbarian, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopBarbarian] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 3)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Archers
	$g_ahPicRankedTrainArmyTroop[$eTroopArcher] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnArcher, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopArcher] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 3)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Giants
	$g_ahPicRankedTrainArmyTroop[$eTroopGiant] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnGiant, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopGiant] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Goblins
	$g_ahPicRankedTrainArmyTroop[$eTroopGoblin] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnGoblin, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopGoblin] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 3)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; WallBreakers
	$g_ahPicRankedTrainArmyTroop[$eTroopWallBreaker] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnWallBreaker, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopWallBreaker] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 3)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Balloons
	$g_ahPicRankedTrainArmyTroop[$eTroopBalloon] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnBalloon, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopBalloon] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Wizards
	$g_ahPicRankedTrainArmyTroop[$eTroopWizard] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnWizard, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopWizard] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Healers
	$g_ahPicRankedTrainArmyTroop[$eTroopHealer] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnHealer, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopHealer] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Dragons
	$g_ahPicRankedTrainArmyTroop[$eTroopDragon] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnDragon, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopDragon] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Pekkas
	$g_ahPicRankedTrainArmyTroop[$eTroopPekka] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnPekka, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopPekka] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	; ELIXIR TROOPS - Second Row
	$x = $iStartX
	$y += $ysplit
	
	; Baby Dragons
	$g_ahPicRankedTrainArmyTroop[$eTroopBabyDragon] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnBabyDragon, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopBabyDragon] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Miners
	$g_ahPicRankedTrainArmyTroop[$eTroopMiner] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnMiner, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopMiner] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Electro Dragon
	$g_ahPicRankedTrainArmyTroop[$eTroopElectroDragon] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnElectroDragon, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopElectroDragon] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Yeti
	$g_ahPicRankedTrainArmyTroop[$eTroopYeti] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnYeti, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopYeti] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Dragon Rider
	$g_ahPicRankedTrainArmyTroop[$eTroopDragonRider] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnDragonRider, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopDragonRider] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Electro Titan
	$g_ahPicRankedTrainArmyTroop[$eTroopElectroTitan] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnElectroTitan, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopElectroTitan] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Root Rider
	$g_ahPicRankedTrainArmyTroop[$eTroopRootRider] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnRootRider, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopRootRider] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Thrower
	$g_ahPicRankedTrainArmyTroop[$eTroopThrower] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnThrower, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopThrower] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Inferno Dragon
	$g_ahPicRankedTrainArmyTroop[$eTroopInfernoDragon] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnInfernoDragon, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopInfernoDragon] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	; DARK TROOPS
	$x = $iStartX
	$y = $iStartY
	; Minions
	$g_ahPicRankedTrainArmyTroop[$eTroopMinion] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnMinion, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopMinion] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 3)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Hog Riders
	$g_ahPicRankedTrainArmyTroop[$eTroopHogRider] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnHogRider, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopHogRider] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Valkyries
	$g_ahPicRankedTrainArmyTroop[$eTroopValkyrie] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnValkyrie, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopValkyrie] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Golems
	$g_ahPicRankedTrainArmyTroop[$eTroopGolem] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnGolem, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopGolem] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Witches
	$g_ahPicRankedTrainArmyTroop[$eTroopWitch] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnWitch, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopWitch] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Lava Hounds
	$g_ahPicRankedTrainArmyTroop[$eTroopLavaHound] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnLavaHound, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopLavaHound] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Bowlers
	$g_ahPicRankedTrainArmyTroop[$eTroopBowler] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnBowler, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopBowler] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Ice Golems
	$g_ahPicRankedTrainArmyTroop[$eTroopIceGolem] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnIceGolem, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopIceGolem] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Headhunters
	$g_ahPicRankedTrainArmyTroop[$eTroopHeadhunter] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnHeadhunter, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopHeadhunter] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Apprentice Warden
	$g_ahPicRankedTrainArmyTroop[$eTroopAppWard] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnAppWard, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopAppWard] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	; Dark Troops - Second Row
	$x = $iStartX
	$y += $ysplit
	; Druid
	$g_ahPicRankedTrainArmyTroop[$eTroopDruid] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnDruid, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopDruid] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Furnace
	$g_ahPicRankedTrainArmyTroop[$eTroopFurnace] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnFurnace, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopFurnace] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	; SUPER TROOPS - Create at fixed positions like normal mode
	$x = $iStartX
	$y = $iStartY
	
	; Super Barbarians
	$g_ahPicRankedTrainArmyTroop[$eTroopSuperBarbarian] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnSuperBarbarian, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopSuperBarbarian] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 3)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Super Archers
	$g_ahPicRankedTrainArmyTroop[$eTroopSuperArcher] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnSuperArcher, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopSuperArcher] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 3)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Sneaky Goblins
	$g_ahPicRankedTrainArmyTroop[$eTroopSneakyGoblin] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnSneakyGoblin, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopSneakyGoblin] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 3)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Super Wall Breakers
	$g_ahPicRankedTrainArmyTroop[$eTroopSuperWallBreaker] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnSuperWallBreaker, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopSuperWallBreaker] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 3)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Super Giants
	$g_ahPicRankedTrainArmyTroop[$eTroopSuperGiant] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnSuperGiant, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopSuperGiant] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Rocket Balloons
	$g_ahPicRankedTrainArmyTroop[$eTroopRocketBalloon] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnRocketBalloon, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopRocketBalloon] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Super Wizards
	$g_ahPicRankedTrainArmyTroop[$eTroopSuperWizard] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnSuperWizard, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopSuperWizard] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Super Dragons
	$g_ahPicRankedTrainArmyTroop[$eTroopSuperDragon] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnSuperDragon, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopSuperDragon] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Super Miners
	$g_ahPicRankedTrainArmyTroop[$eTroopSuperMiner] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnSuperMiner, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopSuperMiner] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Super Minions
	$g_ahPicRankedTrainArmyTroop[$eTroopSuperMinion] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnSuperMinion, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopSuperMinion] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 3)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	; Super Troops - Second Row
	$x = $iStartX
	$y += $ysplit
	
	; Super Valkyries
	$g_ahPicRankedTrainArmyTroop[$eTroopSuperValkyrie] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnSuperValkyrie, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopSuperValkyrie] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Super Witches
	$g_ahPicRankedTrainArmyTroop[$eTroopSuperWitch] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnSuperWitch, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopSuperWitch] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Ice Hounds
	$g_ahPicRankedTrainArmyTroop[$eTroopIceHound] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnIceHound, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopIceHound] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Super Bowlers
	$g_ahPicRankedTrainArmyTroop[$eTroopSuperBowler] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnSuperBowler, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopSuperBowler] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	$x += $xsplit
	; Super Hog Riders
	$g_ahPicRankedTrainArmyTroop[$eTroopSuperHogRider] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnSuperHogRider, $x + 3, $y, 36, 36)
	$g_ahTxtRankedTrainArmyTroopCount[$eTroopSuperHogRider] = GUICtrlCreateInput("0", $x + 1, $y + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "TrainRankedTroopCountEdit")
	
	; Hide all controls initially
	For $i = 0 To $eTroopCount - 1
		GUICtrlSetState($g_ahPicRankedTrainArmyTroop[$i], $GUI_HIDE)
		GUICtrlSetState($g_ahTxtRankedTrainArmyTroopCount[$i], $GUI_HIDE)
	Next
	
	; SPELLS - Create at fixed positions
	$x = $iStartX
	$y = $iStartY
	
	For $i = 0 To $eSpellCount - 1
		Local $col = Mod($i, 10)  ; 10 spells per row
		Local $row = Int($i / 10)  ; Calculate row
		$g_ahPicRankedTrainArmySpell[$i] = _GUICtrlCreateIcon($g_sLibIconPath, $g_aQuickSpellIcon[$i], $x + ($col * $xsplit) + 3, $y + ($row * $ysplit), 36, 36)
		GUICtrlSetState(-1, $GUI_HIDE)
		$g_ahTxtRankedTrainArmySpellCount[$i] = GUICtrlCreateInput("0", $x + ($col * $xsplit) + 1, $y + ($row * $ysplit) + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
		GUICtrlSetState(-1, $GUI_HIDE)
		GUICtrlSetLimit(-1, 2)
		GUICtrlSetOnEvent(-1, "TrainRankedSpellCountEdit")
	Next
	
	; SIEGE MACHINES - Create at fixed positions
	$x = $iStartX
	$y = $iStartY
	
	For $i = 0 To $eSiegeMachineCount - 1
		Local $eSiegeIcon = $eIcnWallW
		Switch $i
			Case $eSiegeWallWrecker
				$eSiegeIcon = $eIcnWallW
			Case $eSiegeBattleBlimp
				$eSiegeIcon = $eIcnBattleB
			Case $eSiegeStoneSlammer
				$eSiegeIcon = $eIcnStoneS
			Case $eSiegeBarracks
				$eSiegeIcon = $eIcnSiegeB
			Case $eSiegeLogLauncher
				$eSiegeIcon = $eIcnLogL
			Case $eSiegeFlameFlinger
				$eSiegeIcon = $eIcnFlameF
			Case $eSiegeBattleDrill
				$eSiegeIcon = $eIcnBattleD
			Case $eSiegeTroopLauncher
				$eSiegeIcon = $eIcnTroopL
		EndSwitch
		Local $col = Mod($i, 8)  ; 8 sieges per row
		Local $row = Int($i / 8)  ; Calculate row
		$g_ahPicRankedTrainArmySiege[$i] = _GUICtrlCreateIcon($g_sLibIconPath, $eSiegeIcon, $x + ($col * $xsplit) + 3, $y + ($row * $ysplit), 36, 36)
		GUICtrlSetState(-1, $GUI_HIDE)
		$g_ahTxtRankedTrainArmySiegeCount[$i] = GUICtrlCreateInput("0", $x + ($col * $xsplit) + 1, $y + ($row * $ysplit) + 39, 40, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
		GUICtrlSetState(-1, $GUI_HIDE)
		GUICtrlSetLimit(-1, 2)
		GUICtrlSetOnEvent(-1, "TrainRankedSiegeCountEdit")
	Next
	
	; Now show default elixir troops in their positions
	BtnRankedElixirTroops()
EndFunc

Func CreateRankedQuickTrain()
	Local $x = 12, $y = 50, $del_y = 108
	
	For $i = 0 To 2
		GUICtrlCreateGroup("", $x - 2, $y, 412, $del_y)
		$g_ahChkRankedArmy[$i] = GUICtrlCreateCheckbox(GetTranslatedFileIni("MBR GUI Design Child Attack - Troops", "ChkArmy", "Army ") & $i + 1, $x + 10, $y + 20, 70, 15)
		If $i = 0 Then GUICtrlSetState(-1, $GUI_CHECKED)
		GUICtrlSetOnEvent(-1, "chkRankedQuickArmy" & ($i + 1))
		
		$g_ahChkRankedUseInGameArmy[$i] = GUICtrlCreateCheckbox(GetTranslatedFileIni("MBR GUI Design Child Attack - Troops", "ChkUseInGameArmy", "In-Game Army"), $x + 10, $y + 45, -1, 15)
		GUICtrlSetState(-1, $GUI_CHECKED)
		GUICtrlSetOnEvent(-1, "chkRankedUseInGameArmy" & ($i + 1))
		GUICtrlSetTip(-1, "Uncheck and create preset army here, MBR will apply this preset to in-game quick train setting")
		
		$g_ahBtnRankedEditArmy[$i] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnTrain, $x + 10, $y + 70, 22, 22)
		GUICtrlSetOnEvent(-1, "btnRankedEditQuickArmy" & ($i + 1))
		$g_ahLblRankedEditArmy[$i] = GUICtrlCreateLabel(" " & GetTranslatedFileIni("MBR GUI Design Child Attack - Troops", "Btn_Edit_Army", "Edit Army"), $x + 35, $y + 75, 50, 15, $SS_LEFT)
		
		$g_ahLblRankedTotalQTroop[$i] = GUICtrlCreateLabel(0, $x + 360, $y + 25, 40, 15, $SS_RIGHT)
		GUICtrlSetBkColor(-1, $COLOR_GRAY)
		GUICtrlSetColor(-1, $COLOR_WHITE)
		GUICtrlSetFont(-1, 9, $FW_BOLD, Default, "Arial", $CLEARTYPE_QUALITY)
		$g_ahPicRankedTotalQTroop[$i] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnTroopsCost, $x + 353, $y + 20, 24, 24)
		
		$g_ahLblRankedTotalQSpell[$i] = GUICtrlCreateLabel(0, $x + 360, $y + 70, 40, 15, $SS_RIGHT)
		GUICtrlSetBkColor(-1, $COLOR_GRAY)
		GUICtrlSetColor(-1, $COLOR_WHITE)
		GUICtrlSetFont(-1, 9, $FW_BOLD, Default, "Arial", $CLEARTYPE_QUALITY)
		$g_ahPicRankedTotalQSpell[$i] = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnSpellsCost, $x + 350, $y + 65, 24, 24)
		
		$g_ahLblRankedQuickTrainNote[$i] = GUICtrlCreateLabel(GetTranslatedFileIni("MBR GUI Design Child Attack - Troops", "LblQuickTrainNote", "Use button 'Edit Army' to create troops and spells in quick Army") & $i + 1, $x + 120, $y + 30, 200, 70, $SS_CENTER)
		GUICtrlSetFont(-1, 12, $FW_BOLD, Default, "Arial", $CLEARTYPE_QUALITY)
		GUICtrlSetColor(-1, $COLOR_SKYBLUE)
		$g_ahLblRankedUseInGameArmyNote[$i] = GUICtrlCreateLabel(GetTranslatedFileIni("MBR GUI Design Child Attack - Troops", "LblUseInGameArmyNote", "Quick train using in-game troops and spells preset Army") & $i + 1, $x + 120, $y + 30, 270, 70, $SS_CENTER)
		GUICtrlSetFont(-1, 12, $FW_BOLD, Default, "Arial", $CLEARTYPE_QUALITY)
		GUICtrlSetColor(-1, $COLOR_SKYBLUE)
		
		For $j = 0 To 6
			$g_ahPicRankedQuickTroop[$i][$j] = _GUICtrlCreateIcon($g_sLibIconPath, $eEmpty3, $x + 100 + $j * 36, $y + 10, 32, 32)
			$g_ahLblRankedQuickTroop[$i][$j] = GUICtrlCreateLabel("", $x + 101 + $j * 36, $y + 42, 30, 11, $ES_CENTER)
			$g_ahPicRankedQuickSpell[$i][$j] = _GUICtrlCreateIcon($g_sLibIconPath, $eEmpty3, $x + 100 + $j * 36, $y + 58, 32, 32)
			$g_ahLblRankedQuickSpell[$i][$j] = GUICtrlCreateLabel("", $x + 101 + $j * 36, $y + 90, 30, 11, $ES_CENTER)
		Next
		
		GUICtrlCreateGroup("", -99, -99, 1, 1)
		
		For $j = $g_ahLblRankedQuickTrainNote[$i] To $g_ahLblRankedQuickSpell[$i][6]
			GUICtrlSetState($j, $GUI_HIDE)
		Next
		
		$x = 12
		$y += $del_y
	Next
EndFunc

Func CreateRankedAttackSettings()
	$g_hGUI_RANKED_ATTACK = _GUICreate("", $g_iSizeWGrpTab3, $g_iSizeHGrpTab3, 5, 25, BitOR($WS_CHILD, $WS_TABSTOP), -1, $g_hGUI_RANKED)
	
	Local $x = 25, $y = 20
	Local $sTxtTip = ""
	
	; Attack with group
	GUICtrlCreateGroup(GetTranslatedFileIni("MBR GUI Design Child Attack - Attack", "Group_01", "Attack with"), $x - 20, $y - 15, 145, 340)
	
	$x -= 15
	$y += 2
	
	; Attack algorithm
	$g_hCmbRankedAlgorithm = GUICtrlCreateCombo("", $x, $y, 135, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetData(-1, GetTranslatedFileIni("MBR GUI Design Child Attack - Attack", "Cmb-Algorithm_Item_01", "Standard Attack") & "|" & _
				GetTranslatedFileIni("MBR GUI Design Child Attack - Attack", "Cmb-Algorithm_Item_02", "Scripted Attack") & "|" & _
				GetTranslatedFileIni("MBR GUI Design Child Attack - Attack", "Cmb-Algorithm_Item_04", "SmartFarm Attack"), _
				GetTranslatedFileIni("MBR GUI Design Child Attack - Attack", "Cmb-Algorithm_Item_01", -1))
		GUICtrlSetOnEvent(-1, "cmbRankedAlgorithm")
	
	$y += 27
	
	; Troop selection
	$g_hCmbRankedSelectTroop = GUICtrlCreateCombo("", $x, $y, 135, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetData(-1, GetTranslatedFileIni("MBR GUI Design Child Attack - Attack", "Cmb-SelectTroop_Item_01", "Use All Troops") & "|" & _
				GetTranslatedFileIni("MBR GUI Design Child Attack - Attack", "Cmb-SelectTroop_Item_02", "Use Troops in Barracks"), _
				GetTranslatedFileIni("MBR GUI Design Child Attack - Attack", "Cmb-SelectTroop_Item_01", -1))
		_GUICtrlSetTip(-1, "Select the troops to use in ranked attacks")
		GUICtrlSetOnEvent(-1, "cmbRankedSelectTroop")
	
	$y += 35
	
	; Heroes
	$g_hPicRankedKingAttack = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnKing, $x, $y, 24, 24)
	$sTxtTip = "Use King in Ranked Attack"
	_GUICtrlSetTip(-1, $sTxtTip)
	$g_hChkRankedKingAttack = GUICtrlCreateCheckbox("", $x + 27, $y, 17, 17)
	_GUICtrlSetTip(-1, $sTxtTip)
	GUICtrlSetOnEvent(-1, "chkRankedUseHeroes")
	
	$x += 46
	$g_hPicRankedQueenAttack = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnQueen, $x, $y, 24, 24)
	$sTxtTip = "Use Queen in Ranked Attack"
	_GUICtrlSetTip(-1, $sTxtTip)
	$g_hChkRankedQueenAttack = GUICtrlCreateCheckbox("", $x + 27, $y, 17, 17)
	_GUICtrlSetTip(-1, $sTxtTip)
	GUICtrlSetOnEvent(-1, "chkRankedUseHeroes")
	
	$x += 46
	$g_hPicRankedPrinceAttack = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnPrince, $x, $y, 24, 24)
	$sTxtTip = "Use Prince in Ranked Attack"
	_GUICtrlSetTip(-1, $sTxtTip)
	$g_hChkRankedPrinceAttack = GUICtrlCreateCheckbox("", $x + 27, $y, 17, 17)
	_GUICtrlSetTip(-1, $sTxtTip)
	GUICtrlSetOnEvent(-1, "chkRankedUseHeroes")
	
	$y += 27
	$x -= 92
	
	$g_hPicRankedWardenAttack = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnWarden, $x, $y, 24, 24)
	$sTxtTip = "Use Warden in Ranked Attack"
	_GUICtrlSetTip(-1, $sTxtTip)
	$g_hChkRankedWardenAttack = GUICtrlCreateCheckbox("", $x + 27, $y, 17, 17)
	_GUICtrlSetTip(-1, $sTxtTip)
	GUICtrlSetOnEvent(-1, "chkRankedWardenAttack")
	
	$x += 46
	$g_hCmbRankedWardenMode = GUICtrlCreateCombo("", $x, $y, 90, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetData(-1, "Ground mode|Air mode|Default", "Default")
		_GUICtrlSetTip(-1, "Select Warden mode for Ranked Attack")
		GUICtrlSetOnEvent(-1, "cmbRankedWardenMode")
	
	$y += 27
	$x -= 46
	
	$g_hPicRankedChampionAttack = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnChampion, $x, $y, 24, 24)
	$sTxtTip = "Use Champion in Ranked Attack"
	_GUICtrlSetTip(-1, $sTxtTip)
	$g_hChkRankedChampionAttack = GUICtrlCreateCheckbox("", $x + 27, $y, 17, 17)
	_GUICtrlSetTip(-1, $sTxtTip)
	GUICtrlSetOnEvent(-1, "chkRankedUseHeroes")
	
	$x += 46
	$g_hPicRankedDropCC = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnCC, $x, $y, 24, 24)
	$sTxtTip = "Drop Clan Castle troops in Ranked Attack"
	_GUICtrlSetTip(-1, $sTxtTip)
	$g_hChkRankedDropCC = GUICtrlCreateCheckbox("", $x + 27, $y, 17, 17)
	_GUICtrlSetTip(-1, $sTxtTip)
	GUICtrlSetOnEvent(-1, "chkRankedDropCC")
	
	$y += 35
	$x = 10
	
	; Spell deployment
	GUICtrlCreateLabel("Deploy Spells:", $x, $y, 100, 17)
	$y += 20
	
	; First row of spells
	$g_hPicRankedLightSpell = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnLightSpell, $x, $y, 24, 24)
	$g_hChkRankedLightSpell = GUICtrlCreateCheckbox("", $x + 27, $y, 17, 17)
	GUICtrlSetOnEvent(-1, "chkRankedUseSpells")
	
	$x += 50
	$g_hPicRankedHealSpell = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnHealSpell, $x, $y, 24, 24)
	$g_hChkRankedHealSpell = GUICtrlCreateCheckbox("", $x + 27, $y, 17, 17)
	GUICtrlSetOnEvent(-1, "chkRankedUseSpells")
	
	$x += 50
	$g_hPicRankedRageSpell = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnRageSpell, $x, $y, 24, 24)
	$g_hChkRankedRageSpell = GUICtrlCreateCheckbox("", $x + 27, $y, 17, 17)
	GUICtrlSetOnEvent(-1, "chkRankedUseSpells")
	
	$y += 27
	$x = 10
	
	; Second row of spells
	$g_hPicRankedJumpSpell = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnJumpSpell, $x, $y, 24, 24)
	$g_hChkRankedJumpSpell = GUICtrlCreateCheckbox("", $x + 27, $y, 17, 17)
	GUICtrlSetOnEvent(-1, "chkRankedUseSpells")
	
	$x += 50
	$g_hPicRankedFreezeSpell = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnFreezeSpell, $x, $y, 24, 24)
	$g_hChkRankedFreezeSpell = GUICtrlCreateCheckbox("", $x + 27, $y, 17, 17)
	GUICtrlSetOnEvent(-1, "chkRankedUseSpells")
	
	$x += 50
	$g_hPicRankedPoisonSpell = _GUICtrlCreateIcon($g_sLibIconPath, $eIcnPoisonSpell, $x, $y, 24, 24)
	$g_hChkRankedPoisonSpell = GUICtrlCreateCheckbox("", $x + 27, $y, 17, 17)
	GUICtrlSetOnEvent(-1, "chkRankedUseSpells")
	
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	
	; Siege machines
	$x = 200
	$y = 20
	GUICtrlCreateGroup("Siege Machines", $x, $y - 15, 220, 80)
	
	$y += 5
	GUICtrlCreateLabel("Siege to use:", $x + 10, $y, 80, 17)
	$g_hCmbRankedSiege = GUICtrlCreateCombo("", $x + 10, $y + 20, 200, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetData(-1, "Any|Wall Wrecker|Battle Blimp|Stone Slammer|Siege Barracks|Log Launcher|Flame Flinger|Battle Drill", "Any")
		_GUICtrlSetTip(-1, "Select which siege machine to use in Ranked Attacks")
		GUICtrlSetOnEvent(-1, "cmbRankedSiege")
	
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	
	; Attack strategy settings group
	$y = 120
	GUICtrlCreateGroup("Attack Strategy", $x, $y, 220, 200)
	$x += 10
	$y += 20
	
	; Standard Attack Settings (default visible)
	Global $g_hGrpRankedStandardAttack = GUICtrlCreateGroup("", $x - 5, $y - 5, 210, 170)
	
	Global $g_hLblRankedStandardSettings = GUICtrlCreateLabel("Standard Attack Settings:", $x, $y, 150, 17)
	$y += 25
	
	Global $g_hChkRankedSmartAttackRedArea = GUICtrlCreateCheckbox("Smart Attack Red Area", $x, $y, -1, -1)
	GUICtrlSetOnEvent(-1, "chkRankedSmartAttackRedArea")
	$y += 25
	
	Global $g_hChkRankedSmartAttackGoldMines = GUICtrlCreateCheckbox("Smart Attack Gold Mines", $x, $y, -1, -1)
	GUICtrlSetOnEvent(-1, "chkRankedSmartAttackGoldMines")
	$y += 25
	
	Global $g_hChkRankedSmartAttackElixirCollectors = GUICtrlCreateCheckbox("Smart Attack Elixir Collectors", $x, $y, -1, -1)
	GUICtrlSetOnEvent(-1, "chkRankedSmartAttackElixirCollectors")
	$y += 25
	
	Global $g_hChkRankedSmartAttackDEDrills = GUICtrlCreateCheckbox("Smart Attack DE Drills", $x, $y, -1, -1)
	GUICtrlSetOnEvent(-1, "chkRankedSmartAttackDEDrills")
	$y += 35
	
	Global $g_hBtnRankedApplySettings = GUICtrlCreateButton("Apply to Ranked Attack", $x, $y, 195, 25)
	GUICtrlSetOnEvent(-1, "ApplyRankedAttackSettings")
	GUICtrlSetBkColor(-1, $COLOR_GREEN)
	
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	
	; Scripted Attack Settings (initially hidden)
	$y = 140
	Global $g_hGrpRankedScriptedAttack = GUICtrlCreateGroup("", $x - 5, $y - 5, 210, 170)
	GUICtrlSetState(-1, $GUI_HIDE)
	
	Global $g_hLblRankedScriptName = GUICtrlCreateLabel("Select Script:", $x, $y, 80, 17)
	GUICtrlSetState(-1, $GUI_HIDE)
	Global $g_hCmbRankedScriptName = GUICtrlCreateCombo("", $x, $y + 20, 195, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetState(-1, $GUI_HIDE)
	GUICtrlSetOnEvent(-1, "cmbRankedScriptName")
	
	$y += 50
	Global $g_hBtnRankedEditScript = GUICtrlCreateButton("Edit Script", $x, $y, 90, 23)
	GUICtrlSetState(-1, $GUI_HIDE)
	GUICtrlSetOnEvent(-1, "EditRankedScriptedAttack")
	
	Global $g_hBtnRankedNewScript = GUICtrlCreateButton("New Script", $x + 100, $y, 90, 23)
	GUICtrlSetState(-1, $GUI_HIDE)
	GUICtrlSetOnEvent(-1, "NewRankedScriptedAttack")
	
	$y += 30
	Global $g_hBtnRankedDuplicateScript = GUICtrlCreateButton("Copy Script", $x, $y, 90, 23)
	GUICtrlSetState(-1, $GUI_HIDE)
	GUICtrlSetOnEvent(-1, "DuplicateRankedScriptedAttack")
	
	Global $g_hBtnRankedDeleteScript = GUICtrlCreateButton("Delete Script", $x + 100, $y, 90, 23)
	GUICtrlSetState(-1, $GUI_HIDE)
	GUICtrlSetOnEvent(-1, "DeleteRankedScriptedAttack")
	
	$y += 30
	Global $g_hLblRankedScriptInfo = GUICtrlCreateLabel("Script will be executed when\nRanked Attack starts", $x, $y, 190, 30, $SS_CENTER)
	GUICtrlSetFont(-1, 8)
	GUICtrlSetColor(-1, $COLOR_GRAY)
	GUICtrlSetState(-1, $GUI_HIDE)
	
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$x -= 10
	$y = 120
	
	$y += 20
	GUICtrlCreateLabel("Note: Ranked attacks cannot search", $x + 10, $y, 200, 17)
	GUICtrlCreateLabel("for bases. The first base found", $x + 10, $y + 15, 200, 17)
	GUICtrlCreateLabel("must be attacked immediately.", $x + 10, $y + 30, 200, 17)
	
	$y += 60
	GUICtrlCreateLabel("Attack Type:", $x + 10, $y, 80, 17)
	$g_hCmbRankedAttackType = GUICtrlCreateCombo("", $x + 10, $y + 20, 200, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetData(-1, "All Out Attack|Smart Deploy|Trophy Push", "Smart Deploy")
		GUICtrlSetOnEvent(-1, "cmbRankedAttackType")
	
	$y += 55
	GUICtrlCreateCheckbox("End battle when trophies secured", $x + 10, $y, 200, 17)
	
	$y += 20
	GUICtrlCreateCheckbox("Activate King/Queen abilities", $x + 10, $y, 200, 17)
		GUICtrlSetState(-1, $GUI_CHECKED)
	
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	
	GUISetState(@SW_HIDE, $g_hGUI_RANKED_ATTACK)
EndFunc

Func CreateRankedOptions()
	$g_hGUI_RANKED_OPTIONS = _GUICreate("", $g_iSizeWGrpTab3, $g_iSizeHGrpTab3, 5, 25, BitOR($WS_CHILD, $WS_TABSTOP), -1, $g_hGUI_RANKED)
	
	Local $x = 25, $y = 20
	
	; Attack Priority Group
	GUICtrlCreateGroup(GetTranslatedFileIni("MBR GUI Design Child Attack - Options", "GroupAttackPriority", "Attack Priority"), $x - 10, $y - 5, 430, 85)
	
	$y += 10
	GUICtrlCreateLabel("When Ranked Mode is enabled:", $x, $y, 400, 17)
	$y += 20
	GUICtrlCreateLabel("• Ranked attacks are prioritized and completed first (up to 6 daily)", $x + 10, $y, 400, 17)
	$y += 18
	GUICtrlCreateLabel("• After ranked attacks are exhausted, normal attacks continue automatically", $x + 10, $y, 400, 17)
	
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	
	$y += 35
	
	; Consecutive Attack Limits Group (Shared with Normal Mode)
	GUICtrlCreateGroup(GetTranslatedFileIni("MBR GUI Design Child Attack - Troops_Options", "GroupConsecutiveAttacks", "Consecutive Attack Limits"), $x - 10, $y, 430, 110)
	
	$y += 20
	$g_hLbAttackconsecutiveTitle = GUICtrlCreateLabel(GetTranslatedFileIni("MBR GUI Design Child Attack - Troops_Options", "LbAttackconsecutiveTitle", "Consecutive Attack Limits :"), $x, $y, -1, -1)
	
	; Note about shared settings
	GUICtrlCreateLabel("(Shared with Normal Mode)", $x + 270, $y, 150, 17)
	GUICtrlSetColor(-1, $COLOR_NAVY)
	GUICtrlSetFont(-1, 8, 400, 2) ; Italic
	
	$y += 22
	GUICtrlCreateLabel(">", $x, $y + 2, 10, 17)
	$g_hCmbAttackconsecutiveMin = GUICtrlCreateInput($g_iAttackconsecutiveMin, $x + 15, $y, 37, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Attack - Troops_Options", "TxtMinLbAttackconsecutiveLimit_Info_01", "Enter minimum number of attacks before doing a pause."))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "cmbAttackconsecutiveMin")
	
	$g_hLbAttackconsecutiveLimit = GUICtrlCreateLabel(GetTranslatedFileIni("MBR GUI Design Child Attack - Troops_Options", "LbAttackconsecutiveLimit", "->"), $x + 56, $y + 2, -1, -1)
	
	$g_hCmbAttackconsecutiveMax = GUICtrlCreateInput($g_iAttackconsecutiveMax, $x + 71, $y, 37, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	_GUICtrlSetTip(-1, GetTranslatedFileIni("MBR GUI Design Child Attack - Troops_Options", "TxtMinLbAttackconsecutiveLimit_Info_02", "Enter maximum number of attacks before doing a pause."))
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetOnEvent(-1, "cmbAttackconsecutiveMax")
	
	GUICtrlCreateLabel("attacks", $x + 113, $y + 2, 50, 17)
	
	; Example text
	$y += 22
	GUICtrlCreateLabel("Example: Bot will randomly attack between min-max times before pausing", $x, $y, 400, 17)
	GUICtrlSetColor(-1, $COLOR_GRAY)
	GUICtrlSetFont(-1, 8)
	
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	
	$y += 35
	
	; Pause Duration Group
	GUICtrlCreateGroup(GetTranslatedFileIni("MBR GUI Design Child Attack - Troops_Options", "GroupPauseDuration", "Random Closing Time"), $x - 10, $y, 430, 110)
	
	$y += 20
	$g_hLblCloseWaitingTroops = GUICtrlCreateLabel(GetTranslatedFileIni("MBR GUI Design Child Attack - Troops_Options", "LblCloseWaitingTroops", "Random Closing Time :"), $x, $y, -1, -1)
	
	; Note about shared settings
	GUICtrlCreateLabel("(Shared with Normal Mode)", $x + 270, $y, 150, 17)
	GUICtrlSetColor(-1, $COLOR_NAVY)
	GUICtrlSetFont(-1, 8, 400, 2) ; Italic
	
	$y += 22
	$g_hLblSymbolWaiting = GUICtrlCreateLabel(">", $x, $y + 2, -1, -1)
	Local $sTxtTip = GetTranslatedFileIni("MBR GUI Design Child Attack - Troops_Options", "LblSymbolWaiting_Info_01", "Enter number Minimum time to close in minutes for close CoC which you want")
	_GUICtrlSetTip(-1, $sTxtTip)
	$g_hCmbMinimumTimeCloseMin = GUICtrlCreateCombo("", $x + 15, $y, 37, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40", "20")
	GUICtrlSetOnEvent(-1, "CmbMinimumTimeCloseMin")
	_GUICtrlSetTip(-1, $sTxtTip)
	
	$g_hLblToWaiting = GUICtrlCreateLabel("To", $x + 58, $y + 2, -1, -1)
	
	$g_hCmbMinimumTimeCloseMax = GUICtrlCreateCombo("", $x + 77, $y, 37, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40", "35")
	GUICtrlSetOnEvent(-1, "CmbMinimumTimeCloseMax")
	_GUICtrlSetTip(-1, $sTxtTip)
	
	$g_hLblWaitingInMinutes = GUICtrlCreateLabel(GetTranslatedFileIni("MBR Global GUI Design", "min.", "min."), $x + 117, $y + 2, -1, -1)
	_GUICtrlSetTip(-1, $sTxtTip)
	
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	
	GUISetState(@SW_HIDE, $g_hGUI_RANKED_OPTIONS)
EndFunc

; Event handlers for Ranked GUI controls
Func chkRankedEnabled()
	$g_bRankedModeEnabled = (GUICtrlRead($g_hChkRankedEnabled) = $GUI_CHECKED)
	SaveConfig()
	SetLog("Ranked Mode " & ($g_bRankedModeEnabled ? "Enabled" : "Disabled"), $COLOR_SUCCESS)
	
	; Enable/disable ranked controls based on checkbox state
	Local $iState = $g_bRankedModeEnabled ? $GUI_ENABLE : $GUI_DISABLE
	GUICtrlSetState($g_hTxtRankedAttacksRemaining, $iState)
	GUICtrlSetState($g_hCmbRankedAlgorithm, $iState)
	GUICtrlSetState($g_hCmbRankedSelectTroop, $iState)
	GUICtrlSetState($g_hChkRankedKingAttack, $iState)
	GUICtrlSetState($g_hChkRankedQueenAttack, $iState)
	GUICtrlSetState($g_hChkRankedWardenAttack, $iState)
	GUICtrlSetState($g_hCmbRankedWardenMode, $iState)
	GUICtrlSetState($g_hChkRankedChampionAttack, $iState)
	GUICtrlSetState($g_hChkRankedPrinceAttack, $iState)
	GUICtrlSetState($g_hChkRankedDropCC, $iState)
	GUICtrlSetState($g_hCmbRankedSiege, $iState)
EndFunc

Func txtRankedAttacksRemaining()
	Local $iValue = Int(GUICtrlRead($g_hTxtRankedAttacksRemaining))
	If $iValue < 0 Then $iValue = 0
	If $iValue > 6 Then $iValue = 6
	GUICtrlSetData($g_hTxtRankedAttacksRemaining, $iValue)
	$g_iRankedAttacksRemaining = $iValue
	$g_iRankedAttacksToday = 6 - $iValue
	SetLog("Ranked attacks remaining set to: " & $iValue, $COLOR_INFO)
	SaveConfig()
EndFunc

Func chkRankedWardenAttack()
	If GUICtrlRead($g_hChkRankedWardenAttack) = $GUI_CHECKED Then
		GUICtrlSetState($g_hCmbRankedWardenMode, $GUI_ENABLE)
	Else
		GUICtrlSetState($g_hCmbRankedWardenMode, $GUI_DISABLE)
	EndIf
	chkRankedUseHeroes()
EndFunc

Func chkRankedDropCC()
	$g_bRankedDropCC = (GUICtrlRead($g_hChkRankedDropCC) = $GUI_CHECKED)
	SaveConfig()
EndFunc

Func chkRankedUseSpells()
	; Save spell usage settings
	$g_bRankedUseLightSpell = (GUICtrlRead($g_hChkRankedLightSpell) = $GUI_CHECKED)
	$g_bRankedUseHealSpell = (GUICtrlRead($g_hChkRankedHealSpell) = $GUI_CHECKED)
	$g_bRankedUseRageSpell = (GUICtrlRead($g_hChkRankedRageSpell) = $GUI_CHECKED)
	$g_bRankedUseJumpSpell = (GUICtrlRead($g_hChkRankedJumpSpell) = $GUI_CHECKED)
	$g_bRankedUseFreezeSpell = (GUICtrlRead($g_hChkRankedFreezeSpell) = $GUI_CHECKED)
	$g_bRankedUsePoisonSpell = (GUICtrlRead($g_hChkRankedPoisonSpell) = $GUI_CHECKED)
	SaveConfig()
EndFunc

Func cmbRankedAlgorithm()
	; Save the selected algorithm
	$g_iRankedAttackAlgorithm = _GUICtrlComboBox_GetCurSel($g_hCmbRankedAlgorithm)
	
	; Show/hide controls based on selection
	If $g_iRankedAttackAlgorithm = 1 Then ; Scripted Attack selected
		; Hide standard attack controls
		GUICtrlSetState($g_hGrpRankedStandardAttack, $GUI_HIDE)
		GUICtrlSetState($g_hLblRankedStandardSettings, $GUI_HIDE)
		GUICtrlSetState($g_hChkRankedSmartAttackRedArea, $GUI_HIDE)
		GUICtrlSetState($g_hChkRankedSmartAttackGoldMines, $GUI_HIDE)
		GUICtrlSetState($g_hChkRankedSmartAttackElixirCollectors, $GUI_HIDE)
		GUICtrlSetState($g_hChkRankedSmartAttackDEDrills, $GUI_HIDE)
		; Hide Apply button for scripted mode
		GUICtrlSetState($g_hBtnRankedApplySettings, $GUI_HIDE)
		
		; Show script controls
		GUICtrlSetState($g_hGrpRankedScriptedAttack, $GUI_SHOW)
		GUICtrlSetState($g_hLblRankedScriptName, $GUI_SHOW)
		GUICtrlSetState($g_hCmbRankedScriptName, $GUI_SHOW)
		GUICtrlSetState($g_hBtnRankedEditScript, $GUI_SHOW)
		GUICtrlSetState($g_hBtnRankedNewScript, $GUI_SHOW)
		GUICtrlSetState($g_hBtnRankedDuplicateScript, $GUI_SHOW)
		GUICtrlSetState($g_hBtnRankedDeleteScript, $GUI_SHOW)
		GUICtrlSetState($g_hLblRankedScriptInfo, $GUI_SHOW)
		; Populate script list
		UpdateRankedScriptList()
	Else
		; Show standard attack controls
		GUICtrlSetState($g_hGrpRankedStandardAttack, $GUI_SHOW)
		GUICtrlSetState($g_hLblRankedStandardSettings, $GUI_SHOW)
		GUICtrlSetState($g_hChkRankedSmartAttackRedArea, $GUI_SHOW)
		GUICtrlSetState($g_hChkRankedSmartAttackGoldMines, $GUI_SHOW)
		GUICtrlSetState($g_hChkRankedSmartAttackElixirCollectors, $GUI_SHOW)
		GUICtrlSetState($g_hChkRankedSmartAttackDEDrills, $GUI_SHOW)
		; Show Apply button for standard mode
		GUICtrlSetState($g_hBtnRankedApplySettings, $GUI_SHOW)
		
		; Hide script controls
		GUICtrlSetState($g_hGrpRankedScriptedAttack, $GUI_HIDE)
		GUICtrlSetState($g_hLblRankedScriptName, $GUI_HIDE)
		GUICtrlSetState($g_hCmbRankedScriptName, $GUI_HIDE)
		GUICtrlSetState($g_hBtnRankedEditScript, $GUI_HIDE)
		GUICtrlSetState($g_hBtnRankedNewScript, $GUI_HIDE)
		GUICtrlSetState($g_hBtnRankedDuplicateScript, $GUI_HIDE)
		GUICtrlSetState($g_hBtnRankedDeleteScript, $GUI_HIDE)
		GUICtrlSetState($g_hLblRankedScriptInfo, $GUI_HIDE)
	EndIf
	
	SaveConfig()
EndFunc

Func UpdateRankedScriptList()
	; Load available CSV attack scripts
	Local $sScriptDir = @ScriptDir & "\CSV\Attack\"
	Local $aFileList = _FileListToArray($sScriptDir, "*.csv", $FLTA_FILES)
	Local $sScriptList = ""
	
	If IsArray($aFileList) Then
		For $i = 1 To $aFileList[0]
			$sScriptList &= StringReplace($aFileList[$i], ".csv", "") & "|"
		Next
	EndIf
	
	If $sScriptList = "" Then
		$sScriptList = "No scripts found|"
	EndIf
	
	GUICtrlSetData($g_hCmbRankedScriptName, $sScriptList, "")
EndFunc

Func cmbRankedScriptName()
	; Save selected script name
	Global $g_sRankedScriptName = GUICtrlRead($g_hCmbRankedScriptName)
	SetLog("Ranked Script Selected: " & $g_sRankedScriptName, $COLOR_INFO)
	SaveConfig()
EndFunc

Func EditRankedScriptedAttack()
	Local $sScriptName = GUICtrlRead($g_hCmbRankedScriptName)
	If $sScriptName <> "" And $sScriptName <> "No scripts found" Then
		ShellExecute("notepad.exe", @ScriptDir & "\CSV\Attack\" & $sScriptName & ".csv")
	Else
		SetLog("Please select a script first", $COLOR_WARNING)
	EndIf
EndFunc

Func NewRankedScriptedAttack()
	SetLog("Create new script feature - Coming soon", $COLOR_INFO)
EndFunc

Func DuplicateRankedScriptedAttack()
	SetLog("Duplicate script feature - Coming soon", $COLOR_INFO)
EndFunc

Func DeleteRankedScriptedAttack()
	SetLog("Delete script feature - Coming soon", $COLOR_INFO)
EndFunc

Func chkRankedSmartAttackRedArea()
	SaveConfig()
EndFunc

Func chkRankedSmartAttackGoldMines()
	SaveConfig()
EndFunc

Func chkRankedSmartAttackElixirCollectors()
	SaveConfig()
EndFunc

Func chkRankedSmartAttackDEDrills()
	SaveConfig()
EndFunc

Func ApplyRankedAttackSettings()
	; Apply the selected settings to ranked attack configuration
	SetLog("Ranked attack settings applied", $COLOR_SUCCESS)
	SaveConfig()
EndFunc

Func TrainRankedTroopCountEdit()
	; Handle individual troop count changes - similar to TrainTroopCountEdit
	For $i = 0 To $eTroopCount - 1
		If @GUI_CtrlId = $g_ahTxtRankedTrainArmyTroopCount[$i] Then
			$g_aiRankedArmyComp[$i] = GUICtrlRead($g_ahTxtRankedTrainArmyTroopCount[$i])
			lblRankedTotalCountTroop()
			Return
		EndIf
	Next
EndFunc

Func TrainRankedSpellCountEdit()
	; Handle individual spell count changes
	For $i = 0 To $eSpellCount - 1
		If @GUI_CtrlId = $g_ahTxtRankedTrainArmySpellCount[$i] Then
			$g_aiRankedSpellComp[$i] = GUICtrlRead($g_ahTxtRankedTrainArmySpellCount[$i])
			lblRankedTotalCountSpell()
			Return
		EndIf
	Next
EndFunc

Func TrainRankedSiegeCountEdit()
	; Handle individual siege count changes
	For $i = 0 To $eSiegeMachineCount - 1
		If @GUI_CtrlId = $g_ahTxtRankedTrainArmySiegeCount[$i] Then
			$g_aiRankedSiegeComp[$i] = GUICtrlRead($g_ahTxtRankedTrainArmySiegeCount[$i])
			lblRankedTotalCountSiege()
			Return
		EndIf
	Next
EndFunc

Func lblRankedTotalCountTroop()
	; Calculate and display total troops - similar to lblTotalCountTroop1
	Local $TotalTroopsToTrain = 0
	Local $ArmyCampTemp = 0
	
	If GUICtrlRead($g_hChkRankedTotalCampForced) = $GUI_CHECKED Then
		$ArmyCampTemp = Floor(GUICtrlRead($g_hTxtRankedTotalCampForced) * GUICtrlRead($g_hTxtRankedFullTroop) / 100)
	Else
		$ArmyCampTemp = Floor(280 * GUICtrlRead($g_hTxtRankedFullTroop) / 100)
	EndIf
	
	; Clear display
	For $i = 0 To UBound($g_ahPicRankedTrainArmyTroopTmp) - 1
		GUICtrlSetState($g_ahPicRankedTrainArmyTroopTmp[$i], $GUI_HIDE)
		GUICtrlSetState($g_ahLblRankedTrainArmyTroopTmp[$i], $GUI_HIDE)
	Next
	
	Local $iTmpTroops = 0
	For $i = 0 To $eTroopCount - 1
		Local $iCount = $g_aiRankedArmyComp[$i]
		If $iCount > 0 Then
			$TotalTroopsToTrain += $iCount * $g_aiTroopSpace[$i]
			; Set display icons
			If $iTmpTroops <= UBound($g_ahPicRankedTrainArmyTroopTmp) - 1 Then
				_GUICtrlSetImage($g_ahPicRankedTrainArmyTroopTmp[$iTmpTroops], $g_sLibIconPath, $g_aQuickTroopIcon[$i])
				GUICtrlSetState($g_ahPicRankedTrainArmyTroopTmp[$iTmpTroops], $GUI_SHOW)
				GUICtrlSetData($g_ahLblRankedTrainArmyTroopTmp[$iTmpTroops], $iCount)
				GUICtrlSetState($g_ahLblRankedTrainArmyTroopTmp[$iTmpTroops], $GUI_SHOW)
				$iTmpTroops += 1
			EndIf
		EndIf
	Next
	
	GUICtrlSetData($g_hLblRankedCountTotal, String($TotalTroopsToTrain))
	
	; Set colors based on capacity
	For $i = 0 To $eTroopCount - 1
		If $g_ahTxtRankedTrainArmyTroopCount[$i] <> 0 Then
			GUICtrlSetBkColor($g_ahTxtRankedTrainArmyTroopCount[$i], $TotalTroopsToTrain <= GUICtrlRead($g_hTxtRankedTotalCampForced) ? $COLOR_WHITE : $COLOR_RED)
		EndIf
	Next
	
	If GUICtrlRead($g_hChkRankedTotalCampForced) = $GUI_CHECKED And GUICtrlRead($g_hLblRankedCountTotal) = GUICtrlRead($g_hTxtRankedTotalCampForced) Then
		GUICtrlSetBkColor($g_hLblRankedCountTotal, $COLOR_GREEN)
	ElseIf GUICtrlRead($g_hLblRankedCountTotal) = $ArmyCampTemp Then
		GUICtrlSetBkColor($g_hLblRankedCountTotal, $COLOR_GREEN)
	ElseIf GUICtrlRead($g_hLblRankedCountTotal) > $ArmyCampTemp / 2 And GUICtrlRead($g_hLblRankedCountTotal) < $ArmyCampTemp Then
		GUICtrlSetBkColor($g_hLblRankedCountTotal, $COLOR_OLIVE)
	Else
		If GUICtrlRead($g_hTxtRankedTotalCampForced) > 0 Then GUICtrlSetBkColor($g_hLblRankedCountTotal, $COLOR_RED)
	EndIf
	
	; Update progress bar
	Local $fPctOfForced = Floor((GUICtrlRead($g_hLblRankedCountTotal) / GUICtrlRead($g_hTxtRankedTotalCampForced)) * 100)
	Local $fPctOfCalculated = Floor((GUICtrlRead($g_hLblRankedCountTotal) / $ArmyCampTemp) * 100)
	
	If GUICtrlRead($g_hChkRankedTotalCampForced) = $GUI_CHECKED Then
		GUICtrlSetData($g_hCalRankedTotalTroops, $fPctOfForced < 1 ? (GUICtrlRead($g_hLblRankedCountTotal) > 0 ? 1 : 0) : $fPctOfForced)
	Else
		GUICtrlSetData($g_hCalRankedTotalTroops, $fPctOfCalculated < 1 ? (GUICtrlRead($g_hLblRankedCountTotal) > 0 ? 1 : 0) : $fPctOfCalculated)
	EndIf
	
	SaveConfig()
EndFunc

Func lblRankedTotalCountSpell()
	; Calculate total space for spell composition
	Local $g_iTotalRankedTrainSpaceSpell = 0
	
	; Clear display
	For $i = 0 To UBound($g_ahPicRankedTrainArmySpellTmp) - 1
		GUICtrlSetState($g_ahPicRankedTrainArmySpellTmp[$i], $GUI_HIDE)
		GUICtrlSetState($g_ahLblRankedTrainArmySpellTmp[$i], $GUI_HIDE)
	Next
	
	Local $iTmpSpells = 0
	For $i = 0 To $eSpellCount - 1
		Local $iCount = $g_aiRankedSpellComp[$i]
		If $iCount > 0 Then
			$g_iTotalRankedTrainSpaceSpell += $iCount * $g_aiSpellSpace[$i]
			
			; Set display icons
			If $iTmpSpells <= UBound($g_ahPicRankedTrainArmySpellTmp) - 1 Then
				_GUICtrlSetImage($g_ahPicRankedTrainArmySpellTmp[$iTmpSpells], $g_sLibIconPath, $g_aQuickSpellIcon[$i])
				GUICtrlSetState($g_ahPicRankedTrainArmySpellTmp[$iTmpSpells], $GUI_SHOW)
				GUICtrlSetData($g_ahLblRankedTrainArmySpellTmp[$iTmpSpells], $iCount)
				GUICtrlSetState($g_ahLblRankedTrainArmySpellTmp[$iTmpSpells], $GUI_SHOW)
				$iTmpSpells += 1
			EndIf
		EndIf
	Next
	
	GUICtrlSetData($g_hLblRankedCountTotalSpells, String($g_iTotalRankedTrainSpaceSpell))
	
	; Set colors
	For $i = 0 To $eSpellCount - 1
		If $g_ahTxtRankedTrainArmySpellCount[$i] <> 0 Then
			GUICtrlSetBkColor($g_ahTxtRankedTrainArmySpellCount[$i], $g_iTotalRankedTrainSpaceSpell <= Number(GUICtrlRead($g_hTxtRankedTotalCountSpell)) ? $COLOR_WHITE : $COLOR_RED)
		EndIf
	Next
	
	GUICtrlSetBkColor($g_hLblRankedCountTotalSpells, $g_iTotalRankedTrainSpaceSpell <= Number(GUICtrlRead($g_hTxtRankedTotalCountSpell)) ? $COLOR_GREEN : $COLOR_RED)
	
	; Update progress bar
	Local $iSpellProgress = Floor(($g_iTotalRankedTrainSpaceSpell / Number(GUICtrlRead($g_hTxtRankedTotalCountSpell))) * 100)
	If $iSpellProgress <= 100 Then
		GUICtrlSetData($g_hCalRankedTotalSpells, $iSpellProgress)
		GUICtrlSetState($g_hCalRankedTotalSpells, $GUI_SHOW)
	Else
		GUICtrlSetState($g_hCalRankedTotalSpells, $GUI_HIDE)
	EndIf
	
	SaveConfig()
EndFunc

Func lblRankedTotalCountSiege()
	; Update siege display
	For $i = 0 To UBound($g_ahPicRankedTrainArmySiegeTmp) - 1
		GUICtrlSetState($g_ahPicRankedTrainArmySiegeTmp[$i], $GUI_HIDE)
		GUICtrlSetState($g_ahLblRankedTrainArmySiegeTmp[$i], $GUI_HIDE)
	Next
	
	Local $iTmpSieges = 0
	For $i = 0 To $eSiegeMachineCount - 1
		Local $iCount = $g_aiRankedSiegeComp[$i]
		If $iCount > 0 Then
			If $iTmpSieges <= UBound($g_ahPicRankedTrainArmySiegeTmp) - 1 Then
				_GUICtrlSetImage($g_ahPicRankedTrainArmySiegeTmp[$iTmpSieges], $g_sLibIconPath, $eIcnWallW + $i)
				GUICtrlSetState($g_ahPicRankedTrainArmySiegeTmp[$iTmpSieges], $GUI_SHOW)
				GUICtrlSetData($g_ahLblRankedTrainArmySiegeTmp[$iTmpSieges], $iCount)
				GUICtrlSetState($g_ahLblRankedTrainArmySiegeTmp[$iTmpSieges], $GUI_SHOW)
				$iTmpSieges += 1
			EndIf
		EndIf
	Next
	
	SaveConfig()
EndFunc

Func SetRankedComboTroopComp()
	; Update when camp size or full % changes
	lblRankedTotalCountTroop()
	lblRankedTotalCountSpell()
	lblRankedTotalCountSiege()
EndFunc

Func txtRankedSpellCount()
	; Update ranked spell composition when spell counts change
	Local $iTotalSpells = 0
	Local $iMaxSpells = 11  ; Default spell capacity
	
	; Calculate total spell space
	For $i = 0 To 6  ; Only first 7 spells shown in simple view
		If $g_ahTxtRankedTrainArmySpellCount[$i] <> 0 Then
			Local $iCount = Int(GUICtrlRead($g_ahTxtRankedTrainArmySpellCount[$i]))
			$g_aiRankedSpellComp[$i] = $iCount
			$iTotalSpells += $iCount * $g_aiSpellSpace[$i]
		EndIf
	Next
	
	; Update progress bar
	If $g_hCalRankedTotalSpells <> 0 Then
		Local $iPercent = Int(($iTotalSpells / $iMaxSpells) * 100)
		If $iPercent > 100 Then $iPercent = 100
		GUICtrlSetData($g_hCalRankedTotalSpells, $iPercent)
	EndIf
	
	; Update total label
	If $g_hLblRankedCountTotalSpells <> 0 Then
		GUICtrlSetData($g_hLblRankedCountTotalSpells, $iTotalSpells & "/" & $iMaxSpells)
		; Color code
		If $iTotalSpells > $iMaxSpells Then
			GUICtrlSetColor($g_hLblRankedCountTotalSpells, $COLOR_RED)
		ElseIf $iTotalSpells = $iMaxSpells Then
			GUICtrlSetColor($g_hLblRankedCountTotalSpells, $COLOR_GREEN)
		Else
			GUICtrlSetColor($g_hLblRankedCountTotalSpells, $COLOR_BLACK)
		EndIf
	EndIf
	
	SaveConfig()
EndFunc

Func txtRankedSiegeCount()
	; Update ranked siege composition when siege counts change
	For $i = 0 To 2  ; Only 3 siege machines shown
		If $g_ahTxtRankedTrainArmySiegeCount[$i] <> 0 Then
			$g_aiRankedSiegeComp[$i] = Int(GUICtrlRead($g_ahTxtRankedTrainArmySiegeCount[$i]))
		EndIf
	Next
	SaveConfig()
EndFunc

Func chkRankedQuickArmy1()
	If GUICtrlRead($g_ahChkRankedArmy[0]) = $GUI_CHECKED Then
		; Uncheck other armies
		GUICtrlSetState($g_ahChkRankedArmy[1], $GUI_UNCHECKED)
		GUICtrlSetState($g_ahChkRankedArmy[2], $GUI_UNCHECKED)
		$g_iRankedQuickTrainArmy = 0
	Else
		$g_iRankedQuickTrainArmy = -1
	EndIf
	SaveConfig()
EndFunc

Func chkRankedQuickArmy2()
	If GUICtrlRead($g_ahChkRankedArmy[1]) = $GUI_CHECKED Then
		; Uncheck other armies
		GUICtrlSetState($g_ahChkRankedArmy[0], $GUI_UNCHECKED)
		GUICtrlSetState($g_ahChkRankedArmy[2], $GUI_UNCHECKED)
		$g_iRankedQuickTrainArmy = 1
	Else
		$g_iRankedQuickTrainArmy = -1
	EndIf
	SaveConfig()
EndFunc

Func chkRankedQuickArmy3()
	If GUICtrlRead($g_ahChkRankedArmy[2]) = $GUI_CHECKED Then
		; Uncheck other armies
		GUICtrlSetState($g_ahChkRankedArmy[0], $GUI_UNCHECKED)
		GUICtrlSetState($g_ahChkRankedArmy[1], $GUI_UNCHECKED)
		$g_iRankedQuickTrainArmy = 2
	Else
		$g_iRankedQuickTrainArmy = -1
	EndIf
	SaveConfig()
EndFunc

Func btnRankedEditQuickArmy1()
	; For now, just show a message that editing will be implemented
	SetLog("Edit Ranked Quick Army 1 - Feature in development", $COLOR_INFO)
EndFunc

Func btnRankedEditQuickArmy2()
	; For now, just show a message that editing will be implemented
	SetLog("Edit Ranked Quick Army 2 - Feature in development", $COLOR_INFO)
EndFunc

Func btnRankedEditQuickArmy3()
	; For now, just show a message that editing will be implemented
	SetLog("Edit Ranked Quick Army 3 - Feature in development", $COLOR_INFO)
EndFunc

Func HideAllRankedTroops()
	; Hide all troops
	For $i = $g_ahPicRankedTrainArmyTroop[$eTroopBarbarian] To $g_ahPicRankedTrainArmyTroop[$eTroopThrower]
		GUICtrlSetState($i, $GUI_HIDE)
	Next
	For $i = $g_ahTxtRankedTrainArmyTroopCount[$eTroopBarbarian] To $g_ahTxtRankedTrainArmyTroopCount[$eTroopThrower]
		GUICtrlSetState($i, $GUI_HIDE)
	Next
	
	; Hide dark troops
	For $i = $g_ahPicRankedTrainArmyTroop[$eTroopMinion] To $g_ahPicRankedTrainArmyTroop[$eTroopFurnace]
		GUICtrlSetState($i, $GUI_HIDE)
	Next
	For $i = $g_ahTxtRankedTrainArmyTroopCount[$eTroopMinion] To $g_ahTxtRankedTrainArmyTroopCount[$eTroopFurnace]
		GUICtrlSetState($i, $GUI_HIDE)
	Next
	
	; Hide super troops
	For $i = $g_ahPicRankedTrainArmyTroop[$eTroopSuperBarbarian] To $g_ahPicRankedTrainArmyTroop[$eTroopSuperHogRider]
		GUICtrlSetState($i, $GUI_HIDE)
	Next
	For $i = $g_ahTxtRankedTrainArmyTroopCount[$eTroopSuperBarbarian] To $g_ahTxtRankedTrainArmyTroopCount[$eTroopSuperHogRider]
		GUICtrlSetState($i, $GUI_HIDE)
	Next
	
	; Hide all spells
	For $i = $g_ahPicRankedTrainArmySpell[$eSpellLightning] To $g_ahPicRankedTrainArmySpell[$eSpellOvergrowth]
		GUICtrlSetState($i, $GUI_HIDE)
	Next
	For $i = $g_ahTxtRankedTrainArmySpellCount[$eSpellLightning] To $g_ahTxtRankedTrainArmySpellCount[$eSpellOvergrowth]
		GUICtrlSetState($i, $GUI_HIDE)
	Next
	
	; Hide all siege machines
	For $i = $g_ahPicRankedTrainArmySiege[$eSiegeWallWrecker] To $g_ahPicRankedTrainArmySiege[$eSiegeTroopLauncher]
		GUICtrlSetState($i, $GUI_HIDE)
	Next
	For $i = $g_ahTxtRankedTrainArmySiegeCount[$eSiegeWallWrecker] To $g_ahTxtRankedTrainArmySiegeCount[$eSiegeTroopLauncher]
		GUICtrlSetState($i, $GUI_HIDE)
	Next
EndFunc

Func SetRankedBtnSelector($sType = "All")
	For $i = $g_hBtnRankedElixirTroops To $g_hBtnRankedSieges
		GUICtrlSetBkColor($i, $COLOR_BLACK)
		GUICtrlSetColor($i, $COLOR_WHITE)
		GUICtrlSetFont($i, 11, $FW_BOLD, Default, "Segoe UI Semibold", $CLEARTYPE_QUALITY)
	Next
	Switch $sType
		Case "ElixirTroops"
			GUICtrlSetColor($g_hBtnRankedElixirTroops, $COLOR_YELLOW)
		Case "DarkElixirTroops"
			GUICtrlSetColor($g_hBtnRankedDarkElixirTroops, $COLOR_YELLOW)
		Case "SuperTroops"
			GUICtrlSetColor($g_hBtnRankedSuperTroops, $COLOR_YELLOW)
		Case "Spells"
			GUICtrlSetColor($g_hBtnRankedSpells, $COLOR_YELLOW)
		Case "Sieges"
			GUICtrlSetColor($g_hBtnRankedSieges, $COLOR_YELLOW)
	EndSwitch
EndFunc

Func BtnRankedElixirTroops()
	; Hide all troops, spells, and sieges first
	For $i = 0 To $eTroopCount - 1
		If $g_ahPicRankedTrainArmyTroop[$i] <> 0 Then GUICtrlSetState($g_ahPicRankedTrainArmyTroop[$i], $GUI_HIDE)
		If $g_ahTxtRankedTrainArmyTroopCount[$i] <> 0 Then GUICtrlSetState($g_ahTxtRankedTrainArmyTroopCount[$i], $GUI_HIDE)
	Next
	For $i = 0 To $eSpellCount - 1
		If $g_ahPicRankedTrainArmySpell[$i] <> 0 Then GUICtrlSetState($g_ahPicRankedTrainArmySpell[$i], $GUI_HIDE)
		If $g_ahTxtRankedTrainArmySpellCount[$i] <> 0 Then GUICtrlSetState($g_ahTxtRankedTrainArmySpellCount[$i], $GUI_HIDE)
	Next
	For $i = 0 To $eSiegeMachineCount - 1
		If $g_ahPicRankedTrainArmySiege[$i] <> 0 Then GUICtrlSetState($g_ahPicRankedTrainArmySiege[$i], $GUI_HIDE)
		If $g_ahTxtRankedTrainArmySiegeCount[$i] <> 0 Then GUICtrlSetState($g_ahTxtRankedTrainArmySiegeCount[$i], $GUI_HIDE)
	Next
	
	; Show only elixir troops ($eTroopBarbarian to $eTroopElectroTitan)
	For $i = $eTroopBarbarian To $eTroopElectroTitan
		If $g_ahPicRankedTrainArmyTroop[$i] <> 0 Then GUICtrlSetState($g_ahPicRankedTrainArmyTroop[$i], $GUI_SHOW)
		If $g_ahTxtRankedTrainArmyTroopCount[$i] <> 0 Then GUICtrlSetState($g_ahTxtRankedTrainArmyTroopCount[$i], $GUI_SHOW)
	Next
	SetRankedBtnSelector("ElixirTroops")
EndFunc

Func BtnRankedDarkElixirTroops()
	; Hide all troops, spells, and sieges first
	For $i = 0 To $eTroopCount - 1
		If $g_ahPicRankedTrainArmyTroop[$i] <> 0 Then GUICtrlSetState($g_ahPicRankedTrainArmyTroop[$i], $GUI_HIDE)
		If $g_ahTxtRankedTrainArmyTroopCount[$i] <> 0 Then GUICtrlSetState($g_ahTxtRankedTrainArmyTroopCount[$i], $GUI_HIDE)
	Next
	For $i = 0 To $eSpellCount - 1
		If $g_ahPicRankedTrainArmySpell[$i] <> 0 Then GUICtrlSetState($g_ahPicRankedTrainArmySpell[$i], $GUI_HIDE)
		If $g_ahTxtRankedTrainArmySpellCount[$i] <> 0 Then GUICtrlSetState($g_ahTxtRankedTrainArmySpellCount[$i], $GUI_HIDE)
	Next
	For $i = 0 To $eSiegeMachineCount - 1
		If $g_ahPicRankedTrainArmySiege[$i] <> 0 Then GUICtrlSetState($g_ahPicRankedTrainArmySiege[$i], $GUI_HIDE)
		If $g_ahTxtRankedTrainArmySiegeCount[$i] <> 0 Then GUICtrlSetState($g_ahTxtRankedTrainArmySiegeCount[$i], $GUI_HIDE)
	Next
	
	; Show only dark elixir troops ($eTroopMinion to $eTroopDruid)
	For $i = $eTroopMinion To $eTroopDruid
		If $g_ahPicRankedTrainArmyTroop[$i] <> 0 Then GUICtrlSetState($g_ahPicRankedTrainArmyTroop[$i], $GUI_SHOW)
		If $g_ahTxtRankedTrainArmyTroopCount[$i] <> 0 Then GUICtrlSetState($g_ahTxtRankedTrainArmyTroopCount[$i], $GUI_SHOW)
	Next
	SetRankedBtnSelector("DarkElixirTroops")
EndFunc

Func BtnRankedSuperTroops()
	; Hide all troops, spells, and sieges first
	For $i = 0 To $eTroopCount - 1
		If $g_ahPicRankedTrainArmyTroop[$i] <> 0 Then GUICtrlSetState($g_ahPicRankedTrainArmyTroop[$i], $GUI_HIDE)
		If $g_ahTxtRankedTrainArmyTroopCount[$i] <> 0 Then GUICtrlSetState($g_ahTxtRankedTrainArmyTroopCount[$i], $GUI_HIDE)
	Next
	For $i = 0 To $eSpellCount - 1
		If $g_ahPicRankedTrainArmySpell[$i] <> 0 Then GUICtrlSetState($g_ahPicRankedTrainArmySpell[$i], $GUI_HIDE)
		If $g_ahTxtRankedTrainArmySpellCount[$i] <> 0 Then GUICtrlSetState($g_ahTxtRankedTrainArmySpellCount[$i], $GUI_HIDE)
	Next
	For $i = 0 To $eSiegeMachineCount - 1
		If $g_ahPicRankedTrainArmySiege[$i] <> 0 Then GUICtrlSetState($g_ahPicRankedTrainArmySiege[$i], $GUI_HIDE)
		If $g_ahTxtRankedTrainArmySiegeCount[$i] <> 0 Then GUICtrlSetState($g_ahTxtRankedTrainArmySiegeCount[$i], $GUI_HIDE)
	Next
	
	; Show only super troops ($eTroopSBarb to $eTroopFurnace)
	For $i = $eTroopSBarb To $eTroopFurnace
		If $g_ahPicRankedTrainArmyTroop[$i] <> 0 Then GUICtrlSetState($g_ahPicRankedTrainArmyTroop[$i], $GUI_SHOW)
		If $g_ahTxtRankedTrainArmyTroopCount[$i] <> 0 Then GUICtrlSetState($g_ahTxtRankedTrainArmyTroopCount[$i], $GUI_SHOW)
	Next
	SetRankedBtnSelector("SuperTroops")
EndFunc

Func BtnRankedSpells()
	; Hide all troops, spells, and sieges first
	For $i = 0 To $eTroopCount - 1
		If $g_ahPicRankedTrainArmyTroop[$i] <> 0 Then GUICtrlSetState($g_ahPicRankedTrainArmyTroop[$i], $GUI_HIDE)
		If $g_ahTxtRankedTrainArmyTroopCount[$i] <> 0 Then GUICtrlSetState($g_ahTxtRankedTrainArmyTroopCount[$i], $GUI_HIDE)
	Next
	For $i = 0 To $eSpellCount - 1
		If $g_ahPicRankedTrainArmySpell[$i] <> 0 Then GUICtrlSetState($g_ahPicRankedTrainArmySpell[$i], $GUI_HIDE)
		If $g_ahTxtRankedTrainArmySpellCount[$i] <> 0 Then GUICtrlSetState($g_ahTxtRankedTrainArmySpellCount[$i], $GUI_HIDE)
	Next
	For $i = 0 To $eSiegeMachineCount - 1
		If $g_ahPicRankedTrainArmySiege[$i] <> 0 Then GUICtrlSetState($g_ahPicRankedTrainArmySiege[$i], $GUI_HIDE)
		If $g_ahTxtRankedTrainArmySiegeCount[$i] <> 0 Then GUICtrlSetState($g_ahTxtRankedTrainArmySiegeCount[$i], $GUI_HIDE)
	Next
	
	; Show all spells
	For $i = 0 To $eSpellCount - 1
		If $g_ahPicRankedTrainArmySpell[$i] <> 0 Then GUICtrlSetState($g_ahPicRankedTrainArmySpell[$i], $GUI_SHOW)
		If $g_ahTxtRankedTrainArmySpellCount[$i] <> 0 Then GUICtrlSetState($g_ahTxtRankedTrainArmySpellCount[$i], $GUI_SHOW)
	Next
	SetRankedBtnSelector("Spells")
EndFunc

Func BtnRankedSieges()
	; Hide all troops, spells, and sieges first
	For $i = 0 To $eTroopCount - 1
		If $g_ahPicRankedTrainArmyTroop[$i] <> 0 Then GUICtrlSetState($g_ahPicRankedTrainArmyTroop[$i], $GUI_HIDE)
		If $g_ahTxtRankedTrainArmyTroopCount[$i] <> 0 Then GUICtrlSetState($g_ahTxtRankedTrainArmyTroopCount[$i], $GUI_HIDE)
	Next
	For $i = 0 To $eSpellCount - 1
		If $g_ahPicRankedTrainArmySpell[$i] <> 0 Then GUICtrlSetState($g_ahPicRankedTrainArmySpell[$i], $GUI_HIDE)
		If $g_ahTxtRankedTrainArmySpellCount[$i] <> 0 Then GUICtrlSetState($g_ahTxtRankedTrainArmySpellCount[$i], $GUI_HIDE)
	Next
	For $i = 0 To $eSiegeMachineCount - 1
		If $g_ahPicRankedTrainArmySiege[$i] <> 0 Then GUICtrlSetState($g_ahPicRankedTrainArmySiege[$i], $GUI_HIDE)
		If $g_ahTxtRankedTrainArmySiegeCount[$i] <> 0 Then GUICtrlSetState($g_ahTxtRankedTrainArmySiegeCount[$i], $GUI_HIDE)
	Next
	
	; Show all sieges
	For $i = 0 To $eSiegeMachineCount - 1
		If $g_ahPicRankedTrainArmySiege[$i] <> 0 Then GUICtrlSetState($g_ahPicRankedTrainArmySiege[$i], $GUI_SHOW)
		If $g_ahTxtRankedTrainArmySiegeCount[$i] <> 0 Then GUICtrlSetState($g_ahTxtRankedTrainArmySiegeCount[$i], $GUI_SHOW)
	Next
	SetRankedBtnSelector("Sieges")
EndFunc

Func tabRankedTrainType()
	; Handle switching between Custom Train and Quick Train tabs
	Local $tabidx = GUICtrlRead($g_hGUI_RANKED_TRAINTYPE_TAB)
	; Tab switching is handled automatically by AutoIt
EndFunc

Func chkRankedUseHeroes()
	; Save hero usage settings
	$g_bRankedUseKing = (GUICtrlRead($g_hChkRankedKingAttack) = $GUI_CHECKED)
	$g_bRankedUseQueen = (GUICtrlRead($g_hChkRankedQueenAttack) = $GUI_CHECKED)
	$g_bRankedUsePrince = (GUICtrlRead($g_hChkRankedPrinceAttack) = $GUI_CHECKED)
	$g_bRankedUseWarden = (GUICtrlRead($g_hChkRankedWardenAttack) = $GUI_CHECKED)
	$g_bRankedUseChampion = (GUICtrlRead($g_hChkRankedChampionAttack) = $GUI_CHECKED)
	SaveConfig()
EndFunc

; Duplicate functions removed - these are defined earlier in the file

Func cmbRankedSelectTroop()
	; Save selected troop mode
	Local $iIndex = _GUICtrlComboBox_GetCurSel($g_hCmbRankedSelectTroop)
	$g_iRankedSelectTroopMode = $iIndex
	SetLog("Ranked Troop Selection: " & GUICtrlRead($g_hCmbRankedSelectTroop), $COLOR_INFO)
	SaveConfig()
EndFunc

Func cmbRankedWardenMode()
	; Save selected warden mode
	Local $iIndex = _GUICtrlComboBox_GetCurSel($g_hCmbRankedWardenMode)
	$g_iRankedWardenMode = $iIndex
	SetLog("Ranked Warden Mode: " & GUICtrlRead($g_hCmbRankedWardenMode), $COLOR_INFO)
	SaveConfig()
EndFunc

Func cmbRankedAttackType()
	; Save selected attack type
	Local $iIndex = _GUICtrlComboBox_GetCurSel($g_hCmbRankedAttackType)
	$g_iRankedAttackType = $iIndex
	SetLog("Ranked Attack Type: " & GUICtrlRead($g_hCmbRankedAttackType), $COLOR_INFO)
	SaveConfig()
EndFunc

Func cmbRankedSiege()
	; Save selected siege machine
	Local $iIndex = _GUICtrlComboBox_GetCurSel($g_hCmbRankedSiege)
	$g_iRankedSiegeMachine = $iIndex
	SetLog("Ranked Siege Machine: " & GUICtrlRead($g_hCmbRankedSiege), $COLOR_INFO)
	SaveConfig()
EndFunc

; Duplicate functions removed - these are defined earlier in the file

Func RemoveRankedCamp()
	; Reset all ranked army composition
	SetLog("Resetting Ranked Army composition", $COLOR_INFO)
	
	; Reset troops
	For $i = 0 To 6
		If $g_ahTxtRankedTrainArmyTroopCount[$i] <> 0 Then
			GUICtrlSetData($g_ahTxtRankedTrainArmyTroopCount[$i], "0")
			$g_aiRankedArmyComp[$i] = 0
		EndIf
	Next
	
	; Reset spells
	For $i = 0 To 6
		If $g_ahTxtRankedTrainArmySpellCount[$i] <> 0 Then
			GUICtrlSetData($g_ahTxtRankedTrainArmySpellCount[$i], "0")
			$g_aiRankedSpellComp[$i] = 0
		EndIf
	Next
	
	; Reset sieges
	For $i = 0 To 2
		If $g_ahTxtRankedTrainArmySiegeCount[$i] <> 0 Then
			GUICtrlSetData($g_ahTxtRankedTrainArmySiegeCount[$i], "0")
			$g_aiRankedSiegeComp[$i] = 0
		EndIf
	Next
	
	; Update displays
	lblRankedTotalCountTroop()
	lblRankedTotalCountSpell()
	lblRankedTotalCountSiege()
EndFunc

Func chkRankedTotalCampForced()
	; Handle force camp checkbox
	If GUICtrlRead($g_hChkRankedTotalCampForced) = $GUI_CHECKED Then
		GUICtrlSetState($g_hTxtRankedTotalCampForced, $GUI_ENABLE)
	Else
		GUICtrlSetState($g_hTxtRankedTotalCampForced, $GUI_DISABLE)
	EndIf
	SaveConfig()
EndFunc

Func ChkRankedDoubleTrain()
	$g_bRankedDoubleTrain = (GUICtrlRead($g_hChkRankedDoubleTrain) = $GUI_CHECKED)
	SetLog("Ranked Double Train: " & ($g_bRankedDoubleTrain ? "Enabled" : "Disabled"), $COLOR_INFO)
	SaveConfig()
EndFunc

Func ChkRankedPreciseArmy()
	$g_bRankedPreciseArmy = (GUICtrlRead($g_hChkRankedPreciseArmy) = $GUI_CHECKED)
	SetLog("Ranked Precise Army: " & ($g_bRankedPreciseArmy ? "Enabled" : "Disabled"), $COLOR_INFO)
	SaveConfig()
EndFunc

Func chkRankedUseInGameArmy1()
	Local $bUseInGame = (GUICtrlRead($g_ahChkRankedUseInGameArmy[0]) = $GUI_CHECKED)
	$g_abRankedUseInGameArmy[0] = $bUseInGame
	; Toggle visibility
	Local $iState = $bUseInGame ? $GUI_HIDE : $GUI_SHOW
	For $j = $g_ahPicRankedQuickTroop[0][0] To $g_ahLblRankedQuickSpell[0][6]
		GUICtrlSetState($j, $iState)
	Next
	GUICtrlSetState($g_ahLblRankedQuickTrainNote[0], $bUseInGame ? $GUI_HIDE : $GUI_SHOW)
	GUICtrlSetState($g_ahLblRankedUseInGameArmyNote[0], $bUseInGame ? $GUI_SHOW : $GUI_HIDE)
	SaveConfig()
EndFunc

Func chkRankedUseInGameArmy2()
	Local $bUseInGame = (GUICtrlRead($g_ahChkRankedUseInGameArmy[1]) = $GUI_CHECKED)
	$g_abRankedUseInGameArmy[1] = $bUseInGame
	; Toggle visibility
	Local $iState = $bUseInGame ? $GUI_HIDE : $GUI_SHOW
	For $j = $g_ahPicRankedQuickTroop[1][0] To $g_ahLblRankedQuickSpell[1][6]
		GUICtrlSetState($j, $iState)
	Next
	GUICtrlSetState($g_ahLblRankedQuickTrainNote[1], $bUseInGame ? $GUI_HIDE : $GUI_SHOW)
	GUICtrlSetState($g_ahLblRankedUseInGameArmyNote[1], $bUseInGame ? $GUI_SHOW : $GUI_HIDE)
	SaveConfig()
EndFunc

Func chkRankedUseInGameArmy3()
	Local $bUseInGame = (GUICtrlRead($g_ahChkRankedUseInGameArmy[2]) = $GUI_CHECKED)
	$g_abRankedUseInGameArmy[2] = $bUseInGame
	; Toggle visibility
	Local $iState = $bUseInGame ? $GUI_HIDE : $GUI_SHOW
	For $j = $g_ahPicRankedQuickTroop[2][0] To $g_ahLblRankedQuickSpell[2][6]
		GUICtrlSetState($j, $iState)
	Next
	GUICtrlSetState($g_ahLblRankedQuickTrainNote[2], $bUseInGame ? $GUI_HIDE : $GUI_SHOW)
	GUICtrlSetState($g_ahLblRankedUseInGameArmyNote[2], $bUseInGame ? $GUI_SHOW : $GUI_HIDE)
	SaveConfig()
EndFunc

Func UpdateRankedTrainButtonColor()
	; Update button colors based on army status
	; This function updates visual indicators for the army composition
	; Can be expanded to show when army is ready, full, etc.
	Local $iTotalTroops = 0
	Local $iTotalSpells = 0
	
	; Calculate totals
	For $i = 0 To $eTroopCount - 1
		If $g_aiRankedArmyComp[$i] > 0 Then
			$iTotalTroops += $g_aiRankedArmyComp[$i] * $g_aiTroopSpace[$i]
		EndIf
	Next
	
	For $i = 0 To $eSpellCount - 1
		If $g_aiRankedSpellComp[$i] > 0 Then
			$iTotalSpells += $g_aiRankedSpellComp[$i] * $g_aiSpellSpace[$i]
		EndIf
	Next
	
	; Update any visual indicators if needed
	; This is a placeholder that can be expanded
EndFunc