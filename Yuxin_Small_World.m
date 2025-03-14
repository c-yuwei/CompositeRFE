clc; clear; close all;

%%%
n1 = 50; n2 = 68; 
c_values_n1 = round(linspace(2, n1-2, 100)); 
c_values_n2 = round(linspace(2, n2-2, 100)); 
p_values = logspace(-5, 0, 30); 

L_values = nan(size(p_values));
C_values_n1 = nan(size(c_values_n1));
C_values_n2 = nan(size(c_values_n2));

n = 500; c = 6;
for i = 1:length(p_values)
    p = p_values(i);
    G = generateWattsStrogatz(n, c, p);
    if all(conncomp(graph(G)) == 1) 
        L_values(i) = mean(mean(distances(graph(G))));
    end
end

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

C_theory_n1 = interp1([2, max(c_values_n1)], [0.2, 0.9], c_values_n1);
C_theory_n2 = interp1([2, max(c_values_n2)], [0.2, 0.9], c_values_n2);

figure;
semilogx(p_values, L_values, 'bo', 'MarkerFaceColor', 'b'); hold on;
yline(max(L_values), 'k--', 'LineWidth', 1.5);
title('Average Path Length vs. p');
xlabel('Rewiring Probability (p)');
ylabel('Average Path Length (l)');
grid on;
legend('Simulation (n=500, c=6)', 'Theory');

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



function G = generateWattsStrogatz(n, d, p)
    G = zeros(n);
    half_k = d / 2;
    
    
    for i = 1:n
        for j = 1:half_k
            neighbor = mod(i + j - 1, n) + 1; 
            G(i, neighbor) = 1;
            G(neighbor, i) = 1;
        end
    end
    
    for i = 1:n
        for j = 1:half_k
            if rand < p
                neighbor = mod(i + j - 1, n) + 1;
                G(i, neighbor) = 0;
                G(neighbor, i) = 0;
                new_neighbor = i;
                while new_neighbor == i || G(i, new_neighbor) == 1
                    new_neighbor = randi(n); 
                end
                G(i, new_neighbor) = 1; 
                G(new_neighbor, i) = 1;
            end
        end
    end
end


function C = computeClusteringCoefficient(G)
    G = graph(G);
    A = adjacency(G);
    C_values = zeros(numnodes(G), 1);
    for v = 1:numnodes(G)
        neighbor_indices = find(A(v, :)); 
        k = length(neighbor_indices);
        if k > 1
            sub_A = A(neighbor_indices, neighbor_indices);
            actualEdges = sum(sub_A(:)) / 2;
            possibleEdges = k * (k - 1) / 2;
            C_values(v) = actualEdges / possibleEdges;
        end
    end
    
    C = mean(C_values, 'omitnan');
end

figure;
G_sample = generateWattsStrogatz(68, 6, 0);
G_graph = graph(G_sample);

subplot(1,1,1); 
plot(G_graph, 'Layout', 'circle');
title('Watts-Strogatz Small World Network (Circle Layout)');


num_subjects = 10; 
N = 68; 
K = 4; 
beta = 0.15; 
data_dir = 'Connectivity_Data'; 

if ~isfolder(data_dir)
    mkdir(data_dir);
end

for i = 1:num_subjects
    G = generateWattsStrogatz(N, K, beta);
    
    A = full(G);
    A(1:N+1:end) = 0; 
    
    r = 0 + (0.5 - 0) * rand(size(A)); 
    diffA = A - r;
    A(A ~= 0) = diffA(A ~= 0);
    A = max(A, A'); 
    
    filename = fullfile(data_dir, sprintf('SubjectCON_%d.xlsx', i));
    
    writetable(array2table(A), filename, 'WriteVariableNames', false);
    
    fprintf('Excel being saved: %s\n', filename);
end

disp('All the subjects have been saved!');

