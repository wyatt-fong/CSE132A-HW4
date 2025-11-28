-- CREATE TABLE Product (
--   pid SERIAL PRIMARY KEY,
--   pname TEXT,
--   category TEXT
-- );
--
-- CREATE TABLE Review (
--   rid SERIAL PRIMARY KEY,
--   pid INT REFERENCES Product(pid),
--   comments TEXT[],
--   reviewer TEXT
-- );

SELECT DISTINCT
    p.pname,
    comment
FROM Product p
JOIN Review r ON p.pid = r.pid
JOIN LATERAL unnest(r.comments) AS comment ON true
WHERE p.category = 'electronics'
  AND comment ~* '(defect|broken)'
ORDER BY p.pname, comment;


