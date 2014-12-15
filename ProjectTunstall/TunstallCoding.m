%%m script

%%��Ϣ�ۻ��������ҵ����Tunstall�����(����D=2,K=2,N����ȡ)
%  ����
%  0 �������01����
%  1 ����Tunstall��
%  2&3 �����ʵ�Lexicon&����
%  4 ����
%  5 ������

%% @version 1.2 ���ӽ��������������еĶԱ�
%    @author RenaicC
%    @date 2014-10-23 23:04:04

%%
clc;
close all;
clear all;

%% --------------PART0: ����01�������-----------------
%������Ϣ
N=4;  % block length�������޸�
D=2;  % D-ary code
K=2;  % K source lex
p=0.6; % P(x=1)=0.6,P(x=0)=0.4,�����޸�
q=floor((D^N-K)/(K-1)); % number of steps of building the Tunstall tree ��
M=K+q*(K-1); 

seqLength=1000; %length of the source
ran=random('unid',1000,[1,seqLength]);
source=floor(mod(ran,10)/(10*(1-p))); % 0 1 sequence,P(x=1)=0.6,P(x=0)=0.4
in=find(source>1);
source(in)=1;
per=sum(source)/seqLength;%����������֤1�ĸ����Ƿ���p����
%source=[0 0 0 1 1 1 1 1 1 1 1 0 1 0 1 1 1 1 0 0 0 0 0 1  1 1];%for debug

%% ---------------PART1: ����Tunstall�� -----------------
%��������
root.left=0; %root
root.right=0;
root.parent=0;
root.probability=1;
root.level=0;
root.val=-1;
root.label=-1;
%����buildTunstallTree�������������ƽ�����볤��
[TunstallTree averageMLength]=buildTunstallTree(root,q,p);

%% -----------------PART2&3: ����&�����ֵ�-----------------
cL=ceil(log2(M));% here N==cL
lexicon=cell(1,2^cL);%�����ֵ�
coded=[];%����������(ʮ����)
codedBinary=[];%����������(������)
lexSrc=[];%��¼��������Ҷ�ӵ�·��
index=1;
for t=1:length(source) 
    if source(t)==1  % source==1
        index=TunstallTree(index).left;
        lexSrc=[lexSrc '1'];
    else %soutce==0
        index=TunstallTree(index).right;
        lexSrc=[lexSrc '0'];
    end
    if TunstallTree(index).left==0%�ɹ��ִ�һ��Ҷ��,�ɹ��ҵ�
        %��Ҷ���ϵ����ִ�ʮ����ת��Ϊ������
        s=num2str(TunstallTree(index).val);
        sn=dec2bin(TunstallTree(index).val,cL);
        %st=mat2str(sn);
        %codedBinary=strcat(codedBinary,sn);
        codedBinary=[codedBinary sn];
        coded=[coded s];
        %display(TunstallTree(index).val+1);
        if(  TunstallTree(index).label==-1) % add to the lexicon
            lexicon{1,TunstallTree(index).val+1}=lexSrc;%value(0~2^cL-1)
        end
        lexSrc=[];%·�����㣬���¿�ʼ
        TunstallTree(index).label=1;
        index=1;%return to the root
    end
end

%����
%�ֵ� lexicon
%���� lexicon  codedBinary 
%��� deSource
%% -----------------------PART4: ����---------------------
ncodedBinary=codedBinary-'0';%ת��Ϊdouble����
deSource=[];
for nn=1:length(ncodedBinary)/cL
     cw=ncodedBinary(cL*nn-cL+1:nn*cL);
     cwDec=0;
     for mm=1:cL
         cwDec=cwDec+cw(mm)*2^(cL-mm);
     end
     deSource=[deSource lexicon{1,cwDec+1}];%���ֵ��ж�Ӧλ���ҵ�Դ��Ϣ
end

%% -----------PART5: Display the result---------
oriStr=num2str(source);
oriStr(oriStr==' ') = '';
display('Դ����');
display(oriStr);
display('�����');
display(codedBinary);
display('�����');
display(deSource);
display('�ֵ�');
display(lexicon);
display('ƽ�����ֳ�');
display(averageMLength);
display('N/E(L)');
R=N/averageMLength;
display(R);