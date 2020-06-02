%Image Encryption using 3D chaotic map method
clc;
clear all;

%%%%%%%%%%%%%%%%%%%% 3D CHAOS GENERATION CODE%%%%%%%%%%%%%%%%%%%%%%

% Initial conditions

x(1)=0.2350;
y(1)=0.3500;
z(1)=0.7350;
a = 0.0125;
b = 0.0157;
l(1) = 3.7700;
image_height=256;

for i=1:70000
    x(i+1) = l*x(i)*(1-x(i)) + b*y(i)*y(i)*x(i) + a*z(i)*z(i)*z(i);
    y(i+1) = l*y(i)*(1-y(i)) + b*z(i)*z(i)*y(i) + a*x(i)*x(i)*x(i);
    z(i+1) = l*z(i)*(1-z(i)) + b*x(i)*x(i)*z(i) + a*y(i)*y(i);
end

%%%%%%Histogram equalization and preparation for use%%%%%%%%%%%%%%%

x = ceil(mod((x*100000),image_height));
y = ceil(mod((y*100000),image_height));
z = ceil(mod((z*100000),image_height));

%%%%%%%%%%%%%%%%%IMAGE INPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

original = imread(GetFileName());
original = imresize(original, [256, 256]);
[row, col, height] = size(original);
pixel_len = row*col;

if height == 1
    gray_image = original;
else
    gray_image = rgb2gray(original);
end

%%%%%%%%%%%%%%%%%INITIALIZE THE VALUE OF ROTATION%%%%%%%%%%%%%%%%%%%

n=500;
p=600;
q=700;

for j=1:row
    k(j) = x(j+n);
    l(j) = y(j+p);
end

for j=1:pixel_len
    m(j) = z(j+q);
end

%%%%%%%%%%% IF k is even, right shift row else left shift row %%%%%%%%%
%%%%%%%%%%% If l is even, shift up column else down shift column %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% ROTATION OPERATION %%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:row
    for j=1:1:col
        if(mod(k(i),2)==0)
            if((j+k(i))<=col)       %shift right of row
                shifted_row(i,j+k(i)) = gray_image(i,j);
                even_shifted_row(i,j) = j+k(i);
            else
                shifted_row(i,(j+k(i)-col)) = gray_image(i,j); 
                even_shifted_row(i,j) = (j+k(i)-col);
            end
        else
            if((j-k(i))>=1)         %shift left of row
                shifted_row(i,j-k(i)) = gray_image(i,j);
                odd_shifted_row(i,j) = j-k(i);
            else
                shifted_row(i,(col+j-k(i))) = gray_image(i,j);
                odd_shifted_row(i,j) = col+j-k(i);
            end
        end
    end
end

for j=1:col
    for i=1:1:row
        if(mod(l(j),2)==0)
            if((i-l(j))>=1)         %shift up of column
                shifted_col(i-l(j),j) = shifted_row(i,j);
                even_shifted_col(i,j) = i-l(j);
            else
                shifted_col((row+i-l(j)),j) = shifted_row(i,j);
                even_shifted_col(i,j) = row+i-l(j);
            end
        else
            if((i+l(j))<=row)       %shift down of column
                shifted_col(i+l(j),j) = shifted_row(i,j);
                odd_shifted_col(i,j) = i+l(j);
                else
                shifted_col((i+l(j)-row),j) = shifted_row(i,j); 
                odd_shifted_col(i,j) = (i+l(j)-row);
            end
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%XOR IMAGE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

flatten_image = int32(reshape(shifted_col, 1, pixel_len));

for i=1:pixel_len
    xored_image(1,i) = bitxor(flatten_image(i), m(i));
end

% Writing Encrypted Image back to disk
Enc_Image = reshape(xored_image,row,col);
imwrite(uint8(Enc_Image), 'Encypted.jpg', 'Quality', 100);

% Plotting the graph and Histogram of Images
figure
subplot(3,2,1)
imshow(gray_image)
title('Original Image');
subplot(3,2,2)
imhist(gray_image)
title('Histogram of original Image');

subplot(3,2,3)
imshow(Enc_Image)
title('Encrypted Image');
subplot(3,2,4)
imhist(Enc_Image)
title('Histogram of Encrypted Image');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%Decryption XOR%%%%%%%%%%%%%%%%%%%%%%%%%%%

[row,col] = size(Enc_Image);

flatten_image = reshape(Enc_Image,1,pixel_len);

for i=1:pixel_len
    xored_image(1,i) = bitxor(flatten_image(i),m(i));
end

shuffled_image = reshape(xored_image,row,col);

%%%%%%%%%%%%%% IF k is even right shift row else left shift row%%%%%
%%%%%%%%%%%%%% If l is even shift up column else down shift column%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% ROTATION OPERATION %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ROW SHIFTING %%%%%%%%%%%%%%%%%%%%%%%%%

for j=1:col
    for i=1:1:row
        if(mod(l(j),2)==0)
            if((i+l(j))<=row)           %shift down of column
                shifted_col(i+l(j),j) = shuffled_image(i,j);
                even_shifted_col(i,j) = i+l(j);
            else
                shifted_col((i+l(j)-row),j) = shuffled_image(i,j); 
                even_shifted_col(i,j) = (i+l(j)-row);
            end
        else
            if((i-l(j))>=1)          %shift up of column
                shifted_col(i-l(j),j) = shuffled_image(i,j);
                odd_shifted_col(i,j) = i-l(j);
            else
                shifted_col((row+i-l(j)),j) = shuffled_image(i,j);
                odd_shifted_col(i,j) = row+i-l(j);
            end
        end
    end
end

for i=1:row
    for j=1:1:col
        if(mod(k(i),2)==0)
            if((j-k(i))>=1)         %shift left of row
                shifted_row(i,j-k(i)) = shifted_col(i,j);
                even_shifted_row(i,j) = j-k(i);
            else
                shifted_row(i,(col+j-k(i))) = shifted_col(i,j);
                even_shifted_row(i,j) = col+j-k(i);
            end
        else
            if((j+k(i))<=col)       %shift right of row
                shifted_row(i,j+k(i)) = shifted_col(i,j);
                even_shifted_row(i,j) = j+k(i);
            else
                shifted_row(i,(j+k(i)-col)) = shifted_col(i,j); 
                even_shifted_row(i,j) = (j+k(i)-col);
            end
        end
    end
end

Dec_Img = shifted_row;
% Plotting the image and it's histogram

subplot(3,2,5)
imshow(Dec_Img)
title('Decrypted image');

subplot(3,2,6)
imhist(Dec_Img)
title('Histogram of Decrypted Image');

imwrite(Dec_Img, 'Decrypted.jpg', 'Quality', 100);