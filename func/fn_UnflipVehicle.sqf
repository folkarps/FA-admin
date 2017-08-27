#include "\1tac_admin\module_header.hpp"


if (isNil "fa_UnflipVehicleFunction") then {
    fa_UnflipVehicleFunction =
    {
        if(local _this) then {
            _this setVectorUp [0,0,1];
            _this setPosATL (( getPosATL _this) vectorAdd [0,0,2]);
        };
    };
    publicVariable "fa_UnflipVehicleFunction";
};

vehicleFlipped = (position _logic) nearEntities [["Car"], 10];
{
    [_x, "fa_UnflipVehicleFunction", true] spawn BIS_fnc_MP;
} forEach vehicleFlipped;
		
#include "\1tac_admin\module_footer.hpp"