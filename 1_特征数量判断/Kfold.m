%实现SVMKfold

function [AccuracySVM AccuracySVM_mean] = Kfold(k, Label, Data, c,g)

    [m n] = size(Data);
    
    %划分为k组
    number = fix(m/k);      %每组数量number
    SplitData = cell(2,k);
    for i = 0:1:k-1
        SplitData{1,i+1} = Data(1+i*number:number+i*number,:);
        SplitData{2,i+1} = Label(1+i*number:number+i*number,:);
        if i == k-1
            SplitData{1,i+1} = Data(1+i*number:m,:);
            SplitData{2,i+1} = Label(1+i*number:m,:);
        end
    end
    
    %轮流充当train和text组
    AccuracySVM = zeros(1,k);%存放每次的准确率

    for i = 1:1:k
        test_label = SplitData{2,i};
        test_data = SplitData{1,i};
        
        train_label = [];
        train_data = [];
        
        for j = 1:1:k
            if j ~= i
                train_label = [train_label; SplitData{2,j}];
                train_data = [train_data; SplitData{1,j}];
            end
        end
    
    option = ['-c ',num2str(c),' -g ',num2str(g),' -b 1'];
    model = libsvmtrain(train_label ,train_data , option);
    [predict_label, accuracy, score]  = libsvmpredict(test_label, test_data , model, '-b 1'); 
    AccuracySVM(1,i) = accuracy(1,1);
    
    end
    
    
    AccuracySVM_mean  = mean(AccuracySVM);

end