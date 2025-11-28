-- CREATE TABLE Topic (
--   tid INT PRIMARY KEY,
--   tname TEXT,
--   parent_tid INT REFERENCES Topic(tid)
-- );
--
-- CREATE TABLE Discussion (
--   did SERIAL PRIMARY KEY,
--   tid INT REFERENCES Topic(tid),
--   messages TEXT[]
-- );

WITH RECURSIVE subtopics(tid, tname, parent_tid) AS (
    -- Base case: the 'Support' topic
    SELECT
        tid,
        tname,
        parent_tid
    FROM Topic
    WHERE tname = 'Support'

    UNION ALL

    -- Recursive case: find all subtopics whose parent is a topic we already found
    SELECT
        t.tid,
        t.tname,
        t.parent_tid
    FROM subtopics st
    JOIN Topic t
        ON t.parent_tid = st.tid
)

SELECT DISTINCT
    st.tname,
    msg
FROM subtopics st
JOIN Discussion d ON
    d.tid = st.tid
JOIN unnest(d.messages) AS msg ON TRUE
WHERE msg ~* '(refund|return)'
ORDER BY st.tname, msg;