DROP FUNCTION IF EXISTS anyarray_enumerate(anyarray);
CREATE FUNCTION anyarray_enumerate(anyarray)
	RETURNS TABLE (index bigint, value anyelement) AS
$$
	SELECT
		row_number() OVER (),
		value
	FROM (
		SELECT unnest($1) AS value
	) AS unnested
$$
	LANGUAGE sql IMMUTABLE;
COMMENT ON FUNCTION anyarray_enumerate(anyarray) IS '
Unnests the array along with the indices of each element.

*index* (bigint) is the index of the element within the array starting at 1.

*value* (anyelement) is the element from the array.

NOTE: Multi-dimensional arrays will be flattened as they are with *unnest()*. 
';
