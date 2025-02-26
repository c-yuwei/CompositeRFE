classdef DataSimulator < ConcreteElement
	%DataSimulator is a simulator for simulating example data.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% XXX
	%
	% The list of DataSimulator properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the data simulator.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the data simulator.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the data simulator.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the data simulator.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the data simulator.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of data simulator.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the data simulator.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>BA</strong> 	BA (parameter, item) is a brain atlas.
	%  <strong>10</strong> <strong>P</strong> 	P (parameter, scalar) is a number of probability for a Watts–Strogatz model.
	%  <strong>11</strong> <strong>D</strong> 	D (parameter, scalar) is a number of degree for a Watts–Strogatz model.
	%  <strong>12</strong> <strong>N</strong> 	N (parameter, scalar) is a number of node for a Watts–Strogatz model.
	%  <strong>13</strong> <strong>TIME_STEP</strong> 	TIME_STEP (parameter, scalar) is time_steps.
	%  <strong>14</strong> <strong>N_SUB</strong> 	N_SUB (data, scalar) is a number of subject to be generated.
	%  <strong>15</strong> <strong>DIRECTORY</strong> 	DIRECTORY (data, string) is the directory to export the FUN subject group files.
	%  <strong>16</strong> <strong>GRAPH_DATA</strong> 	GRAPH_DATA (result, cell) is the Small_World_Graph.
	%  <strong>17</strong> <strong>SIM_DATA</strong> 	SIM_DATA (result, cell) is the simulated data using the Watts–Strogatz model.
	%  <strong>18</strong> <strong>SIM_GR</strong> 	SIM_GR (result, item) is the group of subjectFUN for those simulated data.
	%  <strong>19</strong> <strong>EXPORT_DATA</strong> 	EXPORT_DATA (query, empty) exports a group of subjects with the simulated fMRI data to a series of XLSX file.
	%
	% DataSimulator methods (constructor):
	%  DataSimulator - constructor
	%
	% DataSimulator methods:
	%  set - sets values of a property
	%  check - checks the values of all properties
	%  getr - returns the raw value of a property
	%  get - returns the value of a property
	%  memorize - returns the value of a property and memorizes it
	%             (for RESULT, QUERY, and EVANESCENT properties)
	%  getPropSeed - returns the seed of a property
	%  isLocked - returns whether a property is locked
	%  lock - locks unreversibly a property
	%  isChecked - returns whether a property is checked
	%  checked - sets a property to checked
	%  unchecked - sets a property to NOT checked
	%
	% DataSimulator methods (display):
	%  tostring - string with information about the data simulator
	%  disp - displays information about the data simulator
	%  tree - displays the tree of the data simulator
	%
	% DataSimulator methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two data simulator are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the data simulator
	%
	% DataSimulator methods (save/load, Static):
	%  save - saves BRAPH2 data simulator as b2 file
	%  load - loads a BRAPH2 data simulator from a b2 file
	%
	% DataSimulator method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the data simulator
	%
	% DataSimulator method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the data simulator
	%
	% DataSimulator methods (inspection, Static):
	%  getClass - returns the class of the data simulator
	%  getSubclasses - returns all subclasses of DataSimulator
	%  getProps - returns the property list of the data simulator
	%  getPropNumber - returns the property number of the data simulator
	%  existsProp - checks whether property exists/error
	%  existsTag - checks whether tag exists/error
	%  getPropProp - returns the property number of a property
	%  getPropTag - returns the tag of a property
	%  getPropCategory - returns the category of a property
	%  getPropFormat - returns the format of a property
	%  getPropDescription - returns the description of a property
	%  getPropSettings - returns the settings of a property
	%  getPropDefault - returns the default value of a property
	%  getPropDefaultConditioned - returns the conditioned default value of a property
	%  checkProp - checks whether a value has the correct format/error
	%
	% DataSimulator methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% DataSimulator methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% DataSimulator methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% DataSimulator methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatTag - returns the tag of a format
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% To print full list of constants, click here <a href="matlab:metaclass = ?DataSimulator; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">DataSimulator constants</a>.
	%
	%
	% See also create_data_NN_CLA_FUN_XLS.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		BA = 9; %CET: Computational Efficiency Trick
		BA_TAG = 'BA';
		BA_CATEGORY = 3;
		BA_FORMAT = 8;
		
		P = 10; %CET: Computational Efficiency Trick
		P_TAG = 'P';
		P_CATEGORY = 3;
		P_FORMAT = 11;
		
		D = 11; %CET: Computational Efficiency Trick
		D_TAG = 'D';
		D_CATEGORY = 3;
		D_FORMAT = 11;
		
		N = 12; %CET: Computational Efficiency Trick
		N_TAG = 'N';
		N_CATEGORY = 3;
		N_FORMAT = 11;
		
		TIME_STEP = 13; %CET: Computational Efficiency Trick
		TIME_STEP_TAG = 'TIME_STEP';
		TIME_STEP_CATEGORY = 3;
		TIME_STEP_FORMAT = 11;
		
		N_SUB = 14; %CET: Computational Efficiency Trick
		N_SUB_TAG = 'N_SUB';
		N_SUB_CATEGORY = 4;
		N_SUB_FORMAT = 11;
		
		DIRECTORY = 15; %CET: Computational Efficiency Trick
		DIRECTORY_TAG = 'DIRECTORY';
		DIRECTORY_CATEGORY = 4;
		DIRECTORY_FORMAT = 2;
		
		GRAPH_DATA = 16; %CET: Computational Efficiency Trick
		GRAPH_DATA_TAG = 'GRAPH_DATA';
		GRAPH_DATA_CATEGORY = 5;
		GRAPH_DATA_FORMAT = 16;
		
		SIM_DATA = 17; %CET: Computational Efficiency Trick
		SIM_DATA_TAG = 'SIM_DATA';
		SIM_DATA_CATEGORY = 5;
		SIM_DATA_FORMAT = 16;
		
		SIM_GR = 18; %CET: Computational Efficiency Trick
		SIM_GR_TAG = 'SIM_GR';
		SIM_GR_CATEGORY = 5;
		SIM_GR_FORMAT = 8;
		
		EXPORT_DATA = 19; %CET: Computational Efficiency Trick
		EXPORT_DATA_TAG = 'EXPORT_DATA';
		EXPORT_DATA_CATEGORY = 6;
		EXPORT_DATA_FORMAT = 1;
	end
	methods % constructor
		function dsim = DataSimulator(varargin)
			%DataSimulator() creates a data simulator.
			%
			% DataSimulator(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% DataSimulator(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of DataSimulator properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the data simulator.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the data simulator.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the data simulator.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the data simulator.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the data simulator.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of data simulator.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the data simulator.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>BA</strong> 	BA (parameter, item) is a brain atlas.
			%  <strong>10</strong> <strong>P</strong> 	P (parameter, scalar) is a number of probability for a Watts–Strogatz model.
			%  <strong>11</strong> <strong>D</strong> 	D (parameter, scalar) is a number of degree for a Watts–Strogatz model.
			%  <strong>12</strong> <strong>N</strong> 	N (parameter, scalar) is a number of node for a Watts–Strogatz model.
			%  <strong>13</strong> <strong>TIME_STEP</strong> 	TIME_STEP (parameter, scalar) is time_steps.
			%  <strong>14</strong> <strong>N_SUB</strong> 	N_SUB (data, scalar) is a number of subject to be generated.
			%  <strong>15</strong> <strong>DIRECTORY</strong> 	DIRECTORY (data, string) is the directory to export the FUN subject group files.
			%  <strong>16</strong> <strong>GRAPH_DATA</strong> 	GRAPH_DATA (result, cell) is the Small_World_Graph.
			%  <strong>17</strong> <strong>SIM_DATA</strong> 	SIM_DATA (result, cell) is the simulated data using the Watts–Strogatz model.
			%  <strong>18</strong> <strong>SIM_GR</strong> 	SIM_GR (result, item) is the group of subjectFUN for those simulated data.
			%  <strong>19</strong> <strong>EXPORT_DATA</strong> 	EXPORT_DATA (query, empty) exports a group of subjects with the simulated fMRI data to a series of XLSX file.
			%
			% See also Category, Format.
			
			dsim = dsim@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the data simulator.
			%
			% BUILD = DataSimulator.GETBUILD() returns the build of 'DataSimulator'.
			%
			% Alternative forms to call this method are:
			%  BUILD = DSIM.GETBUILD() returns the build of the data simulator DSIM.
			%  BUILD = Element.GETBUILD(DSIM) returns the build of 'DSIM'.
			%  BUILD = Element.GETBUILD('DataSimulator') returns the build of 'DataSimulator'.
			%
			% Note that the Element.GETBUILD(DSIM) and Element.GETBUILD('DataSimulator')
			%  are less computationally efficient.
			
			build = 1;
		end
		function dsim_class = getClass()
			%GETCLASS returns the class of the data simulator.
			%
			% CLASS = DataSimulator.GETCLASS() returns the class 'DataSimulator'.
			%
			% Alternative forms to call this method are:
			%  CLASS = DSIM.GETCLASS() returns the class of the data simulator DSIM.
			%  CLASS = Element.GETCLASS(DSIM) returns the class of 'DSIM'.
			%  CLASS = Element.GETCLASS('DataSimulator') returns 'DataSimulator'.
			%
			% Note that the Element.GETCLASS(DSIM) and Element.GETCLASS('DataSimulator')
			%  are less computationally efficient.
			
			dsim_class = 'DataSimulator';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the data simulator.
			%
			% LIST = DataSimulator.GETSUBCLASSES() returns all subclasses of 'DataSimulator'.
			%
			% Alternative forms to call this method are:
			%  LIST = DSIM.GETSUBCLASSES() returns all subclasses of the data simulator DSIM.
			%  LIST = Element.GETSUBCLASSES(DSIM) returns all subclasses of 'DSIM'.
			%  LIST = Element.GETSUBCLASSES('DataSimulator') returns all subclasses of 'DataSimulator'.
			%
			% Note that the Element.GETSUBCLASSES(DSIM) and Element.GETSUBCLASSES('DataSimulator')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'DataSimulator' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of data simulator.
			%
			% PROPS = DataSimulator.GETPROPS() returns the property list of data simulator
			%  as a row vector.
			%
			% PROPS = DataSimulator.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = DSIM.GETPROPS([CATEGORY]) returns the property list of the data simulator DSIM.
			%  PROPS = Element.GETPROPS(DSIM[, CATEGORY]) returns the property list of 'DSIM'.
			%  PROPS = Element.GETPROPS('DataSimulator'[, CATEGORY]) returns the property list of 'DataSimulator'.
			%
			% Note that the Element.GETPROPS(DSIM) and Element.GETPROPS('DataSimulator')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = [4 9 10 11 12 13];
				case 4 % Category.DATA
					prop_list = [5 14 15];
				case 5 % Category.RESULT
					prop_list = [16 17 18];
				case 6 % Category.QUERY
					prop_list = [8 19];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of data simulator.
			%
			% N = DataSimulator.GETPROPNUMBER() returns the property number of data simulator.
			%
			% N = DataSimulator.GETPROPNUMBER(CATEGORY) returns the property number of data simulator
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = DSIM.GETPROPNUMBER([CATEGORY]) returns the property number of the data simulator DSIM.
			%  N = Element.GETPROPNUMBER(DSIM) returns the property number of 'DSIM'.
			%  N = Element.GETPROPNUMBER('DataSimulator') returns the property number of 'DataSimulator'.
			%
			% Note that the Element.GETPROPNUMBER(DSIM) and Element.GETPROPNUMBER('DataSimulator')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 19;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 6;
				case 4 % Category.DATA
					prop_number = 3;
				case 5 % Category.RESULT
					prop_number = 3;
				case 6 % Category.QUERY
					prop_number = 2;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in data simulator/error.
			%
			% CHECK = DataSimulator.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = DSIM.EXISTSPROP(PROP) checks whether PROP exists for DSIM.
			%  CHECK = Element.EXISTSPROP(DSIM, PROP) checks whether PROP exists for DSIM.
			%  CHECK = Element.EXISTSPROP(DataSimulator, PROP) checks whether PROP exists for DataSimulator.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:DataSimulator:WrongInput]
			%
			% Alternative forms to call this method are:
			%  DSIM.EXISTSPROP(PROP) throws error if PROP does NOT exist for DSIM.
			%   Error id: [BRAPH2:DataSimulator:WrongInput]
			%  Element.EXISTSPROP(DSIM, PROP) throws error if PROP does NOT exist for DSIM.
			%   Error id: [BRAPH2:DataSimulator:WrongInput]
			%  Element.EXISTSPROP(DataSimulator, PROP) throws error if PROP does NOT exist for DataSimulator.
			%   Error id: [BRAPH2:DataSimulator:WrongInput]
			%
			% Note that the Element.EXISTSPROP(DSIM) and Element.EXISTSPROP('DataSimulator')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 19 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':DataSimulator:' 'WrongInput'], ...
					['BRAPH2' ':DataSimulator:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for DataSimulator.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in data simulator/error.
			%
			% CHECK = DataSimulator.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = DSIM.EXISTSTAG(TAG) checks whether TAG exists for DSIM.
			%  CHECK = Element.EXISTSTAG(DSIM, TAG) checks whether TAG exists for DSIM.
			%  CHECK = Element.EXISTSTAG(DataSimulator, TAG) checks whether TAG exists for DataSimulator.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:DataSimulator:WrongInput]
			%
			% Alternative forms to call this method are:
			%  DSIM.EXISTSTAG(TAG) throws error if TAG does NOT exist for DSIM.
			%   Error id: [BRAPH2:DataSimulator:WrongInput]
			%  Element.EXISTSTAG(DSIM, TAG) throws error if TAG does NOT exist for DSIM.
			%   Error id: [BRAPH2:DataSimulator:WrongInput]
			%  Element.EXISTSTAG(DataSimulator, TAG) throws error if TAG does NOT exist for DataSimulator.
			%   Error id: [BRAPH2:DataSimulator:WrongInput]
			%
			% Note that the Element.EXISTSTAG(DSIM) and Element.EXISTSTAG('DataSimulator')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'BA'  'P'  'D'  'N'  'TIME_STEP'  'N_SUB'  'DIRECTORY'  'GRAPH_DATA'  'SIM_DATA'  'SIM_GR'  'EXPORT_DATA' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':DataSimulator:' 'WrongInput'], ...
					['BRAPH2' ':DataSimulator:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for DataSimulator.'] ...
					)
			end
		end
		function prop = getPropProp(pointer)
			%GETPROPPROP returns the property number of a property.
			%
			% PROP = Element.GETPROPPROP(PROP) returns PROP, i.e., the 
			%  property number of the property PROP.
			%
			% PROP = Element.GETPROPPROP(TAG) returns the property number 
			%  of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PROPERTY = DSIM.GETPROPPROP(POINTER) returns property number of POINTER of DSIM.
			%  PROPERTY = Element.GETPROPPROP(DataSimulator, POINTER) returns property number of POINTER of DataSimulator.
			%  PROPERTY = DSIM.GETPROPPROP(DataSimulator, POINTER) returns property number of POINTER of DataSimulator.
			%
			% Note that the Element.GETPROPPROP(DSIM) and Element.GETPROPPROP('DataSimulator')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'BA'  'P'  'D'  'N'  'TIME_STEP'  'N_SUB'  'DIRECTORY'  'GRAPH_DATA'  'SIM_DATA'  'SIM_GR'  'EXPORT_DATA' })); % tag = pointer %CET: Computational Efficiency Trick
			else % numeric
				prop = pointer;
			end
		end
		function tag = getPropTag(pointer)
			%GETPROPTAG returns the tag of a property.
			%
			% TAG = Element.GETPROPTAG(PROP) returns the tag TAG of the 
			%  property PROP.
			%
			% TAG = Element.GETPROPTAG(TAG) returns TAG, i.e. the tag of 
			%  the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  TAG = DSIM.GETPROPTAG(POINTER) returns tag of POINTER of DSIM.
			%  TAG = Element.GETPROPTAG(DataSimulator, POINTER) returns tag of POINTER of DataSimulator.
			%  TAG = DSIM.GETPROPTAG(DataSimulator, POINTER) returns tag of POINTER of DataSimulator.
			%
			% Note that the Element.GETPROPTAG(DSIM) and Element.GETPROPTAG('DataSimulator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				datasimulator_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'BA'  'P'  'D'  'N'  'TIME_STEP'  'N_SUB'  'DIRECTORY'  'GRAPH_DATA'  'SIM_DATA'  'SIM_GR'  'EXPORT_DATA' };
				tag = datasimulator_tag_list{pointer}; % prop = pointer
			end
		end
		function prop_category = getPropCategory(pointer)
			%GETPROPCATEGORY returns the category of a property.
			%
			% CATEGORY = Element.GETPROPCATEGORY(PROP) returns the category of the
			%  property PROP.
			%
			% CATEGORY = Element.GETPROPCATEGORY(TAG) returns the category of the
			%  property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CATEGORY = DSIM.GETPROPCATEGORY(POINTER) returns category of POINTER of DSIM.
			%  CATEGORY = Element.GETPROPCATEGORY(DataSimulator, POINTER) returns category of POINTER of DataSimulator.
			%  CATEGORY = DSIM.GETPROPCATEGORY(DataSimulator, POINTER) returns category of POINTER of DataSimulator.
			%
			% Note that the Element.GETPROPCATEGORY(DSIM) and Element.GETPROPCATEGORY('DataSimulator')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = DataSimulator.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			datasimulator_category_list = { 1  1  1  3  4  2  2  6  3  3  3  3  3  4  4  5  5  5  6 };
			prop_category = datasimulator_category_list{prop};
		end
		function prop_format = getPropFormat(pointer)
			%GETPROPFORMAT returns the format of a property.
			%
			% FORMAT = Element.GETPROPFORMAT(PROP) returns the
			%  format of the property PROP.
			%
			% FORMAT = Element.GETPROPFORMAT(TAG) returns the
			%  format of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  FORMAT = DSIM.GETPROPFORMAT(POINTER) returns format of POINTER of DSIM.
			%  FORMAT = Element.GETPROPFORMAT(DataSimulator, POINTER) returns format of POINTER of DataSimulator.
			%  FORMAT = DSIM.GETPROPFORMAT(DataSimulator, POINTER) returns format of POINTER of DataSimulator.
			%
			% Note that the Element.GETPROPFORMAT(DSIM) and Element.GETPROPFORMAT('DataSimulator')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = DataSimulator.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			datasimulator_format_list = { 2  2  2  8  2  2  2  2  8  11  11  11  11  11  2  16  16  8  1 };
			prop_format = datasimulator_format_list{prop};
		end
		function prop_description = getPropDescription(pointer)
			%GETPROPDESCRIPTION returns the description of a property.
			%
			% DESCRIPTION = Element.GETPROPDESCRIPTION(PROP) returns the
			%  description of the property PROP.
			%
			% DESCRIPTION = Element.GETPROPDESCRIPTION(TAG) returns the
			%  description of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DESCRIPTION = DSIM.GETPROPDESCRIPTION(POINTER) returns description of POINTER of DSIM.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(DataSimulator, POINTER) returns description of POINTER of DataSimulator.
			%  DESCRIPTION = DSIM.GETPROPDESCRIPTION(DataSimulator, POINTER) returns description of POINTER of DataSimulator.
			%
			% Note that the Element.GETPROPDESCRIPTION(DSIM) and Element.GETPROPDESCRIPTION('DataSimulator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = DataSimulator.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			datasimulator_description_list = { 'ELCLASS (constant, string) is the class of the data simulator.'  'NAME (constant, string) is the name of the data simulator.'  'DESCRIPTION (constant, string) is the description of the data simulator.'  'TEMPLATE (parameter, item) is the template of the data simulator.'  'ID (data, string) is a few-letter code for the data simulator.'  'LABEL (metadata, string) is an extended label of data simulator.'  'NOTES (metadata, string) are some specific notes about the data simulator.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'BA (parameter, item) is a brain atlas.'  'P (parameter, scalar) is a number of probability for a Watts–Strogatz model.'  'D (parameter, scalar) is a number of degree for a Watts–Strogatz model.'  'N (parameter, scalar) is a number of node for a Watts–Strogatz model.'  'TIME_STEP (parameter, scalar) is time_steps.'  'N_SUB (data, scalar) is a number of subject to be generated.'  'DIRECTORY (data, string) is the directory to export the FUN subject group files.'  'GRAPH_DATA (result, cell) is the Small_World_Graph.'  'SIM_DATA (result, cell) is the simulated data using the Watts–Strogatz model.'  'SIM_GR (result, item) is the group of subjectFUN for those simulated data.'  'EXPORT_DATA (query, empty) exports a group of subjects with the simulated fMRI data to a series of XLSX file.' };
			prop_description = datasimulator_description_list{prop};
		end
		function prop_settings = getPropSettings(pointer)
			%GETPROPSETTINGS returns the settings of a property.
			%
			% SETTINGS = Element.GETPROPSETTINGS(PROP) returns the
			%  settings of the property PROP.
			%
			% SETTINGS = Element.GETPROPSETTINGS(TAG) returns the
			%  settings of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  SETTINGS = DSIM.GETPROPSETTINGS(POINTER) returns settings of POINTER of DSIM.
			%  SETTINGS = Element.GETPROPSETTINGS(DataSimulator, POINTER) returns settings of POINTER of DataSimulator.
			%  SETTINGS = DSIM.GETPROPSETTINGS(DataSimulator, POINTER) returns settings of POINTER of DataSimulator.
			%
			% Note that the Element.GETPROPSETTINGS(DSIM) and Element.GETPROPSETTINGS('DataSimulator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = DataSimulator.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % DataSimulator.BA
					prop_settings = 'BrainAtlas';
				case 10 % DataSimulator.P
					prop_settings = Format.getFormatSettings(11);
				case 11 % DataSimulator.D
					prop_settings = Format.getFormatSettings(11);
				case 12 % DataSimulator.N
					prop_settings = Format.getFormatSettings(11);
				case 13 % DataSimulator.TIME_STEP
					prop_settings = Format.getFormatSettings(11);
				case 14 % DataSimulator.N_SUB
					prop_settings = Format.getFormatSettings(11);
				case 15 % DataSimulator.DIRECTORY
					prop_settings = Format.getFormatSettings(2);
				case 16 % DataSimulator.GRAPH_DATA
					prop_settings = Format.getFormatSettings(16);
				case 17 % DataSimulator.SIM_DATA
					prop_settings = Format.getFormatSettings(16);
				case 18 % DataSimulator.SIM_GR
					prop_settings = 'Group';
				case 19 % DataSimulator.EXPORT_DATA
					prop_settings = Format.getFormatSettings(1);
				case 4 % DataSimulator.TEMPLATE
					prop_settings = 'DataSimulator';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = DataSimulator.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = DataSimulator.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = DSIM.GETPROPDEFAULT(POINTER) returns the default value of POINTER of DSIM.
			%  DEFAULT = Element.GETPROPDEFAULT(DataSimulator, POINTER) returns the default value of POINTER of DataSimulator.
			%  DEFAULT = DSIM.GETPROPDEFAULT(DataSimulator, POINTER) returns the default value of POINTER of DataSimulator.
			%
			% Note that the Element.GETPROPDEFAULT(DSIM) and Element.GETPROPDEFAULT('DataSimulator')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = DataSimulator.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % DataSimulator.BA
					prop_default = Format.getFormatDefault(8, DataSimulator.getPropSettings(prop));
				case 10 % DataSimulator.P
					prop_default = 0.2;
				case 11 % DataSimulator.D
					prop_default = 4;
				case 12 % DataSimulator.N
					prop_default = 68;
				case 13 % DataSimulator.TIME_STEP
					prop_default = 100;
				case 14 % DataSimulator.N_SUB
					prop_default = 10;
				case 15 % DataSimulator.DIRECTORY
					prop_default = fileparts(which('BRAPH2.LAUNCHER'));
				case 16 % DataSimulator.GRAPH_DATA
					prop_default = Format.getFormatDefault(16, DataSimulator.getPropSettings(prop));
				case 17 % DataSimulator.SIM_DATA
					prop_default = Format.getFormatDefault(16, DataSimulator.getPropSettings(prop));
				case 18 % DataSimulator.SIM_GR
					prop_default = Format.getFormatDefault(8, DataSimulator.getPropSettings(prop));
				case 19 % DataSimulator.EXPORT_DATA
					prop_default = Format.getFormatDefault(1, DataSimulator.getPropSettings(prop));
				case 1 % DataSimulator.ELCLASS
					prop_default = 'DataSimulator';
				case 2 % DataSimulator.NAME
					prop_default = 'Neural Network Dataset';
				case 3 % DataSimulator.DESCRIPTION
					prop_default = 'XXX';
				case 4 % DataSimulator.TEMPLATE
					prop_default = Format.getFormatDefault(8, DataSimulator.getPropSettings(prop));
				case 6 % DataSimulator.LABEL
					prop_default = 'DataSimulator label';
				case 7 % DataSimulator.NOTES
					prop_default = 'DataSimulator notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = DataSimulator.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = DataSimulator.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = DSIM.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of DSIM.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(DataSimulator, POINTER) returns the conditioned default value of POINTER of DataSimulator.
			%  DEFAULT = DSIM.GETPROPDEFAULTCONDITIONED(DataSimulator, POINTER) returns the conditioned default value of POINTER of DataSimulator.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(DSIM) and Element.GETPROPDEFAULTCONDITIONED('DataSimulator')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = DataSimulator.getPropProp(pointer);
			
			prop_default = DataSimulator.conditioning(prop, DataSimulator.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = DSIM.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = DSIM.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of DSIM.
			%  CHECK = Element.CHECKPROP(DataSimulator, PROP, VALUE) checks VALUE format for PROP of DataSimulator.
			%  CHECK = DSIM.CHECKPROP(DataSimulator, PROP, VALUE) checks VALUE format for PROP of DataSimulator.
			% 
			% DSIM.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:DataSimulator:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DSIM.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of DSIM.
			%   Error id: BRAPH2:DataSimulator:WrongInput
			%  Element.CHECKPROP(DataSimulator, PROP, VALUE) throws error if VALUE has not a valid format for PROP of DataSimulator.
			%   Error id: BRAPH2:DataSimulator:WrongInput
			%  DSIM.CHECKPROP(DataSimulator, PROP, VALUE) throws error if VALUE has not a valid format for PROP of DataSimulator.
			%   Error id: BRAPH2:DataSimulator:WrongInput]
			% 
			% Note that the Element.CHECKPROP(DSIM) and Element.CHECKPROP('DataSimulator')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = DataSimulator.getPropProp(pointer);
			
			switch prop
				case 9 % DataSimulator.BA
					check = Format.checkFormat(8, value, DataSimulator.getPropSettings(prop));
				case 10 % DataSimulator.P
					check = Format.checkFormat(11, value, DataSimulator.getPropSettings(prop));
				case 11 % DataSimulator.D
					check = Format.checkFormat(11, value, DataSimulator.getPropSettings(prop));
				case 12 % DataSimulator.N
					check = Format.checkFormat(11, value, DataSimulator.getPropSettings(prop));
				case 13 % DataSimulator.TIME_STEP
					check = Format.checkFormat(11, value, DataSimulator.getPropSettings(prop));
				case 14 % DataSimulator.N_SUB
					check = Format.checkFormat(11, value, DataSimulator.getPropSettings(prop));
				case 15 % DataSimulator.DIRECTORY
					check = Format.checkFormat(2, value, DataSimulator.getPropSettings(prop));
				case 16 % DataSimulator.GRAPH_DATA
					check = Format.checkFormat(16, value, DataSimulator.getPropSettings(prop));
				case 17 % DataSimulator.SIM_DATA
					check = Format.checkFormat(16, value, DataSimulator.getPropSettings(prop));
				case 18 % DataSimulator.SIM_GR
					check = Format.checkFormat(8, value, DataSimulator.getPropSettings(prop));
				case 19 % DataSimulator.EXPORT_DATA
					check = Format.checkFormat(1, value, DataSimulator.getPropSettings(prop));
				case 4 % DataSimulator.TEMPLATE
					check = Format.checkFormat(8, value, DataSimulator.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':DataSimulator:' 'WrongInput'], ...
					['BRAPH2' ':DataSimulator:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' DataSimulator.getPropTag(prop) ' (' DataSimulator.getFormatTag(DataSimulator.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postprocessing
		function postprocessing(dsim, prop)
			%POSTPROCESSING postprocessesing after setting.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing of PROP after setting. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% The postprocessing of all properties occurs each time set is called.
			%
			% See also conditioning, preset, checkProp, postset, calculateValue,
			%  checkValue.
			
			switch prop
				case 9 % DataSimulator.BA
					ba = dsim.get('BA');
					if ba.get('BR_DICT').get('LENGTH') == 0
					    n = dsim.get('N');
					    brain_regions = cell(1, n);
					    for i = 1:n
					        brain_regions{i} = BrainRegion( ...
					            'ID', ['BR' num2str(i)], ... % 随机取ID，这里用编号
					            'LABEL', ['Region' num2str(i)], ... % 随机取LABEL，这里用编号
					            'NOTES', ['notes' num2str(i)], ... % NOTE 按照对应n的数字起名字
					            'X', rand()*100 - 50, ... % X 坐标在[-50, 50] 之间随机取值
					            'Y', rand()*100 - 50, ... % Y 坐标在[-50, 50] 之间随机取值
					            'Z', rand()*100 - 50 ... % Z 坐标在[-50, 50] 之间随机取值
					            );
					    end
					
					    % Create BrainAtlas with dynamically generated BrainRegions
					    ba = BrainAtlas( ...
					        'ID', 'GeneratedAtlas', ...
					        'LABEL', 'Dynamic Brain Atlas', ...
					        'NOTES', 'Automatically generated brain atlas', ...
					        'BR_DICT', IndexedDictionary('IT_CLASS', 'BrainRegion', 'IT_LIST', brain_regions) ...
					        );
					    dsim.set('BA', ba);
					end
					
				otherwise
					if prop <= 8
						postprocessing@ConcreteElement(dsim, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(dsim, prop, varargin)
			%CALCULATEVALUE calculates the value of a property.
			%
			% VALUE = CALCULATEVALUE(EL, PROP) calculates the value of the property
			%  PROP. It works only with properties with 5,
			%  6, and 7. By default this function
			%  returns the default value for the prop and should be implemented in the
			%  subclasses of Element when needed.
			%
			% VALUE = CALCULATEVALUE(EL, PROP, VARARGIN) works with properties with
			%  6.
			%
			% See also getPropDefaultConditioned, conditioning, preset, checkProp,
			%  postset, postprocessing, checkValue.
			
			switch prop
				case 16 % DataSimulator.GRAPH_DATA
					rng_settings_ = rng(); rng(dsim.getPropSeed(16), 'twister')
					
					% Get parameters %%%YUXIN
					n = dsim.get('N'); % Number of nodes in the network
					d = dsim.get('D'); % Number of nearest neighbor connections per node (must be even)
					p = dsim.get('P'); % Probability of rewiring edges
					time_step = dsim.get('TIME_STEP'); % time_steps
					n_sub = dsim.get('N_SUB'); % Number of samples
					
					% Initialize a cell array to store multiple samples
					sim_data = cell(1, n_sub);
					
					% Generate N_SUB sets of data
					for sub = 1:n_sub
					    % 1. Generate adjacency matrix G using the Watts-Strogatz model
					    G = zeros(n); % Create an n x n zero matrix
					    half_d = d / 2; % Number of nearest neighbors each node connects to
					
					    % 2. Connect nearest neighbors (ring structure)
					    for i = 1:n
					        for j = 1:half_d
					            neighbor = mod(i + j - 1, n) + 1; % Compute the neighboring node
					            G(i, neighbor) = 1; % Connect i and neighbor
					            G(neighbor, i) = 1; % Ensure the adjacency matrix is symmetric
					        end
					    end
					
					    % 3. Perform random rewiring
					    for i = 1:n
					        for j = 1:half_d
					            if rand < p
					                % Disconnect the original connection
					                neighbor = mod(i + j - 1, n) + 1;
					                G(i, neighbor) = 0;
					                G(neighbor, i) = 0;
					
					                % Select a new node for connection
					                new_neighbor = i;
					                while new_neighbor == i || G(i, new_neighbor) == 1
					                    new_neighbor = randi(n); % Generate a new random neighbor
					                end
					                G(i, new_neighbor) = 1; % Connect to the new neighbor
					                G(new_neighbor, i) = 1;
					            end
					        end
					    end
					    graph_data{sub} = G;
					end
					
					% 8. 返回所有生成的数据
					value = graph_data;
					
					rng(rng_settings_)
					
				case 17 % DataSimulator.SIM_DATA
					rng_settings_ = rng(); rng(dsim.getPropSeed(17), 'twister')
					
					% Get parameters  %%%YUXIN
					n_sub = dsim.get('N_SUB'); % Number of samples
					n = dsim.get('N'); % Number of nodes in the network
					time_step = dsim.get('TIME_STEP'); % <-- 这里添加获取时间步长变量
					graph_data = dsim.get('GRAPH_DATA');% 获取 cell 数组
					
					% Generate N_SUB sets of data
					for sub = 1:n_sub
					
					    graph_data_cell = graph_data{sub}; % 取出当前 subject 的邻接矩阵
					
					    % 4. Compute a positive definite covariance matrix (ensure usability)
					    graph_data_cell(1:n+1:end) = 1; % Set diagonal elements to 1 to prevent non-positive definiteness
					    cov_matrix = graph_data_cell * graph_data_cell'; % Compute the positive definite covariance matrix
					
					    % 5. Generate time series data
					    mu = ones(1, n); % Set the mean vector
					    R = mvnrnd(mu, cov_matrix, time_step); % Generate a time series following a multivariate normal distribution
					
					    % 6. Normalize the time series
					    mean_R = mean(R);
					    std_R = std(R);
					    R = (R - mean_R) ./ std_R; % Normalize the data
					
					    % 7. Store in the cell array
					    sim_data{sub} = R;
					end
					
					% 8. 返回所有生成的数据
					value = sim_data;
					
					rng(rng_settings_)
					
				case 18 % DataSimulator.SIM_GR
					rng_settings_ = rng(); rng(dsim.getPropSeed(18), 'twister')
					
					%%%YUXIN
					
					% for i = 1:n_sub
					%     sim_data{i} = dsim.get('SIM_DATA');
					% end
					
					sim_data = dsim.get('SIM_DATA');
					n_sub = dsim.get('N_SUB');
					p = dsim.get('P');
					
					% Generate n BrainRegion instances
					n = dsim.get('N')% 获取节点数
					
					
					
					% % create dummy ba
					% br1 = BrainRegion( ...
					%     'ID', 'ISF', ...
					%     'LABEL', 'superiorfrontal', ...
					%     'NOTES', 'notes1', ...
					%     'X', -12.6, ...
					%     'Y', 22.9, ...
					%     'Z', 42.4 ...
					%     );
					% br2 = BrainRegion( ...
					%     'ID', 'lFP', ...
					%     'LABEL', 'frontalpole', ...
					%     'NOTES', 'notes2', ...
					%     'X', -8.6, ...
					%     'Y', 61.7, ...
					%     'Z', -8.7 ...
					%     );
					% br3 = BrainRegion( ...
					%     'ID', 'lRMF', ...
					%     'LABEL', 'rostralmiddlefrontal', ...
					%     'NOTES', 'notes3', ...
					%     'X', -31.3, ...
					%     'Y', 41.2, ...
					%     'Z', 16.5 ...
					%     );
					% br4 = BrainRegion( ...
					%     'ID', 'lCMF', ...
					%     'LABEL', 'caudalmiddlefrontal', ...
					%     'NOTES', 'notes4', ...
					%     'X', -34.6, ...
					%     'Y', 10.2, ...
					%     'Z', 42.8 ...
					%     );
					% br5 = BrainRegion( ...
					%     'ID', 'lPOB', ...
					%     'LABEL', 'parsorbitalis', ...
					%     'NOTES', 'notes5', ...
					%     'X', -41, ...
					%     'Y', 38.8, ...
					%     'Z', -11.1 ...
					%     );
					% 
					% ba = BrainAtlas( ...
					%     'ID', 'TestToSaveCoolID', ...
					%     'LABEL', 'Brain Atlas', ...
					%     'NOTES', 'Brain atlas notes', ...
					%     'BR_DICT', IndexedDictionary('IT_CLASS', 'BrainRegion', 'IT_LIST', {br1, br2, br3, br4, br5}) ...
					%     );
					% 
					ba = dsim.get('BA');
					
					
					for i = 1:n_sub
					    subs{i} = SubjectFUN( ...
					        'ID', ['Subject FUN ' num2str(i)], ...
					        'LABEL', ['Subject FUN ' num2str(i)], ...
					        'NOTES', ['Notes on Subject FUN ' num2str(i)], ...
					        'BA', ba, ...
					        'FUN', sim_data{i} ...
					        );
					    subs{i}.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'P', 'V', p))
					end
					
					value = Group( ...
					    'ID', 'GR FUN', ...
					    'LABEL', 'Group label', ...
					    'NOTES', 'Group notes', ...
					    'SUB_CLASS', 'SubjectFUN', ...
					    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN', 'IT_LIST', subs) ...
					    );
					
					rng(rng_settings_)
					
				case 19 % DataSimulator.EXPORT_DATA
					%%%YUXIN
					directory = dsim.get('DIRECTORY');
					if ~exist(directory, 'dir')
					    mkdir(directory)
					end
					
					gr = dsim.get('SIM_GR');
					ex = ExporterGroupSubjectFUN_XLS( ...
					    'DIRECTORY', directory, ...
					    'GR', gr ...
					    );
					ex.get('SAVE');
					
					ba = dsim.get('BA');
					file = [directory filesep 'atlas.xlsx'];
					ex = ExporterBrainAtlasXLS( ...
					    'FILE', file, ...
					    'BA', ba ...
					    );
					ex.get('SAVE');
					
					
					value={};
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(dsim, prop, varargin{:});
					else
						value = calculateValue@Element(dsim, prop, varargin{:});
					end
			end
			
		end
	end
end
