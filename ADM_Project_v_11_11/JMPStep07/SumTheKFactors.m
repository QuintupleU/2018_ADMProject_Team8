function [EDS,kVec]=SumTheKFactors(M, Vars, BL)

% M is a matrix specific to a technology combination. The rows correspond
% to the EDS varaibles. The columns are the Technologies. If a technology
% is not activated, the entries in its column should all equal 0. If a
% technology is turned on, its column should contain the technology's
% respective k factors for the design variables.
% Vars is the ordered list of EDS variable names. Its entries should
% correspond to the rows of M.
% BL is the baseline variable vector. 
% k is the vector of new EDS variables after technology infusion.

    [r,~]=size(M);
    if r~=length(BL)
        error('Baseline vector and Technology Impact Matrix dimension mismatch')
    end
    if r~=length(BL)
        warning('Variable name vector and Technology Impact Matrix mismatch')
    end
    EDS=0*BL;
    kVec=EDS;
    for i=1:r
        if strcmp(Vars(i),'TRLN')
            EDS(i)=BL(i)+sum(M(i,:));
            kVec(i)=sum(M(i,:));
        elseif strcmp(Vars(i),'TRUN')
            EDS(i)=BL(i)+sum(M(i,:));
            kVec(i)=sum(M(i,:));
        elseif strcmp(Vars(i),'FCDO')
            EDS(i)=BL(i)*(1+sum(M(i,:)));
            kVec(i)=EDS(i)/BL(i)-1;
        elseif strcmp(Vars(i),'FRFU')
            EDS(i)=BL(i)*(prod(1+M(i,:)));
            kVec(i)=EDS(i)/BL(i)-1;
        elseif strcmp(Vars(i),'FRHT')
            EDS(i)=BL(i)*(prod(1+M(i,:)));
            kVec(i)=EDS(i)/BL(i)-1;
        elseif strcmp(Vars(i),'FRVT')
            EDS(i)=BL(i)*(prod(1+M(i,:)));
            kVec(i)=EDS(i)/BL(i)-1;
        elseif strcmp(Vars(i),'FRWI')
            EDS(i)=BL(i)*(prod(1+M(i,:)));
            kVec(i)=EDS(i)/BL(i)-1;
        elseif strcmp(Vars(i),'FRWI1')
            EDS(i)=BL(i)*(prod(1+M(i,:)));
            kVec(i)=EDS(i)/BL(i)-1;
        elseif strcmp(Vars(i),'FRWI1')
            EDS(i)=BL(i)*(prod(1+M(i,:)));
            kVec(i)=EDS(i)/BL(i)-1;
        elseif strcmp(Vars(i),'XLLAM')
            if sum(M(i,:))>=1
                EDS(i)=1;
            else
                EDS(i)=0;        
            end
            kVec(i)=EDS(i)-BL(i);
        elseif strcmp(Vars(i),'AR')
            EDS(i)=max([BL(i) M(i,:)]);
            kVec(i)=EDS(i)/BL(i)-1;
        elseif strcmp(Vars(i),'WSR')
            EDS(i)=BL(i)*(1+sum(M(i,:)));
            kVec(i)=EDS(i)/BL(i)-1;
        else
            EDS(i)=BL(i)*(1+sum(M(i,:)));
            kVec(i)=EDS(i)/BL(i)-1;
        end
    end                
end