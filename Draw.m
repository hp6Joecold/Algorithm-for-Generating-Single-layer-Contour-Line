%%画出扫描区间结果
function [D_most] = Draw(Position, Data, Space, Indent)  % Indent为扫描线段缩进距离
global Difference
Difference = 10^-4;
D_most = 0;  % 定义绘制的平行线主体距离

X=Data(:, 1);
Y=Data(:, 2);
Y_MIN = min(Y);
Y_MAX = max(Y);

patch(X,Y,[1 1 1])
hold on;
for yi=Y_MIN:Space:Y_MAX
    PositionXi = Position(1, find(abs(Position(2, :) - yi) < Difference));  % 从交点坐标矩阵中确定X
    PositionYi = ones(1, size(PositionXi, 2))*yi;  % 从交点坐标矩阵中确定Y
    Positon_i = [PositionXi; PositionYi];
    if  isempty(Positon_i) == 0
        for i = 1:2:(size(Positon_i, 2) - 1)  % 每条扫描线的交点为偶数个
            j = i + 1;
            D_most = D_most + distance(Positon_i(1, i), Positon_i(2, i), Positon_i(1, j), Positon_i(2, j));
            hold on;
            %判断经过缩进后点在多边形内且不为极值点
            if inpolygon(Positon_i(1, i) + Indent, Positon_i(2, i), Data(:, 1), Data(:, 2)) && inpolygon(Positon_i(1, j) - Indent, Positon_i(2, j), Data(:, 1), Data(:, 2))
                if Positon_i(1, i) ~= Positon_i(1, j)
                    plot([Positon_i(1, i) + Indent, Positon_i(1, j) - Indent], [Positon_i(2, i), Positon_i(2, j)], 'r-');
%                     D_most = D_most + distance(Positon_i(1, i) + Indent, Positon_i(2, i), Positon_i(1, j) - Indent, Positon_i(2, j));
                    hold on;
                end
            end
        end
    end
end
axis equal
axis([0, max(X), 0, max(Y)]);