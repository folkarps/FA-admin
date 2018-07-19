if (isNull (getAssignedCuratorLogic player)) then {
    [] spawn {
        diag_log "give zeus self 1";
        if (!isNull findDisplay 60492 && isNil "zeusEnteredOnce") then {
            diag_log "give zeus self 2";
            ["Terminate"] call BIS_fnc_EGSpectator;
            waitUntil {isNull findDisplay 60492};
            createCenter sideLogic;
            _playerPos = getPos player;
            _newGrp = createGroup sideLogic;
            _newUnit = _newGrp createUnit ["VirtualCurator_F", [0,0,5], [], 0, "FORM"];
            _newUnit allowDamage false;
            _newUnit hideObjectGlobal true;
            _newUnit enableSimulationGlobal false;
            _newUnit setpos _playerPos;
            selectPlayer _newUnit;
            waituntil{player == _newUnit};
            ["Initialize", [player, [], true]] call BIS_fnc_EGSpectator;
            zeusEnteredOnce = true;
            waitUntil {!isNull findDisplay 60492};
            (findDisplay 60492) displayAddEventHandler ["KeyDown", "_this call tac1_admin_fnc_keySpectPressed"];
        };
        player remoteExecCall ["tac1_admin_fnc_zeusServerMake", 2];
    };
    
} else {
    hint "You already have Zeus powers, therefore we can not give you Zeus powers again";
};
