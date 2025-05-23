%EXAMPLE_DATA_SIMULATOR
% Script example data simulator

clear variables %#ok<*NASGU>

%% Simulate data with small worldness and produce text book figures (Task 1)

output_folder = [fileparts(which('DataSimulator')) filesep 'SIM_DATASET_TWO_GROUPS'];

% create simulated data for group 1
%eff_nodes = [1 3 6 8 10 12 14 18];
%eff_nodes = [1 3 6 10];
g_temp = GraphWU();
%dsim = DataSimulator('P_MAX', 0.0001, 'P_MIN', 0.9999, 'D', 6, 'N', 500, 'EFF_NODES', eff_nodes, 'TIME_STEP', 100, 'N_SUB', 50, 'SIM_DIRECTORY', output_folder, 'SIM_GR_ID', 'SimGroup1', 'GRAPH_TEMPLATE', g_temp);
dsim = DataSimulator('P_MAX', 0.999, 'P_MIN', 0.001, 'D', 4, 'N', 20, 'TIME_STEP', 100, 'N_SUB', 25, 'SIM_DIRECTORY', output_folder, 'SIM_GR_ID', 'SimGroup1', 'GRAPH_TEMPLATE', g_temp);
%dsim.get('PLOT_PATHLENGTH')

gui = GUIElement('PE', dsim);
gui.get('DRAW');
gui.get('SHOW')

