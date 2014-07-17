DROP FUNCTION IF EXISTS anyarray_remove(anyarray, anyarray);
CREATE OR REPLACE FUNCTION anyarray_remove(from_array anyarray, remove_array anyarray)
        RETURNS anyarray AS
$BODY$
        DECLARE
                -- The variable used to track iteration over "from_array".
                loop_offset integer;


                -- The array to be returned by this function.
                return_array from_array%TYPE := '{}';
        BEGIN
                -- If either argument is NULL, there is nothing to do.
                IF from_array IS NULL OR remove_array IS NULL THEN
                        RETURN from_array;
                END IF;

                -- Iterate over each element in "from_array".
                FOR loop_offset IN ARRAY_LOWER(from_array, 1)..ARRAY_UPPER(from_array, 1) LOOP
                        -- If the element being iterated over is in "remove_array",
                        -- do not append it to "return_array".
                        IF (from_array[loop_offset] = ANY(remove_array)) IS DISTINCT FROM TRUE THEN
                                return_array = ARRAY_APPEND(return_array, from_array[loop_offset]);
                        END IF;
                END LOOP;


                RETURN return_array;
        END;
$BODY$ LANGUAGE plpgsql;


DROP FUNCTION IF EXISTS anyarray_remove(anyarray, anynonarray);
CREATE OR REPLACE FUNCTION anyarray_remove(from_array anyarray, remove_element anynonarray)
        RETURNS anyarray AS
$BODY$
        BEGIN
                RETURN ANYARRAY_REMOVE(from_array, ARRAY[remove_element]);
        END;
$BODY$ LANGUAGE plpgsql;
