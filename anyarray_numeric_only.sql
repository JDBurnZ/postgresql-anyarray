DROP FUNCTION IF EXISTS anyarray_numeric_only(anyarray);
CREATE OR REPLACE FUNCTION anyarray_numeric_only(anyarray)
	RETURNS anyarray AS
$BODY$
	SELECT ARRAY(
		SELECT
			tbl.val
		FROM
			(
				SELECT UNNEST($1) AS val
			) AS tbl
		WHERE
			tbl.val ~ '^\d+(\.\d+)?$'
	)
$BODY$ LANGUAGE sql IMMUTABLE;
