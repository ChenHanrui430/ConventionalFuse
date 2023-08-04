function SD = SD_evaluation(F)
%  标准差
[m,n]=size(F);
u=mean(mean(F));
SD=sqrt(sum(sum((F-u).^2))/(m*n));
end
