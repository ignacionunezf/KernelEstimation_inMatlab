%Codes to estimate conditional mean with a normal kernel and cross-validation
%Ignacio Nunez, Economics Department, UT-Austin, Feb 27 2020

clear all;  close all;

filename = 'WAGE.xlsx';
sheet = 1;
xlRange = 'B3:Y528';
[data,text1,raw1] = xlsread(filename, sheet, xlRange);

% First, define sample 
global W ED EX G sample_size;
W = data(:,1);
ED = data(:,2);
EX = data(:,3);
G = data(:,6);

sample_size=size(W,1);

% I. Conditional expectation wage on education, Gaussian kernel

interval=[0:0.1:18];

% I use the leave-one out approach, as the sample size is not large

options = optimset('Display','final','TolFun',1e-8,'TolX',1e-4,'MaxIter',200000);
h =1.06*std(ED)*(sample_size^(-1/5)); % Starting Values
h_hat = fminsearch('MSE_1',h,options);
h = fminsearch('MSE_1',h_hat,options);

x = transpose(interval);

y = zeros(size(x,1),1); %conditional expectation
for i=1:size(x,1)
    denom = 0;
    for j=1:sample_size
            denom= denom+k_normal(x(i),ED(j),h);
    end
    for j=1:sample_size
            y(i)=y(i)+W(j)*k_normal(x(i),ED(j),h)/denom;
    end
end

figure
plot(x,y);
axis([0 18 0 15]);
xlabel('Education'); 
ylabel('Wage');
title('Conditional Expectation (Cross-validation, h=0.831266)');

% II. Conditional expectation wage on experience and gender, Gaussian kernel

interval=[0:0.1:55];


options = optimset('Display','final','TolFun',1e-8,'TolX',1e-4,'MaxIter',200000);
h =1.06*std(EX)*(sample_size^(-1/5)); % Starting Values
h_hat = fminsearch('MSE_2',h,options);
h = fminsearch('MSE_2',h_hat,options);

x = transpose(interval);

y1 = zeros(size(x,1),1); %conditional expectation for female
for i=1:size(x,1)
    denom = 0;
    for j=1:sample_size
        if G(j)==1
            denom= denom+k_normal(x(i),EX(j),h);
        end
    end
    for j=1:sample_size
        if G(j)==1
            y1(i)=y1(i)+W(j)*k_normal(x(i),EX(j),h)/denom;
        end
    end
end


y2 = zeros(size(x,1),1); %conditional expectation for male
for i=1:size(x,1)
    denom = 0;
    for j=1:sample_size
        if G(j)==0
            denom= denom+k_normal(x(i),EX(j),h);
        end
    end
    for j=1:sample_size
        if G(j)==0
            y2(i)=y2(i)+W(j)*k_normal(x(i),EX(j),h)/denom;
        end
    end
end

figure
plot(x,y1,x,y2);
axis([0 55 0 18]);
xlabel('Experience'); 
ylabel('Wage');
title('Conditional Expectation (Cross-validation, h=3.6025)');
legend('Female','Male')
