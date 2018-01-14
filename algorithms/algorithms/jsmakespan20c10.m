function minmakespan=jsmakespan20c10(gen) 
%js is the job sequence matrix 
T=[52	26	71	16	34	21	95	21	53	55
   55	98	39	79	12	77	77	66	31	42
   37	92	64	54	19	43	83	34	79	62
   87   77  93	69	87	38	24	41	83	60
   98	25	75	77	49	17	79	44	43	96
   7	61	95	35	10	35	28	76	95	9
   59	43	46	28	52	16	59	91	50	27
   9	43	14	71	20	54	41	87	45	39
   28	66	78	37	42	26	33	89	33	8
   96	27	78	84	94	69	74	81	45	69
   24	32	25	17	87	81	76	18	31	20
   90	28	72	86	23	99	76	97	45	58
   17	98	48	46	27	67	62	42	48	27
   80	50	19	98	28	50	94	63	12	80
   72	75	61	79	37	50	14	55	18	41
   96	14	57	47	65	75	79	71	60	22
   31	47	58	32	44	58	34	33	69	51
   44	40	17	62	66	15	29	38	8	97
   58	50	63	87	57	21	57	32	39	20
   85	84	56	61	15	70	30	90	67	20]; 
js=[9 8 7 10 3 2 6 5 1 4
    5 6 4 10 1 9 7 8 3 2
    6 5 3 7 2 8 1 4 10 9
    2 6 1 4 3 8 9 7 10 5
    3 6 7 10 2 4 9 1 8 5
    2 5 1 3 10 9 6 4 8 7
    6 10 1 5 7 4 3 2 9 8
    6 10 9 8 5 7 4 1 2 3
    2 9 1 3 10 4 6 7 5 8
    5 4 7 6 3 9 2 10 8 1
    5 8 10 3 4 9 6 7 2 1
    9 6 2 8 3 4 7 10 5 1
    3 5 4 2 9 7 8 1 10 6
    1 9 4 8 6 3 5 7 2 10
    10 1 5 9 7 3 6 4 8 2
    4 3 6 1 8 5 9 2 7 10
    2 8 9 4 5 6 7 1 3 10
    2 8 3 1 9 7 4 10 6 5
    3 4 5 10 1 7 8 9 2 6
    2 1 6 4 10 8 9 3 7 5];
[n,m]=size(T); 
wpn=length(gen); 
starts=zeros(m,n); 
ends=zeros(m,n); 
jp=zeros(1,n);%job working procedure 
mj=zeros(m,1);% job on machine 
mjn=zeros(m,n); 
for i=1:wpn 
    jp(gen(i))=jp(gen(i))+1; 
    mj(js(gen(i),jp(gen(i))))=mj(js(gen(i),jp(gen(i))))+1; 
    mjn(js(gen(i),jp(gen(i))),gen(i))=mj(js(gen(i),jp(gen(i)))); 
    if jp(gen(i))==1 
       if mj(js(gen(i),1))==1 
          starts(js(gen(i),1),1)=0; 
          ends(js(gen(i),1),1)=T(gen(i),1); 
       else 
          starts(js(gen(i),1),mj(js(gen(i),1)))=ends(js(gen(i),1),mj(js(gen(i),1))-1); 
          ends(js(gen(i),1),mj(js(gen(i),1)))=starts(js(gen(i),1),mj(js(gen(i),1)))+T(gen(i),1); 
       end 
    else 
       if mj(js(gen(i),jp(gen(i))))==1 
          starts(js(gen(i),jp(gen(i))),1)=ends(js(gen(i),jp(gen(i))-1),mjn(js(gen(i),jp(gen(i))-1),gen(i))); 
          ends(js(gen(i),jp(gen(i))),1)=starts(js(gen(i),jp(gen(i))),1)+T(gen(i),jp(gen(i))); 
       else 
          starts(js(gen(i),jp(gen(i))),mj(js(gen(i),jp(gen(i)))))=max(ends(js(gen(i),jp(gen(i))),mj(js(gen(i),jp(gen(i))))-1),ends(js(gen(i),jp(gen(i))-1),mjn(js(gen(i),jp(gen(i))-1),gen(i)))); 
          ends(js(gen(i),jp(gen(i))),mj(js(gen(i),jp(gen(i)))))=starts(js(gen(i),jp(gen(i))),mj(js(gen(i),jp(gen(i)))))+T(gen(i),jp(gen(i))); 
       end 
    end 
end 
minmakespan=max(max(ends)); 