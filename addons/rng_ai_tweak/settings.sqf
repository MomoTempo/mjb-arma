[	"RNG_disableAccuracy",
	"CHECKBOX",
	["Disable RNG Accuracy","Disables artificial MoA applied to AI shots."],
	["RNG","MJB Tweaks"],
	true,
	true,
	{},
	true
] call CBA_fnc_addSetting;

[	"RNG_dontKnowsAbout",
	"CHECKBOX",
	["Prevent LoS-less knowledge","Caps knowsAbout when out of direct Line of Sight."],
	["RNG","MJB Tweaks"],
	false,
	true,
	{},
	true
] call CBA_fnc_addSetting;

[	"RNG_dontKnowsCap",
	"SLIDER",
	["Max LoS-less knowledge","Cap for knowsAbout when out of direct Line of Sight."],
	["RNG","MJB Tweaks"],
	[0,4,1,2],
	true
] call CBA_fnc_addSetting;

[	"RNG_minVisTarget",
	"SLIDER",
	["Minimum Visibility to Target","Visiblility threshold for knowsAbout limiting and engaging the target. Lower numbers more likely to target through smoke."],
	["RNG","MJB Tweaks"],
	[0,1,0.05,2],
	true
] call CBA_fnc_addSetting;

[	"RNG_allyReactChance",
	"SLIDER",
	["React to Allies Chance","Chance for AI to react to nearby allies firing."],
	["RNG","MJB Tweaks"],
	[0,1,0,3],
	true
] call CBA_fnc_addSetting;

[	"RNG_allyCD",
	"CHECKBOX",
	["Enable Ally CD","Triggers RNG Cooldown when ally shots are ignored."],
	["RNG","MJB Tweaks"],
	false,
	true
] call CBA_fnc_addSetting;

/*/Vcom
[	"Vcm_Debug",
	"CHECKBOX",
	["VCOM Debug","Shows debug for vcom functions."],
	["RNG","VCOM"],
	false,
	true
] call CBA_fnc_addSetting;

[	"Vcm_AI_EM_CHN",
	"SLIDER",
	["Chance Groups use EM","Chance for AI to decide to use EM."],
	["RNG","VCOM"],
	[0,100,0,0],
	true
] call CBA_fnc_addSetting;

[	"VCM_AI_EM_CLDWN",
	"SLIDER",
	["Cooldown for EM use","Seconds before AI groups can decide to use EM again."],
	["RNG","VCOM"],
	[15,6000,300,0],
	true
] call CBA_fnc_addSetting;
//*/