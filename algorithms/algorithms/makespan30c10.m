function [minmakespan,starts,ends]=makespan30c10(gen) 
T=[21	26	16	34	55	52	95	71	21	53
   77	98	42	66	31	39	77	79	55	12
   64	92	34	19	62	54	43	83	79	37
   93	24	69	38	77	87	60	41	87	83
   77	44	96	79	75	98	25	17	43	49
   76	35	28	95	95	61	35	7	9	10
   91	27	50	16	28	59	52	46	59	43
   45	71	39	87	14	54	41	43	9	20
   37	26	33	42	78	89	8	66	28	33
   74	69	84	27	81	45	69	94	78	96
   76	32	18	20	87	17	25	24	31	81
   97	90	28	86	58	72	23	76	99	45
   48	27	67	62	98	42	46	27	48	17
   80	19	28	12	94	63	98	50	80	50
   50	41	61	79	14	72	18	55	37	75
   22	57	75	14	65	96	71	47	79	60
   32	69	44	31	51	33	34	58	47	58
   66	40	17	62	38	8	15	29	44	97
   50	58	21	63	57	32	20	87	57	39
   20	67	85	90	70	84	30	56	61	15
   29	82	18	38	21	50	23	84	45	41
   54	37	62	16	52	57	54	38	74	52
   79	61	11	81	89	89	57	68	81	30
   24	66	32	33	8	20	84	91	55	20
   54	64	83	40	8	7	19	56	39	7
   6	74	63	64	15	42	98	61	40	91
   80	75	26	87	22	39	24	75	44	6
   8	79	61	15	12	43	26	22	20	80
   36	63	10	22	96	40	5	18	33	62
   8	15	64	95	96	38	18	23	64	89];    
js=[5	8	10	3	4	9	6	7	2	1
    9	6	2	8	3	4	7	10	5	1
    3	5	4	2	9	7	8	1	10	6
    1	9	4	8	6	3	5	7	2	10
    10	1	5	9	7	3	6	4	8	2
    4	3	6	1	8	5	9	2	7	10
    2	8	9	4	5	6	7	1	3	10
    2	8	3	1	9	7	4	10	6	5
    3	4	5	10	1	7	8	9	2	6
    2	1	6	4	10	8	9	3	7	5
    6	8	7	1	4	3	10	5	2	9
    10	9	6	8	1	2	3	7	4	5
    10	6	7	8	5	1	2	9	4	3
    10	4	6	2	5	7	8	9	1	3
    3	2	5	9	6	10	8	4	7	1
    10	6	5	3	8	4	2	1	9	7
    4	3	5	2	10	1	7	6	8	9
    9	8	3	1	10	6	7	4	2	5
    4	3	7	5	8	9	6	10	1	2
    5	7	2	3	8	1	9	6	4	10
    7	1	5	4	8	9	2	6	3	10
    4	10	7	6	1	9	5	3	8	2
    5	2	9	1	8	7	6	4	10	3
    10	2	5	4	9	3	7	1	8	6
    4	3	7	10	8	1	5	6	2	9
    2	5	1	3	10	7	8	9	6	4
    2	4	1	3	10	8	9	5	7	6
    6	4	7	2	1	8	9	10	3	5
    2	1	8	5	4	6	10	9	7	3
    5	9	3	4	2	7	8	10	6	1];  
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