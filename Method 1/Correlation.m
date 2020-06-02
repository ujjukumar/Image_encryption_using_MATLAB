%%%%%%%%%%%%%%%%%%%ORIGINAL IMAGE CORRELATION%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear all;
original=imread(uigetfile('*'));
rgb=rgb2gray(original);
[row,col]=size(rgb);
total_length=row*col;

% VERTICAL CORRELATION
x=zeros(1,(row*col)/2);
y=zeros(1,(row*col)/2);
k=0;
l=0;
for j=1:1:col
    for i=1:1:row      
        if(mod(j,2)==0)
            k=k+1;
            x(1,k)=rgb(i,j);
        else
            l=l+1;
            y(1,l)=rgb(i,j);
        end
    end
end
figure
subplot(2,2,1)
scatter(x,y,2)
title('Vertical Correlation of original Image');
xlabel('(a)')

% HORIZONTAL CORRELATION
x=zeros(1,(row*col)/2);
y=zeros(1,(row*col)/2);
k=0;
l=0;
for i=1:1:row
    for j=1:1:col
        if(mod(i,2)==0)
            k=k+1;
            x(1,k)=rgb(i,j);
        else
            l=l+1;
            y(1,l)=rgb(i,j);
        end
    end
end
subplot(2,2,2)
scatter(x,y,2)
title('Horizontal Correlation of original Image');
xlabel('(b)')

%%%%%%%%%%%%%%%%%%%%%% ENCRYPTED IMAGE CORRELATION %%%%%%%%%%%%%%%%%%%

original=imread(uigetfile('*'));
rgb=original;
[row,col]=size(rgb);
total_length=row*col;

% VERTICAL CORRELATION
x=zeros(1,(row*col)/2);
y=zeros(1,(row*col)/2);
k=0;
l=0;
for j=1:1:col
    for i=1:1:row      
        if(mod(j,2)==0)
            k=k+1;
            x(1,k)=rgb(i,j);
        else
            l=l+1;
            y(1,l)=rgb(i,j);
        end
    end
end
subplot(2,2,3)
scatter(x,y,2)
title('Vertical Correlation of Encrypted Image');
xlabel('(c)')

% HORIZONTAL CORRELATION
x=zeros(1,(row*col)/2);
y=zeros(1,(row*col)/2);
k=0;
l=0;
for i=1:1:row
    for j=1:1:col
        if(mod(i,2)==0)
            k=k+1;
            x(1,k)=rgb(i,j);
        else
            l=l+1;
            y(1,l)=rgb(i,j);
        end
    end
end
subplot(2,2,4)
scatter(x,y,2)
xlabel('(d)')
title('Horizontal Correlation of Encrypted Image');
