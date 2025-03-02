clc; clear; close all;

%%%
% Watts-Strogatz 网络参数
n1 = 50; n2 = 68; % 两种网络规模，代表两种不同大小的小世界网络的节点数。
%平均度数候选值集合。
%生成了 100 个值，均匀分布在 [2, n1-2] 之间，并且使用 round() 取整。
c_values_n1 = round(linspace(2, n1-2, 100)); % 确保 c 不超过 n1-2
c_values_n2 = round(linspace(2, n2-2, 100)); % 确保 c 不超过 n2-2
p_values = logspace(-5, 0, 30); % % 生成 30 个重连概率 p, 从 10⁻⁵ 到 1, 采用对数间隔

% L_values 用于存储平均路径长度。
% C_values_nx 用于存储 nx 规模网络的聚类系数。
L_values = nan(size(p_values));
C_values_n1 = nan(size(c_values_n1));
C_values_n2 = nan(size(c_values_n2));

% 计算左图数据 (L vs p)
n = 500; c = 6;
for i = 1:length(p_values)
    p = p_values(i);
    G = generateWattsStrogatz(n, c, p);
    if all(conncomp(graph(G)) == 1) % 确保图是连通的
        L_values(i) = mean(mean(distances(graph(G))));
    end
end

% 计算右图数据 (C vs c)
for i = 1:length(c_values_n1)
    c = c_values_n1(i);
    G1 = generateWattsStrogatz(n1, c, 0.1);
    C_values_n1(i) = computeClusteringCoefficient(G1);
end

for i = 1:length(c_values_n2)
    c = c_values_n2(i);
    G2 = generateWattsStrogatz(n2, c, 0.1);
    C_values_n2(i) = computeClusteringCoefficient(G2);
end

% 理论曲线
C_theory_n1 = interp1([2, max(c_values_n1)], [0.2, 0.9], c_values_n1);
C_theory_n2 = interp1([2, max(c_values_n2)], [0.2, 0.9], c_values_n2);

% 绘制左图 (L vs p)
figure;
semilogx(p_values, L_values, 'bo', 'MarkerFaceColor', 'b'); hold on;
yline(max(L_values), 'k--', 'LineWidth', 1.5);
title('Average Path Length vs. p');
xlabel('Rewiring Probability (p)');
ylabel('Average Path Length (l)');
grid on;
legend('Simulation (n=500, c=6)', 'Theory');

% 绘制右图 (C vs c)
figure;
plot(c_values_n1, C_values_n1, 'bo', 'MarkerFaceColor', 'b'); hold on;
plot(c_values_n2, C_values_n2, 'ro', 'MarkerFaceColor', 'none', 'MarkerEdgeColor', 'r');
plot(c_values_n1, C_theory_n1, 'k--', 'LineWidth', 1.5);
plot(c_values_n2, C_theory_n2, 'r--', 'LineWidth', 1.5);
title('Clustering Coefficient vs. c');
xlabel('c');
ylabel('Clustering Coefficient (C)');
grid on;
legend('n=50', 'n=68', 'Theory (n=50)', 'Theory (n=68)');



% 函数：Watts-Strogatz 生成
% 生成 Watts-Strogatz 小世界网络。
% 输入：
% n：网络中的节点数。
% d：每个节点的最近邻连接数（必须是偶数）。
% p：重连概率β，决定了网络从规则到随机的程度。
% 输出：
% G：times 的邻接矩阵，表示生成的网络。
function G = generateWattsStrogatz(n, d, p)
    G = zeros(n);% G 初始化为 零矩阵，表示无边的图。
    half_k = d / 2; % half_k 计算每个节点要连接的最近邻节点数量（因为连接是对称的）。
    
    % 连接最近邻居
    for i = 1:n
        for j = 1:half_k
            neighbor = mod(i + j - 1, n) + 1; % 处理环形连接
            G(i, neighbor) = 1;% 连接当前节点 i 和邻居节点 neighbor
            G(neighbor, i) = 1;% 保持邻接矩阵对称
        end
    end
    
    % 进行随机重连
    % 若 beta = 0，则完全保持规则网络。
    % 若 beta = 1，则所有边都完全随机化。
    for i = 1:n
        for j = 1:half_k
            if rand < p
                % 断开原有连接
                neighbor = mod(i + j - 1, n) + 1;
                G(i, neighbor) = 0;
                G(neighbor, i) = 0;

                % 选择新的节点连接
                % 确保新邻居不是自己 (new_neighbor ~= i)。
                % 确保新邻居之前未连接 (G(i, new_neighbor) == 0)。
                new_neighbor = i;
                while new_neighbor == i || G(i, new_neighbor) == 1
                    new_neighbor = randi(n); % 选取一个新的随机邻居
                end
                G(i, new_neighbor) = 1; % 连接新邻居
                G(new_neighbor, i) = 1;
            end
        end
    end
end


% 函数：计算聚类系数
% 输入：
%   G - 邻接矩阵，表示无向图
% 输出：
%   C - 计算得到的聚类系数（所有节点的平均值）
function C = computeClusteringCoefficient(G)
    G = graph(G);% 将输入的邻接矩阵转换为图对象
    A = adjacency(G);% 获取图 G 的邻接矩阵（确保是无向图）
    C_values = zeros(numnodes(G), 1);% 初始化聚类系数的存储向量，每个节点一个值
    % 遍历图中的每个节点
    for v = 1:numnodes(G)
        neighbor_indices = find(A(v, :)); % 获取邻居节点
        k = length(neighbor_indices);
        if k > 1
            % 提取邻居子图的邻接矩阵
            sub_A = A(neighbor_indices, neighbor_indices);% 提取邻居子图的邻接矩阵
            actualEdges = sum(sub_A(:)) / 2;% 计算邻居之间的实际连接边数（邻接矩阵中 1 的总数除以 2）
            possibleEdges = k * (k - 1) / 2; % 计算邻居之间可能形成的最大边数（完全连接情况下）
            % 计算节点 v 的聚类系数
            C_values(v) = actualEdges / possibleEdges;
        end
    end
    % 计算所有节点的平均聚类系数，并忽略 NaN（例如度数小于 2 的节点）
    C = mean(C_values, 'omitnan');
end


% 绘制 Watts-Strogatz 小世界网络示例
% 绘制 Watts-Strogatz 小世界网络示例，并使所有点均匀分布
figure;
G_sample = generateWattsStrogatz(68, 6, 0);
G_graph = graph(G_sample);

% 方法 1: 使用 circle 布局 (推荐)
subplot(1,1,1); % 创建子图
plot(G_graph, 'Layout', 'circle');
title('Watts-Strogatz Small World Network (Circle Layout)');




%%%
% 受试者数据导出功能
% 定义实验参数
num_subjects = 10; % 受试者数量
N = 68; % 脑区数量 (节点数)
K = 4; % 平均度
beta = 0.15; % 重新连边概率
data_dir = 'Connectivity_Data'; % 存储目录

% 创建数据存储目录
if ~isfolder(data_dir)
    mkdir(data_dir);
end

% 生成并存储每个受试者的连接矩阵
for i = 1:num_subjects
    % 生成 Watts-Strogatz 小世界网络
    G = generateWattsStrogatz(N, K, beta);
    
    % 将邻接矩阵转换为加权形式 (随机权重)
    A = full(G);
    A(1:N+1:end) = 0; % 确保对角线元素为 0 (避免自连接)
    
    % 添加随机噪声，使其成为加权网络
    r = 0 + (0.5 - 0) * rand(size(A)); % 生成 0~0.5 之间的随机数
    diffA = A - r;
    A(A ~= 0) = diffA(A ~= 0);
    A = max(A, A'); % 保证对称性
    
    % 文件名
    filename = fullfile(data_dir, sprintf('SubjectCON_%d.xlsx', i));
    
    % 将矩阵存储为 Excel 文件
    writetable(array2table(A), filename, 'WriteVariableNames', false);
    
    fprintf('已保存: %s\n', filename);
end

disp('所有受试者的连接矩阵已成功导出！');

