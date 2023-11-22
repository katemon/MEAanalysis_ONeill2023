function [globalBursts_beginI, globalBursts_endI, globalBursts_Elecs, globalBursts_NumBInGB, ...
    globalBursts_width_iter, globalBursts_AvgWidth_iter, globalBursts_AvgWidth_sec, globalBursts_AvgNumBInGB, ...
    NumGlobalBursts, globalIBI_iter, globalIBI_iterAvg, globalIBI_secAvg] ...
    = detectGlobalBursts(NumBurstlets, BBegin_iter, BEnd_iter, burstElectrode, fs)

if NumBurstlets>=2
    TheOverlap = BBegin_iter(2:end) - BEnd_iter(1:end-1);
    particOverlap = TheOverlap;
    particOverlap(TheOverlap<0) = 1;
    particOverlap(TheOverlap>0) = 0;
    [r1,~] = find(particOverlap==1);
    checkOverlap = particOverlap(2:end) - particOverlap(1:end-1);
    [r2,~] = find(checkOverlap==1 | checkOverlap==-1);
    %if you start in the middle of a burst, you want to go to the next one
    %essentially don't count first or last burst bc you don't know where in the
    %burst the recording started
    [firstpos1,~] = find(checkOverlap==1);
    if ((~isempty(firstpos1)) && (length(r2)>1))
        [r2start,~] = find(r2==firstpos1(1));
        GBcount = 0;
        for ii=r2start:2:length(r2)
            begr2 = r2(ii); %1
            if ((ii==length(r2)) && (rem(ii,2)>0))
                %don't count last one
                disp('odd total number')
                break
            elseif ((ii==length(r2)) && (rem(ii,2)==0))
                %the end
                disp('even total number')
                break
            else
                endr2 = r2(ii+1); %15
                CheckIfRight = TheOverlap(begr2+1:endr2); %2 to 15
                if ~isempty(CheckIfRight(CheckIfRight>0))
                    disp('error!');
                    disp(ii);
                    break
                else
                    GBcount = GBcount+1;
                    FirstBurst = begr2 + 1; %2
                    LastBurst = endr2 + 1; %16
                    GBsize = LastBurst - FirstBurst + 1;
                    globalBursts_beginI(GBcount) = BBegin_iter(FirstBurst); %in interations
                    globalBursts_endI(GBcount) = BEnd_iter(LastBurst); %in interations
                    globalBursts_Elecs{GBcount} = burstElectrode(FirstBurst:LastBurst);
                    globalBursts_NumBInGB(GBcount) = GBsize;
                end %if length
            end %if ii=length(r2)
        end %for ii
        if GBcount==0
            globalBursts_beginI = [];
            globalBursts_endI = [];
            globalBursts_Elecs = [];
            globalBursts_NumBInGB = [];
            globalBursts_width_iter = []; %in interations
            globalBursts_AvgWidth_iter = 0;
            globalBursts_AvgWidth_sec = 0;
            globalBursts_AvgNumBInGB = 0;
            NumGlobalBursts = 0;
            globalIBI_iter = [];
            globalIBI_iterAvg = [];
            globalIBI_secAvg = [];
        else
            %Transpose
            globalBursts_NumBInGB = reshape(globalBursts_NumBInGB,[length(globalBursts_NumBInGB), 1]);
            globalBursts_beginI = reshape(globalBursts_beginI,[length(globalBursts_NumBInGB), 1]);
            globalBursts_endI = reshape(globalBursts_endI,[length(globalBursts_NumBInGB), 1]);
            globalBursts_Elecs = reshape(globalBursts_Elecs,[length(globalBursts_NumBInGB), 1]);
            
            %Elim if < 3 bursts in a global burst
            [r3,~] = find(globalBursts_NumBInGB>=3);
            globalBursts_beginI = globalBursts_beginI(r3); %in interations
            globalBursts_endI = globalBursts_endI(r3); %in interations
            globalBursts_Elecs = globalBursts_Elecs(r3);
            globalBursts_NumBInGB = globalBursts_NumBInGB(r3);
            
            if length(globalBursts_beginI)<1 %if the only GlobalBursts have < 3 electrodes involved
                globalBursts_width_iter = []; %in interations
                globalBursts_AvgWidth_iter = 0;
                globalBursts_AvgWidth_sec = 0;
                globalBursts_AvgNumBInGB = 0;
                NumGlobalBursts = 0;
                globalIBI_iter = [];
                globalIBI_iterAvg = [];
                globalIBI_secAvg = [];
            else
                globalBursts_width_iter = globalBursts_endI - globalBursts_beginI; %in interations
                globalBursts_AvgWidth_iter = mean(globalBursts_width_iter);
                globalBursts_AvgWidth_sec = globalBursts_AvgWidth_iter/fs;
                globalBursts_AvgNumBInGB = mean(globalBursts_NumBInGB);
                NumGlobalBursts = length(globalBursts_beginI);
                globalIBI_iter = globalBursts_endI(2:end) - globalBursts_beginI(1:end-1);
                globalIBI_iterAvg = mean(globalIBI_iter);
                globalIBI_secAvg = globalIBI_iterAvg/fs;
            end %if length
        end %if GBcount==0
    else
        globalBursts_beginI = [];
        globalBursts_endI = [];
        globalBursts_Elecs = [];
        globalBursts_NumBInGB = [];
        globalBursts_width_iter = []; %in interations
        globalBursts_AvgWidth_iter = 0;
        globalBursts_AvgWidth_sec = 0;
        globalBursts_AvgNumBInGB = 0;
        NumGlobalBursts = 0;
        globalIBI_iter = [];
        globalIBI_iterAvg = [];
        globalIBI_secAvg = [];
    end %if ~isempty
    
else
    globalBursts_beginI = [];
    globalBursts_endI = [];
    globalBursts_Elecs = [];
    globalBursts_NumBInGB = [];
    globalBursts_width_iter = []; %in interations
    globalBursts_AvgWidth_iter = 0;
    globalBursts_AvgWidth_sec = 0;
    globalBursts_AvgNumBInGB = 0;
    NumGlobalBursts = 0;
    globalIBI_iter = [];
    globalIBI_iterAvg = [];
    globalIBI_secAvg = [];
    
end %if NumBurstlets>2

end %function