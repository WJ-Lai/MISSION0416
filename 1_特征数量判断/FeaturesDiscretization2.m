function [ DiscreteData ] = FeaturesDiscretization( Data )
%% ����������ɢ������ΪFEAST�㷨ɸѡָ����׼��
% ���룺ѵ��������
% �������ɢ�����ѵ���������Լ���ֵ
%% 
DiscreteNums = 20; 
PercGap = 100/DiscreteNums;
for i = 1:1:length(Data(1,:))  
    for j =1:1:DiscreteNums
        Threshold(i,j) = prctile(Data(:,i),j*PercGap);  %�ж������
    end
end

%��ɢ��
for i = 1:1:length(Data(:,1))  
    for j = 1:1:length(Data(1,:))  
        for k = 1:1:DiscreteNums  
            if k == 1
                if Data(i,j) <= Threshold(j,k)
                    DiscreteData(i,j) = k;
                end
            else
                if Data(i,j) > Threshold(j,k-1) && Data(i,j) <= Threshold(j,k)
                    DiscreteData(i,j) = k;
                end
            end
        end
    end
end
end

