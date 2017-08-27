if (isNull (getAssignedCuratorLogic player)) then {

    player remoteExecCall ["tac1_admin_fnc_zeusServerMake", 2];
} else {
    hint "You already have Zeus powers, therefore we can not give you Zeus powers again";
};