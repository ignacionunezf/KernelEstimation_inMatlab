function ret=k_normal(x,x_obs,h)

u=(x-x_obs)/h;
ret=(1/(2*pi))*exp(-(u^2)/2);

end