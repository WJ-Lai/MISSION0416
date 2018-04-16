%�������ǰ����ģʽ������������ͼ (RF)
%��ת��-11��-12
%ֱ�У�1,2
%��ת��11,12��13
function [result_patern patern_pro]  = SVMPatern(max_pro, patern)

    %�����ģʽ���£���תֱ����ת���ܸ���
    [m n] = size(max_pro);
    patern_pro = zeros(length(max_pro),3);
    if m == 1
       patern = patern';  
    end
    for i = 1:1:m
        for j = 1:1:n
            if patern(i,j) < 0
                patern_pro(i,1) = patern_pro(i,1) + max_pro(i,j);
            elseif patern(i,j) > 0 && patern(i,j) < 10
                patern_pro(i,2) = patern_pro(i,2) + max_pro(i,j);
            elseif patern(i,j) > 10
                patern_pro(i,3) = patern_pro(i,3)+ max_pro(i,j);
            end
        end
    end
    [a b] = max(patern_pro');
    b = b-2;
    %��������������ͼ:-1,0,1
    result_patern = b';
end