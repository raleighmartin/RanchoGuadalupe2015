%% function to take info about grain size collections
% and use this to crunch through outputs of Camsizer analyses
% Dependencies: 
% Used by: Processing_Master

function GrainSizeArray = ProcessGrainSize(GrainSizeMetadata,folder_GrainSize)

%% initialize structured array of grain size data based on metadata structured array
GrainSizeArray = GrainSizeMetadata;

% get number of samples
N_Samples = length(GrainSizeMetadata.Filename);

%% go through each flux calculation time interval
for i = 1:N_Samples;
    
    %% Get file location
    filePath = strcat(folder_GrainSize,GrainSizeMetadata.Filename{i},'_xc_min_.xle')
    
    %process file
    [d_10, d_50, d_90, Q3_1mm, Q3_2mm, Q3_4mm, SPAN3, U3, ...
    Q3_SPHT0pt9, Q3_Symm0pt9, Q3_bl0pt9, SPHT3_bar, Symm3_bar, bl3_bar, ...
    Sizeclass_lower,Sizeclass_upper,retained,passing,...
    SPHT3,Symm3,bl3,particlesdetected] = gsimport(filePath);

    %add elements to structured array
    GrainSizeArray.d_10{i,1} = d_10;
    GrainSizeArray.d_50{i,1} = d_50;
    GrainSizeArray.d_90{i,1} = d_90;
end