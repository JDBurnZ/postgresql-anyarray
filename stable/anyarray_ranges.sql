DROP FUNCTION IF EXISTS anyarray_ranges(anyarray);
CREATE OR REPLACE FUNCTION anyarray_ranges(from_array anyarray)
	RETURNS SETOF text[] AS
$BODY$
	BEGIN
		RETURN QUERY SELECT
				ARRAY_AGG(consolidated_values.consolidated_range) AS ranges
			FROM
				(
					SELECT
						(CASE WHEN COUNT(*) > 1 THEN
							MIN(unconsolidated_values.array_value)::text || '-' || MAX(unconsolidated_values.array_value)::text
						ELSE
							MIN(unconsolidated_values.array_value)::text
						END) AS consolidated_range
					FROM
						(
							SELECT
								array_values.array_value,
								ROW_NUMBER() OVER (ORDER BY array_values.array_value) - array_values.array_value AS consolidation_group
							FROM
								(
									SELECT
										UNNEST(from_array) AS array_value
								) AS array_values
							ORDER BY
								array_values.array_value
						) AS unconsolidated_values
					GROUP BY
						unconsolidated_values.consolidation_group
					ORDER BY
						MIN(unconsolidated_values.array_value)
				) AS consolidated_values
		;
	END;
$BODY$ LANGUAGE plpgsql;
