# MEAanalysis_ONeill2023

The code in this package was developed to analyze *.mcd files generated during microelectrode array (MEA) recording experiments. It was developed by Kate M. O'Neill (oneill.katem@gmail.com), and all questions should be directed to her and to corresponding author Bonnie L. Firestein (firestein@biology.rutgers.edu).

Software requirements: MATLAB (versions 2017b or later)

We have included the spike times but not the raw *.mcd files, which will be made available upon reasonable request.
The code should be run in the following order:
  - mainScript_rawData_v1.m or mainScript_rawData_v2.m: run this code to analyze the raw *.mcd files and extract spike times and other activity metrics. There are two versions of this code because we used two versions over the years as MATLAB changed. Refer to the codes themselves for the differences. These codes also contain information on how to organize the folder structure. Make sure the folders analyze_mcd, mcs_related, and other_codes are in the file path.
  - the codes within organize_data: first run makeData2struct_allVars.m, and then run either combine_norm_pubData.m or combine_norm_pubData_no0sorEmpties.m (depending on your normalization needs).
  - the codes within downstream_bdnfOnly, downstream_gluBdnf, and downstream_gluOnly: these codes contain everything necessary for generating the plots and analysis in the manuscript. I suggest starting with the codes labeled "...SynchData_forRM.m" and "network_params...m". Then run the codes "...EstStats_plot_stats.m", "...EstStats_netwData.m", and "...EstStats_synchData.m". You can run the codes labeled "plotRawData_...m" and "plotSynchHists...m" to generate the raw data plots in
  - all data used for the code in the "downstream_..." folders are included in the folders data_bdnfOnly, data_gluBdnf, and data_gluOnly. 

Additional code and data: 
  - data_GCspikeTimes: The spike times used for the Granger causal analysis are included here. Please refer to the following link (and DOI) for the associated code: github.com/ShoutikM/GCandSynchronyAnalysisCode_ONeill_etal_NatCommunBiol_2023 (DOI: 10.5281/zenodo.10162717).
  - nonMEAdata_EIneurons: please see this folder for the raw TIF files, the marked TIF files from Fiji, and the code for calculating statistics.
  - nonMEAdata_EIsynapses: please see this folder for the raw TIF files and analysis code.
  - nonMEAdata_cellDeath: please see this folder for the the blinded TIF files (raw data), the image analysis code and outputs, and the code for calculating statistics.
  - nonMEAdata_western: please see this folder for the Western blot data and the code used for calculating statistics. 

All source data for direct plotting is available on Figshare: https://doi.org/10.6084/m9.figshare.24596121

Citation:
O'Neill KM, Anderson ED, Mukherjee S, Gandu S, McEwan SA, Omelchenko A, Rodriguez AR, Losert W, Meaney DF, Babadi B, Firestein BL. "Time-dependent homeostatic mechanisms underlie Brain-Derived Neurotrophic Factor action on neural circuitry." Communications Biology, 2023.
