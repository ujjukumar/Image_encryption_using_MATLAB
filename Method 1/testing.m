x = imread(uigetfile('*'));
y = imread(uigetfile('*'));
disp('NPCR of Original Image with Decrypted Image :')
disp(NpcrColorImages(x, y));