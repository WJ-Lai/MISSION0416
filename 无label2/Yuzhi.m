%阈值

clc;
clear;

% load('DataExcept2.mat');
% data = Data(:,1);

load('CollectedFeatures.mat');
load('CollectedLabels.mat');
Data = [CollectedFeatures(:,1),CollectedFeatures(:,7)];
Label = CollectedLabels;
oneD = [];
twoD = [];
threeD = [];
oneL = [];
twoL = [];
threeL = [];
for i = 1:1:264
    if Label(i,1) == 1
        oneD = [oneD;Data(i,:)];
        oneL = [oneL;Label(i,:)];
    end
    if Label(i,1) == 2
        twoD = [twoD;Data(i,:)];
        twoL = [twoL;Label(i,:)];
    end
    if Label(i,1) == 3
        threeD = [threeD;Data(i,:)];
        threeL = [threeL;Label(i,:)];
    end
end

scatter(oneD(:,1),oneD(:,2),'k');
hold on;
scatter(twoD(:,1),twoD(:,2),'g');
hold on;
scatter(threeD(:,1),threeD(:,2),'r');

xlabel('特征1','fontsize',15)
ylabel('特征7','fontsize',15)
legend('1','2','3');
title('样本关于特征1和特征7的分布','fontsize',18);

data = [oneD(:,2);twoD(:,2)];
label = [oneL(:,1);twoL(:,1)];
prctile(data,50)