-- SCHEMA
    -- CREATE TABLE Employee (
    --   eid INT PRIMARY KEY,
    --   ename TEXT,
    --   managerid INT REFERENCES Employee(eid)
    -- );
WITH RECURSIVE Hierarchy AS (
    -- Base: employee + direct manager
    SELECT
        e.eid AS employee_id,
        e.ename AS employee_name,
        m.eid AS manager_id,
        m.ename AS manager_name
    FROM Employee e
    JOIN Employee m ON e.managerid = m.eid

    UNION ALL

    -- Recursive: manager → manager’s manager
    SELECT
        h.employee_id,
        h.employee_name,
        m.managerid AS manager_id,
        m.ename AS manager_name
    FROM Hierarchy h
    JOIN Employee m ON h.manager_id = m.eid
)
SELECT DISTINCT
    employee_name,
    manager_name
FROM Hierarchy
ORDER BY employee_name, manager_name;