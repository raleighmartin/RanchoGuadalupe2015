%% Function to read in data from 'file_GrainSizeMetadata' (a .xlsx spreadsheet) that
% gives basic info about grain size samples for analysis
% Function outputs two structured arrays with file information about grain
% size samples for surface sand and BSNes
% Dependencies: NONE, RoundTimeMin
% Used by: Processing_Master

function [GrainSizeMetadata_Surface, GrainSizeMetadata_BSNE] = ...
    ParseGrainSizeMetadata(folder_GrainSizeMetadata,file_GrainSizeMetadata)

%% Get file location
filePath = strcat(folder_GrainSizeMetadata,file_GrainSizeMetadata);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Import Surface grain size metadata %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[~, ~, raw] = xlsread(filePath,'SurfaceSamples');
raw = raw(2:end,:);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};

%% Allocate imported array to column variable names
Filename = {raw(:,1)};
Site = {raw(:,2)};
Date = round(cell2mat(raw(:,3))); %round this to get precise time
Location = {raw(:,4)};
CollectionTime = cell2mat(raw(:,5));

%% Convert dates to MATLAB datetime format
CollectionTime = datetime(Date+CollectionTime,'ConvertFrom','excel');
Date = datetime(Date,'ConvertFrom','excel');

%% Correct for roundoff error (assuming time resolution of minutes)
CollectionTime = RoundTimeMin(CollectionTime);

%% Create structured array with spreadsheet information
% GrainSizeMetadata_Surface.Filename = Filename;
% GrainSizeMetadata_Surface.Site = Site;
% GrainSizeMetadata_Surface.Date = Date;
% GrainSizeMetadata_Surface.Location = Location;
% GrainSizeMetadata_Surface.CollectionTime = CollectionTime;

GrainSizeMetadata_Surface = struct(...
    'Filename',Filename,...
    'Site',Site,...
    'Date',Date,...
    'Location',Location,...
    'CollectionTime',CollectionTime);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Import BSNE grain size metadata %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[~, ~, raw] = xlsread(filePath,'BSNE');
raw = raw(2:end,:);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};

%% Allocate imported array to column variable names
Filename = {raw(:,1)};
Site = {raw(:,2)};
Date = round(cell2mat(raw(:,3))); %round this to get precise time
NameBSNE = {raw(:,4)};
StartTime = cell2mat(raw(:,5));
EndTime = cell2mat(raw(:,6));
Notes = {raw(:,7)};

%% Convert dates to MATLAB datetime format
StartTime = datetime(Date+StartTime,'ConvertFrom','excel');
EndTime = datetime(Date+EndTime,'ConvertFrom','excel');
Date = datetime(Date,'ConvertFrom','excel');

%% Correct for roundoff error (assuming time resolution of minutes)
StartTime = RoundTimeMin(StartTime);
EndTime = RoundTimeMin(EndTime);

%% Create structured array with spreadsheet information
% GrainSizeMetadata_BSNE.Filename = Filename;
% GrainSizeMetadata_BSNE.Site = Site;
% GrainSizeMetadata_BSNE.Date = Date;
% GrainSizeMetadata_BSNE.NameBSNE = NameBSNE;
% GrainSizeMetadata_BSNE.StartTime = StartTime;
% GrainSizeMetadata_BSNE.EndTime = EndTime;
% GrainSizeMetadata_BSNE.Notes = Notes;

GrainSizeMetadata_BSNE = struct(...
    'Filename',Filename,...
    'Site',Site,...
    'Date',Date,...
    'NameBSNE',NameBSNE,...
    'StartTime',StartTime,...
    'EndTime',EndTime,...
    'Notes',Notes);