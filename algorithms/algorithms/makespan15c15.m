function [minmakespan,starts,ends]=makespan15c15(gen) 
T=[21	55	71	98	12	34	16	21	53	26	52	95	31	42	39
   54	83	77	64	34	79	43	55	77	19	37	79	92	62	66
   83	77	87	38	60	98	93	17	41	44	69	49	24	87	25
   77	96	28	7	95	35	35	76	9	95	43	75	61	10	79
   87	28	50	59	46	45	9	43	52	27	91	41	16	59	39
   20	71	78	66	14	8	42	28	54	33	89	26	37	33	43
   69	96	17	69	45	31	78	20	27	87	74	84	76	94	81
   58	90	76	81	23	28	18	32	86	99	97	24	45	72	25
   27	46	67	27	19	80	17	48	62	12	28	98	42	48	50
   37	80	75	55	50	94	14	41	72	50	61	79	98	18	63
   65	96	47	75	69	58	33	71	22	32	57	79	14	31	60
   34	47	58	51	62	44	8	17	97	29	15	66	40	44	38
   50	57	61	20	85	90	58	63	84	39	87	21	56	32	57
   84	45	15	41	18	82	29	70	67	30	50	23	20	21	38
   37	81	61	57	57	52	74	62	30	52	38	68	54	54	16];
js=[5	4	7	15	11	3	10	2	1	8	9	6	13	12	14
    12	5	2	8	9	15	13	1	4	7	10	6	11	14	3
    10	6	3	8	5	13	1	14	7	11	4	12	9	2	15
    6	1	10	7	5	14	8	9	12	13	3	2	11	15	4
    11	5	9	3	1	12	15	10	7	8	2	14	4	6	13
    1	3	5	14	4	13	15	7	2	10	12	9	8	11	6
    9	5	13	1	8	12	7	11	4	14	2	6	15	3	10
    5	14	12	4	8	10	2	3	13	9	15	1	11	7	6
    6	2	7	9	14	11	3	4	8	12	15	5	1	10	13
    12	6	5	9	8	1	10	7	15	4	11	14	3	13	2
    8	4	1	5	13	15	11	2	10	14	6	9	3	12	7
    2	3	4	6	5	7	10	8	11	9	12	14	13	1	15
    4	8	14	6	12	13	3	5	11	2	10	7	15	9	1
    10	8	6	15	11	5	12	3	2	4	14	7	1	13	9
    10	11	12	15	9	1	8	7	13	2	3	14	5	4	6]; 
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