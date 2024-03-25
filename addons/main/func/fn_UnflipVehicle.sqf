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

private _vehicleFlipped = (position _logic) nearEntities [["LandVehicle"], 10];
{
    [_x] remoteExec ["fa_UnflipVehicleFunction",_x];
} forEach _vehicleFlipped;
		
#include "\1tac_admin\module_footer.hpp"