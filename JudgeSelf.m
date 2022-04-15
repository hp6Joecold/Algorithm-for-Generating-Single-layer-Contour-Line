function [Output] = JudgeSelf(NewPosition)
%% 判断拟轮廓是否相交
%首先每次生成拟轮廓顶点时判断线段是否相交(自相交)
Range = [];  % 定义记录四个点坐标的索引
Output = NewPosition;  % 定义输出结果
if length(NewPosition) >= 4
    for i = 3:(length(NewPosition) - 1)
        for j = 1:i - 2
            x_vectors = NewPosition([i + 1, i, j + 1, j], 1);
            y_vectors = NewPosition([i + 1, i, j + 1, j], 2);           
            Range = [i + 1, i, j + 1, j];
            [X, Y] = CrossPoint(x_vectors, y_vectors);  % 判断线段是否自相交
            %裁剪线段相交部分
            %%%%%%%%%%%%%%%%%%%%%%%%%%%
            temp1 = find((x_vectors == X));  % 判断是否是端点
            temp2 = find((y_vectors == Y));
            temp = temp1 + temp2;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%
            if ~isempty(X) && ~isempty(Y) && temp ~= 2
                %裁剪
                Output(Range(1), 1) = X;
                Output(Range(4), 1) = X;
                Output(Range(1), 2) = Y;
                Output(Range(4), 2) = Y;
                
                Output(1:Range(4), :) = [];
                Output(Range(1) + 1:end, :) = [];
                Output(end, :) = Output(1, :);
            end
        end
    end
end
%     if i == length(NewPosition) - 2  % 非首尾线段判断是否相交
%         x_vectors = NewPosition([i: i + 1, 1, 2], 1);
%         y_vectors =NewPosition([i: i + 1, 1, 2], 2);
%         Range = [i: i + 1, 1, 2];
%     elseif i == length(NewPosition) - 1  % 首尾线段判断是否相交
%         x_vectors = NewPosition([i: i + 1, 2, 3], 1);
%         y_vectors =NewPosition([i: i + 1, 2, 3], 2);
%         Range = [i: i + 1, 2, 3];
%     else
%         x_vectors = NewPosition(i: i + 3, 1);
%         y_vectors = NewPosition(i: i + 3, 2);
%         Range = [i: i + 3];
%     end
end
