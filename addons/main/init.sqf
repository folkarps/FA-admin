
//Set the admin IDs
tac1_adminIDs = [
		"76561197970308881", // Bodge
		"76561198012648163", // Wolfenswan
		"76561197975964276", // Fer
		"76561198012169975", // Audiox
		"76561197978479707", // Pickers
		"76561198028156171", // Aquarius
		"76561197967080299", // Ferrard
		"76561197967886612", // Netkev
		"76561197991278130", // SuperÜ
		"76561197970308881", // Bodge
		"76561197991685206", // blip2
		"76561198038419783", // eagle_eye
		"76561197998285916", // darkChozo
		"76561197989940416", // Pooter
		"76561198024309753", // Madrak_the_red
        "76561198057520464", //Mabbott
        "76561198085572549" //AJAX
		];
if(isServer) then {
    if (isFilePatchingEnabled) then {
            diag_log format [ "FA ADMIN: file patching is on, trying to add extra hosts, started with: %1", count tac1_adminIDs];
            hostInit = compile preprocessFileLineNumbers "\userconfig\FA_admin\hostList.sqf";
            reloadHosts = {
                [] call hostInit; 
                diag_log format [ "FA ADMIN: file patching is on, trying to add extra hosts, ran with: %1", count tac1_adminIDs];
                sleep 30;
                [] spawn reloadHosts;
            };
            [] spawn reloadHosts;
    }else {
            diag_log "FA ADMIN: file patching is off, not adding hosts";
    }
};
if (hasInterface) then {
    [] spawn {
        waitUntil {sleep 0.5; !isNull (findDisplay 46)};
        registeredDisplays pushBack((findDisplay 46));
        (findDisplay 46) displayAddEventHandler ["KeyDown", "_this call tac1_admin_fnc_keyPressed"];
    };
    [] spawn {
        waitUntil {sleep 0.5; !isNull (findDisplay 60492)};
        registeredDisplays pushBack((findDisplay 60492));
        (findDisplay 60492) displayAddEventHandler ["KeyDown", "_this call tac1_admin_fnc_keyPressed"];
    };
    registeredDisplays = [];
    addDisplays = {
       _displays = allDisplays;
       {
        if(!(_x in registeredDisplays)) then {
            registeredDisplays pushBack(_x);
            _x displayAddEventHandler ["KeyDown", "_this call tac1_admin_fnc_keyPressed"];
        }
       } forEach _displays;
       sleep 30;
       [] spawn addDisplays;
    };
    [] spawn addDisplays;
    
};
[] spawn {
    sleep 2;
    diag_log format ["FA ADMIN: post init, has %1", count tac1_adminIDs];
};




if(isServer && isDedicated) exitWith {};

[] spawn {
	[] call tac1_admin_fnc_waitForZeus;
	
	// Wait until THIS player is a zeus unit.
	while { !([player] call tac1_admin_fnc_isZeus) } do
	{
		//["Unit not zeus..."] call tac1_admin_fnc_LogMessage;
		sleep 1;
	};

	["tac1_admin"] spawn tac1_admin_fnc_MonitorCuratorDisplay;
	
	_didRegisterForEvents = false;
	{
		if ((getassignedcuratorunit _x) == player) then
		{
			_x addEventHandler ["CuratorObjectPlaced", { _this call tac1_admin_fnc_HandleCuratorObjectPlaced; }];
			_x addEventHandler ["CuratorObjectDoubleClicked", { _this call tac1_admin_fnc_HandleCuratorObjectDoubleClicked; }];
			_didRegisterForEvents = true;
		}
		else
		{
		}
	} foreach allCurators;
};
