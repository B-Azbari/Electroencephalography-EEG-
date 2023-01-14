%% PLOTs 

% This script can serve as a framework for designing some plots, especially for starting condition: 
% included in this script: grand-average ERP, EPN, LPC, various electrodes

% save plots manually after inspection

eeglab
% change folder to eeglab-Folder, if necessary: ('O:/_Eye contact/eeglab14_1_1b')

addpath ('O:/Parenting Study/Parenting EEG/Parenthood_EyeContact/Analysis/preprocessed_data/ERPs (.mat files)/')
load 'Pa_eyegaze_2020.mat' % contains preprocessed and epoched data; containing labeled epochs of different conditions

%% variables%% eeglab and data

times = [-200:1:999];

%% plot grand-average ERP: Gaze and emotion conditions, electrodes P9 and P10
% over the time-course of the whole epoch
% starting condition / first picture

figure;
subplot (2,2,1)
hold on; title('P9 START - gaze'); % allow plotting in one figure + title

plot([0 0],[-17 13],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]); % limitations of x-acis
ylim([-17 13]); % limtations of y-axis
ylabel('ERP [µV]'); % lables of y-axis
box on % display legend

% what to plot in figure + legend
% Here: two curves for frontal and averted gaze
p_Frontal_P9 = plot(times,((mean(erp_Frontal_Neutral(25,:,:),3)+mean(erp_Frontal_Angry(25,:,:),3)+mean(erp_Frontal_Happy(25,:,:),3))/3),'r','linewidth',2); 
p_Averted_P9 = plot(times,((mean(erp_Averted_Neutral(25,:,:),3)+mean(erp_Averted_Angry(25,:,:),3)+mean(erp_Averted_Happy(25,:,:),3))/3),'b','linewidth',2);  
legend([p_Frontal_P9 p_Averted_P9 ],{'Frontal','Averted'},'box','off','location','southeast')


subplot (2,2,2)
hold on; title('P10 START - gaze');

plot([0 0],[-17 13],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]); % limitations of x-acis
ylim([-17 13]); % limtations of y-axis
ylabel('ERP [µV]'); % lables of y-axis
box on % display legend

p_Frontal_P10 = plot(times,(mean(erp_Frontal_Neutral(31,:,:),3)+mean(erp_Frontal_Angry(31,:,:),3)+mean(erp_Frontal_Happy(31,:,:),3)/3),'r','linewidth',2); 
p_Averted_P10 = plot(times,(mean(erp_Averted_Neutral(31,:,:),3)+mean(erp_Averted_Angry(31,:,:),3)+mean(erp_Averted_Happy(31,:,:),3)/3),'b','linewidth',2);  
legend([p_Frontal_P10 p_Averted_P10 ],{'Frontal','Averted'},'box','off','location','southeast')


subplot (2,2,3)
hold on; title('P9 START - emotion');

plot([0 0],[-15 10],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]); % limitations of x-acis
ylim([-15 10]); % limtations of y-axis
ylabel('ERP [µV]'); % lables of y-axis
box on % display legend

p_Neutral_P9 = plot(times,(mean(erp_Frontal_Neutral(25,:,:),3)+mean(erp_Averted_Neutral(25,:,:),3)/2),'b','linewidth',2); 
p_Angry_P9 = plot(times,(mean(erp_Frontal_Angry(25,:,:),3)+mean(erp_Averted_Angry(25,:,:),3)/2),'r','linewidth',2);  
p_Happy_P9 = plot(times,(mean(erp_Frontal_Happy(25,:,:),3)+mean(erp_Averted_Happy(25,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_P9 p_Angry_P9 p_Happy_P9 ],{'neutral','angry', 'happy'},'box','off','location','southeast')


subplot (2,2,4)
hold on; title('P10 START - emotion');

plot([0 0],[-15 10],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]); % limitations of x-acis
ylim([-15 10]); % limtations of y-axis
ylabel('ERP [µV]'); % lables of y-axis
box on % display legend

p_Neutral_P10 = plot(times,(mean(erp_Frontal_Neutral(31,:,:),3)+mean(erp_Averted_Neutral(31,:,:),3)/2),'b','linewidth',2); 
p_Angry_P10 = plot(times,(mean(erp_Frontal_Angry(31,:,:),3)+mean(erp_Averted_Angry(31,:,:),3)/2),'r','linewidth',2);  
p_Happy_P10 = plot(times,(mean(erp_Frontal_Happy(31,:,:),3)+mean(erp_Averted_Happy(31,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_P10 p_Angry_P10 p_Happy_P10],{'neutral','angry', 'happy'},'box','off','location','southeast')


%************** Added By Shadi For 'PO8 and PO7' / 'P7 and P8' / 'PO9 and PO10' *********************
%Change accordingy!

figure;
subplot (2,2,1)
hold on; title('P9 START - gaze'); % allow plotting in one figure + title

plot([0 0],[-15 15],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]); % limitations of x-acis
ylim([-15 15]); % limtations of y-axis
ylabel('ERP [µV]'); % lables of y-axis
box on % display legend


p_Frontal_P9 = plot(times,(mean(erp_Frontal_Neutral(25,:,:),3)+mean(erp_Frontal_Angry(25,:,:),3)+mean(erp_Frontal_Happy(25,:,:),3)/3),'r','linewidth',2); 
p_Averted_P9= plot(times,(mean(erp_Averted_Neutral(25,:,:),3)+mean(erp_Averted_Angry(25,:,:),3)+mean(erp_Averted_Happy(25,:,:),3)/3),'b','linewidth',2);  
legend([p_Frontal_P9 p_Averted_P9 ],{'Frontal','Averted'},'box','off','location','southeast')


subplot (2,2,2)
hold on; title('P10 START - gaze');
 
plot([0 0],[-15 15],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]); % limitations of x-acis
ylim([-15 15]); % limtations of y-axis
ylabel('ERP [µV]'); % lables of y-axis
box on % display legend

p_Frontal_P10= plot(times,(mean(erp_Frontal_Neutral(31,:,:),3)+mean(erp_Frontal_Angry(31,:,:),3)+mean(erp_Frontal_Happy(31,:,:),3)/3),'r','linewidth',2); 
p_Averted_P10 = plot(times,(mean(erp_Averted_Neutral(31,:,:),3)+mean(erp_Averted_Angry(31,:,:),3)+mean(erp_Averted_Happy(31,:,:),3)/3),'b','linewidth',2);  
legend([p_Frontal_P10 p_Averted_P10 ],{'Frontal','Averted'},'box','off','location','southeast')


subplot (2,2,3)
hold on; title('P9START - emotion');

plot([0 0],[-15 10],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]); % limitations of x-acis
ylim([-15 10]); % limtations of y-axis
ylabel('ERP [µV]'); % lables of y-axis
box on % display legend

p_Neutral_P9 = plot(times,(mean(erp_Frontal_Neutral(25,:,:),3)+mean(erp_Averted_Neutral(25,:,:),3)/2),'b','linewidth',2); 
p_Angry_P9 = plot(times,(mean(erp_Frontal_Angry(25,:,:),3)+mean(erp_Averted_Angry(25,:,:),3)/2),'r','linewidth',2);  
p_Happy_P9 = plot(times,(mean(erp_Frontal_Happy(25,:,:),3)+mean(erp_Averted_Happy(25,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_P9 p_Angry_P9 p_Happy_P9],{'neutral','angry', 'happy'},'box','off','location','southeast')


subplot (2,2,4)
hold on; title('P10 START - emotion');

plot([0 0],[-15 10],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]); % limitations of x-acis
ylim([-15 10]); % limtations of y-axis
ylabel('ERP [µV]'); % lables of y-axis
box on % display legend

p_Neutral_P10 = plot(times,(mean(erp_Frontal_Neutral(31,:,:),3)+mean(erp_Averted_Neutral(31,:,:),3)/2),'b','linewidth',2); 
p_Angry_P10 = plot(times,(mean(erp_Frontal_Angry(31,:,:),3)+mean(erp_Averted_Angry(31,:,:),3)/2),'r','linewidth',2);  
p_Happy_P10= plot(times,(mean(erp_Frontal_Happy(31,:,:),3)+mean(erp_Averted_Happy(31,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_P10 p_Angry_P10 p_Happy_P10],{'neutral','angry', 'happy'},'box','off','location','southeast')

%% plot EPN at T7 and T8 (Starting condition/first picture)

figure;

subplot (1,2,1)
hold on; title('T7 START - emotion');

plot([0 0],[-4 3],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-4 3]);
ylabel('ERP [µV]');
box on

p_Neutral_T7 = plot(times,(mean(erp_Frontal_Neutral(16,:,:),3)+mean(erp_Averted_Neutral(16,:,:),3)/2),'b','linewidth',2); 
p_Angry_T7 = plot(times,(mean(erp_Frontal_Angry(16,:,:),3)+mean(erp_Averted_Angry(16,:,:),3)/2),'r','linewidth',2);  
p_Happy_T7 = plot(times,(mean(erp_Frontal_Happy(16,:,:),3)+mean(erp_Averted_Happy(16,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_T7 p_Angry_T7 p_Happy_T7 ],{'neutral','angry', 'happy'},'box','off','location','northeast')


subplot (1,2,2)
hold on; title('T8 START - emotion');

plot([0 0],[-4 3],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-4 3]);
ylabel('ERP [µV]');
box on

p_Neutral_T8 = plot(times,(mean(erp_Frontal_Neutral(20,:,:),3)+mean(erp_Averted_Neutral(20,:,:),3)/2),'b','linewidth',2); 
p_Angry_T8 = plot(times,(mean(erp_Frontal_Angry(20,:,:),3)+mean(erp_Averted_Angry(20,:,:),3)/2),'r','linewidth',2);  
p_Happy_T8 = plot(times,(mean(erp_Frontal_Happy(20,:,:),3)+mean(erp_Averted_Happy(20,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_T8 p_Angry_T8 p_Happy_T8],{'neutral','angry', 'happy'},'box','off','location','northeast')

%% EPN: multiple electrodes in one plot
% T7, T8, P7, PO7, P8, PO8, P9, PO9, P10, PO10
% starting condition / first picture

% T7
figure;
subplot (2,5,1)
hold on; title('T7 START - emotion');

plot([0 0],[-8 20],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-8 20]);
ylabel('ERP [µV]');
box on

p_Neutral_T7 = plot(times,(mean(erp_Frontal_Neutral(16,:,:),3)+mean(erp_Averted_Neutral(16,:,:),3)/2),'b','linewidth',2); 
p_Angry_T7 = plot(times,(mean(erp_Frontal_Angry(16,:,:),3)+mean(erp_Averted_Angry(16,:,:),3)/2),'r','linewidth',2);  
p_Happy_T7 = plot(times,(mean(erp_Frontal_Happy(16,:,:),3)+mean(erp_Averted_Happy(16,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_T7 p_Angry_T7 p_Happy_T7 ],{'neutral','angry', 'happy'},'box','off','location','northeast')

% P7
subplot (2,5,2)
hold on; title('P7 START - emotion');

plot([0 0],[-8 20],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-8 20]);
ylabel('ERP [µV]');
box on

p_Neutral_P7 = plot(times,(mean(erp_Frontal_Neutral(26,:,:),3)+mean(erp_Averted_Neutral(26,:,:),3)/2),'b','linewidth',2); 
p_Angry_P7 = plot(times,(mean(erp_Frontal_Angry(26,:,:),3)+mean(erp_Averted_Angry(26,:,:),3)/2),'r','linewidth',2);  
p_Happy_P7 = plot(times,(mean(erp_Frontal_Happy(26,:,:),3)+mean(erp_Averted_Happy(26,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_P7 p_Angry_P7 p_Happy_P7 ],{'neutral','angry', 'happy'},'box','off','location','northeast')

% PO7 (Shadi Changed 2)
subplot (2,5,3)
hold on; title('PO7 START - emotion');

plot([0 0],[-8 20],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-8 20]);
ylabel('ERP [µV]');
box on

p_Neutral_PO7 = plot(times,(mean(erp_Frontal_Neutral(33,:,:),3)+mean(erp_Averted_Neutral(33,:,:),3)/2),'b','linewidth',2); 
p_Angry_PO7 = plot(times,(mean(erp_Frontal_Angry(33,:,:),3)+mean(erp_Averted_Angry(33,:,:),3)/2),'r','linewidth',2);  
p_Happy_PO7 = plot(times,(mean(erp_Frontal_Happy(33,:,:),3)+mean(erp_Averted_Happy(33,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_PO7 p_Angry_PO7 p_Happy_PO7 ],{'neutral','angry', 'happy'},'box','off','location','northeast')

% P9
subplot (2,5,4)
hold on; title('P9 START - emotion');

plot([0 0],[-10 20],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-10 20]);
ylabel('ERP [µV]');
box on

p_Neutral_P9 = plot(times,(mean(erp_Frontal_Neutral(25,:,:),3)+mean(erp_Averted_Neutral(25,:,:),3)/2),'b','linewidth',2); 
p_Angry_P9 = plot(times,(mean(erp_Frontal_Angry(25,:,:),3)+mean(erp_Averted_Angry(25,:,:),3)/2),'r','linewidth',2);  
p_Happy_P9 = plot(times,(mean(erp_Frontal_Happy(25,:,:),3)+mean(erp_Averted_Happy(25,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_P9 p_Angry_P9 p_Happy_P9 ],{'neutral','angry', 'happy'},'box','off','location','northeast')

% PO9
subplot (2,5,5)
hold on; title('PO9 START - emotion');

plot([0 0],[-8 20],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-8 20]);
ylabel('ERP [µV]');
box on

p_Neutral_PO9 = plot(times,(mean(erp_Frontal_Neutral(32,:,:),3)+mean(erp_Averted_Neutral(32,:,:),3)/2),'b','linewidth',2); 
p_Angry_PO9 = plot(times,(mean(erp_Frontal_Angry(32,:,:),3)+mean(erp_Averted_Angry(32,:,:),3)/2),'r','linewidth',2);  
p_Happy_PO9 = plot(times,(mean(erp_Frontal_Happy(32,:,:),3)+mean(erp_Averted_Happy(32,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_PO9 p_Angry_PO9 p_Happy_PO9 ],{'neutral','angry', 'happy'},'box','off','location','northeast')

% T8
subplot (2,5,6)
hold on; title('T8 START - emotion');

plot([0 0],[-8 20],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-8 20]);
ylabel('ERP [µV]');
box on

p_Neutral_T8 = plot(times,(mean(erp_Frontal_Neutral(20,:,:),3)+mean(erp_Averted_Neutral(20,:,:),3)/2),'b','linewidth',2); 
p_Angry_T8 = plot(times,(mean(erp_Frontal_Angry(20,:,:),3)+mean(erp_Averted_Angry(20,:,:),3)/2),'r','linewidth',2);  
p_Happy_T8 = plot(times,(mean(erp_Frontal_Happy(20,:,:),3)+mean(erp_Averted_Happy(20,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_T8 p_Angry_T8 p_Happy_T8],{'neutral','angry', 'happy'},'box','off','location','northeast')

% P8
subplot (2,5,7)
hold on; title('P8 START - emotion');

plot([0 0],[-8 20],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-8 20]);
ylabel('ERP [µV]');
box on

p_Neutral_P8 = plot(times,(mean(erp_Frontal_Neutral(30,:,:),3)+mean(erp_Averted_Neutral(30,:,:),3)/2),'b','linewidth',2); 
p_Angry_P8 = plot(times,(mean(erp_Frontal_Angry(30,:,:),3)+mean(erp_Averted_Angry(30,:,:),3)/2),'r','linewidth',2);  
p_Happy_P8 = plot(times,(mean(erp_Frontal_Happy(30,:,:),3)+mean(erp_Averted_Happy(30,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_P8 p_Angry_P8 p_Happy_P8],{'neutral','angry', 'happy'},'box','off','location','northeast')

% PO8
subplot (2,5,8)
hold on; title('PO8 START - emotion');

plot([0 0],[-8 20],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-8 20]);
ylabel('ERP [µV]');
box on

p_Neutral_PO8 = plot(times,(mean(erp_Frontal_Neutral(34,:,:),3)+mean(erp_Averted_Neutral(34,:,:),3)/2),'b','linewidth',2); 
p_Angry_PO8 = plot(times,(mean(erp_Frontal_Angry(34,:,:),3)+mean(erp_Averted_Angry(34,:,:),3)/2),'r','linewidth',2);  
p_Happy_PO8 = plot(times,(mean(erp_Frontal_Happy(34,:,:),3)+mean(erp_Averted_Happy(34,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_PO8 p_Angry_PO8 p_Happy_PO8],{'neutral','angry', 'happy'},'box','off','location','northeast')

% P10
subplot (2,5,9)
hold on; title('P10 START - emotion');

plot([0 0],[-12 20],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-12 20]);
ylabel('ERP [µV]');
box on

p_Neutral_P10 = plot(times,(mean(erp_Frontal_Neutral(31,:,:),3)+mean(erp_Averted_Neutral(31,:,:),3)/2),'b','linewidth',2); 
p_Angry_P10 = plot(times,(mean(erp_Frontal_Angry(31,:,:),3)+mean(erp_Averted_Angry(31,:,:),3)/2),'r','linewidth',2);  
p_Happy_P10 = plot(times,(mean(erp_Frontal_Happy(31,:,:),3)+mean(erp_Averted_Happy(31,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_P10 p_Angry_P10 p_Happy_P10],{'neutral','angry', 'happy'},'box','off','location','northeast')

% PO10
subplot (2,5,10)
hold on; title('PO10 START - emotion');

plot([0 0],[-10 20],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-10 20]);
ylabel('ERP [µV]');
box on

p_Neutral_PO10 = plot(times,(mean(erp_Frontal_Neutral(35,:,:),3)+mean(erp_Averted_Neutral(35,:,:),3)/2),'b','linewidth',2); 
p_Angry_PO10 = plot(times,(mean(erp_Frontal_Angry(35,:,:),3)+mean(erp_Averted_Angry(35,:,:),3)/2),'r','linewidth',2);  
p_Happy_PO10 = plot(times,(mean(erp_Frontal_Happy(35,:,:),3)+mean(erp_Averted_Happy(35,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_PO10 p_Angry_PO10 p_Happy_PO10],{'neutral','angry', 'happy'},'box','off','location','northeast')

%*********  Added By Shadi For Posterior Area **********

% PO7 
subplot (2,5,1)
hold on; title('PO7 START - emotion');

plot([0 0],[-8 20],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-8 20]);
ylabel('ERP [µV]');
box on

p_Neutral_PO7 = plot(times,(mean(erp_Frontal_Neutral(33,:,:),3)+mean(erp_Averted_Neutral(33,:,:),3)/2),'b','linewidth',2); 
p_Angry_PO7 = plot(times,(mean(erp_Frontal_Angry(33,:,:),3)+mean(erp_Averted_Angry(33,:,:),3)/2),'r','linewidth',2);  
p_Happy_PO7 = plot(times,(mean(erp_Frontal_Happy(33,:,:),3)+mean(erp_Averted_Happy(33,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_PO7 p_Angry_PO7 p_Happy_PO7 ],{'neutral','angry', 'happy'},'box','off','location','northeast')

% PO9
subplot (2,5,2)
hold on; title('PO9 START - emotion');

plot([0 0],[-8 20],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-8 20]);
ylabel('ERP [µV]');
box on

p_Neutral_PO9 = plot(times,(mean(erp_Frontal_Neutral(32,:,:),3)+mean(erp_Averted_Neutral(32,:,:),3)/2),'b','linewidth',2); 
p_Angry_PO9 = plot(times,(mean(erp_Frontal_Angry(32,:,:),3)+mean(erp_Averted_Angry(32,:,:),3)/2),'r','linewidth',2);  
p_Happy_PO9 = plot(times,(mean(erp_Frontal_Happy(32,:,:),3)+mean(erp_Averted_Happy(32,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_PO9 p_Angry_PO9 p_Happy_PO9 ],{'neutral','angry','happy'},'box','off','location','northeast')

% P8
subplot (2,5,3)
hold on; title('P8 START - emotion');

plot([0 0],[-8 20],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-8 20]);
ylabel('ERP [µV]');
box on

p_Neutral_P8 = plot(times,(mean(erp_Frontal_Neutral(30,:,:),3)+mean(erp_Averted_Neutral(30,:,:),3)/2),'b','linewidth',2); 
p_Angry_P8 = plot(times,(mean(erp_Frontal_Angry(30,:,:),3)+mean(erp_Averted_Angry(30,:,:),3)/2),'r','linewidth',2);  
p_Happy_P8 = plot(times,(mean(erp_Frontal_Happy(30,:,:),3)+mean(erp_Averted_Happy(30,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_P8 p_Angry_P8 p_Happy_P8],{'neutral','angry', 'happy'},'box','off','location','northeast')

% PO8
subplot (2,5,4)
hold on; title('PO8 START - emotion');

plot([0 0],[-8 20],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-8 20]);
ylabel('ERP [µV]');
box on

p_Neutral_PO8 = plot(times,(mean(erp_Frontal_Neutral(34,:,:),3)+mean(erp_Averted_Neutral(34,:,:),3)/2),'b','linewidth',2); 
p_Angry_PO8 = plot(times,(mean(erp_Frontal_Angry(34,:,:),3)+mean(erp_Averted_Angry(34,:,:),3)/2),'r','linewidth',2);  
p_Happy_PO8 = plot(times,(mean(erp_Frontal_Happy(34,:,:),3)+mean(erp_Averted_Happy(34,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_PO8 p_Angry_PO8 p_Happy_PO8],{'neutral','angry', 'happy'},'box','off','location','southeast')


% P10
subplot (2,5,5)
hold on; title('P10 START - emotion');

plot([0 0],[-12 20],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-12 20]);
ylabel('ERP [µV]');
box on

p_Neutral_P10 = plot(times,(mean(erp_Frontal_Neutral(31,:,:),3)+mean(erp_Averted_Neutral(31,:,:),3)/2),'b','linewidth',2); 
p_Angry_P10 = plot(times,(mean(erp_Frontal_Angry(31,:,:),3)+mean(erp_Averted_Angry(31,:,:),3)/2),'r','linewidth',2);  
p_Happy_P10 = plot(times,(mean(erp_Frontal_Happy(31,:,:),3)+mean(erp_Averted_Happy(31,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_P10 p_Angry_P10 p_Happy_P10],{'neutral','angry', 'happy'},'box','off','location','southeast')


% PO10
subplot (2,5,6)
hold on; title('PO10 START - emotion');

plot([0 0],[-10 20],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-10 20]);
ylabel('ERP [µV]');
box on

p_Neutral_PO10 = plot(times,(mean(erp_Frontal_Neutral(35,:,:),3)+mean(erp_Averted_Neutral(35,:,:),3)/2),'b','linewidth',2); 
p_Angry_PO10 = plot(times,(mean(erp_Frontal_Angry(35,:,:),3)+mean(erp_Averted_Angry(35,:,:),3)/2),'r','linewidth',2);  
p_Happy_PO10 = plot(times,(mean(erp_Frontal_Happy(35,:,:),3)+mean(erp_Averted_Happy(35,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_PO10 p_Angry_PO10 p_Happy_PO10],{'neutral','angry', 'happy'},'box','off','location','southeast')


%% Plots of the LPC
% electrodes P3, P4, Pz, POz, CP1, CP2
% starting condition / first picture

% P3
figure;
subplot (2,3,1)
hold on; title('P3 START - emotion');

plot([0 0],[-6 6],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-6 6]);
ylabel('ERP [µV]');
box on

p_Neutral_P3 = plot(times,(mean(erp_Frontal_Neutral(27,:,:),3)+mean(erp_Averted_Neutral(27,:,:),3)/2),'b','linewidth',2); 
p_Angry_P3 = plot(times,(mean(erp_Frontal_Angry(27,:,:),3)+mean(erp_Averted_Angry(27,:,:),3)/2),'r','linewidth',2);  
p_Happy_P3 = plot(times,(mean(erp_Frontal_Happy(27,:,:),3)+mean(erp_Averted_Happy(27,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_P3 p_Angry_P3 p_Happy_P3],{'neutral','angry', 'happy'},'box','off','location','southeast')

% Pz
subplot (2,3,2)
hold on; title('Pz START - emotion');

plot([0 0],[-6 6],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-6 6]);
ylabel('ERP [µV]');
box on

p_Neutral_Pz = plot(times,(mean(erp_Frontal_Neutral(28,:,:),3)+mean(erp_Averted_Neutral(28,:,:),3)/2),'b','linewidth',2); 
p_Angry_Pz   = plot(times,(mean(erp_Frontal_Angry(28,:,:),3)+mean(erp_Averted_Angry(28,:,:),3)/2),'r','linewidth',2);  
p_Happy_Pz   = plot(times,(mean(erp_Frontal_Happy(28,:,:),3)+mean(erp_Averted_Happy(28,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_Pz p_Angry_Pz p_Happy_Pz],{'neutral','angry', 'happy'},'box','off','location','southeast')

% P4
subplot (2,3,3)
hold on; title('P4 START - emotion');

plot([0 0],[-6 6],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-6 6]);
ylabel('ERP [µV]');
box on

p_Neutral_P4 = plot(times,(mean(erp_Frontal_Neutral(29,:,:),3)+mean(erp_Averted_Neutral(29,:,:),3)/2),'b','linewidth',2); 
p_Angry_P4 = plot(times,(mean(erp_Frontal_Angry(29,:,:),3)+mean(erp_Averted_Angry(29,:,:),3)/2),'r','linewidth',2);  
p_Happy_P4 = plot(times,(mean(erp_Frontal_Happy(29,:,:),3)+mean(erp_Averted_Happy(29,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_P4 p_Angry_P4 p_Happy_P4],{'neutral','angry', 'happy'},'box','off','location','southeast')

    % POz
    %subplot (2,3,4)
    %hold on; title('POz START - emotion');

   % plot([0 0],[-10 10],'k'); % vertical line at 0 ms
    %plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
   % xlim([-100 1000]);
   % ylim([-10 10]);
   % ylabel('ERP [µV]');
   % box on

   % p_Neutral_POz = plot(times,(mean(erp_Frontal_Neutral(38,:,:),3)+mean(erp_Averted_Neutral(38,:,:),3)/2),'r','linewidth',2); 
  % p_Angry_POz = plot(times,(mean(erp_Frontal_Angry(38,:,:),3)+mean(erp_Averted_Angry(38,:,:),3)/2),'b','linewidth',2);  
   % p_Happy_POz = plot(times,(mean(erp_Frontal_Happy(38,:,:),3)+mean(erp_Averted_Happy(38,:,:),3)/2),'g','linewidth',2);  

   % legend([p_Neutral_POz p_Angry_POz p_Happy_POz],{'neutral','angry', 'happy'},'box','off','location','southeast')

% CP1
subplot (2,3,4)
hold on; title('CP1 START - emotion');

plot([0 0],[-6 6],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-6 6]);
ylabel('ERP [µV]');
box on

p_Neutral_CP1 = plot(times,(mean(erp_Frontal_Neutral(22,:,:),3)+mean(erp_Averted_Neutral(22,:,:),3)/2),'b','linewidth',2); 
p_Angry_CP1 = plot(times,(mean(erp_Frontal_Angry(22,:,:),3)+mean(erp_Averted_Angry(22,:,:),3)/2),'r','linewidth',2);  
p_Happy_CP1 = plot(times,(mean(erp_Frontal_Happy(22,:,:),3)+mean(erp_Averted_Happy(22,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_CP1 p_Angry_CP1 p_Happy_CP1],{'neutral','angry', 'happy'},'box','off','location','southeast')

% CP2
subplot (2,3,5)
hold on; title('CP2 START - emotion');

plot([0 0],[-6 6],'k'); % vertical line at 0 ms
plot([-100 1000],[0 0],'k'); % horizontal line at 0 ms
xlim([-100 1000]);
ylim([-6 6]);
ylabel('ERP [µV]');
box on

p_Neutral_CP2 = plot(times,(mean(erp_Frontal_Neutral(23,:,:),3)+mean(erp_Averted_Neutral(23,:,:),3)/2),'b','linewidth',2); 
p_Angry_CP2 = plot(times,(mean(erp_Frontal_Angry(23,:,:),3)+mean(erp_Averted_Angry(23,:,:),3)/2),'r','linewidth',2);  
p_Happy_CP2 = plot(times,(mean(erp_Frontal_Happy(23,:,:),3)+mean(erp_Averted_Happy(23,:,:),3)/2),'g','linewidth',2);  

legend([p_Neutral_CP2 p_Angry_CP2 p_Happy_CP2],{'neutral','angry', 'happy'},'box','off','location','southeast')

