[	"RNG_disableAccuracy",
	"CHECKBOX",
	["Disable RNG Accuracy","Disables artificial MoA applied to AI shots."],
	["RNG","MJB Tweaks"],
	true,
	true,
	{},
	true
] call CBA_fnc_addSetting;

[	"RNG_allyReactChance",
	"SLIDER",
	["React to Allies Chance","Chance for AI to react to nearby allies firing."],
	["RNG","MJB Tweaks"],
	[0,1,0,3],
	true,
	{}
] call CBA_fnc_addSetting;

[	"RNG_allyCD",
	"CHECKBOX",
	["Enable Ally CD","Triggers RNG Cooldown when ally shots are ignored."],
	["RNG","MJB Tweaks"],
	false,
	true
] call CBA_fnc_addSetting;