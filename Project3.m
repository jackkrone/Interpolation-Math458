%{
    John Krone
    MATH 458 Fall 2019
    Project 3
    jkrone@usc.edu
%}
clear; clc;

%% Control point coordinates
% create cp coordinates
cp{1} = {[-4,2], [-5,0], [-3,-2.5]};
cp{2} = {[-1,1], [-1.5,0], [-2,-.5]};
cp{3} = {[1,1], [1.5,0], [2,-.5]};
cp{4} = {[4,2], [5,0], [3,-2.5]};

% organize x and y vals
for i = 1:4
    for j = 1:3
    cpx{i}(j) = cp{i}{j}(1);
    cpy{i}(j) = cp{i}{j}(2);
    end
end
    
%% Polynomial Interpolation of control points
% find coefficients
% note: I must switch x and y vals to get a perfect poly fit (error = 0)
for i = 1:4
    coef_PI{i} = polyfit(cpy{i},cpx{i}, 2);
end

% find interpolated values
% note backwards x and y vals still
y_vals = {[],[],[],[]};
x_vals = {[],[],[],[]};
for i = 1:4
    y_vals{i} = linspace(min(cpy{i}),max(cpy{i}));  
    x_vals{i} = polyval(coef_PI{i},y_vals{i});
end

% reorganize x_vals and y_vals to be used in animation
% first add the origin coordinates
y_vals = {y_vals{1:2}, zeros(1,100), y_vals{3:4}};
x_vals = {x_vals{1:2}, zeros(1,100), x_vals{3:4}};
% now "transpose" the cell array
for i = 1:100
    for j = 1:5
    x_reorg{i}(j) = x_vals{j}(i);
    y_reorg{i}(j) = y_vals{j}(i);
    end
end

% animate a figure
figure(1)
frames = [1:100,100:-1:2];
for j = 1:3
     for k = 1:198
         i = frames(k);
         XX = linspace(min(x_reorg{i}), max(x_reorg{i}));
         YY = spline(x_reorg{i}, [0 y_reorg{i} 0], XX);
         plot(XX,YY,'LineWidth',5)
         title("Bird in flight, animated with polynomial interpolation")
         xlim([-6,6])
         ylim([-6,6])
         pause(0.01)
     end
end


%% Cubic Spline Interpolation of control points
% find coefficients
% again switching x and y vals for the spline portion of the function
for i = 1:4
    splines{i} = spline(cpy{i},[0 cpx{i} 0]); % This is natural spline
    coefs_CS{i} = splines{i}.coefs;
end

% find interpolated values
% note backwards x and y vals still
y_vals = {[],[],[],[]};
x_vals = {[],[],[],[]};
for i = 1:4
y_vals{i} = linspace(min(cpy{i}),max(cpy{i}));
x_vals{i} = ppval(splines{i},y_vals{i});
end

% reorganize x_vals and y_vals to be used in animation
% first add the origin coordinates
y_vals = {y_vals{1:2}, zeros(1,100), y_vals{3:4}};
x_vals = {x_vals{1:2}, zeros(1,100), x_vals{3:4}};
% now "transpose" the cell array
for i = 1:100
    for j = 1:5
    x_reorg{i}(j) = x_vals{j}(i);
    y_reorg{i}(j) = y_vals{j}(i);
    end
end

% animate a figure
figure(2)
frames = [1:100,99:-1:2];
for j = 1:3
     for k = 1:198
         i = frames(k);
         XX = linspace(min(x_reorg{i}), max(x_reorg{i}));
         YY = spline(x_reorg{i}, [0 y_reorg{i} 0], XX);
         plot(XX,YY,'LineWidth',5)
         title("Bird in flight, animated with natural cubic spline interpolation")
         xlim([-6,6])
         ylim([-6,6])
         pause(0.01)
     end
end

%% Linear Spline Interpolation of control points
% No need to find coefficients this time
% again switching x and y vals for the spline portion of the function
% First reset x and y vals.
y_vals = {[],[],[],[]};
x_vals = {[],[],[],[]};
for i = 1:4
    y_vals{i} = linspace(min(cpy{i}),max(cpy{i}));
    x_vals{i} = interp1(cpy{i}, cpx{i}, y_vals{i}, 'linear');
end


% reorganize x_vals and y_vals to be used in animation
% first add the origin coordinates
y_vals = {y_vals{1:2}, zeros(1,100), y_vals{3:4}};
x_vals = {x_vals{1:2}, zeros(1,100), x_vals{3:4}};
% now "transpose" the cell array
for i = 1:100
    for j = 1:5
    x_reorg{i}(j) = x_vals{j}(i);
    y_reorg{i}(j) = y_vals{j}(i);
    end
end

% animate a figure
figure(2)
frames = [1:100,99:-1:2];
for j = 1:3
     for k = 1:198
         i = frames(k);
         XX = linspace(min(x_reorg{i}), max(x_reorg{i}));
         YY = spline(x_reorg{i}, [0 y_reorg{i} 0], XX);
         plot(XX,YY,'LineWidth',5)
         title("Bird in flight, animated with linear spline interpolation")
         xlim([-6,6])
         ylim([-6,6])
         pause(0.01)
     end
end

