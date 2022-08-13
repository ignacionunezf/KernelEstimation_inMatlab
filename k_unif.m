function ret=k_unif(x,x_obs,h)

u=(x-x_obs)/h;
if -0.5<=u&&u<=0.5
    ret=1;
else
    ret=0;
end
end