%研究SVM改善过拟合
clc;clear;
load('Data_Selected.mat');

%设置参数
TexNnumber = 2;
K = 5;

c_ini = 0.5
c_finlVal = 10;
c_step = 0.5;
c_stepnubmer = round((c_finlVal-c_ini)/c_step + 1);
c = c_ini:c_step:c_finlVal;

g_ini = 0.5
g_finlVal = 10;
g_step = 0.5;
g_stepnubmer = round((g_finlVal-g_ini)/g_step + 1);
g = g_ini:g_step:g_finlVal;

nfold = 5;

%初始化矩阵
%存放每一大轮的准确率
Tradition = zeros(TexNnumber,c_stepnubmer);
%存放c和g变化时的准确率
OldAcc = zeros(c_stepnubmer,g_stepnubmer);

for t = 1:1:TexNnumber

    DataLabel = [Label Data_Selected];
    rowrank = randperm(size(DataLabel, 1)); 
    DataLabel_Random = DataLabel(rowrank,:);
    [m n] = size(Data_Selected);
    Label = DataLabel_Random(:,1);
    Data = DataLabel_Random(:,2:n+1);
        
    for i = 1:1:c_stepnubmer 
        for j = 1:1:g_stepnubmer 
            %自己写的交叉检验
            [AccuracySVM AccuracySVM_mean] = Kfold(K, Label, Data, c(1,i),g(1,j));
            OldAcc(i,j) = OldAcc(i,j) + AccuracySVM_mean;

            
            %libsvm自带的交叉检验
%             opts = ['-s 0 -t 2 -c ' num2str(c(1,i)) ' -g ' num2str(g(1,j))]
%             acc = libsvmtrain(Label,Data, sprintf('%s -v %d -q',opts,nfold))
%             OldAcc(i,j) = OldAcc(i,j) + acc;

        end
    end
    
    clear DataLabel;
    load('Data_Selected.mat');
end


%%
%绘图
OldAcc = OldAcc/TexNnumber;
figure()
[C2,h2] = contour(c,g,OldAcc);
clabel(C2,h2);
xlabel('惩罚系数c','fontsize',15)
ylabel('gamma系数','fontsize',15)
title('SVM参数寻优','fontsize',18);
