/*

TODO:

A function which calls the function passed (as a string) on every element within the array. Can optionally include additional arguments.

TO DISCUSS:

Every `anyarray` function currently in existance always has the subject
array (the array which the actions will be performed on,) as the first
argument.

Examples:

ANYARRAY_REMOVE(ARRAY[1,2,3], 1)
ANYARRAY_CONCAT(ARRAY[1,2,3], [3,4])
ANYARRAY_SORT(ARRAY[4,2,9])

Should we continue with this formatting in regards to mapping?

Or should we make an exception to argument ordering to make the logic a
little more clear?

*/

-- Both proposals essentially iterate over the array, similarly to:

STRING_TO_ARRAY('a:b', ':') -- {a,b}
STRING_TO_ARRAY('c:d', ':') -- {c,d}
-- and..
TRIM(' a ')
TRIM(' b')

-- Proposal #1:

ANYARRAY_MAP('STRING_TO_ARRAY($1, $2)', ARRAY['a:b','c:d'], ':')
ANYARRAY_MAP('TRIM($1)', ARRAY[' a ',' b'])

-- Proposal #2:

ANYARRAY_MAP(ARRAY['a:b','c:d'], 'STRING_TO_ARRAY($1, $2)', ':')
ANYARRAY_MAP(ARRAY[' a ',' b'], 'TRIM($1)')

-- Both would output the following:

{{a,b},{c,d}} -- STRING_TO_ARRAY output
{a,b} -- TRIM output

