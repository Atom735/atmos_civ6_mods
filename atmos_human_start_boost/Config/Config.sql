-- Atmos Human Start Boost: Advanced Setup options (human players only).

INSERT INTO DomainRanges
		(Domain,					MinimumValue,	MaximumValue)
VALUES	('ATM_HSB_SIGHT_RANGE',		0,				10),
		('ATM_HSB_MOVES_RANGE',		0,				10),
		('ATM_HSB_UNIT_RANGE',		0,				10);

INSERT INTO Parameters
		(ParameterId,				Name,							Description,						Domain,					DefaultValue,	ConfigurationGroup,	ConfigurationId,		GroupId,			SortIndex)
VALUES	('ATM_HSB_SIGHT',			'LOC_ATM_HSB_SIGHT_NAME',		'LOC_ATM_HSB_SIGHT_DESC',		'ATM_HSB_SIGHT_RANGE',	2,				'Game',				'ATM_HSB_SIGHT',		'AdvancedOptions',	3100),
		('ATM_HSB_MOVES',			'LOC_ATM_HSB_MOVES_NAME',		'LOC_ATM_HSB_MOVES_DESC',		'ATM_HSB_MOVES_RANGE',	2,				'Game',				'ATM_HSB_MOVES',		'AdvancedOptions',	3110),
		('ATM_HSB_SETTLER',			'LOC_ATM_HSB_SETTLER_NAME',		'LOC_ATM_HSB_SETTLER_DESC',		'ATM_HSB_UNIT_RANGE',	1,				'Game',				'ATM_HSB_SETTLER',		'AdvancedOptions',	3120),
		('ATM_HSB_BUILDER',			'LOC_ATM_HSB_BUILDER_NAME',		'LOC_ATM_HSB_BUILDER_DESC',		'ATM_HSB_UNIT_RANGE',	1,				'Game',				'ATM_HSB_BUILDER',		'AdvancedOptions',	3130),
		('ATM_HSB_WARRIOR',			'LOC_ATM_HSB_WARRIOR_NAME',		'LOC_ATM_HSB_WARRIOR_DESC',		'ATM_HSB_UNIT_RANGE',	0,				'Game',				'ATM_HSB_WARRIOR',		'AdvancedOptions',	3140),
		('ATM_HSB_SCOUT',			'LOC_ATM_HSB_SCOUT_NAME',		'LOC_ATM_HSB_SCOUT_DESC',		'ATM_HSB_UNIT_RANGE',	2,				'Game',				'ATM_HSB_SCOUT',		'AdvancedOptions',	3150);
