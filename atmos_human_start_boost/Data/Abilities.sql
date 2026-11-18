-- Stackable +1 sight / +1 movement abilities.
-- Granted only to human units via Lua (configurable stack count).
-- Replaces: Sight Enhance, Move +2 (Human Only), First Settler sight/moves, etc.

INSERT INTO Types
		(Type,							Kind)
VALUES	('ABILITY_ATM_HSB_EXTRA_SIGHT',	'KIND_ABILITY'),
		('ABILITY_ATM_HSB_EXTRA_MOVES',	'KIND_ABILITY');

INSERT INTO TypeTags
		(Type,							Tag)
VALUES	('ABILITY_ATM_HSB_EXTRA_SIGHT',	'CLASS_ALL_UNITS'),
		('ABILITY_ATM_HSB_EXTRA_MOVES',	'CLASS_ALL_UNITS');

INSERT INTO UnitAbilities
		(UnitAbilityType,				Name,									Description,								Inactive,	Permanent)
VALUES	('ABILITY_ATM_HSB_EXTRA_SIGHT',	'LOC_ABILITY_ATM_HSB_EXTRA_SIGHT_NAME',	'LOC_ABILITY_ATM_HSB_EXTRA_SIGHT_DESC',	1,			1),
		('ABILITY_ATM_HSB_EXTRA_MOVES',	'LOC_ABILITY_ATM_HSB_EXTRA_MOVES_NAME',	'LOC_ABILITY_ATM_HSB_EXTRA_MOVES_DESC',	1,			1);

INSERT INTO UnitAbilityModifiers
		(UnitAbilityType,				ModifierId)
VALUES	('ABILITY_ATM_HSB_EXTRA_SIGHT',	'ATM_HSB_EXTRA_SIGHT_MODIFIER'),
		('ABILITY_ATM_HSB_EXTRA_MOVES',	'ATM_HSB_EXTRA_MOVES_MODIFIER');

INSERT INTO Modifiers
		(ModifierId,					ModifierType)
VALUES	('ATM_HSB_EXTRA_SIGHT_MODIFIER','MODIFIER_PLAYER_UNIT_ADJUST_SIGHT'),
		('ATM_HSB_EXTRA_MOVES_MODIFIER','MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT');

INSERT INTO ModifierArguments
		(ModifierId,					Name,		Value)
VALUES	('ATM_HSB_EXTRA_SIGHT_MODIFIER','Amount',	'1'),
		('ATM_HSB_EXTRA_MOVES_MODIFIER','Amount',	'1');
