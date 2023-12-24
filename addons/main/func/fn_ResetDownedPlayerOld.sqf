#include "\1tac_admin\module_header.hpp"
downedUnits = (position _logic) nearEntities [["Man"], 1];
{
    
	// if unit is down , revive him.
	if(_x getVariable ["f_wound_down",false] ) then
	{
        [_x,false] remoteExec ["f_fnc_SetDowned",  _x, false] ;
	};
    
	if(_x getVariable ["f_wound_bleeding",false]) then {
        [_x,false] remoteExec ["f_fnc_SetBleeding",  _x, false] ;
    };
} forEach downedUnits;
		
#include "\1tac_admin\module_footer.hpp"