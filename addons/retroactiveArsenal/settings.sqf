private _title = "MJB Arma";

[
    "mjb_duiCustomTag",
    "EDITBOX",
    ["Pronouns/DUI Custom tag", "Sets custom text shown below your name and group in the DUI name tag."],
    [_title, "Player QoL"],
    "",
    false,
	{	params ['_value'];
		if (!isNull player) then { player setVariable ['diwako_dui_nametags_customInfo', _value, true]; };
	}
] call CBA_fnc_addSetting;
[
    "mjb_duiCustomTagClr",
    "COLOR",
    ["Pronouns/DUI Custom tag Color", "Sets color of custom text shown below your name and group in the DUI name tag."],
    [_title, "Player QoL"],
    [0, 0, 0],
    false,
	{
		if (isNull player || {_this isEqualTo [0,0,0]}) exitWith {};
		if (_this isEqualTo [0,0,0]) exitWith { player setVariable ["dui_customInfoHexColor",nil,true]; };
		player setVariable ["dui_customInfoHexColor", _this call BIS_fnc_colorRGBtoHTML, true];
	}
] call CBA_fnc_addSetting;

[
    "mjb_duiJoinPorpl",
    "CHECKBOX",
    ["Purple Team", "Sets custom DUI color to purple."],
    [_title, "Player QoL"],
    false,
    false,
	{	params ['_value'];
		if (!isNull player) then {
			if (_value) then {
				private _colour = [0.51, 0.2, 1];
				player setVariable ["dui_customRGBColor", _colour, true];
				player setVariable ["dui_customHexColor", _colour call BIS_fnc_colorRGBtoHTML, true];
			} else {
				player setVariable ["dui_customRGBColor", nil, true];
				player setVariable ["dui_customHexColor", nil, true];
			};
		};
	}
] call CBA_fnc_addSetting;

[
    "mjb_suppressedMarker",
    "SLIDER",
    ["Suppressed Marker Distance", "Shows the damage indicator for misses closer than the number in meters. (0 disables)"],
    [_title, "Player QoL"],
    [0, 9, 0, 1],
    false,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_suppressedMarkerMax",
    "SLIDER",
    ["Server Max Suppressed Distance", "Maximum distance in meters for near misses allowed to show marker for players. (0 disables)"],
    [_title, "Player QoL"],
    [0, 9, 4, 1],
    true
] call CBA_fnc_addSetting;

[
    "mjb_carryLocally",
    "CHECKBOX",
    ["Carry object local", "Shifts object to player when carrying for accurate rotation control."],
    [_title, "Player QoL"],
    false,
    true,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_loadoutRadios",
    "CHECKBOX",
    ["Add Radios on Load Loadout", "Adds the radios previously set radios when loading a loadout."],
    [_title, "Player QoL"],
    true,
    false,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_woodCutting",
    "CHECKBOX",
    ["Cut Tree hold action", "Allows players to remove trees and bushes, time to complete is based on size of the object."],
    [_title, "Player QoL"],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_clutterTime",
    "SLIDER",
    ["Remove Clutter Time", "Time in seconds it takes to clear an area of grass and similarly small map objects around the player."],
    [_title, "Player QoL"],
    [0, 300, 4, 1],
    true
] call CBA_fnc_addSetting;

[
    "mjb_clutterArea",
    "CHECKBOX",
    ["Larger Clutter removal area", "Doubles the radius of the area cleared, ~5m radius instead of ~2.5m."],
    [_title, "Player QoL"],
    false,
    true
] call CBA_fnc_addSetting;

[
    "mjb_strobeInf",
    "CHECKBOX",
    ["Do not consume self attachables", "Allows players to attach items to self infinitely. One is required in inventory."],
    [_title, "Player QoL"],
    true,
    true
] call CBA_fnc_addSetting;

[
    "mjb_tiesInf",
    "CHECKBOX",
    ["Do not consume cable tie", "Allows players to use a single cable tie infinitely. One is required in inventory."],
    [_title, "Player QoL"],
    true,
    true
] call CBA_fnc_addSetting;

[
    "mjb_cookoffPrevention",
    "CHECKBOX",
    ["Cookoff Grace", "Allows player ground vehicles to ignore one cookoff, damage will still be done to the vehicle."],
    [_title, "Player QoL"],
    true,
    true
] call CBA_fnc_addSetting;
[
    "mjb_cookoffPreventionCD",
    "SLIDER",
    ["Cookoff Grace Cooldown", "Time in seconds before vehicle regains cookoff protection. (0 makes it one and done, vehicle will not regain protection)"],
    [_title, "Player QoL"],
    [0, 9000, 0, 0],
    true
] call CBA_fnc_addSetting;

[
    "mjb_airVehicleDamage",
    "CHECKBOX",
    ["Air Damage", "Prevents detonation of player air vehicles at altitude, allowing more likely auto-rotation situation. (Incompatible with Vehicle Plates)"],
    [_title, "Player QoL"],
    false,
    true
] call CBA_fnc_addSetting;

[
    "mjb_acreProxyVolume",
    "SLIDER",
    ["ACRE Proximity Volume", "Increases volume of allied proximity voice with distance. (1 disables, 3 is 3 times volume at max distance(150m) and no change at 0m)"],
    [_title, "Player QoL"],
    [1, 4, 1, 2],
    false
] call CBA_fnc_addSetting;

[
    "mjb_acreShift",
    "SLIDER",
    ["ACRE Proxy Volume Shift (Doesn't Work?)", "Increases volume of allied proximity voice with distance by shifting the speaker location closer. (1 disables, 2 in theory sounds as loud as it would be at half the distance, but in between has more change the closer to max you get, 2.05 is one third distance at max)"],
    [_title, "Player QoL"],
    [1, 2.05, 1, 2],
    false
] call CBA_fnc_addSetting;

[
    "acre_skipAmphibious",
    "CHECKBOX",
    ["ACRE Skip Amphib check", "If acre breaks turn this on, and/or force ACRE Proxy Volume Shift to 1."],
    [_title, "Player QoL"],
    false,
    true
] call CBA_fnc_addSetting;
/*
[
    "mjb_acreVoiceScale",
    "SLIDER",
    ["ACRE Voice Curve Scale", "Possibly increases audible distance of voices in ACRE."],
    [_title, "Player QoL"],
    [0, 5, 1, 2],
    false
] call CBA_fnc_addSetting;

[
    "mjb_acreCustomCurveMax",
    "SLIDER",
    ["ACRE Custom Voice Curve Max", "Highest volume of acre voice on shout."],
    [_title, "Player QoL"],
    [1, 2.2, 1.3, 2],
    true
] call CBA_fnc_addSetting;

[
    "mjb_acreCustomCurveMin",
    "SLIDER",
    ["ACRE Custom Voice Curve Min", "Lowest volume of acre voice at whisper."],
    [_title, "Player QoL"],
    [0.1, 0.7, 0.1, 2],
    true
] call CBA_fnc_addSetting;
*/

[
    "mjb_tacReload",
    "CHECKBOX",
    ["Allow Tactical Reload", "Player controlled units can double tap their reload to skip part of the reload, dropping their old magazine."],
    [_title, "Tactical Reload"],
    true,
    false,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_tacDropEmptyMagazines",
    "CHECKBOX",
    ["Drop Empty Magazines", "Whether tactical reload drops empty magazines in a groundWeaponHolder."],
    [_title, "Tactical Reload"],
    true,
    false
] call CBA_fnc_addSetting;

[
    "mjb_tacDropCollisionFix",
    "CHECKBOX",
    ["Collision Fix", "Prevent collision with easily collapsed objects like trees and walls."],
    [_title, "Tactical Reload"],
    true,
    true
] call CBA_fnc_addSetting;

[
    "mjb_tacSimGlobal",
    "CHECKBOX",
    ["Global Falling Magazines", "Whether tactical reload drops simulated magazines globally, allowing other players to see them as they fall."],
    [_title, "Tactical Reload"],
    true,
    true
] call CBA_fnc_addSetting;

[
    "mjb_tacForbiddenMags",
    "EDITBOX",
    ["Magazine Class Blacklist", "Magazine classes that cannot tactical reload. (Belts and single ammo count 'mags' are excepted by default)"],
    [_title, "Tactical Reload"],
    "3Rnd_HE_Grenade_shell,CUP_6Rnd_HE_GP25_M,CUP_6Rnd_HE_M203,CUP_6Rnd_HE_M203_heli",
    true
] call CBA_fnc_addSetting;

[
    "mjb_tacForbiddenMuzzles",
    "EDITBOX",
    ["Muzzle Class Blacklist", "Magazine classes that cannot tactical reload. (Belts and single ammo count 'mags' are excepted by default)"],
    [_title, "Tactical Reload"],
    "GL_3GL_F,CUP_glaunch_6G30",
    true
] call CBA_fnc_addSetting;

[
    "mjb_tacGestureFix",
    "CHECKBOX",
    ["Fix Gestures Eating Mags", "Saves magazines when reload gestures are interrupted instead of voiding them."],
    [_title, "Tactical Reload"],
    true,
    true
] call CBA_fnc_addSetting;

[
    "mjb_tacDropMag",
    "CHECKBOX",
    ["Drop Unvoided Mags", "Drops magazines on the ground when reload gestures are interrupted, otherwise attempts to add them to the player after a second."],
    [_title, "Tactical Reload"],
    true,
    true
] call CBA_fnc_addSetting;

[
    "mjb_slotSaverAI",
    "CHECKBOX",
    ["Enable AI control on disconnect", "When a player disconnects AI will be enabled to prevent death. They may still die due to a vanilla locality issue with the AI."],
    [_title, "Disconnect handling"],
    false,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_slotSaverAIExt",
    "CHECKBOX",
    ["Enable Active Disconnect Protection", "The AI will be hidden and attached to group leader or subordinate, then become group leader to prevent locality change death. On returning they will be unhidden and detached."],
    [_title, "Disconnect handling"],
    false,
    true,
    { },
    true
] call CBA_fnc_addSetting;

/*[
    "mjb_autoDeathSync",
    "CHECKBOX",
    ["Automaticlly fix de-sync'd player deaths", "Detects whether players appear dead to each other when they shouldn't and applies the fix automatically."],
    [_title, "Death Handling"],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;*/

[
    "mjb_resyncAction",
    "CHECKBOX",
    ["Enable Resync Action", "Map tab with a list of players and a button to fix if someone is desync'd for you."],
    [_title, "Death Handling"],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_zeusCompKilled",
    "CHECKBOX",
    ["Shift Zeus Comps", "Shift zeus local AI to the server on death, making them ragdoll again for some reason."],
    [_title, "Death Handling"],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_lootFix",
    "CHECKBOX",
    ["Loot Fix", "Check simulation on killed unit inventory opened, and re-enable if disabled for the client opening."],
    [_title, "Death Handling"],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;

/*[
    "mjb_zeusMarker",
    "CHECKBOX",
    ["Hide Zeus Marker", "Hides the zeus group marker for the zeus slot in the zeus templates."],
    [_title, "Zeus Template"],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;*/

[
    "mjb_arsenal_preventAddObjectWargame",
    "CHECKBOX",
    ["Prevent ACE Add Object to Wargame Zeus", "Prevents ACE's auto add object setting from applying to Wargame zeese."],
    [_title, "Zeus"],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;

private _category = "AI";
[
    "mjb_disableGunnerBail",
    "CHECKBOX",
    ["Disable Gunner bailout", "Prevents gunners from bailing if they can still shoot."],
    [_title, _category],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_fullDismount",
    "CHECKBOX",
    ["Full Dismount Only", "Other crew also stay in until the gunner dismounts when Disable Gunner bailout is enabled."],
    [_title, _category],
    true,
    true
] call CBA_fnc_addSetting;

[
    "mjb_combatLock",
    "CHECKBOX",
    ["Player Combat Lock", "Prevents AI from entering vehicles players have exited while players are away from the vehicle."],
    [_title, _category],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_cfBaiFix",
    "CHECKBOX",
    ["Fix CF BAI on Zeus AI", "Runs CF BAI's init on zeus locality to make it's components affect AI they spawn (not global, so zeus can turn it off if it affects their performance)."],
    [_title, _category],
    true,
    false,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_localThunk",
    "CHECKBOX",
    ["AI Think Only Local", "Disable processing targetting data for remote AI units, knowsAbout, targets and similar commands will cease to work on remote units. For a gain in client performance because they no longer have to calculate all AI units."],
    [_title, _category],
    true,
    true
] call CBA_fnc_addSetting;

[
    "mjb_snakePass",
    "CHECKBOX",
    ["Allow Snakes to open doors", "Revert to legacy behaviour when client side snakes would open doors when entering houses."],
    [_title, _category],
    true,
    true
] call CBA_fnc_addSetting;

[
    "mjb_EMfix",
    "CHECKBOX",
    ["Enable possible slow mode fix for EM", "Detects interrupted animations that change animation speed, and attempts to fix speed/climbing ability if broken."],
    [_title, "Enhanced Movement"],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_EMFixDiag",
    "CHECKBOX",
    ["Enable message when slow mode fix triggers", "Just something that might help understand the cause, and make the fix better."],
    [_title, "Enhanced Movement"],
    false,
    false
] call CBA_fnc_addSetting;

[
    "mjb_thermalStart",
    "SLIDER",
    ["Thermal Cold Floor", "Sets where coldest color starts, can make thermals unusable at higher settings."],
    [_title, "Thermal Vision"],
    [0, 1, 0, 2],
    true,
    {
        params ["_value"];
        mjb_thermalStart = _value;
    }
] call CBA_fnc_addSetting;

[
    "mjb_thermalWidth",
    "SLIDER",
    ["Thermal Width", "Sets maximum contrast of thermals, can make thermals unusable at lower settings."],
    [_title, "Thermal Vision"],
    [0, 1, 1, 2],
    true,
    {
        params ["_value"];
        mjb_thermalWidth = _value;
    }
] call CBA_fnc_addSetting;

[
    "mjb_saveLoadout",
    "LIST",
    ["Loadout save frequency", "At what times/actions your loadout gets saved when persistence is enabled for the mission. No saves will be made when disabled, this is only checked at mission start. When enabled, the saved loadout is erased on death, unless the mission maker specifies otherwise."],
    [_title,"Loadout Persistence"],
    [[0, 1, 2, 3], ["Disable","Closing inventory","Five minute interval", "Both"], 3],
    0,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_plateFix",
    "CHECKBOX",
    ["Fix for CBA disabling vanilla Heal EH", "Workaround for healing not working for non-medic %, disable next plates update."],
    [_title, "Plates"],
    false,
    true,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_dropPlate",
    "CHECKBOX",
    ["Move loot plates to quick loot", "When a unit dies move plates in storage to main inventory screen, allowing scroll action to take them."],
    [_title, "Plates"],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_plateToughness",
    "CHECKBOX",
    ["Enable Plate Toughness", "Players can regen plates over time, starts after delay when not taking damage."],
    [_title, "Plates"],
    false,
    true,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_plateRegenCount",
    "SLIDER",
    ["Plates that regen from toughness", "How many plates are affected by the toughness regen. Limited by plates wearable setting in Armor Plates System."],
    [_title, "Plates"],
    [1, 10, 1, 0],
    true,
    {
        params ["_value"];
        mjb_plateRegenCount = round _value;
    }
] call CBA_fnc_addSetting;

[
    "mjb_plateDelay",
    "SLIDER",
    ["Plate toughness delay", "Seconds before toughness plate starts regen."],
    [_title, "Plates"],
    [1, 600, 5, 1],
    true,
    {
        params ["_value"];
        mjb_plateDelay = _value;
    }
] call CBA_fnc_addSetting;

[
    "mjb_plateDelayInter",
    "CHECKBOX",
    ["Delay between plates", "Whether to apply delay between each plate to be regen'd."],
    [_title, "Plates"],
    false,
    true,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_plateRegenSpeed",
    "SLIDER",
    ["Plate toughness regen speed", "Seconds to regen a full plate."],
    [_title, "Plates"],
    [1, 600, 5, 1],
    true,
    {
        params ["_value"];
        mjb_plateRegenSpeed = _value;
    }
] call CBA_fnc_addSetting;

[
    "mjb_plateRegenPerTick",
    "SLIDER",
    ["Plate Health per Tick", "Minimum regen to apply, affects tick speed but not the seconds to full plate (Default: 0.5, plate ui does not change from less). Will not regen more than one full plate per tick."],
    [_title, "Plates"],
    [0.1, 100, 0.5, 1],
    false,
    {
        params ["_value"];
        mjb_plateRegenPerTick = _value;
    }
] call CBA_fnc_addSetting;

[
    "mjb_plateSteal",
    "CHECKBOX",
    ["Enable plate gain on kill", "When a player damages a non-civ target that dies, they gain plate health."],
    [_title, "Plates"],
    false,
    true,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_plateRegain",
    "SLIDER",
    ["Plate gain on kill multiplier", "Multiplier for how much plate health is gained on kill, max all plates."],
    [_title, "Plates"],
    [0, 10, 0.2, 2],
    true,
    {
        params ["_value"];
        mjb_plateRegain = _value;
    }
] call CBA_fnc_addSetting;

[
    "mjb_timerRegain",
    "SLIDER",
    ["Down Timer Regen Coef", "How quickly timer is regen'd. Higher number is faster. 0 disables."],
    [_title, "Plates"],
    [0, 10, 0, 1],
    true,
    {
        params ["_value"];
        mjb_timerRegain = _value;
    },
    true
] call CBA_fnc_addSetting;

[
    "mjb_arsenal_maxLoadoutInjectors",
    "SLIDER",
    ["Max injectors from loadout", "How many injectors a medic can take from arsenal in their inventory. (0 to disable limit)"],
    [_title, "Retroactive Arsenal"],
    [0, 50, 5, 0],
    true,
    {
        params ["_value"];
        mjb_arsenal_maxLoadoutInjectors = round _value;
    },
    true
] call CBA_fnc_addSetting;

[
    "mjb_scriptDebug",
    "CHECKBOX",
    ["Log Spawned Scripts", "Logs all scripts spawned on server, last entry before a crash may be an issue, but could cause log file to be very large."],
    [_title, "xExperimental"],
    false,
    true
] call CBA_fnc_addSetting;

[
    "mjb_enableStabToggle",
    "CHECKBOX",
    ["Allow Co-pilot Stabilize Toggle", "Whether co-pilot stabilization can be disabled, and point/area type functionality then enabled."],
    [_title, "xExperimental"],
    true,
    true
] call CBA_fnc_addSetting;

[
    "mjb_canReacquire",
    "CHECKBOX",
    ["Co-pilot Stabilize can Re-acquire", "Whether co-pilot stabilization can re-acquire a target that has moved out of LoS, when mouse has not been moved or target is sensor targeted, and the target re-enters LoS. Otherwise stabilization will remain on the last known position."],
    [_title, "xExperimental"],
    true,
    true
] call CBA_fnc_addSetting;

[
    "mjb_cupLBMass",
    "SLIDER",
    ["CUP Littlebird Mass", "Mass of CUP Littlebird applied in PostInit."],
    [_title, "xExperimental"],
    [1000, 5000, 1821, 2],
    true,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_cupCHMass",
    "SLIDER",
    ["CUP Chinook Mass", "Mass of CUP Chinook applied in PostInit."],
    [_title, "xExperimental"],
    [5000, 30000, 10001, 2],
    true,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_cba_justLetsYouHaveInfiniteRockets",
    "CHECKBOX",
    ["Prevent CBA Launcher Maxing", "Bug with loadouts where launcher 'magazines' are replaced with loaded tubes in backpacks, disregarding weight."],
    [_title, "xExperimental"],
    true,
    true,
	{},
	true
] call CBA_fnc_addSetting;

[
    "mjb_arsenal_projectileEvents",
    "CHECKBOX",
    ["Enable Projectile Events", "Projectile event handling, currently only setting fuel cans on fire with tracers/incendiary ammo."],
    [_title, "xShenanigans"],
    true,
    true
] call CBA_fnc_addSetting;

[
    "mjb_arsenal_enableRainbow",
    "CHECKBOX",
    ["Enable Rainbow", "Activates rainbow tracers and infinite ammo for the HK121/MG5/Navid when closing ace arsenal with the rainbow mag loaded."],
    [_title, "xShenanigans"],
    false,
    true
] call CBA_fnc_addSetting;

[
    "mjb_memeBeacon",
    "CHECKBOX",
    ["Enable meme beacon", "Puts beagle in a trash can."],
    ["ZEUS WARGAME MOD", "CHEATS"],
    false,
    true
] call CBA_fnc_addSetting;


[
    "ssd_scremVolume",
    "CHECKBOX",
    ["Reduced Death/Hit Screams Volume", "Reduces volume of screams including hit noises and randomly possible Wilhelm and a Beagle noise on death."],
    ["SSD Death Screams","MJB Tweak"],
    false,
    false
] call CBA_fnc_addSetting;
[
    "ssd_scremDisable",
    "CHECKBOX",
    ["Disable SSD Screams", "Disables screams including hit noises and randomly possible Wilhelm and a Beagle noise on death."],
    ["SSD Death Screams","MJB Tweak"],
    false,
    false
] call CBA_fnc_addSetting;

[
    "sfx_r_scremVolume",
    "SLIDER",
    ["Death Sounds Volume", "Volume coef of sounds devised by WebKnight that play on death. (Generally pretty quiet already.)"],
    ["Project SFX: Remastered","1) Death sounds - MJB Tweak"],
    [0, 2.5, 1, 2],
    false
] call CBA_fnc_addSetting;
[
    "sfx_r_scremDisable",
    "CHECKBOX",
    ["Disable Death Sounds", "Disables death sounds."],
    ["Project SFX: Remastered","1) Death sounds - MJB Tweak"],
    false,
    false
] call CBA_fnc_addSetting;
