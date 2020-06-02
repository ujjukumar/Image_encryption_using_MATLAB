% NPCR calculation

clc;
clear all;
x = Image_input();
y = Image_input();
row = 256;
col = 256;
count=0;

for i=1:1:row
    for j=1:1:col
        if(x(i,j)==y(i,j))
            count=count+0;
        else
            count=count+1;
        end
    end
end

disp('NPCR count = '); disp(count);
disp((count/(row*col))*100);
