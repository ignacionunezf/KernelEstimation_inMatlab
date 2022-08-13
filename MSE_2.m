function ret=MSE_2(p)

global W EX G sample_size;

h=abs(p);
y1 = zeros(sample_size,1); %conditional expectation for female
y2 = zeros(sample_size,1); %conditional expectation for male

for i=1:sample_size
        
    denom = 0;
    for j=1:sample_size
        if j==i
        elseif G(j)==1
            denom= denom+k_normal(EX(i),EX(j),h);
        end
    end
    for j=1:sample_size
        if j==i
        elseif G(j)==1
            y1(i)=y1(i)+W(j)*k_normal(EX(i),EX(j),h)/denom;
        end
    end


    denom = 0;
    for j=1:sample_size
        if j==i
        elseif G(j)==0
            denom= denom+k_normal(EX(i),EX(j),h);
        end
    end
    for j=1:sample_size
        if j==i
        elseif G(j)==0
            y2(i)=y2(i)+W(j)*k_normal(EX(i),EX(j),h)/denom;
        end
    end

end

sum=0;
for j=1:sample_size
    if G(j)==1
    sum=sum+(W(j)-y1(j))^2;
    else
    sum=sum+(W(j)-y2(j))^2;
    end
end

ret=sum;
fprintf('MSE:  %20.16f \n',ret)
fprintf('Bandwidth:  %20.16f \n',h)

end