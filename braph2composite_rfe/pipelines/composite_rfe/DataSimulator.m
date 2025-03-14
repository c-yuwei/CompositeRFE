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
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>BA</strong> 	BA (parameter, item) is a brain atlas.
	%  <strong>11</strong> <strong>P_MAX</strong> 	P_MAX (parameter, scalar) is the maximum probability for simulating Watts–Strogatz models.
	%  <strong>12</strong> <strong>P_MIN</strong> 	P_MIN (parameter, scalar) is the minimum probability for simulating Watts–Strogatz models.
	%  <strong>13</strong> <strong>P</strong> 	P (parameter, rvector) is a vector of probability for simulating Watts–Strogatz models.
	%  <strong>14</strong> <strong>D</strong> 	D (parameter, scalar) is a number of degree for a Watts–Strogatz model.
	%  <strong>15</strong> <strong>N</strong> 	N (parameter, scalar) is a number of node for a Watts–Strogatz model.
	%  <strong>16</strong> <strong>EFF_NODES</strong> 	EFF_NODES (data, rvector) represents the effective nodes for a Watts–Strogatz model.
	%  <strong>17</strong> <strong>EFF_BR_DICT</strong> 	EFF_BR_DICT (data, idict) contains the effective brain regions of the simulated netwrok.
	%  <strong>18</strong> <strong>TIME_STEP</strong> 	TIME_STEP (parameter, scalar) is time_steps.
	%  <strong>19</strong> <strong>N_SUB</strong> 	N_SUB (data, scalar) is a number of subject to be generated.
	%  <strong>20</strong> <strong>SIM_DIRECTORY</strong> 	SIM_DIRECTORY (data, string) is the directory to export the FUN subject group files.
	%  <strong>21</strong> <strong>SIM_GR_ID</strong> 	SIM_GR_ID (data, string) is the folder name to export the FUN subject group files.
	%  <strong>22</strong> <strong>GRAPH_TEMPLATE</strong> 	GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
	%  <strong>23</strong> <strong>SIM_G_DICT</strong> 	SIM_G_DICT (result, idict) is a graph dictionary for simulated graph
	%  <strong>24</strong> <strong>SIM_SUB_DICT</strong> 	SIM_SUB_DICT (result, idict) is the simulated data using the Watts–Strogatz model.
	%  <strong>25</strong> <strong>SIM_GR</strong> 	SIM_GR (result, item) is the group of subjectFUN for those simulated data.
	%  <strong>26</strong> <strong>EXPORT_DATA</strong> 	EXPORT_DATA (query, empty) exports a group of subjects with the simulated fMRI data to a series of XLSX file.
	%  <strong>27</strong> <strong>EXPORT_BA</strong> 	EXPORT_BA (query, empty) exports a brain atlas to XLSX file.
	%  <strong>28</strong> <strong>PLOT_GRAPH</strong> 	PLOT_GRAPH (query, empty) plots graph.
	%  <strong>29</strong> <strong>PLOT_CLUSTERING</strong> 	PLOT_CLUSTERING (query, empty) plots graph.
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
		WAITBAR = 9; %CET: Computational Efficiency Trick
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = 9;
		WAITBAR_FORMAT = 4;
		
		BA = 10; %CET: Computational Efficiency Trick
		BA_TAG = 'BA';
		BA_CATEGORY = 3;
		BA_FORMAT = 8;
		
		P_MAX = 11; %CET: Computational Efficiency Trick
		P_MAX_TAG = 'P_MAX';
		P_MAX_CATEGORY = 3;
		P_MAX_FORMAT = 11;
		
		P_MIN = 12; %CET: Computational Efficiency Trick
		P_MIN_TAG = 'P_MIN';
		P_MIN_CATEGORY = 3;
		P_MIN_FORMAT = 11;
		
		P = 13; %CET: Computational Efficiency Trick
		P_TAG = 'P';
		P_CATEGORY = 3;
		P_FORMAT = 12;
		
		D = 14; %CET: Computational Efficiency Trick
		D_TAG = 'D';
		D_CATEGORY = 3;
		D_FORMAT = 11;
		
		N = 15; %CET: Computational Efficiency Trick
		N_TAG = 'N';
		N_CATEGORY = 3;
		N_FORMAT = 11;
		
		EFF_NODES = 16; %CET: Computational Efficiency Trick
		EFF_NODES_TAG = 'EFF_NODES';
		EFF_NODES_CATEGORY = 4;
		EFF_NODES_FORMAT = 12;
		
		EFF_BR_DICT = 17; %CET: Computational Efficiency Trick
		EFF_BR_DICT_TAG = 'EFF_BR_DICT';
		EFF_BR_DICT_CATEGORY = 4;
		EFF_BR_DICT_FORMAT = 10;
		
		TIME_STEP = 18; %CET: Computational Efficiency Trick
		TIME_STEP_TAG = 'TIME_STEP';
		TIME_STEP_CATEGORY = 3;
		TIME_STEP_FORMAT = 11;
		
		N_SUB = 19; %CET: Computational Efficiency Trick
		N_SUB_TAG = 'N_SUB';
		N_SUB_CATEGORY = 4;
		N_SUB_FORMAT = 11;
		
		SIM_DIRECTORY = 20; %CET: Computational Efficiency Trick
		SIM_DIRECTORY_TAG = 'SIM_DIRECTORY';
		SIM_DIRECTORY_CATEGORY = 4;
		SIM_DIRECTORY_FORMAT = 2;
		
		SIM_GR_ID = 21; %CET: Computational Efficiency Trick
		SIM_GR_ID_TAG = 'SIM_GR_ID';
		SIM_GR_ID_CATEGORY = 4;
		SIM_GR_ID_FORMAT = 2;
		
		GRAPH_TEMPLATE = 22; %CET: Computational Efficiency Trick
		GRAPH_TEMPLATE_TAG = 'GRAPH_TEMPLATE';
		GRAPH_TEMPLATE_CATEGORY = 3;
		GRAPH_TEMPLATE_FORMAT = 8;
		
		SIM_G_DICT = 23; %CET: Computational Efficiency Trick
		SIM_G_DICT_TAG = 'SIM_G_DICT';
		SIM_G_DICT_CATEGORY = 5;
		SIM_G_DICT_FORMAT = 10;
		
		SIM_SUB_DICT = 24; %CET: Computational Efficiency Trick
		SIM_SUB_DICT_TAG = 'SIM_SUB_DICT';
		SIM_SUB_DICT_CATEGORY = 5;
		SIM_SUB_DICT_FORMAT = 10;
		
		SIM_GR = 25; %CET: Computational Efficiency Trick
		SIM_GR_TAG = 'SIM_GR';
		SIM_GR_CATEGORY = 5;
		SIM_GR_FORMAT = 8;
		
		EXPORT_DATA = 26; %CET: Computational Efficiency Trick
		EXPORT_DATA_TAG = 'EXPORT_DATA';
		EXPORT_DATA_CATEGORY = 6;
		EXPORT_DATA_FORMAT = 1;
		
		EXPORT_BA = 27; %CET: Computational Efficiency Trick
		EXPORT_BA_TAG = 'EXPORT_BA';
		EXPORT_BA_CATEGORY = 6;
		EXPORT_BA_FORMAT = 1;
		
		PLOT_GRAPH = 28; %CET: Computational Efficiency Trick
		PLOT_GRAPH_TAG = 'PLOT_GRAPH';
		PLOT_GRAPH_CATEGORY = 6;
		PLOT_GRAPH_FORMAT = 1;
		
		PLOT_CLUSTERING = 29; %CET: Computational Efficiency Trick
		PLOT_CLUSTERING_TAG = 'PLOT_CLUSTERING';
		PLOT_CLUSTERING_CATEGORY = 6;
		PLOT_CLUSTERING_FORMAT = 1;
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
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>BA</strong> 	BA (parameter, item) is a brain atlas.
			%  <strong>11</strong> <strong>P_MAX</strong> 	P_MAX (parameter, scalar) is the maximum probability for simulating Watts–Strogatz models.
			%  <strong>12</strong> <strong>P_MIN</strong> 	P_MIN (parameter, scalar) is the minimum probability for simulating Watts–Strogatz models.
			%  <strong>13</strong> <strong>P</strong> 	P (parameter, rvector) is a vector of probability for simulating Watts–Strogatz models.
			%  <strong>14</strong> <strong>D</strong> 	D (parameter, scalar) is a number of degree for a Watts–Strogatz model.
			%  <strong>15</strong> <strong>N</strong> 	N (parameter, scalar) is a number of node for a Watts–Strogatz model.
			%  <strong>16</strong> <strong>EFF_NODES</strong> 	EFF_NODES (data, rvector) represents the effective nodes for a Watts–Strogatz model.
			%  <strong>17</strong> <strong>EFF_BR_DICT</strong> 	EFF_BR_DICT (data, idict) contains the effective brain regions of the simulated netwrok.
			%  <strong>18</strong> <strong>TIME_STEP</strong> 	TIME_STEP (parameter, scalar) is time_steps.
			%  <strong>19</strong> <strong>N_SUB</strong> 	N_SUB (data, scalar) is a number of subject to be generated.
			%  <strong>20</strong> <strong>SIM_DIRECTORY</strong> 	SIM_DIRECTORY (data, string) is the directory to export the FUN subject group files.
			%  <strong>21</strong> <strong>SIM_GR_ID</strong> 	SIM_GR_ID (data, string) is the folder name to export the FUN subject group files.
			%  <strong>22</strong> <strong>GRAPH_TEMPLATE</strong> 	GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
			%  <strong>23</strong> <strong>SIM_G_DICT</strong> 	SIM_G_DICT (result, idict) is a graph dictionary for simulated graph
			%  <strong>24</strong> <strong>SIM_SUB_DICT</strong> 	SIM_SUB_DICT (result, idict) is the simulated data using the Watts–Strogatz model.
			%  <strong>25</strong> <strong>SIM_GR</strong> 	SIM_GR (result, item) is the group of subjectFUN for those simulated data.
			%  <strong>26</strong> <strong>EXPORT_DATA</strong> 	EXPORT_DATA (query, empty) exports a group of subjects with the simulated fMRI data to a series of XLSX file.
			%  <strong>27</strong> <strong>EXPORT_BA</strong> 	EXPORT_BA (query, empty) exports a brain atlas to XLSX file.
			%  <strong>28</strong> <strong>PLOT_GRAPH</strong> 	PLOT_GRAPH (query, empty) plots graph.
			%  <strong>29</strong> <strong>PLOT_CLUSTERING</strong> 	PLOT_CLUSTERING (query, empty) plots graph.
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
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = [4 10 11 12 13 14 15 18 22];
				case 4 % Category.DATA
					prop_list = [5 16 17 19 20 21];
				case 5 % Category.RESULT
					prop_list = [23 24 25];
				case 6 % Category.QUERY
					prop_list = [8 26 27 28 29];
				case 9 % Category.GUI
					prop_list = 9;
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
				prop_number = 29;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 9;
				case 4 % Category.DATA
					prop_number = 6;
				case 5 % Category.RESULT
					prop_number = 3;
				case 6 % Category.QUERY
					prop_number = 5;
				case 9 % Category.GUI
					prop_number = 1;
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
			
			check = prop >= 1 && prop <= 29 && round(prop) == prop; %CET: Computational Efficiency Trick
			
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
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'BA'  'P_MAX'  'P_MIN'  'P'  'D'  'N'  'EFF_NODES'  'EFF_BR_DICT'  'TIME_STEP'  'N_SUB'  'SIM_DIRECTORY'  'SIM_GR_ID'  'GRAPH_TEMPLATE'  'SIM_G_DICT'  'SIM_SUB_DICT'  'SIM_GR'  'EXPORT_DATA'  'EXPORT_BA'  'PLOT_GRAPH'  'PLOT_CLUSTERING' })); %CET: Computational Efficiency Trick
			
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
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'BA'  'P_MAX'  'P_MIN'  'P'  'D'  'N'  'EFF_NODES'  'EFF_BR_DICT'  'TIME_STEP'  'N_SUB'  'SIM_DIRECTORY'  'SIM_GR_ID'  'GRAPH_TEMPLATE'  'SIM_G_DICT'  'SIM_SUB_DICT'  'SIM_GR'  'EXPORT_DATA'  'EXPORT_BA'  'PLOT_GRAPH'  'PLOT_CLUSTERING' })); % tag = pointer %CET: Computational Efficiency Trick
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
				datasimulator_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'BA'  'P_MAX'  'P_MIN'  'P'  'D'  'N'  'EFF_NODES'  'EFF_BR_DICT'  'TIME_STEP'  'N_SUB'  'SIM_DIRECTORY'  'SIM_GR_ID'  'GRAPH_TEMPLATE'  'SIM_G_DICT'  'SIM_SUB_DICT'  'SIM_GR'  'EXPORT_DATA'  'EXPORT_BA'  'PLOT_GRAPH'  'PLOT_CLUSTERING' };
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
			datasimulator_category_list = { 1  1  1  3  4  2  2  6  9  3  3  3  3  3  3  4  4  3  4  4  4  3  5  5  5  6  6  6  6 };
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
			datasimulator_format_list = { 2  2  2  8  2  2  2  2  4  8  11  11  12  11  11  12  10  11  11  2  2  8  10  10  8  1  1  1  1 };
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
			datasimulator_description_list = { 'ELCLASS (constant, string) is the class of the data simulator.'  'NAME (constant, string) is the name of the data simulator.'  'DESCRIPTION (constant, string) is the description of the data simulator.'  'TEMPLATE (parameter, item) is the template of the data simulator.'  'ID (data, string) is a few-letter code for the data simulator.'  'LABEL (metadata, string) is an extended label of data simulator.'  'NOTES (metadata, string) are some specific notes about the data simulator.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'BA (parameter, item) is a brain atlas.'  'P_MAX (parameter, scalar) is the maximum probability for simulating Watts–Strogatz models.'  'P_MIN (parameter, scalar) is the minimum probability for simulating Watts–Strogatz models.'  'P (parameter, rvector) is a vector of probability for simulating Watts–Strogatz models.'  'D (parameter, scalar) is a number of degree for a Watts–Strogatz model.'  'N (parameter, scalar) is a number of node for a Watts–Strogatz model.'  'EFF_NODES (data, rvector) represents the effective nodes for a Watts–Strogatz model.'  'EFF_BR_DICT (data, idict) contains the effective brain regions of the simulated netwrok.'  'TIME_STEP (parameter, scalar) is time_steps.'  'N_SUB (data, scalar) is a number of subject to be generated.'  'SIM_DIRECTORY (data, string) is the directory to export the FUN subject group files.'  'SIM_GR_ID (data, string) is the folder name to export the FUN subject group files.'  'GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.'  'SIM_G_DICT (result, idict) is a graph dictionary for simulated graph'  'SIM_SUB_DICT (result, idict) is the simulated data using the Watts–Strogatz model.'  'SIM_GR (result, item) is the group of subjectFUN for those simulated data.'  'EXPORT_DATA (query, empty) exports a group of subjects with the simulated fMRI data to a series of XLSX file.'  'EXPORT_BA (query, empty) exports a brain atlas to XLSX file.'  'PLOT_GRAPH (query, empty) plots graph.'  'PLOT_CLUSTERING (query, empty) plots graph.' };
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
				case DataSimulator.WAITBAR % __DataSimulator.WAITBAR__
					prop_settings = Format.getFormatSettings(4);
				case DataSimulator.BA % __DataSimulator.BA__
					prop_settings = 'BrainAtlas';
				case DataSimulator.P_MAX % __DataSimulator.P_MAX__
					prop_settings = Format.getFormatSettings(11);
				case DataSimulator.P_MIN % __DataSimulator.P_MIN__
					prop_settings = Format.getFormatSettings(11);
				case DataSimulator.P % __DataSimulator.P__
					prop_settings = Format.getFormatSettings(12);
				case DataSimulator.D % __DataSimulator.D__
					prop_settings = Format.getFormatSettings(11);
				case DataSimulator.N % __DataSimulator.N__
					prop_settings = Format.getFormatSettings(11);
				case DataSimulator.EFF_NODES % __DataSimulator.EFF_NODES__
					prop_settings = Format.getFormatSettings(12);
				case DataSimulator.EFF_BR_DICT % __DataSimulator.EFF_BR_DICT__
					prop_settings = 'BrainRegion';
				case DataSimulator.TIME_STEP % __DataSimulator.TIME_STEP__
					prop_settings = Format.getFormatSettings(11);
				case DataSimulator.N_SUB % __DataSimulator.N_SUB__
					prop_settings = Format.getFormatSettings(11);
				case DataSimulator.SIM_DIRECTORY % __DataSimulator.SIM_DIRECTORY__
					prop_settings = Format.getFormatSettings(2);
				case DataSimulator.SIM_GR_ID % __DataSimulator.SIM_GR_ID__
					prop_settings = Format.getFormatSettings(2);
				case DataSimulator.GRAPH_TEMPLATE % __DataSimulator.GRAPH_TEMPLATE__
					prop_settings = 'Graph';
				case DataSimulator.SIM_G_DICT % __DataSimulator.SIM_G_DICT__
					prop_settings = 'Graph';
				case DataSimulator.SIM_SUB_DICT % __DataSimulator.SIM_SUB_DICT__
					prop_settings = 'SubjectFUN';
				case DataSimulator.SIM_GR % __DataSimulator.SIM_GR__
					prop_settings = 'Group';
				case DataSimulator.EXPORT_DATA % __DataSimulator.EXPORT_DATA__
					prop_settings = Format.getFormatSettings(1);
				case DataSimulator.EXPORT_BA % __DataSimulator.EXPORT_BA__
					prop_settings = Format.getFormatSettings(1);
				case DataSimulator.PLOT_GRAPH % __DataSimulator.PLOT_GRAPH__
					prop_settings = Format.getFormatSettings(1);
				case DataSimulator.PLOT_CLUSTERING % __DataSimulator.PLOT_CLUSTERING__
					prop_settings = Format.getFormatSettings(1);
				case DataSimulator.TEMPLATE % __DataSimulator.TEMPLATE__
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
				case DataSimulator.WAITBAR % __DataSimulator.WAITBAR__
					prop_default = true;
				case DataSimulator.BA % __DataSimulator.BA__
					prop_default = Format.getFormatDefault(8, DataSimulator.getPropSettings(prop));
				case DataSimulator.P_MAX % __DataSimulator.P_MAX__
					prop_default = 1;
				case DataSimulator.P_MIN % __DataSimulator.P_MIN__
					prop_default = 0;
				case DataSimulator.P % __DataSimulator.P__
					prop_default = 0:0.1:1;
				case DataSimulator.D % __DataSimulator.D__
					prop_default = 4;
				case DataSimulator.N % __DataSimulator.N__
					prop_default = 68;
				case DataSimulator.EFF_NODES % __DataSimulator.EFF_NODES__
					prop_default = 1:1:11;
				case DataSimulator.EFF_BR_DICT % __DataSimulator.EFF_BR_DICT__
					prop_default = Format.getFormatDefault(10, DataSimulator.getPropSettings(prop));
				case DataSimulator.TIME_STEP % __DataSimulator.TIME_STEP__
					prop_default = 100;
				case DataSimulator.N_SUB % __DataSimulator.N_SUB__
					prop_default = 11;
				case DataSimulator.SIM_DIRECTORY % __DataSimulator.SIM_DIRECTORY__
					prop_default = fileparts(which(BRAPH2.LAUNCHER));
				case DataSimulator.SIM_GR_ID % __DataSimulator.SIM_GR_ID__
					prop_default = 'SIM_GR';
				case DataSimulator.GRAPH_TEMPLATE % __DataSimulator.GRAPH_TEMPLATE__
					prop_default = GraphWU();
				case DataSimulator.SIM_G_DICT % __DataSimulator.SIM_G_DICT__
					prop_default = Format.getFormatDefault(10, DataSimulator.getPropSettings(prop));
				case DataSimulator.SIM_SUB_DICT % __DataSimulator.SIM_SUB_DICT__
					prop_default = Format.getFormatDefault(10, DataSimulator.getPropSettings(prop));
				case DataSimulator.SIM_GR % __DataSimulator.SIM_GR__
					prop_default = Format.getFormatDefault(8, DataSimulator.getPropSettings(prop));
				case DataSimulator.EXPORT_DATA % __DataSimulator.EXPORT_DATA__
					prop_default = Format.getFormatDefault(1, DataSimulator.getPropSettings(prop));
				case DataSimulator.EXPORT_BA % __DataSimulator.EXPORT_BA__
					prop_default = Format.getFormatDefault(1, DataSimulator.getPropSettings(prop));
				case DataSimulator.PLOT_GRAPH % __DataSimulator.PLOT_GRAPH__
					prop_default = Format.getFormatDefault(1, DataSimulator.getPropSettings(prop));
				case DataSimulator.PLOT_CLUSTERING % __DataSimulator.PLOT_CLUSTERING__
					prop_default = Format.getFormatDefault(1, DataSimulator.getPropSettings(prop));
				case DataSimulator.ELCLASS % __DataSimulator.ELCLASS__
					prop_default = 'DataSimulator';
				case DataSimulator.NAME % __DataSimulator.NAME__
					prop_default = 'Neural Network Dataset';
				case DataSimulator.DESCRIPTION % __DataSimulator.DESCRIPTION__
					prop_default = 'XXX';
				case DataSimulator.TEMPLATE % __DataSimulator.TEMPLATE__
					prop_default = Format.getFormatDefault(8, DataSimulator.getPropSettings(prop));
				case DataSimulator.LABEL % __DataSimulator.LABEL__
					prop_default = 'DataSimulator label';
				case DataSimulator.NOTES % __DataSimulator.NOTES__
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
				case DataSimulator.WAITBAR % __DataSimulator.WAITBAR__
					check = Format.checkFormat(4, value, DataSimulator.getPropSettings(prop));
				case DataSimulator.BA % __DataSimulator.BA__
					check = Format.checkFormat(8, value, DataSimulator.getPropSettings(prop));
				case DataSimulator.P_MAX % __DataSimulator.P_MAX__
					check = Format.checkFormat(11, value, DataSimulator.getPropSettings(prop));
				case DataSimulator.P_MIN % __DataSimulator.P_MIN__
					check = Format.checkFormat(11, value, DataSimulator.getPropSettings(prop));
				case DataSimulator.P % __DataSimulator.P__
					check = Format.checkFormat(12, value, DataSimulator.getPropSettings(prop));
				case DataSimulator.D % __DataSimulator.D__
					check = Format.checkFormat(11, value, DataSimulator.getPropSettings(prop));
				case DataSimulator.N % __DataSimulator.N__
					check = Format.checkFormat(11, value, DataSimulator.getPropSettings(prop));
				case DataSimulator.EFF_NODES % __DataSimulator.EFF_NODES__
					check = Format.checkFormat(12, value, DataSimulator.getPropSettings(prop));
				case DataSimulator.EFF_BR_DICT % __DataSimulator.EFF_BR_DICT__
					check = Format.checkFormat(10, value, DataSimulator.getPropSettings(prop));
				case DataSimulator.TIME_STEP % __DataSimulator.TIME_STEP__
					check = Format.checkFormat(11, value, DataSimulator.getPropSettings(prop));
				case DataSimulator.N_SUB % __DataSimulator.N_SUB__
					check = Format.checkFormat(11, value, DataSimulator.getPropSettings(prop));
				case DataSimulator.SIM_DIRECTORY % __DataSimulator.SIM_DIRECTORY__
					check = Format.checkFormat(2, value, DataSimulator.getPropSettings(prop));
				case DataSimulator.SIM_GR_ID % __DataSimulator.SIM_GR_ID__
					check = Format.checkFormat(2, value, DataSimulator.getPropSettings(prop));
				case DataSimulator.GRAPH_TEMPLATE % __DataSimulator.GRAPH_TEMPLATE__
					check = Format.checkFormat(8, value, DataSimulator.getPropSettings(prop));
				case DataSimulator.SIM_G_DICT % __DataSimulator.SIM_G_DICT__
					check = Format.checkFormat(10, value, DataSimulator.getPropSettings(prop));
				case DataSimulator.SIM_SUB_DICT % __DataSimulator.SIM_SUB_DICT__
					check = Format.checkFormat(10, value, DataSimulator.getPropSettings(prop));
				case DataSimulator.SIM_GR % __DataSimulator.SIM_GR__
					check = Format.checkFormat(8, value, DataSimulator.getPropSettings(prop));
				case DataSimulator.EXPORT_DATA % __DataSimulator.EXPORT_DATA__
					check = Format.checkFormat(1, value, DataSimulator.getPropSettings(prop));
				case DataSimulator.EXPORT_BA % __DataSimulator.EXPORT_BA__
					check = Format.checkFormat(1, value, DataSimulator.getPropSettings(prop));
				case DataSimulator.PLOT_GRAPH % __DataSimulator.PLOT_GRAPH__
					check = Format.checkFormat(1, value, DataSimulator.getPropSettings(prop));
				case DataSimulator.PLOT_CLUSTERING % __DataSimulator.PLOT_CLUSTERING__
					check = Format.checkFormat(1, value, DataSimulator.getPropSettings(prop));
				case DataSimulator.TEMPLATE % __DataSimulator.TEMPLATE__
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
				case DataSimulator.EFF_NODES % __DataSimulator.EFF_NODES__
					eff_br_dict = dsim.get('EFF_BR_DICT');
					br_dict = dsim.get('BA').get('BR_DICT');
                    if br_dict.get('LENGTH') == 0
                        dsim.postprocessing(DataSimulator.BA);
                        br_dict = dsim.get('BA').get('BR_DICT');
                    end
					if br_dict.get('LENGTH') > 0
					    if eff_br_dict.get('LENGTH') == 0
					        eff_nodes = dsim.get('EFF_NODES');
					        br_it_list = br_dict.get('IT_LIST');
					        eff_br_dict.set('IT_LIST',br_it_list(eff_nodes));
                            dsim.set('EFF_BR_DICT', eff_br_dict);
					    end
					end
					
				otherwise
					if prop <= 8
						postset@ConcreteElement(dsim, prop);
					end
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
				case DataSimulator.BA % __DataSimulator.BA__
					ba = dsim.get('BA');
					if ba.get('BR_DICT').get('LENGTH') == 0
					    n = dsim.get('N');
					    brain_regions = cell(1, n);
					    for i = 1:n
					        brain_regions{i} = BrainRegion( ...
					            'ID', ['BR' num2str(i)], ... % Randomize ID, here use the number
					            'LABEL', ['Region' num2str(i)], ... % random LABEL, index number
					            'NOTES', ['Notes' num2str(i)], ... % NOTE names according to the number corresponding to n
					            'X', rand()*100 - 50, ... % X [-50, 50] 
					            'Y', rand()*100 - 50, ... % Y [-50, 50] 
					            'Z', rand()*100 - 50 ... % Z [-50, 50] 
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
					
				case DataSimulator.P % __DataSimulator.P__
					n_sub = dsim.get('N_SUB');
					p = dsim.get('P');
					if ~isequal(length(p), n_sub)    
					    p_min = dsim.get('P_MIN');
					    p_max = dsim.get('P_MAX');
					    step = (p_max - p_min) / (n_sub - 1);
					    if step == 0
					        dsim.set('P', p_max*ones(1, n_sub));
					    else
					        dsim.set('P', p_min:step:p_max);
					    end
					end
					
				case DataSimulator.EFF_NODES % __DataSimulator.EFF_NODES__
					n = dsim.get('N');
					eff_nodes = dsim.getr('EFF_NODES');
					if isa(eff_nodes, 'NoValue') && n ~= 0
					    dsim.set('EFF_NODES', 1:1:n);
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
				case DataSimulator.SIM_G_DICT % __DataSimulator.SIM_G_DICT__
					rng_settings_ = rng(); rng(dsim.getPropSeed(DataSimulator.SIM_G_DICT), 'twister')
					
					n = dsim.get('N'); 
					eff_nodes = dsim.get('EFF_NODES');
					d = dsim.get('D'); 
					p_list = dsim.get('P');
					n_sub = dsim.get('N_SUB'); % the number of samples
					% initialize the cell array with a random ID, in this case a number.
					g_dict = IndexedDictionary('IT_CLASS', 'Graph');
					g_temp = dsim.memorize('GRAPH_TEMPLATE');
					
					% generate networks with different p
					wb = braph2waitbar(dsim.get('WAITBAR'), .15, ['Organizing Infor ...']);
					for sub = 1:1:n_sub
					    p_sub = p_list(sub);  % Take the current sample of p
					    G = zeros(n); % create n x n null adjacency matrix
					    half_d = d / 2; % nearest neighbor connection number
					
					    % 1. First generate a regular ring structure
					    for i = 1:n
					        for j = 1:half_d
					            neighbor = mod(i + j - 1, n) + 1;
					            G(i, neighbor) = 1;
					            G(neighbor, i) = 1;
					        end
					    end
					
					    % 2. Perform reconnection operation (make sure p takes effect)
					    for i = 1:n
					        for j = 1:half_d
					            if rand < p_sub && ismember(i, eff_nodes)  % Reconnect with probability p_sub
					                neighbor = mod(i + j - 1, n) + 1;
					                G(i, neighbor) = 0;
					                G(neighbor, i) = 0;
					
					                new_neighbor = i;
					                while new_neighbor == i || G(i, new_neighbor) == 1
                                        %% 
					                    new_neighbor = eff_nodes(randi(length(eff_nodes))); % Randomly select a new node
					                end
					                G(i, new_neighbor) = 1;
					                G(new_neighbor, i) = 1;
					            end
					        end
					    end
					    b = G;
					    g = eval(g_temp.get('ELCLASS'));
					    g_dict.get('ADD', g.set('ID', ['Simulated network ' num2str(sub)], 'B', b));
					    braph2waitbar(wb, .15 + .85 * sub / n_sub, ['Constructing Network ' num2str(sub) ' of ' num2str(n_sub) ' ...'])
					end
					braph2waitbar(wb, 'close')
					value = g_dict;
					
					rng(rng_settings_)
					
				case DataSimulator.SIM_SUB_DICT % __DataSimulator.SIM_SUB_DICT__
					rng_settings_ = rng(); rng(dsim.getPropSeed(DataSimulator.SIM_SUB_DICT), 'twister')
					
					% Get parameters
					n_sub = dsim.get('N_SUB'); % Number of samples
					n = dsim.get('N'); % Number of nodes in the network
					time_step = dsim.get('TIME_STEP'); % Time step variable
					sim_g_dict = dsim.get('SIM_G_DICT');% Get cell array, small world matrix
					p = dsim.get('P');
					
					ba = dsim.get('BA');
					sub_dict = IndexedDictionary('IT_CLASS', 'SubjectFUN');
					
					% Generate N_SUB sets of data
					wb = braph2waitbar(dsim.get('WAITBAR'), .15, ['Organizing Infor ...']);
					for sub = 1:1:n_sub
					
					    graph_data_cell = cell2mat(sim_g_dict.get('IT', sub).get('A')); % get the adjacency matrix of the current subject
					
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
					    subj = SubjectFUN( ...
					        'ID', ['Subject FUN ' num2str(sub)], ...
					        'LABEL', ['Subject FUN ' num2str(sub)], ...
					        'NOTES', ['Notes on Subject FUN ' num2str(sub)], ...
					        'BA', ba, ...
					        'FUN', R ...
					        );
					    subj.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'P', 'V', p(sub)));
					    sub_dict.get('ADD', subj);
					    braph2waitbar(wb, .15 + .85 * sub / n_sub, ['Constructing Subject FUN ' num2str(sub) ' of ' num2str(n_sub) ' ...'])
					end
					braph2waitbar(wb, 'close')
					value = sub_dict;
					
					rng(rng_settings_)
					
				case DataSimulator.SIM_GR % __DataSimulator.SIM_GR__
					rng_settings_ = rng(); rng(dsim.getPropSeed(DataSimulator.SIM_GR), 'twister')
					
					sub_dict = dsim.get('SIM_SUB_DICT');
					value = Group( ...
					    'ID', dsim.get('SIM_GR_ID'), ...
					    'LABEL', 'Group label', ...
					    'NOTES', 'Group notes', ...
					    'SUB_CLASS', 'SubjectFUN', ...
					    'SUB_DICT', sub_dict ...
					    );
					
					rng(rng_settings_)
					
				case DataSimulator.EXPORT_DATA % __DataSimulator.EXPORT_DATA__
					directory = dsim.get('SIM_DIRECTORY');
					if ~exist(directory, 'dir')
					    mkdir(directory)
					end
					
					gr = dsim.get('SIM_GR');
					ex = ExporterGroupSubjectFUN_XLS( ...
					    'DIRECTORY', directory, ...
					    'GR', gr ...
					    );
					ex.get('SAVE');
					
					value = {};
					
				case DataSimulator.EXPORT_BA % __DataSimulator.EXPORT_BA__
					directory = dsim.get('SIM_DIRECTORY');
					if ~exist(directory, 'dir')
					    mkdir(directory)
					end
					
					ba = dsim.get('BA');
					file = [directory filesep 'atlas.xlsx'];
					ex = ExporterBrainAtlasXLS( ...
					    'FILE', file, ...
					    'BA', ba ...
					    );
					ex.get('SAVE');
					value = {};
					
				case DataSimulator.PLOT_GRAPH % __DataSimulator.PLOT_GRAPH__
					figure;
					%YUXIN make the panel number adaptable with the number of the networks to
					%be plotted (now it is 5x5 fixed)
					tiledlayout(5, 5, 'Padding', 'compact', 'TileSpacing', 'compact');
					g_dict = dsim.get('SIM_G_DICT');
					eff_nodes = dsim.get('EFF_NODES');
					for i = 1:25
					    nexttile;
					    G = graph(cell2mat(g_dict.get('IT', i).get('A')), 'OmitSelfLoops');
					
					    % Default node colors: black
					    node_colors = repmat([0 0 0], numnodes(G), 1); % RGB for black
					
					    % Set the highlighted nodes to red
					    node_colors(eff_nodes, :) = repmat([1 0 0], numel(eff_nodes), 1); % RGB for red
					
					    plot(G, 'Layout', 'circle', 'NodeLabel', {}, 'NodeColor', node_colors);
					end
					value = {};
					
				case DataSimulator.PLOT_CLUSTERING % __DataSimulator.PLOT_CLUSTERING__
					%YUXIN make this work
					value = {};
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(dsim, prop, varargin{:});
					else
						value = calculateValue@Element(dsim, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(dsim, prop, varargin)
			%GETPANELPROP returns a prop panel.
			%
			% PR = GETPANELPROP(EL, PROP) returns the panel of prop PROP.
			%
			% PR = GETPANELPROP(EL, PROP, 'Name', Value, ...) sets the properties 
			%  of the panel prop.
			%
			% See also PanelProp, PanelPropAlpha, PanelPropCell, PanelPropClass,
			%  PanelPropClassList, PanelPropColor, PanelPropHandle,
			%  PanelPropHandleList, PanelPropIDict, PanelPropItem, PanelPropLine,
			%  PanelPropItemList, PanelPropLogical, PanelPropMarker, PanelPropMatrix,
			%  PanelPropNet, PanelPropOption, PanelPropScalar, PanelPropSize,
			%  PanelPropString, PanelPropStringList.
			
			switch prop
				case DataSimulator.P % __DataSimulator.P__
					pr = PanelPropRVectorSmart('EL', dsim, 'PROP', DataSimulator.P, ...
					    'MIN', dsim.get('P_MIN'), 'MAX', dsim.get('P_MAX'), ...
					    'UNIQUE_VALUE', false, ...
					    'DEFAULT', 0:0.1:1, ...
					    varargin{:});
					
				case DataSimulator.EFF_BR_DICT % __DataSimulator.EFF_BR_DICT__
					pr = DataSimulatorPP_EFF_BR_Dict('EL', dsim, 'PROP', DataSimulator.EFF_BR_DICT, ...
					    'WAITBAR', dsim.getCallback('WAITBAR'), ...
					    varargin{:});
					
				case DataSimulator.GRAPH_TEMPLATE % __DataSimulator.GRAPH_TEMPLATE__
					pr = PanelPropItem('EL', dsim, 'PROP', DataSimulator.GRAPH_TEMPLATE, ...
					    'BUTTON_TEXT', ['GRAPH TEMPLATE (' dsim.get('GRAPH_TEMPLATE').getClass() ')'], ...
					    varargin{:});
					
				case DataSimulator.SIM_G_DICT % __DataSimulator.SIM_G_DICT__
					pr = AnalyzeEnsemblePP_GDict('EL', dsim, 'PROP', DataSimulator.SIM_G_DICT, ...
					    'WAITBAR', dsim.getCallback('WAITBAR'), ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@ConcreteElement(dsim, prop, varargin{:});
					
			end
		end
	end
end
