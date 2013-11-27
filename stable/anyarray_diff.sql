DROP FUNCTION IF EXISTS anyarray_diff(anyarray, anyarray);
CREATE OR REPLACE FUNCTION anyarray_diff(with_array anyarray, against_array anyarray)
	RETURNS anyarray AS
$BODY$
	DECLARE
		-- The variable used to track iteration over "with_array".
		loop_offset integer;
		
		-- The array to be returned by this function.
		return_array with_array%TYPE := '{}';
	BEGIN
		IF with_array IS NULL THEN
			RETURN against_array;
		ELSEIF against_array IS NULL THEN
			RETURN with_array;
		END IF;

		-- Iterate over with_array.
		FOR loop_offset IN ARRAY_LOWER(with_array, 1)..ARRAY_UPPER(with_array, 1) LOOP
			IF NOT with_array[loop_offset] = ANY(against_array) THEN
				return_array = ARRAY_APPEND(return_array, with_array[loop_offset]);
			END IF;
		END LOOP;

		-- Iterate over against_array.
		FOR loop_offset IN ARRAY_LOWER(against_array, 1)..ARRAY_UPPER(against_array, 1) LOOP
			IF NOT against_array[loop_offset] = ANY(with_array) THEN
				return_array = ARRAY_APPEND(return_array, against_array[loop_offset]);
			END IF;
		END LOOP;

		RETURN return_array;
	END;
$BODY$ LANGUAGE plpgsql;
