/*
 *
 * ANYARRAY_REMOVE
 *
*/

SELECT
	-- Expected Result: {1}
	ANYARRAY_REMOVE(ARRAY[1,2], 2),

	-- Expected Result: {'one'}
	ANYARRAY_REMOVE(ARRAY['one','two'], 'two'::text),

	-- Expected Result: {1}
	ANYARRAY_REMOVE(ARRAY[1,2], ARRAY[2]),

	-- Expected Result: {'one'}
	ANYARRAY_REMOVE(ARRAY['one','two'], ARRAY['two']),

	-- Expected Result: {}
	ANYARRAY_REMOVE(ARRAY[1], 1),

	-- Expected Result: {}
	ANYARRAY_REMOVE(ARRAY['one'], 'one'::text),

	-- Expected Result: {}
	ANYARRAY_REMOVE(ARRAY[1,2], ARRAY[1,2]),

	-- Expected Result: {}
	ANYARRAY_REMOVE(ARRAY['one','two'], ARRAY['one','two'])
