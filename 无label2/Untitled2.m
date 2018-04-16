%ÌÞ³ýlabel2
clc;clear;

load('CollectedFeatures.mat');
load('CollectedLabels.mat');
Data0 = CollectedFeatures;
Label0 = CollectedLabels;
j = 1;
a = 0;
for i = 1:1:264
    if Label0(i,1) ~= 2
        Data(j,:) = Data0(i,:);
        Label(j,1) = Label0(i,1);
        j = 1+j;
    end
    if Label0(i,1) == 2
        a = 1+a;
    end
end

clearvars -except Data Label
save DataExcept2;