% *************************************************************************
% 项目: mesh绘图自适应colormap
% 版本: v1.0
% 创建日期: 2024/04/13
% 作者: [Seaton]
% 描述: 此脚本用于对数据分布不均匀的图像进行自适应colormap绘图。
% *************************************************************************
clear; clc; close all;

% 加载.mat文件并提取数据
data = load('test_mat.mat'); % 确保.mat文件名与此处匹配
zernikeData = data.zernikeResult; % 提取数据到变量zernikeData

% 消去数据中的NaN值
validIndices = ~isnan(zernikeData);
cleanedData = zernikeData(validIndices);

% 对数据进行排序
sortedCleanedData = sort(cleanedData);

% 计算最小值和最大值
minValue = min(zernikeData(:));
maxValue = max(zernikeData(:));

% 计算分位数的位置
percentileStep = size(cleanedData, 1) / 5;
percentileIndex = fix(percentileStep);

% 提取分位数
v1 = sortedCleanedData(percentileIndex);
v2 = sortedCleanedData(percentileIndex * 2);
v3 = sortedCleanedData(percentileIndex * 3);
v4 = sortedCleanedData(percentileIndex * 4);

% 定义颜色映射的值范围
valRange = [minValue, v1, v2, v3, v4, maxValue];

% 定义颜色映射
colorMapVals = [
    10/255,  10/255, 255/255; % 深蓝
    0/255, 110/255, 193/255; % 浅蓝
    10/255, 255/255,  6/255; % 绿
    255/255, 255/255,  0/255; % 黄
    255/255,  34/255,  34/255; % 深红
    255/255, 117/255, 117/255; % 浅红
    ];

% 创建自定义颜色图
customColormap = interp1(valRange, colorMapVals, linspace(min(valRange), max(valRange), 256));

% 绘制3D表面图
mesh(zernikeData);
colormap(customColormap);
colorbar;

% 添加标题
title('Zernike Result Surface Plot');
xlabel('X Axis');
ylabel('Y Axis');
zlabel('Z Axis');
