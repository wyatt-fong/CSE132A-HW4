-- SCHEMA
-- CREATE TABLE PageLinks (
--   source TEXT,
--   target TEXT
-- );
WITH RECURSIVE paths(src, target) AS (

    -- Base case: links starting from 'home'
    SELECT
        source AS src,
        target AS target
    FROM PageLinks
    WHERE source = 'home'

    UNION ALL

    -- Recursive case: follow links forward
    SELECT
        p.src,
        l.target AS target
    FROM paths p
    JOIN PageLinks l
        ON p.target = l.source
)

SELECT DISTINCT
    target AS reachable_page
FROM paths
WHERE target ~* '(ref|polic)'
ORDER BY reachable_page;