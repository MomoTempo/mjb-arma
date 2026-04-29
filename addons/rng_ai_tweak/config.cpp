class CfgPatches {
  class mjb_rng_ai_tweak {
		ammo[] = {};
		magazines[] = {};
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		author = "Alien314";
		name = "RNG AI Tweak";
		requiredAddons[]=
		{
			"RNG_mod"
		};
		skipWhenMissingDependencies = 1;
	};
};

class Extended_PreInit_EventHandlers
{
	class mjb_rng_ai_tweak
	{
		init="call compile preprocessFileLineNumbers '\z\mjb\addons\rng_ai_tweak\settings.sqf'";
	};
};

class CfgFunctions
{
	class RNG
	{
		class functions
		{
			class unit_init
			{
				tag="RNG";
				file="\z\mjb\addons\rng_ai_tweak\fn_unit_init.sqf";
			};
			/*class react
			{
				tag="RNG";
				file="\RNG_AI\scripts\fn_react.sqf";
			};
			class combat
			{
				tag="RNG";
				file="\RNG_AI\scripts\fn_combat.sqf";
			};*/
			class cover
			{
				tag="RNG";
				file="\z\mjb\addons\rng_ai_tweak\fn_cover.sqf";
			};/*
			class turning
			{
				tag="RNG";
				file="\RNG_AI\scripts\fn_turning.sqf";
			};*/
		};
	};
};