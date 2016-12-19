function sucRate = BEC_Test( ep, er, n, cNum )
%% BEC�ŵ��������ܲ��� 
% er BEC �����������
% ep ���ͼ��߽� 
% cNum�������ָ���
% n col��  ÿ�����ֳ�Ϊn
% 2014-12-02
% renaic@mai.ustc.edu.cn
R=1-er;
%C=1-er;
nRInt=ceil(n*R);
m=power(2,nRInt); % 2^nR ������
%% ����������е��أ������ؼ�����ͼ������½�
Hy=-((1-er)*log2((1-er)/2)+er*log2(er));
HyU=Hy+ep; % �������е��ͼ������½�
HyL=Hy-ep;
Hxy=-((1-er)*log2((1-er)/2)+er*log2(er/2));
HxyU=Hxy+ep; % �����������ϵ��͵����½�
HxyL=Hxy-ep;
xBook = random('Binomial',1,0.5,m,n); % 0-1  Bernoulli��1/2���뱾
%% ���Ͷ�����֣��������ָ���ΪcNum�������ѡȡ
wSeq=random('Discrete Uniform',m,1,cNum); 
wd=[]; % ��������
deCoded=[]; % ���ܵ������н��������У�����ʱ��-1
HyRcv=0; 
countSuc=0; % ��ȷ�������
for i=1:cNum
    wd=[wd xBook(wSeq(i),:)];  % wd ��������
end
wdTrans=wd; % wdTrans ������ɵ�����
bitSent=length(wd);
for i=1:bitSent
    if (random('Binomial',1,er,1,1)==1) %����
        wdTrans(i)=-1;
    end
end

%% ����: �ֱ������������Ƿ���ͣ����ϵ���
for k=1:cNum %һ���յ�cNum��
    wdTrans1=wdTrans((k-1)*n+1:k*n); %ȡ���������� 
    label=[]; %���벾���ϵ��͵ı��
    for i=1:n % ����������е�log(y^n)
        if(wdTrans1(i)==-1) %�յ�-1
            HyRcv=HyRcv+log2(er);
        else %�յ�0����1
            HyRcv=HyRcv+log2((1-er)/2);
        end
    end
    HyRcv=-HyRcv/n; %�������е�log(y^n) 
    
    xBookUni=unique(xBook,'rows');
    [mN, ~]=size(xBookUni); %�Ƚ�ʱ��ֹ�����ظ�����,���½���������
    if(HyRcv>HyU || HyRcv<HyL) 
            display('���ܵ������в��ǵ�������');
            %display('����ʧ�ܣ�')
            deCoded=[deCoded -ones(1,n)]; %������ʧ�ܵı��Ϊ-1
            continue; % ���ǵ������У����ü����Ƿ����ϵ���
    end
    display('�յ��������У�');
    for j=1:mN %��ÿ������һһ�Ƚ�
        HxyRcvJ=0; %log(x^n,y^n)
        wdT=xBookUni(j,:); % ��J������
        for i=1:n
            if(wdTrans1(i)~=wdT(i)) %�յ�-1,������
                HxyRcvJ=HxyRcvJ+log2(er/2);
            else %�յ�0����1��δ������
                HxyRcvJ=HxyRcvJ+log2((1-er)/2);
            end
        end
        HxyRcvJ=-HxyRcvJ/n;
        if(HxyRcvJ>=HxyL && HxyRcvJ<=HxyU)
            display('�ҵ����ϵ�������');
            display(k);
            display(HxyRcvJ)
            label=[label j]; %�������ϵ��͵Ľ�����
            display(label);
        end
    end
    if(length(label)~=1)
        display('����ʧ�ܣ�') %���Ǵ����Ҵ���Ψһһ���±�
        deCoded=[deCoded -ones(1,n)]; %������ʧ�ܵı��Ϊ-1
    else
        countSuc=countSuc+1;
        display('�ɹ����һ�����֣�');
        deCoded=[deCoded xBookUni(label(1),:)];
    end
end
display('����ɹ���');
sucRate=countSuc/cNum;
display(sucRate);
end

