DROP FUNCTION IF EXISTS anyarray_agg_statefunc(anyarray, anyarray);
CREATE FUNCTION anyarray_agg_statefunc(state anyarray, value anyarray)
	RETURNS anyarray AS
$BODY$
	SELECT array_cat($1, $2)
$BODY$
	LANGUAGE sql IMMUTABLE;
COMMENT ON FUNCTION anyarray_agg_statefunc(anyarray, anyarray) IS '
Used internally by aggregate anyarray_agg(anyarray).
';

DROP AGGREGATE IF EXISTS anyarray_agg(anyarray);
CREATE AGGREGATE anyarray_agg(anyarray) (
	SFUNC = anyarray_agg_statefunc,
	STYPE = anyarray
);
COMMENT ON AGGREGATE anyarray_agg(anyarray) IS '
Concatenates arrays into a single array when aggregating.
';
