anyarray
========

A PostgreSQL extension adding highly desirable array-based functionality, independend of data-type.

Supports array operators and procedures to:

* Return number of values in an array.
* Return number of unique values in an array.
* Return number of values which overlap between two arrays.
* Return number of values which don't overlap between two arrays.
* Return number of values in left which don't overlap with right.
* Return number of values in right which don't overlap with left.
* Return whether every value in left is contained by right.
* Return whether every value in right is contained by left.
* Return whether values overlap between two arrays.
* Return values which intersect between two arrays.
* Return values in left which don't overlap with right.
* Return values in right which don't overlap with left.
* Return values which don't overlap between two arrays.
* Return whether two arrays are identical in values, order and size.
* Return whether two arrays contain exact same values, where order may differ.
* Return whether two arrays contain same unique values, where order must be the same.
* Return whether two arrays contain same unique values, where order may differ.
* Return values of right appended to the end of left.
* Return values of left appended to the end of right.
* Return values from left which don't overlap with right.
* Return values from left with only first ocurrance of right removed.
* Return values from left with only last ocurrance of right removed.

