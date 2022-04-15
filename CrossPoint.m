function  [X, Y] = CrossPoint(x_vectors, y_vectors)
%x_vectors和y_vectors为输入的待判断四个坐标点的横纵坐标均为列向量
%求两条直线的交点坐标
if x_vectors(1, :) ~= x_vectors(2, :) && x_vectors(3, :) ~= x_vectors(4, :)
    p1 = polyfit(x_vectors(1:2, :), y_vectors(1:2, :), 1);
    p2 = polyfit(x_vectors(3:4, :), y_vectors(3:4, :), 1);
    %计算一元函数的零点
    x_intersect = fzero(@(x) polyval(p1-p2, x), 3);
    y_intersect = polyval(p1, x_intersect);
elseif x_vectors(1, :) ~= x_vectors(2, :) && x_vectors(3, :) == x_vectors(4, :)
    p1 = polyfit(x_vectors(1:2, :), y_vectors(1:2, :), 1);
    x_intersect = x_vectors(3, :);
    y_intersect = polyval(p1, x_intersect);
elseif x_vectors(1, :) == x_vectors(2, :) && x_vectors(3, :) ~= x_vectors(4, :)
    p2 = polyfit(x_vectors(3:4, :), y_vectors(3:4, :), 1);
    x_intersect = x_vectors(1, :);
    y_intersect = polyval(p2, x_intersect);
end
%判断交点是否在线段上
if (x_intersect >= min(x_vectors(1:2, :)) && x_intersect <= max(x_vectors(1:2, :)) && y_intersect >= min(y_vectors(1:2, :)) && y_intersect <= max(y_vectors(1:2, :))) && (x_intersect >= min(x_vectors(3:4, :)) && x_intersect <= max(x_vectors(3:4, :)) && y_intersect >= min(y_vectors(3:4, :)) && y_intersect <= max(y_vectors(3:4, :)))
    X = x_intersect;
    Y = y_intersect;
else
    X = [];
    Y = [];
end
end