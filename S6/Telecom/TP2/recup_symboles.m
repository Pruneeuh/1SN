function [symboles] = recup_symboles(signal)
   symboles = zeros(size(signal));
   for i=1:length(signal)
       if signal(i)>2 
           symboles(i)=3;
       elseif signal(i)>0
            symboles(i)=1;
       elseif signal(i)>-2
           symboles(i)=-1;
       else 
           symboles(i)=-3;
       end 
   end
end