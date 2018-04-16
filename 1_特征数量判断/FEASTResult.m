%FEAST
clc;clear;

%数据整理
load('CollectedFeatures.mat');
load('CollectedLabels.mat');
Data = CollectedFeatures;
Label = CollectedLabels;

n = 10;

%普通离散
[selectedIndices,Data_discrete] = FeatureSelect( Data,Label,n,1);

%高级离散
[selectedIndices1,Data_discrete1] = FeatureSelect( Data,Label,n,2);