%% Creating Parenthood.mat (extracting and naming epochs)

cd('O:\Parenting Study\Parenting EEG\Parenthood_EyeContact\Analysis')

clear
clc

run('O:/Parenting Study/Parenting EEG/Parenthood_EyeContact/Analysis/eeglab_correct/eeglab14_1_1b/eeglab.m');

%%  Coding system
% Ad vs Ba -> adult pictures vs baby pictures
% emotions: angry, happy, neutral
% gaze directions:
    % Start pictures: Frontal, L, R
    % Change pictures:
        % C_A_F -> change averted to frontal
        % C_F_A_L -> change frontal to averted left
        % C_F_A_R -> change frontal to averted right
        % NC -> non-change
% Mo vs NM -> mothers vs non-mothers

%% PATH (change if necessary)

% Work on Lab PC:

%FOLDERPATH = 'O:/Parenting Study/Parenting EEG/Parenthood_EyeContact/Analysis/preprocessed_data/tocheck/';
%savefolder = 'O:/Parenting Study/Parenting EEG/Parenthood_EyeContact/Analysis/preprocessed_data/tocheck/';

FOLDERPATH = 'O:/Parenting Study/Parenting EEG/Parenthood_EyeContact/Analysis/preprocessed_data/set_files_0.03_30';
savefolder = 'O:/Parenting Study/Parenting EEG/Parenthood_EyeContact/Analysis/preprocessed_data/ERPs (.mat files)/';

% special secret trick to display participant numbers: dir('O:\Parenting Study\Parenting EEG\Parenthood_EyeContact\rawdata\EEG')

%% All participants that haven't completed the experiment or had some other problem: 122017, 112036, 122019

% Last participant update: 27.09.19

mothers = {'112002' '112004' '112006' '112008' '112010' '112012' '112013' '112017' '112024' '122005' '112026' '112030' '112031' '112027' '112032' '112038' '112033' '112052' '112039' '112046' '112053' '112048' '112058' '112056' '112128' '122018' '112045' '112069' '112047' '112075' '112083' '112066' '122014' '112078' '112071' '112073' '112086' '112085' '112134' '112135' '112130' '112133' '112098' '112101' '112105' '112114' '112122' '112126' '122022' '112087' '122013' '122024' '112096' '112097' '122030' '122029' '122023' '122037' '112110'};  %59
non_mothers = {'202001' '202003' '202005' '202007' '202008' '202012' '202013' '202015' '202025' '202029' '202030' '202031' '202033' '202034' '202037' '202041' '202048' '202052' '202055' '202062' '202054' '202092' '202072' '202079' '202091' '202106' '202095' '202104' '202101' '202107' '202110' '202103' '202116' '202115' '202118' '202119' '202120' '202121' '202123' '202124' '202126' '202127' '202129' '202131' '202135' '202137' '202138' '202139' '202144' '202076' '202140' '202133' '202035' '202036' '202143'};   %55

%mothers = {'112004' '112006' '112008' '112010' '112012' '112013' '112024' '122005' '112026' '112030' '112031' '112027' '112032' '112038' '112033' '112052' '112039' '112046' '112053' '112048' '112058' '112056' '112128' '122018' '112045' '112069' '112047' '112075' '112083' '112066' '122014' '112078' '112071' '112073' '112086' '112085' '112134' '112135' '112130' '112133' '112098' '112101' '112105' '112114' '112122' '112126' '122022' '112087' '122013' '122024' '112096' '112097' '122030' '122029' '122023' '122037' '112110'};   % 57
%non_mothers = {'202001' '202005' '202007' '202008' '202012' '202013' '202015' '202025' '202029' '202030' '202031' '202033' '202034' '202037' '202041' '202048' '202052' '202055' '202062' '202054' '202092' '202079' '202091' '202106' '202095' '202104' '202101' '202107' '202110' '202103' '202116' '202115' '202118' '202119' '202120' '202121' '202123' '202124' '202126' '202127' '202129' '202131' '202135' '202137' '202138' '202139' '202144' '202076' '202140' '202133' '202035' '202036' '202143'};   %53

%mothers = {'112008'}; for some reason i had to check these two particpants
%non_mothers = {'202007'};

%Participant:67th = '202017' has bad data! Still !

subjects = [mothers non_mothers];

for s = 1:length(subjects)    
    %% load EEG epochs of this subject
    FILENAME = [subjects{s} '_pa_eyegaze.set'] % set file
    EEG = pop_loadset('filename',FILENAME,'filepath',FOLDERPATH);

    %% Create help variable containing type of time-locking event for each of the extracted epochs (NEW)
    clear epoch_eventtype
    for i=1:size(EEG.data,3) % loop through all epochs
        if iscell(EEG.epoch(i).eventtype) % check data type within EEG.epoch.eventtype (if two triggers occur in the same epoch, it is cell, otherwise char)
            lats = cell2mat([ EEG.epoch(i).eventlatency(:) ]); % EEG.epoch.eventlatency is also cell
            ix0 = find(lats==0);
            epoch_eventtype{i} = EEG.epoch(i).eventtype{ix0}; % reference in cell object
        else % EEG.epoch.eventtype is char; EEG.epoch.eventlatency is double
            lats = [ EEG.epoch(i).eventlatency(:) ];
            ix0 = find(lats==0);        
            epoch_eventtype{i} = EEG.epoch(i).eventtype((ix0*4-3) : (ix0*4)); % take 4 digits (since 'S211' has for digits)
        end
    end
    
    % "epoch_eventtype" now contains the triggers with latency=0 of each epoch
    
    % @ Olaf: This was the preliminary snippet:
%     for e=1:size(EEG.data,3) % for e=1:EEG.trials
% 
%         e
%         lats = [ EEG.epoch(e).eventlatency{:} ];
%         ix0 = find(lats==0);
%         epoch_eventtype(e) = EEG.epoch(e).eventtype(ix0);
% 
%     end
    
    %% select, name, and save epochs 
    % old code: Frontal_Neutral = find(ismember({EEG.event.type},'S 11'));
    
    % START: frontal, all emotions
    Ad_Frontal_Neutral = find(ismember(epoch_eventtype,'S 11')); % adults
    Ad_Frontal_Angry   = find(ismember(epoch_eventtype,'S 12'));
    Ad_Frontal_Happy   = find(ismember(epoch_eventtype,'S 13'));
    Ba_Frontal_Neutral = find(ismember(epoch_eventtype,'S 14')); % babies
    Ba_Frontal_Angry   = find(ismember(epoch_eventtype,'S 15'));
    Ba_Frontal_Happy   = find(ismember(epoch_eventtype,'S 16'));
    
    % START: averted left, all emotions
    Ad_L_Neutral  = find(ismember(epoch_eventtype,'S 21')); % adults
    Ad_L_Angry    = find(ismember(epoch_eventtype,'S 22'));
    Ad_L_Happy    = find(ismember(epoch_eventtype,'S 23'));
    Ba_L_Neutral  = find(ismember(epoch_eventtype,'S 24')); % babies
    Ba_L_Angry    = find(ismember(epoch_eventtype,'S 25'));
    Ba_L_Happy    = find(ismember(epoch_eventtype,'S 26'));
    
    % START: averted right, all emotions
    Ad_R_Neutral  = find(ismember(epoch_eventtype,'S 31')); % adults
    Ad_R_Angry    = find(ismember(epoch_eventtype,'S 32'));
    Ad_R_Happy    = find(ismember(epoch_eventtype,'S 33'));
    Ba_R_Neutral  = find(ismember(epoch_eventtype,'S 34')); % babies
    Ba_R_Angry    = find(ismember(epoch_eventtype,'S 35'));
    Ba_R_Happy    = find(ismember(epoch_eventtype,'S 36'));
    
    % CHANGE: Averted (left or right) to frontal, all emotions
    Ad_C_A_F_Neutral  = find(ismember(epoch_eventtype,'S111'));
    Ad_C_A_F_Angry    = find(ismember(epoch_eventtype,'S112'));
    Ad_C_A_F_Happy    = find(ismember(epoch_eventtype,'S113'));
    Ba_C_A_F_Neutral  = find(ismember(epoch_eventtype,'S114'));
    Ba_C_A_F_Angry    = find(ismember(epoch_eventtype,'S115'));
    Ba_C_A_F_Happy    = find(ismember(epoch_eventtype,'S116'));
    
    % CHANGE: Frontal to averted left, all emotions
    Ad_C_F_A_L_Neutral  = find(ismember(epoch_eventtype,'S121'));
    Ad_C_F_A_L_Angry    = find(ismember(epoch_eventtype,'S122'));
    Ad_C_F_A_L_Happy    = find(ismember(epoch_eventtype,'S123'));
    Ba_C_F_A_L_Neutral  = find(ismember(epoch_eventtype,'S124'));
    Ba_C_F_A_L_Angry    = find(ismember(epoch_eventtype,'S125'));
    Ba_C_F_A_L_Happy    = find(ismember(epoch_eventtype,'S126'));
       
    % CHANGE: Frontal to averted right, all emotions
    Ad_C_F_A_R_Neutral  = find(ismember(epoch_eventtype,'S131'));
    Ad_C_F_A_R_Angry    = find(ismember(epoch_eventtype,'S132'));
    Ad_C_F_A_R_Happy    = find(ismember(epoch_eventtype,'S133'));
    Ba_C_F_A_R_Neutral  = find(ismember(epoch_eventtype,'S134'));
    Ba_C_F_A_R_Angry    = find(ismember(epoch_eventtype,'S135'));
    Ba_C_F_A_R_Happy    = find(ismember(epoch_eventtype,'S136'));
    
    % Non-change: direct->direct
    Ad_NC_F_Neutral  = find(ismember(epoch_eventtype,'S211'));
    Ad_NC_F_Angry    = find(ismember(epoch_eventtype,'S212'));
    Ad_NC_F_Happy    = find(ismember(epoch_eventtype,'S213'));
    Ba_NC_F_Neutral  = find(ismember(epoch_eventtype,'S214'));
    Ba_NC_F_Angry    = find(ismember(epoch_eventtype,'S215'));
    Ba_NC_F_Happy    = find(ismember(epoch_eventtype,'S216'));   
    
    % Non-change: left->left
    Ad_NC_L_Neutral  = find(ismember(epoch_eventtype,'S221'));
    Ad_NC_L_Angry    = find(ismember(epoch_eventtype,'S222'));
    Ad_NC_L_Happy    = find(ismember(epoch_eventtype,'S223'));
    Ba_NC_L_Neutral  = find(ismember(epoch_eventtype,'S224'));
    Ba_NC_L_Angry    = find(ismember(epoch_eventtype,'S225'));
    Ba_NC_L_Happy    = find(ismember(epoch_eventtype,'S226'));   
    
    % Non-change: right->right
    Ad_NC_R_Neutral  = find(ismember(epoch_eventtype,'S231'));
    Ad_NC_R_Angry    = find(ismember(epoch_eventtype,'S232'));
    Ad_NC_R_Happy    = find(ismember(epoch_eventtype,'S233'));
    Ba_NC_R_Neutral  = find(ismember(epoch_eventtype,'S234'));
    Ba_NC_R_Angry    = find(ismember(epoch_eventtype,'S235'));
    Ba_NC_R_Happy    = find(ismember(epoch_eventtype,'S236'));      
    
    
    %% average and store subject-ERPs in 3rd dimension of new matrix (EDITED)
    % old code: erp_Frontal_Neutral(:,:,s) = mean(EEG.data(:,:,[EEG.event(Frontal_Neutral).epoch]),3);
    % Now, "Frontal_Neutral" (for example) already contains the indices of the respective epochs.
    
    % 1st Pic
    erp_Ad_Frontal_Neutral(:,:,s) = mean(EEG.data(:,:,Ad_Frontal_Neutral),3);
    erp_Ad_Frontal_Angry(:,:,s)   = mean(EEG.data(:,:,Ad_Frontal_Angry),3);
    erp_Ad_Frontal_Happy(:,:,s)   = mean(EEG.data(:,:,Ad_Frontal_Happy),3);
    erp_Ba_Frontal_Neutral(:,:,s) = mean(EEG.data(:,:,Ba_Frontal_Neutral),3);
    erp_Ba_Frontal_Angry(:,:,s)   = mean(EEG.data(:,:,Ba_Frontal_Angry),3);
    erp_Ba_Frontal_Happy(:,:,s)   = mean(EEG.data(:,:,Ba_Frontal_Happy),3);    
    
    erp_Ad_L_Neutral(:,:,s) = mean(EEG.data(:,:,Ad_L_Neutral),3);
    erp_Ad_L_Angry(:,:,s)   = mean(EEG.data(:,:,Ad_L_Angry),3);
    erp_Ad_L_Happy(:,:,s)   = mean(EEG.data(:,:,Ad_L_Happy),3);
    erp_Ba_L_Neutral(:,:,s) = mean(EEG.data(:,:,Ba_L_Neutral),3);
    erp_Ba_L_Angry(:,:,s)   = mean(EEG.data(:,:,Ba_L_Angry),3);
    erp_Ba_L_Happy(:,:,s)   = mean(EEG.data(:,:,Ba_L_Happy),3);
    
    erp_Ad_R_Neutral(:,:,s) = mean(EEG.data(:,:,Ad_R_Neutral),3);
    erp_Ad_R_Angry(:,:,s)   = mean(EEG.data(:,:,Ad_R_Angry),3);
    erp_Ad_R_Happy(:,:,s)   = mean(EEG.data(:,:,Ad_R_Happy),3);
    erp_Ba_R_Neutral(:,:,s) = mean(EEG.data(:,:,Ba_R_Neutral),3);
    erp_Ba_R_Angry(:,:,s)   = mean(EEG.data(:,:,Ba_R_Angry),3);
    erp_Ba_R_Happy(:,:,s)   = mean(EEG.data(:,:,Ba_R_Happy),3);    
    
    % 2nd Pic
    erp_Ad_C_A_F_Neutral(:,:,s) = mean(EEG.data(:,:,Ad_C_A_F_Neutral),3);
    erp_Ad_C_A_F_Angry(:,:,s)   = mean(EEG.data(:,:,Ad_C_A_F_Angry),3);
    erp_Ad_C_A_F_Happy(:,:,s)   = mean(EEG.data(:,:,Ad_C_A_F_Happy),3);
    erp_Ba_C_A_F_Neutral(:,:,s) = mean(EEG.data(:,:,Ba_C_A_F_Neutral),3);
    erp_Ba_C_A_F_Angry(:,:,s)   = mean(EEG.data(:,:,Ba_C_A_F_Angry),3);
    erp_Ba_C_A_F_Happy(:,:,s)   = mean(EEG.data(:,:,Ba_C_A_F_Happy),3);    

    erp_Ad_C_F_A_L_Neutral(:,:,s) = mean(EEG.data(:,:,Ad_C_F_A_L_Neutral),3);
    erp_Ad_C_F_A_L_Angry(:,:,s)   = mean(EEG.data(:,:,Ad_C_F_A_L_Angry),3);
    erp_Ad_C_F_A_L_Happy(:,:,s)   = mean(EEG.data(:,:,Ad_C_F_A_L_Happy),3);
    erp_Ba_C_F_A_L_Neutral(:,:,s) = mean(EEG.data(:,:,Ba_C_F_A_L_Neutral),3);
    erp_Ba_C_F_A_L_Angry(:,:,s)   = mean(EEG.data(:,:,Ba_C_F_A_L_Angry),3);
    erp_Ba_C_F_A_L_Happy(:,:,s)   = mean(EEG.data(:,:,Ba_C_F_A_L_Happy),3);    

    erp_Ad_C_F_A_R_Neutral(:,:,s) = mean(EEG.data(:,:,Ad_C_F_A_R_Neutral),3);
    erp_Ad_C_F_A_R_Angry(:,:,s)   = mean(EEG.data(:,:,Ad_C_F_A_R_Angry),3);
    erp_Ad_C_F_A_R_Happy(:,:,s)   = mean(EEG.data(:,:,Ad_C_F_A_R_Happy),3);
    erp_Ba_C_F_A_R_Neutral(:,:,s) = mean(EEG.data(:,:,Ba_C_F_A_R_Neutral),3);
    erp_Ba_C_F_A_R_Angry(:,:,s)   = mean(EEG.data(:,:,Ba_C_F_A_R_Angry),3);
    erp_Ba_C_F_A_R_Happy(:,:,s)   = mean(EEG.data(:,:,Ba_C_F_A_R_Happy),3);  
    
    % Non-change
    erp_Ad_NC_F_Neutral(:,:,s) = mean(EEG.data(:,:,Ad_NC_F_Neutral),3);
    erp_Ad_NC_F_Angry(:,:,s)   = mean(EEG.data(:,:,Ad_NC_F_Angry),3);
    erp_Ad_NC_F_Happy(:,:,s)   = mean(EEG.data(:,:,Ad_NC_F_Happy),3);
    erp_Ba_NC_F_Neutral(:,:,s) = mean(EEG.data(:,:,Ba_NC_F_Neutral),3);
    erp_Ba_NC_F_Angry(:,:,s)   = mean(EEG.data(:,:,Ba_NC_F_Angry),3);
    erp_Ba_NC_F_Happy(:,:,s)   = mean(EEG.data(:,:,Ba_NC_F_Happy),3);    
    
    erp_Ad_NC_L_Neutral(:,:,s) = mean(EEG.data(:,:,Ad_NC_L_Neutral),3);
    erp_Ad_NC_L_Angry(:,:,s)   = mean(EEG.data(:,:,Ad_NC_L_Angry),3);
    erp_Ad_NC_L_Happy(:,:,s)   = mean(EEG.data(:,:,Ad_NC_L_Happy),3);
    erp_Ba_NC_L_Neutral(:,:,s) = mean(EEG.data(:,:,Ba_NC_L_Neutral),3);
    erp_Ba_NC_L_Angry(:,:,s)   = mean(EEG.data(:,:,Ba_NC_L_Angry),3);
    erp_Ba_NC_L_Happy(:,:,s)   = mean(EEG.data(:,:,Ba_NC_L_Happy),3); 
    
    erp_Ad_NC_R_Neutral(:,:,s) = mean(EEG.data(:,:,Ad_NC_R_Neutral),3);
    erp_Ad_NC_R_Angry(:,:,s)   = mean(EEG.data(:,:,Ad_NC_R_Angry),3);
    erp_Ad_NC_R_Happy(:,:,s)   = mean(EEG.data(:,:,Ad_NC_R_Happy),3);
    erp_Ba_NC_R_Neutral(:,:,s) = mean(EEG.data(:,:,Ba_NC_R_Neutral),3);
    erp_Ba_NC_R_Angry(:,:,s)   = mean(EEG.data(:,:,Ba_NC_R_Angry),3);
    erp_Ba_NC_R_Happy(:,:,s)   = mean(EEG.data(:,:,Ba_NC_R_Happy),3); 
    
    %% display current status
    disp(['*** Done with ' num2str(s) ' out of ' num2str(length(subjects)) ' subjects in total. Wait a moment, I am not fully done yet :) ***'])
end


%% ************************** [For CHANGE Analysis]%%  ***********************************

% average direct->averted left and direct->averted right
erp_Ad_C_F_A_Neutral = (erp_Ad_C_F_A_L_Neutral + erp_Ad_C_F_A_R_Neutral)/2;
erp_Ad_C_F_A_Angry   = (erp_Ad_C_F_A_L_Angry + erp_Ad_C_F_A_R_Angry)/2;
erp_Ad_C_F_A_Happy   = (erp_Ad_C_F_A_L_Happy + erp_Ad_C_F_A_R_Happy)/2;

erp_Ba_C_F_A_Neutral = (erp_Ba_C_F_A_L_Neutral + erp_Ba_C_F_A_R_Neutral)/2;
erp_Ba_C_F_A_Angry   = (erp_Ba_C_F_A_L_Angry + erp_Ba_C_F_A_R_Angry)/2;
erp_Ba_C_F_A_Happy   = (erp_Ba_C_F_A_L_Happy + erp_Ba_C_F_A_R_Happy)/2;

%% average over adults and babies
erp_C_F_A_Neutral = (erp_Ad_C_F_A_Neutral + erp_Ba_C_F_A_Neutral)/2;
erp_C_F_A_Angry   = (erp_Ad_C_F_A_Angry + erp_Ba_C_F_A_Angry)/2;
erp_C_F_A_Happy   = (erp_Ad_C_F_A_Happy + erp_Ba_C_F_A_Happy)/2;

erp_C_A_F_Neutral = (erp_Ad_C_A_F_Neutral + erp_Ba_C_A_F_Neutral)/2;
erp_C_A_F_Angry   = (erp_Ad_C_A_F_Angry + erp_Ba_C_A_F_Angry)/2;
erp_C_A_F_Happy   = (erp_Ad_C_A_F_Happy + erp_Ba_C_A_F_Happy)/2;

%% Mothers / Non-mothers
% mothers
erp_Mo_C_F_A_Neutral    = erp_C_F_A_Neutral(:,:,1:length(mothers) );
erp_Mo_C_F_A_Angry      = erp_C_F_A_Angry(:,:,1:length(mothers) );
erp_Mo_C_F_A_Happy      = erp_C_F_A_Happy(:,:,1:length(mothers) );

erp_Mo_C_A_F_Neutral    = erp_C_A_F_Neutral(:,:,1:length(mothers) );
erp_Mo_C_A_F_Angry      = erp_C_A_F_Angry(:,:,1:length(mothers) );
erp_Mo_C_A_F_Happy      = erp_C_A_F_Happy(:,:,1:length(mothers) );

% non-mothers
erp_NM_C_F_A_Neutral    = erp_C_F_A_Neutral(:,:,(length(mothers)+1) : (length(mothers)+length(non_mothers)) );
erp_NM_C_F_A_Angry      = erp_C_F_A_Angry(:,:,(length(mothers)+1) : (length(mothers)+length(non_mothers)) );
erp_NM_C_F_A_Happy      = erp_C_F_A_Happy(:,:,(length(mothers)+1) : (length(mothers)+length(non_mothers)) );

erp_NM_C_A_F_Neutral    = erp_C_A_F_Neutral(:,:,(length(mothers)+1) : (length(mothers)+length(non_mothers)) );
erp_NM_C_A_F_Angry      = erp_C_A_F_Angry(:,:,(length(mothers)+1) : (length(mothers)+length(non_mothers)) );
erp_NM_C_A_F_Happy      = erp_C_A_F_Happy(:,:,(length(mothers)+1) : (length(mothers)+length(non_mothers)) );

%% Average over emotions
erp_Ad_C_F_A = (erp_Ad_C_F_A_Neutral + erp_Ad_C_F_A_Angry + erp_Ad_C_F_A_Happy)/3;
erp_Ad_C_A_F = (erp_Ad_C_A_F_Neutral + erp_Ad_C_A_F_Angry + erp_Ad_C_A_F_Happy)/3;

erp_Ba_C_F_A = (erp_Ba_C_F_A_Neutral + erp_Ba_C_F_A_Angry + erp_Ba_C_F_A_Happy)/3;
erp_Ba_C_A_F = (erp_Ba_C_A_F_Neutral + erp_Ba_C_A_F_Angry + erp_Ba_C_A_F_Happy)/3;


erp_Mo_C_F_A = (erp_Mo_C_F_A_Neutral + erp_Mo_C_F_A_Angry + erp_Mo_C_F_A_Happy)/3;
erp_Mo_C_A_F = (erp_Mo_C_A_F_Neutral + erp_Mo_C_A_F_Angry + erp_Mo_C_A_F_Happy)/3;

erp_NM_C_F_A = (erp_NM_C_F_A_Neutral + erp_NM_C_F_A_Angry + erp_NM_C_F_A_Happy)/3;
erp_NM_C_A_F = (erp_NM_C_A_F_Neutral + erp_NM_C_A_F_Angry + erp_NM_C_A_F_Happy)/3;


erp_C_A_F_Angry_EPN   = mean(erp_C_A_F_Angry([26 30 32 35 33 34 36 38 37 39],:,:), 1);
erp_C_A_F_Happy_EPN   = mean(erp_C_A_F_Happy([26 30 32 35 33 34 36 38 37 39],:,:), 1);
erp_C_A_F_Neutral_EPN = mean(erp_C_A_F_Neutral([26 30 32 35 33 34 36 38 37 39],:,:), 1);

erp_C_F_A_Angry_EPN   = mean(erp_C_F_A_Angry([26 30 32 35 33 34 36 38 37 39],:,:), 1);
erp_C_F_A_Happy_EPN   = mean(erp_C_F_A_Happy([26 30 32 35 33 34 36 38 37 39],:,:), 1);
erp_C_F_A_Neutral_EPN = mean(erp_C_F_A_Neutral([26 30 32 35 33 34 36 38 37 39],:,:), 1);

%% Mothers vs non-mothers
% baby pictures
erp_Mo_Ba_C_F_A = erp_Ba_C_F_A(:,:,1:length(mothers));
erp_Mo_Ba_C_A_F = erp_Ba_C_A_F(:,:,1:length(mothers));

erp_NM_Ba_C_F_A = erp_Ba_C_F_A(:,:, (length(mothers)+1) : length(subjects) );
erp_NM_Ba_C_A_F = erp_Ba_C_A_F(:,:, (length(mothers)+1) : length(subjects) );

% adult pictures
erp_Mo_Ad_C_F_A = erp_Ad_C_F_A(:,:,1:length(mothers));
erp_Mo_Ad_C_A_F = erp_Ad_C_A_F(:,:,1:length(mothers));

erp_NM_Ad_C_F_A = erp_Ad_C_F_A(:,:, (length(mothers)+1) : length(subjects) );
erp_NM_Ad_C_A_F = erp_Ad_C_A_F(:,:, (length(mothers)+1) : length(subjects) );

%% overall averages but keep gaze direction
% average over emotions
erp_Ad_C_F_A_L = (erp_Ad_C_F_A_L_Angry + erp_Ad_C_F_A_L_Happy + erp_Ad_C_F_A_L_Neutral)/3;
erp_Ad_C_F_A_R = (erp_Ad_C_F_A_R_Angry + erp_Ad_C_F_A_R_Happy + erp_Ad_C_F_A_R_Neutral)/3;
erp_Ba_C_F_A_L = (erp_Ba_C_F_A_L_Angry + erp_Ba_C_F_A_L_Happy + erp_Ba_C_F_A_L_Neutral)/3;
erp_Ba_C_F_A_R = (erp_Ba_C_F_A_R_Angry + erp_Ba_C_F_A_R_Happy + erp_Ba_C_F_A_R_Neutral)/3;

% average over babies and adult pictures
erp_C_F_A_L = (erp_Ad_C_F_A_L + erp_Ba_C_F_A_L)/2;
erp_C_F_A_R = (erp_Ad_C_F_A_R + erp_Ba_C_F_A_R)/2;

% separate mothers and non-mothers
erp_Mo_Ad_C_F_A_L = erp_Ad_C_F_A_L(:,:,1:length(mothers));
erp_NM_Ad_C_F_A_L = erp_Ad_C_F_A_L(:,:, (length(mothers)+1) : length(subjects) );
erp_Mo_Ad_C_F_A_R = erp_Ad_C_F_A_R(:,:,1:length(mothers));
erp_NM_Ad_C_F_A_R = erp_Ad_C_F_A_R(:,:, (length(mothers)+1) : length(subjects) );

erp_Mo_Ba_C_F_A_L = erp_Ba_C_F_A_L(:,:,1:length(mothers));
erp_NM_Ba_C_F_A_L = erp_Ba_C_F_A_L(:,:, (length(mothers)+1) : length(subjects) );
erp_Mo_Ba_C_F_A_R = erp_Ba_C_F_A_R(:,:,1:length(mothers));
erp_NM_Ba_C_F_A_R = erp_Ba_C_F_A_R(:,:, (length(mothers)+1) : length(subjects) );


%% ************************** [For START Analysis]%%  ***********************************
%% average over averted left and averted right
erp_Ad_Averted_Neutral = (erp_Ad_L_Neutral + erp_Ad_R_Neutral)/2;
erp_Ad_Averted_Angry   = (erp_Ad_L_Angry   + erp_Ad_R_Angry)/2;
erp_Ad_Averted_Happy   = (erp_Ad_L_Happy   + erp_Ad_R_Happy)/2;

erp_Ba_Averted_Neutral = (erp_Ba_L_Neutral + erp_Ba_R_Neutral)/2;
erp_Ba_Averted_Angry   = (erp_Ba_L_Angry   + erp_Ba_R_Angry)/2;
erp_Ba_Averted_Happy   = (erp_Ba_L_Happy   + erp_Ba_R_Happy)/2;

%% average over babies and adult pictures
erp_Frontal_Neutral = (erp_Ad_Frontal_Neutral + erp_Ba_Frontal_Neutral)/2;
erp_Frontal_Angry   = (erp_Ad_Frontal_Angry   + erp_Ba_Frontal_Angry)/2;
erp_Frontal_Happy   = (erp_Ad_Frontal_Happy   + erp_Ba_Frontal_Happy)/2;

erp_Averted_Neutral = (erp_Ad_Averted_Neutral + erp_Ba_Averted_Neutral)/2;
erp_Averted_Angry   = (erp_Ad_Averted_Angry   + erp_Ba_Averted_Angry)/2;
erp_Averted_Happy   = (erp_Ad_Averted_Happy   + erp_Ba_Averted_Happy)/2;

%% Mothers / Non-mothers
% mothers
erp_Mo_Frontal_Neutral    = erp_Frontal_Neutral(:,:,1:length(mothers) );
erp_Mo_Frontal_Angry      = erp_Frontal_Angry(:,:,1:length(mothers) );
erp_Mo_Frontal_Happy      = erp_Frontal_Happy(:,:,1:length(mothers) );

erp_Mo_Averted_Neutral    = erp_Averted_Neutral(:,:,1:length(mothers) );
erp_Mo_Averted_Angry      = erp_Averted_Angry(:,:,1:length(mothers) );
erp_Mo_Averted_Happy      = erp_Averted_Happy(:,:,1:length(mothers) );

% non-mothers
erp_NM_Frontal_Neutral    = erp_Frontal_Neutral(:,:,(length(mothers)+1) : (length(mothers)+length(non_mothers)) );
erp_NM_Frontal_Angry      = erp_Frontal_Angry(:,:,(length(mothers)+1) : (length(mothers)+length(non_mothers)) );
erp_NM_Frontal_Happy      = erp_Frontal_Happy(:,:,(length(mothers)+1) : (length(mothers)+length(non_mothers)) );

erp_NM_Averted_Neutral    = erp_Averted_Neutral(:,:,(length(mothers)+1) : (length(mothers)+length(non_mothers)) );
erp_NM_Averted_Angry      = erp_Averted_Angry(:,:,(length(mothers)+1) : (length(mothers)+length(non_mothers)) );
erp_NM_Averted_Happy      = erp_Averted_Happy(:,:,(length(mothers)+1) : (length(mothers)+length(non_mothers)) );

%% Average over emotions
erp_Ad_Frontal = (erp_Ad_Frontal_Neutral + erp_Ad_Frontal_Angry + erp_Ad_Frontal_Happy)/3;
erp_Ad_Averted = (erp_Ad_Averted_Neutral + erp_Ad_Averted_Angry + erp_Ad_Averted_Happy)/3;

erp_Ba_Frontal = (erp_Ba_Frontal_Neutral + erp_Ba_Frontal_Angry + erp_Ba_Frontal_Happy)/3;
erp_Ba_Averted = (erp_Ba_Averted_Neutral + erp_Ba_Averted_Angry + erp_Ba_Averted_Happy)/3;


erp_Mo_Frontal = (erp_Mo_Frontal_Neutral + erp_Mo_Frontal_Angry + erp_Mo_Frontal_Happy)/3;
erp_Mo_Averted = (erp_Mo_Averted_Neutral + erp_Mo_Averted_Angry + erp_Mo_Averted_Happy)/3;

erp_NM_Frontal = (erp_NM_Frontal_Neutral + erp_NM_Frontal_Angry + erp_NM_Frontal_Happy)/3;
erp_NM_Averted = (erp_NM_Averted_Neutral + erp_NM_Averted_Angry + erp_NM_Averted_Happy)/3;


erp_Frontal_Angry_EPN   = mean(erp_Frontal_Angry([26 30 32 35 33 34 36 38 37 39],:,:), 1);
erp_Frontal_Happy_EPN   = mean(erp_Frontal_Happy([26 30 32 35 33 34 36 38 37 39],:,:), 1);
erp_Frontal_Neutral_EPN = mean(erp_Frontal_Neutral([26 30 32 35 33 34 36 38 37 39],:,:), 1);

erp_Averted_Angry_EPN   = mean(erp_Averted_Angry([26 30 32 35 33 34 36 38 37 39],:,:), 1);
erp_Averted_Happy_EPN   = mean(erp_Averted_Happy([26 30 32 35 33 34 36 38 37 39],:,:), 1);
erp_Averted_Neutral_EPN = mean(erp_Averted_Neutral([26 30 32 35 33 34 36 38 37 39],:,:), 1);

%% Mothers vs non-mothers
% baby pictures
erp_Mo_Ba_Frontal = erp_Ba_Frontal(:,:,1:length(mothers));
erp_Mo_Ba_Averted = erp_Ba_Averted(:,:,1:length(mothers));

erp_NM_Ba_Frontal = erp_Ba_Frontal(:,:, (length(mothers)+1) : length(subjects) );
erp_NM_Ba_Averted = erp_Ba_Averted(:,:, (length(mothers)+1) : length(subjects) );

% adult pictures
erp_Mo_Ad_Frontal = erp_Ad_Frontal(:,:,1:length(mothers));
erp_Mo_Ad_Averted = erp_Ad_Averted(:,:,1:length(mothers));

erp_NM_Ad_Frontal = erp_Ad_Frontal(:,:, (length(mothers)+1) : length(subjects) );
erp_NM_Ad_Averted = erp_Ad_Averted(:,:, (length(mothers)+1) : length(subjects) );

%% overall averages but keep gaze direction
% average over emotions
erp_Ad_Averted_L = (erp_Ad_L_Angry + erp_Ad_L_Happy + erp_Ad_L_Neutral)/3;
erp_Ad_Averted_R = (erp_Ad_R_Angry + erp_Ad_R_Happy + erp_Ad_R_Neutral)/3;
erp_Ba_Averted_L = (erp_Ba_L_Angry + erp_Ba_L_Happy + erp_Ba_L_Neutral)/3;
erp_Ba_Averted_R = (erp_Ba_R_Angry + erp_Ba_R_Happy + erp_Ba_R_Neutral)/3;

% average over babies and adult pictures
erp_Averted_L = (erp_Ad_Averted_L + erp_Ba_Averted_L)/2;
erp_Averted_R = (erp_Ad_Averted_R + erp_Ba_Averted_R)/2;

% separate mothers and non-mothers
erp_Mo_Ad_Averted_L = erp_Ad_Averted_L(:,:,1:length(mothers));
erp_NM_Ad_Averted_L = erp_Ad_Averted_L(:,:, (length(mothers)+1) : length(subjects) );
erp_Mo_Ad_Averted_R = erp_Ad_Averted_R(:,:,1:length(mothers));
erp_NM_Ad_Averted_R = erp_Ad_Averted_R(:,:, (length(mothers)+1) : length(subjects) );

erp_Mo_Ba_Averted_L = erp_Ba_Averted_L(:,:,1:length(mothers));
erp_NM_Ba_Averted_L = erp_Ba_Averted_L(:,:, (length(mothers)+1) : length(subjects) );
erp_Mo_Ba_Averted_R = erp_Ba_Averted_R(:,:,1:length(mothers));
erp_NM_Ba_Averted_R = erp_Ba_Averted_R(:,:, (length(mothers)+1) : length(subjects) );

%% save Data for future analysis
save([savefolder 'Pa_eyegaze_2019.mat']) %filtered on 0.03-30 Hz
disp('*** Done :) ***')

%% %% %% code to check for Nans in all subjects (by olaf):%% %% %%
% for s = 1:114
%     disp(s)
%     result(s) = sum(sum(isnan(erp_Ba_Frontal_Neutral(:,:,s))))
% end
% figure; plot(result,'bo-')
% xlabel('Subject ID')

% ************************subject 67 contains Nans**********************
 
% erp_Frontal_Neutral = (erp_Ad_Frontal_Neutral(:,:,[1:66 68:114]) + erp_Ba_Frontal_Neutral(:,:,[1:66 68:114]))./2;
