function [xored_image] = Encrypt_Image(k, l, m, gray_image)

%%%%%%%%%%% IF k is even, right shift row else left shift row %%%%%%%%%
%%%%%%%%%%% If l is even, shift up column else down shift column %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% ROTATION OPERATION %%%%%%%%%%%%%%%%%%%%%%%%%

row = 256;
col = 256;
pixel_len = row*col;
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