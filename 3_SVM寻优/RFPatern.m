%�������ǰ����ģʽ������������ͼ (RF)
%��ת��-11��-12
%ֱ�У�1,2
%��ת��11,12��13
function [result_patern patern_pro]  = RFPatern(max_pro, patern, n)

    %�����ģʽ���£���תֱ����ת���ܸ���
    patern_pro = zeros(length(max_pro),n);
    
    for i = 1:length(max_pro)
        for j = 1:n
            if str2double(patern{i,j}) < 0
                patern_pro(i,1) = patern_pro(i,1) + max_pro(i,j);
            elseif str2double(patern{i,j}) > 0 && str2double(patern{i,j}) < 10
                patern_pro(i,2) = patern_pro(i,2) + max_pro(i,j);
            elseif str2double(patern{i,j}) > 10
                patern_pro(i,3) = patern_pro(i,3)+ max_pro(i,j);
            end
        end
        [a b] = max(patern_pro');
        b = b-2;
        %��������������ͼ:-1,0,1
        result_patern = b';
        
    end
end