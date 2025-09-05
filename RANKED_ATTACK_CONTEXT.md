# MyBot-MBR v8.2.0 - Ranked Attack System Implementation Context

## Project Overview
MyBot-MBR is a Clash of Clans automation bot written in AutoIt3. The project automates gameplay including farming, attacking, training troops, and resource management.

## Major Feature Implementation: Ranked Attack System

### Feature Requirements
- **Dual Attack System**: Normal attacks (existing) and Ranked attacks (new)
- **Ranked Mode Constraints**:
  - Maximum 6 attacks per day
  - Daily reset at 7 AM
  - No base searching (must attack first base found)
  - Separate army configurations from normal mode
  - Prioritized execution (ranked attacks before normal attacks)

### Key Files Modified/Created

#### 1. Core Implementation Files

**COCBot/functions/Attack/RankedAttack.au3** (Created)
- Main ranked attack implementation
- Functions:
  - `ExecuteRankedAttack()` - Main attack execution
  - `CheckRankedDailyReset()` - Handles 7 AM reset
  - `CheckRankedArmyReady()` - Validates army readiness
  - `UpdateRankedAttackStats()` - Updates statistics
  - `IsRankedAttackAvailable()` - Checks if attacks remaining

**MyBot.run.au3** (Modified - Lines 870-927)
- Added ranked attack prioritization logic
- Ensures ranked attacks execute before normal attacks
- Integration point for the ranked system

#### 2. GUI Implementation Files

**COCBot/GUI/MBR GUI Design Child Attack - Ranked.au3** (Created)
- Complete GUI implementation for ranked settings
- Major sections:
  - Lines 1-150: Tab creation and status display
  - Lines 151-300: Train Army tab with troop/spell/siege selection
  - Lines 301-500: Attack Settings tab
  - Lines 501-600: Options tab with consecutive attack settings
  - Lines 936-1051: Button functions for troop category switching
  - Lines 1078-1101: Dropdown event handlers

Key Functions:
- `CreateAttackSearchRanked()` - Main GUI creation
- `HideAllRankedTroops()` - Hides all troop/spell/siege controls
- `SetRankedBtnSelector()` - Highlights selected category button
- `BtnRankedElixirTroops/DarkElixirTroops/SuperTroops/Spells/Sieges()` - Category switchers
- `lblRankedTotalCountTroop/Spell/Siege()` - Space calculators
- `cmbRankedAlgorithm/SelectTroop/WardenMode/AttackType/Siege()` - Dropdown handlers

#### 3. Global Variables and Configuration

**COCBot/MBR Global Variables.au3** (Modified - Lines 620-690)
Key Variables Added:
```autoit
; Core Ranked Variables
Global $g_bRankedModeEnabled = False
Global $g_iRankedAttacksRemaining = 6
Global $g_iRankedAttacksToday = 0
Global $g_iLastRankedResetDay = -1

; Army Composition Arrays (declared after troop/spell enums)
Global $g_aiRankedArmyComp[$eTroopCount]
Global $g_aiRankedSpellComp[$eSpellCount]
Global $g_aiRankedSiegeComp[$eSiegeMachineCount]

; GUI Control Handles
Global $g_ahPicRankedTrainArmyTroop[$eTroopCount]
Global $g_ahTxtRankedTrainArmyTroopCount[$eTroopCount]
Global $g_ahPicRankedTrainArmySpell[$eSpellCount]
Global $g_ahTxtRankedTrainArmySpellCount[$eSpellCount]
Global $g_ahPicRankedTrainArmySiege[$eSiegeMachineCount]
Global $g_ahTxtRankedTrainArmySiegeCount[$eSiegeMachineCount]

; Settings
Global $g_iRankedWardenMode = 2 ; 0=Ground, 1=Air, 2=Default
Global $g_iRankedAttackType = 1 ; 0=All Out, 1=Smart Deploy, 2=Trophy Push
Global $g_iRankedAttackAlgorithm = 0
Global $g_iRankedSelectTroopMode = 0
Global $g_iRankedSiegeMachine = 0
```

**COCBot/MBR GUI Control.au3** (Modified - Line 1847)
- Added `tabRanked()` function for tab switching

#### 4. Supporting Files

**COCBot/GUI/MBR GUI Design Child Attack - Troops.au3**
- Contains icon arrays: `$g_aQuickTroopIcon`, `$g_aQuickSpellIcon`
- Reference for troop space calculations: `$g_aiTroopSpace`

**COCBot/GUI/MBR GUI Control Child Army.au3**
- Reference implementation for normal mode army controls
- Functions like `HideAllTroops()`, `SetBtnSelector()` served as templates

## Key Technical Implementations

### 1. Hide/Show Mechanism (Fixed Issue #1)
- Problem: Controls were being repositioned causing wrong troops to be selected
- Solution: Implemented hide/show mechanism similar to normal mode
- Controls maintain fixed positions, only visibility changes

### 2. Icon Management (Fixed Issue #2)
- All troop/spell icons properly assigned during control creation
- Uses `$g_aQuickTroopIcon` and `$g_aQuickSpellIcon` arrays

### 3. Troop Space Calculations
```autoit
For $i = 0 To $eTroopCount - 1
    Local $iCount = $g_aiRankedArmyComp[$i]
    If $iCount > 0 Then
        $TotalTroopsToTrain += $iCount * $g_aiTroopSpace[$i]
    EndIf
Next
```

### 4. Daily Reset Logic
```autoit
Func CheckRankedDailyReset()
    Local $currentHour = @HOUR
    Local $currentDay = @YDAY
    If $currentHour >= 7 And $g_iLastRankedResetDay <> $currentDay Then
        $g_iRankedAttacksRemaining = 6
        $g_iRankedAttacksToday = 0
        $g_iLastRankedResetDay = $currentDay
    EndIf
EndFunc
```

### 5. Attack Prioritization
Located in MyBot.run.au3:
- Checks if ranked attacks available before normal attacks
- Ensures ranked army is ready
- Executes ranked attack without village search

## Common Issues and Solutions

### Compilation Errors Fixed:
1. **Variable Declaration Order**: Arrays depending on enums must be declared after the enums
2. **Missing Constants**: Added `$COLOR_ORANGE = 0xFFA500`
3. **Duplicate Functions**: Removed duplicate `SetRankedComboTroopComp()`
4. **Typos**: Fixed `$eTroopInfernoD` to `$eTroopInfernoDragon`

### GUI Issues Fixed:
1. **Tab Visibility**: Fixed tab switching in `MBR GUI Control.au3`
2. **Control Positioning**: Used fixed positions instead of dynamic repositioning
3. **Event Handlers**: Added all missing dropdown and button handlers

## Testing Checklist
- [ ] Ranked tab appears in Attack Plan
- [ ] Train Army tab shows correct troops when switching categories
- [ ] Attack Settings dropdowns save values correctly
- [ ] Daily reset occurs at 7 AM
- [ ] Attack counter decrements properly
- [ ] Ranked attacks execute before normal attacks
- [ ] Army space calculations are accurate
- [ ] Quick train armies can be selected

## Future Enhancements
1. Add ranked attack statistics tracking
2. Implement quick army editor for ranked mode
3. Add ranked attack logs
4. Create ranked-specific deployment strategies
5. Add notification system for daily reset

## AutoIt3 Compilation
The project uses AutoIt3 scripting language. Main entry point is `MyBot.run.au3`.
Do NOT attempt to compile using AutoIt3Wrapper command directly - use the project's build system.

## Important Notes
- The bot interacts with the game using image recognition (OpenCV)
- All GUI controls use event-driven programming model
- Config is saved/loaded using INI files
- The project follows Hungarian notation for variables (g_ for global, h for handles)
- Always test changes thoroughly as the bot interacts with a live game

## Session Summary
In this implementation session, we:
1. Created a complete ranked attack system from scratch
2. Fixed 39+ compilation errors
3. Resolved GUI control positioning issues
4. Implemented proper hide/show mechanism for troop selection
5. Added all necessary event handlers and global variables
6. Ensured proper integration with existing bot systems

The ranked attack feature is now fully implemented and ready for testing.