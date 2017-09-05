params["","_key","_shift"];
_returnMe = false;
if (_key isEqualTo 59 && _shift) then {

    closeDialog 0;
    if (!alive player && !(isNil "f_fnc_forceExit")) then {
        [] call f_fnc_forceExit;
    };

    if (isServer or ((getPlayerUID player) in tac1_adminIDs) or (serverCommandAvailable "#kick")) then {
        createDialog 'adminMenuDialog';
    } else {
        hint "You are not logged in as an admin.";
    };
    _returnMe = true;
}else {
    if(_key isEqualTo 21) then {
         [] spawn {
            ["Terminate"] call BIS_fnc_EGSpectator;
            waitUntil {isNull findDisplay 60492};
            openCuratorInterface;
            [] spawn {
                waitUntil {!isNull findDisplay 312};
                waitUntil {isNull findDisplay 312};
                ["Initialize", [player, [], true]] call BIS_fnc_EGSpectator;
                waitUntil {!isNull findDisplay 60492};
                (findDisplay 60492) displayAddEventHandler ["KeyDown", "_this call tac1_admin_fnc_keySpectPressed"];
            };
         };
            _returnMe = true;
    }else {
        _returnMe = false;
    };
};

_returnMe