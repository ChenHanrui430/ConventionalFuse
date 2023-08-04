function [EN, SF, SD, PSNR, MSE, MI, VIF, AG, CC, SCD, Qabf, Nabf, SSIM, MS_SSIM, FMI_pixel, FMI_dct, FMI_w] = analysis_Reference(image_f,image_ir,image_vis, easy)
% 返回值所有的评价指标    
grey_level = 256;
    [s1,s2] = size(image_ir);
    imgSeq = zeros(s1, s2, 2);
    imgSeq(:, :, 1) = image_ir;
    imgSeq(:, :, 2) = image_vis;

    image1 = im2double(image_ir);
    image2 = im2double(image_vis);
    image_fused = im2double(image_f);
    if easy ==1
        %EN
        EN = entropy(image_f);

        %SF
        SF = SF_evaluation(image_fused);
        %SD
        SD = SD_evaluation(image_f);
        %PSNR
        PSNR = PSNR_evaluation(image1,image2,image_fused);
        %MSE
        MSE = MSE_evaluation(image1,image2,image_fused);
        %MI
        MI = MI_evaluation(image_ir,image_vis,image_f, grey_level);
        %VIF
        VIF = vifp_mscale(image_ir, image_f) + vifp_mscale(image_vis, image_f);
        %AG
        AG = AG_evaluation(image_f);
        %CC
        CC = CC_evaluation(image1, image2, image_fused);
        %SCD
        SCD = analysis_SCD(image1, image2, image_fused);
        %Qabf
        Qabf = analysis_Qabf(image1, image2, image_fused);
        Nabf = 1;
        SSIM = 1;
        MS_SSIM = 1;
        FMI_pixel = 1;
        FMI_dct = 1;
        FMI_w = 1; 
    elseif easy ==-1
        %EN
        EN = entropy(image_f);
        %SF
        SF = SF_evaluation(image_fused);
        %SD
        SD = SD_evaluation(image_f);
        %PSNR
        PSNR = PSNR_evaluation(image1,image2,image_fused);
        %MSE
        MSE = MSE_evaluation(image1,image2,image_fused);
        %MI
        MI = MI_evaluation(image_ir,image_vis,image_f, grey_level); 
        %VIF
        VIF = vifp_mscale(image_ir, image_f) + vifp_mscale(image_vis, image_f);
        %AG
        AG = AG_evaluation(image_f);
        %CC
        CC = CC_evaluation(image1, image2, image_fused);
        %SCD
        SCD = analysis_SCD(image1, image2, image_fused);
        %Qabf
        Qabf = analysis_Qabf(image1, image2, image_fused);
        % %Nabf
        Nabf = analysis_nabf(image_fused, image1, image2);
        % SSIM_a
        % SSIM1 = ssim(image_fused,image1);
        % SSIM2 = ssim(image_fused,image2);
        SSIM = mef_ssim(imgSeq, image_f);
        %MS_SSIM
        [MS_SSIM,t1,t2]= analysis_ms_ssim(imgSeq, image_f);
        %FMI
        FMI_pixel = analysis_fmi(image1,image2,image_fused);
        FMI_dct = analysis_fmi(image1,image2,image_fused,'dct');
        FMI_w = analysis_fmi(image1,image2,image_fused,'wavelet');
    else
        %EN
        EN = -1;%entropy(image_f);
        %SF
        SF = SF_evaluation(image_fused);
        %SD
        SD = -1;%SD_evaluation(image_f);
        %PSNR
        PSNR = -1;%PSNR_evaluation(image1,image2,image_fused);
        %MSE
        MSE = -1;%MSE_evaluation(image1,image2,image_fused);
        %MI
        MI = -1;%MI_evaluation(image_ir,image_vis,image_f, grey_level);
        %VIF
        VIF = -1;%vifp_mscale(image_ir, image_f) + vifp_mscale(image_vis, image_f);
        %AG
        AG = -1;%AG_evaluation(image_f);
        %CC
        CC = -1;%CC_evaluation(image1, image2, image_fused);
        %SCD
        SCD = analysis_SCD(image1, image2, image_fused);
        %Qabf
        Qabf = analysis_Qabf(image1, image2, image_fused);
        % %Nabf
        Nabf = -1;%analysis_nabf(image_fused, image1, image2);
        % SSIM_a
        % SSIM1 = ssim(image_fused,image1);
        % SSIM2 = ssim(image_fused,image2);
        SSIM = mef_ssim(imgSeq, image_f);
        %MS_SSIM
        [MS_SSIM,t1,t2]= analysis_ms_ssim(imgSeq, image_f);
        %FMI
        FMI_pixel = analysis_fmi(image1,image2,image_fused);
        FMI_dct =-1;%analysis_fmi(image1,image2,image_fused,'dct');
        FMI_w = -1;%analysis_fmi(image1,image2,image_fused,'wavelet');
    end
end







