/*

TODO:

A function which calls the function passed (as a string) on every element within the array. Can optionally include additional arguments.

TO DISCUSS:

Every `anyarray` function currently in existance always has the subject
array (the array which the actions will be performed on,) as the first
argument.

Should we continue with this formatting in regards to mapping?

Or, should we change argument ordering to make the logic a little more
clear?


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

