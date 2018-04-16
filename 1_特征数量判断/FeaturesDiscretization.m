%% ����������ɢ������ΪFEAST�㷨ɸѡָ����׼��
% ���룺ѵ��������
% �������ɢ�����ѵ��������

function [ Data_discrete ] = FeaturesDiscretization( Data )
    
    [Row,Column]=size(Data);
    %�ȷֳ�10��
    n = 10;
    %���ֵ
    A_max = max(Data);
    %��Сֵ
    A_min = min(Data);
    %ÿһ��֮����
    A = [(A_max-A_min)/n];
    %L��Ÿ���������10������ı߽�ֵ�������11���߽�ֵ
    L = zeros(10,Column);
    for i = 1:n+1
        L(i,:) = A_min+A*(i-1);
    end
    %ѵ��������ÿһ����Ϊһ�����������䣬����������һ�е����ֵ����Сֵ
    %Ȼ��ȷ�10�ݣ��ٿ���һ�е�ÿһ������������һ������

    boundary = zeros(10,Column);
    for i = 1:n
        boundary(i,:) = A_min+A*(i);
    end
    Data_discrete = zeros(Row,Column);
    for j = 1:Column
        for i = 1:min(size(Data))
            for k = 1:10
                %��һ������Ϊ������[],��������Ϊ���ұպϣ�]
                if boundary(k,j)>=Data(i,j)
                    Data_discrete(i,j) = k;    %�����ɢ����
                    break;
                end  
            end
        end
    end


end