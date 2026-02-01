% % 读取数据
% data = readtable('solution_data.csv');
% 
% % 提取变量
% x = data.x; y = data.y; z = data.z;
% u = data.u; v = data.v; w = data.w;
% p = data.p;
% 
% % 已知 FreeFEM 中 nn = 13 → 节点数 N = nn + 1 = 14
% nn = 13;
% N = nn + 1;
% 
% % 验证数据长度
% if numel(x) ~= N^3
%     error('Number of points does not match (nn+1)^3. Check nn value.');
% end
% 
% % 重塑为 3D 数组 (x-fastest order)
% X = reshape(x, [N, N, N]);
% Y = reshape(y, [N, N, N]);
% Z = reshape(z, [N, N, N]);
% U = reshape(u, [N, N, N]);
% V = reshape(v, [N, N, N]);
% W = reshape(w, [N, N, N]);
% P = reshape(p, [N, N, N]);
% 
% % 绘图：显示三个速度分量在前面 (z=0) 的分布
% figure;
% colormap(jet);
% 
% for i = 1:4
%     subplot(1, 4, i);
%     
%     switch i
%         case 1
%             F = U; title_str = '(a) u_1 solution';
%         case 2
%             F = V; title_str = '(b) u_2 solution';
%         case 3
%             F = W; title_str = '(c) u_3 solution';
%         case 4
%             F = P; title_str = '(d) p solution';
%     end
%     
%     % 绘制 z = 0 的面（第一个 z 层）
%     surf(X(:,:,1), Y(:,:,1), Z(:,:,1), F(:,:,1), 'EdgeColor', 'none');
%     shading interp;
%     camlight; lighting gouraud;
%     view(3);
%     axis equal tight;
%     
%     % 添加缩短的colorbar
%     h = colorbar;
%     
%     % 获取当前坐标轴位置
%     pos_ax = get(gca, 'Position');
%     
%     % 计算缩短后的colorbar位置
%     cbar_pos = get(h, 'Position');
%     
%     % 保持colorbar的宽度和水平位置，将高度减半
%     cbar_height = cbar_pos(4) * 0.5;  % 高度减半
%     cbar_bottom = cbar_pos(2) + cbar_pos(4) * 0.25;  % 垂直居中
%     
%     % 设置新的colorbar位置
%     set(h, 'Position', [cbar_pos(1), cbar_bottom, cbar_pos(3), cbar_height]);
%     
%     title(title_str);
% end

% 读取数据
data = readtable('solution_data.csv');

% 提取变量
x = data.x; y = data.y; z = data.z;
u = data.u; v = data.v; w = data.w;
p = data.p;

% 已知 FreeFEM 中 nn = 13 → 节点数 N = nn + 1 = 14
nn = 13;
N = nn + 1;

% 验证数据长度
if numel(x) ~= N^3
    error('Number of points does not match (nn+1)^3. Check nn value.');
end

% 重塑为 3D 数组 (x-fastest order)
X = reshape(x, [N, N, N]);
Y = reshape(y, [N, N, N]);
Z = reshape(z, [N, N, N]);
U = reshape(u, [N, N, N]);
V = reshape(v, [N, N, N]);
W = reshape(w, [N, N, N]);
P = reshape(p, [N, N, N]);

% 创建四个独立的图形窗口
figure_list = {'u_1 solution,z=0', 'u_2 solution,z=0', 'u_3 solution,z=0', 'pressure'};
data_list = {U, V, W, P};
z_level = 1; % 绘制z=0平面（对应第一层）

for i = 1:4
    % 创建新图形窗口
    figure('Position', [50+300*(i-1), 100, 400, 300]);
    
    % 获取当前数据
    F = data_list{i};
    title_str = figure_list{i};
    
    % 绘制 z = 0 的面（第一个 z 层）
    surf(X(:,:,z_level), Y(:,:,z_level), Z(:,:,z_level), F(:,:,z_level), 'EdgeColor', 'none');
    shading interp;
    camlight; 
    lighting gouraud;
    view(3);
    axis equal tight;
    
    % 添加缩短的colorbar
    h = colorbar;
    
    % 获取当前坐标轴位置
    pos_ax = get(gca, 'Position');
    
    % 计算缩短后的colorbar位置
    cbar_pos = get(h, 'Position');
    
    % 保持colorbar的宽度和水平位置，将高度减半
    cbar_height = cbar_pos(4) * 0.5;  % 高度减半
    cbar_bottom = cbar_pos(2) + cbar_pos(4) * 0.25;  % 垂直居中
    
    % 设置新的colorbar位置
    set(h, 'Position', [cbar_pos(1), cbar_bottom, cbar_pos(3), cbar_height]);
    
    % 设置标题
    title(title_str, 'FontSize', 12, 'FontWeight', 'bold');
    
    % 添加坐标轴标签
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    
    % 添加网格
    grid on;
    
    % 设置图形颜色映射
    colormap(jet);
end