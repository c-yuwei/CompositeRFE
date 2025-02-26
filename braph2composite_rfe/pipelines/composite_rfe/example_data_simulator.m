%% Task 1

% 预分配存储100个小世界网络
generated_network = cell(1, 100);

% 生成100个不同概率p的小世界网络
for i = 1:100
    p = i * 0.01; % 这里p取值从0.01到1
    dsim = DataSimulator('P', p, 'D', 4, 'N', 20, 'TIME_STEP', 200, 'N_SUB', 1);
    G_cell = dsim.get('GRAPH_DATA');
    cov_cell = dsim.get('SIM_DATA');

    % 确保 G_cell 不是空的
    if isempty(G_cell)
        warning('警告: DataSimulator 在 P=%.2f 处返回空 SIM_DATA', p);
        continue; % 跳过这个值，继续循环
    end

    % 取出 cell 数组中的邻接矩阵
    G = G_cell{1};  

    % 确保 G 是有效的邻接矩阵
    if isempty(G) || ~ismatrix(G) || size(G,1) ~= size(G,2)
        warning('P = %.2f: 无效的邻接矩阵 G', p);
        continue;
    end

    generated_network{i} = G; % 存储有效的网络
end

% 确保至少有一个有效网络
valid_networks = generated_network(~cellfun('isempty', generated_network));
if isempty(valid_networks)
    error('所有 P 值下都未能生成有效的 G 矩阵');
end

% 随机选择一个有效网络进行绘制
random_index = randi(length(valid_networks));
selected_network = valid_networks{random_index};

% 绘制网络
figure;
graph_obj = graph(selected_network); % 将邻接矩阵转换为Graph对象
plot(graph_obj, 'Layout', 'circle'); % 以力导向布局绘制网络
title(sprintf('Small-world Network (P = %.2f)', random_index * 0.01));
xlabel('Nodes');
ylabel('Connections');

dsim = DataSimulator('P', 0.2, 'D', 4, 'N', 20, 'TIME_STEP', 200, 'N_SUB', 1);
G_cell = dsim.get('GRAPH_DATA');
cov_cell = dsim.get('SIM_DATA');

% disp('Selected G_cell (adjacency matrix):');
% disp(G_cell{1});
% 
% disp('Selected cov_cell (simulated fMRI data):');
% disp(cov_cell{1});


% sim_data = dsim.get('SIM_DATA'); % 获取 sim_data

% disp('Simulated fMRI data (first sample):');
% disp(sim_data{1}); % 显示第一个样本的矩阵



%%%
clear

%% Task 2

dsim_1 = DataSimulator('P', 0.02, 'D', 4, 'N', 68, 'TIME_STEP', 200, 'N_SUB', 25, 'DIRECTORY', 'Group 1');

sim_data = dsim_1.get('SIM_DATA');

% % 检查数据格式
% if iscell(sim_data) && ~isempty(sim_data)
%     disp('SIM_DATA 是 cell 数组，检查第一个样本：');
%     first_sample = sim_data{1}; % 取第一个样本
%     disp(size(first_sample)); % 显示数据的行列数
% 
%     if size(first_sample, 2) == 68
%         disp('数据格式正确，每列代表一个脑区');
%     else
%         error('数据格式错误：列数应为 68，实际为 %d', size(first_sample, 2));
%     end
% else
%     error('SIM_DATA 为空，无法导出');
% end


dsim_1.get('EXPORT_DATA')

% % 手动导出数据 !68列 200行
% if exist('first_sample', 'var') && size(first_sample, 2) == 68
%     xlswrite('D:\GitHub\CompositeRFE\Group 1\manual_export.xlsx', first_sample);
%     disp('数据已手动导出，检查 manual_export.xlsx 是否正确');
% else
%     error('数据格式不对，手动导出失败');
% end




dsim_2 = DataSimulator('P', 0.2, 'D', 4, 'N', 68, 'TIME_STEP', 200, 'N_SUB', 25, 'DIRECTORY', 'Group 2');
dsim_2.get('EXPORT_DATA')

%% Task 2.1

% 'FILE', [fileparts(which('SubjectFUN')) filesep 'Example data FUN XLS' filesep 'atlas.xlsx'], ... % get desikan desikan_atlas.xlsx path

% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', 'D:\\GitHub\\CompositeRFE\\braph2genesis\\atlases\\desikan_atlas.xlsx', ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

dsim_1 = DataSimulator('BA', ba, 'P', 0.02, 'D', 4, 'N', 68, 'TIME_STEP', 200, 'N_SUB', 25, 'DIRECTORY', 'Group 1');
dsim_1.get('EXPORT_DATA')


dsim_2 = DataSimulator('BA', ba, 'P', 0.2, 'D', 4, 'N', 68, 'TIME_STEP', 200, 'N_SUB', 25, 'DIRECTORY', 'Group 2');
dsim_2.get('EXPORT_DATA')

group1_path = fullfile('D:', 'GitHub', 'CompositeRFE', 'Group 1');
% Load Groups of SubjectFUN

% 'DIRECTORY', [fileparts(which('SubjectFUN')) filesep 'Example data FUN XLS' filesep 'FUN_Group_1_XLS'], ... % your group directory

im_gr1 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', 'D:\GitHub\CompositeRFE\Group 1\GR FUN', ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

% 'DIRECTORY', [fileparts(which('SubjectFUN')) filesep 'Example data FUN XLS' filesep 'FUN_Group_2_XLS'], ... % your group directory

im_gr2 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', 'D:\GitHub\CompositeRFE\Group 2\GR FUN', ...
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

% measure calculation

strength_WU1 = a_WU1.get('MEASUREENSEMBLE', 'Clustering').get('M');
strength_WU2 = a_WU2.get('MEASUREENSEMBLE', 'Clustering').get('M');



%% Task 3
% load the exported data and calculate the clustering and smallworldness
% with the built-in functionalites


%% Task 4
% key brain region