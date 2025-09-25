function [symbole] = mapping_naturel(bits)
%mapping naturel 
%% bits     symboles 
%  00           -3
%  01           -1
%  10           1
%  11           3

   i = 1;
   j = 1;
   symbole=zeros(1,length(bits)/2);
   while i<=length(bits)
        duo = bits(i:i+1);
        if duo(1)==0 && duo(2)==0
            symbole(j)=-3;
        elseif duo(1)==0 && duo(2)==1
            symbole(j)=-1;
        elseif duo(1)==1 && duo(2)==0
            symbole(j)=1;
        else
            symbole(j)=3;
        end
        i = i + 2;
        j = j + 1; 
   end 
end
