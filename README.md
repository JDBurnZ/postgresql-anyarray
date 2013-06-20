anyarray
========

A PostgreSQL extension adding highly desirable array-based functionality, independend of data-type.

<h3>Operators and Procedures</h3>

<small><small>
<table><tbody>
<tr><th>Operator</th><th>Method</th><th>Arguments</th><th>Returns</th><th>Description</th></tr>
<tr><td>#</td><td>anyarray_count</td><td>anyarray</td><td>integer</td><td>Returns number of values in array</td></tr>
<tr><td>#&</td><td>anyarray_count_overlap</td><td>anyarray, anyarray</td><td>integer</td><td>Returns number of values which overlap between left and right</td></tr>
<tr><td>#!</td><td>anyarray_count_diff</td><td>anyarray, anyarray</td><td>integer</td><td>Returns number of values which don't overlap between left and right</td></tr>
<tr><td>#<</td><td>anyarray_count_diff_lr</td><td>anyarray, anyarray</td><td>integer</td><td>Returns number of values in left which don't overlap with right</td></tr>
<tr><td>>#</td><td>anyarray_count_diff_rl</td><td>anyarray, anyarray</td><td>integer</td><td>Returns number of values in right which don't overlap with left</td></tr>
<tr><td>@<</td><td>anyarray_logic_all_lr</td><td>anyarray, anyarray</td><td>boolean</td><td>Returns whether every value in left is contained by right</td></tr>
<tr><td>>@</td><td>anyarray_logic_all_rl</td><td>anyarray, anyarray</td><td>boolean</td><td>Returns whether every value in right is contained by left</td></tr>
<tr><td>?</td><td>anyarray_logic_any</td><td>anyarray, anyarray</td><td>boolean</td><td>Returns whether values overlap between left and right</td></tr>
<tr><td>&</td><td>anyarray_intersect</td><td>anyarray, anyarray</td><td>anyarray</td><td>Returns values which intersect between left and right</td></tr>
<tr><td>!<</td><td>anyarray_diff_right</td><td>anyarray, anyarray</td><td>anyarray</td><td>Returns values in left which aren't in right</td></tr>
<tr><td>>!</td><td>anyarray_diff_left</td><td>anyarray, anyarray</td><td>anyarray</td><td>Returns values in right which aren't in left</td></tr>
<tr><td>!</td><td>anyarray_diff</td><td>anyarray, anyarray</td><td>anyarray</td><td>Returns values which left doesn't contain in right and vice versa</td></tr>
<tr><td>==</td><td>anyarray_eq</td><td>anyarray, anyarray</td><td>boolean</td><td>Returns whether left and right contain the same values, same size, same order</td></tr>
<tr><td>=~</td><td>anyarray_eq_unord</td><td>anyarray, anyarray</td><td>boolean</td><td>Returns whether left and right contain same values, same size, order may differ</td></tr>
<tr><td>=#</td><td>anyarray_eq_uniq</td><td>anyarray, anyarray</td><td>boolean</td><td>Returns whether left and right contain same unique values, size may differ, same order</td></tr>
<tr><td>=?</td><td>anyarray_eq_uniq_unord</td><td>anyarray, anyarray</td><td>boolean</td><td>Returns whether left and right contain same unique values, size may differ, order may differ</td></tr>
<tr><td>+, +<</td><td>anyarray_append</td><td>anyarray, anyarray</td><td>anyarray</td><td>Returns left with right appended to the end</td></tr>
<tr><td>>+</td><td>anyarray_prepend</td><td>anyarray, anyarray</td><td>anyarray</td><td>Returns right with left appended to the end</td></tr>
<tr><td>-</td><td>anyarray_remove</td><td>anyarray, anyarray</td><td>anyarray</td><td>Returns left with every ocurrance of right removed</td></tr>
<tr><td>-<</td><td>anyarray_remove_first</td><td>anyarray, anyarray</td><td>anyarray</td><td>Returns left with only first ocurrance of right removed</td></tr>
<tr><td>>-</td><td>anyarray_remove_last</td><td>anyarray, anyarray</td><td>anyarray</td><td>Returns left with only last ocurrance of right removed</td></tr>
<tr><td>%</td><td>anyarray_segment_size</td><td>anyarray, integer</td><td>anyarray[]</td><td>Returns array of arrays from left, each containing max of number defined by right</td></tr>
<tr><td>/</td><td>anyarray_segment_number</td><td>anyarray, integer</td><td>anyarray[]</td><td>Returns array of arrays from left, broken up into number defined by right</td></tr>
</tbody></table>
</small></small>

<h3>Usage Examples</h3>

<small><small>
<table><tbody>
<tr><th>Operator</th><th>Example</th><th>Result</th></tr>
<tr><td>#</td><td># ARRAY['one','two','three']</td><td>3</td></tr>
<tr><td>#&</td><td>ARRAY['pig','cat','dog'] #& ARRAY['dog','cat','cow','duck']</td><td>2</td></tr>
<tr><td>#!</td><td>ARRAY['pig','cat','dog'] #! ARRAY['dog','cat','cow','duck']</td><td>3</td></tr>
<tr><td>#&lt;</td><td>ARRAY['pig','cat','dog'] #&lt; ARRAY['dog','cat','cow','duck']</td><td>1</td></tr>
<tr><td>&gt;#</td><td>ARRAY['pig','cat','dog'] &gt;# ARRAY['dog','cat','cow','duck']</td><td>2</td></tr>
<tr><td>@&lt;</td><td>ARRAY['pig','cat','dog'] @&lt; ARRAY['dog','cat','cow','duck']</td><td>FALSE</td></tr>
<tr><td>@&lt;</td><td>ARRAY['cat','dog'] @&lt; ARRAY['dog','cat','cow','duck']</td><td>TRUE</td></tr>
<tr><td>@&lt;</td><td>ARRAY['dog','cat','cow','duck'] @&lt; ARRAY['cat','dog']</td><td>FALSE</td></tr>
<tr><td>@&lt;</td><td>ARRAY['dog','cat'] @&lt; ARRAY['cow','duck']</td><td>FALSE</td></tr>
<tr><td>&gt;@</td><td>ARRAY['pig','cat','dog'] &gt;@ ARRAY['dog','cat','cow','duck']</td><td>FALSE</td></tr>
<tr><td>&gt;@</td><td>ARRAY['cat','dog'] &gt;@ ARRAY['dog','cat','cow','duck']</td><td>FALSE</td></tr>
<tr><td>&gt;@</td><td>ARRAY['dog','cat','cow','duck'] &gt;@ ARRAY['cat','dog']</td><td>TRUE</td></tr>
<tr><td>&gt;@</td><td>ARRAY['dog','cat'] &gt;@ ARRAY['cow','duck']</td><td>FALSE</td></tr>
<tr><td>?</td><td>ARRAY['pig','cat','dog'] ? ARRAY['dog','cat','cow','duck']</td><td>TRUE</td></tr>
<tr><td>?</td><td>ARRAY['cat','dog'] ? ARRAY['dog','cat','cow','duck']</td><td>TRUE</td></tr>
<tr><td>?</td><td>ARRAY['dog','cat','cow','duck'] ? ARRAY['cat','dog']</td><td>TRUE</td></tr>
<tr><td>?</td><td>ARRAY['dog','cat'] ? ARRAY['cow','duck']</td><td>FALSE</td></tr>
<tr><td>&</td><td>ARRAY['pig','cat','dog'] & ARRAY['dog','cat','cow','duck']</td><td>ARRAY['dog','cat']</td></tr>
<tr><td>!&lt;</td><td>ARRAY['pig','cat','dog'] !&lt; ARRAY['dog','cat','cow','duck']</td><td>ARRAY['pig']</td></tr>
<tr><td>&gt;!</td><td>ARRAY['pig','cat','dog'] &gt;! ARRAY['dog','cat','cow','duck']</td><td>ARRAY['cow','duck']</td></tr>
<tr><td>!</td><td>ARRAY['pig','cat','dog'] &gt;! ARRAY['dog','cat','cow','duck']</td><td>ARRAY['pig','cow','duck']</td></tr>
<tr><td>==</td><td>ARRAY['dog','cat'] == ARRAY['dog','cat']</td><td>TRUE</td></tr>
<tr><td>==</td><td>ARRAY['dog','cat'] == ARRAY['cat','dog']</td><td>FALSE</td></tr>
<tr><td>==</td><td>ARRAY['dog','dog','cat','cat'] == ARRAY['dog','cat','cat','cat']</td><td>FALSE</td></tr>
<tr><td>==</td><td>ARRAY['dog','cat','dog'] == ARRAY['cat','dog','cat','dog']</td><td>FALSE</td></tr>
<tr><td>=~</td><td>ARRAY['dog','cat'] =~ ARRAY['dog','cat']</td><td>TRUE</td></tr>
<tr><td>=~</td><td>ARRAY['dog','cat'] =~ ARRAY['cat','dog']</td><td>TRUE</td></tr>
<tr><td>=~</td><td>ARRAY['dog','dog','cat','cat'] =~ ARRAY['dog','cat','cat','cat']</td><td>FALSE</td></tr>
<tr><td>=~</td><td>ARRAY['dog','cat','dog'] =~ ARRAY['cat','dog','cat','dog']</td><td>FALSE</td></tr>
<tr><td>=#</td><td>ARRAY['dog','cat'] =# ARRAY['dog','cat']</td><td>TRUE</td></tr>
<tr><td>=#</td><td>ARRAY['dog','cat'] =# ARRAY['cat','dog']</td><td>FALSE</td></tr>
<tr><td>=#</td><td>ARRAY['dog','dog','cat','cat'] =# ARRAY['dog','cat','cat','cat']</td><td>TRUE</td></tr>
<tr><td>=#</td><td>ARRAY['dog','cat','dog'] =# ARRAY['cat','dog','cat','dog']</td><td>FALSE</td></tr>
<tr><td>=?</td><td>ARRAY['dog','cat'] =? ARRAY['dog','cat']</td><td>TRUE</td></tr>
<tr><td>=?</td><td>ARRAY['dog','cat'] =? ARRAY['cat','dog']</td><td>TRUE</td></tr>
<tr><td>=?</td><td>ARRAY['dog','dog','cat','cat'] =? ARRAY['dog','cat','cat','cat']</td><td>TRUE</td></tr>
<tr><td>=?</td><td>ARRAY['dog','cat','dog'] =? ARRAY['cat','dog','cat','dog']</td><td>TRUE</td></tr>
<tr><td>+, +&lt;</td><td>ARRAY['dot','cat'] + ARRAY['cow']</td><td>ARRAY['dog','cat','cow']</td></tr>
<tr><td>&gt;+</td><td>ARRAY['dot','cat'] &gt;+ ARRAY['cow']</td><td>ARRAY['cow','dog','cat']</td></tr>
<tr><td>-</td><td>ARRAY['dog','cat','dog','cat'] - ARRAY['dog']</td><td>ARRAY['cat','cat']</td></tr>
<tr><td>-</td><td>ARRAY['dog','cat','dog','cow'] - ARRAY['dog','cat','duck']</td><td>ARRAY['cow']</td></tr>
<tr><td>-&lt;</td><td>ARRAY['dog','cat','dog','cat'] - ARRAY['dog']</td><td>ARRAY['cat','dog','cat']</td></tr>
<tr><td>&gt;-</td><td>ARRAY['dog','cat','dog','cat'] - ARRAY['dog']</td><td>ARRAY['dog','cat','cat']</td></tr>
<tr><td>%</td><td>ARRAY['cat','dog','cow','duck','sheep'] % 2</td><td>ARRAY[ARRAY['cat','dog'],ARRAY['cow','duck'],ARRAY['sheep']]</td></tr>
<tr><td>/</td><td>ARRAY['cat','dog','cow','duck','sheep'] / 2</td><td>ARRAY[ARRAY['cat','dog','cow'],ARRAY['duck','sheep']]</td></tr>
</tbody></table>
</small></small>
