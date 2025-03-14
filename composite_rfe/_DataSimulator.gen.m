%% ¡header!
DataSimulator < ConcreteElement (dsim, data simulator) is a simulator for simulating example data.

%%% ¡description!
XXX

%%% ¡seealso!
create_data_NN_CLA_FUN_XLS

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
DataSimulator.ID
%%%% ¡title!
Data Simulator ID

%%% ¡prop!
%%%% ¡id!
DataSimulator.LABEL
%%%% ¡title!
Data Simulator LABEL

%%% ¡prop!
%%%% ¡id!
DataSimulator.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
DataSimulator.BA
%%%% ¡title!
Brain Atlas

%%% ¡prop!
%%%% ¡id!
DataSimulator.P_MAX
%%%% ¡title!
Maximum Rewiring Probability

%%% ¡prop!
%%%% ¡id!
DataSimulator.P_MIN
%%%% ¡title!
Minimum Rewiring Probability

%%% ¡prop!
%%%% ¡id!
DataSimulator.P
%%%% ¡title!
Probabilities

%%% ¡prop!
%%%% ¡id!
DataSimulator.D
%%%% ¡title!
Network Degree

%%% ¡prop!
%%%% ¡id!
DataSimulator.N
%%%% ¡title!
Network Node Number

%%% ¡prop!
%%%% ¡id!
DataSimulator.EFF_BR_DICT
%%%% ¡title!
Effective Brain Regions

%%% ¡prop!
%%%% ¡id!
DataSimulator.TIME_STEP
%%%% ¡title!
Simulated Time Step

%%% ¡prop!
%%%% ¡id!
DataSimulator.N_SUB
%%%% ¡title!
Number Simulated Subjects

%%% ¡prop!
%%%% ¡id!
DataSimulator.SIM_DIRECTORY
%%%% ¡title!
Exporting Directory

%%% ¡prop!
%%%% ¡id!
DataSimulator.SIM_GR_ID
%%%% ¡title!
Exporting Folder Name

%%% ¡prop!
%%%% ¡id!
DataSimulator.SIM_G_DICT
%%%% ¡title!
Simulated G DICT

%%% ¡prop!
%%%% ¡id!
DataSimulator.SIM_GR
%%%% ¡title!
Simulated Group

%%% ¡prop!
%%%% ¡id!
DataSimulator.EXPORT_DATA
%%%% ¡title!
EXPORT Simulated Data

%%% ¡prop!
%%%% ¡id!
DataSimulator.EXPORT_BA
%%%% ¡title!
EXPORT Brain Atlas

%%% ¡prop!
%%%% ¡id!
DataSimulator.PLOT_GRAPH
%%%% ¡title!
Plot Circled Graphs

%%% ¡prop!
%%%% ¡id!
DataSimulator.PLOT_CLUSTERING
%%%% ¡title!
Plot Clustering

%%% ¡prop!
%%%% ¡id!
DataSimulator.NOTES
%%%% ¡title!
Data Simulator NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the data simulator.
%%%% ¡default!
'DataSimulator'

%%% ¡prop!
NAME (constant, string) is the name of the data simulator.
%%%% ¡default!
'Neural Network Dataset'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the data simulator.
%%%% ¡default!
'XXX'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the data simulator.
%%%% ¡settings!
'DataSimulator'

%%% ¡prop!
ID (data, string) is a few-letter code for the data simulator.
'DataSimulator ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of data simulator.
%%%% ¡default!
'DataSimulator label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the data simulator.
%%%% ¡default!
'DataSimulator notes'
    
%% ¡props!

%%% ¡prop!
WAITBAR (gui, logical) detemines whether to show the waitbar.
%%%% ¡default!
true

%%% ¡prop!
BA (parameter, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'
%%%% ¡postprocessing!
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

%%% ¡prop!
P_MAX (parameter, scalar) is the maximum probability for simulating Watts–Strogatz models.
%%%% ¡default!
1

%%% ¡prop!
P_MIN (parameter, scalar) is the minimum probability for simulating Watts–Strogatz models.
%%%% ¡default!
0

%%% ¡prop!
P (parameter, rvector) is a vector of probability for simulating Watts–Strogatz models.
%%%% ¡default!
0:0.1:1
%%%% ¡postprocessing!
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
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', dsim, 'PROP', DataSimulator.P, ...
    'MIN', dsim.get('P_MIN'), 'MAX', dsim.get('P_MAX'), ...
    'UNIQUE_VALUE', false, ...
    'DEFAULT', 0:0.1:1, ...
    varargin{:});

%%% ¡prop!
D (parameter, scalar) is a number of degree for a Watts–Strogatz model.
%%%% ¡default!
4

%%% ¡prop!
N (parameter, scalar) is a number of node for a Watts–Strogatz model.
%%%% ¡default!
68

%%% ¡prop!
EFF_NODES (data, rvector) represents the effective nodes for a Watts–Strogatz model.
%%%% ¡default!
1:1:11
%%%% ¡postprocessing!
n = dsim.get('N');
eff_nodes = dsim.getr('EFF_NODES');
if isa(eff_nodes, 'NoValue') && n ~= 0
    dsim.set('EFF_NODES', 1:1:n);
end
%%%% ¡postset!
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

%%% ¡prop!
EFF_BR_DICT (data, idict) contains the effective brain regions of the simulated netwrok.
%%%% ¡settings!
'BrainRegion'
%%%% ¡gui!
pr = DataSimulatorPP_EFF_BR_Dict('EL', dsim, 'PROP', DataSimulator.EFF_BR_DICT, ...
    'WAITBAR', dsim.getCallback('WAITBAR'), ...
    varargin{:});

%%% ¡prop!
TIME_STEP (parameter, scalar) is time_steps.
%%%% ¡default!
100

%%% ¡prop!
N_SUB (data, scalar) is a number of subject to be generated.
%%%% ¡default!
11

%%% ¡prop!
SIM_DIRECTORY (data, string) is the directory to export the FUN subject group files.
%%%% ¡default!
fileparts(which(BRAPH2.LAUNCHER))

%%% ¡prop!
SIM_GR_ID (data, string) is the folder name to export the FUN subject group files.
%%%% ¡default!
'SIM_GR'

%%% ¡prop!
GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
%%%% ¡settings!
'Graph'
%%%% ¡default!
GraphWU()
%%%% ¡gui!
pr = PanelPropItem('EL', dsim, 'PROP', DataSimulator.GRAPH_TEMPLATE, ...
    'BUTTON_TEXT', ['GRAPH TEMPLATE (' dsim.get('GRAPH_TEMPLATE').getClass() ')'], ...
    varargin{:});

%%% ¡prop!
SIM_G_DICT (result, idict) is a graph dictionary for simulated graph
%%%% ¡settings!
'Graph'
%%%% ¡calculate!
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
%%%% ¡gui!
pr = AnalyzeEnsemblePP_GDict('EL', dsim, 'PROP', DataSimulator.SIM_G_DICT, ...
    'WAITBAR', dsim.getCallback('WAITBAR'), ...
    varargin{:});

%%% ¡prop!
SIM_SUB_DICT (result, idict) is the simulated data using the Watts–Strogatz model.
%%%% ¡settings!
'SubjectFUN'
%%%% ¡calculate! 
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

%%% ¡prop!
SIM_GR (result, item) is the group of subjectFUN for those simulated data.
%%%% ¡settings!
'Group'
%%%% ¡calculate!
sub_dict = dsim.get('SIM_SUB_DICT');
value = Group( ...
    'ID', dsim.get('SIM_GR_ID'), ...
    'LABEL', 'Group label', ...
    'NOTES', 'Group notes', ...
    'SUB_CLASS', 'SubjectFUN', ...
    'SUB_DICT', sub_dict ...
    );

%%% ¡prop!
EXPORT_DATA (query, empty) exports a group of subjects with the simulated fMRI data to a series of XLSX file.
%%%% ¡calculate!
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

%%% ¡prop!
EXPORT_BA (query, empty) exports a brain atlas to XLSX file.
%%%% ¡calculate!
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

%%% ¡prop!
PLOT_GRAPH (query, empty) plots graph.
%%%% ¡calculate!
figure;
%YUXIN add brain region name on the plot directly
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

%%% ¡prop!
PLOT_CLUSTERING (query, empty) plots graph.
%%%% ¡calculate!
%YUXIN make this work
value = {};

%% ¡tests!

%%% ¡excluded_props!
[DataSimulator.TEMPLATE DataSimulator.BA DataSimulator.EXPORT_DATA DataSimulator.EXPORT_BA DataSimulator.PLOT_GRAPH DataSimulator.PLOT_CLUSTERING]

