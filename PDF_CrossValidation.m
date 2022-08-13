%Codes to estimate PDF with normal kernel and cross validation
%Ignacio Nunez, Economics Department, UT-Austin, Feb 27 2020

clear all;  close all;

filename = 'WAGE.xlsx';
sheet = 1;
xlRange = 'A1:U527';
[data,text1,raw1] = xlsread(filename, sheet, xlRange);

% First, I define the sample 
global S sample_size

S = data(:,1);
interval=[0:0.1:20];
sample_size=size(S,1);

% I use the leave-one out approach, as the sample size is not large

options = optimset('Display','final','TolFun',1e-8,'TolX',1e-4,'MaxIter',200000);
h =1.06*std(S)*(sample_size^(-1/5)); % Starting Values
h_hat = fminsearch('logll',h,options);
h_hat = fminsearch('logll',h_hat,options);


% Now plot it

x=transpose(interval);
y = zeros(size(x,1),1);
for i=1:size(x,1)
    for j=1:sample_size
            y(i)=y(i)+k_normal(x(i),S(j),h_hat)/(sample_size*h_hat);
    end
end


figure
plot(x,y);
axis([0 20 0 0.15]);
xlabel('Support'); 
ylabel('Probability Density');
title('PDF with Gaussian kernel using cross validation');
