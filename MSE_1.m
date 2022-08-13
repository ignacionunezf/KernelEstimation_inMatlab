function ret=MSE_1(p)


global W ED sample_size;

h=abs(p);
cond_moment=zeros(sample_size,1);
for i=1:sample_size
    
    denom = 0;
    for j=1:sample_size
        if j==i
        else
            denom=denom+k_normal(ED(i),ED(j),h);
        end
    end
    for j=1:sample_size
        if j==i
        else
            cond_moment(i)=cond_moment(i)+W(j)*k_normal(ED(i),ED(j),h)/denom;
        end
    end

end

sum=0;
for j=1:sample_size
    sum=sum+(W(j)-cond_moment(j))^2;
end

ret=sum;
fprintf('MSE:  %20.16f \n',ret)
fprintf('Bandwidth:  %20.16f \n',h)

end