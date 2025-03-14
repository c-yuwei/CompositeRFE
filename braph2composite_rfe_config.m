distribution_name = 'Composite RFE';
distribution_moniker = 'composite_rfe';
pipeline_folders = {
    'composite_rfe'
    };
braph2_version = 'heads/ywc-lite-genesis';

% Add here all included and excluded folders and elements
% '-folder'                 the folder and its elements will be excluded
%
% '+folder'                 the folder is included, but not its elements
%   '+_ElementName.gen.m'   the element is included,
%                           if the folder is included
%
% '+folder*'                the folder and its elements are included
%   '-_ElementName.gen.m'   the element is excluded,
%                           if the folder and its elements are included
% (by default, the folders are included as '+folder*')
rollcall = { ...
    '+util', '+_Exporter.gen.m', '+_Importer.gen.m', ...
    '+ds*', '-ds_examples', ...
    '+atlas*', ...
    '+gt', '+_Measure.gen.m', '+_Graph.gen.m', '+_GraphAdjPF.gen.m', '+_GraphHistPF.gen.m', '+_GraphPP_MDict.gen.m', '+_NoValue.gen.m', ...
        '+_MeasurePF.gen.m', '+_MeasurePF_BU.gen.m', '+_MeasurePF_GU.gen.m', '+_MeasurePF_NU.gen.m', '+_MeasurePF_NxPP_Node.gen.m', '+_MeasurePF_xUPP_Layer.gen.m', ...
    '+cohort*', ...
    '+analysis', '+_AnalyzeEnsemble.gen.m', '+_AnalyzeEnsemblePP_GDict.gen.m', '+_AnalyzeEnsemblePP_MeDict.gen.m', '+_CompareEnsemble.gen.m', '+_CompareEnsemblePP_CpDict.gen.m', ...
        '+_ComparisonEnsemble.gen.m', '+_ComparisonEnsembleBrainPF.gen.m', '+_ComparisonEnsembleBrainPF_BB.gen.m', '+_ComparisonEnsembleBrainPF_BS.gen.m', '+_ComparisonEnsembleBrainPF_BU.gen.m', ...
        '+_ComparisonEnsembleBrainPF_GB.gen.m', '+_ComparisonEnsembleBrainPF_GS.gen.m', '+_ComparisonEnsembleBrainPF_GU.gen.m', '+_ComparisonEnsembleBrainPF_NB.gen.m', '+_ComparisonEnsembleBrainPF_NS.gen.m', ...
        '+_ComparisonEnsembleBrainPF_NU.gen.m', '+_ComparisonEnsembleBrainPF_xSPP_Layer.gen.m', '+_ComparisonEnsembleBrainPF_xUPP_Layer.gen.m', '+_ComparisonEnsemblePF.gen.m', ...
        '+_ComparisonEnsemblePF_BB.gen.m', '+_ComparisonEnsemblePF_BS.gen.m', '+_ComparisonEnsemblePF_BU.gen.m', '+_ComparisonEnsemblePF_BxPP_Nodes.gen.m', '+_ComparisonEnsemblePF_GB.gen.m', ...
        '+_ComparisonEnsemblePF_GS.gen.m', '+_ComparisonEnsemblePF_GU.gen.m', '+_ComparisonEnsemblePF_NB.gen.m', '+_ComparisonEnsemblePF_NS.gen.m', '+_ComparisonEnsemblePF_NU.gen.m', '+_ComparisonEnsemblePF_NxPP_Node.gen.m', ...
        '+_ComparisonEnsemblePF_xUPP_Layer.gen.m', '+_MeasureEnsemble.gen.m', ...
        '+_MeasureEnsembleBrainPF.gen.m', '+_MeasureEnsembleBrainPF_GU.gen.m', '+_MeasureEnsembleBrainPF_NU.gen.m', '+_MeasureEnsembleBrainPF_xUPP_Layer.gen.m', ...
        '+_MeasureEnsemblePF.gen.m', '+_MeasureEnsemblePF_GU.gen.m', '+_MeasureEnsemblePF_NU.gen.m', '+_MeasureEnsemblePF_NxPP_Node.gen.m', '+_MeasureEnsemblePF_xUPP_Layer.gen.m', ...
        '+_PanelPropCellFDR.gen.m', ...
    '+nn*', ...
    '+gui*', ...
    '+brainsurfs*', ...
    '+atlases*', ...
    '+graphs', '+_GraphWU.gen.m', ...
    '+measures', '+_Degree.gen.m', '+_Triangles.gen.m', '+_Clustering.gen.m', '+_ClusteringAv.gen.m', '+_Distance.gen.m', '+_PathLength.gen.m', '+_PathLengthAv.gen.m', '+_SmallWorldness.gen.m', ...
    '+neuralnetworks*', ...
    '+pipelines', ...
        '+functional*', '-_AnalyzeEnsemble_FUN_BUD.gen.m', '-_AnalyzeEnsemble_FUN_BUT.gen.m', ...
        '+functional NN*', ...
        '+composite_rfe*', ...
    '+test*', ...
    '-sandbox' ...
    };
files_to_delete = { ...
    ['graphs' filesep 'test_GraphWU.m'], ...
    ['measures' filesep 'test_Degree.m'], ...
    ['measures' filesep 'test_Triangles.m'], ...
    ['measures' filesep 'test_Clustering.m'], ...
    ['measures' filesep 'test_ClusteringAv.m'], ...
    ['measures' filesep 'test_Distance.m'], ...
    ['measures' filesep 'test_PathLength.m'], ...
    ['measures' filesep 'test_PathLengthAv.m'], ...
    ['measures' filesep 'test_SmallWorldness.m'], ...
    ['neuralnetworks' filesep 'test_NNClassifierMLP.m'], ...
    ['neuralnetworks' filesep 'test_NNClassifierMLP_CrossValidation.m'], ...
    ['neuralnetworks' filesep 'test_NNClassifierMLP_CrossValidationPF_ROC.m'], ...
    ['neuralnetworks' filesep 'test_NNClassifierMLP_Evaluator.m'], ...
    ['neuralnetworks' filesep 'test_NNClassifierMLP_EvaluatorPF_ROC.m'], ...
    ['neuralnetworks' filesep 'test_NNRegressorMLP.m'], ...
    ['neuralnetworks' filesep 'test_NNRegressorMLP_CrossValidation.m'], ...
    ['neuralnetworks' filesep 'test_NNRegressorMLP_CrossValidationPF_Scatter.m'], ...
    ['neuralnetworks' filesep 'test_NNRegressorMLP_Evaluator.m'], ...
    ['neuralnetworks' filesep 'test_NNRegressorMLP_EvaluatorPF_Scatter.m'], ...
    ['neuralnetworks' filesep 'test_NNxMLP_FeatureImportance.m'], ...
    ['neuralnetworks' filesep 'test_NNxMLP_FeatureImportance_CV.m'], ...
    ['neuralnetworks' filesep 'test_NNxMLP_FeatureImportanceAcrossMeasures.m'], ...
    ['neuralnetworks' filesep 'test_NNxMLP_FeatureImportanceAcrossMeasures_CV.m'], ...
    ['neuralnetworks' filesep 'test_NNxMLP_FeatureImportanceBrainSurface.m'], ...
    ['neuralnetworks' filesep 'test_NNxMLP_FeatureImportanceBrainSurface_CV.m'], ...
    ['neuralnetworks' filesep 'test_NNxMLP_FeatureImportanceBrainSurfacePF.m'], ...
    ['neuralnetworks' filesep 'test_NNxMLP_FeatureImportanceBrainSurfacePF_BB.m'], ...
    ['neuralnetworks' filesep 'test_NNxMLP_FeatureImportanceBrainSurfacePF_BS.m'], ...
    ['neuralnetworks' filesep 'test_NNxMLP_FeatureImportanceBrainSurfacePF_BU.m'], ...
    ['neuralnetworks' filesep 'test_NNxMLP_FeatureImportanceBrainSurfacePF_GB.m'], ...
    ['neuralnetworks' filesep 'test_NNxMLP_FeatureImportanceBrainSurfacePF_GS.m'], ...
    ['neuralnetworks' filesep 'test_NNxMLP_FeatureImportanceBrainSurfacePF_GU.m'], ...
    ['neuralnetworks' filesep 'test_NNxMLP_FeatureImportanceBrainSurfacePF_NB.m'], ...
    ['neuralnetworks' filesep 'test_NNxMLP_FeatureImportanceBrainSurfacePF_NS.m'], ...
    ['neuralnetworks' filesep 'test_NNxMLP_FeatureImportanceBrainSurfacePF_NU.m'], ...
    ['neuralnetworks' filesep 'test_NNxMLP_FeatureImportanceBrainSurfacePP_Data.m'], ...
    ['neuralnetworks' filesep 'test_NNxMLP_FeatureImportanceBrainSurfacePP_Graph.m'], ...
    ['neuralnetworks' filesep 'test_NNxMLP_FeatureImportanceBrainSurfacePP_Measure.m'], ...
    ['neuralnetworks' filesep 'test_NNxMLP_FeatureImportanceBSPF_xSPP_Layer.m'], ...
    ['neuralnetworks' filesep 'test_NNxMLP_FeatureImportanceBSPF_xUPP_Layer.m'], ...
    ['neuralnetworks' filesep 'test_NNDataPoint_Graph_CLA.m'], ...
    ['neuralnetworks' filesep 'test_NNDataPoint_Graph_REG.m'], ...
    ['neuralnetworks' filesep 'test_NNDataPoint_Measure_CLA.m'], ...
    ['neuralnetworks' filesep 'test_NNDataPoint_Measure_REG.m'], ...
    ['neuralnetworks' filesep 'test_NNDataPointMLP_Shuffled.m'], ...
    ['pipelines' filesep 'functional' filesep 'test_AnalyzeEnsemble_FUN_WU.m'], ...
    ['pipelines' filesep 'functional' filesep 'pipeline_functional_analysis_bud.braph2'], ...
    ['pipelines' filesep 'functional' filesep 'pipeline_functional_analysis_but.braph2'], ...
    ['pipelines' filesep 'functional' filesep 'pipeline_functional_analysis_wu.braph2'], ...
    ['pipelines' filesep 'functional' filesep 'pipeline_functional_comparison_bud.braph2'], ...
    ['pipelines' filesep 'functional' filesep 'pipeline_functional_comparison_but.braph2'], ...
    ['pipelines' filesep 'functional' filesep 'pipeline_functional_comparison_wu.braph2'], ...
    ['pipelines' filesep 'functional NN' filesep 'test_NNDataPoint_FUN_CLA.m'], ...
    ['pipelines' filesep 'functional NN' filesep 'test_NNDataPoint_FUN_REG.m'], ...
    ['pipelines' filesep 'composite_rfe' filesep 'test_NNxMLP_FeatureImportanceAcrossFUN.m'], ...
    ['pipelines' filesep 'functional NN' filesep 'example_NN_FUN_CLA.m'], ...
    ['pipelines' filesep 'functional NN' filesep 'example_NN_FUN_REG.m'], ...
    ['pipelines' filesep 'functional NN' filesep 'example_NNCV_FUN_BUD_M_CLA.m'], ...
    ['pipelines' filesep 'functional NN' filesep 'example_NNCV_FUN_BUD_REG.m'], ...
    ['pipelines' filesep 'functional NN' filesep 'example_NNCV_FUN_BUT_M_CLA.m'], ...
    ['pipelines' filesep 'functional NN' filesep 'example_NNCV_FUN_BUT_REG.m'], ...
    ['pipelines' filesep 'functional NN' filesep 'example_NNCV_FUN_WU_CLA.m'], ...
    ['pipelines' filesep 'functional NN' filesep 'example_NNCV_FUN_WU_M_REG.m'], ...
    ['pipelines' filesep 'functional NN' filesep 'pipeline_regression_cross_validation_functional_wu_measure.braph2'], ...
    ['pipelines' filesep 'functional NN' filesep 'pipeline_regression_cross_validation_functional_but.braph2'], ...
    ['pipelines' filesep 'functional NN' filesep 'pipeline_regression_cross_validation_functional_bud.braph2'], ...
    ['pipelines' filesep 'functional NN' filesep 'pipeline_classification_training_test_split_functional_data.braph2'], ...
    ['pipelines' filesep 'functional NN' filesep 'pipeline_classification_cross_validation_functional_wu.braph2'], ...
    ['pipelines' filesep 'functional NN' filesep 'pipeline_classification_cross_validation_functional_but_measure.braph2'], ...
    ['pipelines' filesep 'functional NN' filesep 'pipeline_classification_cross_validation_functional_bud_measure.braph2'] ...   
    };