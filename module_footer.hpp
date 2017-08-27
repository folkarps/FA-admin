	// ...
	// End of the 'inner' scope that was opened in the header where
	// all of the module logic actuall executes.
};

// Cleanup the module if the script logic didn't tell us not to.
if (_deleteModuleOnExit) then
{
	deleteVehicle (_this select 0);
}
else
{
};

// Return how happy we are (best practice)
true