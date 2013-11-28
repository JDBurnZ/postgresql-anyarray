DROP FUNCTION IF EXISTS anyarray_map(text, anyarray, anyarray);
CREATE OR REPLACE FUNCTION
	anyarray_map
(
	function_call text,
	with_array anyarray,
	VARIADIC args anyarray DEFAULT ARRAY[NULL]
)
RETURNS
	anyarray
AS $BODY$
	DECLARE
		-- The variable used to track iteration over "with_array".
		loop_offset integer;

		-- The array to be returned by this function.
		return_array with_array%TYPE := '{}';

		temp_function text;
	BEGIN
		-- Iterate over conditional args, inserting them as args into the function to be called.
		FOR loop_offset IN ARRAY_LOWER(args, 1)..ARRAY_UPPER(args, 1) LOOP
			-- Format the value of argument being iterated over.
			function_call = FORMAT(
				REPLACE(function_call, ('$' || (loop_offset+1)::text), '%1$L'),
				args[loop_offset]
			);
			RAISE NOTICE '%', function_call;
		END LOOP;

		-- Iterate over each element in the array.
		loop_offset = 0;
		FOR loop_offset IN ARRAY_LOWER(with_array, 1)..ARRAY_UPPER(with_array, 1) LOOP
			execute FORMAT(
				'SELECT ' || REPLACE(function_call, '$1', '%1$L'),
				with_array[loop_offset]
			) into temp_function;
			return_array[loop_offset] = temp_function;
			--temp_function = REPLACE(function_call, '$1', '%1$L');
			--RAISE NOTICE '%', tmp_function;
			--PERFORM '%', tmp_function;
		END LOOP;

		RETURN return_array;
	END;
$BODY$ LANGUAGE plpgsql;
