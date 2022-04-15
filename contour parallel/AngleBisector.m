function [k, b] = AngleBisector(x_pre, y_pre, x_now, y_now, x_last, y_last)
%获取三个顶点的坐标点
L0 = [x_pre, y_pre];
L1 = [x_now, y_now];
L2 = [x_last, y_last];
%计算得到角平分线的斜率
angle_BA = angle_x(L1, L0);
angle_BC = angle_x(L1, L2);
%计算角平分线方程参数
k = tan((angle_BA + angle_BC) / 2);
b = y_now - k*x_now;
end
