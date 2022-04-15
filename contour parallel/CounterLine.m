%% 轮廓线拟合
%% 读取数据坐标点
Data = csvread('graph1.csv', 3, 0);
X = Data(:, 1);
Y = Data(:, 2);

Data = [-2,2; 2,2; 2,-2; -2,-2; -1,1; -2,2];
%Data = [-1,0; 0,2; 3,2; 3,0; -1,0];
%% 全局定义变量
global D delta step
D = 0.4;  % 定义轮廓线之间的间隔距离
delta = 10^-4;  % 定义浮点数计算误差
step = 10^-4;  % 定义法线向量的递进步
%% 轮廓线拟合算法
figure(1);
plot(Data(:, 1), Data(:, 2));
hold on;
for i = 1:2  % 指定循环次数
    %获取法向量方向的新轮廓坐标点
    NewPosition = CounterPosition(Data, D, delta, step);
    %判断拟轮廓是否相交
    %首先每次生成拟轮廓顶点时判断线段是否相交(自相交)
    NewPosition = JudgeSelf(NewPosition);
%     %其次判断生成拟轮廓与外圈是否相交(异相交)
%     NewPosition = JudegOther(Data, NewPosition);
    %绘制新轮廓
    plot(NewPosition(:, 1), NewPosition(:, 2));
    hold on;
    %外边界轮廓迭代
    Data = NewPosition;
end
