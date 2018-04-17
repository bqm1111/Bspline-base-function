function base=basefunc(t,x,p,k)
% t: sequence of node
% x: current point taken into consideration
% p: degree of Bspline
node_num=length(t);   %% number of nodes
cp_num=node_num-p-1;   %% number of control points
if(k<0)
    if x==t(cp_num+1)
        cur=cp_num+1;
    else
        for i=1:(cp_num)
            if(t(i)<=x)&&(t(i+1)>x)
                cur=i;          %% current considering interval
                break;
            end
        end
    end
else
    cur=k;
end
display(cur);
N=sym(zeros(1,node_num-1));  % khoi tao cac ham spline bac 0
N(cur)=1;           % cho gia tri cua ham tai khoang dang xet toi =1
% display(cp_num,'cp_num');
display(N)
for j=1:p
    A = sym(zeros(1,length(N)-1));
    for i=1:(length(N)-1)
        if (i+j+1<=p+1)
            A(i) = 0;
        else
            if(i+j<=p+1)&&(i+j+1>p+1)
            A(i)=vpa((t(i+j+1)-x)/(t(i+j+1)-t(i+1))*N(i+1));
        else
                if(i+1>=cp_num+1)&&(i<cp_num+1)
               A(i)= vpa((x-t(i))/(t(i+j)-t(i))*N(i));
                else
                    if (i>=cp_num+1)
                        A(i)=0;
                    else
                    A(i)=vpa((x-t(i))/(t(i+j)-t(i))*N(i)+(t(i+j+1)-x)/(t(i+j+1)-t(i+1))*N(i+1));  
                    end
                end
            end
        end
        
    end
display(A)
    N(end)=[];
        for k=1:(length(A))
            N(k)=A(k);
        end
end
base=N;
end
