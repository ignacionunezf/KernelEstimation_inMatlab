%Codes to estimate PDF using kernel estimation
%Ignacio Nunez, Economics Department, UT-Austin, Feb 27 2020

clear all;  close all;

filename = 'WAGE.xlsx';
sheet = 1;
xlRange = 'A1:U527';
[data,text1,raw1] = xlsread(filename, sheet, xlRange);

% First, define sample 

S = data(:,1);
interval=[0:0.1:20];
sample_size=size(S,1);

% I. Uniform kernel

cases=5;
h=zeros(cases,1);
x=zeros(size(interval,2),cases);
for c=1:cases
h(c)=(0.5*c)*std(S)*(sample_size^(-1/5));
x(:,c) = transpose(interval);
end

y = zeros(size(x,1),cases);
for i=1:size(x,1)
    for j=1:sample_size
        for c=1:cases
            y(i,c)=y(i,c)+k_unif(x(i),S(j),h(c))/(sample_size*h(c));
        end
    end
end

figure
plot(x,y);
axis([0 20 0 0.5]);
xlabel('Support'); 
ylabel('Probability Density');
title('PDF with uniform kernel');
legend('\lambda=0.5','\lambda=1','\lambda=1.5','\lambda=2','\lambda=2.5')

% II. Gaussian kernel (LAMBDA)

cases=5;
h=zeros(cases,1);
x=zeros(size(interval,2),cases);
for c=1:cases
h(c)=(0.5*c)*std(S)*(sample_size^(-1/5));
x(:,c) = transpose(interval);
end

y = zeros(size(x,1),cases);
for i=1:size(x,1)
    for j=1:sample_size
        for c=1:cases
            y(i,c)=y(i,c)+k_normal(x(i),S(j),h(c))/(sample_size*h(c));
        end
    end
end

figure
plot(x,y);
axis([0 20 0 0.1]);
xlabel('Support'); 
ylabel('Probability Density');
title('PDF with Gaussian kernel');
legend('\lambda=0.5','\lambda=1','\lambda=1.5','\lambda=2','\lambda=2.5')

% III. Epanechnikov kernel

cases=5;
h=zeros(cases,1);
x=zeros(size(interval,2),cases);
for c=1:cases
h(c)=(0.5*c)*std(S)*(sample_size^(-1/5));
x(:,c) = transpose(interval);
end

y = zeros(size(x,1),cases);
for i=1:size(x,1)
    for j=1:sample_size
        for c=1:cases
            y(i,c)=y(i,c)+k_epach(x(i),S(j),h(c))/(sample_size*h(c));
        end
    end
end

figure
plot(x,y);
axis([0 20 0 0.35]);
xlabel('Support'); 
ylabel('Probability Density');
title('PDF with Epanechnikov kernel');
legend('\lambda=0.5','\lambda=1','\lambda=1.5','\lambda=2','\lambda=2.5')

% IV. Gaussian kernel (N)

cases=6;
h=zeros(cases,1);
x=zeros(size(interval,2),cases);
for c=1:cases
h(c)=(1.06)*std(S)*(sample_size^(-1/(c+1)));
x(:,c) = transpose(interval);
end

y = zeros(size(x,1),cases);
for i=1:size(x,1)
    for j=1:sample_size
        for c=1:cases
            y(i,c)=y(i,c)+k_normal(x(i),S(j),h(c))/(sample_size*h(c));
        end
    end
end

figure
plot(x,y);
axis([0 20 0 0.2]);
xlabel('Support'); 
ylabel('Probability Density');
title('PDF with Gaussian kernel, \lambda=1.06');
legend('n^{-1/2}','n^{-1/3}','n^{-1/4}','n^{-1/5}','n^{-1/6}','n^{-1/7}')
