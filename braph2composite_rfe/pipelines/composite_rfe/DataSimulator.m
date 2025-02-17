classdef DataSimulator < ConcreteElement
	%DataSimulator is a simulator for simulating example data.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% XXX
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
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	properties (Constant) % properties
		P = ConcreteElement.getPropNumber() + 1;
		P_TAG = 'P';
		P_CATEGORY = Category.PARAMETER;
		P_FORMAT = Format.SCALAR;
		
		D = ConcreteElement.getPropNumber() + 2;
		D_TAG = 'D';
		D_CATEGORY = Category.PARAMETER;
		D_FORMAT = Format.SCALAR;
		
		N = ConcreteElement.getPropNumber() + 3;
		N_TAG = 'N';
		N_CATEGORY = Category.PARAMETER;
		N_FORMAT = Format.SCALAR;
		
		DIRECTORY = ConcreteElement.getPropNumber() + 4;
		DIRECTORY_TAG = 'DIRECTORY';
		DIRECTORY_CATEGORY = Category.DATA;
		DIRECTORY_FORMAT = Format.STRING;
		
		EX = ConcreteElement.getPropNumber() + 5;
		EX_TAG = 'EX';
		EX_CATEGORY = Category.DATA;
		EX_FORMAT = Format.ITEM;
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
			
			subclass_list = subclasses('DataSimulator', [], [], true);
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
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						DataSimulator.P ...
						DataSimulator.D ...
						DataSimulator.N ...
						DataSimulator.DIRECTORY ...
						DataSimulator.EX ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConcreteElement.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						DataSimulator.P ...
						DataSimulator.D ...
						DataSimulator.N ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						DataSimulator.DIRECTORY ...
						DataSimulator.EX ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						];
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
			
			prop_number = numel(DataSimulator.getProps(varargin{:}));
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
			
			check = any(prop == DataSimulator.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':DataSimulator:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':DataSimulator:' BRAPH2.WRONG_INPUT '\n' ...
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
			
			datasimulator_tag_list = cellfun(@(x) DataSimulator.getPropTag(x), num2cell(DataSimulator.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, datasimulator_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':DataSimulator:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':DataSimulator:' BRAPH2.WRONG_INPUT '\n' ...
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
				datasimulator_tag_list = cellfun(@(x) DataSimulator.getPropTag(x), num2cell(DataSimulator.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, datasimulator_tag_list)); % tag = pointer
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
				prop = pointer;
				
				switch prop
					case DataSimulator.P
						tag = DataSimulator.P_TAG;
					case DataSimulator.D
						tag = DataSimulator.D_TAG;
					case DataSimulator.N
						tag = DataSimulator.N_TAG;
					case DataSimulator.DIRECTORY
						tag = DataSimulator.DIRECTORY_TAG;
					case DataSimulator.EX
						tag = DataSimulator.EX_TAG;
					otherwise
						tag = getPropTag@ConcreteElement(prop);
				end
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
			
			switch prop
				case DataSimulator.P
					prop_category = DataSimulator.P_CATEGORY;
				case DataSimulator.D
					prop_category = DataSimulator.D_CATEGORY;
				case DataSimulator.N
					prop_category = DataSimulator.N_CATEGORY;
				case DataSimulator.DIRECTORY
					prop_category = DataSimulator.DIRECTORY_CATEGORY;
				case DataSimulator.EX
					prop_category = DataSimulator.EX_CATEGORY;
				otherwise
					prop_category = getPropCategory@ConcreteElement(prop);
			end
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
			
			switch prop
				case DataSimulator.P
					prop_format = DataSimulator.P_FORMAT;
				case DataSimulator.D
					prop_format = DataSimulator.D_FORMAT;
				case DataSimulator.N
					prop_format = DataSimulator.N_FORMAT;
				case DataSimulator.DIRECTORY
					prop_format = DataSimulator.DIRECTORY_FORMAT;
				case DataSimulator.EX
					prop_format = DataSimulator.EX_FORMAT;
				otherwise
					prop_format = getPropFormat@ConcreteElement(prop);
			end
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
			
			switch prop
				case DataSimulator.P
					prop_description = 'P (parameter, scalar) is a number of probability for a Watts–Strogatz model.';
				case DataSimulator.D
					prop_description = 'D (parameter, scalar) is a number of degree for a Watts–Strogatz model.';
				case DataSimulator.N
					prop_description = 'N (parameter, scalar) is a number of node for a Watts–Strogatz model.';
				case DataSimulator.DIRECTORY
					prop_description = 'DIRECTORY (data, string) is the directory to export the FUN subject group files.';
				case DataSimulator.EX
					prop_description = 'EX (data, item) exports a group of subjects with the simulated fMRI data to a series of XLSX file.';
				case DataSimulator.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the data simulator.';
				case DataSimulator.NAME
					prop_description = 'NAME (constant, string) is the name of the data simulator.';
				case DataSimulator.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the data simulator.';
				case DataSimulator.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the data simulator.';
				case DataSimulator.ID
					prop_description = 'ID (data, string) is a few-letter code for the data simulator.';
				case DataSimulator.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of data simulator.';
				case DataSimulator.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the data simulator.';
				otherwise
					prop_description = getPropDescription@ConcreteElement(prop);
			end
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
			
			switch prop
				case DataSimulator.P
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case DataSimulator.D
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case DataSimulator.N
					prop_settings = 'Group';
				case DataSimulator.DIRECTORY
					prop_settings = Format.getFormatSettings(Format.STRING);
				case DataSimulator.EX
					prop_settings = 'ExporterGroupSubjectFUN_XLS';
				case DataSimulator.TEMPLATE
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
			
			switch prop
				case DataSimulator.P
					prop_default = 0.2;
				case DataSimulator.D
					prop_default = 4;
				case DataSimulator.N
					prop_default = 68

N_SUB (data, scalar) is a number of subject to be generated.;
				case DataSimulator.DIRECTORY
					prop_default = fileparts(which('BRAPH2.LAUNCHER'));
				case DataSimulator.EX
					prop_default = Format.getFormatDefault(Format.ITEM, DataSimulator.getPropSettings(prop));
				case DataSimulator.ELCLASS
					prop_default = 'DataSimulator';
				case DataSimulator.NAME
					prop_default = 'Neural Network Dataset';
				case DataSimulator.DESCRIPTION
					prop_default = 'XXX';
				case DataSimulator.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, DataSimulator.getPropSettings(prop));
				case DataSimulator.LABEL
					prop_default = 'DataSimulator label';
				case DataSimulator.NOTES
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
			%  Error id: €BRAPH2.STR€:DataSimulator:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DSIM.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of DSIM.
			%   Error id: €BRAPH2.STR€:DataSimulator:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(DataSimulator, PROP, VALUE) throws error if VALUE has not a valid format for PROP of DataSimulator.
			%   Error id: €BRAPH2.STR€:DataSimulator:€BRAPH2.WRONG_INPUT€
			%  DSIM.CHECKPROP(DataSimulator, PROP, VALUE) throws error if VALUE has not a valid format for PROP of DataSimulator.
			%   Error id: €BRAPH2.STR€:DataSimulator:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(DSIM) and Element.CHECKPROP('DataSimulator')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = DataSimulator.getPropProp(pointer);
			
			switch prop
				case DataSimulator.P % __DataSimulator.P__
					check = Format.checkFormat(Format.SCALAR, value, DataSimulator.getPropSettings(prop));
				case DataSimulator.D % __DataSimulator.D__
					check = Format.checkFormat(Format.SCALAR, value, DataSimulator.getPropSettings(prop));
				case DataSimulator.N % __DataSimulator.N__
					check = Format.checkFormat(Format.SCALAR, value, DataSimulator.getPropSettings(prop));
				case DataSimulator.DIRECTORY % __DataSimulator.DIRECTORY__
					check = Format.checkFormat(Format.STRING, value, DataSimulator.getPropSettings(prop));
				case DataSimulator.EX % __DataSimulator.EX__
					check = Format.checkFormat(Format.ITEM, value, DataSimulator.getPropSettings(prop));
				case DataSimulator.TEMPLATE % __DataSimulator.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, DataSimulator.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':DataSimulator:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':DataSimulator:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' DataSimulator.getPropTag(prop) ' (' DataSimulator.getFormatTag(DataSimulator.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(dsim, prop)
			%POSTSET postprocessing after a prop has been set.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing after PROP has been set. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% This postprocessing occurs only when PROP is set.
			%
			% See also conditioning, preset, checkProp, postprocessing, calculateValue,
			%  checkValue.
			
			switch prop
				case DataSimulator.EX % __DataSimulator.EX__
					if isa(dsim.getr('EX'), 'NoValue')
					    ex = ExporterGroupSubjectFUN_XLS('DIRECTORY', dsim.get('DIRECTORY'), dsim.get('SIM_GR'), gr);
					    dsim.set('EXPORTER', ex);
					end
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						postset@ConcreteElement(dsim, prop);
					end
			end
		end
	end
end
