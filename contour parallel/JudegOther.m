function [NewPosition] = JudegOther(Data, NewPosition)
%其次判断生成拟轮廓与外圈是否相交(异相交)
poly1 = polyshape(Data(:, 1)', Data(:, 2)');
poly2 = polyshape(NewPosition(:, 1)', NewPosition(:, 2)');
polyout = intersect(poly1,poly2);  % 获取多边形相交部分且保留原始顺序
Diff = setdiff(polyout.Vertices, poly2.Vertices, 'stable', 'rows');  % 获取多边形相差部分且保留原始顺序
% if ~isequal(poly2.Vertices, polyout.Vertices)  % 判断存在异相交
%     %保留上层轮廓和本层轮廓的相交部分
%     NewPosition = [];  % 声明新轮廓边界坐标矩阵
%     ResultPostion = [];  % 声明结果位置
%     ResultPostion = setdiff(polyout.Vertices, Diff, 'stable', 'rows');
%     
%     NewPosition(:, 1) = ResultPostion(:, 1);
%     NewPosition(:, 2) = ResultPostion(:, 2);
%     NewPosition = [NewPosition; ResultPostion(1, :)];
% end
end
