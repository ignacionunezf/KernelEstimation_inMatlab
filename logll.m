function ret=logll(p)


global S sample_size
h=abs(p);
density=zeros(sample_size,1);
for i=1:sample_size
for j=1:sample_size
    if j==i
    else
        density(i)=density(i)+k_normal(S(i),S(j),h)/((sample_size-1)*h);
    end
end
end

ret=-sum(log(density));
fprintf('Loglikelihood:  %20.16f \n',-ret)
fprintf('Bandwidth:  %20.16f \n',h)

end