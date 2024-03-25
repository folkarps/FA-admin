#include "\1tac_admin\module_header.hpp"
private _menToHeal = (position _logic) nearEntities [["CAManBase"], 2];
{
    _x setDamage 0;
} forEach _menToHeal;
		
#include "\1tac_admin\module_footer.hpp"