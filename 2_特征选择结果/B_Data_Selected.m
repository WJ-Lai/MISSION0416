%提取31个特征数据

%%
%总数据
clear;clc;
% load('DataExcept2.mat');
load('CollectedFeatures.mat');
load('CollectedLabels.mat');
Data = CollectedFeatures;
Label = CollectedLabels;
[Row Column] = size(Data);

%设置特征选择的个数和对应编号
n=2;
selectedIndices = [1 7 ];


selectedIndices = selectedIndices';
%形成特征筛选后新的数据集(仅仅有数据，无label)
Data_Selected = zeros(Row,n);

for i= 1:n
   %特征放在后面
    Data_Selected(:,i) = [Data(:,selectedIndices(i))];
end

%%
%是否需要归一化
%归一化
% Data_Selected = mapminmax(Data_Selected', 0, 1)';

clearvars -except Data_Selected Label
save Data_Selected;

