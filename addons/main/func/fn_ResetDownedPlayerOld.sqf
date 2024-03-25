#include "\1tac_admin\module_header.hpp"
private _downedUnits = (position _logic) nearEntities [["CAManBase"], 1];
{
    
	// if unit is down , revive him.
	if(_x getVariable ["f_wound_down",false] ) then
	{
        [_x,false] remoteExec ["f_fnc_SetDowned",  _x];
	};
    
	if(_x getVariable ["f_wound_bleeding",false]) then {
        [_x,false] remoteExec ["f_fnc_SetBleeding",  _x];
    };
} forEach _downedUnits;
		
#include "\1tac_admin\module_footer.hpp"