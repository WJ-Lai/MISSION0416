%FEAST
clc;clear;

%��������
load('CollectedFeatures.mat');
load('CollectedLabels.mat');
Data = CollectedFeatures;
Label = CollectedLabels;

n = 10;

%��ͨ��ɢ
[selectedIndices,Data_discrete] = FeatureSelect( Data,Label,n,1);

%�߼���ɢ
[selectedIndices1,Data_discrete1] = FeatureSelect( Data,Label,n,2);