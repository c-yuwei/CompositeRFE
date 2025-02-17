classdef NNxMLP_FeatureImportanceAcrossFUN < NNxMLP_FeatureImportance
	%NNxMLP_FeatureImportanceAcrossFUN provides feature importance analysis for multi-layer perceptron (MLP) across all functional time series.
	% It is a subclass of <a href="matlab:help NNxMLP_FeatureImportance">NNxMLP_FeatureImportance</a>.
	%
	% Neural Network Feature Importance Across Functional Data (NNxMLP_FeatureImportanceAcrossFUN) 
	%  assesses the importance of brain regions by measuring the increase in model error 
	%  when its corresponding functional time series values are randomly shuffled.
	%
	% NNxMLP_FeatureImportanceAcrossFUN methods (constructor):
	%  NNxMLP_FeatureImportanceAcrossFUN - constructor
	%
	% NNxMLP_FeatureImportanceAcrossFUN methods:
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
	% NNxMLP_FeatureImportanceAcrossFUN methods (display):
	%  tostring - string with information about the neural network feature importace for multi-layer perceptron
	%  disp - displays information about the neural network feature importace for multi-layer perceptron
	%  tree - displays the tree of the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportanceAcrossFUN methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two neural network feature importace for multi-layer perceptron are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportanceAcrossFUN methods (save/load, Static):
	%  save - saves BRAPH2 neural network feature importace for multi-layer perceptron as b2 file
	%  load - loads a BRAPH2 neural network feature importace for multi-layer perceptron from a b2 file
	%
	% NNxMLP_FeatureImportanceAcrossFUN method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportanceAcrossFUN method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportanceAcrossFUN methods (inspection, Static):
	%  getClass - returns the class of the neural network feature importace for multi-layer perceptron
	%  getSubclasses - returns all subclasses of NNxMLP_FeatureImportanceAcrossFUN
	%  getProps - returns the property list of the neural network feature importace for multi-layer perceptron
	%  getPropNumber - returns the property number of the neural network feature importace for multi-layer perceptron
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
	% NNxMLP_FeatureImportanceAcrossFUN methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNxMLP_FeatureImportanceAcrossFUN methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNxMLP_FeatureImportanceAcrossFUN methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNxMLP_FeatureImportanceAcrossFUN methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNxMLP_FeatureImportanceAcrossFUN; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNxMLP_FeatureImportanceAcrossFUN constants</a>.
	%
	%
	% See also NNDataPoint_FUN_CLA, NNDataPoint_FUN_REG, NNxMLP_FeatureImportanceAcrossMeasures.
	%
	% BUILD BRAPH2 BRAPH2.BUILD class_name 1
	
	properties (Constant) % properties
		BA = NNxMLP_FeatureImportance.getPropNumber() + 1;
		BA_TAG = 'BA';
		BA_CATEGORY = Category.PARAMETER;
		BA_FORMAT = Format.ITEM;
		
		GR_FUN_LIST = NNxMLP_FeatureImportance.getPropNumber() + 2;
		GR_FUN_LIST_TAG = 'GR_FUN_LIST';
		GR_FUN_LIST_CATEGORY = Category.DATA;
		GR_FUN_LIST_FORMAT = Format.ITEMLIST;
		
		AE_TEMPLATE = NNxMLP_FeatureImportance.getPropNumber() + 3;
		AE_TEMPLATE_TAG = 'AE_TEMPLATE';
		AE_TEMPLATE_CATEGORY = Category.DATA;
		AE_TEMPLATE_FORMAT = Format.ITEM;
	end
	methods % constructor
		function nnfiam = NNxMLP_FeatureImportanceAcrossFUN(varargin)
			%NNxMLP_FeatureImportanceAcrossFUN() creates a neural network feature importace for multi-layer perceptron.
			%
			% NNxMLP_FeatureImportanceAcrossFUN(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNxMLP_FeatureImportanceAcrossFUN(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			nnfiam = nnfiam@NNxMLP_FeatureImportance(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the neural network feature importace for multi-layer perceptron.
			%
			% BUILD = NNxMLP_FeatureImportanceAcrossFUN.GETBUILD() returns the build of 'NNxMLP_FeatureImportanceAcrossFUN'.
			%
			% Alternative forms to call this method are:
			%  BUILD = NNFIAM.GETBUILD() returns the build of the neural network feature importace for multi-layer perceptron NNFIAM.
			%  BUILD = Element.GETBUILD(NNFIAM) returns the build of 'NNFIAM'.
			%  BUILD = Element.GETBUILD('NNxMLP_FeatureImportanceAcrossFUN') returns the build of 'NNxMLP_FeatureImportanceAcrossFUN'.
			%
			% Note that the Element.GETBUILD(NNFIAM) and Element.GETBUILD('NNxMLP_FeatureImportanceAcrossFUN')
			%  are less computationally efficient.
			
			build = 1;
		end
		function nnfiam_class = getClass()
			%GETCLASS returns the class of the neural network feature importace for multi-layer perceptron.
			%
			% CLASS = NNxMLP_FeatureImportanceAcrossFUN.GETCLASS() returns the class 'NNxMLP_FeatureImportanceAcrossFUN'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNFIAM.GETCLASS() returns the class of the neural network feature importace for multi-layer perceptron NNFIAM.
			%  CLASS = Element.GETCLASS(NNFIAM) returns the class of 'NNFIAM'.
			%  CLASS = Element.GETCLASS('NNxMLP_FeatureImportanceAcrossFUN') returns 'NNxMLP_FeatureImportanceAcrossFUN'.
			%
			% Note that the Element.GETCLASS(NNFIAM) and Element.GETCLASS('NNxMLP_FeatureImportanceAcrossFUN')
			%  are less computationally efficient.
			
			nnfiam_class = 'NNxMLP_FeatureImportanceAcrossFUN';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the neural network feature importace for multi-layer perceptron.
			%
			% LIST = NNxMLP_FeatureImportanceAcrossFUN.GETSUBCLASSES() returns all subclasses of 'NNxMLP_FeatureImportanceAcrossFUN'.
			%
			% Alternative forms to call this method are:
			%  LIST = NNFIAM.GETSUBCLASSES() returns all subclasses of the neural network feature importace for multi-layer perceptron NNFIAM.
			%  LIST = Element.GETSUBCLASSES(NNFIAM) returns all subclasses of 'NNFIAM'.
			%  LIST = Element.GETSUBCLASSES('NNxMLP_FeatureImportanceAcrossFUN') returns all subclasses of 'NNxMLP_FeatureImportanceAcrossFUN'.
			%
			% Note that the Element.GETSUBCLASSES(NNFIAM) and Element.GETSUBCLASSES('NNxMLP_FeatureImportanceAcrossFUN')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNxMLP_FeatureImportanceAcrossFUN', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of neural network feature importace for multi-layer perceptron.
			%
			% PROPS = NNxMLP_FeatureImportanceAcrossFUN.GETPROPS() returns the property list of neural network feature importace for multi-layer perceptron
			%  as a row vector.
			%
			% PROPS = NNxMLP_FeatureImportanceAcrossFUN.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNFIAM.GETPROPS([CATEGORY]) returns the property list of the neural network feature importace for multi-layer perceptron NNFIAM.
			%  PROPS = Element.GETPROPS(NNFIAM[, CATEGORY]) returns the property list of 'NNFIAM'.
			%  PROPS = Element.GETPROPS('NNxMLP_FeatureImportanceAcrossFUN'[, CATEGORY]) returns the property list of 'NNxMLP_FeatureImportanceAcrossFUN'.
			%
			% Note that the Element.GETPROPS(NNFIAM) and Element.GETPROPS('NNxMLP_FeatureImportanceAcrossFUN')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					NNxMLP_FeatureImportance.getProps() ...
						NNxMLP_FeatureImportanceAcrossFUN.BA ...
						NNxMLP_FeatureImportanceAcrossFUN.GR_FUN_LIST ...
						NNxMLP_FeatureImportanceAcrossFUN.AE_TEMPLATE ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						NNxMLP_FeatureImportance.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						NNxMLP_FeatureImportance.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						NNxMLP_FeatureImportance.getProps(Category.PARAMETER) ...
						NNxMLP_FeatureImportanceAcrossFUN.BA ...
						];
				case Category.DATA
					prop_list = [ ...
						NNxMLP_FeatureImportance.getProps(Category.DATA) ...
						NNxMLP_FeatureImportanceAcrossFUN.GR_FUN_LIST ...
						NNxMLP_FeatureImportanceAcrossFUN.AE_TEMPLATE ...
						];
				case Category.RESULT
					prop_list = [
						NNxMLP_FeatureImportance.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						NNxMLP_FeatureImportance.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						NNxMLP_FeatureImportance.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						NNxMLP_FeatureImportance.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						NNxMLP_FeatureImportance.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of neural network feature importace for multi-layer perceptron.
			%
			% N = NNxMLP_FeatureImportanceAcrossFUN.GETPROPNUMBER() returns the property number of neural network feature importace for multi-layer perceptron.
			%
			% N = NNxMLP_FeatureImportanceAcrossFUN.GETPROPNUMBER(CATEGORY) returns the property number of neural network feature importace for multi-layer perceptron
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NNFIAM.GETPROPNUMBER([CATEGORY]) returns the property number of the neural network feature importace for multi-layer perceptron NNFIAM.
			%  N = Element.GETPROPNUMBER(NNFIAM) returns the property number of 'NNFIAM'.
			%  N = Element.GETPROPNUMBER('NNxMLP_FeatureImportanceAcrossFUN') returns the property number of 'NNxMLP_FeatureImportanceAcrossFUN'.
			%
			% Note that the Element.GETPROPNUMBER(NNFIAM) and Element.GETPROPNUMBER('NNxMLP_FeatureImportanceAcrossFUN')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNxMLP_FeatureImportanceAcrossFUN.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in neural network feature importace for multi-layer perceptron/error.
			%
			% CHECK = NNxMLP_FeatureImportanceAcrossFUN.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNFIAM.EXISTSPROP(PROP) checks whether PROP exists for NNFIAM.
			%  CHECK = Element.EXISTSPROP(NNFIAM, PROP) checks whether PROP exists for NNFIAM.
			%  CHECK = Element.EXISTSPROP(NNxMLP_FeatureImportanceAcrossFUN, PROP) checks whether PROP exists for NNxMLP_FeatureImportanceAcrossFUN.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNxMLP_FeatureImportanceAcrossFUN:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNFIAM.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNFIAM.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceAcrossFUN:WrongInput]
			%  Element.EXISTSPROP(NNFIAM, PROP) throws error if PROP does NOT exist for NNFIAM.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceAcrossFUN:WrongInput]
			%  Element.EXISTSPROP(NNxMLP_FeatureImportanceAcrossFUN, PROP) throws error if PROP does NOT exist for NNxMLP_FeatureImportanceAcrossFUN.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceAcrossFUN:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NNFIAM) and Element.EXISTSPROP('NNxMLP_FeatureImportanceAcrossFUN')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNxMLP_FeatureImportanceAcrossFUN.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNxMLP_FeatureImportanceAcrossFUN:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNxMLP_FeatureImportanceAcrossFUN:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNxMLP_FeatureImportanceAcrossFUN.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in neural network feature importace for multi-layer perceptron/error.
			%
			% CHECK = NNxMLP_FeatureImportanceAcrossFUN.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNFIAM.EXISTSTAG(TAG) checks whether TAG exists for NNFIAM.
			%  CHECK = Element.EXISTSTAG(NNFIAM, TAG) checks whether TAG exists for NNFIAM.
			%  CHECK = Element.EXISTSTAG(NNxMLP_FeatureImportanceAcrossFUN, TAG) checks whether TAG exists for NNxMLP_FeatureImportanceAcrossFUN.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNxMLP_FeatureImportanceAcrossFUN:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNFIAM.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNFIAM.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceAcrossFUN:WrongInput]
			%  Element.EXISTSTAG(NNFIAM, TAG) throws error if TAG does NOT exist for NNFIAM.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceAcrossFUN:WrongInput]
			%  Element.EXISTSTAG(NNxMLP_FeatureImportanceAcrossFUN, TAG) throws error if TAG does NOT exist for NNxMLP_FeatureImportanceAcrossFUN.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceAcrossFUN:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NNFIAM) and Element.EXISTSTAG('NNxMLP_FeatureImportanceAcrossFUN')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nnxmlp_featureimportanceacrossfun_tag_list = cellfun(@(x) NNxMLP_FeatureImportanceAcrossFUN.getPropTag(x), num2cell(NNxMLP_FeatureImportanceAcrossFUN.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nnxmlp_featureimportanceacrossfun_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNxMLP_FeatureImportanceAcrossFUN:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNxMLP_FeatureImportanceAcrossFUN:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNxMLP_FeatureImportanceAcrossFUN.'] ...
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
			%  PROPERTY = NNFIAM.GETPROPPROP(POINTER) returns property number of POINTER of NNFIAM.
			%  PROPERTY = Element.GETPROPPROP(NNxMLP_FeatureImportanceAcrossFUN, POINTER) returns property number of POINTER of NNxMLP_FeatureImportanceAcrossFUN.
			%  PROPERTY = NNFIAM.GETPROPPROP(NNxMLP_FeatureImportanceAcrossFUN, POINTER) returns property number of POINTER of NNxMLP_FeatureImportanceAcrossFUN.
			%
			% Note that the Element.GETPROPPROP(NNFIAM) and Element.GETPROPPROP('NNxMLP_FeatureImportanceAcrossFUN')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nnxmlp_featureimportanceacrossfun_tag_list = cellfun(@(x) NNxMLP_FeatureImportanceAcrossFUN.getPropTag(x), num2cell(NNxMLP_FeatureImportanceAcrossFUN.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nnxmlp_featureimportanceacrossfun_tag_list)); % tag = pointer
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
			%  TAG = NNFIAM.GETPROPTAG(POINTER) returns tag of POINTER of NNFIAM.
			%  TAG = Element.GETPROPTAG(NNxMLP_FeatureImportanceAcrossFUN, POINTER) returns tag of POINTER of NNxMLP_FeatureImportanceAcrossFUN.
			%  TAG = NNFIAM.GETPROPTAG(NNxMLP_FeatureImportanceAcrossFUN, POINTER) returns tag of POINTER of NNxMLP_FeatureImportanceAcrossFUN.
			%
			% Note that the Element.GETPROPTAG(NNFIAM) and Element.GETPROPTAG('NNxMLP_FeatureImportanceAcrossFUN')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case NNxMLP_FeatureImportanceAcrossFUN.BA
						tag = NNxMLP_FeatureImportanceAcrossFUN.BA_TAG;
					case NNxMLP_FeatureImportanceAcrossFUN.GR_FUN_LIST
						tag = NNxMLP_FeatureImportanceAcrossFUN.GR_FUN_LIST_TAG;
					case NNxMLP_FeatureImportanceAcrossFUN.AE_TEMPLATE
						tag = NNxMLP_FeatureImportanceAcrossFUN.AE_TEMPLATE_TAG;
					otherwise
						tag = getPropTag@NNxMLP_FeatureImportance(prop);
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
			%  CATEGORY = NNFIAM.GETPROPCATEGORY(POINTER) returns category of POINTER of NNFIAM.
			%  CATEGORY = Element.GETPROPCATEGORY(NNxMLP_FeatureImportanceAcrossFUN, POINTER) returns category of POINTER of NNxMLP_FeatureImportanceAcrossFUN.
			%  CATEGORY = NNFIAM.GETPROPCATEGORY(NNxMLP_FeatureImportanceAcrossFUN, POINTER) returns category of POINTER of NNxMLP_FeatureImportanceAcrossFUN.
			%
			% Note that the Element.GETPROPCATEGORY(NNFIAM) and Element.GETPROPCATEGORY('NNxMLP_FeatureImportanceAcrossFUN')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceAcrossFUN.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportanceAcrossFUN.BA
					prop_category = NNxMLP_FeatureImportanceAcrossFUN.BA_CATEGORY;
				case NNxMLP_FeatureImportanceAcrossFUN.GR_FUN_LIST
					prop_category = NNxMLP_FeatureImportanceAcrossFUN.GR_FUN_LIST_CATEGORY;
				case NNxMLP_FeatureImportanceAcrossFUN.AE_TEMPLATE
					prop_category = NNxMLP_FeatureImportanceAcrossFUN.AE_TEMPLATE_CATEGORY;
				otherwise
					prop_category = getPropCategory@NNxMLP_FeatureImportance(prop);
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
			%  FORMAT = NNFIAM.GETPROPFORMAT(POINTER) returns format of POINTER of NNFIAM.
			%  FORMAT = Element.GETPROPFORMAT(NNxMLP_FeatureImportanceAcrossFUN, POINTER) returns format of POINTER of NNxMLP_FeatureImportanceAcrossFUN.
			%  FORMAT = NNFIAM.GETPROPFORMAT(NNxMLP_FeatureImportanceAcrossFUN, POINTER) returns format of POINTER of NNxMLP_FeatureImportanceAcrossFUN.
			%
			% Note that the Element.GETPROPFORMAT(NNFIAM) and Element.GETPROPFORMAT('NNxMLP_FeatureImportanceAcrossFUN')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceAcrossFUN.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportanceAcrossFUN.BA
					prop_format = NNxMLP_FeatureImportanceAcrossFUN.BA_FORMAT;
				case NNxMLP_FeatureImportanceAcrossFUN.GR_FUN_LIST
					prop_format = NNxMLP_FeatureImportanceAcrossFUN.GR_FUN_LIST_FORMAT;
				case NNxMLP_FeatureImportanceAcrossFUN.AE_TEMPLATE
					prop_format = NNxMLP_FeatureImportanceAcrossFUN.AE_TEMPLATE_FORMAT;
				otherwise
					prop_format = getPropFormat@NNxMLP_FeatureImportance(prop);
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
			%  DESCRIPTION = NNFIAM.GETPROPDESCRIPTION(POINTER) returns description of POINTER of NNFIAM.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNxMLP_FeatureImportanceAcrossFUN, POINTER) returns description of POINTER of NNxMLP_FeatureImportanceAcrossFUN.
			%  DESCRIPTION = NNFIAM.GETPROPDESCRIPTION(NNxMLP_FeatureImportanceAcrossFUN, POINTER) returns description of POINTER of NNxMLP_FeatureImportanceAcrossFUN.
			%
			% Note that the Element.GETPROPDESCRIPTION(NNFIAM) and Element.GETPROPDESCRIPTION('NNxMLP_FeatureImportanceAcrossFUN')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceAcrossFUN.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportanceAcrossFUN.BA
					prop_description = 'BA (parameter, item) is the brain atlas.';
				case NNxMLP_FeatureImportanceAcrossFUN.GR_FUN_LIST
					prop_description = 'GR_FUN_LIST (data, itemlist) is the list of FUN group, which also defines the subject class SubjectFUN.';
				case NNxMLP_FeatureImportanceAcrossFUN.AE_TEMPLATE
					prop_description = 'AE_TEMPLATE (data, item) is the list of FUN group, which also defines the subject class SubjectFUN.';
				case NNxMLP_FeatureImportanceAcrossFUN.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.';
				case NNxMLP_FeatureImportanceAcrossFUN.NAME
					prop_description = 'NAME (constant, string) is the name of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.';
				case NNxMLP_FeatureImportanceAcrossFUN.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.';
				case NNxMLP_FeatureImportanceAcrossFUN.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.';
				case NNxMLP_FeatureImportanceAcrossFUN.ID
					prop_description = 'ID (data, string) is a few-letter code of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.';
				case NNxMLP_FeatureImportanceAcrossFUN.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.';
				case NNxMLP_FeatureImportanceAcrossFUN.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.';
				case NNxMLP_FeatureImportanceAcrossFUN.COMP_FEATURE_INDICES
					prop_description = 'COMP_FEATURE_INDICES (result, cell) provides the indices of brain regions, represented as a cell array containing sets of feature indices, such as {[1], [2], [3], ...}.';
				case NNxMLP_FeatureImportanceAcrossFUN.D_SHUFFLED
					prop_description = 'D_SHUFFLED (query, item) generates a shuffled version of the dataset where the time series of one brain region is replaced with random values drawn from a distribution with the same mean and standard deviation as the orginal ones.';
				otherwise
					prop_description = getPropDescription@NNxMLP_FeatureImportance(prop);
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
			%  SETTINGS = NNFIAM.GETPROPSETTINGS(POINTER) returns settings of POINTER of NNFIAM.
			%  SETTINGS = Element.GETPROPSETTINGS(NNxMLP_FeatureImportanceAcrossFUN, POINTER) returns settings of POINTER of NNxMLP_FeatureImportanceAcrossFUN.
			%  SETTINGS = NNFIAM.GETPROPSETTINGS(NNxMLP_FeatureImportanceAcrossFUN, POINTER) returns settings of POINTER of NNxMLP_FeatureImportanceAcrossFUN.
			%
			% Note that the Element.GETPROPSETTINGS(NNFIAM) and Element.GETPROPSETTINGS('NNxMLP_FeatureImportanceAcrossFUN')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceAcrossFUN.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportanceAcrossFUN.BA
					prop_settings = 'BrainAtlas';
				case NNxMLP_FeatureImportanceAcrossFUN.GR_FUN_LIST
					prop_settings = 'Group';
				case NNxMLP_FeatureImportanceAcrossFUN.AE_TEMPLATE
					prop_settings = 'AnalyzeEnsemble';
				case NNxMLP_FeatureImportanceAcrossFUN.TEMPLATE
					prop_settings = 'NNxMLP_FeatureImportanceAcrossFUN';
				case NNxMLP_FeatureImportanceAcrossFUN.D_SHUFFLED
					prop_settings = 'NNDataset';
				otherwise
					prop_settings = getPropSettings@NNxMLP_FeatureImportance(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNxMLP_FeatureImportanceAcrossFUN.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNxMLP_FeatureImportanceAcrossFUN.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNFIAM.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNFIAM.
			%  DEFAULT = Element.GETPROPDEFAULT(NNxMLP_FeatureImportanceAcrossFUN, POINTER) returns the default value of POINTER of NNxMLP_FeatureImportanceAcrossFUN.
			%  DEFAULT = NNFIAM.GETPROPDEFAULT(NNxMLP_FeatureImportanceAcrossFUN, POINTER) returns the default value of POINTER of NNxMLP_FeatureImportanceAcrossFUN.
			%
			% Note that the Element.GETPROPDEFAULT(NNFIAM) and Element.GETPROPDEFAULT('NNxMLP_FeatureImportanceAcrossFUN')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNxMLP_FeatureImportanceAcrossFUN.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportanceAcrossFUN.BA
					prop_default = Format.getFormatDefault(Format.ITEM, NNxMLP_FeatureImportanceAcrossFUN.getPropSettings(prop));
				case NNxMLP_FeatureImportanceAcrossFUN.GR_FUN_LIST
					prop_default = Format.getFormatDefault(Format.ITEMLIST, NNxMLP_FeatureImportanceAcrossFUN.getPropSettings(prop));
				case NNxMLP_FeatureImportanceAcrossFUN.AE_TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNxMLP_FeatureImportanceAcrossFUN.getPropSettings(prop));
				case NNxMLP_FeatureImportanceAcrossFUN.ELCLASS
					prop_default = 'NNxMLP_FeatureImportanceAcrossFUN';
				case NNxMLP_FeatureImportanceAcrossFUN.NAME
					prop_default = 'Feature Importace for Multi-layer Perceptron Across Functional Time Series';
				case NNxMLP_FeatureImportanceAcrossFUN.DESCRIPTION
					prop_default = 'Neural Network Feature Importance Across Functional Data (NNxMLP_FeatureImportanceAcrossFUN) assesses the importance of brain regions by measuring the increase in model error when its corresponding functional time series values are randomly shuffled.';
				case NNxMLP_FeatureImportanceAcrossFUN.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNxMLP_FeatureImportanceAcrossFUN.getPropSettings(prop));
				case NNxMLP_FeatureImportanceAcrossFUN.ID
					prop_default = 'NNxMLP_FeatureImportanceAcrossFUN ID';
				case NNxMLP_FeatureImportanceAcrossFUN.LABEL
					prop_default = 'NNxMLP_FeatureImportanceAcrossFUN label';
				case NNxMLP_FeatureImportanceAcrossFUN.NOTES
					prop_default = 'NNxMLP_FeatureImportanceAcrossFUN notes';
				case NNxMLP_FeatureImportanceAcrossFUN.D_SHUFFLED
					prop_default = Format.getFormatDefault(Format.ITEM, NNxMLP_FeatureImportanceAcrossFUN.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@NNxMLP_FeatureImportance(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNxMLP_FeatureImportanceAcrossFUN.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNxMLP_FeatureImportanceAcrossFUN.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNFIAM.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNFIAM.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNxMLP_FeatureImportanceAcrossFUN, POINTER) returns the conditioned default value of POINTER of NNxMLP_FeatureImportanceAcrossFUN.
			%  DEFAULT = NNFIAM.GETPROPDEFAULTCONDITIONED(NNxMLP_FeatureImportanceAcrossFUN, POINTER) returns the conditioned default value of POINTER of NNxMLP_FeatureImportanceAcrossFUN.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NNFIAM) and Element.GETPROPDEFAULTCONDITIONED('NNxMLP_FeatureImportanceAcrossFUN')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNxMLP_FeatureImportanceAcrossFUN.getPropProp(pointer);
			
			prop_default = NNxMLP_FeatureImportanceAcrossFUN.conditioning(prop, NNxMLP_FeatureImportanceAcrossFUN.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NNFIAM.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NNFIAM.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NNFIAM.
			%  CHECK = Element.CHECKPROP(NNxMLP_FeatureImportanceAcrossFUN, PROP, VALUE) checks VALUE format for PROP of NNxMLP_FeatureImportanceAcrossFUN.
			%  CHECK = NNFIAM.CHECKPROP(NNxMLP_FeatureImportanceAcrossFUN, PROP, VALUE) checks VALUE format for PROP of NNxMLP_FeatureImportanceAcrossFUN.
			% 
			% NNFIAM.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNxMLP_FeatureImportanceAcrossFUN:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNFIAM.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNFIAM.
			%   Error id: €BRAPH2.STR€:NNxMLP_FeatureImportanceAcrossFUN:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNxMLP_FeatureImportanceAcrossFUN, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNxMLP_FeatureImportanceAcrossFUN.
			%   Error id: €BRAPH2.STR€:NNxMLP_FeatureImportanceAcrossFUN:€BRAPH2.WRONG_INPUT€
			%  NNFIAM.CHECKPROP(NNxMLP_FeatureImportanceAcrossFUN, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNxMLP_FeatureImportanceAcrossFUN.
			%   Error id: €BRAPH2.STR€:NNxMLP_FeatureImportanceAcrossFUN:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(NNFIAM) and Element.CHECKPROP('NNxMLP_FeatureImportanceAcrossFUN')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNxMLP_FeatureImportanceAcrossFUN.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportanceAcrossFUN.BA % __NNxMLP_FeatureImportanceAcrossFUN.BA__
					check = Format.checkFormat(Format.ITEM, value, NNxMLP_FeatureImportanceAcrossFUN.getPropSettings(prop));
				case NNxMLP_FeatureImportanceAcrossFUN.GR_FUN_LIST % __NNxMLP_FeatureImportanceAcrossFUN.GR_FUN_LIST__
					check = Format.checkFormat(Format.ITEMLIST, value, NNxMLP_FeatureImportanceAcrossFUN.getPropSettings(prop));
				case NNxMLP_FeatureImportanceAcrossFUN.AE_TEMPLATE % __NNxMLP_FeatureImportanceAcrossFUN.AE_TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNxMLP_FeatureImportanceAcrossFUN.getPropSettings(prop));
				case NNxMLP_FeatureImportanceAcrossFUN.TEMPLATE % __NNxMLP_FeatureImportanceAcrossFUN.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNxMLP_FeatureImportanceAcrossFUN.getPropSettings(prop));
				case NNxMLP_FeatureImportanceAcrossFUN.D_SHUFFLED % __NNxMLP_FeatureImportanceAcrossFUN.D_SHUFFLED__
					check = Format.checkFormat(Format.ITEM, value, NNxMLP_FeatureImportanceAcrossFUN.getPropSettings(prop));
				otherwise
					if prop <= NNxMLP_FeatureImportance.getPropNumber()
						check = checkProp@NNxMLP_FeatureImportance(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNxMLP_FeatureImportanceAcrossFUN:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNxMLP_FeatureImportanceAcrossFUN:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNxMLP_FeatureImportanceAcrossFUN.getPropTag(prop) ' (' NNxMLP_FeatureImportanceAcrossFUN.getFormatTag(NNxMLP_FeatureImportanceAcrossFUN.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(nnfiam, prop, varargin)
			%CALCULATEVALUE calculates the value of a property.
			%
			% VALUE = CALCULATEVALUE(EL, PROP) calculates the value of the property
			%  PROP. It works only with properties with Category.RESULT,
			%  Category.QUERY, and Category.EVANESCENT. By default this function
			%  returns the default value for the prop and should be implemented in the
			%  subclasses of Element when needed.
			%
			% VALUE = CALCULATEVALUE(EL, PROP, VARARGIN) works with properties with
			%  Category.QUERY.
			%
			% See also getPropDefaultConditioned, conditioning, preset, checkProp,
			%  postset, postprocessing, checkValue.
			
			switch prop
				case NNxMLP_FeatureImportanceAcrossFUN.COMP_FEATURE_INDICES % __NNxMLP_FeatureImportanceAcrossFUN.COMP_FEATURE_INDICES__
					rng_settings_ = rng(); rng(nnfiam.getPropSeed(NNxMLP_FeatureImportanceAcrossFUN.COMP_FEATURE_INDICES), 'twister')
					
					% yuxin 
					% Instruction: the value of this one should be the brain node index, such as {[1], [2],
					% [3], ...} for the momemnt.
					ba = nnfiam.get('BA');
					num_brain_region = ba.get('BR_DICT').get('LENGTH');
					value = num2cell(1:num_brain_region);
					
					rng(rng_settings_)
					
				case NNxMLP_FeatureImportanceAcrossFUN.D_SHUFFLED % __NNxMLP_FeatureImportanceAcrossFUN.D_SHUFFLED__
					% yuxin
					% Instruction: D_SHUFFLED will consist of NNDataPointMLP_Shuffled 
					% with inputs being adjacency matrices derived from correlations
					% between the time series of nodes, with one of the node time series shuffled.
					if isempty(varargin)
					    value = NNDataset();
					    return
					end
					comp_feature_combination = varargin{1}; % the composite indexes
					
					gr_fun_list = nnfiam.get('GR_FUN_LIST');
					
					% combine all grs to single gr
					comb_sub_list = {};
					for i = 1:length(gr_fun_list)
					    current_gr = gr_fun_list{i};
					    sub_list = current_gr.get('SUB_DICT').get('IT_LIST');
					    comb_sub_list = [comb_sub_list sub_list];
					end
					
					% shuffle the time series
					for i = 1:length(comb_sub_list)
					    current_subj = comb_sub_list{i};
					    fun = current_subj.get('FUN'); % time_length x brain_regions
					    for j = 1:length(comp_feature_combination)
					        br_idx = comp_feature_combination(j);
					        permuted_value = squeeze(normrnd(mean(fun(:, br_idx)), std(fun(:, br_idx)), squeeze(size(fun(:, br_idx)))));
					        fun(:, br_idx) = permuted_value;
					    end
					    permuted_sub_list{i} = SubjectFUN('ID', current_subj.get('ID'), ...
					        'BA', current_subj.get('BA'), ...
					        'FUN', fun);
					end
					
					permuted_sub_dict = IndexedDictionary(...
					    'IT_CLASS', 'SubjectFUN', ...
					    'IT_LIST', permuted_sub_list ...
					    );
					
					permuted_gr = Group('SUB_DICT', permuted_sub_dict);
					
					% get analyzeEnsemble
					ae_template = nnfiam.get('AE_TEMPLATE');
					ae = eval([ae_template.getClass() '(''TEMPLATE'', ae_template);']);
					ae.set('GR', permuted_gr);
					ae.memorize('G_DICT')
					
					shuffled_dp_list = cellfun(@(x) NNDataPointMLP_Shuffled( ...
					    'ID', x.get('ID'), ...
					    'SHUFFLED_INPUT', {transpose(nnfiam.get('FLATTEN_CELL', x.get('A')))}), ...
					    ae.get('G_DICT').get('IT_LIST'), ...
					    'UniformOutput', false);
					
					shuffled_dp_dict = IndexedDictionary(...
					    'IT_CLASS', 'NNDataPointMLP_Shuffled', ...
					    'IT_LIST', shuffled_dp_list ...
					    );
					
					value = NNDataset( ...
					    'DP_CLASS', 'NNDataPointMLP_Shuffled', ...
					    'DP_DICT', shuffled_dp_dict ...
					    );
					
				otherwise
					if prop <= NNxMLP_FeatureImportance.getPropNumber()
						value = calculateValue@NNxMLP_FeatureImportance(nnfiam, prop, varargin{:});
					else
						value = calculateValue@Element(nnfiam, prop, varargin{:});
					end
			end
			
		end
	end
end
