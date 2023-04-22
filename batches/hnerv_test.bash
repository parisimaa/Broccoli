#!/bin/bash

data="/scratch/kl3866/IVP/HNeRV/data/uvg_10bit/Beauty_3840x2160_120fps_420_10bit_YUV_960x540_downsampled_images"
outpath="/scratch/kl3866/IVP/HNeRV/another_hnerv_test"
qt_model=(8)
qt_embed=(6)
# r_factor=(1.2 2) #better not mess with r_Factor and modelsize since this will affect architecture and input size requirement as well
#model_size=(1.2 1.5) #could accept as, as is, since this is HNeRV's architecture by design


for qtm in ${qt_model[@]}
do
    for qte in ${qt_embed[@]}
        do
            # for rf in ${r_factor[@]}
            #     do
            #         for ms in ${model_size[@]}
            #             do
                        # echo "POS ${qtm} , MR ${qte} , PR ${rf}, test${rf}test"
                        echo "Will run through Beauty_3840x2160_120fps_420_10bit_YUV_RAW{qtm}_${qte}"
                        python ../run_hnerv.py --data_path ${data} \
                                              --batchSize 2 \
                                              --vid beauty_sbatch_BS2_test_${qtm}_${qte} \
                                              --outf beauty_sbatch_BS2_test_out_${qtm}_${qte} \
                                              --conv_type convnext pshuffel \
                                              --act gelu \
                                              --norm none  \
                                              --crop_list 480_960 \
                                              --resize_list -1 \
                                              --loss L2  \
                                              --enc_strds 5 4 3 2 2 \
                                              --enc_dim 64_16 \
                                              --dec_strds 5 4 3 2 2 \
                                              --ks 0_1_5 \
                                              --reduce 1.2 \
                                              --modelsize 1.5  \
                                              --epochs 2 \
                                              --eval_freq 1 \
                                              --lower_width 12 \
                                              --lr 0.001 \
                                              --quant_model_bit ${qtm} \
                                              --quant_embed_bit ${qte} \
                                              --dump_images 
                        # done
                # done
        done
done


