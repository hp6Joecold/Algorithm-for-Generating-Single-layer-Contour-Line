%%画出扫描区间结果
function [OutPut] = NewPos(Position, Data, Space, Indent)  % Indent为扫描线段缩进距离
global Difference
Difference = 10^-4;
OutPut = [];
X=Data(:, 1);
Y=Data(:, 2);
Y_MIN = min(Y);
Y_MAX = max(Y);

for yi=Y_MIN:Space:Y_MAX
    PositionXi = Position(1, find(abs(Position(2, :) - yi) < Difference));  % 从交点坐标矩阵中确定X
    PositionYi = ones(1, size(PositionXi, 2))*yi;  % 从交点坐标矩阵中确定Y
    Positon_i = [PositionXi; PositionYi];
    if  isempty(Positon_i) == 0
        for i = 1:2:(size(Positon_i, 2) - 1)  % 每条扫描线的交点为偶数个
            j = i + 1;
            %判断经过缩进后点在多边形内且不为极值点
            if inpolygon(Positon_i(1, i) + Indent, Positon_i(2, i), Data(:, 1), Data(:, 2)) && inpolygon(Positon_i(1, j) - Indent, Positon_i(2, j), Data(:, 1), Data(:, 2))
                if Positon_i(1, i) ~= Positon_i(1, j)
                    temp = [[Positon_i(1, i) + Indent, Positon_i(1, j) - Indent]; [Positon_i(2, i), Positon_i(2, j)]];
                    OutPut = [OutPut, temp];
                else
                    temp = [[Positon_i(1, i), Positon_i(1, j)]; [Positon_i(2, i), Positon_i(2, j)]];
                    OutPut = [OutPut, temp];
                end
            else
                temp = [[Positon_i(1, i), Positon_i(1, j)]; [Positon_i(2, i), Positon_i(2, j)]];
                OutPut = [OutPut, temp];
            end
        end
    end
end
OutPut = [OutPut; Position(3, :)];
end