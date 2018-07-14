#include "\1tac_admin\module_header.hpp"
vehicleToRepair = (position _logic) nearEntities [["Air", "Car", "Motorcycle", "Tank"], 5];
{
    _x setDamage 0;
} forEach vehicleToRepair;
		
#include "\1tac_admin\module_footer.hpp"