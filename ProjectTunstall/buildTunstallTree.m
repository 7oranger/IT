function [tree averageMLength]=buildTunstallTree(root,q,p)
% Function: buildTunstallTree������Tunstall �� (����D=2,K=2)
% Input: root  q( q steps) p(probability of one of the source lex) 
% Output: the built Tunstall tree; the average message length
%       ���� �����ڵ� ��������q ��Դȡ1�ĸ���p
%       ��� ���õ�����ƽ�����볤

%% @version 1.2 ���Ӽ���ƽ����ֵ���Ĳ���
%    @author RenaicC
%    @date 2014-10-23 22:53:21

%%
tree(1)=root;
select=1;
count=numel(tree); %    N = numel(A) returns the number of elements, Num, in array A(tree).

%% ----------------------Build the tree----------------------%
for ii=0:q
    maxPro=0;
    for k=1:count  % for: to select the maximum probability and its node (kk)
        if (tree(k).probability>maxPro)&&(tree(k).left==0)
            maxPro=tree(k).probability;
            select=k;
        end%end if
    end%end for
    % add the new tree to the chosen node
    tree(select).left=count+1;%left child
    tree(select).right=count+2;%right child
    tree(count+1).parent=select; %parent
    tree(count+2).parent=select;
    tree(count+1).level=tree(select).level+1; %level
    tree(count+2).level=tree(select).level+1;
    tree(count+1).probability=tree(select).probability*p;  %multiple by p(left child)
    tree(count+2).probability=tree(select).probability*(1-p);  %multiple by 1-p(right child)
    tree(count+1).val=-1;%val codeword ��ű�������
    tree(count+1).label=-1;
    tree(count+2).val=-1;
    tree(count+2).label=-1;
    %create new  empty node    
    tree(count+1).left=0;
    tree(count+2).left=0;
    tree(count+1).right=0;
    tree(count+2).right=0;
    count=numel(tree);
end%end for
%% Ϊ���ϵ�Ҷ�Ӹ�����, ��ƽ�����ֳ�
%%---------give the codeword for the leaf and calculate the average message lenght------
averageMLength=0;
M=2*q+2;
cL=ceil(log2(M));%fixed length
%cL==N
jj=0;%�����Ƕ������֣������ָ�ֵΪ0~2^N-1����
for k=1:count
%     disp(k);
%     disp(tree(k).level);
%     disp(tree(k).probability);
    if tree(k).left==0 %is leaf ΪҶ�Ӹ�ֵ�������ֽڵ㣩
        tree(k).val=jj;
        jj=jj+1;
    else 
        averageMLength=averageMLength+tree(k).probability;%�ڽ��ĸ��ʺͼ�ƽ�����ֳ�
    end %end if
end%end for

