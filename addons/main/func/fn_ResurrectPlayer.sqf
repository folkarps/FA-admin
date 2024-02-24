#include "\1tac_admin\module_header.hpp"

if(isNil "fa_admin_fnc_initRunner") then {
    fa_admin_fnc_initRunner = compileFinal {
		params ["_corpse","_unit"];
        if(!isNil "F_fnc_ForceExit") then {
            [] call F_fnc_ForceExit;
            f_cam_VirtualCreated = nil;
        }else {
            ["Terminate"] call BIS_fnc_EGSpectator;
        };

        setPlayable _unit;
        selectPlayer _unit;
        _corpse setName format ["Resurrection%1",  round(random 20000)];
        _init = compile preprocessFile "init.sqf";
        _handle = [] spawn _init;
        waitUntil {scriptDone _handle};
        deleteVehicle _corpse;
    };
	publicVariable "fa_admin_fnc_initRunner";
};

if (isNil "fa_admin_fnc_serverRunner") then {
	fa_admin_fnc_serverRunner = compileFinal {
		{
			private _logicPos = _this select 0;
			diag_log format ["comparing %1", (name _x)];
			if((_logicPos distance _x) < 2 && (owner _x != 2)) then {
				_unit = (group _x) createUnit [(typeOf _x), position _x, [], 0, "NONE"];
				_unit setName format ["Resurrection%1",  round(random 20000)];
				waitUntil{!isNil "_unit"};
				(group _unit) setGroupOwner (owner _x);
				[_x, _unit] remoteExec ["fa_admin_fnc_initRunner", (owner _x)];
			};
		}forEach allDead;
	};
	publicVariable "fa_admin_fnc_serverRunner";
};

publicVariable "loadoutCopy";

_logicPos = (position _logic);

[_logicPos] remoteExec ["fa_admin_fnc_serverRunner", 2];
		
#include "\1tac_admin\module_footer.hpp"

