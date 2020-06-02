function [k, l, m] = Initializer()
%%%%%%%%%%%%%%%%%%%% 3D CHAOS GENERATION CODE%%%%%%%%%%%%%%%%%%%%%%

% Initial conditions
x(1)=0.2350;
y(1)=0.3500;
z(1)=0.7350;
a = 0.0125;
b = 0.0157;
l(1) = 3.7700;
image_height=256;
pixel_len = image_height*image_height;

for i=1:70000
    x(i+1) = l*x(i)*(1-x(i)) + b*y(i)*y(i)*x(i) + a*z(i)*z(i)*z(i);
    y(i+1) = l*y(i)*(1-y(i)) + b*z(i)*z(i)*y(i) + a*x(i)*x(i)*x(i);
    z(i+1) = l*z(i)*(1-z(i)) + b*x(i)*x(i)*z(i) + a*y(i)*y(i);
end

%%%%%%Histogram equalization and preparation for use%%%%%%%%%%%%%%%

x = ceil(mod((x*100000),image_height));
y = ceil(mod((y*100000),image_height));
z = ceil(mod((z*100000),image_height));

%%%%%%%%%%%%%%%%%INITIALIZE THE VALUE OF ROTATION%%%%%%%%%%%%%%%%%%%

n=500;
p=600;
q=700;

for j=1:image_height
    k(j) = x(j+n);
    l(j) = y(j+p);
end

for j=1:pixel_len
    m(j) = z(j+q);
end