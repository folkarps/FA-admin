#include "\1tac_admin\module_header.hpp"

if (isNil "f_fnc_fcsInit") exitWith { systemChat "FA ADMIN ZEUS MODULE: FA3 FCS module not present in mission.";};

private _vehicleToFCS = (position _logic) nearestObject "LandVehicle";
private _displayName = getText (configOf _vehicleToFCS >> "displayName");

titleText [format ["Selected vehicle - %1 - press ENTER within 10 seconds to confirm",_displayName],"PLAIN"];

uiNamespace setVariable ["fa_admin_vehicleToFCS",_vehicleToFCS];
private _EH = (findDisplay 46) displayAddEventHandler ["KeyDown",{
	params ["_displayOrControl", "_key", "_shift", "_ctrl", "_alt"];
	if (_key in [156,28]) then {
		private _vehicle = uiNamespace getVariable ["fa_admin_vehicleToFCS",objNull];
		if (alive _vehicle) then {
			[_vehicle] remoteExec ["f_fnc_fcsInit",0];
		};
		(findDisplay 46) displayRemoveEventHandler _thisEventHandler;
		uiNamespace setVariable ["fa_admin_vehicleToFCS",objNull];
		true
	} else {
	false
	};
}];

_EH spawn {
	sleep 10;
	(findDisplay 46) displayRemoveEventHandler _EH;
	uiNamespace setVariable ["fa_admin_vehicleToFCS",objNull];
};
		
#include "\1tac_admin\module_footer.hpp"