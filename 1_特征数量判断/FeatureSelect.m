%����ѡ����
%����������ɢ����FEAST�㷨
%���룺���ݼ�,��������ɢ����
%�������ɢ�����ݼ���FEASTѡ�����������

function [selectedIndices,Data_discrete] = FeatureSelect( Data,label,n,a)

    if a == 1
        %��ͨ��ɢ
        [ Data_discrete ] = FeaturesDiscretization( Data );
    elseif a == 2
        %�������Ǹ߼���ɢ
        [ Data_discrete ] = FeaturesDiscretization2( Data );
    end
    %FEASTɸѡ��10������
    selectedIndices = feast('jmi',n,Data_discrete,label);


end