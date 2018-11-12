clear
[~,~,raw]=xlsread('Revised TIM_Team8_300pax.xlsx','BareTIM');
[~,~,TCMraw]=xlsread('Revised TIM_Team8_300pax.xlsx','Compatibility_Matrix');
[TechCombos,~,~]=xlsread('TechnologyCombinationTable.xlsx');
%%
% Eliminate incompatible technology combinations:
[r,c]=size(TechCombos);
TCM=cell2mat(TCMraw(2:end,2:end));
incompatibles=zeros(r,1)-1;
for m=1:r
    t=TechCombos(m,:);
    if sum(t)>3
        incompatibles(m)=1;
    else
        for n=1:c
            if t(n)==1
                for b=n:c
                    if t(b)==1 && TCM(n,b)==0 
                        incompatibles(m)=1;
                    end
                end
            end
        end
    end
end

%[r,c]=size(TechCombos);
if ~strcmp(raw(1,2:end-1), TCMraw(1,2:end))
    warning('TCM technologies and TIM technologies mismatch.')
end

Vars=raw(2:end,1);
TIM=cell2mat(raw(2:end,2:end-1));
BL=cell2mat(raw(2:end,end))';
VarsForTechCombos=zeros(r,length(BL));
kFacsForTechCombos=VarsForTechCombos;

%Calculate the EDS design Variables and k-factor vectors for the Technologies 
for k=1:r
    TechCombo=TechCombos(k,:);
    M=0*TIM;
    for j=1:length(BL)
        M(j,:)=TIM(j,:).*TechCombo;
    end
    [VarsForTechCombos(k,:), kFacsForTechCombos(k,:)]=SumTheKFactors(M,Vars,BL);
end
FinalResult=[incompatibles, TechCombos,  kFacsForTechCombos, VarsForTechCombos];
xlswrite('TechComboEDSVars.xlsx',FinalResult);