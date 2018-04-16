%计算100次得到最佳特征选择个数
%caluate为计算次数，n为特征个数,
clear;clc;

%计时
tic; 
%设置参数
caluate = 1;    %计算次数
n = 63;         %FEAST最大个数
d = 1;         %离散化种类：1：普通离散，2：高级离散
kfold = 5;          %kfold的k

%libsvm自带的kfold
opts = '-s 0 -t 2 -c 1 -g 0.25';  
nfold = 10;
%自己写的的kfoldSVM参数
c = 2;
g = 0.01;

%每一次每一个情况的准确率存入accuracy中，最后取平均值
SVMaccuracy = zeros(caluate,n);
for k = 1:caluate

        %特征筛选20个
        load('CollectedFeatures.mat');
        load('CollectedLabels.mat');
        Data = CollectedFeatures;
        Label = CollectedLabels;
        
%         load('DataExcept2.mat')        
%          load('EyeDatabase.mat')
        [Row Column] = size(Data);

        
        %特征选择
        [selectedIndices,Data_discrete] = FeatureSelect( Data,Label,n,d);

        %形成特征筛选后新的数据集(仅仅有数据，无label)
        Data_Selected = zeros(Row,n);

        for i= 1:1:n
           %特征放在后面
            Data_Selected(:,i) = [Data(:,selectedIndices(i))];
        end

       %%
        %确定特征个数

        %random数据（与label）若用自己写的kfold时，需要打乱顺序
%         DataLabel = [Label Data_Selected];
%         rowrank = randperm(size(DataLabel, 1)); 
%         DataLabel_Random = DataLabel(rowrank,:);
% 
%         Label_Random = DataLabel_Random(:,1);
%         Data_Random = DataLabel_Random(:,2:n+1);

        %用libsvm自带的kfold时，不用手动打乱顺序
        Label_Random = Label ;
        Data_Random = Data;

        %按列归一化
%         Data_Random = mapminmax(Data_Random', 0, 1)';

       %%
        %特征数分别从2到n
        for i = n:-1:1

            %取前n个特征
            KfoldData = Data_Random(:,1:i);
            KfoldLabel = Label_Random;
            
            %自己写的kfold
            [AccuracySVM AccuracySVM_mean] = Kfold(kfold , KfoldLabel, KfoldData, c,g)
            SVMaccuracy(k,i) = AccuracySVM_mean;
%             libsvm自带的svm
%             acc = libsvmtrain(KfoldLabel,  KfoldData, sprintf('%s -v %d -q',opts,nfold))
%             SVMaccuracy(k,i) = acc;
        end

end

%为了绘图，需要转置
SVMaccuracy_mean = mean(SVMaccuracy);
SVMaccuracy_mean = SVMaccuracy_mean';


%绘制图标n-accuracy
figure()
P =plot(SVMaccuracy_mean(:,1),'-^','Linewidth',2.5)

xlabel('特征个数','fontsize',15)
set(gca,'xtick',[1:1:n])
set(gca,'xticklabel',[1:1:n])
set(gca,'XtickLabel',{'','2','','4','','6','','8','','10',...
    '', '12','','14','','16','','18','','20'})
ylabel('准确率','fontsize',15)
title('特征个数与准确率关系图','fontsize',18);
legend('SVM');
hold on 
toc;
