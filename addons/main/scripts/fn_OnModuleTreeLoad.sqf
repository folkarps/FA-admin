/*
	Does magic to add custom items to a category in Zeus.
*/

#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

private ["_display","_ctrl","_category","_categoryName","_categoryMod","_subCategories","_categoryBranches","_moduleClassList","_index"];

disableSerialization;

//Safety precaution, wait for the curator screen to be displayed
while {isNull (findDisplay IDD_RSCDISPLAYCURATOR)} do {
	sleep 1;
};

// Get the UI control
_display = findDisplay IDD_RSCDISPLAYCURATOR;
_ctrl = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_MODULES;

// Generate a structure holding the data for all the entries we need to add to the display.
_leafData = []; // An array of arrays with information on items in each category - [ ["CategoryName", "DisplayName", "ModuleClass", "icon"], ... ]

// Generate the leaf data for the modules defined as items in the mod.
{
	// Only add modules that define themselves in the "Ares" category
	_moduleCategory = gettext (configFile >> "CfgVehicles" >> _x >> "category");
	if(_moduleCategory == "Fa") then
	{
		_categoryName = gettext (configFile >> "CfgVehicles" >> _x >> "subCategory");
		_displayName = gettext (configFile >> "CfgVehicles" >> _x >> "displayName");
		_className = _x;
		_leafData pushBack [_categoryName, _displayName, _className];
	};
} forEach getArray (configFile >> "cfgPatches" >> "1TAC_ADMIN_CONSOLE" >> "units");


// Figure out the names of the categories we need to generate - and generate some data for them.
_categoryData = [];
{
	_categoryName = _x select 0;
	
	_isAlreadyInData = false;
	{
		if (_x == _categoryName) exitWith { _isAlreadyInData = true; };
	} forEach _categoryData;
	
	if (not _isAlreadyInData) then
	{
		_categoryData pushBack _categoryName;
	};
} forEach _leafData;

// Check to see if our categories already exist, and if they do then delete them
{
	_categoryName = _x;
	for [{ _i = 0 }, { _i < (_ctrl tvCount []) }, { _i = _i + 1 }] do 
	{
		_tvText = _ctrl tvText [_i];
		if(_tvText == _categoryName) then
		{
			_ctrl tvDelete [_i];
		};
	};
} forEach _categoryData;

// Create new categories and add them to the tree.
_categoryBranches = [];
{
	_tvText = _x;
	_tvData = "Ares_Module_Empty"; // All of the categories use the 'Empty' module. There's no logic associated with them.
	_tvBranch = _ctrl tvAdd [[], _tvText];
	_ctrl tvSetData [[_tvBranch], _tvData];

	_categoryBranches pushBack _tvBranch;
} forEach _categoryData;

//Add all of the leaf nodes into their correct categories
{
	//Get values from leaf data [["CategoryName", "DisplayName", "ModuleClass", "icon"], ...]
	_moduleSubCategory = _x select 0;
	_moduleDisplayName = _x select 1;
	_moduleClassName = _x select 2;

	// Serach for the branch we need to add this item to
	_tvModuleBranch = nil;
	{
		if(_moduleSubCategory == _x) exitWith
		{
			// We assume the _categoryBrances are a parallel array with the _categoryBranches array.
			_tvModuleBranch = _categoryBranches select _forEachIndex;
		};
	} forEach _categoryData;
	
	if (not isNil "_tvmodulebranch") then
	{
		//Create the new tree entry in the branch
		_leaf = _ctrl tvAdd [[_tvModuleBranch], _moduleDisplayName];
		_newPath = [_tvModuleBranch, _leaf];

		//Copy all of the data into it
		_ctrl tvSetData [_newPath, _moduleClassName];
		_ctrl tvSetValue [_newPath, _forEachIndex];
	};
} forEach _leafData;

//Sort the new categories
{
	_ctrl tvSort [[_x], false];
} forEach _categoryBranches;

//Sort the base module list
_ctrl tvSort [[], false];