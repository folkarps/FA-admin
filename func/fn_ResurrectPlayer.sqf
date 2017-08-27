#include "\1tac_admin\module_header.hpp"

if(isNil "initRunner") then {
    initRunner = {
        _corpse = _this select 0;
        _unit = _this select 1;
        diag_log format ["init running running on machine:%1", clientOwner];
        _unit globalChat format ["init running running on machine:%1", clientOwner];
       [] call F_fnc_ForceExit;
       f_cam_VirtualCreated = nil;
        setPlayable _unit;
        selectPlayer _unit;
        _init = compile preprocessFile "init.sqf";
        _handle = [] spawn _init;
        waitUntil{scriptDone _handle};
        [_corpse, _unit, false] call loadoutCopy;
        deleteVehicle _corpse;
    };
};


loadoutCopy = {

    params ["_from", "_to"];
    _primary = primaryWeapon _from;
    _weapons = weaponsItems _from;

    _to removeWeapon secondaryWeapon _to;
    removeAllAssignedItems _to;
    removeAllContainers _to;

    removeHeadgear _to;
    if((headgear _from)!="") then {
        _to addHeadgear (headgear _from);
    };
    removeGoggles _to;
    if((goggles _from)!="") then {
        _to addGoggles (goggles _from);
    };
    if((uniform _from)!="") then {
        _to adduniform(uniform _from);
    };
    if((vest _from)!="") then {
        _to addvest (vest _from);
    };
    if((backpack _from)!="") then {
        _to addbackpack (backpack _from);
    };



    {
        _to addmagazine [(_x select 0),(_x select 1)];
    } foreach magazinesAmmoFull _from;


    _blacklist = ["Rangefinder","Binocular"];
    diag_log format ["%1", weaponsItems _from];
    {
        if((_x select 0)!="" && !((_x select 0) in _blacklist)) then {

            _to addweapon (_x select 0);
            _to linkitem (_x select 1);
            _to linkitem (_x select 2);
            _to linkitem (_x select 3);
        };
    } foreach (weaponsItems _from);

    _array = getItemCargo uniformContainer _from;
    if(count(_array)>0) then {
        {
            for[{_i=0},{_i<((_array) select 1) select _forEachIndex},{_i=_i+1}] do {
                _to addItemToUniform _x;
            };
        } foreach ((_array) select 0);
    };

    _array = getWeaponCargo uniformContainer _from;
    if(count(_array)>0) then {
        {
            for[{_i=0},{_i<((_array) select 1) select _forEachIndex},{_i=_i+1}] do {
                _to addItemToUniform _x;
            };
        } foreach ((_array) select 0);
    };

    _array = getItemCargo vestContainer _from;
    if(count(_array)>0) then {
        {
            for[{_i=0},{_i<((_array) select 1) select _forEachIndex},{_i=_i+1}] do {
                _to addItemToVest _x;
            };
        } foreach ((_array) select 0);
    };

    _array = getWeaponCargo vestContainer _from;
    if(count(_array)>0) then {
        {
            for[{_i=0},{_i<((_array) select 1) select _forEachIndex},{_i=_i+1}] do {
                _to addItemToBackpack _x;
            };
        } foreach ((_array) select 0);
    };


    _array = getItemCargo backpackContainer _from;
    if(count(_array)>0) then {
        {
            for[{_i=0},{_i<((_array) select 1) select _forEachIndex},{_i=_i+1}] do {
                _to addItemToBackpack _x;
            };
        } foreach ((_array) select 0);
    };

    _array = getWeaponCargo backpackContainer _from;
    if(count(_array)>0) then {
        {
            for[{_i=0},{_i<((_array) select 1) select _forEachIndex},{_i=_i+1}] do {
                _to addItemToBackpack _x;
            };
        } foreach ((_array) select 0);
    };

    {
        _to linkItem _x;
    } foreach assignedItems _from;

};

serverRunner = {
    {
        _logicPos = _this select 0;
        diag_log format ["comparing %1", (name _x)];
        if((_logicPos distance _x) < 2 && (owner _x != 2)) then {
            diag_log format ["creating unit %1, creating unit belonging to ", (name _x), (owner _x)];
            _unit = (group _x) createUnit [(typeOf _x), position _x, [], 0, "NONE"];
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

