%��ȡ31����������

%%
%������
clear;clc;
% load('DataExcept2.mat');
load('CollectedFeatures.mat');
load('CollectedLabels.mat');
Data = CollectedFeatures;
Label = CollectedLabels;
[Row Column] = size(Data);

%��������ѡ��ĸ����Ͷ�Ӧ���
n=2;
selectedIndices = [1 7 ];


selectedIndices = selectedIndices';
%�γ�����ɸѡ���µ����ݼ�(���������ݣ���label)
Data_Selected = zeros(Row,n);

for i= 1:n
   %�������ں���
    Data_Selected(:,i) = [Data(:,selectedIndices(i))];
end

%%
%�Ƿ���Ҫ��һ��
%��һ��
% Data_Selected = mapminmax(Data_Selected', 0, 1)';

clearvars -except Data_Selected Label
save Data_Selected;

