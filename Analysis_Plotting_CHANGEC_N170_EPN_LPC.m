%% PLOTs (Change / Second Picture)
% ICON
% Charlotte J. Lion
% 05.12.2016
% Edited by Shadi 24.10.2019

% This script can serve as a framework for designing some plots, especially for changing condition: 
% included in this script: grand-average ERP, EPN, LPC, various electrodes

% save plots manually after inspection

clear
clc

%% eeglab and data
addpath('O:/_Eye contact/eeglab13_6_5b')
eeglab
 %change folder to eeglab-Folder, if necessary: ('O:/_Eye contact/eeglab14_1_1b')

filepath = 'O:/Parenting Study/Parenting EEG/Parenthood_EyeContact/Analysis/preprocessed_data/ERPs (.mat files)/';
load([filepath 'pa_eyegaze_evaluated_VSep.mat'])  % contains preprocessed and epoched data; containing labeled epochs of different conditions

times = [-200:2:999];

%% What do you want to plot? (Never two electrodes on two sites!)
erp_C_A_F     = mean(erp_C_A_F_Neutral,3)+mean(erp_C_A_F_Angry,3)+mean(erp_C_A_F_Happy,3)/3;
erp_C_F_A     = mean(erp_C_F_A_Neutral,3)+mean(erp_C_A_F_Angry,3)+mean(erp_C_A_F_Happy,3)/3;
erp_C_A_F     = mean(erp_C_A_F_Neutral,3)+mean(erp_C_A_F_Angry,3)+mean(erp_C_A_F_Happy,3)/3;
erp_C_F_A     = mean(erp_C_F_A_Neutral,3)+mean(erp_C_A_F_Angry,3)+mean(erp_C_A_F_Happy,3)/3;

% plot
figure;
subplot(1,2,1), hold on; title('P9 & PO9 CHANGE - gaze'); %%% P9 and PO9

plot([0 0],[-20 10],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-15 10]);
ylabel('ERP [µV]');
box on

erp_C_A_F_PO9 = plot(EEG.times, erp_C_A_F(36,:), '--r','linewidth',2) % plot ERP for A to F
erp_C_A_F_P9  = plot(EEG.times, erp_C_A_F(46,:), 'r','linewidth',2) % plot ERP for A to F
erp_C_F_A_PO9 = plot(EEG.times, erp_C_F_A(36,:), '--b','linewidth',2) % plot ERP for F to A
erp_C_F_A_P9  = plot(EEG.times, erp_C_F_A(46,:), 'b','linewidth',2) % plot ERP for F to A
legend([erp_C_A_F_PO9 erp_C_A_F_P9 erp_C_F_A_PO9 erp_C_F_A_P9],{'C_A_F PO9','C_A_F P9','C_F_A PO9','C_F_A P9'},'box','off','location','southeast')

subplot(1,2,2), hold on; title('P10 & PO10 CHANGE - gaze'); %%% P10 & PO10

plot([0 0],[-20 10],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-15 10]);
ylabel('ERP [µV]');
box on

erp_C_A_F_PO10  = plot(EEG.times, erp_C_A_F(40,:), '--k','linewidth',2) % plot ERP for A to F
erp_C_A_F_P10   = plot(EEG.times, erp_C_A_F(47,:), 'k','linewidth',2) % plot ERP for A to F
erp_C_F_A_PO10  = plot(EEG.times, erp_C_F_A(40,:), '--m','linewidth',2) % plot ERP for F to A
erp_C_F_A_P10   = plot(EEG.times, erp_C_F_A(47,:), 'm','linewidth',2) % plot ERP for F to A
legend([erp_C_A_F_PO10 erp_C_A_F_P10 erp_C_F_A_PO10 erp_C_F_A_P10],{'C_A_F PO10','C_A_F P10','C_F_A PO10','C_F_A P10'},'box','off','location','southeast')

%% For EPN (Emotion x Gaze Interaction)
ROI           = [26 33 36 37 39 34 35 30 31]; % P7, PO7, O1, Oz, Iz, PO8, P8, P10, PO10
erp_C_A_F_Neutral_ROI = mean(mean(erp_C_A_F_Neutral(ROI,:,:),1),3); % adapt the next three lines
erp_C_F_A_Neutral_ROI = mean(mean(erp_C_F_A_Neutral(ROI,:,:),1),3);
erp_C_A_F_Angry_ROI   = mean(mean(erp_C_A_F_Angry(ROI,:,:),1),3);
erp_C_F_A_Angry_ROI   = mean(mean(erp_C_F_A_Angry(ROI,:,:),1),3);
erp_C_A_F_Happy_ROI   = mean(mean(erp_C_A_F_Happy(ROI,:,:),1),3);
erp_C_F_A_Happy_ROI   = mean(mean(erp_C_F_A_Happy(ROI,:,:),1),3);

%% By Tilman

figure;
title('PO10 Gaze x Emotion');
hold on;
xlim([-100 1000]);
ylim([-6 2]);
plot([0 0],[-6 2],'k'); % vertical line at 0 ms
plot([-100 1200],[0 0],'k'); % horizontal line at 0 ms
ylabel('ERP [µV]');
box on

p_C_A_F_Angry_PO10  = plot(EEG.times,mean(erp_C_A_F_Angry(40,:,:),3), 'r','linewidth',1.5);
p_C_A_F_Happy_PO10  = plot(EEG.times,mean(erp_C_A_F_Happy(40,:,:),3), 'g','linewidth',1.5);
p_C_A_F_Neutral_PO10= plot(EEG.times,mean(erp_C_A_F_Neutral(40,:,:),3), 'b','linewidth',1.5);

p_C_F_A_Angry_PO10  = plot(EEG.times,mean(erp_C_F_A_Angry(40,:,:),3), '--r','linewidth',1.5);
p_C_F_A_Happy_PO10  = plot(EEG.times,mean(erp_C_F_A_Happy(40,:,:),3), '--g','linewidth',1.5);
p_C_F_A_Neutral_PO10= plot(EEG.times,mean(erp_C_F_A_Neutral(40,:,:),3), '--b','linewidth',1.5);

legend([p_C_A_F_Angry_PO10 p_C_A_F_Happy_PO10 p_C_A_F_Neutral_PO10...
        p_C_F_A_Angry_PO10 p_C_F_A_Happy_PO10 p_C_F_A_Neutral_PO10],...
       {'Averted->Frontal Angry','Averted->Frontal Happy','Averted->Frontal Neutral',...
        'Frontal->Averted Angry','Frontal->Averted Happy','Frontal->Averted Neutral'},'box','off','location','southeast')
hold off;




%%
% plot
figure;

subplot(1,2,1)

erp_C_A_F_Neutral_ROI = plot(EEG.times, erp_C_A_F_Neutral_ROI, 'r','linewidth',2)
erp_C_A_F_Angry_ROI   = plot(EEG.times, erp_C_A_F_Angry_ROI, 'b','linewidth',2)
erp_C_A_F_Happy_ROI   = plot(EEG.times, erp_C_A_F_Happy_ROI, 'g','linewidth',2)
legend([erp_C_A_F_Neutral_ROI erp_C_A_F_Angry_ROI erp_C_A_F_Happy_ROI],{'C_A_F_Neutral','C_A_F_Angry','C_A_F_Happy'},'box','off','location','southeast')

subplot(1,2,2)

erp_C_F_A_Neutral = plot(EEG.times, erp_C_F_A_Neutral_ROI, '--r','linewidth',2)
erp_C_F_A_Angry   = plot(EEG.times, erp_C_F_A_Angry_ROI, '--b','linewidth',2)
erp_C_F_A_Happy   = plot(EEG.times, erp_C_F_A_Happy_ROI, '--g','linewidth',2)
legend([erp_C_F_A Neutral_ROI erp_C_F_A Angry_ROI erp_C_F_A Happy_ROI],{'C_F_A Neutral','C_F_A Angry','C_F_A Happy'},'box','off','location','southeast')


%% Plot N170, gaze and emotion
% electrodes: P9 and P10
% change / second picture

% P9, gaze
figure;
subplot (2,2,1)
hold on; title('P9 CHANGE - gaze');

plot([0 0],[-20 10],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-15 10]);
ylabel('ERP [µV]');
box on

p_C_A_F_P9 = plot(EEG.times,(mean(erp_C_A_F_Neutral(46,:,:),3)+mean(erp_C_A_F_Angry(46,:,:),3)+mean(erp_C_A_F_Happy(46,:,:),3)/3),'r','linewidth',2); 
p_C_F_A_P9 = plot(EEG.times,(mean(erp_C_F_A_Neutral(46,:,:),3)+mean(erp_C_F_A_Angry(46,:,:),3)+mean(erp_C_F_A_Happy(46,:,:),3)/3),'b','linewidth',2);  
legend([p_C_A_F_P9 p_C_F_A_P9 ],{'C_A_F','C_F_A'},'box','off','location','southeast')

% P10, gaze
subplot (2,2,2)
hold on; title('P10 CHANGE - gaze');

plot([0 0],[-20 10],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-15 10]);
ylabel('ERP [µV]');
box on

p_C_A_F_P10 = plot(EEG.times,(mean(erp_C_A_F_Neutral(47,:,:),3)+mean(erp_C_A_F_Angry(47,:,:),3)+mean(erp_C_A_F_Happy(47,:,:),3)/3),'r','linewidth',2); 
p_C_F_A_P10 = plot(EEG.times,(mean(erp_C_F_A_Neutral(47,:,:),3)+mean(erp_C_F_A_Angry(47,:,:),3)+mean(erp_C_F_A_Happy(47,:,:),3)/3),'b','linewidth',2);  
legend([p_C_A_F_P10 p_C_F_A_P9 ],{'C_A_F','C_F_A'},'box','off','location','southeast')

% P9, emotion
subplot (2,2,3)
hold on; title('P9 CHANGE - emotion');

plot([0 0],[-10 10],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-10 10]);
ylabel('ERP [µV]');
box on

p_Neutral_P9 = plot(EEG.times,(mean(erp_C_A_F_Neutral(46,:,:),3)+mean(erp_C_F_A_Neutral(46,:,:),3)/2),'r','linewidth',2); 
p_Angry_P9   = plot(EEG.times,(mean(erp_C_A_F_Angry(46,:,:),3)+mean(erp_C_F_A_Angry(46,:,:),3)/2),'b','linewidth',2);  
p_Happy_P9   = plot(EEG.times,(mean(erp_C_A_F_Happy(46,:,:),3)+mean(erp_C_F_A_Happy(46,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_P9 p_Angry_P9 p_Happy_P9 ],{'neutral','angry', 'happy'},'box','off','location','southeast')

% P10, emotion
subplot (2,2,4)
hold on; title('P10 CHANGE - emotion');

plot([0 0],[-10 10],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-10 10]);
ylabel('ERP [µV]');
box on

p_Neutral_P10 = plot(EEG.times,(mean(erp_C_A_F_Neutral(47,:,:),3)+mean(erp_C_F_A_Neutral(46,:,:),3)/2),'r','linewidth',2); 
p_Angry_P10   = plot(EEG.times,(mean(erp_C_A_F_Angry(47,:,:),3)+mean(erp_C_F_A_Angry(46,:,:),3)/2),'b','linewidth',2);  
p_Happy_P10   = plot(EEG.times,(mean(erp_C_A_F_Happy(47,:,:),3)+mean(erp_C_F_A_Happy(46,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_P10 p_Angry_P10 p_Happy_P10],{'neutral','angry', 'happy'},'box','off','location','southeast')

%% plot EPN at T7 and T8 (Change / second picture)

figure;
% T7
subplot (1,2,1)
hold on; title('T7 CHANGE - emotion');

plot([0 0],[-5 5],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-5 5]);
ylabel('ERP [µV]');
box on

p_Neutral_T7 = plot(EEG.times,(mean(erp_C_A_F_Neutral(16,:,:),3)+mean(erp_C_F_A_Neutral(16,:,:),3)/2),'r','linewidth',1.5); 
p_Angry_T7   = plot(EEG.times,(mean(erp_C_A_F_Angry(16,:,:),3)+mean(erp_C_F_A_Angry(16,:,:),3)/2),'b','linewidth',1.5);  
p_Happy_T7   = plot(EEG.times,(mean(erp_C_A_F_Happy(16,:,:),3)+mean(erp_C_F_A_Happy(16,:,:),3)/2),'g','linewidth',1.5);  

legend([p_Neutral_T7 p_Angry_T7 p_Happy_T7 ],{'neutral','angry', 'happy'},'box','off','location','southeast')

% T8
subplot (1,2,2)
hold on; title('T8 CHANGE - emotion');

plot([0 0],[-5 5],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-5 5]);
ylabel('ERP [µV]');
box on

p_Neutral_T8 = plot(EEG.times,(mean(erp_C_A_F_Neutral(20,:,:),3)+mean(erp_C_F_A_Neutral(20,:,:),3)/2),'r','linewidth',1.5); 
p_Angry_T8   = plot(EEG.times,(mean(erp_C_A_F_Angry(20,:,:),3)+mean(erp_C_F_A_Angry(20,:,:),3)/2),'b','linewidth',1.5);  
p_Happy_T8   = plot(EEG.times,(mean(erp_C_A_F_Happy(20,:,:),3)+mean(erp_C_F_A_Happy(20,:,:),3)/2),'g','linewidth',1.5);  

legend([p_Neutral_T8 p_Angry_T8 p_Happy_T8],{'neutral','angry', 'happy'},'box','off','location','southeast')

%% EPN: multiple electrodes in one plot
% T7, T8, P7, PO7, P8, PO8, P9, PO9, P10, PO10
% changing condition / second picture

% T7
figure;
subplot (2,5,1)
hold on; title('T7 CHANGE - emotion');

plot([0 0],[-8 8],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-8 8]);
ylabel('ERP [µV]');
box on

p_Neutral_T7 = plot(EEG.times,(mean(erp_C_A_F_Neutral(16,:,:),3)+mean(erp_C_F_A_Neutral(16,:,:),3)/2),'r','linewidth',2); 
p_Angry_T7   = plot(EEG.times,(mean(erp_C_A_F_Angry(16,:,:),3)+mean(erp_C_F_A_Angry(16,:,:),3)/2),'b','linewidth',2);  
p_Happy_T7   = plot(EEG.times,(mean(erp_C_A_F_Happy(16,:,:),3)+mean(erp_C_F_A_Happy(16,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_T7 p_Angry_T7 p_Happy_T7 ],{'neutral','angry', 'happy'},'box','off','location','southeast')

% P7
subplot (2,5,2)
hold on; title('P7 CHANGE - emotion');

plot([0 0],[-8 8],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-8 8]);
ylabel('ERP [µV]');
box on

p_Neutral_P7 = plot(EEG.times,(mean(erp_C_A_F_Neutral(26,:,:),3)+mean(erp_C_F_A_Neutral(26,:,:),3)/2),'r','linewidth',2); 
p_Angry_P7   = plot(EEG.times,(mean(erp_C_A_F_Angry(26,:,:),3)+mean(erp_C_F_A_Angry(26,:,:),3)/2),'b','linewidth',2);  
p_Happy_P7   = plot(EEG.times,(mean(erp_C_A_F_Happy(26,:,:),3)+mean(erp_C_F_A_Happy(26,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_P7 p_Angry_P7 p_Happy_P7 ],{'neutral','angry', 'happy'},'box','off','location','southeast')

% PO7
subplot (2,5,3)
hold on; title('PO7 CHANGE - emotion');

plot([0 0],[-8 8],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-8 8]);
ylabel('ERP [µV]');
box on

p_Neutral_PO7 = plot(EEG.times,(mean(erp_C_A_F_Neutral(33,:,:),3)+mean(erp_C_F_A_Neutral(33,:,:),3)/2),'r','linewidth',2); 
p_Angry_PO7   = plot(EEG.times,(mean(erp_C_A_F_Angry(33,:,:),3)+mean(erp_C_F_A_Angry(33,:,:),3)/2),'b','linewidth',2);  
p_Happy_PO7   = plot(EEG.times,(mean(erp_C_A_F_Happy(33,:,:),3)+mean(erp_C_F_A_Happy(33,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_PO7 p_Angry_PO7 p_Happy_PO7 ],{'neutral','angry', 'happy'},'box','off','location','southeast')

% P9
subplot (2,5,4)
hold on; title('P9 CHANGE - emotion');

plot([0 0],[-8 8],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-8 8]);
ylabel('ERP [µV]');
box on

p_Neutral_P9 = plot(EEG.times,(mean(erp_C_A_F_Neutral(25,:,:),3)+mean(erp_C_F_A_Neutral(25,:,:),3)/2),'r','linewidth',2); 
p_Angry_P9   = plot(EEG.times,(mean(erp_C_A_F_Angry(25,:,:),3)+mean(erp_C_F_A_Angry(25,:,:),3)/2),'b','linewidth',2);  
p_Happy_P9   = plot(EEG.times,(mean(erp_C_A_F_Happy(25,:,:),3)+mean(erp_C_F_A_Happy(25,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_P9 p_Angry_P9 p_Happy_P9 ],{'neutral','angry', 'happy'},'box','off','location','southeast')

%PO9
subplot (2,5,5)
hold on; title('PO9 CHANGE - emotion');

plot([0 0],[-8 8],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-8 8]);
ylabel('ERP [µV]');
box on

p_Neutral_PO9 = plot(EEG.times,(mean(erp_C_A_F_Neutral(32,:,:),3)+mean(erp_C_F_A_Neutral(32,:,:),3)/2),'r','linewidth',2); 
p_Angry_PO9 = plot(EEG.times,(mean(erp_C_A_F_Angry(32,:,:),3)+mean(erp_C_F_A_Angry(32,:,:),3)/2),'b','linewidth',2);  
p_Happy_PO9 = plot(EEG.times,(mean(erp_C_A_F_Happy(32,:,:),3)+mean(erp_C_F_A_Happy(32,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_PO9 p_Angry_PO9 p_Happy_PO9 ],{'neutral','angry', 'happy'},'box','off','location','southeast')

% T8
subplot (2,5,6)
hold on; title('T8 CHANGE - emotion');

plot([0 0],[-8 8],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-8 8]);
ylabel('ERP [µV]');
box on

p_Neutral_T8 = plot(EEG.times,(mean(erp_C_A_F_Neutral(20,:,:),3)+mean(erp_C_F_A_Neutral(20,:,:),3)/2),'r','linewidth',2); 
p_Angry_T8 = plot(EEG.times,(mean(erp_C_A_F_Angry(20,:,:),3)+mean(erp_C_F_A_Angry(20,:,:),3)/2),'b','linewidth',2);  
p_Happy_T8 = plot(EEG.times,(mean(erp_C_A_F_Happy(20,:,:),3)+mean(erp_C_F_A_Happy(20,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_T8 p_Angry_T8 p_Happy_T8],{'neutral','angry', 'happy'},'box','off','location','southeast')

% P8
subplot (2,5,7)
hold on; title('P8 CHANGE - emotion');

plot([0 0],[-8 8],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-8 8]);
ylabel('ERP [µV]');
box on

p_Neutral_P8 = plot(EEG.times,(mean(erp_C_A_F_Neutral(30,:,:),3)+mean(erp_C_F_A_Neutral(30,:,:),3)/2),'r','linewidth',2); 
p_Angry_P8   = plot(EEG.times,(mean(erp_C_A_F_Angry(30,:,:),3)+mean(erp_C_F_A_Angry(30,:,:),3)/2),'b','linewidth',2);  
p_Happy_P8   = plot(EEG.times,(mean(erp_C_A_F_Happy(30,:,:),3)+mean(erp_C_F_A_Happy(30,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_P8 p_Angry_P8 p_Happy_P8],{'neutral','angry', 'happy'},'box','off','location','southeast')

% PO8
subplot (2,5,8)
hold on; title('PO8 CHANGE - emotion');

plot([0 0],[-8 8],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-8 8]);
ylabel('ERP [µV]');
box on

p_Neutral_PO8 = plot(EEG.times,(mean(erp_C_A_F_Neutral(34,:,:),3)+mean(erp_C_F_A_Neutral(34,:,:),3)/2),'r','linewidth',2); 
p_Angry_PO8   = plot(EEG.times,(mean(erp_C_A_F_Angry(34,:,:),3)+mean(erp_C_F_A_Angry(34,:,:),3)/2),'b','linewidth',2);  
p_Happy_PO8   = plot(EEG.times,(mean(erp_C_A_F_Happy(34,:,:),3)+mean(erp_C_F_A_Happy(34,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_PO8 p_Angry_PO8 p_Happy_PO8],{'neutral','angry', 'happy'},'box','off','location','southeast')

% P10 this is the plot made by Shadi just to make the n ROI complete!!
subplot (2,5,9)
hold on; title('P10 CHANGE - emotion');

plot([0 0],[-8 8],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-8 8]);
ylabel('ERP [µV]');
box on

p_Neutral_P10 = plot(EEG.times,(mean(erp_C_A_F_Neutral(31,:,:),3)+mean(erp_C_F_A_Neutral(31,:,:),3)/2),'r','linewidth',2); 
p_Angry_P10   = plot(EEG.times,(mean(erp_C_A_F_Angry(31,:,:),3)  +mean(erp_C_F_A_Angry(31,:,:),3)/2),'b','linewidth',2);  
p_Happy_P10   = plot(EEG.times,(mean(erp_C_A_F_Happy(31,:,:),3)  +mean(erp_C_F_A_Happy(31,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_P10 p_Angry_P10 p_Happy_P10],{'neutral','angry', 'happy'},'box','off','location','southeast')


% PO10
subplot (2,5,10)
hold on; title('PO10 CHANGE - emotion'); 

plot([0 0],[-8 8],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-8 8]);
ylabel('ERP [µV]');
box on

p_Neutral_PO10 = plot(EEG.times,(mean(erp_C_A_F_Neutral(35,:,:),3)+mean(erp_C_F_A_Neutral(35,:,:),3)/2),'r','linewidth',2); 
p_Angry_PO10   = plot(EEG.times,(mean(erp_C_A_F_Angry(35,:,:),3)+mean(erp_C_F_A_Angry(35,:,:),3)/2),'b','linewidth',2);  
p_Happy_PO10   = plot(EEG.times,(mean(erp_C_A_F_Happy(35,:,:),3)+mean(erp_C_F_A_Happy(35,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_PO10 p_Angry_PO10 p_Happy_PO10],{'neutral','angry', 'happy'},'box','off','location','southeast')


% ######################################################
% #### P10: this is the plot made by Olaf in the meeting on 17-07-2017 #####
figure;
hold on; title('P10');

ELEC = [16 26 33 25 34 32 20 34 31] %T7, P7, PO7,P9, PO8, PO9, T8, P8, PO8, P10
plot(EEG.times,mean(mean(erp_C_A_F_Neutral(ELEC,:,:),3),1),'b:','linewidth',2.0)
plot(EEG.times,mean(mean(erp_C_F_A_Neutral(ELEC,:,:),3),1),'b','linewidth',1.2); 
plot(EEG.times,mean(mean(erp_C_A_F_Angry(  ELEC,:,:),3),1),'r:','linewidth',2.0);
plot(EEG.times,mean(mean(erp_C_F_A_Angry(  ELEC,:,:),3),1),'r','linewidth',1.2);  
plot(EEG.times,mean(mean(erp_C_A_F_Happy(  ELEC,:,:),3),1),'g:','linewidth',2.0); 
plot(EEG.times,mean(mean(erp_C_F_A_Happy(  ELEC,:,:),3),1),'g','linewidth',1.2);  
legend({'neutral-A->D','neutral-D->A','angry-A->D','angry-D->A','happy-A->D','happy-D->A'},'box','off','location','southeast')

plot([0 0],[-10 10],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-4.5 2]);
ylabel('ERP [µV]');
box on
plot([350 350],[-10 10],'k:'); % vertical line at 0 ms
plot([400 400],[-10 10],'k:'); % vertical line at 0 ms

%P9
figure;
hold on; title('P9');

ELEC = [16 26 33 25 34 32 20 34 31] %T7, P7, PO7, P10, PO9, T8, P8, P08, P10
plot(EEG.times,mean(mean(erp_C_A_F_Neutral(ELEC,:,:),3),1),'b:','linewidth',2.0)
plot(EEG.times,mean(mean(erp_C_F_A_Neutral(ELEC,:,:),3),1),'b','linewidth',1.2); 
plot(EEG.times,mean(mean(erp_C_A_F_Angry(  ELEC,:,:),3),1),'r:','linewidth',2.0);
plot(EEG.times,mean(mean(erp_C_F_A_Angry(  ELEC,:,:),3),1),'r','linewidth',1.2);  
plot(EEG.times,mean(mean(erp_C_A_F_Happy(  ELEC,:,:),3),1),'g:','linewidth',2.0); 
plot(EEG.times,mean(mean(erp_C_F_A_Happy(  ELEC,:,:),3),1),'g','linewidth',1.2);  
legend({'neutral-A->D','neutral-D->A','angry-A->D','angry-D->A','happy-A->D','happy-D->A'},'box','off','location','southeast')

plot([0 0],[-10 10],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-4.5 2]);
ylabel('ERP [µV]');
box on
plot([350 350],[-10 10],'k:'); % vertical line at 0 ms
plot([400 400],[-10 10],'k:'); % vertical line at 0 ms


%% Plots of the LPC
% electrodes P3, P4, Pz, POz, CP1, CP2
% changing condition / second picture

% P3
figure;
subplot (2,3,1)
hold on; title('P3 CHANGE - emotion');

plot([0 0],[-10 10],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-10 10]);
ylabel('ERP [µV]');
box on

p_Neutral_P3 = plot(EEG.times,(mean(erp_C_A_F_Neutral(27,:,:),3)+mean(erp_C_F_A_Neutral(27,:,:),3)/2),'r','linewidth',2); 
p_Angry_P3 = plot(EEG.times,(mean(erp_C_A_F_Angry(27,:,:),3)+mean(erp_C_F_A_Angry(27,:,:),3)/2),'b','linewidth',2);  
p_Happy_P3 = plot(EEG.times,(mean(erp_C_A_F_Happy(27,:,:),3)+mean(erp_C_F_A_Happy(27,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_P3 p_Angry_P3 p_Happy_P3],{'neutral','angry', 'happy'},'box','off','location','southeast')

% Pz
subplot (2,3,2)
hold on; title('Pz CHANGE - emotion');

plot([0 0],[-10 10],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-10 10]);
ylabel('ERP [µV]');
box on

p_Neutral_Pz = plot(times,(mean(erp_C_F_A_Neutral(28,:,:),3)+mean(erp_C_A_F_Neutral(28,:,:),3)/2),'r','linewidth',2); 
p_Angry_Pz = plot(times,(mean(erp_C_F_A_Angry(28,:,:),3)+mean(erp_C_A_F_Angry(28,:,:),3)/2),'b','linewidth',2);  
p_Happy_Pz = plot(times,(mean(erp_C_F_A_Happy(28,:,:),3)+mean(erp_C_A_F_Happy(28,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_Pz p_Angry_Pz p_Happy_Pz],{'neutral','angry', 'happy'},'box','off','location','southeast')

% P4
subplot (2,3,3)
hold on; title('P4 CHANGE - emotion');

plot([0 0],[-10 10],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-10 10]);
ylabel('ERP [µV]');
box on

p_Neutral_P4 = plot(times,(mean(erp_C_F_A_Neutral(29,:,:),3)+mean(erp_C_A_F_Neutral(29,:,:),3)/2),'r','linewidth',2); 
p_Angry_P4 = plot(times,(mean(erp_C_F_A_Angry(29,:,:),3)+mean(erp_C_A_F_Angry(29,:,:),3)/2),'b','linewidth',2);  
p_Happy_P4 = plot(times,(mean(erp_C_F_A_Happy(29,:,:),3)+mean(erp_C_A_F_Happy(29,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_P4 p_Angry_P4 p_Happy_P4],{'neutral','angry', 'happy'},'box','off','location','southeast')

% POz
%subplot (2,3,4)
%hold on; title('POz CHANGE - emotion');

%plot([0 0],[-10 10],'k'); % vertical line at 0 ms
%plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
%xlim([-100 1000]);
%ylim([-10 10]);
%ylabel('ERP [µV]');
%box on

%p_Neutral_POz = plot(EEG.times,(mean(erp_C_A_F_Neutral(38,:,:),3)+mean(erp_C_F_A_Neutral(38,:,:),3)/2),'r','linewidth',2); 
%p_Angry_POz = plot(EEG.times,(mean(erp_C_A_F_Angry(38,:,:),3)+mean(erp_C_F_A_Angry(38,:,:),3)/2),'b','linewidth',2);  
%p_Happy_POz = plot(EEG.times,(mean(erp_C_A_F_Happy(38,:,:),3)+mean(erp_C_F_A_Happy(38,:,:),3)/2),'g','linewidth',2);  

%legend([p_Neutral_POz p_Angry_POz p_Happy_POz],{'neutral','angry', 'happy'},'box','off','location','southeast')

% CP1
subplot (2,3,4)
hold on; title('CP1 CHANGE - emotion');

plot([0 0],[-10 10],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-10 10]);
ylabel('ERP [µV]');
box on

p_Neutral_CP1 = plot(times,(mean(erp_C_F_A_Neutral(22,:,:),3)+mean(erp_C_A_F_Neutral(22,:,:),3)/2),'r','linewidth',2); 
p_Angry_CP1 = plot(times,(mean(erp_C_F_A_Angry(22,:,:),3)+mean(erp_C_A_F_Angry(22,:,:),3)/2),'b','linewidth',2);  
p_Happy_CP1 = plot(times,(mean(erp_C_F_A_Happy(22,:,:),3)+mean(erp_C_A_F_Happy(22,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_CP1 p_Angry_CP1 p_Happy_CP1],{'neutral','angry', 'happy'},'box','off','location','southeast')

% CP2
subplot (2,3,5)
hold on; title('CP2 CHANGE - emotion');

plot([0 0],[-10 10],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-10 10]);
ylabel('ERP [µV]');
box on

p_Neutral_CP2 = plot(times,(mean(erp_C_F_A_Neutral(23,:,:),3)+mean(erp_C_A_F_Neutral(23,:,:),3)/2),'r','linewidth',2); 
p_Angry_CP2 = plot(times,(mean(erp_C_F_A_Angry(23,:,:),3)+mean(erp_C_A_F_Angry(23,:,:),3)/2),'b','linewidth',2);  
p_Happy_CP2 = plot(times,(mean(erp_C_F_A_Happy(23,:,:),3)+mean(erp_C_A_F_Happy(23,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_CP2 p_Angry_CP2 p_Happy_CP2],{'neutral','angry', 'happy'},'box','off','location','southeast')


