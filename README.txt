一：
第一个文件夹内运行：A_FeatureNumber.m
设置参数那里可以选择实验次数、FEAST需要的个数、离散的类型、Kfold
也可以用libsvm自带的交叉检验

二：
第二个文件夹内运行：B_Data_Selected.m
设置参数那里设置特征选择的个数和对应编号，如果需要归一化，去掉下面的注释
代码运行结束后，会生成Data_Selected.mat
将这个文件粘贴到第三个文件夹内


三：
第三个文件夹内运行：BestCG.m
可以自己设置c,g范围，试验次数
也可以用libsvm自带的交叉检验



实验数据pic内时昨晚的一些过程性数据


无label2是去除label2的程序