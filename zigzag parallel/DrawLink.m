function [D_link] = DrawLink(PositionNew, Space)
D_link = 0;  % 定义之字形连接线段距离
for i = 1:max(PositionNew(3, :)) - 1
    Pos_last = find(PositionNew(3, :) == i + 1);  % 获取下一层的索引
    Pos_now = find(PositionNew(3, :) == i);  % 获取当前层数的索引
    MIN = 3*Space;  % 定义距离
    if mod(i, 2)  % 奇数行
        Pos_line_x = [];
        Pos_line_y = [];
        for j = 2: 2: length(Pos_now)  % 当前层的偶数位置
            for k = 1:length(Pos_last)
                D = distance(PositionNew(1, Pos_now(:, j)), PositionNew(2, Pos_now(:, j)), PositionNew(1, Pos_last(:, k)), PositionNew(2, Pos_last(:, k)));
                if D <= MIN
                    D_link = D_link + D;
%                     MIN = D;
                    Pos_line_x = [Pos_line_x, PositionNew(1, Pos_now(:, j)), PositionNew(1, Pos_last(:, k))];
                    Pos_line_y = [Pos_line_y, PositionNew(2, Pos_now(:, j)), PositionNew(2, Pos_last(:, k))];
                end
            end
            if ~isempty(Pos_line_x) && ~isempty(Pos_line_y)
                plot(Pos_line_x(:, end-1:end), Pos_line_y(:, end-1:end), 'r-');
                hold on;
            end
        end
    end
    if ~mod(i, 2)  % 偶数行
        Pos_line_x = [];
        Pos_line_y = [];
        for j = 1: 2: length(Pos_now)  % 当前层的奇数位置
            for k = 1:length(Pos_last)
                D = distance(PositionNew(1, Pos_now(:, j)), PositionNew(2, Pos_now(:, j)), PositionNew(1, Pos_last(:, k)), PositionNew(2, Pos_last(:, k)));
                if D <= MIN
                    MIN = D;
                    Pos_line_x = [Pos_line_x, PositionNew(1, Pos_now(:, j)), PositionNew(1, Pos_last(:, k))];
                    Pos_line_y = [Pos_line_y, PositionNew(2, Pos_now(:, j)), PositionNew(2, Pos_last(:, k))];
                end
            end
            if ~isempty(Pos_line_x) && ~isempty(Pos_line_y)
                plot(Pos_line_x(:, end-1:end), Pos_line_y(:, end-1:end), 'r-');
                hold on;
            end
        end
    end
end
end

