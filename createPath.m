function [path] = createPath(First, SNR, Foff, NFrame, NStart)
    switch First
        case 'Input'
            path = strcat('Input_GroupID_1D_FreqID_40_SNR_', SNR, '_Foff_'...
                , Foff, '_Nframe_', NFrame, '_Nstart_', NStart, '.txt');
        case 'V0'
            path = strcat('V0_GroupID_1D_FreqID_40_SNR_', SNR, '_Foff_'...
                , Foff, '_Nframe_', NFrame, '_Nstart_', NStart, '.txt');
        case 'V1'
            path = strcat('V1_GroupID_1D_FreqID_40_SNR_', SNR, '_Foff_'...
                , Foff, '_Nframe_', NFrame, '_Nstart_', NStart, '.txt');
        case 'V2'
            path = strcat('V2_GroupID_1D_FreqID_40_SNR_', SNR, '_Foff_'...
                , Foff, '_Nframe_', NFrame, '_Nstart_', NStart, '.txt');
        case 'V3'
            path = strcat('V3_GroupID_1D_FreqID_40_SNR_', SNR, '_Foff_'...
                , Foff, '_Nframe_', NFrame, '_Nstart_', NStart, '.txt');
        case 'ScrambledV0'
            path = strcat('ScrambledV0_GroupID_1D_FreqID_40_SNR_', SNR, '_Foff_'...
                , Foff, '_Nframe_', NFrame, '_Nstart_', NStart, '.txt');
        case 'ScrambledV1'
            path = strcat('ScrambledV1_GroupID_1D_FreqID_40_SNR_', SNR, '_Foff_'...
                , Foff, '_Nframe_', NFrame, '_Nstart_', NStart, '.txt');
        case 'ScrambledV2'
            path = strcat('ScrambledV2_GroupID_1D_FreqID_40_SNR_', SNR, '_Foff_'...
                , Foff, '_Nframe_', NFrame, '_Nstart_', NStart, '.txt');
        case 'ScrambledV3'
            path = strcat('ScrambledV3_GroupID_1D_FreqID_40_SNR_', SNR, '_Foff_'...
                , Foff, '_Nframe_', NFrame, '_Nstart_', NStart, '.txt');
        case 'Tn'
            path = strcat('Tn_GroupID_1D_FreqID_40_SNR_', SNR, '_Foff_'...
                , Foff, '_Nframe_', NFrame, '_Nstart_', NStart, '.txt');
        case 'Rn'
            path = strcat('Rn_GroupID_1D_FreqID_40_SNR_', SNR, '_Foff_'...
                , Foff, '_Nframe_', NFrame, '_Nstart_', NStart, '.txt');
    end          
end

