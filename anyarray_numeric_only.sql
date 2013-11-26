DROP FUNCTION IF EXISTS anyarray_numeric_only(anyarray);
CREATE OR REPLACE FUNCTION anyarray_numeric_only(anyarray)
        RETURNS anyarray AS
$BODY$
        SELECT ARRAY(
                SELECT
                        array_values.array_value
                FROM
                        (
                                SELECT UNNEST($1) AS array_value
                        ) AS array_values
                WHERE
                        array_values.array_value::TEXT ~ '^\d+(\.\d+)?$'
        )
$BODY$ LANGUAGE sql IMMUTABLE;
