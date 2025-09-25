function [symbole] = bit_a_symbole(bits)
   i = 1;
   j = 1;
   symbole=zeros(1,length(bits)/2);
   while i<length(bits)
        duo = bits(i:i+1);
        if duo == [0,0]
            symbole(j)=1;
        elseif duo == [0,1]
            symbole(j)=2;
        elseif duo == [1,0]
            symbole(j)=-1;
        else
            symbole(j)=-2;
        end
        i = i + 2;
        j = j + 1; 
   end 

end

