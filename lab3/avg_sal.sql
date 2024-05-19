-- 3. Средняя заработная плата по отделам
SELECT 
    d.name AS department_name,
    AVG(s.amount) AS average_salary
FROM 
    Salary s
JOIN 
    Employee e ON s.employee_id = e.id
JOIN 
    Department d ON e.department_id = d.id
GROUP BY 
    d.name;

