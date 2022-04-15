%% 计算下一层轮廓的各个顶点位置
function [NewPosition] = CounterPosition(Data, D, delta, step)
global MIN MAX
MIN = -10^3;
MAX = 10^3;
NewPosition = [];  % 定义存放新轮廓的坐标值
%计算角平分线
for i = 1: length(Data) - 1
    if i == 1
        x_pre = Data(length(Data) - 1, 1);
        y_pre = Data(length(Data) - 1, 2);
        x_now = Data(i, 1);
        y_now = Data(i, 2);
        x_last = Data(i + 1, 1);
        y_last = Data(i + 1, 2);
    elseif i == length(Data) - 1
        x_pre = Data(i - 1, 1);
        y_pre = Data(i - 1, 2);
        x_now = Data(length(Data) - 1, 1);
        y_now = Data(length(Data) - 1, 2);
        x_last = Data(1, 1);
        y_last = Data(1, 2);
    else
        x_pre = Data(i - 1, 1);
        y_pre = Data(i - 1, 2);
        x_now = Data(i, 1);
        y_now = Data(i, 2);
        x_last = Data(i + 1, 1);
        y_last = Data(i + 1, 2);
    end
    %计算每三个相邻散点的角平分线的直线方程及其法线方向
    [k, b] = AngleBisector(x_pre, y_pre, x_now, y_now, x_last, y_last);
    Apart = 0;  % 定义初始距离为零
    x_new = x_now;
    y_new = y_now;
    %根据当前计算点所处像元分类计算
    if ~isnan(k)  % 判断直线方程不为竖直线
        if k < 0 && k > MIN
            dir = step;
            x_new = x_new + dir;
            y_new = k*x_new + b;
            [in, on] = inpolygon(x_new, y_new,Data(:, 1), Data(:, 2));
            if in + on == 0
                dir = -dir;
                x_new = x_new + dir;
                y_new = k*x_new + b;
            end
            while (Apart - D) <= delta
                Apart = distance(x_now, y_now, x_new, y_new);
                x_new = x_new + dir;
                y_new = k*x_new + b;
            end
        end
        
        if k >= 0
            dir = step;
            x_new = x_new + dir;
            y_new = k*x_new + b;
            [in, on] = inpolygon(x_new, y_new, Data(:, 1), Data(:, 2));
            if in + on == 0
                dir = -dir;
                x_new = x_new + dir;
                y_new = k*x_new + b;
            end
            while (Apart - D) <= delta
                Apart = distance(x_now, y_now, x_new, y_new);
                x_new = x_new + dir;
                y_new = k*x_new + b;
            end            
        end
        
        if k <= MIN  % 表示水平
            dir = step;
            x_new = x_new;
            y_new = y_new + dir;
            [in, on] = inpolygon(x_new, y_new, Data(:, 1), Data(:, 2));
            if in + on == 0
                dir = -dir;
                x_new = x_new;
                y_new = y_new + dir;
            end
            while (Apart - D) <= delta
                Apart = distance(x_now, y_now, x_new, y_new);
                x_new = x_new + dir;
                y_new = k*x_new + b;
            end
        end
    end
    NewPosition(i, 1) = x_new;
    NewPosition(i, 2) = y_new;
end
NewPosition = [NewPosition; NewPosition(1,:)];
end
