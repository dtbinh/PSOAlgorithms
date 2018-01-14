function minmakespan=jsmakespan15c10(gen) 
%js is the job sequence matrix 
T=[34	55	95	16	21	71	53	52	21	26
   39	31	12	42	79	77	77	98	55	66
   19	83	34	92	54	79	62	37	64	43
   60	87	24	77	69	38	87	41	83	93
   79	77	98	96	17	44	43	75	49	25
   35	95	9	10	35	7	28	61	95	76
   28	59	16	43	46	50	52	27	59	91
   9	20	39	54	45	71	87	41	43	14
   28	33	78	26	37	8	66	89	42	33
   94	84	78	81	74	27	69	69	45	96
   31	24	20	17	25	81	76	87	32	18
   28	97	58	45	76	99	23	72	90	86
   27	48	27	62	98	67	48	42	46	17
   12	50	80	50	80	19	28	63	94	98
   61	55	37	14	50	79	41	72	18	75];
js=[3	4	6	10	5	7	1	9	2	8
    4	3	1	2	10	9	7	6	5	8
    2	1	4	5	7	10	9	6	3	8
    5	3	9	6	4	8	2	7	10	1
    9	10	3	5	4	1	8	7	2	6
    9	8	7	10	3	2	6	5	1	4
    5	6	4	10	1	9	7	8	3	2
    6	5	3	7	2	8	1	4	10	9
    2	6	1	4	3	8	9	7	10	5
    3	6	7	10	2	4	9	1	8	5
    2	5	1	3	10	9	6	4	8	7
    6	10	1	5	7	4	3	2	9	8
    6	10	9	8	5	7	4	1	2	3
    2	9	1	3	10	4	6	7	5	8
    5	4	7	6	3	9	2	10	8	1]; 
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