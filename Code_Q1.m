%Assignment #1, Q1 Adv. Econometrics, by Ignacio Nunez, Feb 27 2020

clear all; close all;

% Random sample of size 100 from normal dist 
sample_size=100;
S = randn(sample_size,1);

% Plot CDF 
mu = 0;
sigma = 1;
pd = makedist('Normal','mu',mu,'sigma',sigma);
interval=[-3:0.01:3];
x = transpose(interval);
y = cdf(pd,x);

% I. True CDF

figure 
plot(x,y,'red');
axis([-3 3 0 1]);
xlabel('Support'); 
ylabel('Cumulative Probability');
title('CDF of Standard Normal Distribution');

% II. Empirical CDF
x2 = transpose(interval);
y2 = zeros(size(x2,1),1);
for i=1:size(x2,1)
    for j=1:sample_size
        if S(j)<=x2(i)
        y2(i)=y2(i)+1/sample_size;   
        else
        end
    end
end

figure 
plot(x2,y2,'red');
axis([-3 3 0 1]);
xlabel('Support'); 
ylabel('Cumulative Probability');
title('Empirical CDF');

% III. Kernel CDF

cases=5;
h=zeros(cases,1);
x3=zeros(size(interval,2),cases);
for c=1:cases
h(c)=sample_size^(-1/c);
x3(:,c) = transpose(interval);
end

y3 = zeros(size(x3,1),cases);
for i=1:size(x3,1)
    for j=1:sample_size
        for c=1:cases
            y3(i,c)=y3(i,c)+cdf(pd,(x3(i,c)-S(j))/h(c))/sample_size;
        end
    end
end

figure 
subplot(2,1,1)
plot(x3,y3);
axis([-3 3 0 1]);
xlabel('Support'); 
ylabel('Cumulative Probability');
title('CDF with kernel method');
legend('n^{-1}','n^{-1/2}','n^{-1/3}','n^{-1/4}','n^{-1/5}')
subplot(2,1,2)
plot(x3,y3);
axis([-0.2 0.2 0.4 0.6]);
xlabel('Support'); 
ylabel('Cumulative Probability');
title('CDF with kernel method');
legend('n^{-1}','n^{-1/2}','n^{-1/3}','n^{-1/4}','n^{-1/5}')
