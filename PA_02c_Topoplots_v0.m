%% Difference maps and Topoplots
% Parenthood Study
% Shadi 01.02.2020

% This script is about creating difference maps and displaying topoplots
% save plots manually in the end

clear
clc

eeglab

load 'Pa_eyegaze_2019.mat';

%% %% %% code to check for Nans in all subject:%% %% %%
 %for s = 1:114
   %disp(s)
    %result(s) = sum(sum(isnan(erp_Frontal_Happy(:,:,s))))
 %end
 %figure; plot(result,'bo-')
 %xlabel('Subject ID')

% ************************i.e. subject 67 contains Nans**********************
 
%erp_Frontal_Neutral = (erp_Ad_Frontal_Neutral(:,:,[1:3 5:6]) + erp_Ba_Frontal_Neutral(:,:,[1:3 5:6]))./2;

%% Creating Difference-waves

% Averted-Frontal, all emotions START
diff_1   = erp_Averted_Neutral - erp_Frontal_Neutral ; % Averted_Frontal_Neutral
diff_2   = erp_Averted_Angry   - erp_Frontal_Angry ; % Averted_Frontal_Angry
diff_3   = erp_Averted_Happy   - erp_Frontal_Happy; % Averted_Frontal_Happy
diff_123 = ((diff_1+diff_2+diff_3)./3);
diff_123 = mean(diff_123(:,:,:),3); % Subject mean Averted MINUS Frontal

% Angry-Neutral, frontal and averted START
diff_4  = erp_Frontal_Angry - erp_Frontal_Neutral; % Angry_Neutral_Frontal
diff_5  = erp_Averted_Angry - erp_Averted_Neutral; % Angry_Neutral_Averted
diff_45 = ((diff_4+diff_5)./2);
diff_45 = mean(diff_45(:,:,:),3); % Subject mean & Angry MINUS Neutral

% Happy-Neutral, frontal and averted START
diff_6  = erp_Frontal_Happy - erp_Frontal_Neutral; %Happy_Neutral_Frontal
diff_7  = erp_Averted_Happy - erp_Averted_Neutral; %Happy_Neutral_Averted
diff_67 = ((diff_6+diff_7)./2);
diff_67 = mean(diff_67(:,:,:),3); % Subject mean & Happy MINUS Neutral

% Frontal to Averted MINUS Averted to Frongtal, all emotions CHANGE
diff_8    = erp_C_F_A_Neutral - erp_C_A_F_Neutral; % CFA_CAF_Neutral
diff_9    = erp_C_F_A_Angry   - erp_C_A_F_Angry ; % CFA_CAF_Angry
diff_10   = erp_C_F_A_Happy   - erp_C_A_F_Happy ; % CFA_CAF_Happy
diff_8910 =((diff_8+diff_9+diff_10)./3);
diff_8910 = mean(diff_8910(:,:,:),3); % Subject mean & CFA MINUS CAF

% Angry-Neutral, frontal and averted CHANGE
diff_11   = erp_C_A_F_Angry - erp_C_A_F_Neutral; % CAF_Angry_Neutral
diff_12   = erp_C_F_A_Angry - erp_C_A_F_Neutral; % CFA_Angry_Neutral
diff_1112 = ((diff_11+diff_12)./2);
diff_1112 = mean(diff_1112(:,:,:),3); % Subject mean & Angry MINUS Neutral

% Happy-Neutral, frontal and averted CHANGE
diff_13   = erp_C_A_F_Happy - erp_C_A_F_Neutral; % CAF_Happy_Neutral
diff_14   = erp_C_F_A_Happy - erp_C_A_F_Neutral; % CFA_Happy_Neutral
diff_1314 = ((diff_13+diff_14)./2);
diff_1314 = mean(diff_1314(:,:,:),3); % Subject mean & Happy MINUS Neutral

save 'Pa_eyegaze_2019.mat' % to add difference data


%% Topography START - Emotions

for d= 1:6
    
    switch d
        case 1
            difference = diff_45; % Angry - Neutral START
        case 2
            difference = diff_67; % Happy - Neutral START
        case 3
            difference = diff_123; % Averted - Frontal START
        case 4
            difference = diff_1112; % Angry - Neutral CHANGE
        case 5
            difference = diff_1314; % Happy - Neutral CHANGE
        case 6
            difference = diff_8910; % Frontal to Averted - Averted to Frontal CHANGE
            
        otherwise
            disp('no way - this subject does not exist!') % J
            
    end
    
    
TOPOSMP_100_150 = find(EEG.times >= 100 & EEG.times < 150);
TOPOSMP_150_200 = find(EEG.times >= 150 & EEG.times < 200);
TOPOSMP_200_250 = find(EEG.times >= 200 & EEG.times < 250);
TOPOSMP_250_300 = find(EEG.times >= 250 & EEG.times < 300);
TOPOSMP_300_350 = find(EEG.times >= 300 & EEG.times < 350);
TOPOSMP_350_400 = find(EEG.times >= 350 & EEG.times < 400);

    %% plot difference-maps of components in one figure      

figure;
    %N170 (100-150)
    subplot (3,2,1)
    hold on; title('100-150ms');
    topoplot(mean(difference(:,TOPOSMP_100_150,:),2),EEG.chanlocs); % topography
    colorbar
    caxis([-1 1])
    
    %N170 (150-200)
    subplot (3,2,2)
    hold on; title('150-200ms');
    topoplot(mean(difference(:,TOPOSMP_150_200,:),2),EEG.chanlocs); % topography
    colorbar
    caxis([-1 1])
    
    % EPN (200-250ms)
    subplot (3,2,3)
    hold on; title('200-250ms');
    topoplot(mean(difference(:,TOPOSMP_200_250,:),2),EEG.chanlocs); % topography
    colorbar
    caxis([-1 1])
    
    % EPN (250-300ms)
    subplot (3,2,4)
    hold on; title('250-300ms');
    topoplot(mean(difference(:,TOPOSMP_250_300,:),2),EEG.chanlocs); % topography
    colorbar
    caxis([-1 1])
    
    % EPN (300-350ms)
    subplot (3,2,5)
    hold on; title('300-350ms');
    topoplot(mean(difference(:,TOPOSMP_300_350,:),2),EEG.chanlocs); % topography
    colorbar
    caxis([-1 1])
    
    % EPN (350-400ms)
    subplot (3,2,6)
    hold on; title('350-400ms');
    topoplot(mean(difference(:,TOPOSMP_350_400,:),2),EEG.chanlocs); % topography
    colorbar
    caxis([-1 1])
    
%     % LPC (400-500ms)
%     subplot (3,2,7)
%     hold on; title('400-500ms');
%     topoplot(mean(difference(:,300:350),2),EEG.chanlocs); % topography
%     colorbar
%     caxis([-1 1])
%     

    %% add annotations to figure
    switch d
        case 1
            annotation('textbox', [0 0.9 1 0.1],'String', 'START Angry vs. Neutral','EdgeColor', 'none', 'HorizontalAlignment', 'center')
        case 2
            annotation('textbox', [0 0.9 1 0.1],'String', 'START Happy vs. Neutral','EdgeColor', 'none', 'HorizontalAlignment', 'center')
            
        case 3
            annotation('textbox', [0 0.9 1 0.1],'String', 'START Averted vs. Frontal','EdgeColor', 'none', 'HorizontalAlignment', 'center')
        case 4
            annotation('textbox', [0 0.9 1 0.1],'String', 'CHANGE Angry vs. Neutral','EdgeColor', 'none', 'HorizontalAlignment', 'center')
        case 5
            annotation('textbox', [0 0.9 1 0.1],'String', 'CHANGE Happy vs. Neutral','EdgeColor', 'none', 'HorizontalAlignment', 'center')
        case 6
            annotation('textbox', [0 0.9 1 0.1],'String', 'CHANGE CFA vs. CAF','EdgeColor', 'none', 'HorizontalAlignment', 'center')
            
        otherwise
            disp('nixda - diesen Probanden gibts garnicht!') % J
            
    end
    
end





%     % N170
%     if d>3
%         subplot (3,2,1)
%         hold on; title('174ms'); % N170 peak CHANGE
%         %topoplot(difference(:,100+87),EEG.chanlocs); % topography
%         topoplot(difference(:,382),EEG.chanlocs); % topography
%         colorbar
%         caxis([-1 1])
%     else
%        subplot (3,2,1)
%         hold on; title('166ms'); % N170 peak START
%         topoplot(difference(:,382),EEG.chanlocs); % topography
%         colorbar
%         caxis([-1 1])
%     end


%% Back-up
case 1
    annotation('textbox', [0 0.9 1 0.1],'String', 'START Frontal vs. Averted Neutral','EdgeColor', 'none', 'HorizontalAlignment', 'center')
    case 2
        annotation('textbox', [0 0.9 1 0.1],'String', 'START Frontal vs. Averted Angry','EdgeColor', 'none', 'HorizontalAlignment', 'center')
        case 3
            annotation('textbox', [0 0.9 1 0.1],'String', 'START Frontal vs. Averted Happy','EdgeColor', 'none', 'HorizontalAlignment', 'center')
            case 4
                annotation('textbox', [0 0.9 1 0.1],'String', 'START Angry vs. Neutral Frontal','EdgeColor', 'none', 'HorizontalAlignment', 'center')
                case 5
                    annotation('textbox', [0 0.9 1 0.1],'String', 'START Angry vs. Neutral Averted','EdgeColor', 'none', 'HorizontalAlignment', 'center')
                    case 6
                        annotation('textbox', [0 0.9 1 0.1],'String', 'START Happy vs. Neutral Frontal','EdgeColor', 'none', 'HorizontalAlignment', 'center')
                        case 7
                            annotation('textbox', [0 0.9 1 0.1],'String', 'START Happy vs. Neutral Averted','EdgeColor', 'none', 'HorizontalAlignment', 'center')
                            case 8
                                annotation('textbox', [0 0.9 1 0.1],'String', 'CAF vs. CFA Neutral','EdgeColor', 'none', 'HorizontalAlignment', 'center')
                                case 9
                                    annotation('textbox', [0 0.9 1 0.1],'String', 'CAF vs. CFA Angry','EdgeColor', 'none', 'HorizontalAlignment', 'center')
                                    case 10
                                        annotation('textbox', [0 0.9 1 0.1],'String', 'CAF vs. CFA Happy','EdgeColor', 'none', 'HorizontalAlignment', 'center')
                                        case 11
                                            annotation('textbox', [0 0.9 1 0.1],'String', 'Angry vs Neutral CAF','EdgeColor', 'none', 'HorizontalAlignment', 'center')
                                            case 12
                                                annotation('textbox', [0 0.9 1 0.1],'String', 'Angry vs Neutral CFA','EdgeColor', 'none', 'HorizontalAlignment', 'center')
                                                case 13
                                                    annotation('textbox', [0 0.9 1 0.1],'String', 'Happy vs Neutral CAF','EdgeColor', 'none', 'HorizontalAlignment', 'center')
                                                    case 14
                                                        annotation('textbox', [0 0.9 1 0.1],'String', 'Happy vs Neutral CFA','EdgeColor', 'none', 'HorizontalAlignment', 'center')
                                                        otherwise
                                                            disp('nixda - diesen Probanden gibts garnicht!') % J
