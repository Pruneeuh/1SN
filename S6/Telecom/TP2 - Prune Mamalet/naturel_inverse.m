function [bits] = naturel_inverse(symboles)
   %mapping naturel 
%% bits     symboles 
%  00           -3
%  01           -1
%  10           1
%  11           3

   i = 1; %boucle sur symboles
   j = 1;%boucle sur bits
   bits=zeros(1,length(symboles)*2);
   while i<=length(bits)
        if symboles(j)==-3
            bits(i)=0;
            bits(i+1)=0;
        elseif symboles(j)==-1
            bits(i)=0;
            bits(i+1)=1;
        elseif symboles(j)==1
            bits(i)=1;
            bits(i+1)=0; 
        else
            bits(i)=1;
            bits(i+1)=1;
        end
        i = i + 2;
        j = j + 1; 
   end 
end
