%EXAMPLE_DATA_SIMULATOR
% Script example data simulator

clear variables %#ok<*NASGU>

%% Simulate data with small worldness (Task 1)

output_folder = [fileparts(which('DataSimulator')) filesep 'SIM_DATASET_TWO_GROUPS'];

% create simulated data for group 1
dsim_1 = DataSimulator('P_MAX', 0.02, 'P_MIN', 0.02, 'D', 4, 'N', 10, 'TIME_STEP', 200, 'N_SUB', 25, 'DIRECTORY', output_folder, 'GR_ID', 'SimGroup1');
graph_data_1 = dsim_1.get('GRAPH_DATA');

%yuxin add the circle plot for sim_data_1 with 5x5 panels
% 画出 group 1 的数据
figure;
tiledlayout(5, 5, 'Padding', 'compact', 'TileSpacing', 'compact');
for i = 1:25
    nexttile;
    G = graph(graph_data_1{i}, 'OmitSelfLoops');
    plot(G, 'Layout', 'circle', 'NodeLabel', {});
    title(['Sample ' num2str(i)]);
end

% create simulated data for group 2
dsim_2 = DataSimulator('P_MAX', 0.5, 'P_MIN', 0.5, 'D', 4, 'N', 10, 'TIME_STEP', 200, 'N_SUB', 25, 'DIRECTORY', output_folder, 'GR_ID', 'SimGroup2');
graph_data_2 = dsim_2.get('GRAPH_DATA');

%yuxin add the circle plot for sim_data_2 with 5x5 panels
% 画出 group 2 的数据
figure;
tiledlayout(5, 5, 'Padding', 'compact', 'TileSpacing', 'compact');
for i = 1:25
    nexttile;
    G = graph(graph_data_2{i}, 'OmitSelfLoops');
    plot(G, 'Layout', 'circle', 'NodeLabel', {});
    title(['Sample ' num2str(i)]);
end



% export to folder
dsim_1.get('EXPORT_BA');
dsim_1.get('EXPORT_DATA');
dsim_2.get('EXPORT_DATA');

%% Load simulated data and verify the built-in meausre functions (Task 2)
% Load Brain Atlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [output_folder filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

% Load Group of Simulated Data
im_gr1 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [output_folder filesep 'SimGroup1'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [output_folder filesep 'SimGroup2'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

% Analysis FUN WU
a_WU1 = AnalyzeEnsemble_FUN_WU( ...
    'GR', gr1 ...
    );

a_WU2 = AnalyzeEnsemble_FUN_WU( ...
    'TEMPLATE', a_WU1, ...
    'GR', gr2 ...
    );

% Calculate individual network
clustering_WU1 = a_WU1.get('MEASUREENSEMBLE', 'Clustering').get('M');
clustering_WU2 = a_WU2.get('MEASUREENSEMBLE', 'Clustering').get('M');
clusteringAv_WU1 = a_WU1.get('MEASUREENSEMBLE', 'ClusteringAv').get('M');
clusteringAv_WU2 = a_WU2.get('MEASUREENSEMBLE', 'ClusteringAv').get('M');
sm_WU1 = a_WU1.get('MEASUREENSEMBLE', 'SmallWorldness').get('M');
sm_WU2 = a_WU2.get('MEASUREENSEMBLE', 'SmallWorldness').get('M');

%% Load simulated data and produce text book figures (Task 3)

output_folder = [fileparts(which('DataSimulator')) filesep 'SIM_DATASET_VARYING_P'];

% create simulated data for group % use the text parameter
dsim = DataSimulator('P_MAX', 0.00, 'P_MIN', 1, 'D', 4, 'N', 50, 'TIME_STEP', 200, 'N_SUB', 25, 'DIRECTORY', output_folder, 'GR_ID', 'TEXT_BOOOK_DATA');
ground_truth_graph_data = dsim.get('GRAPH_DATA');
p = dsim.get('P');
% ground_truth_pathlength_av = ....

% 计算不同 p 下的所有样本的平均路径长度
unique_p = unique(p);
avg_path_lengths_per_p = zeros(size(unique_p));
n_sub = dsim.get('N_SUB')
for idx = 1:length(unique_p)
    current_p = unique_p(idx);
    path_lengths = [];
    for i = 1:n_sub
        if p(i) == current_p
            G = graph(ground_truth_graph_data{i}, 'OmitSelfLoops');
            dists = distances(G);
            dists(dists == Inf) = NaN; % 处理不可达情况
            path_lengths = [path_lengths; nanmean(dists(:))];
        end
    end
    avg_path_lengths_per_p(idx) = nanmean(path_lengths);
end

% 绘制平均路径长度随连接概率 P 的变化图
figure;
plot(unique_p, avg_path_lengths_per_p, '-o', 'LineWidth', 2);
xlabel('Connection Probability P');
ylabel('Average Path Length');
title('Average Path Length vs Connection Probability P');
grid on;
% saveas(gcf, fullfile(output_folder, 'AvgPathLength_vs_P.png'));

disp('Plots saved successfully!');



%yuxin add the function to calculate the ground_truth_pathlength_av on the ground_truth_graph_data 

%yuxin add the plot of ground_truth_pathlength_av with respect to p 

% export the simulated data
dsim.get('EXPORT_BA');
dsim.get('EXPORT_DATA');

%%

% load ba and data
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [output_folder filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

im_gr = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [output_folder filesep 'TEXT_BOOOK_DATA'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr = im_gr.get('GR');

a_WU = AnalyzeEnsemble_FUN_WU( ...
    'GR', gr ...
    );

g_dict = a_WU.get('G_DICT');

graph_data = g_dict.get('IT_LIST');

%yuxin compare on the ground_truth_graph_data 


target_measure = 'PathLengthAv';

for i = 1:g_dict.get('LENGTH')
    pathlength_av(i) = g_dict.get('IT', i).get('M_DICT').get('IT', target_measure).get('M');
end

%yuxin add the plot of pathlength_av with respect to p 

%% Key feature configuration (Task 4)