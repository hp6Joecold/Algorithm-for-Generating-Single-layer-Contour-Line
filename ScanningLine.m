%% 扫描线拟合
%% 读取数据坐标点
tic;
Data = csvread('graph1.csv', 3, 0);
X = Data(:, 1);
Y = Data(:, 2);

%% 绘制边界
plot(X, Y, 'b-');
hold on;

%% 定义全局变量
global Space Indent
Space = 0.1;  % 指定扫描线间隔
Indent = 0.1;  % 指定前后缩进距离
%% 扫描线算法
[Position] = Scan(Data, Space);
[D_most] = Draw(Position, Data, Space, Indent);
%获取缩进后的坐标点
[OutPut] = NewPos(Position, Data, Space, Indent);
%绘制平行等距线
[D_link] = DrawLink(OutPut, Space);
hold on;
xlabel('X-axis');
ylabel('Y-axis');
title('Graphical of Equally Spaced Zigzag Parallel Lines');
toc;
%% 算法分析
%1.统计绘制线段层数
NUM_layers = max(OutPut(3, :));
%2.统计绘制线段数目
NUM = size(OutPut, 2) / 2;
%3.统计线段主体长度
Length_most = D_most - NUM*Indent*2;
%4.统计绘制线段总长
Length_all = Length_most + D_link;
%5.统计代码运行时间
disp(['运行时间: ',num2str(toc)]);