--create
create table emp_bkp as select * from emp;
create table emp_bkp_1 as select * from emp where 1=2;
select * from EMP_BKP;
select * from EMP_BKP_1;
--insert
--1.direct
--2.dynamic
--3. using table data
insert into EMP_BKP_1 select  * from EMP_BKP;
--update
update EMP_BKP_1 set ename='Kishore', job='PROGRAMER' where empno=7369;
--order by
select * from EMP_BKP_1 where deptno=20 order by HIREDATE, ename;

select job,mgr from EMP_BKP_1  order by job;

select job,mgr from EMP_BKP_1  order by job,mgr;

select * from EMP_BKP_1 where deptno=20 order by 1;
select job,mgr from EMP_BKP_1  order by 1,2;
select job,mgr from EMP_BKP_1  order by job asc,mgr desc;

-- group by.. aggrigate functions
select DEPTNO from EMP_BKP_1 group by DEPTNO;--3 rows
select DEPTNO from EMP_BKP_1 group by DEPTNO,job; --10-3 20-4  30 - 3

--aggrigate: MIN MAX COUNT SUM AVG
select MIN(sal) from EMP_BKP_1;
select MIN(sal) as MIN_SAL from EMP_BKP_1;
select MIN(sal) MIN_SAL from EMP_BKP_1;
select MIN(sal) as "Min_Sal" from EMP_BKP_1;

select deptno, MIN(sal) from EMP_BKP_1 group by deptno;
select ename,JOB,MAX(sal) from EMP_BKP_1 group by ename,JOB;
--1. columns defined in SELECT, should be present in group by
--2. columns defined in group by, may or may not present in SELECT
--3. Aggr. functions not required to define in group by
select deptno,MAX(sal) from EMP_BKP_1 group by deptno order by deptno;
select deptno,count(empno) from EMP_BKP_1 group by deptno order by deptno;
select deptno,count(*) from EMP_BKP_1 group by deptno order by deptno;
select deptno,count(COMM) from EMP_BKP_1 group by deptno order by deptno;-- not recomended since NULL values present 
select deptno,count(JOB) from EMP_BKP_1 group by deptno order by deptno;

select deptno,SUM(SAL) from EMP_BKP_1 group by deptno order by deptno;
select deptno,SUM(COMM) from EMP_BKP_1 group by deptno order by deptno;
-- Aggrigate functions always return 0 if no data but not give result as null
select deptno,SUM(SAL) from EMP_BKP_1 group by deptno having SUM(SAL)>10000 order by deptno;
select deptno,SUM(SAL) from EMP_BKP_1 where HIREDATE is not null group by deptno having SUM(SAL)>10000 order by deptno;
--Filter: where and having
/*Order:
1. FROM
2. WHERE
3. GROUP BY
4. HAVING
5. ORDER BY
6. SELECT*/
select * from EMP_BKP_1 where deptno <> 30; --not equal
select * from EMP_BKP_1 where deptno != 30; --not equal
select * from EMP_BKP_1 where hiredate > '01-JAN-85';
select * from EMP_BKP_1 where hiredate < '01-JAN-85';
select * from EMP_BKP_1 where hiredate between '01-JAN-81' and '01-JAN-85';
select * from EMP_BKP_1 where deptno in (10,20);
select * from EMP_BKP_1 where deptno=10 or deptno=20;
--Arithmetic
--1+2=3
select 1+2, 2-1, 2*3, 4/2 from dual;
select * from dual;

delete from EMP_BKP_1 where deptno=10;
select * from EMP_BKP_1;
truncate table EMP_BKP_1;
rollback work

describe emp;
desc emp;
--MERGE
select * from emp_new;
select * from emp_old;

MERGE INTO emp_new
USING emp_old 
ON (emp_old.empno=emp_new.empno)
WHEN MATCHED THEN
UPDATE SET sal=sal+1000
WHEN NOT MATCHED THEN
INSERT VALUES(emp_old.empno, emp_old.ename, emp_old.JOB, emp_old.mgr, emp_old.hiredate, emp_old.sal, emp_old.comm, emp_old.deptno);

select sysdate from dual;
select to_char(sysdate,'DD-MONTH-YYYY') from dual;

select en.*, to_char(HIREDATE,'DD/MON/YYYY') from emp_new en;

select ltrim('  Kiran E   ') from dual;
select rtrim('  Kiran E   ') from dual;
select trim('  Kiran E   ') from dual;

select replace('  Kiran  E   ',' ',null) as result from dual;

select trunc(systimestamp) from dual;

create table master_accounts
(accno number primary key,
customer varchar2(20),
loan_amt number,
total_emi number);

create table loan_details
(accno number not null,
loan_name varchar2(10),
loan_paid_emi number,
loan_bal_emi number,
CONSTRAINT fk_accno  
foreign key(accno) REFERENCES  master_accounts(accno) 
ON DELETE CASCADE
);

insert into master_accounts values(456,'B',800,15);
insert into loan_details values(456,'Y',10,5);

select * from master_accounts;
select * from loan_details;

delete from master_accounts where accno=456;

create table loan_details
(accno number ,
loan_name varchar2(10),
loan_paid_emi number,
loan_bal_emi number,
CONSTRAINT fk_accno  
foreign key(accno) REFERENCES  master_accounts(accno) 
ON DELETE SET NULL
);

drop table loan_details;

select * from emp_new;
truncate table emp_new;

insert into emp_new
select sno, 'Kiran', 'Manager', 1502,sysdate,15000,100,20 
from (select level as sno from dual connect by level<=1000000);

select level from dual where connect by level<=100;
desc emp_new
alter table emp_new
modify empno number;


select * from emp;

select e.*,
        case 
            when job = 'CLERK' then 'Avg Grade'
            when job = 'PRESIDENT' then 'Hi Grade'
            else 'Poor Grade'
        end  as STATUS
        from emp e;
select * from emp_new order by empno;

truncate table emp_new

begin
for i in 1..10000
loop
    INSERT into emp_new values (i,'Kiran', 'Manager', 1502,sysdate,(15000+i),100,20);
    --dbms_output.put_line('*');
end loop;
commit;
end;


/***** 2nd day**************/

--WAP to display ename who are belongs to dept name - 'ACCOUNTING'
select * from emp;
select * from dept;

--Algorithm
select * from dept where dname='ACCOUNTING';--10
select ename from emp where deptno=10;

--Logic-1: using sub queries
select ename from emp where deptno=(select DEPTNO from dept where dname='ACCOUNTING');

--Logic-2: using JOINS

select * from EMP e join DEPT d on e.deptno=d.deptno where d.dname='ACCOUNTING';


--WAP to display ename, dept loc who are belongs to dept name - 'ACCOUNTING'

--Logic-1: using sub queries-- NOT possible
select ename from emp where deptno=(select DEPTNO from dept where dname='ACCOUNTING');

--Logic-2: using JOINS
select e.ename, d.dname from EMP e join DEPT d on e.deptno=d.deptno where d.dname='ACCOUNTING';

-- JOINs concept---

select * from EMP,DEPT;--cross join. i.e. no join condition
select * from EMP e join DEPT d on e.deptno=d.deptno;-- INNER JOIN
select * from EMP e, DEPT d where e.deptno=d.deptno;-- INNER JOIN
select * from EMP e LEFT JOIN DEPT d on e.deptno=d.deptno;
select * from EMP e RIGHT JOIN DEPT d on e.deptno=d.deptno;

--WAP to display ename who are belongs to dept no - 20
select ename from emp where deptno=20;


select * from tab1;
select * from tab2;


--cross
select * from tab1,tab2;--16

--inner join--only matched
select * from tab1 t1 join tab2 t2 on t1.sno=t2.sno;--2
select * from tab1 t1,tab2 t2 where t1.sno=t2.sno;--2
select * from tab1 t1 INNER JOIN tab2 t2 on t1.sno=t2.sno;--2

--natural join. column names should be the same in both tables

select * from tab1 t1 NATURAL JOIN tab2 t2;

--Left join
select * from tab1 t1 left outer join tab2 t2 on t1.sno=t2.sno;--2
select * from tab1 t1 left join tab2 t2 on t1.sno=t2.sno;--2
select * from tab1 t1 join tab2 t2 on t1.sno=t2.sno(+);-- 9i and prior 9i

--Right join
select * from tab1 t1 right outer join tab2 t2 on t1.sno=t2.sno;--2
select * from tab1 t1 right join tab2 t2 on t1.sno=t2.sno;--2
select * from tab1 t1 join tab2 t2 on t1.sno(+)=t2.sno;

-- full outer join
select * from tab1 t1 full outer join tab2 t2 on t1.sno=t2.sno;--2
select * from tab1 t1 full join tab2 t2 on t1.sno=t2.sno;--2

-- self join--
select * from emp;
--WAP to display emp names and their mgr names

--Org Strucure
Kiran - Shailedra
Kishore - Adithya
Sushma - Bhanu

--EMP table:
EMPNO   ENAME       MANAGER
----    -----       -------
100     Kiran       104
101     Kishore     105
102     Sushma      103    
103     Bhanu       106
104     Shailndra   106
105     Adithya     106
106     Amma         -

select e1.ename as EMPLOYEE ,e2.ename as MANAGER from EMP e1 left join EMP e2 on e1.mgr=e2.empno;


select * from emp;
--select deptno,SUM(SAL) from EMP group by deptno having SUM(SAL)>10000 order by deptno;
select deptno,max(sal) from emp group by deptno;

select e.deptno,d.dname, max(e.sal) from emp e join dept d  on e.deptno=d.deptno group by e.deptno,d.dname;


select ename, sal, deptno from emp where deptno=10 and sal=5000;

select ename, sal, deptno from emp where (deptno,sal) IN (select deptno,max(sal) from emp group by deptno);

-- INLINE VIEW---
select deptno,max(sal) from emp group by deptno having max(SAL)>=5000;

select * from (select deptno,max(sal) max_sal from emp group by deptno) where max_sal>=5000;


insert into emp_bkp select * from emp where deptno=10;

select * from emp_bkp;

SELECT ENAME, COUNT (ENAME)
FROM emp_bkp
GROUP BY ENAME
HAVING COUNT (ENAME) > 1;

delete from emp_bkp where ROWID='AAASRMAAEAAAAJlAAY';

select rowid,e.* from emp_bkp e;

select COALESCE(null,null,'C',null) from dual;

--DECODE and CASE- it is IF-ELSE - IF ... . Both are similar but DECODE is function, CASE is statement

if deptno=20 then 'sales'
else if deptno=30 then 'markets'
else 'N/A'

select e.*, decode(deptno,20,'sales',30,'markets','N/A') from emp e;

select e.*,
        case 
            when deptno=20 then 'sales'
            when deptno=30 then 'markets'
            else 'N/A'
        end
from emp e;

--UNION, UNION ALL, MINUS & INTERSECT 

select * from tab1;
select * from tab2;

UNION - All records from both tables without duplicates
UNION ALL - All records from both tables including duplicates
MINUS - records present in first data set but not present in second data set
INTERSECT - records present in both data sets

(select SNO from tab1) INTERSECT (select SNO from tab2);
1
2
4
6

1
2
3
5
select SNO from tab1;
select SNO from tab2;

-- USING not in
select sno from tab1 where sno not in (select sno from tab2);

(select SNO from tab1) MINUS (select SNO from tab2);

-- nth highist

select * from emp;

-- dept wise highist
select deptno,max(sal) from emp group by deptno;

-- ANALYTICAL Functions
select * from (select emp.*, ROW_NUMBER() over(partition by deptno order by sal desc) rno FROM emp) WHERE rno=1; -- 

select * from (select emp.*, RANK() over(partition by deptno order by sal desc) rno FROM emp) WHERE rno=1; -- skiping

select * from (select emp.*, DENSE_RANK() over(partition by deptno order by sal desc) rno FROM emp) WHERE rno=1; -- no skiping


-- NVL
select emp.*,NVL(COMM,0) as status from emp;

--NVL2
select emp.*,NVL2(COMM,0,1) as status from emp;

--LISTAGG
select listagg(ename,';') WITHIN GROUP (ORDER BY ename)  from emp;

-- order by
select empno, ename from emp order by 3 desc;
/*********PL/SQL**********/
set serveroutput on
DECLARE
    sno number:=10;
    sname varchar2(20);
    --DOB DATE default sysdate;
    Is_clover BOOLEAN;-- TRUE/FALSE
    Marks number;
BEGIN
    sname :='Kiran';
    Marks := 900;
    
    IF MARKS >= 900
    then    
        Is_clover:=TRUE;        
    ELSIF MARKS <900
    then
        Is_clover:=FALSE;
    end if;
    
    IF IS_clover
    then
        dbms_output.put_line('SNo#'||sno||' Sname: '||sname||' marks: '||marks||'*** CLOVER***');
    end if;
    
EXCEPTION
WHEN others THEN
    dbms_output.put_line('Excpetion raised...!'||DBMS_UTILITY.format_error_backtrace);
END;
----

create or replace procedure p1 
as
    sno number:=10;
    sname varchar2(20);
    --DOB DATE default sysdate;
    Is_clover BOOLEAN;-- TRUE/FALSE
    Marks number;
BEGIN
    sname :='Kiran';
    Marks := 900;
    
    IF MARKS >= 900
    then    
        Is_clover:=TRUE;        
    ELSIF MARKS <900
    then
        Is_clover:=FALSE;
    end if;
    
    IF IS_clover
    then
        dbms_output.put_line('SNo#'||sno||' Sname: '||sname||' marks: '||marks||'*** CLOVER***');
    end if;
    
EXCEPTION
WHEN others THEN
    dbms_output.put_line('Excpetion raised...!'||DBMS_UTILITY.format_error_backtrace);
END;



execute p1;

BEGIN
    p1;
END;


create or replace procedure p2(n number)
AS
BEGIN
    for i in 1..n
    loop
        dbms_output.put_line(i);
    end loop;
EXCEPTION
WHEN others THEN
    dbms_output.put_line('Excpetion raised...!'||DBMS_UTILITY.format_error_backtrace);
END p2;

execute p2(10);

BEGIN
    p2(10);
END;


create or replace procedure p3(n IN number, v_sum OUT number)
AS   
BEGIN
    
    v_sum:=0;
    
    for i in 1..n
    loop
        v_sum:=v_sum+i;
    end loop;
    dbms_output.put_line('v_sum from P3: '||v_sum);
EXCEPTION
WHEN others THEN
    dbms_output.put_line('Excpetion raised...!'||DBMS_UTILITY.format_error_backtrace);
END p3;


execute p3(10);

DECLARE
x number:=100;
y number;
t number;
BEGIN
    p3(10,t);
    --y:=x+p3(10,t);
    y:=x+t;
    dbms_output.put_line(y);
END;



create or replace procedure p4(n IN OUT number)
AS   
    v_sum number:=0;
BEGIN
    
    v_sum:=0;
    
    for i in 1..n
    loop
        v_sum:=v_sum+i;
    end loop;
    dbms_output.put_line('v_sum from P3: '||v_sum);
    n:=v_sum;
EXCEPTION
WHEN others THEN
    dbms_output.put_line('Excpetion raised...!'||DBMS_UTILITY.format_error_backtrace);
END p4;

DECLARE
x number:=100;
y number;
t number:=10;
BEGIN
    p4(t);
    --y:=x+p3(10,t);
    y:=x+t;
    dbms_output.put_line(y);
END;



--anonymous block vs named block
-- cusor
declare 
    cursor cur1 is select * from emp;
begin
    for i in cur1
    loop
        dbms_output.put_line(i.ename);
    end loop;    
EXCEPTION
WHEN others THEN
    dbms_output.put_line('Excpetion raised...!'||DBMS_UTILITY.format_error_backtrace);
end;
