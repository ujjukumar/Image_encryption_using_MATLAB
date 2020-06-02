% NPCR calculation
function [npcr] = NpcrColorImages(x, y)

[row, col, height] = size(x);
count=0;

for i=1:1:row
    for j=1:1:col
        for k = 1:height
            if(x(i, j, k)==y(i,j, k))
                count=count+0;
            else
                count=count+1;
            end
        end
    end
end

npcr = (count/(row*col*height))*100;
