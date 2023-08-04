clc
clear all
close all
easy =-1;
% 需要测试的融合图像的路径
dirOutput = getAlldoc("/home/chr/chr/home/traditionFusion/secondpaper/NSST/fused"); % 需要测试的红外图像所在文件夹
fileNames = {dirOutput.name};
fileNames =sort_nat(fileNames);
test_path = dirOutput.folder;
[m, num] = size(fileNames);
% 原始数据集的图像路径，会自动遍历路径下所有文件，如果报错，请手动指定匹配的文件尾缀
IRdocStruct = getAlldoc("/home/chr/chr/FuseResult/LLVIP/firstPaperChoosed/infraredNumber");
VISdocStruct =getAlldoc('/home/chr/chr/FuseResult/LLVIP/firstPaperChoosed/visibleNumber');
% IRdocStruct = getAlldoc("/home/chr/chr/FuseResult/LLVIP/firstPaperChoosed/infrared");
% VISdocStruct = getAlldoc('/home/chr/chr/FuseResult/LLVIP/firstPaperChoosed/visible');
% IRdocStruct = getAlldoc("/home/chr/chr/Dataset/TNO/infrared");
% VISdocStruct = getAlldoc('/home/chr/chr/Dataset/TNO/light');
                      

visfileNames = {IRdocStruct.name};% 用于评估算法的可见光图像名
visfileNames=sort_nat(visfileNames);
irfileNames = {VISdocStruct.name};% 用于评估算法的红外图像名
irfileNames=sort_nat(irfileNames);

IRdocPath = IRdocStruct.folder;
VISdocPath = VISdocStruct.folder;
%创建容器
EN_set = [];  
SF_set = [];
SD_set = [];
PSNR_set = [];
MSE_set = [];
MI_set = [];
VIF_set = []; 
AG_set = [];
CC_set = [];
SCD_set = []; 
Qabf_set = [];
SSIM_set = [];
MS_SSIM_set = [];
Nabf_set = [];
FMI_pixel_set = [];
FMI_dct_set = [];
FMI_w_set = [];
fprintf("\t Completion: ")
showTimeToCompletion;startTime=tic;
p = parfor_progress(num);
parfor i = 1:num
    p = parfor_progress;
    showTimeToCompletion(p/100,[],[],startTime);
%     disp('---------------------------Analysis---------------------------');
%     fileName_source_ir = fullfile(ir_dir, irfileNames{i});
%     fileName_source_vi = fullfile(vi_dir, visfileNames{i}); 
    fileName_Fusion = fullfile(test_path, fileNames{i});
    
    fileName_source_ir = [VISdocPath filesep visfileNames{i}];
    fileName_source_vi = [IRdocPath filesep irfileNames{i}];

    ir_image = imread(fileName_source_ir);
    vi_image = imread(fileName_source_vi);
    fused_image = imread(fileName_Fusion);
    if ndims(ir_image)==3
        ir_image=rgb2gray(ir_image);
    end
    if ndims(vi_image)==3
        vi_image=rgb2gray(vi_image);
    end
    if ndims(fused_image)==3
        fused_image=rgb2gray(fused_image);
    end
%     t = dct2(ir_image(:,:,1));
%     figure()
%     imshow(t)
    [m, n ,p] = size(fused_image);
    [ir_m, ir_n, ir_c] = size(ir_image);
    % resize image 
    if m~=ir_m || n~=ir_n
        fused_image=imresize(ir_image,[ir_m ir_n])
    end
    [EN, SF,SD,PSNR,MSE, MI, VIF, AG, CC, SCD, Qabf, Nabf, SSIM, MS_SSIM, FMI_pixel, FMI_dct, FMI_w] = analysis_Reference(fused_image,ir_image,vi_image, easy);
    EN_set = [EN_set, EN];
    SF_set = [SF_set,SF];
    SD_set = [SD_set, SD];
    PSNR_set = [PSNR_set, PSNR];
    MSE_set = [MSE_set, MSE];
    MI_set = [MI_set, MI];
    VIF_set = [VIF_set, VIF];
    AG_set = [AG_set, AG]; 
    CC_set = [CC_set, CC];
    SCD_set = [SCD_set, SCD];
    Qabf_set = [Qabf_set, Qabf];
    Nabf_set = [Nabf_set, Nabf];
    SSIM_set = [SSIM_set, SSIM];
    MS_SSIM_set = [MS_SSIM_set, MS_SSIM];
    FMI_pixel_set = [FMI_pixel_set, FMI_pixel];
    FMI_dct_set = [FMI_dct_set,FMI_dct];
    FMI_w_set = [FMI_w_set, FMI_w];
%     fprintf('Evaluating %s Image', fileNames{i});
end
%% 参数保存到metrixs.txt文件
ag=sum(AG_set)/length(AG_set);
cc=sum(CC_set)/length(CC_set);
en=sum(EN_set)/length(EN_set);
scd=sum(SCD_set)/length(SCD_set);
vif=sum(VIF_set)/length(VIF_set);
mi=sum(MI_set)/length(MI_set);
mse=sum(MSE_set)/length(MSE_set);
qabf=sum(Qabf_set)/length(Qabf_set);
psnr=sum(PSNR_set)/length(PSNR_set);
sd=sum(SD_set)/length(SD_set);
sf=sum(SF_set)/length(SF_set);
% 下面几个指标比较耗时
nabf=sum(Nabf_set)/length(Nabf_set);
ssim=sum(SSIM_set)/length (SSIM_set);
fmi_w=sum(FMI_w_set)/length(FMI_w_set);
fmi_pixel=sum(FMI_pixel_set)/length(FMI_pixel_set);
fmi_dct=sum(FMI_dct_set)/length(FMI_dct_set);
ms_ssim=sum(MS_SSIM_set)/length(MS_SSIM_set);
save metrics.mat ag cc en scd vif mi mse qabf psnr sd sf nabf ssim fmi_w fmi_pixel fmi_dct ms_ssim
everyMetric = [EN_set',SF_set',SD_set',PSNR_set',MSE_set',MI_set',VIF_set',AG_set',CC_set',SCD_set',Qabf_set',Nabf_set',SSIM_set',MS_SSIM_set',FMI_pixel_set',FMI_dct_set',FMI_w_set'];
writematrix(everyMetric,'everyMetric.xlsx');
disp('\n结束')
