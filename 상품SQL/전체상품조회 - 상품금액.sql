DECLARE
  vsql VARCHAR2(2000);
  vdeptno emp.deptno%TYPE;
  vempno emp.empno%TYPE;
  vename emp.ename%TYPE;
  vjob emp.job%TYPE;
BEGIN
   vsql := 'SELECT deptno, empno, ename, job ';
   vsql := vsql || ' FROM emp ';
   vsql := vsql || ' WHERE empno=7369';

DBMS_OUTPUT.PUT_LINE( vsql );

   EXECUTE IMMEDIATE vsql
           INTO vdeptno, vempno, vename, vjob;
              
   DBMS_OUTPUT.PUT_LINE( vdeptno || ', ' || 
   vempno || ', ' || vename || ', ' || vjob )     ;          
-- EXCEPTION
END;
