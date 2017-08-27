#include "\1tac_admin\module_header.hpp"
menToHeal = (position _logic) nearEntities [["Man"], 2];
{
    _x setDamage 0;
} forEach menToHeal;
		
#include "\1tac_admin\module_footer.hpp"