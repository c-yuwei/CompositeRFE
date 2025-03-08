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
DataSimulator.EFF_NODES
%%%% ¡title!
Effective Nodes

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
Plot Graph

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
            'NOTES', ['notes' num2str(i)], ... % NOTE names according to the number corresponding to n
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

%%% ¡prop!
D (parameter, scalar) is a number of degree for a Watts–Strogatz model.
%%%% ¡default!
4

%%% ¡prop!
N (parameter, scalar) is a number of node for a Watts–Strogatz model.
%%%% ¡default!
68

%%% ¡prop!
EFF_NODES (parameter, rvector) represents the effective nodes for a Watts–Strogatz model.
%%%% ¡default!
1:1:10

%%% ¡prop!
TIME_STEP (parameter, scalar) is time_steps.
%%%% ¡default!
100

%%% ¡prop!
N_SUB (data, scalar) is a number of subject to be generated.
%%%% ¡default!
10

%%% ¡prop!
SIM_DIRECTORY (data, string) is the directory to export the FUN subject group files.
%%%% ¡default!
fileparts(which('BRAPH2.LAUNCHER'))

%%% ¡prop!
SIM_GR_ID (data, string) is the folder name to export the FUN subject group files.
%%%% ¡default!
'SIM_GR'

%%% ¡prop!
SIM_G_DICT (result, idict) is a graph dictionary for simulated graph
%%%% ¡settings!
'Graph'
%%%% ¡calculate!
n_whole = dsim.get('N'); 
eff_nodes = dsim.get('EFF_NODES');
n = length(eff_nodes);
d = dsim.get('D'); 
p_list = dsim.get('P');
n_sub = dsim.get('N_SUB'); % the number of samples
% initialize the cell array with a random ID, in this case a number.
g_dict = IndexedDictionary('IT_CLASS', 'Graph');

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
            if rand < p_sub  % Reconnect with probability p_sub
                neighbor = mod(i + j - 1, n) + 1;
                G(i, neighbor) = 0;
                G(neighbor, i) = 0;

                new_neighbor = i;
                while new_neighbor == i || G(i, new_neighbor) == 1
                    new_neighbor = randi(n); % Randomly select a new node
                end
                G(i, new_neighbor) = 1;
                G(new_neighbor, i) = 1;
            end
        end
    end
    b = zeros(n_whole);
    b(eff_nodes, eff_nodes) = G;
    g_dict.get('ADD', GraphWU('ID', ['Simulated network ' num2str(sub)], 'B', b));
    braph2waitbar(wb, .15 + .85 * sub / n_sub, ['Constructing Network ' num2str(sub) ' of ' num2str(n_sub) ' ...'])
end
braph2waitbar(wb, 'close')
value = g_dict;

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

ba = dsim.get('BA');
sub_dict = IndexedDictionary('IT_CLASS', 'SubjectFUN');

% Generate N_SUB sets of data
wb = braph2waitbar(dsim.get('WAITBAR'), .15, ['Organizing Infor ...']);
for sub = 1:1:n_sub

    graph_data_cell = sim_g_dict.get('IT', sub).get('A'); % get the adjacency matrix of the current subject

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
        'ID', ['Subject FUN ' num2str(i)], ...
        'LABEL', ['Subject FUN ' num2str(i)], ...
        'NOTES', ['Notes on Subject FUN ' num2str(i)], ...
        'BA', ba, ...
        'FUN', R ...
        );
    subj.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'P', 'V', p(i)));
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
sub_dict = dsim.get('SIM_SUB_DICT')
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
value = {};

%%% ¡prop!
PLOT_CLUSTERING (query, empty) plots graph.
%%%% ¡calculate!
value = {};

%% ¡tests!

%%% ¡excluded_props!
[DataSimulator.TEMPLATE DataSimulator.EXPORT_DATA DataSimulator.BA]

