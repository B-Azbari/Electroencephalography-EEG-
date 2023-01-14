p%% ANOVA preparation N170 START
% Shadi 01.06.2020

% This script is about preparing the eeg-data for further statistical
% analysis in R. Here a .txt with all relevant amplitudes will be created

% Peak detection is done within subjects separated for all conditions for
% PO8 electrode

clear
clc

%% eeglab and data
run('O:/Parenting Study/Parenting EEG/Parenthood_EyeContact/Analysis/eeglab_correct/eeglab14_1_1b/eeglab.m');

savepath = 'O:/Parenting Study/Parenting EEG/Parenthood_EyeContact/Analysis/statistics/'; % output is saved here

%save_suffix = 'N170_PO8_Region';
%save_suffix = 'N170_PO8_Hemisphere';
save_suffix = 'N170_PO8_Peak';

filepath = 'O:/Parenting Study/Parenting EEG/Parenthood_EyeContact/Analysis/preprocessed_data/ERPs (.mat files)/';
load([filepath 'Pa_eyegaze_2019.mat']) % contains preprocessed and epoched data; containing labeled epochs of different conditions

%% context variables (epoch length, factors etc)

mothers = {'112002' '112004' '112006' '112008' '112010' '112012' '112013' '112017' '112024' '122005' '112026' '112030' '112031' '112027' '112032' '112038' '112033' '112052' '112039' '112046' '112053' '112048' '112058' '112056' '112128' '122018' '112045' '112069' '112047' '112075' '112083' '112066' '122014' '112078' '112071' '112073' '112086' '112085' '112134' '112135' '112130' '112133' '112098' '112101' '112105' '112114' '112122' '112126' '122022' '112087' '122013' '122024' '112096' '112097' '122030' '122029' '122023' '122037' '112110'};  %59
non_mothers = {'202001' '202003' '202005' '202007' '202008' '202012' '202013' '202015' '202025' '202029' '202030' '202031' '202033' '202034' '202037' '202041' '202048' '202052' '202055' '202062' '202054' '202092' '202072' '202079' '202091' '202106' '202095' '202104' '202101' '202107' '202110' '202103' '202116' '202115' '202118' '202119' '202120' '202121' '202123' '202124' '202126' '202127' '202129' '202131' '202135' '202137' '202138' '202139' '202144' '202076' '202140' '202133' '202035' '202036' '202143'};   %55

%mothers = {'112008'};
%non_mothers = {'202007'};

subjects = [mothers, non_mothers];
num_subjects = length(subjects);

pic_types = {'Ad' 'Ba'};
emotions = {'Angry' 'Happy' 'Neutral'};
gaze_conditions = {'Frontal' 'Averted'};

electrodes = [33 34]; % PO7, PO8 = Peak
%electrodes = [30 34 31 35]; % P8, PO8, P10, PO10 = Region
%electrodes = [26 33 30 34]; % P7, PO7, P8, PO8 = hemisphere

peak_electr = 34; % electrode at which peak is detected

srate = 1000;

epoch_length_ms = [-200 1000];%in ms
epoch_length_pt = epoch_length_ms*srate/1000 ; %in ms

window_ms = [150 190];% time window peak detection N170 (in ms); !!!!!!!!!!!!!!!! EDIT ?
pt_win   = window_ms*srate/1000 - epoch_length_pt(1)+ 1; %(in pt)/if srt=1000

%% loop 
line = 1; %initialize line index for output
for s = 1:num_subjects
   
    if s <= length(mothers)
        subj_type{s} = 'mother';
    elseif s > length(mothers)
        subj_type{s} = 'non-mother';
    end
    
           for c = 1:length(pic_types)
                 pic_type = pic_types{c};
        
                for f = 1:length(emotions)
                   emotion = emotions{f};
             
                       for g = 1:length(gaze_conditions)
                          gaze = gaze_conditions{g};
                                     
                        % Detect peaks for single participants within all conditions
                        [peak_amp,  peak_lat]  = eval(['min(erp_' pic_type '_' gaze '_' emotion '(peak_electr, pt_win(1):pt_win(2), s))']);
                
                        % adapt latencies to whole epoch length
                         peak_lat = peak_lat + pt_win(1) - 1;   
                         
                          for h = 1:length(electrodes) % peak amplitudes and latencies for specified electrodes
                          electr = electrodes(h);
                          %peak_electr = electrodes(h);
                        
                               % Factors for output
                               Output_col_1{line} = subjects{s}; % subject number
                               Output_col_2{line} = subj_type{s};
                               Output_col_3{line} = pic_type;
                               Output_col_4{line} = emotion;
                               Output_col_5{line} = gaze;
                               Output_col_6{line} = EEG.chanlocs(electr).labels; % electrode name
                               
                                % Peak amplitude
                        
                         AMP{line} = eval(['erp_' pic_type '_' gaze '_' emotion '(' num2str(electr) ', peak_lat, ' num2str(s) ')']);
                        
                        % Latency
%                        lat_pt_tmp = eval(['peak_lat_' condition '(' num2str(s) ');']);

                         %LAT{line} = (peak_lat - 1)*2 + epoch_length_pt(1)*2; % convert pt to ms; subtract prestimulus interval (in ms)
                         %LAT{line} = (peak_lat*1000 + epoch_length_pt(1))*1000/srate; % convert pt to ms; subtract prestimulus interval (in ms)
                         
                         LAT{line} = (peak_lat + epoch_length_pt(1) - 1) * (1000/srate);
                        line = line + 1; % line in output
              
                   end
        
              end
    
         end
        
    end
    
end
%% Create output
% Peak amplitudes and latencies

fid=fopen([savepath 'AMP_Pa_START_' save_suffix '.txt'],'wt');
% headers
fprintf(fid,['subject\t'...
    'num\t'...
    'subj_type\t'...
    'pic_type\t'...
    'emotion\t'...
    'gaze\t'...
    'electrode\t'...
    'LAT\t'...        %LAT_PO8
    'AMP\n']);        %AMP_PO8
% data

for i = 1:length(AMP)
    fprintf(fid,[Output_col_1{i} '\t'...
        num2str(i) '\t'...
        Output_col_2{i} '\t'...
        Output_col_3{i} '\t'...
        Output_col_4{i} '\t'...
        Output_col_5{i} '\t'...
        Output_col_6{i} '\t'...
        num2str(LAT{i}) '\t'...
        num2str(AMP{i}) '\n']);
end

fclose(fid);

disp('*** Done :) ***');




