#include "\1tac_admin\module_header.hpp"
private _downedUnits = (position _logic) nearEntities [["CAManBase"], 1];
{
	if(isPlayer _x) then
	{
        [_x] remoteExec ["f_fnc_famReset",  _x] ;
	};
} forEach _downedUnits;
		
#include "\1tac_admin\module_footer.hpp"