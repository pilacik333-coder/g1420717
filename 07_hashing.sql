USE crownfield;

# Example of hashing data from pat_tbl
# It does not change the original post_code

CREATE TEMPORARY TABLE hashed_postcodes AS
SELECT pat_id, SHA2(post_code, 256) AS post_code_hash
FROM pat_tbl;

SELECT * FROM hashed_postcodes;

DROP TEMPORARY TABLE hashed_postcodes;
