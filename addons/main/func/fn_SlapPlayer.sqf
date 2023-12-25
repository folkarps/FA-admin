#include "\1tac_admin\module_header.hpp"

if (isNil "fa_admin_fnc_slapPlayerLocal") then {
	fa_admin_fnc_slapPlayer = {
		params ["_unit"];
		_unit allowDamage false;
		private _randomStage1 = [
			random [-1, selectRandom [0.5,-0.5], 1],
			random [-1, selectRandom [0.5,-0.5], 1]
		];
		private _randomStage2 = [selectRandom _randomStage1, selectRandom _randomStage1, 0.5];
		_unit addForce [_randomStage2 vectorMultiply 4000, [0,0,1]];
		sleep 10;
		_unit setUnconscious false;
		_unit allowDamage true;
		_unit playMoveNow "amovppnemstpsraswrfldnon";
	};
	publicVariable "fa_admin_fnc_slapPlayerLocal";
};

private _targetUnit = (position _logic) nearestObject "CAManBase";
titleText [format ["Selected player - %1 - press ENTER within 10 seconds to confirm",name _targetUnit],"PLAIN"];

uiNamespace setVariable ["fa_admin_playerToSlap",_targetUnit
private _EH = (findDisplay 46) displayAddEventHandler ["KeyDown",{
	params ["_displayOrControl", "_key", "_shift", "_ctrl", "_alt"];
	if (_key in [156,28]) then {
		private _unit = uiNamespace getVariable ["fa_admin_playerToSlap",objNull];
		if (alive _unit) then {
			[_unit] remoteExec ["fa_admin_fnc_slapPlayerLocal",_unit];
		};
		(findDisplay 46) displayRemoveEventHandler _thisEventHandler;
		uiNamespace setVariable ["fa_admin_playerToSlap",objNull];
		true
	} else {
	false
	};
}];

_EH spawn {
	sleep 10;
	(findDisplay 46) displayRemoveEventHandler _EH;
	uiNamespace setVariable ["fa_admin_playerToSlap",objNull];
};
		
#include "\1tac_admin\module_footer.hpp"