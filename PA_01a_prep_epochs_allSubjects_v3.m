%% ALL SUBJECTS: Preprocessing and Epoching
% Parenthood_eyegaze
% Shadi & Tilman & Lisa (15/11/2017)
% Last Update: 27.09.2019

% This script is about preprocessing and epoching of the Praenthood_eyegaze Rawdata,
% leading to .set Data in the end, which then can be used for ERP analysis.

% cd('O:/Parenting Study/Parenting EEG/Parenthood_EyeContact/Analysis')

clear
clc
% addpath('O:/Parenting Study/Parenting EEG/Parenthood_EyeContact/Analysis/eeglab_correct/eeglab14_1_1b');
run('O:/Parenting Study/Parenting EEG/Parenthood_EyeContact/Analysis/eeglab_correct/eeglab14_1_1b/eeglab.m');


%% PATHs
% Shadi´s Laptop:
% FOLDERPATH  = '/Volumes/bio/daten/Parenting Study/Parenting EEG/Parenthood_EyeContact/rawdata/EEG/';
% BESAfile = '/Volumes/bio/daten/Shadi/Brain-Vision/Parenthood.elp';
% SAVEFILEPATH = '/Volumes/bio/daten/Parenting Study/Parenting EEG/Parenthood_EyeContact/Analysis/preprocessed_data/set_files/';

% Work on Office PC:
FOLDERPATH  = 'O:/Parenting Study/Parenting EEG/Parenthood_EyeContact/Analysis/preprocessed_data/ERPs (.mat files)/';
BESAfile = 'O:/Shadi/Brain-Vision_output/Parenthood.elp';
%SAVEFILEPATH = 'O:/Parenting Study/Parenting EEG/Parenthood_EyeContact/Analysis/preprocessed_data/tocheck/';

SAVEFILEPATH = 'O:/Parenting Study/Parenting EEG/Parenthood_EyeContact/Analysis/preprocessed_data/set_files_0.03_30/mothers/'; %fitered on 0.03 - 30 Hz

% special secret trick to display participant numbers: dir('O:\Parenting Study\Parenting EEG\Parenthood_EyeContact\Rawdata\EEG')

%% All participants that haven't completed the experiment or had some other problem: No eyegaze:[122017, 122019, 112035, 112036],Calibration problem:[122028], %Participant:67th = [202017] Fist particpant with correct Triggers. Dunno!
%% EEG for eyegaze but no Blood taken: 112110 (mother) , 202035, 202036 (non-mother)
% Mothers: 58,  Non-Mothers: 56  (including blood failure)

% Corrected EEG Files (wrong labelings): 122030 instead of 121030
% Total Number of Mothers with correct EEG: 59 [Breast-f(48),Bottle-f(11)] /*string below= 58/
% Including blood failure : 60
% Total Number of Non-Mothers with correct EEG: 53/ *string below= 55/
% Including blood failure : 56
% Still Problem; '202017'= No.67th ! '122028' Since the hormones are not important for the moment.!                                

%% Latest attemps
% mothers = {'112002' '112004' '112006' '112008' '112010' '112012' '112013' '112017' '112024' '122005' '112027' '112048' '112075' '112085'} 
%(112110); problem with the calibration, the  particpant with the blood issue got added! Since the hormones are not important for the moment.!
% subjects = {'112012'}; % for debugging

%% Participants that have been already checked:
mothers = {'112002' '112004' '112006' '112008' '112010' '112012' '112013' '112017' '112024' '122005' '112026' '112030' '112031' '112027' '112032' '112038' '112033' '112052' '112039' '112046' '112053' '112048' '112058' '112056' '112128' '122018' '112045' '112069' '112047' '112075' '112083' '112066' '122014' '112078' '112071' '112073' '112086' '112085' '112134' '112135' '112130' '112133' '112098' '112101' '112105' '112114' '112122' '112126' '122022' '112087' '122013' '122024' '112096' '112097' '122030' '122029' '122023' '122037' '112110'};  %59
non_mothers = {'202001' '202003' '202005' '202007' '202008' '202012' '202013' '202015' '202025' '202029' '202030' '202031' '202033' '202034' '202037' '202041' '202048' '202052' '202055' '202062' '202054' '202092' '202072' '202079' '202091' '202106' '202095' '202104' '202101' '202107' '202110' '202103' '202116' '202115' '202118' '202119' '202120' '202121' '202123' '202124' '202126' '202127' '202129' '202131' '202135' '202137' '202138' '202139' '202144' '202076' '202140' '202133' '202035' '202036' '202143'};   %55

% Total in string : 114 particpants
% Bottle-feeding (N=11): '122018' '122030' '122029' '122023' '122037' '122022'  '112128' '122013' '122024' '122014' '122005'

%% Add new participants here:
                                
%non_mothers = {''} 
%mothers = {''} 
%subjects = [mothers];

subjects = [mothers non_mothers];

%% Preprocessing and epoching loop
for subnumber = 1:length(subjects)

    % generate subject filename for loading and saving data
    filename   = [subjects{subnumber} '_eyegaze.vhdr']
    filefolder = [subjects{subnumber} '/Eyegaze/'];
    savefilename = [subjects{subnumber} '_eyegaze.set'];    

    % load data-Set and name it
    
    %eeglab redraw
    EEG = pop_loadbv([FOLDERPATH filefolder], filename,[],[1:43]); % exclude EMG channels

    % Check Channel location and insert A1
    EEG = pop_chanedit(EEG, 'lookup',BESAfile); % no names found for HO1,HO2,VO2,Corr,Zyg !!!!
    EEG = pop_chanedit(EEG, 'insert',44,'changefield',{44 'labels' 'A1'});
    EEG = pop_chanedit(EEG, 'setref',{'1:44' 'A1'});

    % Rereference (now 44 channels)
    EEG = pop_reref( EEG, [],'refloc',struct('labels',{'A1'},'type',{''},'theta',{[]},'radius',{[]},'X',{[]},'Y',{[]},'Z',{[]},'sph_theta',{[]},'sph_phi',{[]},'sph_radius',{[]},'urchan',{[]},'ref',{'A1'},'datachan',{0}));

    % Filter the data (2 separate calls of eegfilt)
    EEG = pop_eegfiltnew(EEG,  [], 30); % LP-filter   (EEG,  [], 40)
    EEG = pop_eegfiltnew(EEG, 0.03, []); % HP-filter  (EEG, 0.2, [])
    %EEG = pop_eegfiltnew(EEG, 1, []); % HP-filter, for Debugging

    %% BESA artifact correction (via linear derivation) 
    % 1. Import MSEC correction matrix (generated in BESA)
    delimiter = '\t'; % separator between columns
    startRow = 2; % because first row contains names of columns (channel names)
    %formatSpec = '%*s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f[^\n\r]';
    formatSpec = '%*s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]'; % 45 columns ?
    clear filename
    
    %read the text file into MATLAB
    filename_besamatrix = [FOLDERPATH subjects{subnumber} '/Calibration/Calibration Analysis New/' subjects{subnumber} '_Cali.matrix']; % !!!!!!!!!!!!!!!!! edit
    fileID = fopen(filename_besamatrix,'r');
    dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);
    fclose(fileID); % close text file

    besamatrix = [dataArray{1:end-1}];
    clear filename delimiter startRow formatSpec fileID dataArray ans

    fprintf('\nSize of BESA MSEC matrix: %i x %i\n',size(besamatrix,1),size(besamatrix,2));
    if size(besamatrix,1) ~= 47 | size(besamatrix,2) ~= 44 
        error('There is something wrong with the BESA matrix')
    end
    EEG.etc.besa_correction_matrix = besamatrix;
    % do correction using *matrix multiplication* with BESA matrix
    tmp = besamatrix * EEG.data(1:44,:);  % note: in matrix multiplication the order is important A*B is not the same as B*A % EMG channels are excluded
    EEG.data(1:44,:) = tmp(1:44,:); % add eye-track again, OVERWRITING the MSEC-channels ("ART") created by BESA
    tmp = [];

    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET);


    %% ALL Epochs
    EEG = pop_epoch( EEG, {'S 11'  'S 12'  'S 13' 'S 14' 'S 15' 'S 16'... % 1st pic direct
                           'S 21'  'S 22'  'S 23' 'S 24' 'S 25' 'S 26'... % 1st pic averted left
                           'S 31'  'S 32'  'S 33' 'S 34' 'S 35' 'S 36'... % 1st pic averted right
                           'S111'  'S112'  'S113' 'S114' 'S115' 'S116'... % 2nd pic averted->direct  
                           'S121'  'S122'  'S123' 'S124' 'S125' 'S126'... % 2nd pic direct->averted left
                           'S131'  'S132'  'S133' 'S134' 'S135' 'S136'... % 2nd pic direct->averted right
                           'S211'  'S212'  'S213' 'S214' 'S215' 'S216'... % non-change direct->direct
                           'S221'  'S222'  'S223' 'S224' 'S225' 'S226'... % non-change left->left
                           'S231'  'S232'  'S233' 'S234' 'S235' 'S236'... % non-change right->right
                           }, [-0.2 1.0], 'newname', [num2str(subnumber) '_filter_reref_epochs_ALL'], 'epochinfo', 'yes');

                       
% There is no uniformly 'optimum' method for selecting either the baseline period or the
%baseline value. Using the mean value in the pre-stimulus period (the pop_rmbase.m default) is effective for many
%datasets, if the goal of the analysis is to define transformations that occur in the data following the time-locking events.
%Press OK to subtract the baseline (or Cancel to not remove the baseline).                 
  
% Baseline correction
    EEG = applytochannels(EEG, [1:44] ,' pop_rmbase( EEG, [-100 0]);');

    fprintf('\n************************************')
    fprintf('\nTrials before: %i', size(EEG.data,3))
    fprintf('\n************************************\n')
    total_trials(subnumber,1) = size(EEG.data,3);

    % remove bad epochs - only for EEG-channels
    EEG = pop_eegthresh(EEG,1,[1:44] ,-80,80,-0.2,0.998,0,1); % finding bad epochs AND excluding them
    %EEG = pop_eegthresh(EEG,1,[1:44] ,-80,80,-0.2,0.998,0,0);
    %EEG = pop_rejepoch( EEG, find(EEG.reject.rejthresh) ,0);    

    fprintf('\n************************************')
    fprintf('\nTrials after rejections: %i', size(EEG.data,3))
    fprintf('\n************************************\n')
    total_trials(subnumber,2) = size(EEG.data,3);

    %% Save dataset/filename
    savefilename = [subjects{subnumber} '_pa_eyegaze.set'];
    EEG = pop_saveset( EEG, 'filename',savefilename,'filepath', SAVEFILEPATH);

    %% add on: display trial numbers to check how many trials were lost during correction
    disp('Trial numbers:')
    total_trials
    total_trials(:,2)-total_trials(:,1)
    disp('*** Done :) ***')
end

