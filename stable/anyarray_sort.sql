DROP FUNCTION IF EXISTS anyarray_sort(anyarray);
CREATE OR REPLACE FUNCTION anyarray_sort(with_array anyarray)
	RETURNS SETOF anyarray AS
$BODY$
	BEGIN
		RETURN QUERY SELECT 
			ARRAY_AGG(sorted_vals.val) AS array_value
		FROM
			(
				SELECT
					UNNEST(with_array) AS val
				ORDER BY
					val
			) AS sorted_vals
		;
	END;
$BODY$ LANGUAGE plpgsql;
