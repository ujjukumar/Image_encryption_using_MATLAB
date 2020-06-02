function Plotting_Images(gray_image, Enc_Image, Dec_Img)

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

subplot(3,2,5)
imshow(Dec_Img)
title('Decrypted image');

subplot(3,2,6)
imhist(Dec_Img)
title('Histogram of Decrypted Image');