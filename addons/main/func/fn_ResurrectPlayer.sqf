#include "\1tac_admin\module_header.hpp"

if(isNil "initRunner") then {
    initRunner = {
        _corpse = _this select 0;
        _unit = _this select 1;
        if(!isNil "F_fnc_ForceExit") then {
            [] call F_fnc_ForceExit;
            f_cam_VirtualCreated = nil;
        }else {
            ["Terminate"] call BIS_fnc_EGSpectator;
        };

        setPlayable _unit;
        selectPlayer _unit;
        _corpse setName format ["Ressurection%1",  round(random 20000)];
        _init = compile preprocessFile "init.sqf";
        _handle = [] spawn _init;
        waitUntil{scriptDone _handle};
        deleteVehicle _corpse;
    };
};


serverRunner = {
    {
        _logicPos = _this select 0;
        diag_log format ["comparing %1", (name _x)];
        if((_logicPos distance _x) < 2 && (owner _x != 2)) then {
            _unit = (group _x) createUnit [(typeOf _x), position _x, [], 0, "NONE"];
            _unit setName format ["Ressurection%1",  round(random 20000)];
            waitUntil{!isNil "_unit"};
            (group _unit) setGroupOwner (owner _x);
            [_x, _unit] remoteExec ["initRunner", (owner _x), false];
        };
    }forEach allDead;
};

publicVariable "loadoutCopy";
publicVariable "initRunner";
publicVariable "serverRunner";

_logicPos = (position _logic);

[_logicPos] remoteExec ["serverRunner", 2, false];
		
#include "\1tac_admin\module_footer.hpp"

