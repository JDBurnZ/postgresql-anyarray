DROP FUNCTION IF EXISTS anyarray_is_array(anyelement);
CREATE OR REPLACE FUNCTION anyarray_is_array(anyelement)
	RETURNS boolean AS
$BODY$
	BEGIN
		-- TODO: Is there a more "elegant" / less hacky of accomplishing
		-- this?

		-- If the following function call throws an exception, we know the
		-- element is not an array. If the call succeeds, then it must be
		-- an array.
		EXECUTE FORMAT('WITH a AS (SELECT %L::TEXT[] AS val) SELECT ARRAY_DIMS(a.val) FROM a', $1);
		RETURN TRUE;
	EXCEPTION WHEN
	      SQLSTATE '42804' -- Unknown data-type passed
	      OR SQLSTATE '42883' -- Function doesn't exist
	      OR SQLSTATE '22P02' -- Unable to cast to an array
	THEN
		RETURN FALSE;
	END;
$BODY$ LANGUAGE plpgsql;
