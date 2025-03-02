%% ¡header!
DataSimulator < ConcreteElement (dsim, data simulator) is a simulator for simulating example data.

%%% ¡description!
XXX

%%% ¡seealso!
create_data_NN_CLA_FUN_XLS

%%% ¡build!
1

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
1:1:10
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
TIME_STEP (parameter, scalar) is time_steps.
%%%% ¡default!
100

%%% ¡prop!
N_SUB (data, scalar) is a number of subject to be generated.
%%%% ¡default!
10

%%% ¡prop!
DIRECTORY (data, string) is the directory to export the FUN subject group files.
%%%% ¡default!
fileparts(which('BRAPH2.LAUNCHER'))

%%% ¡prop!
GR_ID (data, string) is the folder name to export the FUN subject group files.
%%%% ¡default!
'SIM_GR'

%%% ¡prop!
GRAPH_DATA (result, cell) is the Small_World_Graph.
%%%% ¡calculate!
% 获取参数
n = dsim.get('N'); % 节点数
d = dsim.get('D'); % 连接数
p_list = dsim.get('P'); % 连接概率
n_sub = dsim.get('N_SUB'); % 样本数量

% 初始化 cell 数组
graph_data = cell(1, n_sub);

% 生成不同 p 的网络
for sub = 1:n_sub
    p_sub = p_list(sub);  % 取当前样本的 p
    G = zeros(n); % 创建 n x n 的空邻接矩阵
    half_d = d / 2; % 最近邻连接数

    % 1. 先生成规则的环状结构
    for i = 1:n
        for j = 1:half_d
            neighbor = mod(i + j - 1, n) + 1;
            G(i, neighbor) = 1;
            G(neighbor, i) = 1;
        end
    end

    % 2. 进行重连操作（确保 p 生效）
    for i = 1:n
        for j = 1:half_d
            if rand < p_sub  % 按照 p_sub 的概率进行重连
                neighbor = mod(i + j - 1, n) + 1;
                G(i, neighbor) = 0;
                G(neighbor, i) = 0;

                new_neighbor = i;
                while new_neighbor == i || G(i, new_neighbor) == 1
                    new_neighbor = randi(n); % 随机选择一个新的节点
                end
                G(i, new_neighbor) = 1;
                G(new_neighbor, i) = 1;
            end
        end
    end

    graph_data{sub} = G; % 存储当前 p_sub 生成的图
end

value = graph_data;


%%% ¡prop!
SIM_DATA (result, cell) is the simulated data using the Watts–Strogatz model.
%%%% ¡calculate! 
% Get parameters
n_sub = dsim.get('N_SUB'); % Number of samples
n = dsim.get('N'); % Number of nodes in the network
time_step = dsim.get('TIME_STEP'); % Time step variable
graph_data = dsim.get('GRAPH_DATA');% Get cell array, small world matrix

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

%%% ¡prop!
SIM_GR (result, item) is the group of subjectFUN for those simulated data.
%%%% ¡settings!
'Group'
%%%% ¡calculate!
sim_data = dsim.get('SIM_DATA');
n_sub = dsim.get('N_SUB');
p = dsim.get('P');

% Generate n BrainRegion instances
n = dsim.get('N')% 获取节点数

ba = dsim.get('BA');


for i = 1:n_sub
    subs{i} = SubjectFUN( ...
        'ID', ['Subject FUN ' num2str(i)], ...
        'LABEL', ['Subject FUN ' num2str(i)], ...
        'NOTES', ['Notes on Subject FUN ' num2str(i)], ...
        'BA', ba, ...
        'FUN', sim_data{i} ...
        );
    subs{i}.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'P', 'V', p(i)))
end

value = Group( ...
    'ID', dsim.get('GR_ID'), ...
    'LABEL', 'Group label', ...
    'NOTES', 'Group notes', ...
    'SUB_CLASS', 'SubjectFUN', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN', 'IT_LIST', subs) ...
    );

%%% ¡prop!
EXPORT_DATA (query, empty) exports a group of subjects with the simulated fMRI data to a series of XLSX file.
%%%% ¡calculate!
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

value = {};

%%% ¡prop!
EXPORT_BA (query, empty) exports a brain atlas to XLSX file.
%%%% ¡calculate!
%%%YUXIN
directory = dsim.get('DIRECTORY');
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

%% ¡tests!

%%% ¡excluded_props!
[DataSimulator.TEMPLATE DataSimulator.EXPORT_DATA DataSimulator.BA]

