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
P (parameter, scalar) is a number of probability for a Watts–Strogatz model.
%%%% ¡default!
0.2

%%% ¡prop!
D (parameter, scalar) is a number of degree for a Watts–Strogatz model.
%%%% ¡default!
4

%%% ¡prop!
N (parameter, scalar) is a number of node for a Watts–Strogatz model.
%%%% ¡default!
68

N_SUB (data, scalar) is a number of subject to be generated.
%%%% ¡default!
10

SIM_DATA (result, cell) is the simulated data using the Watts–Strogatz model.
%%%% ¡calculate! 
% yuxin
value = {}; 

SIM_GR (result, item) is the group of subjectFUN for those simulated data.
%%%% ¡settings!
'Group'
%%%% ¡calculate!
% yuxin
value = Group(); 

%%% ¡prop!
DIRECTORY (data, string) is the directory to export the FUN subject group files.
%%%% ¡default!
fileparts(which('BRAPH2.LAUNCHER'))

%%% ¡prop!
EX (data, item) exports a group of subjects with the simulated fMRI data to a series of XLSX file.
%%%% ¡settings!
'ExporterGroupSubjectFUN_XLS'
%%%% ¡postset!
if isa(dsim.getr('EX'), 'NoValue')
    ex = ExporterGroupSubjectFUN_XLS('DIRECTORY', dsim.get('DIRECTORY'), dsim.get('SIM_GR'), gr);
    dsim.set('EXPORTER', ex);
end