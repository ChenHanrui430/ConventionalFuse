clc;
clear all;
close all;
tic
parfor i=1:200

image_ir =  ['..\llvip_noMask\IR\',num2str(i),'.jpg'];

I1=imread(image_ir);

image_vis = ['..\llvip_noMask\VIS\',num2str(i),'.jpg'];
% I2=rgb2gray(imread(image_vis));
I2=imread(image_vis);
fused_path =  ['..\llvip_noMask\fused\ADF\fused',num2str(i),'.jpg'];
% imshow([I1,I2])

%     
%  I1=imread('H:\Traditional_Fusion\ADF\TNO\infrared\43.png');
%  I1=rgb2gray(I1);
% %  I1=double(I1);
% 
%  I2=imread('H:\Traditional_Fusion\ADF\TNO\light\43.png');
%  I2=rgb2gray(I2);
% %  I2=double(I2);
% 
% i=43;
% fused_path = ['H:/Traditional_Fusion/ADF/fuse/',num2str(i),'.png'];

%转换图像的通道数
if size(I1,3)==3
    I1=rgb2gray(I1);
end
% figure, imshow((uint8(I1))),title("InFred image")

if size(I2,3)==3
    I2=rgb2gray(I2);
end

% figure, imshow(uint8(I2)),title("Visiable  image")

% 各向异性的扩散参数
num_iter = 10; % 迭代次数
delta_t = 0.15;  % 积分常数
kappa = 30; %控制传导的梯度模量阈值
option = 1;


A1 = anisodiff2D(I1,num_iter,delta_t,kappa,option);

A2= anisodiff2D(I2,num_iter,delta_t,kappa,option);

D1=double(I1)-A1;
D2=double(I2)-A2;


C1 = cov([D1(:) D2(:)]);
[V11, D11] = eig(C1);
if D11(1,1) >= D11(2,2)
    pca1 = V11(:,1)./sum(V11(:,1));
else
    pca1 = V11(:,2)./sum(V11(:,2));
end

imf1 = pca1(1)*D1 + pca1(2)*D2;


imf2=(0.5*A1+0.5*A2);


%线性叠加
fuseimage=(double(imf1)+double(imf2));

% figure, imshow((fuseimage), []),title("fusion image")
fuseimage=uint8(fuseimage);
imwrite(fuseimage,fused_path);
end
toc




%对图显示
% figure,imshowpair(I1,fuseimage,'montage')
% figure,imshowpair(I2,fuseimage,'montage')

