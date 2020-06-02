function [gray_image] = Image_input()

%%%%%%%%%%%%%%%%%IMAGE INPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

original = imread(GetFileName());
original = imresize(original, [256, 256]);
[~, ~, height] = size(original);

if height == 1
    gray_image = original;
else
    gray_image = rgb2gray(original);
end