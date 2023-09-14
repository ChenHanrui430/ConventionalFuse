clc,clear
close all
tic
for i=1:42
    image_ir = ['/home/chr/chr/Dataset/TNO/infrared/',num2str(i),'.png'];
% image_ir = ['C:\Users\liu\Desktop\Traditional_Fusion\DCT\RoadScene\infrared\img',num2str(i),'.jpg'];
    A=imread(image_ir);
    image_vis = ['/home/chr/chr/Dataset/TNO/light/',num2str(i),'.png'];
% image_vis = ['C:\Users\liu\Desktop\Traditional_Fusion\DCT\RoadScene\vis\img',num2str(i),'.jpg'];
    B=imread(image_vis);
    fused_path = ['..\llvip_noMask\fused\DCT\fused/',num2str(i),'.jpg'];




% alpha
% A = imread( 'Sourceimages/alpha_A.tif'); 
% B = imread( 'Sourceimages/alpha_B.tif'); 
[fusedDctVarCv, fusedDctVar] = dctVarFusion(A,B );
% F = dctVarFusion(A,B);
% figure,imshow(fusedDctVarCv);title("fusedDctVarCv")
% figure,imshow(fusedDctVar);title("fusedDctVar")
imwrite(fusedDctVarCv,fused_path,'jpg');
toc
end
toc


% imwrite(F,'alpha_dct.tif');
% % lena
% A = imread( 'Sourceimages/lena_A.tif'); 
% B = imread( 'Sourceimages/lena_B.tif'); 
% F = dctVarFusion(A,B);
% figure,imshow(F);
% imwrite(F,'lena_dct.tif');
% % sale
% A = imread( 'Sourceimages/sale_A.tif'); 
% B = imread( 'Sourceimages/sale_B.tif'); 
% F = dctVarFusion(A,B);
% figure,imshow(F);
% imwrite(F,'sale_dct.tif');
% % zebra
% A = imread( 'Sourceimages/zebra_A.tif'); 
% B = imread( 'Sourceimages/zebra_B.tif'); 
% F = dctVarFusion(A,B);
% figure,imshow(F);
% imwrite(F,'zebra_dct.tif');
% % comic
% A = imread( 'Sourceimages/comic_A.tif'); 
% B = imread( 'Sourceimages/comic_B.tif'); 
% F = dctVarFusion(A,B);
% figure,imshow(F);
% imwrite(F,'comic_dct.tif');