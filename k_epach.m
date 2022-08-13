function ret=k_epach(x,x_obs,h)

u=(x-x_obs)/h;

if -1<=u&&u<=01
    ret=(3/4)*(1-u^2);
else
    ret=0;
end

end