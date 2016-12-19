%% BEC�ŵ��������ܲ��� 
% er BEC �����������
% ep ���ͼ��߽� 
% cNum�������ָ���
% n col��  ÿ�����ֳ�Ϊn
% 2014-12-02
% renaic@mai.ustc.edu.cn
% Ĭ�ϲ���
ep=0.2;
er=0.01;
cNum=15;
n=10;
sucRates=[];
for i=5:15 % n�仯 5~15
    sucRates(i-4) = BEC_Test( ep, er, i, cNum );
end
figure;
stem(5:15,sucRates);
title('n�仯');
sucRates=[];
for i=1:8 % ep�仯��0.1~0.8
    sucRates(i) = BEC_Test( i/10, er, n, cNum );
end
figure;
stem((1:8)/10,sucRates);
title('ep�仯');
sucRates=[];
for i=1:8 % er�仯��0.01~0.08
    sucRates(i) = BEC_Test( ep, i*0.01, n, cNum );
end
figure;
stem((1:8)/100,sucRates);
title('er�仯');
sucRates=[];
for i=10:20 % cNum�仯��10-20
    sucRates(i-9) = BEC_Test( ep, er, n, i );
end
figure;
stem(10:20,sucRates);
title('cNum�仯');
