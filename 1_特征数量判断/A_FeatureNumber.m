%����100�εõ��������ѡ�����
%caluateΪ���������nΪ��������,
clear;clc;

%��ʱ
tic; 
%���ò���
caluate = 1;    %�������
n = 63;         %FEAST������
d = 1;         %��ɢ�����ࣺ1����ͨ��ɢ��2���߼���ɢ
kfold = 5;          %kfold��k

%libsvm�Դ���kfold
opts = '-s 0 -t 2 -c 1 -g 0.25';  
nfold = 10;
%�Լ�д�ĵ�kfoldSVM����
c = 2;
g = 0.01;

%ÿһ��ÿһ�������׼ȷ�ʴ���accuracy�У����ȡƽ��ֵ
SVMaccuracy = zeros(caluate,n);
for k = 1:caluate

        %����ɸѡ20��
        load('CollectedFeatures.mat');
        load('CollectedLabels.mat');
        Data = CollectedFeatures;
        Label = CollectedLabels;
        
%         load('DataExcept2.mat')        
%          load('EyeDatabase.mat')
        [Row Column] = size(Data);

        
        %����ѡ��
        [selectedIndices,Data_discrete] = FeatureSelect( Data,Label,n,d);

        %�γ�����ɸѡ���µ����ݼ�(���������ݣ���label)
        Data_Selected = zeros(Row,n);

        for i= 1:1:n
           %�������ں���
            Data_Selected(:,i) = [Data(:,selectedIndices(i))];
        end

       %%
        %ȷ����������

        %random���ݣ���label�������Լ�д��kfoldʱ����Ҫ����˳��
%         DataLabel = [Label Data_Selected];
%         rowrank = randperm(size(DataLabel, 1)); 
%         DataLabel_Random = DataLabel(rowrank,:);
% 
%         Label_Random = DataLabel_Random(:,1);
%         Data_Random = DataLabel_Random(:,2:n+1);

        %��libsvm�Դ���kfoldʱ�������ֶ�����˳��
        Label_Random = Label ;
        Data_Random = Data;

        %���й�һ��
%         Data_Random = mapminmax(Data_Random', 0, 1)';

       %%
        %�������ֱ��2��n
        for i = n:-1:1

            %ȡǰn������
            KfoldData = Data_Random(:,1:i);
            KfoldLabel = Label_Random;
            
            %�Լ�д��kfold
            [AccuracySVM AccuracySVM_mean] = Kfold(kfold , KfoldLabel, KfoldData, c,g)
            SVMaccuracy(k,i) = AccuracySVM_mean;
%             libsvm�Դ���svm
%             acc = libsvmtrain(KfoldLabel,  KfoldData, sprintf('%s -v %d -q',opts,nfold))
%             SVMaccuracy(k,i) = acc;
        end

end

%Ϊ�˻�ͼ����Ҫת��
SVMaccuracy_mean = mean(SVMaccuracy);
SVMaccuracy_mean = SVMaccuracy_mean';


%����ͼ��n-accuracy
figure()
P =plot(SVMaccuracy_mean(:,1),'-^','Linewidth',2.5)

xlabel('��������','fontsize',15)
set(gca,'xtick',[1:1:n])
set(gca,'xticklabel',[1:1:n])
set(gca,'XtickLabel',{'','2','','4','','6','','8','','10',...
    '', '12','','14','','16','','18','','20'})
ylabel('׼ȷ��','fontsize',15)
title('����������׼ȷ�ʹ�ϵͼ','fontsize',18);
legend('SVM');
hold on 
toc;
