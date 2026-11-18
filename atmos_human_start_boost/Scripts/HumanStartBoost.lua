-- Atmos Human Start Boost
-- One configurable replacement for:
--   Extra Starting Settler (Human Players Only)
--   Sight Enhance
--   Move +2 (Human Only)
--   Player's first settler grants +N movement and +N Sight
-- Disable those Workshop mods to avoid stacking.

local PROP_START_DONE = "ATM_HSB_START_UNITS_DONE"
local ABILITY_SIGHT = "ABILITY_ATM_HSB_EXTRA_SIGHT"
local ABILITY_MOVES = "ABILITY_ATM_HSB_EXTRA_MOVES"

local DEFAULTS = {
	ATM_HSB_SIGHT = 2,
	ATM_HSB_MOVES = 2,
	ATM_HSB_SETTLER = 1,
	ATM_HSB_BUILDER = 1,
	ATM_HSB_WARRIOR = 0,
	ATM_HSB_SCOUT = 2,
}

local START_UNITS = {
	{ config = "ATM_HSB_SETTLER", unitType = "UNIT_SETTLER" },
	{ config = "ATM_HSB_BUILDER", unitType = "UNIT_BUILDER" },
	{ config = "ATM_HSB_WARRIOR", unitType = "UNIT_WARRIOR" },
	{ config = "ATM_HSB_SCOUT", unitType = "UNIT_SCOUT" },
}

local function ConfigInt(key)
	local value = GameConfiguration.GetValue(key)
	if value == nil then
		return DEFAULTS[key] or 0
	end
	local number = tonumber(value)
	if number == nil then
		return DEFAULTS[key] or 0
	end
	return number
end

local function IsHumanPlayer(playerID)
	local player = Players[playerID]
	return player ~= nil and player:IsMajor() and player:IsHuman()
end

-- Use civ unique replacements (e.g. Cree Scout -> Okihtcitaw).
local function PlayerHasTrait(playerID, traitType)
	local playerConfig = PlayerConfigurations[playerID]
	if playerConfig == nil or traitType == nil then
		return false
	end

	local civType = playerConfig:GetCivilizationTypeName()
	local leaderType = playerConfig:GetLeaderTypeName()

	for row in GameInfo.CivilizationTraits() do
		if row.CivilizationType == civType and row.TraitType == traitType then
			return true
		end
	end

	for row in GameInfo.LeaderTraits() do
		if row.LeaderType == leaderType and row.TraitType == traitType then
			return true
		end
	end

	return false
end

local function ResolveUnitType(playerID, baseUnitType)
	if GameInfo.UnitReplaces == nil then
		return baseUnitType
	end

	for row in GameInfo.UnitReplaces() do
		if row.ReplacesUnitType == baseUnitType then
			local uniqueInfo = GameInfo.Units[row.CivUniqueUnitType]
			if uniqueInfo ~= nil and PlayerHasTrait(playerID, uniqueInfo.TraitType) then
				return row.CivUniqueUnitType
			end
		end
	end

	return baseUnitType
end

local function GetAbilityIndex(abilityType)
	local info = GameInfo.UnitAbilities[abilityType]
	if info == nil then
		return nil
	end
	return info.Index
end

local function SetAbilityStacks(unit, abilityType, desired)
	local abilityIndex = GetAbilityIndex(abilityType)
	if abilityIndex == nil or desired < 0 then
		return
	end

	local unitAbility = unit:GetAbility()
	if unitAbility == nil then
		return
	end

	local current = unitAbility:GetAbilityCount(abilityIndex) or 0
	if current ~= desired then
		unitAbility:ChangeAbilityCount(abilityIndex, desired - current)
	end
end

local function ApplyUnitBonuses(playerID, unitID)
	if not IsHumanPlayer(playerID) then
		return
	end

	local unit = UnitManager.GetUnit(playerID, unitID)
	if unit == nil then
		return
	end

	SetAbilityStacks(unit, ABILITY_SIGHT, ConfigInt("ATM_HSB_SIGHT"))
	SetAbilityStacks(unit, ABILITY_MOVES, ConfigInt("ATM_HSB_MOVES"))
end

local function ApplyBonusesToPlayerUnits(playerID)
	if not IsHumanPlayer(playerID) then
		return
	end

	local player = Players[playerID]
	local units = player:GetUnits()
	if units == nil then
		return
	end

	for _, unit in units:Members() do
		if unit ~= nil then
			ApplyUnitBonuses(playerID, unit:GetID())
		end
	end
end

local function SpawnStartUnitsForPlayer(playerID)
	if not IsHumanPlayer(playerID) then
		return
	end

	local player = Players[playerID]
	local startPlot = player:GetStartingPlot()
	if startPlot == nil then
		print("ATM_HSB: no starting plot for player " .. tostring(playerID))
		return
	end

	local x = startPlot:GetX()
	local y = startPlot:GetY()

	for _, entry in ipairs(START_UNITS) do
		local count = ConfigInt(entry.config)
		if count > 0 then
			local unitType = ResolveUnitType(playerID, entry.unitType)
			for _ = 1, count do
				UnitManager.InitUnitValidAdjacentHex(playerID, unitType, x, y, 1)
			end
			print("ATM_HSB: spawned " .. tostring(count) .. " x " .. unitType
				.. " (base " .. entry.unitType .. ") for player " .. tostring(playerID))
		end
	end
end

local function OnUnitAddedToMap(playerID, unitID)
	ApplyUnitBonuses(playerID, unitID)
end

local function OnUnitUpgraded(playerID, unitID)
	ApplyUnitBonuses(playerID, unitID)
end

local function OnLoadScreenClose()
	if Game:GetProperty(PROP_START_DONE) == 1 then
		for _, playerID in ipairs(PlayerManager.GetAliveMajorIDs()) do
			ApplyBonusesToPlayerUnits(playerID)
		end
		return
	end

	Game:SetProperty(PROP_START_DONE, 1)

	for _, playerID in ipairs(PlayerManager.GetAliveMajorIDs()) do
		SpawnStartUnitsForPlayer(playerID)
		ApplyBonusesToPlayerUnits(playerID)
	end

	print("ATM_HSB: start boost applied (sight=" .. tostring(ConfigInt("ATM_HSB_SIGHT"))
		.. ", moves=" .. tostring(ConfigInt("ATM_HSB_MOVES"))
		.. ", settler=" .. tostring(ConfigInt("ATM_HSB_SETTLER"))
		.. ", builder=" .. tostring(ConfigInt("ATM_HSB_BUILDER"))
		.. ", warrior=" .. tostring(ConfigInt("ATM_HSB_WARRIOR"))
		.. ", scout=" .. tostring(ConfigInt("ATM_HSB_SCOUT")) .. ")")
end

Events.UnitAddedToMap.Add(OnUnitAddedToMap)
Events.UnitUpgraded.Add(OnUnitUpgraded)
Events.LoadScreenClose.Add(OnLoadScreenClose)

print("ATM_HSB: HumanStartBoost.lua loaded")
