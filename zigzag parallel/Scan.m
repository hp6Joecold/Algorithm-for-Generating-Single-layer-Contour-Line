%% 输出Postion为扫描区间，Data为输入多边形顶点, Space为扫描线段间隔距离
function [Position]=Scan(Data, Space)
global Difference
Difference = 10^-4;
L = length(Data);  % 定义循环长度
X=Data(:, 1);
Y=Data(:, 2);
Y_MIN=min(Y);
Y_MAX=max(Y);
%% 判断相邻两条线段斜率是否相同, 若相同则删除中间点
%计算相邻顶点之间的斜率
K = [];
for n1 = 1:L - 1  % 计算斜率
    if n1~= L - 1
        n2 = n1+1;
    else
        n2 = 1;
    end
    Ki = (Y(n1) - Y(n2)) / (X(n1) - X(n2));
    K = [K; Ki];
end
%判断向量顶点线段斜率是否相同
DeletePoint=[]; 
for n1 = 1:L - 1
     if n1 ~= L - 1
        n2 = n1+1;
    else
        n2 = 1;
     end
    if K(n1) == K(n2)
       DeletePoint=[DeletePoint, n1];
    end
end
X(DeletePoint+1, :)=[];
Y(DeletePoint+1, :)=[];
K(DeletePoint+1, :)=[];
%% 扫描线算法
%%开始扫描线
Position=[];  %  保存交点坐标
num = 1;
for yi = Y_MIN:Space:Y_MAX
    Positioni=[];   %用于记录每行交点
    for n1 = 1:L - 1
        %n0-n1为上一条线段
        if n1 ~= 1
            n0 = n1 - 1;
        else
            n0 = L - 1;
        end
        %n1-n2为当前线段
        if n1 ~= L - 1
            n2 = n1 + 1;
        else
            n2 = 1;
        end
        %n2-n3为下一条线段
        if n2 ~= L - 1
            n3 = n2 + 1;
        else
            n3 = 1;
        end
        %计算交点坐标
        xi=[];   %初始无交点
        if abs(abs(Y(n1) - yi) + abs(Y(n2) - yi) - abs(Y(n1) - Y(n2))) <= Difference  % 则存在交点
            if (X(n1) - X(n2)) ~= 0 && (Y(n1) - Y(n2)) ~= 0  % 判断该线段是斜线
                Ki = (Y(n1) - Y(n2)) / (X(n1) - X(n2));
                xi = (yi - Y(n2)) / Ki + X(n2);
                p = [xi; yi];  % 交点坐标
            elseif (X(n1) - X(n2)) == 0  % 判断该线段是竖直线
                xi = X(n1);
                p = [xi; yi];
            elseif (Y(n1) - Y(n2)) == 0  % 判断该线段是水平线
                xi = X(n1);
                p1 = [X(n1); yi];
                p2 = [X(n2); yi];
            end
        end
        %判断一次扫描线得到的坐标是否记录
        if isempty(xi) == 0  % 如果存在xi, 即存在交点
            if sum(Y(find(X == xi)) == yi) == 0   % 判断非多边形顶点
                Positioni = [Positioni, p];  % 直接记录
            else  %判断是多边形顶点
                if  sign(Y(n1) - Y(n2)) == 0  % 该条线是水平线
                    if (sign(Y(n0) - Y(n1)) + sign(Y(n2) - Y(n3))) == 0  % 前后线段水平或斜率相反
                        Positioni = [Positioni, p1, p2];  % 记录前后交点
                    end
                    if sign(Y(n0) - Y(n1)) > 0 && sign(Y(n2) - Y(n3)) > 0  % 前后线段均为正斜率
                        Positioni = [Positioni, p1];  % 记录前交点
                    end
                    if sign(Y(n0) - Y(n1)) < 0 && sign(Y(n2) - Y(n3)) < 0  % 前后线段均为负斜率
                        Positioni = [Positioni, p2];  % 记录后交点
                    end
                elseif   xi == X(n2)  % 如果不是水平线则记录后交点
                    if  (sign(Y(n1) - Y(n2)) + sign(Y(n2) - Y(n3))) == 0  % 前后线段斜率相反
                        Positioni = [Positioni, p, p];  % 记录两次极大极小值
                    else
                        if sign(Y(n2)-Y(n3)) ~= 0  % 下一条如果是横线则不记录
                           Positioni = [Positioni, p];
                        end
                    end
                end
            end
        end
    end
    Positioni = sort(Positioni, 2);  %按从小到大排列
    Positioni = [Positioni; num*ones(1, size(Positioni, 2))];
    num = num + 1;
    Position = [Position, Positioni];
end