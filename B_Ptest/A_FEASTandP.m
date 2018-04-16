%FEAST�������Լ���

clear;clc;
load('CollectedFeatures.mat');
load('CollectedLabels.mat');
Data = CollectedFeatures;
Label = CollectedLabels;

%FEASTѡ�����
n = 10;
%��һ���ȼ�����
FirstNumber = 5;
%�ڶ����ȼ�����
SecondNumber = n - FirstNumber;
%K-fold����
opts = '-s 0 -t 2 -c 1 -g 0.25';    
nfold = 10;

%���ݴ���
[Data_Random Label_Random] = RandomData(Data, Label);

%FEASTѡ��20������ɢ�����ø߼���ɢ
[selectedIndices,~] = FeatureSelect( Data,Label,n,2);

%FEAST�������
[Data_Selected] =  DataSelect(Data,selectedIndices);

%�����Լ���FEAST�Ľ��
p = SignificanceTest(Data, Label);
%����FEAST���ѡ��Ҫ�õ�P
[Data_Selected_P] =  DataSelect_P(p,selectedIndices);

%FEAST�����Pֵ�ϲ����ֳ������ȼ�
First = [selectedIndices(1:FirstNumber), Data_Selected_P(1:FirstNumber)];
Second = [selectedIndices(FirstNumber+1:n), Data_Selected_P(FirstNumber+1:n)];
old = First;

%��FEAST�����£������ȼ���Pֵ�Ƚϣ����ڶ��ȼ���Pֵ�ȵ�һ�ȼ�PֵС�����滻������
% [Data, ~] = pretreatment(Data, Data)
%First�ɺ���ǰ
for x = FirstNumber:-1:1

    %Firstԭ��׼ȷ������
    [Data_First] =  DataSelect(Data,First(:,1));
    First_acc = libsvmtrain(Label, Data_First, sprintf('%s -v %d -q',opts,nfold));
  
    %Second��ǰ����
    Change_acc = zeros(SecondNumber,2);
    replace_i = 0;
    for y = 1:1:SecondNumber
        %���ڶ��ȼ���Pֵ�ȵ�һ�ȼ�PֵС�����滻������
        if First(x,2) > Second(y,2)
            replace_i = replace_i+1;
            %SVM��ּ��㣬���滻������滻ǰ�����滻
            [NewFirst NewSecond] = replace(First, x,Second, y);
            
            %�����滻��First��׼ȷ��
            [Data_Change] =  DataSelect(Data,NewFirst(:,1));
            Change_acc(replace_i, 1) = libsvmtrain(Label, Data_Change, sprintf('%s -v %d -q',opts,nfold));
            %��¼�¶�ӦSecond��λ��
            Change_acc(replace_i, 2) = y;
        end
    end 
    %ԭacc����acc�Ӹ�������ԭ��acc�Ƚ�
    Change_acc = sortrows(Change_acc,1);
    for k = SecondNumber:-1:1
        %һ������acc���ߣ����滻
        if Change_acc(k,1) > First_acc
            [First Second] = replace(First, x,Second, Change_acc(k,2));
            First_acc = Change_acc(k,1);
            c = 'change'
        end
    end 
        
a = '********'
end

[Data_First] =  DataSelect(Data,First(:,1));
First_acc = libsvmtrain(Label, Data_First, sprintf('%s -v %d -q',opts,nfold))

First - old

%��ֱ��FEAST�Ľ��һ��