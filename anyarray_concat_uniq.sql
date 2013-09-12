DROP FUNCTION IF EXISTS anyarray_concat_uniq(anyarray, anyarray);
CREATE OR REPLACE FUNCTION anyarray_concat_uniq(with_array anyarray, concat_array anyarray)
	RETURNS anyarray AS
$BODY$
	DECLARE
		-- The variable used to track iteration over "with_array".
		loop_offset integer;

		-- The array to be returned by this function.
		return_array with_array%TYPE;
	BEGIN
		IF with_array IS NULL THEN
			RETURN concat_array;
		ELSEIF concat_array IS NULL THEN
			RETURN with_array;
		END IF;

		-- Add all items in "with_array" to "return_array".
		return_array = with_array;

		-- Iterate over each element in "concat_array".
		FOR loop_offset IN ARRAY_LOWER(concat_array, 1)..ARRAY_UPPER(concat_array, 1) LOOP
			IF NOT concat_array[loop_offset] = ANY(return_array) THEN
				return_array = ARRAY_APPEND(return_array, concat_array[loop_offset]);
			END IF;
		END LOOP;

		RETURN return_array;
	END;
$BODY$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS anyarray_concat_uniq(anyarray, anynonarray);
CREATE OR REPLACE FUNCTION anyarray_concat_uniq(with_array anyarray, concat_element anynonarray)
	RETURNS anyarray AS
$BODY$
	BEGIN
		RETURN ANYARRAY_CONCAT_UNIQ(with_array, ARRAY[concat_element]);
	END;
$BODY$ LANGUAGE plpgsql;
