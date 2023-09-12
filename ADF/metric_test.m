%指标测试
%读入图像
% https://www.jianshu.com/p/93cad0a90b0d
close all;
clear all;
load fusion10.mat
%读入红外图像 需要灰度图
img1=imread('F:\Traditional_Fusion\Comparison\infrared\190010.jpg');

I1=rgb2gray(img1);
I1=double(I1);
% HistPicFig(I1)

% 读入可见光图像
img2=imread('F:\Traditional_Fusion\Comparison\RGB\190010.jpg');
I2=rgb2gray(img2);
I2=double(I2);

% entropy_value=entropy_liu(FF);
% disp(entropy_value)
% 
% output = analysis_Qabf(I1, I2,fuseimage );
% disp(output)
% [MCE,RCE]=cross_entropy(I1,I2,FF);
% disp(MCE)
% disp(RCE)


% % % ssim
% [ssim_value1] = ssim_liu(I1,fuseimage);
% disp(ssim_value1);
% % 
% % 
% [ssim_value2] = ssim_liu(I2,fuseimage);
% disp(ssim_value2);

% entropy_value=entropy_liu(fuseimage);
% disp(entropy_value)
[MCE,RCE]=cross_entropy(I1,I2,fuseimage);
disp(MCE)
disp(RCE)
