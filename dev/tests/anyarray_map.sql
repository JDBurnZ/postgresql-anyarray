/*
*
* ANYARRAY_REMOVE
*
*/

SELECT
	-- -- Expected Result: {a,b,c}
	ANYARRAY_MAP('TRIM($1)', ARRAY[' a ',' b','c']),

	-- -- Expected Result: {" A "," B",C}
	ANYARRAY_MAP('UPPER($1)', ARRAY[' a ',' b','c']),
	
	-- Expected Result: {hello,howdy}
	ANYARRAY_MAP('REPLACE($1, $2, $3)', ARRAY['hi','howdy'], 'hi', 'hello')
