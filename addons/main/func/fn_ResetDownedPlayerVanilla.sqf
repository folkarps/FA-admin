#include "\1tac_admin\module_header.hpp"
private _downedUnits = (position _logic) nearEntities [["CAManBase"], 1];
{
    
	// if unit is down , revive him.
	if(isPlayer _x) then
	{
        ["#rev",1,_x] remoteExecCall ["BIS_fnc_reviveOnState",  _x] ;
	};
   
} forEach _downedUnits;
		
#include "\1tac_admin\module_footer.hpp"