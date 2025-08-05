# foundations
Foundational types and functions.
Here, you'll find documentation for basic data types like integers and strings as well as details about core computational functions.
# arguments
Captured arguments to a function.
## Argument Sinks
Like built-in functions, custom functions can also take a variable number of arguments. You can specify an argument sink which collects all excess arguments as `..sink`. The resulting `sink` value is of the `arguments` type. It exposes methods to access the positional and named arguments.
    
    #let format(title, ..authors) = {
      let by = authors
        .pos()
        .join(", ", last: " and ")
    
      [*#title* \ _Written by #by;_]
    }
    
    #format("ArtosFlow", "Jane", "Joe")
    
## Spreading
Inversely to an argument sink, you can spread arguments, arrays and dictionaries into a function call with the `..spread` operator:
    
    #let array = (2, 3, 5)
    #calc.min(..array)
    #let dict = (fill: blue)
    #text(..dict)[Hello]
    
# arguments
Construct spreadable arguments in place.
This function behaves like `let args(..sink) = sink`.
arguments
The arguments to construct.
# at
Returns the positional argument at the specified index, or the named argument with the specified name.
If the key is an integer, this is equivalent to first calling `pos` and then `array.at`. If it is a string, this is equivalent to first calling `named` and then `dictionary.at`.
key
The index or name of the argument to get.
default
A default value to return if the key is invalid.
# pos
Returns the captured positional arguments as an array.
# named
Returns the captured named arguments as a dictionary.
# array
A sequence of values.
You can construct an array by enclosing a comma-separated sequence of values in parentheses. The values do not have to be of the same type.
You can access and update array items with the `.at()` method. Indices are zero-based and negative indices wrap around to the end of the array. You can iterate over an array using a for loop. Arrays can be added together with the `+` operator, joined together and multiplied with integers.
Note: An array of length one needs a trailing comma, as in `(1,)`. This is to disambiguate from a simple parenthesized expressions like `(1 + 2) * 3`. An empty array is written as `()`.
## Example
    
    #let values = (1, 7, 4, -3, 2)
    
    #values.at(0) \
    #(values.at(0) = 3)
    #values.at(-1) \
    #values.find(calc.even) \
    #values.filter(calc.odd) \
    #values.map(calc.abs) \
    #values.rev() \
    #(1, (2, 3)).flatten() \
    #(("A", "B", "C")
        .join(", ", last: " and "))
    
# array
Converts a value to an array.
Note that this function is only intended for conversion of a collection-like value to an array, not for creation of an array from individual items. Use the array syntax `(1, 2, 3)` (or `(1,)` for a single-element array) instead.
value
The value that should be converted to an array.
# len
The number of values in the array.
# first
Returns the first item in the array. May be used on the left-hand side of an assignment. Fails with an error if the array is empty.
# last
Returns the last item in the array. May be used on the left-hand side of an assignment. Fails with an error if the array is empty.
# at
Returns the item at the specified index in the array. May be used on the left-hand side of an assignment. Returns the default value if the index is out of bounds or fails with an error if no default value was specified.
index
The index at which to retrieve the item. If negative, indexes from the back.
default
A default value to return if the index is out of bounds.
# push
Adds a value to the end of the array.
value
The value to insert at the end of the array.
# pop
Removes the last item from the array and returns it. Fails with an error if the array is empty.
# insert
Inserts a value into the array at the specified index, shifting all subsequent elements to the right. Fails with an error if the index is out of bounds.
To replace an element of an array, use `at`.
index
The index at which to insert the item. If negative, indexes from the back.
value
The value to insert into the array.
# remove
Removes the value at the specified index from the array and return it.
index
The index at which to remove the item. If negative, indexes from the back.
default
A default value to return if the index is out of bounds.
# slice
Extracts a subslice of the array. Fails with an error if the start or end index is out of bounds.
start
The start index (inclusive). If negative, indexes from the back.
end
The end index (exclusive). If omitted, the whole slice until the end of the array is extracted. If negative, indexes from the back.
count
The number of items to extract. This is equivalent to passing `start + count` as the `end` position. Mutually exclusive with `end`.
# contains
Whether the array contains the specified value.
This method also has dedicated syntax: You can write `2 in (1, 2, 3)` instead of `(1, 2, 3).contains(2)`.
value
The value to search for.
# find
Searches for an item for which the given function returns `true` and returns the first match or `none` if there is no match.
searcher
The function to apply to each item. Must return a boolean.
# position
Searches for an item for which the given function returns `true` and returns the index of the first match or `none` if there is no match.
searcher
The function to apply to each item. Must return a boolean.
# range
Create an array consisting of a sequence of numbers.
If you pass just one positional parameter, it is interpreted as the `end` of the range. If you pass two, they describe the `start` and `end` of the range.
This function is available both in the array function's scope and globally.
start
The start of the range (inclusive).
end
The end of the range (exclusive).
step
The distance between the generated numbers.
# filter
Produces a new array with only the items from the original one for which the given function returns true.
test
The function to apply to each item. Must return a boolean.
# map
Produces a new array in which all items from the original one were transformed with the given function.
mapper
The function to apply to each item.
# enumerate
Returns a new array with the values alongside their indices.
The returned array consists of `(index, value)` pairs in the form of length-2 arrays. These can be destructured with a let binding or for loop.
start
The index returned for the first pair of the returned list.
# zip
Zips the array with other arrays.
Returns an array of arrays, where the `i`th inner array contains all the `i`th elements from each original array.
If the arrays to be zipped have different lengths, they are zipped up to the last element of the shortest array and all remaining elements are ignored.
This function is variadic, meaning that you can zip multiple arrays together at once: `(1, 2).zip(("A", "B"), (10, 20))` yields `((1, "A", 10), (2, "B", 20))`.
exact
Whether all arrays have to have the same length. For example, `(1, 2).zip((1, 2, 3), exact: true)` produces an error.
others
The arrays to zip with.
# fold
Folds all items into a single value using an accumulator function.
init
The initial value to start with.
folder
The folding function. Must have two parameters: One for the accumulated value and one for an item.
# sum
Sums all items (works for all types that can be added).
default
What to return if the array is empty. Must be set if the array can be empty.
# product
Calculates the product all items (works for all types that can be multiplied).
default
What to return if the array is empty. Must be set if the array can be empty.
# any
Whether the given function returns `true` for any item in the array.
test
The function to apply to each item. Must return a boolean.
# all
Whether the given function returns `true` for all items in the array.
test
The function to apply to each item. Must return a boolean.
# flatten
Combine all nested arrays into a single flat one.
# rev
Return a new array with the same items, but in reverse order.
# split
Split the array at occurrences of the specified value.
at
The value to split at.
# join
Combine all items in the array into one.
separator
A value to insert between each item of the array.
last
An alternative separator between the last two items.
# intersperse
Returns an array with a copy of the separator value placed between adjacent elements.
separator
The value that will be placed between each adjacent element.
# chunks
Splits an array into non-overlapping chunks, starting at the beginning, ending with a single remainder chunk.
All chunks but the last have `chunk-size` elements. If `exact` is set to `true`, the remainder is dropped if it contains less than `chunk-size` elements.
chunk-size
How many elements each chunk may at most contain.
exact
Whether to keep the remainder if its size is less than `chunk-size`.
# windows
Returns sliding windows of `window-size` elements over an array.
If the array length is less than `window-size`, this will return an empty array.
window-size
How many elements each window will contain.
# sorted
Return a sorted version of this array, optionally by a given key function. The sorting algorithm used is stable.
Returns an error if two values could not be compared or if the key function (if given) yields an error.
To sort according to multiple criteria at once, e.g. in case of equality between some criteria, the key function can return an array. The results are in lexicographic order.
key
If given, applies this function to the elements in the array to determine the keys to sort by.
# dedup
Deduplicates all items in the array.
Returns a new array with all duplicate items removed. Only the first element of each duplicate is kept.
key
If given, applies this function to the elements in the array to determine the keys to deduplicate by.
# to-dict
Converts an array of pairs into a dictionary. The first value of each pair is the key, the second the value.
If the same key occurs multiple times, the last value is selected.
# reduce
Reduces the elements to a single one, by repeatedly applying a reducing operation.
If the array is empty, returns `none`, otherwise, returns the result of the reduction.
The reducing function is a closure with two arguments: an "accumulator", and an element.
For arrays with at least one element, this is the same as `array.fold` with the first element of the array as the initial accumulator value, folding every subsequent element into it.
reducer
The reducing function. Must have two parameters: One for the accumulated value and one for an item.
# assert
Ensures that a condition is fulfilled.
Fails with an error if the condition is not fulfilled. Does not produce any output in the document.
If you wish to test equality between two values, see `assert.eq` and `assert.ne`.
## Example
    
    #assert(1 < 2, message: "math broke")
    
condition
The condition that must be true for the assertion to pass.
message
The error message when the assertion fails.
# eq
Ensures that two values are equal.
Fails with an error if the first value is not equal to the second. Does not produce any output in the document.
left
The first value to compare.
right
The second value to compare.
message
An optional message to display on error instead of the representations of the compared values.
# ne
Ensures that two values are not equal.
Fails with an error if the first value is equal to the second. Does not produce any output in the document.
left
The first value to compare.
right
The second value to compare.
message
An optional message to display on error instead of the representations of the compared values.
# auto
A value that indicates a smart default.
The auto type has exactly one value: `auto`.
Parameters that support the `auto` value have some smart default or contextual behaviour. A good example is the text direction parameter. Setting it to `auto` lets Typst automatically determine the direction from the text language.
# bool
A type with two states.
The boolean type has two values: `true` and `false`. It denotes whether something is active or enabled.
## Example
    
    #false \
    #true \
    #(1 < 2)
    
# bytes
A sequence of bytes.
This is conceptually similar to an array of integers between `0` and `255`, but represented much more efficiently. You can iterate over it using a for loop.
You can convert
  * a string or an array of integers to bytes with the `bytes` constructor
  * bytes to a string with the `str` constructor, with UTF-8 encoding
  * bytes to an array of integers with the `array` constructor


When reading data from a file, you can decide whether to load it as a string or as raw bytes.
    
    #bytes((123, 160, 22, 0)) \
    #bytes("Hello 😃")
    
    #let data = read(
      "rhino.png",
      encoding: none,
    )
    
    // Magic bytes.
    #array(data.slice(0, 4)) \
    #str(data.slice(1, 4))
    
# bytes
Converts a value to bytes.
  * Strings are encoded in UTF-8.
  * Arrays of integers between `0` and `255` are converted directly. The dedicated byte representation is much more efficient than the array representation and thus typically used for large byte buffers (e.g. image data).

value
The value that should be converted to bytes.
# len
The length in bytes.
# at
Returns the byte at the specified index. Returns the default value if the index is out of bounds or fails with an error if no default value was specified.
index
The index at which to retrieve the byte.
default
A default value to return if the index is out of bounds.
# slice
Extracts a subslice of the bytes. Fails with an error if the start or end index is out of bounds.
start
The start index (inclusive).
end
The end index (exclusive). If omitted, the whole slice until the end is extracted.
count
The number of items to extract. This is equivalent to passing `start + count` as the `end` position. Mutually exclusive with `end`.
# calc
Module for calculations and processing of numeric values.
These definitions are part of the `calc` module and not imported by default. In addition to the functions listed below, the `calc` module also defines the constants `pi`, `tau`, `e`, and `inf`.
# abs
Calculates the absolute value of a numeric value.
value
The value whose absolute value to calculate.
# pow
Raises a value to some exponent.
base
The base of the power.
If this is a `decimal`, the exponent can only be an integer.
exponent
The exponent of the power.
# exp
Raises a value to some exponent of e.
exponent
The exponent of the power.
# sqrt
Calculates the square root of a number.
value
The number whose square root to calculate. Must be non-negative.
# root
Calculates the real nth root of a number.
If the number is negative, then n must be odd.
radicand
The expression to take the root of
index
Which root of the radicand to take
# sin
Calculates the sine of an angle.
When called with an integer or a float, they will be interpreted as radians.
angle
The angle whose sine to calculate.
# cos
Calculates the cosine of an angle.
When called with an integer or a float, they will be interpreted as radians.
angle
The angle whose cosine to calculate.
# tan
Calculates the tangent of an angle.
When called with an integer or a float, they will be interpreted as radians.
angle
The angle whose tangent to calculate.
# asin
Calculates the arcsine of a number.
value
The number whose arcsine to calculate. Must be between -1 and 1.
# acos
Calculates the arccosine of a number.
value
The number whose arcsine to calculate. Must be between -1 and 1.
# atan
Calculates the arctangent of a number.
value
The number whose arctangent to calculate.
# atan2
Calculates the four-quadrant arctangent of a coordinate.
The arguments are `(x, y)`, not `(y, x)`.
x
The X coordinate.
y
The Y coordinate.
# sinh
Calculates the hyperbolic sine of a hyperbolic angle.
value
The hyperbolic angle whose hyperbolic sine to calculate.
# cosh
Calculates the hyperbolic cosine of a hyperbolic angle.
value
The hyperbolic angle whose hyperbolic cosine to calculate.
# tanh
Calculates the hyperbolic tangent of an hyperbolic angle.
value
The hyperbolic angle whose hyperbolic tangent to calculate.
# log
Calculates the logarithm of a number.
If the base is not specified, the logarithm is calculated in base 10.
value
The number whose logarithm to calculate. Must be strictly positive.
base
The base of the logarithm. May not be zero.
# ln
Calculates the natural logarithm of a number.
value
The number whose logarithm to calculate. Must be strictly positive.
# fact
Calculates the factorial of a number.
number
The number whose factorial to calculate. Must be non-negative.
# perm
Calculates a permutation.
Returns the `k`-permutation of `n`, or the number of ways to choose `k` items from a set of `n` with regard to order.
base
The base number. Must be non-negative.
numbers
The number of permutations. Must be non-negative.
# binom
Calculates a binomial coefficient.
Returns the `k`-combination of `n`, or the number of ways to choose `k` items from a set of `n` without regard to order.
n
The upper coefficient. Must be non-negative.
k
The lower coefficient. Must be non-negative.
# gcd
Calculates the greatest common divisor of two integers.
a
The first integer.
b
The second integer.
# lcm
Calculates the least common multiple of two integers.
a
The first integer.
b
The second integer.
# floor
Rounds a number down to the nearest integer.
If the number is already an integer, it is returned unchanged.
Note that this function will always return an integer, and will error if the resulting `float` or `decimal` is larger than the maximum 64-bit signed integer or smaller than the minimum for that type.
value
The number to round down.
# ceil
Rounds a number up to the nearest integer.
If the number is already an integer, it is returned unchanged.
Note that this function will always return an integer, and will error if the resulting `float` or `decimal` is larger than the maximum 64-bit signed integer or smaller than the minimum for that type.
value
The number to round up.
# trunc
Returns the integer part of a number.
If the number is already an integer, it is returned unchanged.
Note that this function will always return an integer, and will error if the resulting `float` or `decimal` is larger than the maximum 64-bit signed integer or smaller than the minimum for that type.
value
The number to truncate.
# fract
Returns the fractional part of a number.
If the number is an integer, returns `0`.
value
The number to truncate.
# round
Rounds a number to the nearest integer away from zero.
Optionally, a number of decimal places can be specified.
If the number of digits is negative, its absolute value will indicate the amount of significant integer digits to remove before the decimal point.
Note that this function will return the same type as the operand. That is, applying `round` to a `float` will return a `float`, and to a `decimal`, another `decimal`. You may explicitly convert the output of this function to an integer with `int`, but note that such a conversion will error if the `float` or `decimal` is larger than the maximum 64-bit signed integer or smaller than the minimum integer.
In addition, this function can error if there is an attempt to round beyond the maximum or minimum integer or `decimal`. If the number is a `float`, such an attempt will cause `float.inf` or `-float.inf` to be returned for maximum and minimum respectively.
value
The number to round.
digits
If positive, the number of decimal places.
If negative, the number of significant integer digits that should be removed before the decimal point.
# clamp
Clamps a number between a minimum and maximum value.
value
The number to clamp.
min
The inclusive minimum value.
max
The inclusive maximum value.
# min
Determines the minimum of a sequence of values.
values
The sequence of values from which to extract the minimum. Must not be empty.
# max
Determines the maximum of a sequence of values.
values
The sequence of values from which to extract the maximum. Must not be empty.
# even
Determines whether an integer is even.
value
The number to check for evenness.
# odd
Determines whether an integer is odd.
value
The number to check for oddness.
# rem
Calculates the remainder of two numbers.
The value `calc.rem(x, y)` always has the same sign as `x`, and is smaller in magnitude than `y`.
This can error if given a `decimal` input and the dividend is too small in magnitude compared to the divisor.
dividend
The dividend of the remainder.
divisor
The divisor of the remainder.
# div-euclid
Performs euclidean division of two numbers.
The result of this computation is that of a division rounded to the integer `n` such that the dividend is greater than or equal to `n` times the divisor.
dividend
The dividend of the division.
divisor
The divisor of the division.
# rem-euclid
This calculates the least nonnegative remainder of a division.
Warning: Due to a floating point round-off error, the remainder may equal the absolute value of the divisor if the dividend is much smaller in magnitude than the divisor and the dividend is negative. This only applies for floating point inputs.
In addition, this can error if given a `decimal` input and the dividend is too small in magnitude compared to the divisor.
dividend
The dividend of the remainder.
divisor
The divisor of the remainder.
# quo
Calculates the quotient (floored division) of two numbers.
Note that this function will always return an integer, and will error if the resulting `float` or `decimal` is larger than the maximum 64-bit signed integer or smaller than the minimum for that type.
dividend
The dividend of the quotient.
divisor
The divisor of the quotient.
# norm
Calculates the p-norm of a sequence of values.
p
The p value to calculate the p-norm of.
values
The sequence of values from which to calculate the p-norm. Returns `0.0` if empty.
# content
A piece of document content.
This type is at the heart of Typst. All markup you write and most functions you call produce content values. You can create a content value by enclosing markup in square brackets. This is also how you pass content to functions.
## Example
    
    Type of *Hello!* is
    #type([*Hello!*])
    
Content can be added with the `+` operator, joined together and multiplied with integers. Wherever content is expected, you can also pass a string or `none`.
## Representation
Content consists of elements with fields. When constructing an element with its element function, you provide these fields as arguments and when you have a content value, you can access its fields with field access syntax.
Some fields are required: These must be provided when constructing an element and as a consequence, they are always available through field access on content of that type. Required fields are marked as such in the documentation.
Most fields are optional: Like required fields, they can be passed to the element function to configure them for a single element. However, these can also be configured with set rules to apply them to all elements within a scope. Optional fields are only available with field access syntax when they were explicitly passed to the element function, not when they result from a set rule.
Each element has a default appearance. However, you can also completely customize its appearance with a show rule. The show rule is passed the element. It can access the element's field and produce arbitrary content from it.
In the web app, you can hover over a content variable to see exactly which elements the content is composed of and what fields they have. Alternatively, you can inspect the output of the `repr` function.
# func
The content's element function. This function can be used to create the element contained in this content. It can be used in set and show rules for the element. Can be compared with global functions to check whether you have a specific kind of element.
# has
Whether the content has the specified field.
field
The field to look for.
# at
Access the specified field on the content. Returns the default value if the field does not exist or fails with an error if no default value was specified.
field
The field to access.
default
A default value to return if the field does not exist.
# fields
Returns the fields of this content.
# location
The location of the content. This is only available on content returned by query or provided by a show rule, for other content it will be `none`. The resulting location can be used with counters, state and queries.
# datetime
Represents a date, a time, or a combination of both.
Can be created by either specifying a custom datetime using this type's constructor function or getting the current date with `datetime.today`.
## Example
    
    #let date = datetime(
      year: 2020,
      month: 10,
      day: 4,
    )
    
    #date.display() \
    #date.display(
      "y:[year repr:last_two]"
    )
    
    #let time = datetime(
      hour: 18,
      minute: 2,
      second: 23,
    )
    
    #time.display() \
    #time.display(
      "h:[hour repr:12][period]"
    )
    
## Datetime and Duration
You can get a duration by subtracting two datetime:
    
    #let first-of-march = datetime(day: 1, month: 3, year: 2024)
    #let first-of-jan = datetime(day: 1, month: 1, year: 2024)
    #let distance = first-of-march - first-of-jan
    #distance.hours()
    
You can also add/subtract a datetime and a duration to retrieve a new, offset datetime:
    
    #let date = datetime(day: 1, month: 3, year: 2024)
    #let two-days = duration(days: 2)
    #let two-days-earlier = date - two-days
    #let two-days-later = date + two-days
    
    #date.display() \
    #two-days-earlier.display() \
    #two-days-later.display()
    
## Format
You can specify a customized formatting using the `display` method. The format of a datetime is specified by providing components with a specified number of modifiers. A component represents a certain part of the datetime that you want to display, and with the help of modifiers you can define how you want to display that component. In order to display a component, you wrap the name of the component in square brackets (e.g. `[year]` will display the year). In order to add modifiers, you add a space after the component name followed by the name of the modifier, a colon and the value of the modifier (e.g. `[month repr:short]` will display the short representation of the month).
The possible combination of components and their respective modifiers is as follows:
  * `year`: Displays the year of the datetime. 
    * `padding`: Can be either `zero`, `space` or `none`. Specifies how the year is padded.
    * `repr` Can be either `full` in which case the full year is displayed or `last_two` in which case only the last two digits are displayed.
    * `sign`: Can be either `automatic` or `mandatory`. Specifies when the sign should be displayed.
  * `month`: Displays the month of the datetime. 
    * `padding`: Can be either `zero`, `space` or `none`. Specifies how the month is padded.
    * `repr`: Can be either `numerical`, `long` or `short`. Specifies if the month should be displayed as a number or a word. Unfortunately, when choosing the word representation, it can currently only display the English version. In the future, it is planned to support localization.
  * `day`: Displays the day of the datetime. 
    * `padding`: Can be either `zero`, `space` or `none`. Specifies how the day is padded.
  * `week_number`: Displays the week number of the datetime. 
    * `padding`: Can be either `zero`, `space` or `none`. Specifies how the week number is padded.
    * `repr`: Can be either `ISO`, `sunday` or `monday`. In the case of `ISO`, week numbers are between 1 and 53, while the other ones are between 0 and 53.
  * `weekday`: Displays the weekday of the date. 
    * `repr` Can be either `long`, `short`, `sunday` or `monday`. In the case of `long` and `short`, the corresponding English name will be displayed (same as for the month, other languages are currently not supported). In the case of `sunday` and `monday`, the numerical value will be displayed (assuming Sunday and Monday as the first day of the week, respectively).
    * `one_indexed`: Can be either `true` or `false`. Defines whether the numerical representation of the week starts with 0 or 1.
  * `hour`: Displays the hour of the date. 
    * `padding`: Can be either `zero`, `space` or `none`. Specifies how the hour is padded.
    * `repr`: Can be either `24` or `12`. Changes whether the hour is displayed in the 24-hour or 12-hour format.
  * `period`: The AM/PM part of the hour 
    * `case`: Can be `lower` to display it in lower case and `upper` to display it in upper case.
  * `minute`: Displays the minute of the date. 
    * `padding`: Can be either `zero`, `space` or `none`. Specifies how the minute is padded.
  * `second`: Displays the second of the date. 
    * `padding`: Can be either `zero`, `space` or `none`. Specifies how the second is padded.


Keep in mind that not always all components can be used. For example, if you create a new datetime with `datetime(year: 2023, month: 10, day: 13)`, it will be stored as a plain date internally, meaning that you cannot use components such as `hour` or `minute`, which would only work on datetimes that have a specified time.
# datetime
Creates a new datetime.
You can specify the datetime using a year, month, day, hour, minute, and second.
Note: Depending on which components of the datetime you specify, Typst will store it in one of the following three ways:
  * If you specify year, month and day, Typst will store just a date.
  * If you specify hour, minute and second, Typst will store just a time.
  * If you specify all of year, month, day, hour, minute and second, Typst will store a full datetime.


Depending on how it is stored, the `display` method will choose a different formatting by default.
year
The year of the datetime.
month
The month of the datetime.
day
The day of the datetime.
hour
The hour of the datetime.
minute
The minute of the datetime.
second
The second of the datetime.
# today
Returns the current date.
offset
An offset to apply to the current UTC date. If set to `auto`, the offset will be the local offset.
# display
Displays the datetime in a specified format.
Depending on whether you have defined just a date, a time or both, the default format will be different. If you specified a date, it will be `[year]-[month]-[day]`. If you specified a time, it will be `[hour]:[minute]:[second]`. In the case of a datetime, it will be `[year]-[month]-[day] [hour]:[minute]:[second]`.
See the format syntax for more information.
pattern
The format used to display the datetime.
# year
The year if it was specified, or `none` for times without a date.
# month
The month if it was specified, or `none` for times without a date.
# weekday
The weekday (counting Monday as 1) or `none` for times without a date.
# day
The day if it was specified, or `none` for times without a date.
# hour
The hour if it was specified, or `none` for dates without a time.
# minute
The minute if it was specified, or `none` for dates without a time.
# second
The second if it was specified, or `none` for dates without a time.
# ordinal
The ordinal (day of the year), or `none` for times without a date.
# decimal
A fixed-point decimal number type.
This type should be used for precise arithmetic operations on numbers represented in base 10. A typical use case is representing currency.
## Example
    
    Decimal: #(decimal("0.1") + decimal("0.2")) \
    Float: #(0.1 + 0.2)
    
## Construction and casts
To create a decimal number, use the `decimal(string)` constructor, such as in `decimal("3.141592653")` (note the double quotes!). This constructor preserves all given fractional digits, provided they are representable as per the limits specified below (otherwise, an error is raised).
You can also convert any integer to a decimal with the `decimal(int)` constructor, e.g. `decimal(59)`. However, note that constructing a decimal from a floating-point number, while supported, is an imprecise conversion and therefore discouraged. A warning will be raised if Typst detects that there was an accidental `float` to `decimal` cast through its constructor, e.g. if writing `decimal(3.14)` (note the lack of double quotes, indicating this is an accidental `float` cast and therefore imprecise). It is recommended to use strings for constant decimal values instead (e.g. `decimal("3.14")`).
The precision of a `float` to `decimal` cast can be slightly improved by rounding the result to 15 digits with `calc.round`, but there are still no precision guarantees for that kind of conversion.
## Operations
Basic arithmetic operations are supported on two decimals and on pairs of decimals and integers.
Built-in operations between `float` and `decimal` are not supported in order to guard against accidental loss of precision. They will raise an error instead.
Certain `calc` functions, such as trigonometric functions and power between two real numbers, are also only supported for `float` (although raising `decimal` to integer exponents is supported). You can opt into potentially imprecise operations with the `float(decimal)` constructor, which casts the `decimal` number into a `float`, allowing for operations without precision guarantees.
## Displaying decimals
To display a decimal, simply insert the value into the document. To only display a certain number of digits, round the decimal first. Localized formatting of decimals and other numbers is not yet supported, but planned for the future.
You can convert decimals to strings using the `str` constructor. This way, you can post-process the displayed representation, e.g. to replace the period with a comma (as a stand-in for proper built-in localization to languages that use the comma).
## Precision and limits
A `decimal` number has a limit of 28 to 29 significant base-10 digits. This includes the sum of digits before and after the decimal point. As such, numbers with more fractional digits have a smaller range. The maximum and minimum `decimal` numbers have a value of `79228162514264337593543950335` and `-79228162514264337593543950335` respectively. In contrast with `float`, this type does not support infinity or NaN, so overflowing or underflowing operations will raise an error.
Typical operations between `decimal` numbers, such as addition, multiplication, and power to an integer, will be highly precise due to their fixed-point representation. Note, however, that multiplication and division may not preserve all digits in some edge cases: while they are considered precise, digits past the limits specified above are rounded off and lost, so some loss of precision beyond the maximum representable digits is possible. Note that this behavior can be observed not only when dividing, but also when multiplying by numbers between 0 and 1, as both operations can push a number's fractional digits beyond the limits described above, leading to rounding. When those two operations do not surpass the digit limits, they are fully precise.
# decimal
Converts a value to a `decimal`.
It is recommended to use a string to construct the decimal number, or an integer (if desired). The string must contain a number in the format `"3.14159"` (or `"-3.141519"` for negative numbers). The fractional digits are fully preserved; if that's not possible due to the limit of significant digits (around 28 to 29) having been reached, an error is raised as the given decimal number wouldn't be representable.
While this constructor can be used with floating-point numbers to cast them to `decimal`, doing so is discouraged as this cast is inherently imprecise. It is easy to accidentally perform this cast by writing `decimal(1.234)` (note the lack of double quotes), which is why Typst will emit a warning in that case. Please write `decimal("1.234")` instead for that particular case (initialization of a constant decimal). Also note that floats that are NaN or infinite cannot be cast to decimals and will raise an error.
value
The value that should be converted to a decimal.
# dictionary
A map from string keys to values.
You can construct a dictionary by enclosing comma-separated `key: value` pairs in parentheses. The values do not have to be of the same type. Since empty parentheses already yield an empty array, you have to use the special `(:)` syntax to create an empty dictionary.
A dictionary is conceptually similar to an array, but it is indexed by strings instead of integers. You can access and create dictionary entries with the `.at()` method. If you know the key statically, you can alternatively use field access notation (`.key`) to access the value. Dictionaries can be added with the `+` operator and joined together. To check whether a key is present in the dictionary, use the `in` keyword.
You can iterate over the pairs in a dictionary using a for loop. This will iterate in the order the pairs were inserted / declared.
## Example
    
    #let dict = (
      name: "Typst",
      born: 2019,
    )
    
    #dict.name \
    #(dict.launch = 20)
    #dict.len() \
    #dict.keys() \
    #dict.values() \
    #dict.at("born") \
    #dict.insert("city", "Berlin ")
    #("name" in dict)
    
# dictionary
Converts a value into a dictionary.
Note that this function is only intended for conversion of a dictionary-like value to a dictionary, not for creation of a dictionary from individual pairs. Use the dictionary syntax `(key: value)` instead.
value
The value that should be converted to a dictionary.
# len
The number of pairs in the dictionary.
# at
Returns the value associated with the specified key in the dictionary. May be used on the left-hand side of an assignment if the key is already present in the dictionary. Returns the default value if the key is not part of the dictionary or fails with an error if no default value was specified.
key
The key at which to retrieve the item.
default
A default value to return if the key is not part of the dictionary.
# insert
Inserts a new pair into the dictionary. If the dictionary already contains this key, the value is updated.
key
The key of the pair that should be inserted.
value
The value of the pair that should be inserted.
# remove
Removes a pair from the dictionary by key and return the value.
key
The key of the pair to remove.
default
A default value to return if the key does not exist.
# keys
Returns the keys of the dictionary as an array in insertion order.
# values
Returns the values of the dictionary as an array in insertion order.
# pairs
Returns the keys and values of the dictionary as an array of pairs. Each pair is represented as an array of length two.
# duration
Represents a positive or negative span of time.
# duration
Creates a new duration.
You can specify the duration using weeks, days, hours, minutes and seconds. You can also get a duration by subtracting two datetimes.
seconds
The number of seconds.
minutes
The number of minutes.
hours
The number of hours.
days
The number of days.
weeks
The number of weeks.
# seconds
The duration expressed in seconds.
This function returns the total duration represented in seconds as a floating-point number rather than the second component of the duration.
# minutes
The duration expressed in minutes.
This function returns the total duration represented in minutes as a floating-point number rather than the second component of the duration.
# hours
The duration expressed in hours.
This function returns the total duration represented in hours as a floating-point number rather than the second component of the duration.
# days
The duration expressed in days.
This function returns the total duration represented in days as a floating-point number rather than the second component of the duration.
# weeks
The duration expressed in weeks.
This function returns the total duration represented in weeks as a floating-point number rather than the second component of the duration.
# eval
Evaluates a string as Typst code.
This function should only be used as a last resort.
## Example
    
    #eval("1 + 1") \
    #eval("(1, 2, 3, 4)").len() \
    #eval("*Markup!*", mode: "markup") \
    
source
A string of Typst code to evaluate.
mode
The syntactical mode in which the string is parsed.
    
    #eval("= Heading", mode: "markup")
    #eval("1_2^3", mode: "math")
    
scope
A scope of definitions that are made available.
    
    #eval("x + 1", scope: (x: 2)) \
    #eval(
      "abc/xyz",
      mode: "math",
      scope: (
        abc: $a + b + c$,
        xyz: $x + y + z$,
      ),
    )
    
# float
A floating-point number.
A limited-precision representation of a real number. Typst uses 64 bits to store floats. Wherever a float is expected, you can also pass an integer.
You can convert a value to a float with this type's constructor.
NaN and positive infinity are available as `float.nan` and `float.inf` respectively.
## Example
    
    #3.14 \
    #1e4 \
    #(10 / 4)
    
# float
Converts a value to a float.
  * Booleans are converted to `0.0` or `1.0`.
  * Integers are converted to the closest 64-bit float. For integers with absolute value less than `calc.pow(2, 53)`, this conversion is exact.
  * Ratios are divided by 100%.
  * Strings are parsed in base 10 to the closest 64-bit float. Exponential notation is supported.

value
The value that should be converted to a float.
# is-nan
Checks if a float is not a number.
In IEEE 754, more than one bit pattern represents a NaN. This function returns `true` if the float is any of those bit patterns.
# is-infinite
Checks if a float is infinite.
Floats can represent positive infinity and negative infinity. This function returns `true` if the float is an infinity.
# signum
Calculates the sign of a floating point number.
  * If the number is positive (including `+0.0`), returns `1.0`.
  * If the number is negative (including `-0.0`), returns `-1.0`.
  * If the number is NaN, returns `float.nan`.


# from-bytes
Interprets bytes as a float.
bytes
The bytes that should be converted to a float.
Must have a length of either 4 or 8. The bytes are then interpreted in IEEE 754's binary32 (single-precision) or binary64 (double-precision) format depending on the length of the bytes.
endian
The endianness of the conversion.
# to-bytes
Converts a float to bytes.
endian
The endianness of the conversion.
size
The size of the resulting bytes.
This must be either 4 or 8. The call will return the representation of this float in either IEEE 754's binary32 (single-precision) or binary64 (double-precision) format depending on the provided size.
# function
A mapping from argument values to a return value.
You can call a function by writing a comma-separated list of function arguments enclosed in parentheses directly after the function name. Additionally, you can pass any number of trailing content blocks arguments to a function after the normal argument list. If the normal argument list would become empty, it can be omitted. Typst supports positional and named arguments. The former are identified by position and type, while the latter are written as `name: value`.
Within math mode, function calls have special behaviour. See the math documentation for more details.
## Example
    
    // Call a function.
    #list([A], [B])
    
    // Named arguments and trailing
    // content blocks.
    #enum(start: 2)[A][B]
    
    // Version without parentheses.
    #list[A][B]
    
Functions are a fundamental building block of Typst. Typst provides functions for a variety of typesetting tasks. Moreover, the markup you write is backed by functions and all styling happens through functions. This reference lists all available functions and how you can use them. Please also refer to the documentation about set and show rules to learn about additional ways you can work with functions in Typst.
## Element functions
Some functions are associated with elements like headings or tables. When called, these create an element of their respective kind. In contrast to normal functions, they can further be used in set rules, show rules, and selectors.
## Function scopes
Functions can hold related definitions in their own scope, similar to a module. Examples of this are `assert.eq` or `list.item`. However, this feature is currently only available for built-in functions.
## Defining functions
You can define your own function with a let binding that has a parameter list after the binding's name. The parameter list can contain mandatory positional parameters, named parameters with default values and argument sinks.
The right-hand side of a function binding is the function body, which can be a block or any other expression. It defines the function's return value and can depend on the parameters. If the function body is a code block, the return value is the result of joining the values of each expression in the block.
Within a function body, the `return` keyword can be used to exit early and optionally specify a return value. If no explicit return value is given, the body evaluates to the result of joining all expressions preceding the `return`.
Functions that don't return any meaningful value return `none` instead. The return type of such functions is not explicitly specified in the documentation. (An example of this is `array.push`).
    
    #let alert(body, fill: red) = {
      set text(white)
      set align(center)
      rect(
        fill: fill,
        inset: 8pt,
        radius: 4pt,
        [*Warning:\ #body*],
      )
    }
    
    #alert[
      Danger is imminent!
    ]
    
    #alert(fill: blue)[
      KEEP OFF TRACKS
    ]
    
## Importing functions
Functions can be imported from one file (`module`) into another using `import`. For example, assume that we have defined the `alert` function from the previous example in a file called `foo.typ`. We can import it into another file by writing `import "foo.typ": alert`.
## Unnamed functions
You can also created an unnamed function without creating a binding by specifying a parameter list followed by `=>` and the function body. If your function has just one parameter, the parentheses around the parameter list are optional. Unnamed functions are mainly useful for show rules, but also for settable properties that take functions like the page function's `footer` property.
    
    #show "once?": it => [#it #it]
    once?
    
## Note on function purity
In Typst, all functions are pure. This means that for the same arguments, they always return the same result. They cannot "remember" things to produce another value when they are called a second time.
The only exception are built-in methods like `array.push(value)`. These can modify the values they are called on.
# with
Returns a new function that has the given arguments pre-applied.
arguments
The arguments to apply to the function.
# where
Returns a selector that filters for elements belonging to this function whose fields have the values of the given arguments.
fields
The fields to filter for.
# int
A whole number.
The number can be negative, zero, or positive. As Typst uses 64 bits to store integers, integers cannot be smaller than `-9223372036854775808` or larger than `9223372036854775807`. Integer literals are always positive, so a negative integer such as `-1` is semantically the negation `-` of the positive literal `1`. A positive integer greater than the maximum value and a negative integer less than or equal to the minimum value cannot be represented as an integer literal, and are instead parsed as a `float`. The minimum integer value can still be obtained through integer arithmetic.
The number can also be specified as hexadecimal, octal, or binary by starting it with a zero followed by either `x`, `o`, or `b`.
You can convert a value to an integer with this type's constructor.
## Example
    
    #(1 + 2) \
    #(2 - 5) \
    #(3 + 4 < 8)
    
    #0xff \
    #0o10 \
    #0b1001
    
# int
Converts a value to an integer. Raises an error if there is an attempt to produce an integer larger than the maximum 64-bit signed integer or smaller than the minimum 64-bit signed integer.
  * Booleans are converted to `0` or `1`.
  * Floats and decimals are truncated to the next 64-bit integer.
  * Strings are parsed in base 10.

value
The value that should be converted to an integer.
# signum
Calculates the sign of an integer.
  * If the number is positive, returns `1`.
  * If the number is negative, returns `-1`.
  * If the number is zero, returns `0`.


# bit-not
Calculates the bitwise NOT of an integer.
For the purposes of this function, the operand is treated as a signed integer of 64 bits.
# bit-and
Calculates the bitwise AND between two integers.
For the purposes of this function, the operands are treated as signed integers of 64 bits.
rhs
The right-hand operand of the bitwise AND.
# bit-or
Calculates the bitwise OR between two integers.
For the purposes of this function, the operands are treated as signed integers of 64 bits.
rhs
The right-hand operand of the bitwise OR.
# bit-xor
Calculates the bitwise XOR between two integers.
For the purposes of this function, the operands are treated as signed integers of 64 bits.
rhs
The right-hand operand of the bitwise XOR.
# bit-lshift
Shifts the operand's bits to the left by the specified amount.
For the purposes of this function, the operand is treated as a signed integer of 64 bits. An error will occur if the result is too large to fit in a 64-bit integer.
shift
The amount of bits to shift. Must not be negative.
# bit-rshift
Shifts the operand's bits to the right by the specified amount. Performs an arithmetic shift by default (extends the sign bit to the left, such that negative numbers stay negative), but that can be changed by the `logical` parameter.
For the purposes of this function, the operand is treated as a signed integer of 64 bits.
shift
The amount of bits to shift. Must not be negative.
Shifts larger than 63 are allowed and will cause the return value to saturate. For non-negative numbers, the return value saturates at `0`, while, for negative numbers, it saturates at `-1` if `logical` is set to `false`, or `0` if it is `true`. This behavior is consistent with just applying this operation multiple times. Therefore, the shift will always succeed.
logical
Toggles whether a logical (unsigned) right shift should be performed instead of arithmetic right shift. If this is `true`, negative operands will not preserve their sign bit, and bits which appear to the left after the shift will be `0`. This parameter has no effect on non-negative operands.
# from-bytes
Converts bytes to an integer.
bytes
The bytes that should be converted to an integer.
Must be of length at most 8 so that the result fits into a 64-bit signed integer.
endian
The endianness of the conversion.
signed
Whether the bytes should be treated as a signed integer. If this is `true` and the most significant bit is set, the resulting number will negative.
# to-bytes
Converts an integer to bytes.
endian
The endianness of the conversion.
size
The size in bytes of the resulting bytes (must be at least zero). If the integer is too large to fit in the specified size, the conversion will truncate the remaining bytes based on the endianness. To keep the same resulting value, if the endianness is big-endian, the truncation will happen at the rightmost bytes. Otherwise, if the endianness is little-endian, the truncation will happen at the leftmost bytes.
Be aware that if the integer is negative and the size is not enough to make the number fit, when passing the resulting bytes to `int.from-bytes`, the resulting number might be positive, as the most significant bit might not be set to 1.
# label
A label for an element.
Inserting a label into content attaches it to the closest preceding element that is not a space. The preceding element must be in the same scope as the label, which means that `Hello #[<label>]`, for instance, wouldn't work.
A labelled element can be referenced, queried for, and styled through its label.
Once constructed, you can get the name of a label using `str`.
## Example
    
    #show <a>: set text(blue)
    #show label("b"): set text(red)
    
    = Heading <a>
    *Strong* #label("b")
    
## Syntax
This function also has dedicated syntax: You can create a label by enclosing its name in angle brackets. This works both in markup and code. A label's name can contain letters, numbers, `_`, `-`, `:`, and `.`.
Note that there is a syntactical difference when using the dedicated syntax for this function. In the code below, the `<a>` terminates the heading and thus attaches to the heading itself, whereas the `#label("b")` is part of the heading and thus attaches to the heading's text.
    
    // Equivalent to `#heading[Introduction] <a>`.
    = Introduction <a>
    
    // Equivalent to `#heading[Conclusion #label("b")]`.
    = Conclusion #label("b")
    
Currently, labels can only be attached to elements in markup mode, not in code mode. This might change in the future.
# label
Creates a label from a string.
name
The name of the label.
# module
An module of definitions.
A module
  * be built-in
  * stem from a file import
  * stem from a package import (and thus indirectly its entrypoint file)
  * result from a call to the plugin function


You can access definitions from the module using field access notation and interact with it using the import and include syntaxes. Alternatively, it is possible to convert a module to a dictionary, and therefore access its contents dynamically, using the dictionary constructor.
## Example
    
    #import "utils.typ"
    #utils.add(2, 5)
    
    #import utils: sub
    #sub(1, 4)
    
# none
A value that indicates the absence of any other value.
The none type has exactly one value: `none`.
When inserted into the document, it is not visible. This is also the value that is produced by empty code blocks. It can be joined with any value, yielding the other value.
## Example
    
    Not visible: #none
    
# panic
Fails with an error.
Arguments are displayed to the user (not rendered in the document) as strings, converting with `repr` if necessary.
## Example
The code below produces the error `panicked with: "this is wrong"`.
    
    #panic("this is wrong")
    
values
The values to panic with and display to the user.
# plugin
Loads a WebAssembly module.
The resulting module will contain one Typst function for each function export of the loaded WebAssembly module.
Typst WebAssembly plugins need to follow a specific protocol. To run as a plugin, a program needs to be compiled to a 32-bit shared WebAssembly library. Plugin functions may accept multiple byte buffers as arguments and return a single byte buffer. They should typically be wrapped in idiomatic Typst functions that perform the necessary conversions between native Typst types and bytes.
For security reasons, plugins run in isolation from your system. This means that printing, reading files, or similar things are not supported.
## Example
    
    #let myplugin = plugin("hello.wasm")
    #let concat(a, b) = str(
      myplugin.concatenate(
        bytes(a),
        bytes(b),
      )
    )
    
    #concat("hello", "world")
    
Since the plugin function returns a module, it can be used with import syntax:
    
    #import plugin("hello.wasm"): concatenate
    
## Purity
Plugin functions must be pure: A plugin function call most not have any observable side effects on future plugin calls and given the same arguments, it must always return the same value.
The reason for this is that Typst functions must be pure (which is quite fundamental to the language design) and, since Typst function can call plugin functions, this requirement is inherited. In particular, if a plugin function is called twice with the same arguments, Typst might cache the results and call your function only once. Moreover, Typst may run multiple instances of your plugin in multiple threads, with no state shared between them.
Typst does not enforce plugin function purity (for efficiency reasons), but calling an impure function will lead to unpredictable and irreproducible results and must be avoided.
That said, mutable operations can be useful for plugins that require costly runtime initialization. Due to the purity requirement, such initialization cannot be performed through a normal function call. Instead, Typst exposes a plugin transition API, which executes a function call and then creates a derived module with new functions which will observe the side effects produced by the transition call. The original plugin remains unaffected.
## Plugins and Packages
Any Typst code can make use of a plugin simply by including a WebAssembly file and loading it. However, because the byte-based plugin interface is quite low-level, plugins are typically exposed through a package containing the plugin and idiomatic wrapper functions.
## WASI
Many compilers will use the WASI ABI by default or as their only option (e.g. emscripten), which allows printing, reading files, etc. This ABI will not directly work with Typst. You will either need to compile to a different target or stub all functions.
## Protocol
To be used as a plugin, a WebAssembly module must conform to the following protocol:
### Exports
A plugin module can export functions to make them callable from Typst. To conform to the protocol, an exported function should:
  * Take `n` 32-bit integer arguments `a_1`, `a_2`, ..., `a_n` (interpreted as lengths, so `usize/size_t` may be preferable), and return one 32-bit integer.
  * The function should first allocate a buffer `buf` of length `a_1 + a_2 + ... + a_n`, and then call `wasm_minimal_protocol_write_args_to_buffer(buf.ptr)`.
  * The `a_1` first bytes of the buffer now constitute the first argument, the `a_2` next bytes the second argument, and so on.
  * The function can now do its job with the arguments and produce an output buffer. Before returning, it should call `wasm_minimal_protocol_send_result_to_host` to send its result back to the host.
  * To signal success, the function should return `0`.
  * To signal an error, the function should return `1`. The written buffer is then interpreted as an UTF-8 encoded error message.


### Imports
Plugin modules need to import two functions that are provided by the runtime. (Types and functions are described using WAT syntax.)
  * `(import "typst_env" "wasm_minimal_protocol_write_args_to_buffer" (func (param i32)))`
Writes the arguments for the current function into a plugin-allocated buffer. When a plugin function is called, it receives the lengths of its input buffers as arguments. It should then allocate a buffer whose capacity is at least the sum of these lengths. It should then call this function with a `ptr` to the buffer to fill it with the arguments, one after another.
  * `(import "typst_env" "wasm_minimal_protocol_send_result_to_host" (func (param i32 i32)))`
Sends the output of the current function to the host (Typst). The first parameter shall be a pointer to a buffer (`ptr`), while the second is the length of that buffer (`len`). The memory pointed at by `ptr` can be freed immediately after this function returns. If the message should be interpreted as an error message, it should be encoded as UTF-8.


## Resources
For more resources, check out the wasm-minimal-protocol repository. It contains:
  * A list of example plugin implementations and a test runner for these examples
  * Wrappers to help you write your plugin in Rust (Zig wrapper in development)
  * A stubber for WASI

source
A path to a WebAssembly file or raw WebAssembly bytes.
# transition
Calls a plugin function that has side effects and returns a new module with plugin functions that are guaranteed to have observed the results of the mutable call.
Note that calling an impure function through a normal function call (without use of the transition API) is forbidden and leads to unpredictable behaviour. Read the section on purity for more details.
In the example below, we load the plugin `hello-mut.wasm` which exports two functions: The `get()` function retrieves a global array as a string. The `add(value)` function adds a value to the global array.
We call `add` via the transition API. The call `mutated.get()` on the derived module will observe the addition. Meanwhile the original module remains untouched as demonstrated by the `base.get()` call.
Note: Due to limitations in the internal WebAssembly implementation, the transition API can only guarantee to reflect changes in the plugin's memory, not in WebAssembly globals. If your plugin relies on changes to globals being visible after transition, you might want to avoid use of the transition API for now. We hope to lift this limitation in the future.
func
The plugin function to call.
arguments
The byte buffers to call the function with.
# regex
A regular expression.
Can be used as a show rule selector and with string methods like `find`, `split`, and `replace`.
See here for a specification of the supported syntax.
## Example
    
    // Works with string methods.
    #"a,b;c".split(regex("[,;]"))
    
    // Works with show rules.
    #show regex("\d+"): set text(red)
    
    The numbers 1 to 10.
    
# regex
Create a regular expression from a string.
regex
The regular expression as a string.
Most regex escape sequences just work because they are not valid Typst escape sequences. To produce regex escape sequences that are also valid in Typst (e.g. `\\`), you need to escape twice. Thus, to match a verbatim backslash, you would need to write `regex("\\\\")`.
If you need many escape sequences, you can also create a raw element and extract its text to use it for your regular expressions:
`regex(`\d+\.\d+\.\d+`.text)`.
# repr
Returns the string representation of a value.
When inserted into content, most values are displayed as this representation in monospace with syntax-highlighting. The exceptions are `none`, integers, floats, strings, content, and functions.
Note: This function is for debugging purposes. Its output should not be considered stable and may change at any time!
## Example
    
    #none vs #repr(none) \
    #"hello" vs #repr("hello") \
    #(1, 2) vs #repr((1, 2)) \
    #[*Hi*] vs #repr([*Hi*])
    
value
The value whose string representation to produce.
# selector
A filter for selecting elements within the document.
You can construct a selector in the following ways:
  * you can use an element function
  * you can filter for an element function with specific fields
  * you can use a string or regular expression
  * you can use a `<label>`
  * you can use a `location`
  * call the `selector` constructor to convert any of the above types into a selector value and use the methods below to refine it


Selectors are used to apply styling rules to elements. You can also use selectors to query the document for certain types of elements.
Furthermore, you can pass a selector to several of Typst's built-in functions to configure their behaviour. One such example is the outline where it can be used to change which elements are listed within the outline.
Multiple selectors can be combined using the methods shown below. However, not all kinds of selectors are supported in all places, at the moment.
## Example
    
    #context query(
      heading.where(level: 1)
        .or(heading.where(level: 2))
    )
    
    = This will be found
    == So will this
    === But this will not.
    
# selector
Turns a value into a selector. The following values are accepted:
  * An element function like a `heading` or `figure`.
  * A `<label>`.
  * A more complex selector like `heading.where(level: 1)`.

target
Can be an element function like a `heading` or `figure`, a `<label>` or a more complex selector like `heading.where(level: 1)`.
# or
Selects all elements that match this or any of the other selectors.
others
The other selectors to match on.
# and
Selects all elements that match this and all of the other selectors.
others
The other selectors to match on.
# before
Returns a modified selector that will only match elements that occur before the first match of `end`.
end
The original selection will end at the first match of `end`.
inclusive
Whether `end` itself should match or not. This is only relevant if both selectors match the same type of element. Defaults to `true`.
# after
Returns a modified selector that will only match elements that occur after the first match of `start`.
start
The original selection will start at the first match of `start`.
inclusive
Whether `start` itself should match or not. This is only relevant if both selectors match the same type of element. Defaults to `true`.
# str
A sequence of Unicode codepoints.
You can iterate over the grapheme clusters of the string using a for loop. Grapheme clusters are basically characters but keep together things that belong together, e.g. multiple codepoints that together form a flag emoji. Strings can be added with the `+` operator, joined together and multiplied with integers.
Typst provides utility methods for string manipulation. Many of these methods (e.g., `split`, `trim` and `replace`) operate on patterns: A pattern can be either a string or a regular expression. This makes the methods quite versatile.
All lengths and indices are expressed in terms of UTF-8 bytes. Indices are zero-based and negative indices wrap around to the end of the string.
You can convert a value to a string with this type's constructor.
## Example
    
    #"hello world!" \
    #"\"hello\n  world\"!" \
    #"1 2 3".split() \
    #"1,2;3".split(regex("[,;]")) \
    #(regex("\d+") in "ten euros") \
    #(regex("\d+") in "10 euros")
    
## Escape sequences
Just like in markup, you can escape a few symbols in strings:
  * `\\` for a backslash
  * `\"` for a quote
  * `\n` for a newline
  * `\r` for a carriage return
  * `\t` for a tab
  * `\u{1f600}` for a hexadecimal Unicode escape sequence


# str
Converts a value to a string.
  * Integers are formatted in base 10. This can be overridden with the optional `base` parameter.
  * Floats are formatted in base 10 and never in exponential notation.
  * Negative integers and floats are formatted with the Unicode minus sign ("−" U+2212) instead of the ASCII minus sign ("-" U+002D).
  * From labels the name is extracted.
  * Bytes are decoded as UTF-8.


If you wish to convert from and to Unicode code points, see the `to-unicode` and `from-unicode` functions.
value
The value that should be converted to a string.
base
The base (radix) to display integers in, between 2 and 36.
# len
The length of the string in UTF-8 encoded bytes.
# first
Extracts the first grapheme cluster of the string. Fails with an error if the string is empty.
# last
Extracts the last grapheme cluster of the string. Fails with an error if the string is empty.
# at
Extracts the first grapheme cluster after the specified index. Returns the default value if the index is out of bounds or fails with an error if no default value was specified.
index
The byte index. If negative, indexes from the back.
default
A default value to return if the index is out of bounds.
# slice
Extracts a substring of the string. Fails with an error if the start or end index is out of bounds.
start
The start byte index (inclusive). If negative, indexes from the back.
end
The end byte index (exclusive). If omitted, the whole slice until the end of the string is extracted. If negative, indexes from the back.
count
The number of bytes to extract. This is equivalent to passing `start + count` as the `end` position. Mutually exclusive with `end`.
# clusters
Returns the grapheme clusters of the string as an array of substrings.
# codepoints
Returns the Unicode codepoints of the string as an array of substrings.
# to-unicode
Converts a character into its corresponding code point.
character
The character that should be converted.
# from-unicode
Converts a unicode code point into its corresponding string.
value
The code point that should be converted.
# contains
Whether the string contains the specified pattern.
This method also has dedicated syntax: You can write `"bc" in "abcd"` instead of `"abcd".contains("bc")`.
pattern
The pattern to search for.
# starts-with
Whether the string starts with the specified pattern.
pattern
The pattern the string might start with.
# ends-with
Whether the string ends with the specified pattern.
pattern
The pattern the string might end with.
# find
Searches for the specified pattern in the string and returns the first match as a string or `none` if there is no match.
pattern
The pattern to search for.
# position
Searches for the specified pattern in the string and returns the index of the first match as an integer or `none` if there is no match.
pattern
The pattern to search for.
# match
Searches for the specified pattern in the string and returns a dictionary with details about the first match or `none` if there is no match.
The returned dictionary has the following keys:
  * `start`: The start offset of the match
  * `end`: The end offset of the match
  * `text`: The text that matched.
  * `captures`: An array containing a string for each matched capturing group. The first item of the array contains the first matched capturing, not the whole match! This is empty unless the `pattern` was a regex with capturing groups.

pattern
The pattern to search for.
# matches
Searches for the specified pattern in the string and returns an array of dictionaries with details about all matches. For details about the returned dictionaries, see above.
pattern
The pattern to search for.
# replace
Replace at most `count` occurrences of the given pattern with a replacement string or function (beginning from the start). If no count is given, all occurrences are replaced.
pattern
The pattern to search for.
replacement
The string to replace the matches with or a function that gets a dictionary for each match and can return individual replacement strings.
count
If given, only the first `count` matches of the pattern are placed.
# trim
Removes matches of a pattern from one or both sides of the string, once or repeatedly and returns the resulting string.
pattern
The pattern to search for. If `none`, trims white spaces.
at
Can be `start` or `end` to only trim the start or end of the string. If omitted, both sides are trimmed.
repeat
Whether to repeatedly removes matches of the pattern or just once. Defaults to `true`.
# split
Splits a string at matches of a specified pattern and returns an array of the resulting parts.
When the empty string is used as a separator, it separates every character (i.e., Unicode code point) in the string, along with the beginning and end of the string. In practice, this means that the resulting list of parts will contain the empty string at the start and end of the list.
pattern
The pattern to split at. Defaults to whitespace.
# rev
Reverse the string.
# symbol
A Unicode symbol.
Typst defines common symbols so that they can easily be written with standard keyboards. The symbols are defined in modules, from which they can be accessed using field access notation:
  * General symbols are defined in the `sym` module
  * Emoji are defined in the `emoji` module


Moreover, you can define custom symbols with this type's constructor function.
    
    #sym.arrow.r \
    #sym.gt.eq.not \
    $gt.eq.not$ \
    #emoji.face.halo
    
Many symbols have different variants, which can be selected by appending the modifiers with dot notation. The order of the modifiers is not relevant. Visit the documentation pages of the symbol modules and click on a symbol to see its available variants.
    
    $arrow.l$ \
    $arrow.r$ \
    $arrow.t.quad$
    
# symbol
Create a custom symbol with modifiers.
variants
The variants of the symbol.
Can be a just a string consisting of a single character for the modifierless variant or an array with two strings specifying the modifiers and the symbol. Individual modifiers should be separated by dots. When displaying a symbol, Typst selects the first from the variants that have all attached modifiers and the minimum number of other modifiers.
# sys
Module for system interactions.
This module defines the following items:
  * The `sys.version` constant (of type `version`) that specifies the currently active Typst compiler version.
  * The `sys.inputs` dictionary, which makes external inputs available to the project. An input specified in the command line as `--input key=value` becomes available under `sys.inputs.key` as `"value"`. To include spaces in the value, it may be enclosed with single or double quotes.
The value is always of type string. More complex data may be parsed manually using functions like `json.decode`.


# target
Returns the current export target.
This function returns either
  * `"paged"` (for PDF, PNG, and SVG export), or
  * `"html"` (for HTML export).


The design of this function is not yet finalized and for this reason it is guarded behind the `html` feature. Visit the HTML documentation page for more details.
## When to use it
This function allows you to format your document properly across both HTML and paged export targets. It should primarily be used in templates and show rules, rather than directly in content. This way, the document's contents can be fully agnostic to the export target and content can be shared between PDF and HTML export.
## Varying targets
This function is contextual as the target can vary within a single compilation: When exporting to HTML, the target will be `"paged"` while within an `html.frame`.
## Example
    
    #let kbd(it) = context {
      if target() == "html" {
        html.elem("kbd", it)
      } else {
        set text(fill: rgb("#1f2328"))
        let r = 3pt
        box(
          fill: rgb("#f6f8fa"),
          stroke: rgb("#d1d9e0b3"),
          outset: (y: r),
          inset: (x: r),
          radius: r,
          raw(it)
        )
      }
    }
    
    Press #kbd("F1") for help.
    
# type
Describes a kind of value.
To style your document, you need to work with values of different kinds: Lengths specifying the size of your elements, colors for your text and shapes, and more. Typst categorizes these into clearly defined types and tells you where it expects which type of value.
Apart from basic types for numeric values and typical types known from programming languages, Typst provides a special type for content. A value of this type can hold anything that you can enter into your document: Text, elements like headings and shapes, and style information.
## Example
    
    #let x = 10
    #if type(x) == int [
      #x is an integer!
    ] else [
      #x is another value...
    ]
    
    An image is of type
    #type(image("glacier.jpg")).
    
The type of `10` is `int`. Now, what is the type of `int` or even `type`?
    
    #type(int) \
    #type(type)
    
## Compatibility
In Typst 0.7 and lower, the `type` function returned a string instead of a type. Compatibility with the old way will remain until Typst 0.14 to give package authors time to upgrade.
  * Checks like `int == "integer"` evaluate to `true`
  * Adding/joining a type and string will yield a string
  * The `in` operator on a type and a dictionary will evaluate to `true` if the dictionary has a string key matching the type's name


# type
Determines a value's type.
value
The value whose type's to determine.
# version
A version with an arbitrary number of components.
The first three components have names that can be used as fields: `major`, `minor`, `patch`. All following components do not have names.
The list of components is semantically extended by an infinite list of zeros. This means that, for example, `0.8` is the same as `0.8.0`. As a special case, the empty version (that has no components at all) is the same as `0`, `0.0`, `0.0.0`, and so on.
The current version of the Typst compiler is available as `sys.version`.
You can convert a version to an array of explicitly given components using the `array` constructor.
# version
Creates a new version.
It can have any number of components (even zero).
components
The components of the version (array arguments are flattened)
# at
Retrieves a component of a version.
The returned integer is always non-negative. Returns `0` if the version isn't specified to the necessary length.
index
The index at which to retrieve the component. If negative, indexes from the back of the explicitly given components.
# model
Document structuring.
Here, you can find functions to structure your document and interact with that structure. This includes section headings, figures, bibliography management, cross-referencing and more.
# bibliography
A bibliography / reference listing.
You can create a new bibliography by calling this function with a path to a bibliography file in either one of two formats:
  * A Hayagriva `.yml` file. Hayagriva is a new bibliography file format designed for use with Typst. Visit its documentation for more details.
  * A BibLaTeX `.bib` file.


As soon as you add a bibliography somewhere in your document, you can start citing things with reference syntax (`@key`) or explicit calls to the citation function (`#cite(<key>)`). The bibliography will only show entries for works that were referenced in the document.
## Styles
Typst offers a wide selection of built-in citation and bibliography styles. Beyond those, you can add and use custom CSL (Citation Style Language) files. Wondering which style to use? Here are some good defaults based on what discipline you're working in:
FieldsTypical Styles  
Engineering, IT`"ieee"`  
Psychology, Life Sciences`"apa"`  
Social sciences`"chicago-author-date"`  
Humanities`"mla"`, `"chicago-notes"`, `"harvard-cite-them-right"`  
Economics`"harvard-cite-them-right"`  
Physics`"american-physics-society"`  
## Example
    
    This was already noted by
    pirates long ago. @arrgh
    
    Multiple sources say ...
    @arrgh @netwok.
    
    #bibliography("works.bib")
    
sources
One or multiple paths to or raw bytes for Hayagriva `.yml` and/or BibLaTeX `.bib` files.
This can be a:
  * A path string to load a bibliography file from the given path. For more details about paths, see the Paths section.
  * Raw bytes from which the bibliography should be decoded.
  * An array where each item is one the above.

title
The title of the bibliography.
  * When set to `auto`, an appropriate title for the text language will be used. This is the default.
  * When set to `none`, the bibliography will not have a title.
  * A custom title can be set by passing content.


The bibliography's heading will not be numbered by default, but you can force it to be with a show-set rule: `show bibliography: set heading(numbering: "1.")`
full
Whether to include all works from the given bibliography files, even those that weren't cited in the document.
To selectively add individual cited works without showing them, you can also use the `cite` function with `form` set to `none`.
style
The bibliography style.
This can be:
  * A string with the name of one of the built-in styles (see below). Some of the styles listed below appear twice, once with their full name and once with a short alias.
  * A path string to a CSL file. For more details about paths, see the Paths section.
  * Raw bytes from which a CSL style should be decoded.


# list
A bullet list.
Displays a sequence of items vertically, with each item introduced by a marker.
## Example
    
    Normal list.
    - Text
    - Math
    - Layout
    - ...
    
    Multiple lines.
    - This list item spans multiple
      lines because it is indented.
    
    Function call.
    #list(
      [Foundations],
      [Calculate],
      [Construct],
      [Data Loading],
    )
    
## Syntax
This functions also has dedicated syntax: Start a line with a hyphen, followed by a space to create a list item. A list item can contain multiple paragraphs and other block-level content. All content that is indented more than an item's marker becomes part of that item.
tight
Defines the default spacing of the list. If it is `false`, the items are spaced apart with paragraph spacing. If it is `true`, they use paragraph leading instead. This makes the list more compact, which can look better if the items are short.
In markup mode, the value of this parameter is determined based on whether items are separated with a blank line. If items directly follow each other, this is set to `true`; if items are separated by a blank line, this is set to `false`. The markup-defined tightness cannot be overridden with set rules.
    
    - If a list has a lot of text, and
      maybe other inline content, it
      should not be tight anymore.
    
    - To make a list wide, simply insert
      a blank line between the items.
    
marker
The marker which introduces each item.
Instead of plain content, you can also pass an array with multiple markers that should be used for nested lists. If the list nesting depth exceeds the number of markers, the markers are cycled. For total control, you may pass a function that maps the list's nesting depth (starting from `0`) to a desired marker.
    
    #set list(marker: [--])
    - A more classic list
    - With en-dashes
    
    #set list(marker: ([•], [--]))
    - Top-level
      - Nested
      - Items
    - Items
    
indent
The indent of each item.
body-indent
The spacing between the marker and the body of each item.
spacing
The spacing between the items of the list.
If set to `auto`, uses paragraph `leading` for tight lists and paragraph `spacing` for wide (non-tight) lists.
children
The bullet list's children.
When using the list syntax, adjacent items are automatically collected into lists, even through constructs like for loops.
    
    #for letter in "ABC" [
      - Letter #letter
    ]
    
# item
A bullet list item.
body
The item's body.
# cite
Cite a work from the bibliography.
Before you starting citing, you need to add a bibliography somewhere in your document.
## Example
    
    This was already noted by
    pirates long ago. @arrgh
    
    Multiple sources say ...
    @arrgh @netwok.
    
    You can also call `cite`
    explicitly. #cite(<arrgh>)
    
    #bibliography("works.bib")
    
If your source name contains certain characters such as slashes, which are not recognized by the `<>` syntax, you can explicitly call `label` instead.
    
    Computer Modern is an example of a modernist serif typeface.
    #cite(label("DBLP:books/lib/Knuth86a")).
    
## Syntax
This function indirectly has dedicated syntax. References can be used to cite works from the bibliography. The label then corresponds to the citation key.
key
The citation key that identifies the entry in the bibliography that shall be cited, as a label.
    
    // All the same
    @netwok \
    #cite(<netwok>) \
    #cite(label("netwok"))
    
supplement
A supplement for the citation such as page or chapter number.
In reference syntax, the supplement can be added in square brackets:
    
    This has been proven. @distress[p.~7]
    
    #bibliography("works.bib")
    
form
The kind of citation to produce. Different forms are useful in different scenarios: A normal citation is useful as a source at the end of a sentence, while a "prose" citation is more suitable for inclusion in the flow of text.
If set to `none`, the cited work is included in the bibliography, but nothing will be displayed.
    
    #cite(<netwok>, form: "prose")
    show the outsized effects of
    pirate life on the human psyche.
    
style
The citation style.
This can be:
  * `auto` to automatically use the bibliography's style for citations.
  * A string with the name of one of the built-in styles (see below). Some of the styles listed below appear twice, once with their full name and once with a short alias.
  * A path string to a CSL file. For more details about paths, see the Paths section.
  * Raw bytes from which a CSL style should be decoded.


# document
The root element of a document and its metadata.
All documents are automatically wrapped in a `document` element. You cannot create a document element yourself. This function is only used with set rules to specify document metadata. Such a set rule must not occur inside of any layout container.
    
    #set document(title: [Hello])
    
    This has no visible output, but
    embeds metadata into the PDF!
    
Note that metadata set with this function is not rendered within the document. Instead, it is embedded in the compiled PDF file.
title
The document's title. This is often rendered as the title of the PDF viewer window.
While this can be arbitrary content, PDF viewers only support plain text titles, so the conversion might be lossy.
author
The document's authors.
description
The document's description.
keywords
The document's keywords.
date
The document's creation date.
If this is `auto` (default), Typst uses the current date and time. Setting it to `none` prevents Typst from embedding any creation date into the PDF metadata.
The year component must be at least zero in order to be embedded into a PDF.
If you want to create byte-by-byte reproducible PDFs, set this to something other than `auto`.
# emph
Emphasizes content by toggling italics.
  * If the current text style is `"normal"`, this turns it into `"italic"`.
  * If it is already `"italic"` or `"oblique"`, it turns it back to `"normal"`.


## Example
    
    This is _emphasized._ \
    This is #emph[too.]
    
    #show emph: it => {
      text(blue, it.body)
    }
    
    This is _emphasized_ differently.
    
## Syntax
This function also has dedicated syntax: To emphasize content, simply enclose it in underscores (`_`). Note that this only works at word boundaries. To emphasize part of a word, you have to use the function.
body
The content to emphasize.
# figure
A figure with an optional caption.
Automatically detects its kind to select the correct counting track. For example, figures containing images will be numbered separately from figures containing tables.
## Examples
The example below shows a basic figure with an image:
    
    @glacier shows a glacier. Glaciers
    are complex systems.
    
    #figure(
      image("glacier.jpg", width: 80%),
      caption: [A curious figure.],
    ) <glacier>
    
You can also insert tables into figures to give them a caption. The figure will detect this and automatically use a separate counter.
    
    #figure(
      table(
        columns: 4,
        [t], [1], [2], [3],
        [y], [0.3s], [0.4s], [0.8s],
      ),
      caption: [Timing results],
    )
    
This behaviour can be overridden by explicitly specifying the figure's `kind`. All figures of the same kind share a common counter.
## Figure behaviour
By default, figures are placed within the flow of content. To make them float to the top or bottom of the page, you can use the `placement` argument.
If your figure is too large and its contents are breakable across pages (e.g. if it contains a large table), then you can make the figure itself breakable across pages as well with this show rule:
    
    #show figure: set block(breakable: true)
    
See the block documentation for more information about breakable and non-breakable blocks.
## Caption customization
You can modify the appearance of the figure's caption with its associated `caption` function. In the example below, we emphasize all captions:
    
    #show figure.caption: emph
    
    #figure(
      rect[Hello],
      caption: [I am emphasized!],
    )
    
By using a `where` selector, we can scope such rules to specific kinds of figures. For example, to position the caption above tables, but keep it below for all other kinds of figures, we could write the following show-set rule:
    
    #show figure.where(
      kind: table
    ): set figure.caption(position: top)
    
    #figure(
      table(columns: 2)[A][B][C][D],
      caption: [I'm up here],
    )
    
body
The content of the figure. Often, an image.
placement
The figure's placement on the page.
  * `none`: The figure stays in-flow exactly where it was specified like other content.
  * `auto`: The figure picks `top` or `bottom` depending on which is closer.
  * `top`: The figure floats to the top of the page.
  * `bottom`: The figure floats to the bottom of the page.


The gap between the main flow content and the floating figure is controlled by the `clearance` argument on the `place` function.
    
    #set page(height: 200pt)
    
    = Introduction
    #figure(
      placement: bottom,
      caption: [A glacier],
      image("glacier.jpg", width: 60%),
    )
    #lorem(60)
    
scope
Relative to which containing scope the figure is placed.
Set this to `"parent"` to create a full-width figure in a two-column document.
Has no effect if `placement` is `none`.
    
    #set page(height: 250pt, columns: 2)
    
    = Introduction
    #figure(
      placement: bottom,
      scope: "parent",
      caption: [A glacier],
      image("glacier.jpg", width: 60%),
    )
    #lorem(60)
    
caption
The figure's caption.
kind
The kind of figure this is.
All figures of the same kind share a common counter.
If set to `auto`, the figure will try to automatically determine its kind based on the type of its body. Automatically detected kinds are tables and code. In other cases, the inferred kind is that of an image.
Setting this to something other than `auto` will override the automatic detection. This can be useful if
  * you wish to create a custom figure type that is not an image, a table or code,
  * you want to force the figure to use a specific counter regardless of its content.


You can set the kind to be an element function or a string. If you set it to an element function other than `table`, `raw` or `image`, you will need to manually specify the figure's supplement.
    
    #figure(
      circle(radius: 10pt),
      caption: [A curious atom.],
      kind: "atom",
      supplement: [Atom],
    )
    
supplement
The figure's supplement.
If set to `auto`, the figure will try to automatically determine the correct supplement based on the `kind` and the active text language. If you are using a custom figure type, you will need to manually specify the supplement.
If a function is specified, it is passed the first descendant of the specified `kind` (typically, the figure's body) and should return content.
    
    #figure(
      [The contents of my figure!],
      caption: [My custom figure],
      supplement: [Bar],
      kind: "foo",
    )
    
numbering
How to number the figure. Accepts a numbering pattern or function.
gap
The vertical gap between the body and caption.
outlined
Whether the figure should appear in an `outline` of figures.
# caption
The caption of a figure. This element can be used in set and show rules to customize the appearance of captions for all figures or figures of a specific kind.
In addition to its `pos` and `body`, the `caption` also provides the figure's `kind`, `supplement`, `counter`, and `numbering` as fields. These parts can be used in `where` selectors and show rules to build a completely custom caption.
position
The caption's position in the figure. Either `top` or `bottom`.
    
    #show figure.where(
      kind: table
    ): set figure.caption(position: top)
    
    #figure(
      table(columns: 2)[A][B],
      caption: [I'm up here],
    )
    
    #figure(
      rect[Hi],
      caption: [I'm down here],
    )
    
    #figure(
      table(columns: 2)[A][B],
      caption: figure.caption(
        position: bottom,
        [I'm down here too!]
      )
    )
    
separator
The separator which will appear between the number and body.
If set to `auto`, the separator will be adapted to the current language and region.
    
    #set figure.caption(separator: [ --- ])
    
    #figure(
      rect[Hello],
      caption: [A rectangle],
    )
    
body
The caption's body.
Can be used alongside `kind`, `supplement`, `counter`, `numbering`, and `location` to completely customize the caption.
    
    #show figure.caption: it => [
      #underline(it.body) |
      #it.supplement
      #context it.counter.display(it.numbering)
    ]
    
    #figure(
      rect[Hello],
      caption: [A rectangle],
    )
    
# footnote
A footnote.
Includes additional remarks and references on the same page with footnotes. A footnote will insert a superscript number that links to the note at the bottom of the page. Notes are numbered sequentially throughout your document and can break across multiple pages.
To customize the appearance of the entry in the footnote listing, see `footnote.entry`. The footnote itself is realized as a normal superscript, so you can use a set rule on the `super` function to customize it. You can also apply a show rule to customize only the footnote marker (superscript number) in the running text.
## Example
    
    Check the docs for more details.
    #footnote[https://typst.app/docs]
    
The footnote automatically attaches itself to the preceding word, even if there is a space before it in the markup. To force space, you can use the string `#" "` or explicit horizontal spacing.
By giving a label to a footnote, you can have multiple references to it.
    
    You can edit Typst documents online.
    #footnote[https://typst.app/app] <fn>
    Checkout Typst's website. @fn
    And the online app. #footnote(<fn>)
    
Note: Set and show rules in the scope where `footnote` is called may not apply to the footnote's content. See here for more information.
numbering
How to number footnotes.
By default, the footnote numbering continues throughout your document. If you prefer per-page footnote numbering, you can reset the footnote counter in the page header. In the future, there might be a simpler way to achieve this.
    
    #set footnote(numbering: "*")
    
    Footnotes:
    #footnote[Star],
    #footnote[Dagger]
    
body
The content to put into the footnote. Can also be the label of another footnote this one should point to.
# entry
An entry in a footnote list.
This function is not intended to be called directly. Instead, it is used in set and show rules to customize footnote listings.
note
The footnote for this entry. Its location can be used to determine the footnote counter state.
    
    #show footnote.entry: it => {
      let loc = it.note.location()
      numbering(
        "1: ",
        ..counter(footnote).at(loc),
      )
      it.note.body
    }
    
    Customized #footnote[Hello]
    listing #footnote[World! 🌏]
    
separator
The separator between the document body and the footnote listing.
    
    #set footnote.entry(
      separator: repeat[.]
    )
    
    Testing a different separator.
    #footnote[
      Unconventional, but maybe
      not that bad?
    ]
    
clearance
The amount of clearance between the document body and the separator.
    
    #set footnote.entry(clearance: 3em)
    
    Footnotes also need ...
    #footnote[
      ... some space to breathe.
    ]
    
gap
The gap between footnote entries.
    
    #set footnote.entry(gap: 0.8em)
    
    Footnotes:
    #footnote[Spaced],
    #footnote[Apart]
    
indent
The indent of each footnote entry.
    
    #set footnote.entry(indent: 0em)
    
    Footnotes:
    #footnote[No],
    #footnote[Indent]
    
# heading
A section heading.
With headings, you can structure your document into sections. Each heading has a level, which starts at one and is unbounded upwards. This level indicates the logical role of the following content (section, subsection, etc.) A top-level heading indicates a top-level section of the document (not the document's title).
Typst can automatically number your headings for you. To enable numbering, specify how you want your headings to be numbered with a numbering pattern or function.
Independently of the numbering, Typst can also automatically generate an outline of all headings for you. To exclude one or more headings from this outline, you can set the `outlined` parameter to `false`.
## Example
    
    #set heading(numbering: "1.a)")
    
    = Introduction
    In recent years, ...
    
    == Preliminaries
    To start, ...
    
## Syntax
Headings have dedicated syntax: They can be created by starting a line with one or multiple equals signs, followed by a space. The number of equals signs determines the heading's logical nesting depth. The `offset` field can be set to configure the starting depth.
level
The absolute nesting depth of the heading, starting from one. If set to `auto`, it is computed from `offset + depth`.
This is primarily useful for usage in show rules (either with `where` selectors or by accessing the level directly on a shown heading).
    
    #show heading.where(level: 2): set text(red)
    
    = Level 1
    == Level 2
    
    #set heading(offset: 1)
    = Also level 2
    == Level 3
    
depth
The relative nesting depth of the heading, starting from one. This is combined with `offset` to compute the actual `level`.
This is set by the heading syntax, such that `== Heading` creates a heading with logical depth of 2, but actual level `offset + 2`. If you construct a heading manually, you should typically prefer this over setting the absolute level.
offset
The starting offset of each heading's `level`, used to turn its relative `depth` into its absolute `level`.
    
    = Level 1
    
    #set heading(offset: 1, numbering: "1.1")
    = Level 2
    
    #heading(offset: 2, depth: 2)[
      I'm level 4
    ]
    
numbering
How to number the heading. Accepts a numbering pattern or function.
    
    #set heading(numbering: "1.a.")
    
    = A section
    == A subsection
    === A sub-subsection
    
supplement
A supplement for the heading.
For references to headings, this is added before the referenced number.
If a function is specified, it is passed the referenced heading and should return content.
    
    #set heading(numbering: "1.", supplement: [Chapter])
    
    = Introduction <intro>
    In @intro, we see how to turn
    Sections into Chapters. And
    in @intro[Part], it is done
    manually.
    
outlined
Whether the heading should appear in the outline.
Note that this property, if set to `true`, ensures the heading is also shown as a bookmark in the exported PDF's outline (when exporting to PDF). To change that behavior, use the `bookmarked` property.
    
    #outline()
    
    #heading[Normal]
    This is a normal heading.
    
    #heading(outlined: false)[Hidden]
    This heading does not appear
    in the outline.
    
bookmarked
Whether the heading should appear as a bookmark in the exported PDF's outline. Doesn't affect other export formats, such as PNG.
The default value of `auto` indicates that the heading will only appear in the exported PDF's outline if its `outlined` property is set to `true`, that is, if it would also be listed in Typst's outline. Setting this property to either `true` (bookmark) or `false` (don't bookmark) bypasses that behavior.
    
    #heading[Normal heading]
    This heading will be shown in
    the PDF's bookmark outline.
    
    #heading(bookmarked: false)[Not bookmarked]
    This heading won't be
    bookmarked in the resulting
    PDF.
    
hanging-indent
The indent all but the first line of a heading should have.
The default value of `auto` indicates that the subsequent heading lines will be indented based on the width of the numbering.
    
    #set heading(numbering: "1.")
    #heading[A very, very, very, very, very, very long heading]
    
body
The heading's title.
# link
Links to a URL or a location in the document.
By default, links do not look any different from normal text. However, you can easily apply a style of your choice with a show rule.
## Example
    
    #show link: underline
    
    https://example.com \
    
    #link("https://example.com") \
    #link("https://example.com")[
      See example.com
    ]
    
## Hyphenation
If you enable hyphenation or justification, by default, it will not apply to links to prevent unwanted hyphenation in URLs. You can opt out of this default via `show link: set text(hyphenate: true)`.
## Syntax
This function also has dedicated syntax: Text that starts with `http://` or `https://` is automatically turned into a link.
dest
The destination the link points to.
  * To link to web pages, `dest` should be a valid URL string. If the URL is in the `mailto:` or `tel:` scheme and the `body` parameter is omitted, the email address or phone number will be the link's body, without the scheme.
  * To link to another part of the document, `dest` can take one of three forms:
    * A label attached to an element. If you also want automatic text for the link based on the element, consider using a reference instead.
    * A `location` (typically retrieved from `here`, `locate` or `query`).
    * A dictionary with a `page` key of type integer and `x` and `y` coordinates of type length. Pages are counted from one, and the coordinates are relative to the page's top left corner.


    
    = Introduction <intro>
    #link("mailto:hello@typst.app") \
    #link(<intro>)[Go to intro] \
    #link((page: 1, x: 0pt, y: 0pt))[
      Go to top
    ]
    
body
The content that should become a link.
If `dest` is an URL string, the parameter can be omitted. In this case, the URL will be shown as the link.
# enum
A numbered list.
Displays a sequence of items vertically and numbers them consecutively.
## Example
    
    Automatically numbered:
    + Preparations
    + Analysis
    + Conclusions
    
    Manually numbered:
    2. What is the first step?
    5. I am confused.
    +  Moving on ...
    
    Multiple lines:
    + This enum item has multiple
      lines because the next line
      is indented.
    
    Function call.
    #enum[First][Second]
    
You can easily switch all your enumerations to a different numbering style with a set rule.
    
    #set enum(numbering: "a)")
    
    + Starting off ...
    + Don't forget step two
    
You can also use `enum.item` to programmatically customize the number of each item in the enumeration:
    
    #enum(
      enum.item(1)[First step],
      enum.item(5)[Fifth step],
      enum.item(10)[Tenth step]
    )
    
## Syntax
This functions also has dedicated syntax:
  * Starting a line with a plus sign creates an automatically numbered enumeration item.
  * Starting a line with a number followed by a dot creates an explicitly numbered enumeration item.


Enumeration items can contain multiple paragraphs and other block-level content. All content that is indented more than an item's marker becomes part of that item.
tight
Defines the default spacing of the enumeration. If it is `false`, the items are spaced apart with paragraph spacing. If it is `true`, they use paragraph leading instead. This makes the list more compact, which can look better if the items are short.
In markup mode, the value of this parameter is determined based on whether items are separated with a blank line. If items directly follow each other, this is set to `true`; if items are separated by a blank line, this is set to `false`. The markup-defined tightness cannot be overridden with set rules.
    
    + If an enum has a lot of text, and
      maybe other inline content, it
      should not be tight anymore.
    
    + To make an enum wide, simply
      insert a blank line between the
      items.
    
numbering
How to number the enumeration. Accepts a numbering pattern or function.
If the numbering pattern contains multiple counting symbols, they apply to nested enums. If given a function, the function receives one argument if `full` is `false` and multiple arguments if `full` is `true`.
    
    #set enum(numbering: "1.a)")
    + Different
    + Numbering
      + Nested
      + Items
    + Style
    
    #set enum(numbering: n => super[#n])
    + Superscript
    + Numbering!
    
start
Which number to start the enumeration with.
    
    #enum(
      start: 3,
      [Skipping],
      [Ahead],
    )
    
full
Whether to display the full numbering, including the numbers of all parent enumerations.
    
    #set enum(numbering: "1.a)", full: true)
    + Cook
      + Heat water
      + Add ingredients
    + Eat
    
reversed
Whether to reverse the numbering for this enumeration.
    
    #set enum(reversed: true)
    + Coffee
    + Tea
    + Milk
    
indent
The indentation of each item.
body-indent
The space between the numbering and the body of each item.
spacing
The spacing between the items of the enumeration.
If set to `auto`, uses paragraph `leading` for tight enumerations and paragraph `spacing` for wide (non-tight) enumerations.
number-align
The alignment that enum numbers should have.
By default, this is set to `end + top`, which aligns enum numbers towards end of the current text direction (in left-to-right script, for example, this is the same as `right`) and at the top of the line. The choice of `end` for horizontal alignment of enum numbers is usually preferred over `start`, as numbers then grow away from the text instead of towards it, avoiding certain visual issues. This option lets you override this behaviour, however. (Also to note is that the unordered list uses a different method for this, by giving the `marker` content an alignment directly.).
    
    #set enum(number-align: start + bottom)
    
    Here are some powers of two:
    1. One
    2. Two
    4. Four
    8. Eight
    16. Sixteen
    32. Thirty two
    
children
The numbered list's items.
When using the enum syntax, adjacent items are automatically collected into enumerations, even through constructs like for loops.
    
    #for phase in (
       "Launch",
       "Orbit",
       "Descent",
    ) [+ #phase]
    
# item
An enumeration item.
number
The item's number.
body
The item's body.
# numbering
Applies a numbering to a sequence of numbers.
A numbering defines how a sequence of numbers should be displayed as content. It is defined either through a pattern string or an arbitrary function.
A numbering pattern consists of counting symbols, for which the actual number is substituted, their prefixes, and one suffix. The prefixes and the suffix are repeated as-is.
## Example
    
    #numbering("1.1)", 1, 2, 3) \
    #numbering("1.a.i", 1, 2) \
    #numbering("I – 1", 12, 2) \
    #numbering(
      (..nums) => nums
        .pos()
        .map(str)
        .join(".") + ")",
      1, 2, 3,
    )
    
## Numbering patterns and numbering functions
There are multiple instances where you can provide a numbering pattern or function in Typst. For example, when defining how to number headings or figures. Every time, the expected format is the same as the one described below for the `numbering` parameter.
The following example illustrates that a numbering function is just a regular function that accepts numbers and returns `content`.
    
    #let unary(.., last) = "|" * last
    #set heading(numbering: unary)
    = First heading
    = Second heading
    = Third heading
    
numbering
Defines how the numbering works.
Counting symbols are `1`, `a`, `A`, `i`, `I`, `α`, `Α`, `一`, `壹`, `あ`, `い`, `ア`, `イ`, `א`, `가`, `ㄱ`, `*`, `١`, `۱`, `१`, `১`, `ক`, `①`, and `⓵`. They are replaced by the number in the sequence, preserving the original case.
The `*` character means that symbols should be used to count, in the order of `*`, `†`, `‡`, `§`, `¶`, `‖`. If there are more than six items, the number is represented using repeated symbols.
Suffixes are all characters after the last counting symbol. They are repeated as-is at the end of any rendered number.
Prefixes are all characters that are neither counting symbols nor suffixes. They are repeated as-is at in front of their rendered equivalent of their counting symbol.
This parameter can also be an arbitrary function that gets each number as an individual argument. When given a function, the `numbering` function just forwards the arguments to that function. While this is not particularly useful in itself, it means that you can just give arbitrary numberings to the `numbering` function without caring whether they are defined as a pattern or function.
numbers
The numbers to apply the numbering to. Must be positive.
If `numbering` is a pattern and more numbers than counting symbols are given, the last counting symbol with its prefix is repeated.
# outline
A table of contents, figures, or other elements.
This function generates a list of all occurrences of an element in the document, up to a given `depth`. The element's numbering and page number will be displayed in the outline alongside its title or caption.
## Example
    
    #set heading(numbering: "1.")
    #outline()
    
    = Introduction
    #lorem(5)
    
    = Methods
    == Setup
    #lorem(10)
    
## Alternative outlines
In its default configuration, this function generates a table of contents. By setting the `target` parameter, the outline can be used to generate a list of other kinds of elements than headings.
In the example below, we list all figures containing images by setting `target` to `figure.where(kind: image)`. Just the same, we could have set it to `figure.where(kind: table)` to generate a list of tables.
We could also set it to just `figure`, without using a `where` selector, but then the list would contain all figures, be it ones containing images, tables, or other material.
    
    #outline(
      title: [List of Figures],
      target: figure.where(kind: image),
    )
    
    #figure(
      image("tiger.jpg"),
      caption: [A nice figure!],
    )
    
## Styling the outline
At the most basic level, you can style the outline by setting properties on it and its entries. This way, you can customize the outline's title, how outline entries are indented, and how the space between an entry's text and its page number should be filled.
Richer customization is possible through configuration of the outline's entries. The outline generates one entry for each outlined element.
### Spacing the entries
Outline entries are blocks, so you can adjust the spacing between them with normal block-spacing rules:
    
    #show outline.entry.where(
      level: 1
    ): set block(above: 1.2em)
    
    #outline()
    
    = About ACME Corp.
    == History
    === Origins
    = Products
    == ACME Tools
    
### Building an outline entry from its parts
For full control, you can also write a transformational show rule on `outline.entry`. However, the logic for properly formatting and indenting outline entries is quite complex and the outline entry itself only contains two fields: The level and the outlined element.
For this reason, various helper functions are provided. You can mix and match these to compose an entry from just the parts you like.
The default show rule for an outline entry looks like this1:
    
    #show outline.entry: it => link(
      it.element.location(),
      it.indented(it.prefix(), it.inner()),
    )
    
  * The `indented` function takes an optional prefix and inner content and automatically applies the proper indentation to it, such that different entries align nicely and long headings wrap properly.
  * The `prefix` function formats the element's numbering (if any). It also appends a supplement for certain elements.
  * The `inner` function combines the element's `body`, the filler, and the `page` number.


You can use these individual functions to format the outline entry in different ways. Let's say, you'd like to fully remove the filler and page numbers. To achieve this, you could write a show rule like this:
    
    #show outline.entry: it => link(
      it.element.location(),
      // Keep just the body, dropping
      // the fill and the page.
      it.indented(it.prefix(), it.body()),
    )
    
    #outline()
    
    = About ACME Corp.
    == History
    
1
The outline of equations is the exception to this rule as it does not have a body and thus does not use indented layout.
title
The title of the outline.
  * When set to `auto`, an appropriate title for the text language will be used.
  * When set to `none`, the outline will not have a title.
  * A custom title can be set by passing content.


The outline's heading will not be numbered by default, but you can force it to be with a show-set rule: `show outline: set heading(numbering: "1.")`
target
The type of element to include in the outline.
To list figures containing a specific kind of element, like an image or a table, you can specify the desired kind in a `where` selector. See the section on alternative outlines for more details.
    
    #outline(
      title: [List of Tables],
      target: figure.where(kind: table),
    )
    
    #figure(
      table(
        columns: 4,
        [t], [1], [2], [3],
        [y], [0.3], [0.7], [0.5],
      ),
      caption: [Experiment results],
    )
    
depth
The maximum level up to which elements are included in the outline. When this argument is `none`, all elements are included.
    
    #set heading(numbering: "1.")
    #outline(depth: 2)
    
    = Yes
    Top-level section.
    
    == Still
    Subsection.
    
    === Nope
    Not included.
    
indent
How to indent the outline's entries.
  * `auto`: Indents the numbering/prefix of a nested entry with the title of its parent entry. If the entries are not numbered (e.g., via heading numbering), this instead simply inserts a fixed amount of `1.2em` indent per level.
  * Relative length: Indents the entry by the specified length per nesting level. Specifying `2em`, for instance, would indent top-level headings by `0em` (not nested), second level headings by `2em` (nested once), third-level headings by `4em` (nested twice) and so on.
  * Function: You can further customize this setting with a function. That function receives the nesting level as a parameter (starting at 0 for top-level headings/elements) and should return a (relative) length. For example, `n => n * 2em` would be equivalent to just specifying `2em`.


    
    #set heading(numbering: "1.a.")
    
    #outline(
      title: [Contents (Automatic)],
      indent: auto,
    )
    
    #outline(
      title: [Contents (Length)],
      indent: 2em,
    )
    
    = About ACME Corp.
    == History
    === Origins
    #lorem(10)
    
    == Products
    #lorem(10)
    
# entry
Represents an entry line in an outline.
With show-set and show rules on outline entries, you can richly customize the outline's appearance. See the section on styling the outline for details.
level
The nesting level of this outline entry. Starts at `1` for top-level entries.
element
The element this entry refers to. Its location will be available through the `location` method on the content and can be linked to.
fill
Content to fill the space between the title and the page number. Can be set to `none` to disable filling.
The `fill` will be placed into a fractionally sized box that spans the space between the entry's body and the page number. When using show rules to override outline entries, it is thus recommended to wrap the fill in a `box` with fractional width, i.e. `box(width: 1fr, it.fill`.
When using `repeat`, the `gap` property can be useful to tweak the visual weight of the fill.
    
    #set outline.entry(fill: line(length: 100%))
    #outline()
    
    = A New Beginning
    
# indented
A helper function for producing an indented entry layout: Lays out a prefix and the rest of the entry in an indent-aware way.
If the parent outline's `indent` is `auto`, the inner content of all entries at level `N` is aligned with the prefix of all entries at level `N + 1`, leaving at least `gap` space between the prefix and inner parts. Furthermore, the `inner` contents of all entries at the same level are aligned.
If the outline's indent is a fixed value or a function, the prefixes are indented, but the inner contents are simply inset from the prefix by the specified `gap`, rather than aligning outline-wide.
prefix
The `prefix` is aligned with the `inner` content of entries that have level one less.
In the default show rule, this is just `it.prefix()`, but it can be freely customized.
inner
The formatted inner content of the entry.
In the default show rule, this is just `it.inner()`, but it can be freely customized.
gap
The gap between the prefix and the inner content.
# prefix
Formats the element's numbering (if any).
This also appends the element's supplement in case of figures or equations. For instance, it would output `1.1` for a heading, but `Figure 1` for a figure, as is usual for outlines.
# inner
Creates the default inner content of the entry.
This includes the body, the fill, and page number.
# body
The content which is displayed in place of the referred element at its entry in the outline. For a heading, this is its `body`; for a figure a caption and for equations, it is empty.
# page
The page number of this entry's element, formatted with the numbering set for the referenced page.
# par
A logical subdivison of textual content.
Typst automatically collects inline-level elements into paragraphs. Inline-level elements include text, horizontal spacing, boxes, and inline equations.
To separate paragraphs, use a blank line (or an explicit `parbreak`). Paragraphs are also automatically interrupted by any block-level element (like `block`, `place`, or anything that shows itself as one of these).
The `par` element is primarily used in set rules to affect paragraph properties, but it can also be used to explicitly display its argument as a paragraph of its own. Then, the paragraph's body may not contain any block-level content.
## Boxes and blocks
As explained above, usually paragraphs only contain inline-level content. However, you can integrate any kind of block-level content into a paragraph by wrapping it in a `box`.
Conversely, you can separate inline-level content from a paragraph by wrapping it in a `block`. In this case, it will not become part of any paragraph at all. Read the following section for an explanation of why that matters and how it differs from just adding paragraph breaks around the content.
## What becomes a paragraph?
When you add inline-level content to your document, Typst will automatically wrap it in paragraphs. However, a typical document also contains some text that is not semantically part of a paragraph, for example in a heading or caption.
The rules for when Typst wraps inline-level content in a paragraph are as follows:
  * All text at the root of a document is wrapped in paragraphs.
  * Text in a container (like a `block`) is only wrapped in a paragraph if the container holds any block-level content. If all of the contents are inline-level, no paragraph is created.


In the laid-out document, it's not immediately visible whether text became part of a paragraph. However, it is still important for various reasons:
  * Certain paragraph styling like `first-line-indent` will only apply to proper paragraphs, not any text. Similarly, `par` show rules of course only trigger on paragraphs.
  * A proper distinction between paragraphs and other text helps people who rely on assistive technologies (such as screen readers) navigate and understand the document properly. Currently, this only applies to HTML export since Typst does not yet output accessible PDFs, but support for this is planned for the near future.
  * HTML export will generate a `<p>` tag only for paragraphs.


When creating custom reusable components, you can and should take charge over whether Typst creates paragraphs. By wrapping text in a `block` instead of just adding paragraph breaks around it, you can force the absence of a paragraph. Conversely, by adding a `parbreak` after some content in a container, you can force it to become a paragraph even if it's just one word. This is, for example, what non-`tight` lists do to force their items to become paragraphs.
## Example
    
    #set par(
      first-line-indent: 1em,
      spacing: 0.65em,
      justify: true,
    )
    
    We proceed by contradiction.
    Suppose that there exists a set
    of positive integers $a$, $b$, and
    $c$ that satisfies the equation
    $a^n + b^n = c^n$ for some
    integer value of $n > 2$.
    
    Without loss of generality,
    let $a$ be the smallest of the
    three integers. Then, we ...
    
leading
The spacing between lines.
Leading defines the spacing between the bottom edge of one line and the top edge of the following line. By default, these two properties are up to the font, but they can also be configured manually with a text set rule.
By setting top edge, bottom edge, and leading, you can also configure a consistent baseline-to-baseline distance. You could, for instance, set the leading to `1em`, the top-edge to `0.8em`, and the bottom-edge to `-0.2em` to get a baseline gap of exactly `2em`. The exact distribution of the top- and bottom-edge values affects the bounds of the first and last line.
spacing
The spacing between paragraphs.
Just like leading, this defines the spacing between the bottom edge of a paragraph's last line and the top edge of the next paragraph's first line.
When a paragraph is adjacent to a `block` that is not a paragraph, that block's `above` or `below` property takes precedence over the paragraph spacing. Headings, for instance, reduce the spacing below them by default for a better look.
justify
Whether to justify text in its line.
Hyphenation will be enabled for justified paragraphs if the text function's `hyphenate` property is set to `auto` and the current language is known.
Note that the current alignment still has an effect on the placement of the last line except if it ends with a justified line break.
linebreaks
How to determine line breaks.
When this property is set to `auto`, its default value, optimized line breaks will be used for justified paragraphs. Enabling optimized line breaks for ragged paragraphs may also be worthwhile to improve the appearance of the text.
    
    #set page(width: 207pt)
    #set par(linebreaks: "simple")
    Some texts feature many longer
    words. Those are often exceedingly
    challenging to break in a visually
    pleasing way.
    
    #set par(linebreaks: "optimized")
    Some texts feature many longer
    words. Those are often exceedingly
    challenging to break in a visually
    pleasing way.
    
first-line-indent
The indent the first line of a paragraph should have.
By default, only the first line of a consecutive paragraph will be indented (not the first one in the document or container, and not paragraphs immediately following other block-level elements).
If you want to indent all paragraphs instead, you can pass a dictionary containing the `amount` of indent as a length and the pair `all: true`. When `all` is omitted from the dictionary, it defaults to `false`.
By typographic convention, paragraph breaks are indicated either by some space between paragraphs or by indented first lines. Consider
  * reducing the paragraph `spacing` to the `leading` using `set par(spacing: 0.65em)`
  * increasing the block `spacing` (which inherits the paragraph spacing by default) to the original paragraph spacing using `set block(spacing: 1.2em)`


    
    #set block(spacing: 1.2em)
    #set par(
      first-line-indent: 1.5em,
      spacing: 0.65em,
    )
    
    The first paragraph is not affected
    by the indent.
    
    But the second paragraph is.
    
    #line(length: 100%)
    
    #set par(first-line-indent: (
      amount: 1.5em,
      all: true,
    ))
    
    Now all paragraphs are affected
    by the first line indent.
    
    Even the first one.
    
hanging-indent
The indent that all but the first line of a paragraph should have.
    
    #set par(hanging-indent: 1em)
    
    #lorem(15)
    
body
The contents of the paragraph.
# line
A paragraph line.
This element is exclusively used for line number configuration through set rules and cannot be placed.
The `numbering` option is used to enable line numbers by specifying a numbering format.
numbering
How to number each line. Accepts a numbering pattern or function.
    
    #set par.line(numbering: "I")
    
    Roses are red. \
    Violets are blue. \
    Typst is there for you.
    
number-align
The alignment of line numbers associated with each line.
The default of `auto` indicates a smart default where numbers grow horizontally away from the text, considering the margin they're in and the current text direction.
    
    #set par.line(
      numbering: "I",
      number-align: left,
    )
    
    Hello world! \
    Today is a beautiful day \
    For exploring the world.
    
number-margin
The margin at which line numbers appear.
Note: In a multi-column document, the line numbers for paragraphs inside the last column will always appear on the `end` margin (right margin for left-to-right text and left margin for right-to-left), regardless of this configuration. That behavior cannot be changed at this moment.
    
    #set par.line(
      numbering: "1",
      number-margin: right,
    )
    
    = Report
    - Brightness: Dark, yet darker
    - Readings: Negative
    
number-clearance
The distance between line numbers and text.
The default value of `auto` results in a clearance that is adaptive to the page width and yields reasonable results in most cases.
    
    #set par.line(
      numbering: "1",
      number-clearance: 4pt,
    )
    
    Typesetting \
    Styling \
    Layout
    
numbering-scope
Controls when to reset line numbering.
Note: The line numbering scope must be uniform across each page run (a page run is a sequence of pages without an explicit pagebreak in between). For this reason, set rules for it should be defined before any page content, typically at the very start of the document.
    
    #set par.line(
      numbering: "1",
      numbering-scope: "page",
    )
    
    First line \
    Second line
    #pagebreak()
    First line again \
    Second line again
    
# parbreak
A paragraph break.
This starts a new paragraph. Especially useful when used within code like for loops. Multiple consecutive paragraph breaks collapse into a single one.
## Example
    
    #for i in range(3) {
      [Blind text #i: ]
      lorem(5)
      parbreak()
    }
    
## Syntax
Instead of calling this function, you can insert a blank line into your markup to create a paragraph break.
# quote
Displays a quote alongside an optional attribution.
## Example
    
    Plato is often misquoted as the author of #quote[I know that I know
    nothing], however, this is a derivation form his original quote:
    
    #set quote(block: true)
    
    #quote(attribution: [Plato])[
      ... ἔοικα γοῦν τούτου γε σμικρῷ τινι αὐτῷ τούτῳ σοφώτερος εἶναι, ὅτι
      ἃ μὴ οἶδα οὐδὲ οἴομαι εἰδέναι.
    ]
    #quote(attribution: [from the Henry Cary literal translation of 1897])[
      ... I seem, then, in just this little thing to be wiser than this man at
      any rate, that what I do not know I do not think I know either.
    ]
    
By default block quotes are padded left and right by `1em`, alignment and padding can be controlled with show rules:
    
    #set quote(block: true)
    #show quote: set align(center)
    #show quote: set pad(x: 5em)
    
    #quote[
      You cannot pass... I am a servant of the Secret Fire, wielder of the
      flame of Anor. You cannot pass. The dark fire will not avail you,
      flame of Udûn. Go back to the Shadow! You cannot pass.
    ]
    
block
Whether this is a block quote.
    
    An inline citation would look like
    this: #quote(
      attribution: [René Descartes]
    )[
      cogito, ergo sum
    ], and a block equation like this:
    #quote(
      block: true,
      attribution: [JFK]
    )[
      Ich bin ein Berliner.
    ]
    
quotes
Whether double quotes should be added around this quote.
The double quotes used are inferred from the `quotes` property on smartquote, which is affected by the `lang` property on text.
  * `true`: Wrap this quote in double quotes.
  * `false`: Do not wrap this quote in double quotes.
  * `auto`: Infer whether to wrap this quote in double quotes based on the `block` property. If `block` is `false`, double quotes are automatically added.


    
    #set text(lang: "de")
    
    Ein deutsch-sprechender Author
    zitiert unter umständen JFK:
    #quote[Ich bin ein Berliner.]
    
    #set text(lang: "en")
    
    And an english speaking one may
    translate the quote:
    #quote[I am a Berliner.]
    
attribution
The attribution of this quote, usually the author or source. Can be a label pointing to a bibliography entry or any content. By default only displayed for block quotes, but can be changed using a `show` rule.
    
    #quote(attribution: [René Descartes])[
      cogito, ergo sum
    ]
    
    #show quote.where(block: false): it => {
      ["] + h(0pt, weak: true) + it.body + h(0pt, weak: true) + ["]
      if it.attribution != none [ (#it.attribution)]
    }
    
    #quote(
      attribution: link("https://typst.app/home")[typst.com]
    )[
      Compose papers faster
    ]
    
    #set quote(block: true)
    
    #quote(attribution: <tolkien54>)[
      You cannot pass... I am a servant
      of the Secret Fire, wielder of the
      flame of Anor. You cannot pass. The
      dark fire will not avail you, flame
      of Udûn. Go back to the Shadow! You
      cannot pass.
    ]
    
    #bibliography("works.bib", style: "apa")
    
body
The quote.
# ref
A reference to a label or bibliography.
Takes a label and cross-references it. There are two kind of references, determined by its `form`: `"normal"` and `"page"`.
The default, a `"normal"` reference, produces a textual reference to a label. For example, a reference to a heading will yield an appropriate string such as "Section 1" for a reference to the first heading. The references are also links to the respective element. Reference syntax can also be used to cite from a bibliography.
As the default form requires a supplement and numbering, the label must be attached to a referenceable element. Referenceable elements include headings, figures, equations, and footnotes. To create a custom referenceable element like a theorem, you can create a figure of a custom `kind` and write a show rule for it. In the future, there might be a more direct way to define a custom referenceable element.
If you just want to link to a labelled element and not get an automatic textual reference, consider using the `link` function instead.
A `"page"` reference produces a page reference to a label, displaying the page number at its location. You can use the page's supplement to modify the text before the page number. Unlike a `"normal"` reference, the label can be attached to any element.
## Example
    
    #set page(numbering: "1")
    #set heading(numbering: "1.")
    #set math.equation(numbering: "(1)")
    
    = Introduction <intro>
    Recent developments in
    typesetting software have
    rekindled hope in previously
    frustrated researchers. @distress
    As shown in @results (see
    #ref(<results>, form: "page")),
    we ...
    
    = Results <results>
    We discuss our approach in
    comparison with others.
    
    == Performance <perf>
    @slow demonstrates what slow
    software looks like.
    $ T(n) = O(2^n) $ <slow>
    
    #bibliography("works.bib")
    
## Syntax
This function also has dedicated syntax: A `"normal"` reference to a label can be created by typing an `@` followed by the name of the label (e.g. `= Introduction <intro>` can be referenced by typing `@intro`).
To customize the supplement, add content in square brackets after the reference: `@intro[Chapter]`.
## Customization
If you write a show rule for references, you can access the referenced element through the `element` field of the reference. The `element` may be `none` even if it exists if Typst hasn't discovered it yet, so you always need to handle that case in your code.
    
    #set heading(numbering: "1.")
    #set math.equation(numbering: "(1)")
    
    #show ref: it => {
      let eq = math.equation
      let el = it.element
      if el != none and el.func() == eq {
        // Override equation references.
        link(el.location(),numbering(
          el.numbering,
          ..counter(eq).at(el.location())
        ))
      } else {
        // Other references as usual.
        it
      }
    }
    
    = Beginnings <beginning>
    In @beginning we prove @pythagoras.
    $ a^2 + b^2 = c^2 $ <pythagoras>
    
target
The target label that should be referenced.
Can be a label that is defined in the document or, if the `form` is set to `"normal"`, an entry from the `bibliography`.
supplement
A supplement for the reference.
If the `form` is set to `"normal"`:
  * For references to headings or figures, this is added before the referenced number.
  * For citations, this can be used to add a page number.


If the `form` is set to `"page"`, then this is added before the page number of the label referenced.
If a function is specified, it is passed the referenced element and should return content.
    
    #set heading(numbering: "1.")
    #show ref.where(
      form: "normal"
    ): set ref(supplement: it => {
      if it.func() == heading {
        "Chapter"
      } else {
        "Thing"
      }
    })
    
    = Introduction <intro>
    In @intro, we see how to turn
    Sections into Chapters. And
    in @intro[Part], it is done
    manually.
    
form
The kind of reference to produce.
    
    #set page(numbering: "1")
    
    Here <here> we are on
    #ref(<here>, form: "page").
    
# strong
Strongly emphasizes content by increasing the font weight.
Increases the current font weight by a given `delta`.
## Example
    
    This is *strong.* \
    This is #strong[too.] \
    
    #show strong: set text(red)
    And this is *evermore.*
    
## Syntax
This function also has dedicated syntax: To strongly emphasize content, simply enclose it in stars/asterisks (`*`). Note that this only works at word boundaries. To strongly emphasize part of a word, you have to use the function.
delta
The delta to apply on the font weight.
    
    #set strong(delta: 0)
    No *effect!*
    
body
The content to strongly emphasize.
# table
A table of items.
Tables are used to arrange content in cells. Cells can contain arbitrary content, including multiple paragraphs and are specified in row-major order. For a hands-on explanation of all the ways you can use and customize tables in Typst, check out the table guide.
Because tables are just grids with different defaults for some cell properties (notably `stroke` and `inset`), refer to the grid documentation for more information on how to size the table tracks and specify the cell appearance properties.
If you are unsure whether you should be using a table or a grid, consider whether the content you are arranging semantically belongs together as a set of related data points or similar or whether you are just want to enhance your presentation by arranging unrelated content in a grid. In the former case, a table is the right choice, while in the latter case, a grid is more appropriate. Furthermore, Typst will annotate its output in the future such that screenreaders will announce content in `table` as tabular while a grid's content will be announced no different than multiple content blocks in the document flow.
Note that, to override a particular cell's properties or apply show rules on table cells, you can use the `table.cell` element. See its documentation for more information.
Although the `table` and the `grid` share most properties, set and show rules on one of them do not affect the other.
To give a table a caption and make it referenceable, put it into a figure.
## Example
The example below demonstrates some of the most common table options.
    
    #table(
      columns: (1fr, auto, auto),
      inset: 10pt,
      align: horizon,
      table.header(
        [], [*Volume*], [*Parameters*],
      ),
      image("cylinder.svg"),
      $ pi h (D^2 - d^2) / 4 $,
      [
        $h$: height \
        $D$: outer radius \
        $d$: inner radius
      ],
      image("tetrahedron.svg"),
      $ sqrt(2) / 12 a^3 $,
      [$a$: edge length]
    )
    
Much like with grids, you can use `table.cell` to customize the appearance and the position of each cell.
    
    #set table(
      stroke: none,
      gutter: 0.2em,
      fill: (x, y) =>
        if x == 0 or y == 0 { gray },
      inset: (right: 1.5em),
    )
    
    #show table.cell: it => {
      if it.x == 0 or it.y == 0 {
        set text(white)
        strong(it)
      } else if it.body == [] {
        // Replace empty cells with 'N/A'
        pad(..it.inset)[_N/A_]
      } else {
        it
      }
    }
    
    #let a = table.cell(
      fill: green.lighten(60%),
    )[A]
    #let b = table.cell(
      fill: aqua.lighten(60%),
    )[B]
    
    #table(
      columns: 4,
      [], [Exam 1], [Exam 2], [Exam 3],
    
      [John], [], a, [],
      [Mary], [], a, a,
      [Robert], b, a, b,
    )
    
columns
The column sizes. See the grid documentation for more information on track sizing.
rows
The row sizes. See the grid documentation for more information on track sizing.
gutter
The gaps between rows and columns. This is a shorthand for setting `column-gutter` and `row-gutter` to the same value. See the grid documentation for more information on gutters.
column-gutter
The gaps between columns. Takes precedence over `gutter`. See the grid documentation for more information on gutters.
row-gutter
The gaps between rows. Takes precedence over `gutter`. See the grid documentation for more information on gutters.
fill
How to fill the cells.
This can be a color or a function that returns a color. The function receives the cells' column and row indices, starting from zero. This can be used to implement striped tables.
    
    #table(
      fill: (x, _) =>
        if calc.odd(x) { luma(240) }
        else { white },
      align: (x, y) =>
        if y == 0 { center }
        else if x == 0 { left }
        else { right },
      columns: 4,
      [], [*Q1*], [*Q2*], [*Q3*],
      [Revenue:], [1000 €], [2000 €], [3000 €],
      [Expenses:], [500 €], [1000 €], [1500 €],
      [Profit:], [500 €], [1000 €], [1500 €],
    )
    
align
How to align the cells' content.
This can either be a single alignment, an array of alignments (corresponding to each column) or a function that returns an alignment. The function receives the cells' column and row indices, starting from zero. If set to `auto`, the outer alignment is used.
    
    #table(
      columns: 3,
      align: (left, center, right),
      [Hello], [Hello], [Hello],
      [A], [B], [C],
    )
    
stroke
How to stroke the cells.
Strokes can be disabled by setting this to `none`.
If it is necessary to place lines which can cross spacing between cells produced by the `gutter` option, or to override the stroke between multiple specific cells, consider specifying one or more of `table.hline` and `table.vline` alongside your table cells.
See the grid documentation for more information on strokes.
inset
How much to pad the cells' content.
    
    #table(
      inset: 10pt,
      [Hello],
      [World],
    )
    
    #table(
      columns: 2,
      inset: (
        x: 20pt,
        y: 10pt,
      ),
      [Hello],
      [World],
    )
    
children
The contents of the table cells, plus any extra table lines specified with the `table.hline` and `table.vline` elements.
# cell
A cell in the table. Use this to position a cell manually or to apply styling. To do the latter, you can either use the function to override the properties for a particular cell, or use it in show rules to apply certain styles to multiple cells at once.
Perhaps the most important use case of `table.cell` is to make a cell span multiple columns and/or rows with the `colspan` and `rowspan` fields.
body
The cell's body.
x
The cell's column (zero-indexed). Functions identically to the `x` field in `grid.cell`.
y
The cell's row (zero-indexed). Functions identically to the `y` field in `grid.cell`.
colspan
The amount of columns spanned by this cell.
rowspan
The amount of rows spanned by this cell.
fill
The cell's fill override.
align
The cell's alignment override.
inset
The cell's inset override.
stroke
The cell's stroke override.
breakable
Whether rows spanned by this cell can be placed in different pages. When equal to `auto`, a cell spanning only fixed-size rows is unbreakable, while a cell spanning at least one `auto`-sized row is breakable.
# hline
A horizontal line in the table.
Overrides any per-cell stroke, including stroke specified through the table's `stroke` field. Can cross spacing between cells created through the table's `column-gutter` option.
Use this function instead of the table's `stroke` field if you want to manually place a horizontal line at a specific position in a single table. Consider using table's `stroke` field or `table.cell`'s `stroke` field instead if the line you want to place is part of all your tables' designs.
y
The row above which the horizontal line is placed (zero-indexed). Functions identically to the `y` field in `grid.hline`.
start
The column at which the horizontal line starts (zero-indexed, inclusive).
end
The column before which the horizontal line ends (zero-indexed, exclusive).
stroke
The line's stroke.
Specifying `none` removes any lines previously placed across this line's range, including hlines or per-cell stroke below it.
position
The position at which the line is placed, given its row (`y`) - either `top` to draw above it or `bottom` to draw below it.
This setting is only relevant when row gutter is enabled (and shouldn't be used otherwise - prefer just increasing the `y` field by one instead), since then the position below a row becomes different from the position above the next row due to the spacing between both.
# vline
A vertical line in the table. See the docs for `grid.vline` for more information regarding how to use this element's fields.
Overrides any per-cell stroke, including stroke specified through the table's `stroke` field. Can cross spacing between cells created through the table's `row-gutter` option.
Similar to `table.hline`, use this function if you want to manually place a vertical line at a specific position in a single table and use the table's `stroke` field or `table.cell`'s `stroke` field instead if the line you want to place is part of all your tables' designs.
x
The column before which the horizontal line is placed (zero-indexed). Functions identically to the `x` field in `grid.vline`.
start
The row at which the vertical line starts (zero-indexed, inclusive).
end
The row on top of which the vertical line ends (zero-indexed, exclusive).
stroke
The line's stroke.
Specifying `none` removes any lines previously placed across this line's range, including vlines or per-cell stroke below it.
position
The position at which the line is placed, given its column (`x`) - either `start` to draw before it or `end` to draw after it.
The values `left` and `right` are also accepted, but discouraged as they cause your table to be inconsistent between left-to-right and right-to-left documents.
This setting is only relevant when column gutter is enabled (and shouldn't be used otherwise - prefer just increasing the `x` field by one instead), since then the position after a column becomes different from the position before the next column due to the spacing between both.
# header
A repeatable table header.
You should wrap your tables' heading rows in this function even if you do not plan to wrap your table across pages because Typst will use this function to attach accessibility metadata to tables in the future and ensure universal access to your document.
You can use the `repeat` parameter to control whether your table's header will be repeated across pages.
repeat
Whether this header should be repeated across pages.
children
The cells and lines within the header.
# footer
A repeatable table footer.
Just like the `table.header` element, the footer can repeat itself on every page of the table. This is useful for improving legibility by adding the column labels in both the header and footer of a large table, totals, or other information that should be visible on every page.
No other table cells may be placed after the footer.
repeat
Whether this footer should be repeated across pages.
children
The cells and lines within the footer.
# terms
A list of terms and their descriptions.
Displays a sequence of terms and their descriptions vertically. When the descriptions span over multiple lines, they use hanging indent to communicate the visual hierarchy.
## Example
    
    / Ligature: A merged glyph.
    / Kerning: A spacing adjustment
      between two adjacent letters.
    
## Syntax
This function also has dedicated syntax: Starting a line with a slash, followed by a term, a colon and a description creates a term list item.
tight
Defines the default spacing of the term list. If it is `false`, the items are spaced apart with paragraph spacing. If it is `true`, they use paragraph leading instead. This makes the list more compact, which can look better if the items are short.
In markup mode, the value of this parameter is determined based on whether items are separated with a blank line. If items directly follow each other, this is set to `true`; if items are separated by a blank line, this is set to `false`. The markup-defined tightness cannot be overridden with set rules.
    
    / Fact: If a term list has a lot
      of text, and maybe other inline
      content, it should not be tight
      anymore.
    
    / Tip: To make it wide, simply
      insert a blank line between the
      items.
    
separator
The separator between the item and the description.
If you want to just separate them with a certain amount of space, use `h(2cm, weak: true)` as the separator and replace `2cm` with your desired amount of space.
    
    #set terms(separator: [: ])
    
    / Colon: A nice separator symbol.
    
indent
The indentation of each item.
hanging-indent
The hanging indent of the description.
This is in addition to the whole item's `indent`.
    
    #set terms(hanging-indent: 0pt)
    / Term: This term list does not
      make use of hanging indents.
    
spacing
The spacing between the items of the term list.
If set to `auto`, uses paragraph `leading` for tight term lists and paragraph `spacing` for wide (non-tight) term lists.
children
The term list's children.
When using the term list syntax, adjacent items are automatically collected into term lists, even through constructs like for loops.
    
    #for (year, product) in (
      "1978": "TeX",
      "1984": "LaTeX",
      "2019": "Typst",
    ) [/ #product: Born in #year.]
    
# item
A term list item.
term
The term described by the list item.
description
The description of the term.
# text
Text styling.
The text function is of particular interest.
# highlight
Highlights text with a background color.
## Example
    
    This is #highlight[important].
    
fill
The color to highlight the text with.
    
    This is #highlight(
      fill: blue
    )[highlighted with blue].
    
stroke
The highlight's border color. See the rectangle's documentation for more details.
    
    This is a #highlight(
      stroke: fuchsia
    )[stroked highlighting].
    
top-edge
The top end of the background rectangle.
    
    #set highlight(top-edge: "ascender")
    #highlight[a] #highlight[aib]
    
    #set highlight(top-edge: "x-height")
    #highlight[a] #highlight[aib]
    
bottom-edge
The bottom end of the background rectangle.
    
    #set highlight(bottom-edge: "descender")
    #highlight[a] #highlight[ap]
    
    #set highlight(bottom-edge: "baseline")
    #highlight[a] #highlight[ap]
    
extent
The amount by which to extend the background to the sides beyond (or within if negative) the content.
    
    A long #highlight(extent: 4pt)[background].
    
radius
How much to round the highlight's corners. See the rectangle's documentation for more details.
    
    Listen #highlight(
      radius: 5pt, extent: 2pt
    )[carefully], it will be on the test.
    
body
The content that should be highlighted.
# linebreak
Inserts a line break.
Advances the paragraph to the next line. A single trailing line break at the end of a paragraph is ignored, but more than one creates additional empty lines.
## Example
    
    *Date:* 26.12.2022 \
    *Topic:* Infrastructure Test \
    *Severity:* High \
    
## Syntax
This function also has dedicated syntax: To insert a line break, simply write a backslash followed by whitespace. This always creates an unjustified break.
justify
Whether to justify the line before the break.
This is useful if you found a better line break opportunity in your justified text than Typst did.
    
    #set par(justify: true)
    #let jb = linebreak(justify: true)
    
    I have manually tuned the #jb
    line breaks in this paragraph #jb
    for an _interesting_ result. #jb
    
# lorem
Creates blind text.
This function yields a Latin-like Lorem Ipsum blind text with the given number of words. The sequence of words generated by the function is always the same but randomly chosen. As usual for blind texts, it does not make any sense. Use it as a placeholder to try layouts.
## Example
    
    = Blind Text
    #lorem(30)
    
    = More Blind Text
    #lorem(15)
    
words
The length of the blind text in words.
# lower
Converts a string or content to lowercase.
## Example
    
    #lower("ABC") \
    #lower[*My Text*] \
    #lower[already low]
    
text
The text to convert to lowercase.
# overline
Adds a line over text.
## Example
    
    #overline[A line over text.]
    
stroke
How to stroke the line.
If set to `auto`, takes on the text's color and a thickness defined in the current font.
    
    #set text(fill: olive)
    #overline(
      stroke: green.darken(20%),
      offset: -12pt,
      [The Forest Theme],
    )
    
offset
The position of the line relative to the baseline. Read from the font tables if `auto`.
    
    #overline(offset: -1.2em)[
      The Tale Of A Faraway Line II
    ]
    
extent
The amount by which to extend the line beyond (or within if negative) the content.
    
    #set overline(extent: 4pt)
    #set underline(extent: 4pt)
    #overline(underline[Typography Today])
    
evade
Whether the line skips sections in which it would collide with the glyphs.
    
    #overline(
      evade: false,
      offset: -7.5pt,
      stroke: 1pt,
      extent: 3pt,
      [Temple],
    )
    
background
Whether the line is placed behind the content it overlines.
    
    #set overline(stroke: (thickness: 1em, paint: maroon, cap: "round"))
    #overline(background: true)[This is stylized.] \
    #overline(background: false)[This is partially hidden.]
    
body
The content to add a line over.
# raw
Raw text with optional syntax highlighting.
Displays the text verbatim and in a monospace font. This is typically used to embed computer code into your document.
## Example
    
    Adding `rbx` to `rcx` gives
    the desired result.
    
    What is ```rust fn main()``` in Rust
    would be ```c int main()``` in C.
    
    ```rust
    fn main() {
        println!("Hello World!");
    }
    ```
    
    This has ``` `backticks` ``` in it
    (but the spaces are trimmed). And
    ``` here``` the leading space is
    also trimmed.
    
You can also construct a `raw` element programmatically from a string (and provide the language tag via the optional `lang` argument).
    
    #raw("fn " + "main() {}", lang: "rust")
    
## Syntax
This function also has dedicated syntax. You can enclose text in 1 or 3+ backticks (```) to make it raw. Two backticks produce empty raw text. This works both in markup and code.
When you use three or more backticks, you can additionally specify a language tag for syntax highlighting directly after the opening backticks. Within raw blocks, everything (except for the language tag, if applicable) is rendered as is, in particular, there are no escape sequences.
The language tag is an identifier that directly follows the opening backticks only if there are three or more backticks. If your text starts with something that looks like an identifier, but no syntax highlighting is needed, start the text with a single space (which will be trimmed) or use the single backtick syntax. If your text should start or end with a backtick, put a space before or after it (it will be trimmed).
text
The raw text.
You can also use raw blocks creatively to create custom syntaxes for your automations.
    
    // Parse numbers in raw blocks with the
    // `mydsl` tag and sum them up.
    #show raw.where(lang: "mydsl"): it => {
      let sum = 0
      for part in it.text.split("+") {
        sum += int(part.trim())
      }
      sum
    }
    
    ```mydsl
    1 + 2 + 3 + 4 + 5
    ```
    
block
Whether the raw text is displayed as a separate block.
In markup mode, using one-backtick notation makes this `false`. Using three-backtick notation makes it `true` if the enclosed content contains at least one line break.
    
    // Display inline code in a small box
    // that retains the correct baseline.
    #show raw.where(block: false): box.with(
      fill: luma(240),
      inset: (x: 3pt, y: 0pt),
      outset: (y: 3pt),
      radius: 2pt,
    )
    
    // Display block code in a larger block
    // with more padding.
    #show raw.where(block: true): block.with(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )
    
    With `rg`, you can search through your files quickly.
    This example searches the current directory recursively
    for the text `Hello World`:
    
    ```bash
    rg "Hello World"
    ```
    
lang
The language to syntax-highlight in.
Apart from typical language tags known from Markdown, this supports the `"typ"`, `"typc"`, and `"typm"` tags for Typst markup, Typst code, and Typst math, respectively.
    
    ```typ
    This is *Typst!*
    ```
    
    This is ```typ also *Typst*```, but inline!
    
align
The horizontal alignment that each line in a raw block should have. This option is ignored if this is not a raw block (if specified `block: false` or single backticks were used in markup mode).
By default, this is set to `start`, meaning that raw text is aligned towards the start of the text direction inside the block by default, regardless of the current context's alignment (allowing you to center the raw block itself without centering the text inside it, for example).
    
    #set raw(align: center)
    
    ```typc
    let f(x) = x
    code = "centered"
    ```
    
syntaxes
Additional syntax definitions to load. The syntax definitions should be in the `sublime-syntax` file format.
You can pass any of the following values:
  * A path string to load a syntax file from the given path. For more details about paths, see the Paths section.
  * Raw bytes from which the syntax should be decoded.
  * An array where each item is one the above.


    
    #set raw(syntaxes: "SExpressions.sublime-syntax")
    
    ```sexp
    (defun factorial (x)
      (if (zerop x)
        ; with a comment
        1
        (* x (factorial (- x 1)))))
    ```
    
theme
The theme to use for syntax highlighting. Themes should be in the `tmTheme` file format.
You can pass any of the following values:
  * `none`: Disables syntax highlighting.
  * `auto`: Highlights with Typst's default theme.
  * A path string to load a theme file from the given path. For more details about paths, see the Paths section.
  * Raw bytes from which the theme should be decoded.


Applying a theme only affects the color of specifically highlighted text. It does not consider the theme's foreground and background properties, so that you retain control over the color of raw text. You can apply the foreground color yourself with the `text` function and the background with a filled block. You could also use the `xml` function to extract these properties from the theme.
    
    #set raw(theme: "halcyon.tmTheme")
    #show raw: it => block(
      fill: rgb("#1d2433"),
      inset: 8pt,
      radius: 5pt,
      text(fill: rgb("#a2aabc"), it)
    )
    
    ```typ
    = Chapter 1
    #let hi = "Hello World"
    ```
    
tab-size
The size for a tab stop in spaces. A tab is replaced with enough spaces to align with the next multiple of the size.
    
    #set raw(tab-size: 8)
    ```tsv
    Year	Month	Day
    2000	2	3
    2001	2	1
    2002	3	10
    ```
    
# line
A highlighted line of raw text.
This is a helper element that is synthesized by `raw` elements.
It allows you to access various properties of the line, such as the line number, the raw non-highlighted text, the highlighted text, and whether it is the first or last line of the raw block.
number
The line number of the raw line inside of the raw block, starts at 1.
count
The total number of lines in the raw block.
text
The line of raw text.
body
The highlighted raw text.
# smallcaps
Displays text in small capitals.
## Example
    
    Hello \
    #smallcaps[Hello]
    
## Smallcaps fonts
By default, this uses the `smcp` and `c2sc` OpenType features on the font. Not all fonts support these features. Sometimes, smallcaps are part of a dedicated font. This is, for example, the case for the Latin Modern family of fonts. In those cases, you can use a show-set rule to customize the appearance of the text in smallcaps:
    
    #show smallcaps: set text(font: "Latin Modern Roman Caps")
    
In the future, this function will support synthesizing smallcaps from normal letters, but this is not yet implemented.
## Smallcaps headings
You can use a show rule to apply smallcaps formatting to all your headings. In the example below, we also center-align our headings and disable the standard bold font.
    
    #set par(justify: true)
    #set heading(numbering: "I.")
    
    #show heading: smallcaps
    #show heading: set align(center)
    #show heading: set text(
      weight: "regular"
    )
    
    = Introduction
    #lorem(40)
    
all
Whether to turn uppercase letters into small capitals as well.
Unless overridden by a show rule, this enables the `c2sc` OpenType feature.
    
    #smallcaps(all: true)[UNICEF] is an
    agency of #smallcaps(all: true)[UN].
    
body
The content to display in small capitals.
# smartquote
A language-aware quote that reacts to its context.
Automatically turns into an appropriate opening or closing quote based on the active text language.
## Example
    
    "This is in quotes."
    
    #set text(lang: "de")
    "Das ist in Anführungszeichen."
    
    #set text(lang: "fr")
    "C'est entre guillemets."
    
## Syntax
This function also has dedicated syntax: The normal quote characters (`'` and `"`). Typst automatically makes your quotes smart.
double
Whether this should be a double quote.
enabled
Whether smart quotes are enabled.
To disable smartness for a single quote, you can also escape it with a backslash.
    
    #set smartquote(enabled: false)
    
    These are "dumb" quotes.
    
alternative
Whether to use alternative quotes.
Does nothing for languages that don't have alternative quotes, or if explicit quotes were set.
    
    #set text(lang: "de")
    #set smartquote(alternative: true)
    
    "Das ist in anderen Anführungszeichen."
    
quotes
The quotes to use.
  * When set to `auto`, the appropriate single quotes for the text language will be used. This is the default.
  * Custom quotes can be passed as a string, array, or dictionary of either 
    * string: a string consisting of two characters containing the opening and closing double quotes (characters here refer to Unicode grapheme clusters)
    * array: an array containing the opening and closing double quotes
    * dictionary: an array containing the double and single quotes, each specified as either `auto`, string, or array


    
    #set text(lang: "de")
    'Das sind normale Anführungszeichen.'
    
    #set smartquote(quotes: "()")
    "Das sind eigene Anführungszeichen."
    
    #set smartquote(quotes: (single: ("[[", "]]"),  double: auto))
    'Das sind eigene Anführungszeichen.'
    
# strike
Strikes through text.
## Example
    
    This is #strike[not] relevant.
    
stroke
How to stroke the line.
If set to `auto`, takes on the text's color and a thickness defined in the current font.
Note: Please don't use this for real redaction as you can still copy paste the text.
    
    This is #strike(stroke: 1.5pt + red)[very stricken through]. \
    This is #strike(stroke: 10pt)[redacted].
    
offset
The position of the line relative to the baseline. Read from the font tables if `auto`.
This is useful if you are unhappy with the offset your font provides.
    
    #set text(font: "Inria Serif")
    This is #strike(offset: auto)[low-ish]. \
    This is #strike(offset: -3.5pt)[on-top].
    
extent
The amount by which to extend the line beyond (or within if negative) the content.
    
    This #strike(extent: -2pt)[skips] parts of the word.
    This #strike(extent: 2pt)[extends] beyond the word.
    
background
Whether the line is placed behind the content.
    
    #set strike(stroke: red)
    #strike(background: true)[This is behind.] \
    #strike(background: false)[This is in front.]
    
body
The content to strike through.
# sub
Renders text in subscript.
The text is rendered smaller and its baseline is lowered.
## Example
    
    Revenue#sub[yearly]
    
typographic
Whether to prefer the dedicated subscript characters of the font.
If this is enabled, Typst first tries to transform the text to subscript codepoints. If that fails, it falls back to rendering lowered and shrunk normal letters.
    
    N#sub(typographic: true)[1]
    N#sub(typographic: false)[1]
    
baseline
The baseline shift for synthetic subscripts. Does not apply if `typographic` is true and the font has subscript codepoints for the given `body`.
size
The font size for synthetic subscripts. Does not apply if `typographic` is true and the font has subscript codepoints for the given `body`.
body
The text to display in subscript.
# super
Renders text in superscript.
The text is rendered smaller and its baseline is raised.
## Example
    
    1#super[st] try!
    
typographic
Whether to prefer the dedicated superscript characters of the font.
If this is enabled, Typst first tries to transform the text to superscript codepoints. If that fails, it falls back to rendering raised and shrunk normal letters.
    
    N#super(typographic: true)[1]
    N#super(typographic: false)[1]
    
baseline
The baseline shift for synthetic superscripts. Does not apply if `typographic` is true and the font has superscript codepoints for the given `body`.
size
The font size for synthetic superscripts. Does not apply if `typographic` is true and the font has superscript codepoints for the given `body`.
body
The text to display in superscript.
# text
Customizes the look and layout of text in a variety of ways.
This function is used frequently, both with set rules and directly. While the set rule is often the simpler choice, calling the `text` function directly can be useful when passing text as an argument to another function.
## Example
    
    #set text(18pt)
    With a set rule.
    
    #emph(text(blue)[
      With a function call.
    ])
    
font
A font family descriptor or priority list of font family descriptor.
A font family descriptor can be a plain string representing the family name or a dictionary with the following keys:
  * `name` (required): The font family name.
  * `covers` (optional): Defines the Unicode codepoints for which the family shall be used. This can be: 
    * A predefined coverage set: 
      * `"latin-in-cjk"` covers all codepoints except for those which exist in Latin fonts, but should preferrably be taken from CJK fonts.
    * A regular expression that defines exactly which codepoints shall be covered. Accepts only the subset of regular expressions which consist of exactly one dot, letter, or character class.


When processing text, Typst tries all specified font families in order until it finds a font that has the necessary glyphs. In the example below, the font `Inria Serif` is preferred, but since it does not contain Arabic glyphs, the arabic text uses `Noto Sans Arabic` instead.
The collection of available fonts differs by platform:
  * In the web app, you can see the list of available fonts by clicking on the "Ag" button. You can provide additional fonts by uploading `.ttf` or `.otf` files into your project. They will be discovered automatically. The priority is: project fonts > server fonts.
  * Locally, Typst uses your installed system fonts or embedded fonts in the CLI, which are `Libertinus Serif`, `New Computer Modern`, `New Computer Modern Math`, and `DejaVu Sans Mono`. In addition, you can use the `--font-path` argument or `TYPST_FONT_PATHS` environment variable to add directories that should be scanned for fonts. The priority is: `--font-paths` > system fonts > embedded fonts. Run `typst fonts` to see the fonts that Typst has discovered on your system. Note that you can pass the `--ignore-system-fonts` parameter to the CLI to ensure Typst won't search for system fonts.


    
    #set text(font: "PT Sans")
    This is sans-serif.
    
    #set text(font: (
      "Inria Serif",
      "Noto Sans Arabic",
    ))
    
    This is Latin. \
    هذا عربي.
    
    // Change font only for numbers.
    #set text(font: (
      (name: "PT Sans", covers: regex("[0-9]")),
      "Libertinus Serif"
    ))
    
    The number 123.
    
    // Mix Latin and CJK fonts.
    #set text(font: (
      (name: "Inria Serif", covers: "latin-in-cjk"),
      "Noto Serif CJK SC"
    ))
    分别设置“中文”和English字体
    
fallback
Whether to allow last resort font fallback when the primary font list contains no match. This lets Typst search through all available fonts for the most similar one that has the necessary glyphs.
Note: Currently, there are no warnings when fallback is disabled and no glyphs are found. Instead, your text shows up in the form of "tofus": Small boxes that indicate the lack of an appropriate glyph. In the future, you will be able to instruct Typst to issue warnings so you know something is up.
    
    #set text(font: "Inria Serif")
    هذا عربي
    
    #set text(fallback: false)
    هذا عربي
    
style
The desired font style.
When an italic style is requested and only an oblique one is available, it is used. Similarly, the other way around, an italic style can stand in for an oblique one. When neither an italic nor an oblique style is available, Typst selects the normal style. Since most fonts are only available either in an italic or oblique style, the difference between italic and oblique style is rarely observable.
If you want to emphasize your text, you should do so using the emph function instead. This makes it easy to adapt the style later if you change your mind about how to signify the emphasis.
    
    #text(font: "Libertinus Serif", style: "italic")[Italic]
    #text(font: "DejaVu Sans", style: "oblique")[Oblique]
    
weight
The desired thickness of the font's glyphs. Accepts an integer between `100` and `900` or one of the predefined weight names. When the desired weight is not available, Typst selects the font from the family that is closest in weight.
If you want to strongly emphasize your text, you should do so using the strong function instead. This makes it easy to adapt the style later if you change your mind about how to signify the strong emphasis.
    
    #set text(font: "IBM Plex Sans")
    
    #text(weight: "light")[Light] \
    #text(weight: "regular")[Regular] \
    #text(weight: "medium")[Medium] \
    #text(weight: 500)[Medium] \
    #text(weight: "bold")[Bold]
    
stretch
The desired width of the glyphs. Accepts a ratio between `50%` and `200%`. When the desired width is not available, Typst selects the font from the family that is closest in stretch. This will only stretch the text if a condensed or expanded version of the font is available.
If you want to adjust the amount of space between characters instead of stretching the glyphs itself, use the `tracking` property instead.
    
    #text(stretch: 75%)[Condensed] \
    #text(stretch: 100%)[Normal]
    
size
The size of the glyphs. This value forms the basis of the `em` unit: `1em` is equivalent to the font size.
You can also give the font size itself in `em` units. Then, it is relative to the previous font size.
    
    #set text(size: 20pt)
    very #text(1.5em)[big] text
    
fill
The glyph fill paint.
    
    #set text(fill: red)
    This text is red.
    
stroke
How to stroke the text.
    
    #text(stroke: 0.5pt + red)[Stroked]
    
tracking
The amount of space that should be added between characters.
    
    #set text(tracking: 1.5pt)
    Distant text.
    
spacing
The amount of space between words.
Can be given as an absolute length, but also relative to the width of the space character in the font.
If you want to adjust the amount of space between characters rather than words, use the `tracking` property instead.
    
    #set text(spacing: 200%)
    Text with distant words.
    
cjk-latin-spacing
Whether to automatically insert spacing between CJK and Latin characters.
    
    #set text(cjk-latin-spacing: auto)
    第4章介绍了基本的API。
    
    #set text(cjk-latin-spacing: none)
    第4章介绍了基本的API。
    
baseline
An amount to shift the text baseline by.
    
    A #text(baseline: 3pt)[lowered]
    word.
    
overhang
Whether certain glyphs can hang over into the margin in justified text. This can make justification visually more pleasing.
    
    #set par(justify: true)
    This justified text has a hyphen in
    the paragraph's first line. Hanging
    the hyphen slightly into the margin
    results in a clearer paragraph edge.
    
    #set text(overhang: false)
    This justified text has a hyphen in
    the paragraph's first line. Hanging
    the hyphen slightly into the margin
    results in a clearer paragraph edge.
    
top-edge
The top end of the conceptual frame around the text used for layout and positioning. This affects the size of containers that hold text.
    
    #set rect(inset: 0pt)
    #set text(size: 20pt)
    
    #set text(top-edge: "ascender")
    #rect(fill: aqua)[Typst]
    
    #set text(top-edge: "cap-height")
    #rect(fill: aqua)[Typst]
    
bottom-edge
The bottom end of the conceptual frame around the text used for layout and positioning. This affects the size of containers that hold text.
    
    #set rect(inset: 0pt)
    #set text(size: 20pt)
    
    #set text(bottom-edge: "baseline")
    #rect(fill: aqua)[Typst]
    
    #set text(bottom-edge: "descender")
    #rect(fill: aqua)[Typst]
    
lang
An ISO 639-1/2/3 language code.
Setting the correct language affects various parts of Typst:
  * The text processing pipeline can make more informed choices.
  * Hyphenation will use the correct patterns for the language.
  * Smart quotes turns into the correct quotes for the language.
  * And all other things which are language-aware.


    
    #set text(lang: "de")
    #outline()
    
    = Einleitung
    In diesem Dokument, ...
    
region
An ISO 3166-1 alpha-2 region code.
This lets the text processing pipeline make more informed choices.
script
The OpenType writing script.
The combination of `lang` and `script` determine how font features, such as glyph substitution, are implemented. Frequently the value is a modified (all-lowercase) ISO 15924 script identifier, and the `math` writing script is used for features appropriate for mathematical symbols.
When set to `auto`, the default and recommended setting, an appropriate script is chosen for each block of characters sharing a common Unicode script property.
    
    #set text(
      font: "Libertinus Serif",
      size: 20pt,
    )
    
    #let scedilla = [Ş]
    #scedilla // S with a cedilla
    
    #set text(lang: "ro", script: "latn")
    #scedilla // S with a subscript comma
    
    #set text(lang: "ro", script: "grek")
    #scedilla // S with a cedilla
    
dir
The dominant direction for text and inline objects. Possible values are:
  * `auto`: Automatically infer the direction from the `lang` property.
  * `ltr`: Layout text from left to right.
  * `rtl`: Layout text from right to left.


When writing in right-to-left scripts like Arabic or Hebrew, you should set the text language or direction. While individual runs of text are automatically layouted in the correct direction, setting the dominant direction gives the bidirectional reordering algorithm the necessary information to correctly place punctuation and inline objects. Furthermore, setting the direction affects the alignment values `start` and `end`, which are equivalent to `left` and `right` in `ltr` text and the other way around in `rtl` text.
If you set this to `rtl` and experience bugs or in some way bad looking output, please get in touch with us through the Forum, Discord server, or our contact form.
    
    #set text(dir: rtl)
    هذا عربي.
    
hyphenate
Whether to hyphenate text to improve line breaking. When `auto`, text will be hyphenated if and only if justification is enabled.
Setting the text language ensures that the correct hyphenation patterns are used.
    
    #set page(width: 200pt)
    
    #set par(justify: true)
    This text illustrates how
    enabling hyphenation can
    improve justification.
    
    #set text(hyphenate: false)
    This text illustrates how
    enabling hyphenation can
    improve justification.
    
costs
The "cost" of various choices when laying out text. A higher cost means the layout engine will make the choice less often. Costs are specified as a ratio of the default cost, so `50%` will make text layout twice as eager to make a given choice, while `200%` will make it half as eager.
Currently, the following costs can be customized:
  * `hyphenation`: splitting a word across multiple lines
  * `runt`: ending a paragraph with a line with a single word
  * `widow`: leaving a single line of paragraph on the next page
  * `orphan`: leaving single line of paragraph on the previous page


Hyphenation is generally avoided by placing the whole word on the next line, so a higher hyphenation cost can result in awkward justification spacing. Note: Hyphenation costs will only be applied when the `linebreaks` are set to "optimized". (For example by default implied by `justify`.)
Runts are avoided by placing more or fewer words on previous lines, so a higher runt cost can result in more awkward in justification spacing.
Text layout prevents widows and orphans by default because they are generally discouraged by style guides. However, in some contexts they are allowed because the prevention method, which moves a line to the next page, can result in an uneven number of lines between pages. The `widow` and `orphan` costs allow disabling these modifications. (Currently, `0%` allows widows/orphans; anything else, including the default of `100%`, prevents them. More nuanced cost specification for these modifications is planned for the future.)
    
    #set text(hyphenate: true, size: 11.4pt)
    #set par(justify: true)
    
    #lorem(10)
    
    // Set hyphenation to ten times the normal cost.
    #set text(costs: (hyphenation: 1000%))
    
    #lorem(10)
    
kerning
Whether to apply kerning.
When enabled, specific letter pairings move closer together or further apart for a more visually pleasing result. The example below demonstrates how decreasing the gap between the "T" and "o" results in a more natural look. Setting this to `false` disables kerning by turning off the OpenType `kern` font feature.
    
    #set text(size: 25pt)
    Totally
    
    #set text(kerning: false)
    Totally
    
alternates
Whether to apply stylistic alternates.
Sometimes fonts contain alternative glyphs for the same codepoint. Setting this to `true` switches to these by enabling the OpenType `salt` font feature.
    
    #set text(
      font: "IBM Plex Sans",
      size: 20pt,
    )
    
    0, a, g, ß
    
    #set text(alternates: true)
    0, a, g, ß
    
stylistic-set
Which stylistic sets to apply. Font designers can categorize alternative glyphs forms into stylistic sets. As this value is highly font-specific, you need to consult your font to know which sets are available.
This can be set to an integer or an array of integers, all of which must be between `1` and `20`, enabling the corresponding OpenType feature(s) from `ss01` to `ss20`. Setting this to `none` will disable all stylistic sets.
    
    #set text(font: "IBM Plex Serif")
    ß vs #text(stylistic-set: 5)[ß] \
    10 years ago vs #text(stylistic-set: (1, 2, 3))[10 years ago]
    
ligatures
Whether standard ligatures are active.
Certain letter combinations like "fi" are often displayed as a single merged glyph called a ligature. Setting this to `false` disables these ligatures by turning off the OpenType `liga` and `clig` font features.
    
    #set text(size: 20pt)
    A fine ligature.
    
    #set text(ligatures: false)
    A fine ligature.
    
discretionary-ligatures
Whether ligatures that should be used sparingly are active. Setting this to `true` enables the OpenType `dlig` font feature.
historical-ligatures
Whether historical ligatures are active. Setting this to `true` enables the OpenType `hlig` font feature.
number-type
Which kind of numbers / figures to select. When set to `auto`, the default numbers for the font are used.
    
    #set text(font: "Noto Sans", 20pt)
    #set text(number-type: "lining")
    Number 9.
    
    #set text(number-type: "old-style")
    Number 9.
    
number-width
The width of numbers / figures. When set to `auto`, the default numbers for the font are used.
    
    #set text(font: "Noto Sans", 20pt)
    #set text(number-width: "proportional")
    A 12 B 34. \
    A 56 B 78.
    
    #set text(number-width: "tabular")
    A 12 B 34. \
    A 56 B 78.
    
slashed-zero
Whether to have a slash through the zero glyph. Setting this to `true` enables the OpenType `zero` font feature.
    
    0, #text(slashed-zero: true)[0]
    
fractions
Whether to turn numbers into fractions. Setting this to `true` enables the OpenType `frac` font feature.
It is not advisable to enable this property globally as it will mess with all appearances of numbers after a slash (e.g., in URLs). Instead, enable it locally when you want a fraction.
    
    1/2 \
    #text(fractions: true)[1/2]
    
features
Raw OpenType features to apply.
  * If given an array of strings, sets the features identified by the strings to `1`.
  * If given a dictionary mapping to numbers, sets the features identified by the keys to the values.


    
    // Enable the `frac` feature manually.
    #set text(features: ("frac",))
    1/2
    
body
Content in which all text is styled according to the other arguments.
text
The text.
# underline
Underlines text.
## Example
    
    This is #underline[important].
    
stroke
How to stroke the line.
If set to `auto`, takes on the text's color and a thickness defined in the current font.
    
    Take #underline(
      stroke: 1.5pt + red,
      offset: 2pt,
      [care],
    )
    
offset
The position of the line relative to the baseline, read from the font tables if `auto`.
    
    #underline(offset: 5pt)[
      The Tale Of A Faraway Line I
    ]
    
extent
The amount by which to extend the line beyond (or within if negative) the content.
    
    #align(center,
      underline(extent: 2pt)[Chapter 1]
    )
    
evade
Whether the line skips sections in which it would collide with the glyphs.
    
    This #underline(evade: true)[is great].
    This #underline(evade: false)[is less great].
    
background
Whether the line is placed behind the content it underlines.
    
    #set underline(stroke: (thickness: 1em, paint: maroon, cap: "round"))
    #underline(background: true)[This is stylized.] \
    #underline(background: false)[This is partially hidden.]
    
body
The content to underline.
# upper
Converts a string or content to uppercase.
## Example
    
    #upper("abc") \
    #upper[*my text*] \
    #upper[ALREADY HIGH]
    
text
The text to convert to uppercase.
# math
Typst has special syntax and library functions to typeset mathematical formulas. Math formulas can be displayed inline with text or as separate blocks. They will be typeset into their own block if they start and end with at least one space (e.g. `$ x^2 $`).
## Variables
In math, single letters are always displayed as is. Multiple letters, however, are interpreted as variables and functions. To display multiple letters verbatim, you can place them into quotes and to access single letter variables, you can use the hash syntax.
    
    $ A = pi r^2 $
    $ "area" = pi dot "radius"^2 $
    $ cal(A) :=
        { x in RR | x "is natural" } $
    #let x = 5
    $ #x < 17 $
    
## Symbols
Math mode makes a wide selection of symbols like `pi`, `dot`, or `RR` available. Many mathematical symbols are available in different variants. You can select between different variants by applying modifiers to the symbol. Typst further recognizes a number of shorthand sequences like `=>` that approximate a symbol. When such a shorthand exists, the symbol's documentation lists it.
    
    $ x < y => x gt.eq.not y $
    
## Line Breaks
Formulas can also contain line breaks. Each line can contain one or multiple alignment points (`&`) which are then aligned.
    
    $ sum_(k=0)^n k
        &= 1 + ... + n \
        &= (n(n+1)) / 2 $
    
## Function calls
Math mode supports special function calls without the hash prefix. In these "math calls", the argument list works a little differently than in code:
  * Within them, Typst is still in "math mode". Thus, you can write math directly into them, but need to use hash syntax to pass code expressions (except for strings, which are available in the math syntax).
  * They support positional and named arguments, as well as argument spreading.
  * They don't support trailing content blocks.
  * They provide additional syntax for 2-dimensional argument lists. The semicolon (`;`) merges preceding arguments separated by commas into an array argument.


    
    $ frac(a^2, 2) $
    $ vec(1, 2, delim: "[") $
    $ mat(1, 2; 3, 4) $
    $ mat(..#range(1, 5).chunks(2)) $
    $ lim_x =
        op("lim", limits: #true)_x $
    
To write a verbatim comma or semicolon in a math call, escape it with a backslash. The colon on the other hand is only recognized in a special way if directly preceded by an identifier, so to display it verbatim in those cases, you can just insert a space before it.
Functions calls preceded by a hash are normal code function calls and not affected by these rules.
## Alignment
When equations include multiple alignment points (`&`), this creates blocks of alternatingly right- and left-aligned columns. In the example below, the expression `(3x + y) / 7` is right-aligned and `= 9` is left-aligned. The word "given" is also left-aligned because `&&` creates two alignment points in a row, alternating the alignment twice. `& &` and `&&` behave exactly the same way. Meanwhile, "multiply by 7" is right-aligned because just one `&` precedes it. Each alignment point simply alternates between right-aligned/left-aligned.
    
    $ (3x + y) / 7 &= 9 && "given" \
      3x + y &= 63 & "multiply by 7" \
      3x &= 63 - y && "subtract y" \
      x &= 21 - y/3 & "divide by 3" $
    
## Math fonts
You can set the math font by with a show-set rule as demonstrated below. Note that only special OpenType math fonts are suitable for typesetting maths.
    
    #show math.equation: set text(font: "Fira Math")
    $ sum_(i in NN) 1 + i $
    
## Math module
All math functions are part of the `math` module, which is available by default in equations. Outside of equations, they can be accessed with the `math.` prefix.
# accent
Attaches an accent to a base.
## Example
    
    $grave(a) = accent(a, `)$ \
    $arrow(a) = accent(a, arrow)$ \
    $tilde(a) = accent(a, \u{0303})$
    
base
The base to which the accent is applied. May consist of multiple letters.
    
    $arrow(A B C)$
    
accent
The accent to apply to the base.
Supported accents include:
AccentNameCodepoint  
Grave`grave````  
Acute`acute``´`  
Circumflex`hat``^`  
Tilde`tilde``~`  
Macron`macron``¯`  
Dash`dash``‾`  
Breve`breve``˘`  
Dot`dot``.`  
Double dot, Diaeresis`dot.double`, `diaer``¨`  
Triple dot`dot.triple``⃛`  
Quadruple dot`dot.quad``⃜`  
Circle`circle``∘`  
Double acute`acute.double``˝`  
Caron`caron``ˇ`  
Right arrow`arrow`, `->``→`  
Left arrow`arrow.l`, `<-``←`  
Left/Right arrow`arrow.l.r``↔`  
Right harpoon`harpoon``⇀`  
Left harpoon`harpoon.lt``↼`  
size
The size of the accent, relative to the width of the base.
# attach
Subscript, superscripts, and limits.
Attachments can be displayed either as sub/superscripts, or limits. Typst automatically decides which is more suitable depending on the base, but you can also control this manually with the `scripts` and `limits` functions.
If you want the base to stretch to fit long top and bottom attachments (for example, an arrow with text above it), use the `stretch` function.
## Example
    
    $ sum_(i=0)^n a_i = 2^(1+i) $
    
## Syntax
This function also has dedicated syntax for attachments after the base: Use the underscore (`_`) to indicate a subscript i.e. bottom attachment and the hat (`^`) to indicate a superscript i.e. top attachment.
# attach
A base with optional attachments.
base
The base to which things are attached.
t
The top attachment, smartly positioned at top-right or above the base.
You can wrap the base in `limits()` or `scripts()` to override the smart positioning.
b
The bottom attachment, smartly positioned at the bottom-right or below the base.
You can wrap the base in `limits()` or `scripts()` to override the smart positioning.
tl
The top-left attachment (before the base).
bl
The bottom-left attachment (before base).
tr
The top-right attachment (after the base).
br
The bottom-right attachment (after the base).
# scripts
Forces a base to display attachments as scripts.
body
The base to attach the scripts to.
# limits
Forces a base to display attachments as limits.
body
The base to attach the limits to.
inline
Whether to also force limits in inline equations.
When applying limits globally (e.g., through a show rule), it is typically a good idea to disable this.
# binom
A binomial expression.
## Example
    
    $ binom(n, k) $
    $ binom(n, k_1, k_2, k_3, ..., k_m) $
    
upper
The binomial's upper index.
lower
The binomial's lower index.
# cancel
Displays a diagonal line over a part of an equation.
This is commonly used to show the elimination of a term.
## Example
    
    Here, we can simplify:
    $ (a dot b dot cancel(x)) /
        cancel(x) $
    
body
The content over which the line should be placed.
length
The length of the line, relative to the length of the diagonal spanning the whole element being "cancelled". A value of `100%` would then have the line span precisely the element's diagonal.
    
    $ a + cancel(x, length: #200%)
        - cancel(x, length: #200%) $
    
inverted
Whether the cancel line should be inverted (flipped along the y-axis). For the default angle setting, inverted means the cancel line points to the top left instead of top right.
    
    $ (a cancel((b + c), inverted: #true)) /
        cancel(b + c, inverted: #true) $
    
cross
Whether two opposing cancel lines should be drawn, forming a cross over the element. Overrides `inverted`.
    
    $ cancel(Pi, cross: #true) $
    
angle
How much to rotate the cancel line.
  * If given an angle, the line is rotated by that angle clockwise with respect to the y-axis.
  * If `auto`, the line assumes the default angle; that is, along the rising diagonal of the content box.
  * If given a function `angle => angle`, the line is rotated, with respect to the y-axis, by the angle returned by that function. The function receives the default angle as its input.


    
    $ cancel(Pi)
      cancel(Pi, angle: #0deg)
      cancel(Pi, angle: #45deg)
      cancel(Pi, angle: #90deg)
      cancel(1/(1+x), angle: #(a => a + 45deg))
      cancel(1/(1+x), angle: #(a => a + 90deg)) $
    
stroke
How to stroke the cancel line.
    
    $ cancel(
      sum x,
      stroke: #(
        paint: red,
        thickness: 1.5pt,
        dash: "dashed",
      ),
    ) $
    
# cases
A case distinction.
Content across different branches can be aligned with the `&` symbol.
## Example
    
    $ f(x, y) := cases(
      1 "if" (x dot y)/2 <= 0,
      2 "if" x "is even",
      3 "if" x in NN,
      4 "else",
    ) $
    
delim
The delimiter to use.
Can be a single character specifying the left delimiter, in which case the right delimiter is inferred. Otherwise, can be an array containing a left and a right delimiter.
    
    #set math.cases(delim: "[")
    $ x = cases(1, 2) $
    
reverse
Whether the direction of cases should be reversed.
    
    #set math.cases(reverse: true)
    $ cases(1, 2) = x $
    
gap
The gap between branches.
    
    #set math.cases(gap: 1em)
    $ x = cases(1, 2) $
    
children
The branches of the case distinction.
# class
Forced use of a certain math class.
This is useful to treat certain symbols as if they were of a different class, e.g. to make a symbol behave like a relation. The class of a symbol defines the way it is laid out, including spacing around it, and how its scripts are attached by default. Note that the latter can always be overridden using `limits` and `scripts`.
## Example
    
    #let loves = math.class(
      "relation",
      sym.suit.heart,
    )
    
    $x loves y and y loves 5$
    
class
The class to apply to the content.
body
The content to which the class is applied.
# equation
A mathematical equation.
Can be displayed inline with text or as a separate block. An equation becomes block-level through the presence of at least one space after the opening dollar sign and one space before the closing dollar sign.
## Example
    
    #set text(font: "New Computer Modern")
    
    Let $a$, $b$, and $c$ be the side
    lengths of right-angled triangle.
    Then, we know that:
    $ a^2 + b^2 = c^2 $
    
    Prove by induction:
    $ sum_(k=1)^n k = (n(n+1)) / 2 $
    
By default, block-level equations will not break across pages. This can be changed through `show math.equation: set block(breakable: true)`.
## Syntax
This function also has dedicated syntax: Write mathematical markup within dollar signs to create an equation. Starting and ending the equation with at least one space lifts it into a separate block that is centered horizontally. For more details about math syntax, see the main math page.
block
Whether the equation is displayed as a separate block.
numbering
How to number block-level equations.
    
    #set math.equation(numbering: "(1)")
    
    We define:
    $ phi.alt := (1 + sqrt(5)) / 2 $ <ratio>
    
    With @ratio, we get:
    $ F_n = floor(1 / sqrt(5) phi.alt^n) $
    
number-align
The alignment of the equation numbering.
By default, the alignment is `end + horizon`. For the horizontal component, you can use `right`, `left`, or `start` and `end` of the text direction; for the vertical component, you can use `top`, `horizon`, or `bottom`.
    
    #set math.equation(numbering: "(1)", number-align: bottom)
    
    We can calculate:
    $ E &= sqrt(m_0^2 + p^2) \
        &approx 125 "GeV" $
    
supplement
A supplement for the equation.
For references to equations, this is added before the referenced number.
If a function is specified, it is passed the referenced equation and should return content.
    
    #set math.equation(numbering: "(1)", supplement: [Eq.])
    
    We define:
    $ phi.alt := (1 + sqrt(5)) / 2 $ <ratio>
    
    With @ratio, we get:
    $ F_n = floor(1 / sqrt(5) phi.alt^n) $
    
body
The contents of the equation.
# frac
A mathematical fraction.
## Example
    
    $ 1/2 < (x+1)/2 $
    $ ((x+1)) / 2 = frac(a, b) $
    
## Syntax
This function also has dedicated syntax: Use a slash to turn neighbouring expressions into a fraction. Multiple atoms can be grouped into a single expression using round grouping parenthesis. Such parentheses are removed from the output, but you can nest multiple to force them.
num
The fraction's numerator.
denom
The fraction's denominator.
# lr
Delimiter matching.
The `lr` function allows you to match two delimiters and scale them with the content they contain. While this also happens automatically for delimiters that match syntactically, `lr` allows you to match two arbitrary delimiters and control their size exactly. Apart from the `lr` function, Typst provides a few more functions that create delimiter pairings for absolute, ceiled, and floored values as well as norms.
## Example
    
    $ [a, b/2] $
    $ lr(]sum_(x=1)^n], size: #50%) x $
    $ abs((x + y) / 2) $
    
# lr
Scales delimiters.
While matched delimiters scale by default, this can be used to scale unmatched delimiters and to control the delimiter scaling more precisely.
size
The size of the brackets, relative to the height of the wrapped content.
body
The delimited content, including the delimiters.
# mid
Scales delimiters vertically to the nearest surrounding `lr()` group.
body
The content to be scaled.
# abs
Takes the absolute value of an expression.
size
The size of the brackets, relative to the height of the wrapped content.
body
The expression to take the absolute value of.
# norm
Takes the norm of an expression.
size
The size of the brackets, relative to the height of the wrapped content.
body
The expression to take the norm of.
# floor
Floors an expression.
size
The size of the brackets, relative to the height of the wrapped content.
body
The expression to floor.
# ceil
Ceils an expression.
size
The size of the brackets, relative to the height of the wrapped content.
body
The expression to ceil.
# round
Rounds an expression.
size
The size of the brackets, relative to the height of the wrapped content.
body
The expression to round.
# mat
A matrix.
The elements of a row should be separated by commas, while the rows themselves should be separated by semicolons. The semicolon syntax merges preceding arguments separated by commas into an array. You can also use this special syntax of math function calls to define custom functions that take 2D data.
Content in cells can be aligned with the `align` parameter, or content in cells that are in the same row can be aligned with the `&` symbol.
## Example
    
    $ mat(
      1, 2, ..., 10;
      2, 2, ..., 10;
      dots.v, dots.v, dots.down, dots.v;
      10, 10, ..., 10;
    ) $
    
delim
The delimiter to use.
Can be a single character specifying the left delimiter, in which case the right delimiter is inferred. Otherwise, can be an array containing a left and a right delimiter.
    
    #set math.mat(delim: "[")
    $ mat(1, 2; 3, 4) $
    
align
The horizontal alignment that each cell should have.
    
    #set math.mat(align: right)
    $ mat(-1, 1, 1; 1, -1, 1; 1, 1, -1) $
    
augment
Draws augmentation lines in a matrix.
  * `none`: No lines are drawn.
  * A single number: A vertical augmentation line is drawn after the specified column number. Negative numbers start from the end.
  * A dictionary: With a dictionary, multiple augmentation lines can be drawn both horizontally and vertically. Additionally, the style of the lines can be set. The dictionary can contain the following keys: 
    * `hline`: The offsets at which horizontal lines should be drawn. For example, an offset of `2` would result in a horizontal line being drawn after the second row of the matrix. Accepts either an integer for a single line, or an array of integers for multiple lines. Like for a single number, negative numbers start from the end.
    * `vline`: The offsets at which vertical lines should be drawn. For example, an offset of `2` would result in a vertical line being drawn after the second column of the matrix. Accepts either an integer for a single line, or an array of integers for multiple lines. Like for a single number, negative numbers start from the end.
    * `stroke`: How to stroke the line. If set to `auto`, takes on a thickness of 0.05em and square line caps.


    
    $ mat(1, 0, 1; 0, 1, 2; augment: #2) $
    // Equivalent to:
    $ mat(1, 0, 1; 0, 1, 2; augment: #(-1)) $
    
    
    $ mat(0, 0, 0; 1, 1, 1; augment: #(hline: 1, stroke: 2pt + green)) $
    
gap
The gap between rows and columns.
This is a shorthand to set `row-gap` and `column-gap` to the same value.
    
    #set math.mat(gap: 1em)
    $ mat(1, 2; 3, 4) $
    
row-gap
The gap between rows.
    
    #set math.mat(row-gap: 1em)
    $ mat(1, 2; 3, 4) $
    
column-gap
The gap between columns.
    
    #set math.mat(column-gap: 1em)
    $ mat(1, 2; 3, 4) $
    
rows
An array of arrays with the rows of the matrix.
    
    #let data = ((1, 2, 3), (4, 5, 6))
    #let matrix = math.mat(..data)
    $ v := matrix $
    
# primes
Grouped primes.
    
    $ a'''_b = a^'''_b $
    
## Syntax
This function has dedicated syntax: use apostrophes instead of primes. They will automatically attach to the previous element, moving superscripts to the next level.
count
The number of grouped primes.
# roots
Square and non-square roots.
## Example
    
    $ sqrt(3 - 2 sqrt(2)) = sqrt(2) - 1 $
    $ root(3, x) $
    
# root
A general root.
index
Which root of the radicand to take.
radicand
The expression to take the root of.
# sqrt
A square root.
radicand
The expression to take the square root of.
# sizes
Forced size styles for expressions within formulas.
These functions allow manual configuration of the size of equation elements to make them look as in a display/inline equation or as if used in a root or sub/superscripts.
# display
Forced display style in math.
This is the normal size for block equations.
body
The content to size.
cramped
Whether to impose a height restriction for exponents, like regular sub- and superscripts do.
# inline
Forced inline (text) style in math.
This is the normal size for inline equations.
body
The content to size.
cramped
Whether to impose a height restriction for exponents, like regular sub- and superscripts do.
# script
Forced script style in math.
This is the smaller size used in powers or sub- or superscripts.
body
The content to size.
cramped
Whether to impose a height restriction for exponents, like regular sub- and superscripts do.
# sscript
Forced second script style in math.
This is the smallest size, used in second-level sub- and superscripts (script of the script).
body
The content to size.
cramped
Whether to impose a height restriction for exponents, like regular sub- and superscripts do.
# stretch
Stretches a glyph.
This function can also be used to automatically stretch the base of an attachment, so that it fits the top and bottom attachments.
Note that only some glyphs can be stretched, and which ones can depend on the math font being used. However, most math fonts are the same in this regard.
    
    $ H stretch(=)^"define" U + p V $
    $ f : X stretch(->>, size: #150%)_"surjective" Y $
    $ x stretch(harpoons.ltrb, size: #3em) y
        stretch(\[, size: #150%) z $
    
body
The glyph to stretch.
size
The size to stretch to, relative to the maximum size of the glyph and its attachments.
# styles
Alternate letterforms within formulas.
These functions are distinct from the `text` function because math fonts contain multiple variants of each letter.
# upright
Upright (non-italic) font style in math.
body
The content to style.
# italic
Italic font style in math.
For roman letters and greek lowercase letters, this is already the default.
body
The content to style.
# bold
Bold font style in math.
body
The content to style.
# op
A text operator in an equation.
## Example
    
    $ tan x = (sin x)/(cos x) $
    $ op("custom",
         limits: #true)_(n->oo) n $
    
## Predefined Operators
Typst predefines the operators `arccos`, `arcsin`, `arctan`, `arg`, `cos`, `cosh`, `cot`, `coth`, `csc`, `csch`, `ctg`, `deg`, `det`, `dim`, `exp`, `gcd`, `lcm`, `hom`, `id`, `im`, `inf`, `ker`, `lg`, `lim`, `liminf`, `limsup`, `ln`, `log`, `max`, `min`, `mod`, `Pr`, `sec`, `sech`, `sin`, `sinc`, `sinh`, `sup`, `tan`, `tanh`, `tg` and `tr`.
text
The operator's text.
limits
Whether the operator should show attachments as limits in display mode.
# underover
Delimiters above or below parts of an equation.
The braces and brackets further allow you to add an optional annotation below or above themselves.
# underline
A horizontal line under content.
body
The content above the line.
# overline
A horizontal line over content.
body
The content below the line.
# underbrace
A horizontal brace under content, with an optional annotation below.
body
The content above the brace.
annotation
The optional content below the brace.
# overbrace
A horizontal brace over content, with an optional annotation above.
body
The content below the brace.
annotation
The optional content above the brace.
# underbracket
A horizontal bracket under content, with an optional annotation below.
body
The content above the bracket.
annotation
The optional content below the bracket.
# overbracket
A horizontal bracket over content, with an optional annotation above.
body
The content below the bracket.
annotation
The optional content above the bracket.
# underparen
A horizontal parenthesis under content, with an optional annotation below.
body
The content above the parenthesis.
annotation
The optional content below the parenthesis.
# overparen
A horizontal parenthesis over content, with an optional annotation above.
body
The content below the parenthesis.
annotation
The optional content above the parenthesis.
# undershell
A horizontal tortoise shell bracket under content, with an optional annotation below.
body
The content above the tortoise shell bracket.
annotation
The optional content below the tortoise shell bracket.
# overshell
A horizontal tortoise shell bracket over content, with an optional annotation above.
body
The content below the tortoise shell bracket.
annotation
The optional content above the tortoise shell bracket.
# variants
Alternate typefaces within formulas.
These functions are distinct from the `text` function because math fonts contain multiple variants of each letter.
# serif
Serif (roman) font style in math.
This is already the default.
body
The content to style.
# sans
Sans-serif font style in math.
body
The content to style.
# frak
Fraktur font style in math.
body
The content to style.
# mono
Monospace font style in math.
body
The content to style.
# bb
Blackboard bold (double-struck) font style in math.
For uppercase latin letters, blackboard bold is additionally available through symbols of the form `NN` and `RR`.
body
The content to style.
# cal
Calligraphic font style in math.
body
The content to style.
# vec
A column vector.
Content in the vector's elements can be aligned with the `align` parameter, or the `&` symbol.
## Example
    
    $ vec(a, b, c) dot vec(1, 2, 3)
        = a + 2b + 3c $
    
delim
The delimiter to use.
Can be a single character specifying the left delimiter, in which case the right delimiter is inferred. Otherwise, can be an array containing a left and a right delimiter.
    
    #set math.vec(delim: "[")
    $ vec(1, 2) $
    
align
The horizontal alignment that each element should have.
    
    #set math.vec(align: right)
    $ vec(-1, 1, -1) $
    
gap
The gap between elements.
    
    #set math.vec(gap: 1em)
    $ vec(1, 2) $
    
children
The elements of the vector.
# symbols
These two modules give names to symbols and emoji to make them easy to insert with a normal keyboard. Alternatively, you can also always directly enter Unicode symbols into your text and formulas. In addition to the symbols listed below, math mode defines `dif` and `Dif`. These are not normal symbol values because they also affect spacing and font style.
# sym
Named general symbols.
For example, `#sym.arrow` produces the → symbol. Within formulas, these symbols can be used without the `#sym.` prefix.
The `d` in an integral's `dx` can be written as `$dif x$`. Outside math formulas, `dif` can be accessed as `math.dif`.
# emoji
Named emoji.
For example, `#emoji.face` produces the 😀 emoji. If you frequently use certain emojis, you can also import them from the `emoji` module (`#import emoji: face`) to use them without the `#emoji.` prefix.
# layout
Arranging elements on the page in different ways.
By combining layout functions, you can create complex and automatic layouts.
# align
Aligns content horizontally and vertically.
## Example
Let's start with centering our content horizontally:
    
    #set page(height: 120pt)
    #set align(center)
    
    Centered text, a sight to see \
    In perfect balance, visually \
    Not left nor right, it stands alone \
    A work of art, a visual throne
    
To center something vertically, use horizon alignment:
    
    #set page(height: 120pt)
    #set align(horizon)
    
    Vertically centered, \
    the stage had entered, \
    a new paragraph.
    
## Combining alignments
You can combine two alignments with the `+` operator. Let's also only apply this to one piece of content by using the function form instead of a set rule:
    
    #set page(height: 120pt)
    Though left in the beginning ...
    
    #align(right + bottom)[
      ... they were right in the end, \
      and with addition had gotten, \
      the paragraph to the bottom!
    ]
    
## Nested alignment
You can use varying alignments for layout containers and the elements within them. This way, you can create intricate layouts:
    
    #align(center, block[
      #set align(left)
      Though centered together \
      alone \
      we \
      are \
      left.
    ])
    
## Alignment within the same line
The `align` function performs block-level alignment and thus always interrupts the current paragraph. To have different alignment for parts of the same line, you should use fractional spacing instead:
    
    Start #h(1fr) End
    
alignment
The alignment along both axes.
    
    #set page(height: 6cm)
    #set text(lang: "ar")
    
    مثال
    #align(
      end + horizon,
      rect(inset: 12pt)[ركن]
    )
    
body
The content to align.
# alignment
Where to align something along an axis.
Possible values are:
  * `start`: Aligns at the start of the text direction.
  * `end`: Aligns at the end of the text direction.
  * `left`: Align at the left.
  * `center`: Aligns in the middle, horizontally.
  * `right`: Aligns at the right.
  * `top`: Aligns at the top.
  * `horizon`: Aligns in the middle, vertically.
  * `bottom`: Align at the bottom.


These values are available globally and also in the alignment type's scope, so you can write either of the following two:
    
    #align(center)[Hi]
    #align(alignment.center)[Hi]
    
## 2D alignments
To align along both axes at the same time, add the two alignments using the `+` operator. For example, `top + right` aligns the content to the top right corner.
    
    #set page(height: 3cm)
    #align(center + bottom)[Hi]
    
## Fields
The `x` and `y` fields hold the alignment's horizontal and vertical components, respectively (as yet another `alignment`). They may be `none`.
    
    #(top + right).x \
    #left.x \
    #left.y (none)
    
# axis
The axis this alignment belongs to.
  * `"horizontal"` for `start`, `left`, `center`, `right`, and `end`
  * `"vertical"` for `top`, `horizon`, and `bottom`
  * `none` for 2-dimensional alignments


# inv
The inverse alignment.
# angle
An angle describing a rotation.
Typst supports the following angular units:
  * Degrees: `180deg`
  * Radians: `3.14rad`


## Example
    
    #rotate(10deg)[Hello there!]
    
# rad
Converts this angle to radians.
# deg
Converts this angle to degrees.
# block
A block-level container.
Such a container can be used to separate content, size it, and give it a background or border.
Blocks are also the primary way to control whether text becomes part of a paragraph or not. See the paragraph documentation for more details.
## Examples
With a block, you can give a background to content while still allowing it to break across multiple pages.
    
    #set page(height: 100pt)
    #block(
      fill: luma(230),
      inset: 8pt,
      radius: 4pt,
      lorem(30),
    )
    
Blocks are also useful to force elements that would otherwise be inline to become block-level, especially when writing show rules.
    
    #show heading: it => it.body
    = Blockless
    More text.
    
    #show heading: it => block(it.body)
    = Blocky
    More text.
    
width
The block's width.
    
    #set align(center)
    #block(
      width: 60%,
      inset: 8pt,
      fill: silver,
      lorem(10),
    )
    
height
The block's height. When the height is larger than the remaining space on a page and `breakable` is `true`, the block will continue on the next page with the remaining height.
    
    #set page(height: 80pt)
    #set align(center)
    #block(
      width: 80%,
      height: 150%,
      fill: aqua,
    )
    
breakable
Whether the block can be broken and continue on the next page.
    
    #set page(height: 80pt)
    The following block will
    jump to its own page.
    #block(
      breakable: false,
      lorem(15),
    )
    
fill
The block's background color. See the rectangle's documentation for more details.
stroke
The block's border color. See the rectangle's documentation for more details.
radius
How much to round the block's corners. See the rectangle's documentation for more details.
inset
How much to pad the block's content. See the box's documentation for more details.
outset
How much to expand the block's size without affecting the layout. See the box's documentation for more details.
spacing
The spacing around the block. When `auto`, inherits the paragraph `spacing`.
For two adjacent blocks, the larger of the first block's `above` and the second block's `below` spacing wins. Moreover, block spacing takes precedence over paragraph `spacing`.
Note that this is only a shorthand to set `above` and `below` to the same value. Since the values for `above` and `below` might differ, a context block only provides access to `block.above` and `block.below`, not to `block.spacing` directly.
This property can be used in combination with a show rule to adjust the spacing around arbitrary block-level elements.
    
    #set align(center)
    #show math.equation: set block(above: 8pt, below: 16pt)
    
    This sum of $x$ and $y$:
    $ x + y = z $
    A second paragraph.
    
above
The spacing between this block and its predecessor.
below
The spacing between this block and its successor.
clip
Whether to clip the content inside the block.
Clipping is useful when the block's content is larger than the block itself, as any content that exceeds the block's bounds will be hidden.
    
    #block(
      width: 50pt,
      height: 50pt,
      clip: true,
      image("tiger.jpg", width: 100pt, height: 100pt)
    )
    
sticky
Whether this block must stick to the following one, with no break in between.
This is, by default, set on heading blocks to prevent orphaned headings at the bottom of the page.
    
    // Disable stickiness of headings.
    #show heading: set block(sticky: false)
    #lorem(20)
    
    = Chapter
    #lorem(10)
    
body
The contents of the block.
# box
An inline-level container that sizes content.
All elements except inline math, text, and boxes are block-level and cannot occur inside of a paragraph. The box function can be used to integrate such elements into a paragraph. Boxes take the size of their contents by default but can also be sized explicitly.
## Example
    
    Refer to the docs
    #box(
      height: 9pt,
      image("docs.svg")
    )
    for more information.
    
width
The width of the box.
Boxes can have fractional widths, as the example below demonstrates.
Note: Currently, only boxes and only their widths might be fractionally sized within paragraphs. Support for fractionally sized images, shapes, and more might be added in the future.
    
    Line in #box(width: 1fr, line(length: 100%)) between.
    
height
The height of the box.
baseline
An amount to shift the box's baseline by.
    
    Image: #box(baseline: 40%, image("tiger.jpg", width: 2cm)).
    
fill
The box's background color. See the rectangle's documentation for more details.
stroke
The box's border color. See the rectangle's documentation for more details.
radius
How much to round the box's corners. See the rectangle's documentation for more details.
inset
How much to pad the box's content.
Note: When the box contains text, its exact size depends on the current text edges.
    
    #rect(inset: 0pt)[Tight]
    
outset
How much to expand the box's size without affecting the layout.
This is useful to prevent padding from affecting line layout. For a generalized version of the example below, see the documentation for the raw text's block parameter.
    
    An inline
    #box(
      fill: luma(235),
      inset: (x: 3pt, y: 0pt),
      outset: (y: 3pt),
      radius: 2pt,
    )[rectangle].
    
clip
Whether to clip the content inside the box.
Clipping is useful when the box's content is larger than the box itself, as any content that exceeds the box's bounds will be hidden.
    
    #box(
      width: 50pt,
      height: 50pt,
      clip: true,
      image("tiger.jpg", width: 100pt, height: 100pt)
    )
    
body
The contents of the box.
# colbreak
Forces a column break.
The function will behave like a page break when used in a single column layout or the last column on a page. Otherwise, content after the column break will be placed in the next column.
## Example
    
    #set page(columns: 2)
    Preliminary findings from our
    ongoing research project have
    revealed a hitherto unknown
    phenomenon of extraordinary
    significance.
    
    #colbreak()
    Through rigorous experimentation
    and analysis, we have discovered
    a hitherto uncharacterized process
    that defies our current
    understanding of the fundamental
    laws of nature.
    
weak
If `true`, the column break is skipped if the current column is already empty.
# columns
Separates a region into multiple equally sized columns.
The `column` function lets you separate the interior of any container into multiple columns. It will currently not balance the height of the columns. Instead, the columns will take up the height of their container or the remaining height on the page. Support for balanced columns is planned for the future.
## Page-level columns
If you need to insert columns across your whole document, use the `page` function's `columns` parameter instead. This will create the columns directly at the page-level rather than wrapping all of your content in a layout container. As a result, things like pagebreaks, footnotes, and line numbers will continue to work as expected. For more information, also read the relevant part of the page setup guide.
## Breaking out of columns
To temporarily break out of columns (e.g. for a paper's title), use parent-scoped floating placement:
    
    #set page(columns: 2, height: 150pt)
    
    #place(
      top + center,
      scope: "parent",
      float: true,
      text(1.4em, weight: "bold")[
        My document
      ],
    )
    
    #lorem(40)
    
count
The number of columns.
gutter
The size of the gutter space between each column.
body
The content that should be layouted into the columns.
# direction
The four directions into which content can be laid out.
Possible values are:
  * `ltr`: Left to right.
  * `rtl`: Right to left.
  * `ttb`: Top to bottom.
  * `btt`: Bottom to top.


These values are available globally and also in the direction type's scope, so you can write either of the following two:
    
    #stack(dir: rtl)[A][B][C]
    #stack(dir: direction.rtl)[A][B][C]
    
# axis
The axis this direction belongs to, either `"horizontal"` or `"vertical"`.
# start
The start point of this direction, as an alignment.
# end
The end point of this direction, as an alignment.
# inv
The inverse direction.
# fraction
Defines how the remaining space in a layout is distributed.
Each fractionally sized element gets space based on the ratio of its fraction to the sum of all fractions.
For more details, also see the h and v functions and the grid function.
## Example
    
    Left #h(1fr) Left-ish #h(2fr) Right
    
# grid
Arranges content in a grid.
The grid element allows you to arrange content in a grid. You can define the number of rows and columns, as well as the size of the gutters between them. There are multiple sizing modes for columns and rows that can be used to create complex layouts.
While the grid and table elements work very similarly, they are intended for different use cases and carry different semantics. The grid element is intended for presentational and layout purposes, while the `table` element is intended for, in broad terms, presenting multiple related data points. In the future, Typst will annotate its output such that screenreaders will announce content in `table` as tabular while a grid's content will be announced no different than multiple content blocks in the document flow. Set and show rules on one of these elements do not affect the other.
A grid's sizing is determined by the track sizes specified in the arguments. Because each of the sizing parameters accepts the same values, we will explain them just once, here. Each sizing argument accepts an array of individual track sizes. A track size is either:
  * `auto`: The track will be sized to fit its contents. It will be at most as large as the remaining space. If there is more than one `auto` track width, and together they claim more than the available space, the `auto` tracks will fairly distribute the available space among themselves.
  * A fixed or relative length (e.g. `10pt` or `20% - 1cm`): The track will be exactly of this size.
  * A fractional length (e.g. `1fr`): Once all other tracks have been sized, the remaining space will be divided among the fractional tracks according to their fractions. For example, if there are two fractional tracks, each with a fraction of `1fr`, they will each take up half of the remaining space.


To specify a single track, the array can be omitted in favor of a single value. To specify multiple `auto` tracks, enter the number of tracks instead of an array. For example, `columns:` `3` is equivalent to `columns:` `(auto, auto, auto)`.
## Examples
The example below demonstrates the different track sizing options. It also shows how you can use `grid.cell` to make an individual cell span two grid tracks.
    
    // We use `rect` to emphasize the
    // area of cells.
    #set rect(
      inset: 8pt,
      fill: rgb("e4e5ea"),
      width: 100%,
    )
    
    #grid(
      columns: (60pt, 1fr, 2fr),
      rows: (auto, 60pt),
      gutter: 3pt,
      rect[Fixed width, auto height],
      rect[1/3 of the remains],
      rect[2/3 of the remains],
      rect(height: 100%)[Fixed height],
      grid.cell(
        colspan: 2,
        image("tiger.jpg", width: 100%),
      ),
    )
    
You can also spread an array of strings or content into a grid to populate its cells.
    
    #grid(
      columns: 5,
      gutter: 5pt,
      ..range(25).map(str)
    )
    
## Styling the grid
The grid's appearance can be customized through different parameters. These are the most important ones:
  * `fill` to give all cells a background
  * `align` to change how cells are aligned
  * `inset` to optionally add internal padding to each cell
  * `stroke` to optionally enable grid lines with a certain stroke


If you need to override one of the above options for a single cell, you can use the `grid.cell` element. Likewise, you can override individual grid lines with the `grid.hline` and `grid.vline` elements.
Alternatively, if you need the appearance options to depend on a cell's position (column and row), you may specify a function to `fill` or `align` of the form `(column, row) => value`. You may also use a show rule on `grid.cell` \- see that element's examples or the examples below for more information.
Locating most of your styling in set and show rules is recommended, as it keeps the grid's or table's actual usages clean and easy to read. It also allows you to easily change the grid's appearance in one place.
### Stroke styling precedence
There are three ways to set the stroke of a grid cell: through `grid.cell`'s `stroke` field, by using `grid.hline` and `grid.vline`, or by setting the `grid`'s `stroke` field. When multiple of these settings are present and conflict, the `hline` and `vline` settings take the highest precedence, followed by the `cell` settings, and finally the `grid` settings.
Furthermore, strokes of a repeated grid header or footer will take precedence over regular cell strokes.
columns
The column sizes.
Either specify a track size array or provide an integer to create a grid with that many `auto`-sized columns. Note that opposed to rows and gutters, providing a single track size will only ever create a single column.
rows
The row sizes.
If there are more cells than fit the defined rows, the last row is repeated until there are no more cells.
gutter
The gaps between rows and columns.
If there are more gutters than defined sizes, the last gutter is repeated.
This is a shorthand to set `column-gutter` and `row-gutter` to the same value.
column-gutter
The gaps between columns.
row-gutter
The gaps between rows.
fill
How to fill the cells.
This can be a color or a function that returns a color. The function receives the cells' column and row indices, starting from zero. This can be used to implement striped grids.
    
    #grid(
      fill: (x, y) =>
        if calc.even(x + y) { luma(230) }
        else { white },
      align: center + horizon,
      columns: 4,
      inset: 2pt,
      [X], [O], [X], [O],
      [O], [X], [O], [X],
      [X], [O], [X], [O],
      [O], [X], [O], [X],
    )
    
align
How to align the cells' content.
This can either be a single alignment, an array of alignments (corresponding to each column) or a function that returns an alignment. The function receives the cells' column and row indices, starting from zero. If set to `auto`, the outer alignment is used.
You can find an example for this argument at the `table.align` parameter.
stroke
How to stroke the cells.
Grids have no strokes by default, which can be changed by setting this option to the desired stroke.
If it is necessary to place lines which can cross spacing between cells produced by the `gutter` option, or to override the stroke between multiple specific cells, consider specifying one or more of `grid.hline` and `grid.vline` alongside your grid cells.
    
    #set page(height: 13em, width: 26em)
    
    #let cv(..jobs) = grid(
      columns: 2,
      inset: 5pt,
      stroke: (x, y) => if x == 0 and y > 0 {
        (right: (
          paint: luma(180),
          thickness: 1.5pt,
          dash: "dotted"
        ))
      },
      grid.header(grid.cell(colspan: 2)[
        *Professional Experience*
        #box(width: 1fr, line(length: 100%, stroke: luma(180)))
      ]),
      ..{
        let last = none
        for job in jobs.pos() {
          (
            if job.year != last [*#job.year*],
            [
              *#job.company* - #job.role _(#job.timeframe)_ \
              #job.details
            ]
          )
          last = job.year
        }
      }
    )
    
    #cv(
      (
        year: 2012,
        company: [Pear Seed & Co.],
        role: [Lead Engineer],
        timeframe: [Jul - Dec],
        details: [
          - Raised engineers from 3x to 10x
          - Did a great job
        ],
      ),
      (
        year: 2012,
        company: [Mega Corp.],
        role: [VP of Sales],
        timeframe: [Mar - Jun],
        details: [- Closed tons of customers],
      ),
      (
        year: 2013,
        company: [Tiny Co.],
        role: [CEO],
        timeframe: [Jan - Dec],
        details: [- Delivered 4x more shareholder value],
      ),
      (
        year: 2014,
        company: [Glorbocorp Ltd],
        role: [CTO],
        timeframe: [Jan - Mar],
        details: [- Drove containerization forward],
      ),
    )
    
inset
How much to pad the cells' content.
You can find an example for this argument at the `table.inset` parameter.
children
The contents of the grid cells, plus any extra grid lines specified with the `grid.hline` and `grid.vline` elements.
The cells are populated in row-major order.
# cell
A cell in the grid. You can use this function in the argument list of a grid to override grid style properties for an individual cell or manually positioning it within the grid. You can also use this function in show rules to apply certain styles to multiple cells at once.
For example, you can override the position and stroke for a single cell:
body
The cell's body.
x
The cell's column (zero-indexed). This field may be used in show rules to style a cell depending on its column.
You may override this field to pick in which column the cell must be placed. If no row (`y`) is chosen, the cell will be placed in the first row (starting at row 0) with that column available (or a new row if none). If both `x` and `y` are chosen, however, the cell will be placed in that exact position. An error is raised if that position is not available (thus, it is usually wise to specify cells with a custom position before cells with automatic positions).
    
    #let circ(c) = circle(
        fill: c, width: 5mm
    )
    
    #grid(
      columns: 4,
      rows: 7mm,
      stroke: .5pt + blue,
      align: center + horizon,
      inset: 1mm,
    
      grid.cell(x: 2, y: 2, circ(aqua)),
      circ(yellow),
      grid.cell(x: 3, circ(green)),
      circ(black),
    )
    
y
The cell's row (zero-indexed). This field may be used in show rules to style a cell depending on its row.
You may override this field to pick in which row the cell must be placed. If no column (`x`) is chosen, the cell will be placed in the first column (starting at column 0) available in the chosen row. If all columns in the chosen row are already occupied, an error is raised.
    
    #let tri(c) = polygon.regular(
      fill: c,
      size: 5mm,
      vertices: 3,
    )
    
    #grid(
      columns: 2,
      stroke: blue,
      inset: 1mm,
    
      tri(black),
      grid.cell(y: 1, tri(teal)),
      grid.cell(y: 1, tri(red)),
      grid.cell(y: 2, tri(orange))
    )
    
colspan
The amount of columns spanned by this cell.
rowspan
The amount of rows spanned by this cell.
fill
The cell's fill override.
align
The cell's alignment override.
inset
The cell's inset override.
stroke
The cell's stroke override.
breakable
Whether rows spanned by this cell can be placed in different pages. When equal to `auto`, a cell spanning only fixed-size rows is unbreakable, while a cell spanning at least one `auto`-sized row is breakable.
# hline
A horizontal line in the grid.
Overrides any per-cell stroke, including stroke specified through the grid's `stroke` field. Can cross spacing between cells created through the grid's `column-gutter` option.
An example for this function can be found at the `table.hline` element.
y
The row above which the horizontal line is placed (zero-indexed). If the `position` field is set to `bottom`, the line is placed below the row with the given index instead (see that field's docs for details).
Specifying `auto` causes the line to be placed at the row below the last automatically positioned cell (that is, cell without coordinate overrides) before the line among the grid's children. If there is no such cell before the line, it is placed at the top of the grid (row 0). Note that specifying for this option exactly the total amount of rows in the grid causes this horizontal line to override the bottom border of the grid, while a value of 0 overrides the top border.
start
The column at which the horizontal line starts (zero-indexed, inclusive).
end
The column before which the horizontal line ends (zero-indexed, exclusive). Therefore, the horizontal line will be drawn up to and across column `end - 1`.
A value equal to `none` or to the amount of columns causes it to extend all the way towards the end of the grid.
stroke
The line's stroke.
Specifying `none` removes any lines previously placed across this line's range, including hlines or per-cell stroke below it.
position
The position at which the line is placed, given its row (`y`) - either `top` to draw above it or `bottom` to draw below it.
This setting is only relevant when row gutter is enabled (and shouldn't be used otherwise - prefer just increasing the `y` field by one instead), since then the position below a row becomes different from the position above the next row due to the spacing between both.
# vline
A vertical line in the grid.
Overrides any per-cell stroke, including stroke specified through the grid's `stroke` field. Can cross spacing between cells created through the grid's `row-gutter` option.
x
The column before which the horizontal line is placed (zero-indexed). If the `position` field is set to `end`, the line is placed after the column with the given index instead (see that field's docs for details).
Specifying `auto` causes the line to be placed at the column after the last automatically positioned cell (that is, cell without coordinate overrides) before the line among the grid's children. If there is no such cell before the line, it is placed before the grid's first column (column 0). Note that specifying for this option exactly the total amount of columns in the grid causes this vertical line to override the end border of the grid (right in LTR, left in RTL), while a value of 0 overrides the start border (left in LTR, right in RTL).
start
The row at which the vertical line starts (zero-indexed, inclusive).
end
The row on top of which the vertical line ends (zero-indexed, exclusive). Therefore, the vertical line will be drawn up to and across row `end - 1`.
A value equal to `none` or to the amount of rows causes it to extend all the way towards the bottom of the grid.
stroke
The line's stroke.
Specifying `none` removes any lines previously placed across this line's range, including vlines or per-cell stroke below it.
position
The position at which the line is placed, given its column (`x`) - either `start` to draw before it or `end` to draw after it.
The values `left` and `right` are also accepted, but discouraged as they cause your grid to be inconsistent between left-to-right and right-to-left documents.
This setting is only relevant when column gutter is enabled (and shouldn't be used otherwise - prefer just increasing the `x` field by one instead), since then the position after a column becomes different from the position before the next column due to the spacing between both.
# header
A repeatable grid header.
If `repeat` is set to `true`, the header will be repeated across pages. For an example, refer to the `table.header` element and the `grid.stroke` parameter.
repeat
Whether this header should be repeated across pages.
children
The cells and lines within the header.
# footer
A repeatable grid footer.
Just like the `grid.header` element, the footer can repeat itself on every page of the table.
No other grid cells may be placed after the footer.
repeat
Whether this footer should be repeated across pages.
children
The cells and lines within the footer.
# hide
Hides content without affecting layout.
The `hide` function allows you to hide content while the layout still 'sees' it. This is useful to create whitespace that is exactly as large as some content. It may also be useful to redact content because its arguments are not included in the output.
## Example
    
    Hello Jane \
    #hide[Hello] Joe
    
body
The content to hide.
# layout
Provides access to the current outer container's (or page's, if none) dimensions (width and height).
Accepts a function that receives a single parameter, which is a dictionary with keys `width` and `height`, both of type `length`. The function is provided context, meaning you don't need to use it in combination with the `context` keyword. This is why `measure` can be called in the example below.
    
    #let text = lorem(30)
    #layout(size => [
      #let (height,) = measure(
        block(width: size.width, text),
      )
      This text is #height high with
      the current page width: \
      #text
    ])
    
Note that the `layout` function forces its contents into a block-level container, so placement relative to the page or pagebreaks are not possible within it.
If the `layout` call is placed inside a box with a width of `800pt` and a height of `400pt`, then the specified function will be given the argument `(width: 800pt, height: 400pt)`. If it is placed directly into the page, it receives the page's dimensions minus its margins. This is mostly useful in combination with measurement.
You can also use this function to resolve `ratio` to fixed lengths. This might come in handy if you're building your own layout abstractions.
    
    #layout(size => {
      let half = 50% * size.width
      [Half a page is #half wide.]
    })
    
Note that the width or height provided by `layout` will be infinite if the corresponding page dimension is set to `auto`.
func
A function to call with the outer container's size. Its return value is displayed in the document.
The container's size is given as a dictionary with the keys `width` and `height`.
This function is called once for each time the content returned by `layout` appears in the document. This makes it possible to generate content that depends on the dimensions of its container.
# length
A size or distance, possibly expressed with contextual units.
Typst supports the following length units:
  * Points: `72pt`
  * Millimeters: `254mm`
  * Centimeters: `2.54cm`
  * Inches: `1in`
  * Relative to font size: `2.5em`


You can multiply lengths with and divide them by integers and floats.
## Example
    
    #rect(width: 20pt)
    #rect(width: 2em)
    #rect(width: 1in)
    
    #(3em + 5pt).em \
    #(20pt).em \
    #(40em + 2pt).abs \
    #(5em).abs
    
## Fields
  * `abs`: A length with just the absolute component of the current length (that is, excluding the `em` component).
  * `em`: The amount of `em` units in this length, as a float.


# pt
Converts this length to points.
Fails with an error if this length has non-zero `em` units (such as `5em + 2pt` instead of just `2pt`). Use the `abs` field (such as in `(5em + 2pt).abs.pt()`) to ignore the `em` component of the length (thus converting only its absolute component).
# mm
Converts this length to millimeters.
Fails with an error if this length has non-zero `em` units. See the `pt` method for more details.
# cm
Converts this length to centimeters.
Fails with an error if this length has non-zero `em` units. See the `pt` method for more details.
# inches
Converts this length to inches.
Fails with an error if this length has non-zero `em` units. See the `pt` method for more details.
# to-absolute
Resolve this length to an absolute length.
# measure
Measures the layouted size of content.
The `measure` function lets you determine the layouted size of content. By default an infinite space is assumed, so the measured dimensions may not necessarily match the final dimensions of the content. If you want to measure in the current layout dimensions, you can combine `measure` and `layout`.
## Example
The same content can have a different size depending on the context that it is placed into. In the example below, the `#content` is of course bigger when we increase the font size.
    
    #let content = [Hello!]
    #content
    #set text(14pt)
    #content
    
For this reason, you can only measure when context is available.
    
    #let thing(body) = context {
      let size = measure(body)
      [Width of "#body" is #size.width]
    }
    
    #thing[Hey] \
    #thing[Welcome]
    
The measure function returns a dictionary with the entries `width` and `height`, both of type `length`.
width
The width available to layout the content.
Setting this to `auto` indicates infinite available width.
Note that using the `width` and `height` parameters of this function is different from measuring a sized `block` containing the content. In the following example, the former will get the dimensions of the inner content instead of the dimensions of the block.
    
    #context measure(lorem(100), width: 400pt)
    
    #context measure(block(lorem(100), width: 400pt))
    
height
The height available to layout the content.
Setting this to `auto` indicates infinite available height.
content
The content whose size to measure.
# move
Moves content without affecting layout.
The `move` function allows you to move content while the layout still 'sees' it at the original positions. Containers will still be sized as if the content was not moved.
## Example
    
    #rect(inset: 0pt, move(
      dx: 6pt, dy: 6pt,
      rect(
        inset: 8pt,
        fill: white,
        stroke: black,
        [Abra cadabra]
      )
    ))
    
dx
The horizontal displacement of the content.
dy
The vertical displacement of the content.
body
The content to move.
# pad
Adds spacing around content.
The spacing can be specified for each side individually, or for all sides at once by specifying a positional argument.
## Example
    
    #set align(center)
    
    #pad(x: 16pt, image("typing.jpg"))
    _Typing speeds can be
     measured in words per minute._
    
left
The padding at the left side.
top
The padding at the top side.
right
The padding at the right side.
bottom
The padding at the bottom side.
x
A shorthand to set `left` and `right` to the same value.
y
A shorthand to set `top` and `bottom` to the same value.
rest
A shorthand to set all four sides to the same value.
body
The content to pad at the sides.
# page
Layouts its child onto one or multiple pages.
Although this function is primarily used in set rules to affect page properties, it can also be used to explicitly render its argument onto a set of pages of its own.
Pages can be set to use `auto` as their width or height. In this case, the pages will grow to fit their content on the respective axis.
The Guide for Page Setup explains how to use this and related functions to set up a document with many examples.
## Example
    
    #set page("us-letter")
    
    There you go, US friends!
    
paper
A standard paper size to set width and height.
This is just a shorthand for setting `width` and `height` and, as such, cannot be retrieved in a context expression.
width
The width of the page.
    
    #set page(
      width: 3cm,
      margin: (x: 0cm),
    )
    
    #for i in range(3) {
      box(square(width: 1cm))
    }
    
height
The height of the page.
If this is set to `auto`, page breaks can only be triggered manually by inserting a page break. Most examples throughout this documentation use `auto` for the height of the page to dynamically grow and shrink to fit their content.
flipped
Whether the page is flipped into landscape orientation.
    
    #set page(
      "us-business-card",
      flipped: true,
      fill: rgb("f2e5dd"),
    )
    
    #set align(bottom + end)
    #text(14pt)[*Sam H. Richards*] \
    _Procurement Manager_
    
    #set text(10pt)
    17 Main Street \
    New York, NY 10001 \
    +1 555 555 5555
    
margin
The page's margins.
  * `auto`: The margins are set automatically to 2.5/21 times the smaller dimension of the page. This results in 2.5cm margins for an A4 page.
  * A single length: The same margin on all sides.
  * A dictionary: With a dictionary, the margins can be set individually. The dictionary can contain the following keys in order of precedence: 
    * `top`: The top margin.
    * `right`: The right margin.
    * `bottom`: The bottom margin.
    * `left`: The left margin.
    * `inside`: The margin at the inner side of the page (where the binding is).
    * `outside`: The margin at the outer side of the page (opposite to the binding).
    * `x`: The horizontal margins.
    * `y`: The vertical margins.
    * `rest`: The margins on all sides except those for which the dictionary explicitly sets a size.


The values for `left` and `right` are mutually exclusive with the values for `inside` and `outside`.
    
    #set page(
     width: 3cm,
     height: 4cm,
     margin: (x: 8pt, y: 4pt),
    )
    
    #rect(
      width: 100%,
      height: 100%,
      fill: aqua,
    )
    
binding
On which side the pages will be bound.
  * `auto`: Equivalent to `left` if the text direction is left-to-right and `right` if it is right-to-left.
  * `left`: Bound on the left side.
  * `right`: Bound on the right side.


This affects the meaning of the `inside` and `outside` options for margins.
columns
How many columns the page has.
If you need to insert columns into a page or other container, you can also use the `columns` function.
    
    #set page(columns: 2, height: 4.8cm)
    Climate change is one of the most
    pressing issues of our time, with
    the potential to devastate
    communities, ecosystems, and
    economies around the world. It's
    clear that we need to take urgent
    action to reduce our carbon
    emissions and mitigate the impacts
    of a rapidly changing climate.
    
fill
The page's background fill.
Setting this to something non-transparent instructs the printer to color the complete page. If you are considering larger production runs, it may be more environmentally friendly and cost-effective to source pre-dyed pages and not set this property.
When set to `none`, the background becomes transparent. Note that PDF pages will still appear with a (usually white) background in viewers, but they are actually transparent. (If you print them, no color is used for the background.)
The default of `auto` results in `none` for PDF output, and `white` for PNG and SVG.
    
    #set page(fill: rgb("444352"))
    #set text(fill: rgb("fdfdfd"))
    *Dark mode enabled.*
    
numbering
How to number the pages.
If an explicit `footer` (or `header` for top-aligned numbering) is given, the numbering is ignored.
    
    #set page(
      height: 100pt,
      margin: (top: 16pt, bottom: 24pt),
      numbering: "1 / 1",
    )
    
    #lorem(48)
    
supplement
A supplement for the pages.
For page references, this is added before the page number.
    
    #set page(numbering: "1.", supplement: [p.])
    
    = Introduction <intro>
    We are on #ref(<intro>, form: "page")!
    
number-align
The alignment of the page numbering.
If the vertical component is `top`, the numbering is placed into the header and if it is `bottom`, it is placed in the footer. Horizon alignment is forbidden. If an explicit matching `header` or `footer` is given, the numbering is ignored.
    
    #set page(
      margin: (top: 16pt, bottom: 24pt),
      numbering: "1",
      number-align: right,
    )
    
    #lorem(30)
    
header
The page's header. Fills the top margin of each page.
  * Content: Shows the content as the header.
  * `auto`: Shows the page number if a `numbering` is set and `number-align` is `top`.
  * `none`: Suppresses the header.


    
    #set par(justify: true)
    #set page(
      margin: (top: 32pt, bottom: 20pt),
      header: [
        #set text(8pt)
        #smallcaps[Typst Academy]
        #h(1fr) _Exercise Sheet 3_
      ],
    )
    
    #lorem(19)
    
header-ascent
The amount the header is raised into the top margin.
footer
The page's footer. Fills the bottom margin of each page.
  * Content: Shows the content as the footer.
  * `auto`: Shows the page number if a `numbering` is set and `number-align` is `bottom`.
  * `none`: Suppresses the footer.


For just a page number, the `numbering` property typically suffices. If you want to create a custom footer but still display the page number, you can directly access the page counter.
    
    #set par(justify: true)
    #set page(
      height: 100pt,
      margin: 20pt,
      footer: context [
        #set align(right)
        #set text(8pt)
        #counter(page).display(
          "1 of I",
          both: true,
        )
      ]
    )
    
    #lorem(48)
    
footer-descent
The amount the footer is lowered into the bottom margin.
background
Content in the page's background.
This content will be placed behind the page's body. It can be used to place a background image or a watermark.
    
    #set page(background: rotate(24deg,
      text(18pt, fill: rgb("FFCBC4"))[
        *CONFIDENTIAL*
      ]
    ))
    
    = Typst's secret plans
    In the year 2023, we plan to take
    over the world (of typesetting).
    
foreground
Content in the page's foreground.
This content will overlay the page's body.
    
    #set page(foreground: text(24pt)[🥸])
    
    Reviewer 2 has marked our paper
    "Weak Reject" because they did
    not understand our approach...
    
body
The contents of the page(s).
Multiple pages will be created if the content does not fit on a single page. A new page with the page properties prior to the function invocation will be created after the body has been typeset.
# pagebreak
A manual page break.
Must not be used inside any containers.
## Example
    
    The next page contains
    more details on compound theory.
    #pagebreak()
    
    == Compound Theory
    In 1984, the first ...
    
weak
If `true`, the page break is skipped if the current page is already empty.
to
If given, ensures that the next page will be an even/odd page, with an empty page in between if necessary.
    
    #set page(height: 30pt)
    
    First.
    #pagebreak(to: "odd")
    Third.
    
# place
Places content relatively to its parent container.
Placed content can be either overlaid (the default) or floating. Overlaid content is aligned with the parent container according to the given `alignment`, and shown over any other content added so far in the container. Floating content is placed at the top or bottom of the container, displacing other content down or up respectively. In both cases, the content position can be adjusted with `dx` and `dy` offsets without affecting the layout.
The parent can be any container such as a `block`, `box`, `rect`, etc. A top level `place` call will place content directly in the text area of the current page. This can be used for absolute positioning on the page: with a `top + left` `alignment`, the offsets `dx` and `dy` will set the position of the element's top left corner relatively to the top left corner of the text area. For absolute positioning on the full page including margins, you can use `place` in `page.foreground` or `page.background`.
## Examples
    
    #set page(height: 120pt)
    Hello, world!
    
    #rect(
      width: 100%,
      height: 2cm,
      place(horizon + right, square()),
    )
    
    #place(
      top + left,
      dx: -5pt,
      square(size: 5pt, fill: red),
    )
    
## Effect on the position of other elements
Overlaid elements don't take space in the flow of content, but a `place` call inserts an invisible block-level element in the flow. This can affect the layout by breaking the current paragraph. To avoid this, you can wrap the `place` call in a `box` when the call is made in the middle of a paragraph. The alignment and offsets will then be relative to this zero-size box. To make sure it doesn't interfere with spacing, the box should be attached to a word using a word joiner.
For example, the following defines a function for attaching an annotation to the following word:
    
    #let annotate(..args) = {
      box(place(..args))
      sym.wj
      h(0pt, weak: true)
    }
    
    A placed #annotate(square(), dy: 2pt)
    square in my text.
    
The zero-width weak spacing serves to discard spaces between the function call and the next word.
alignment
Relative to which position in the parent container to place the content.
  * If `float` is `false`, then this can be any alignment other than `auto`.
  * If `float` is `true`, then this must be `auto`, `top`, or `bottom`.


When `float` is `false` and no vertical alignment is specified, the content is placed at the current position on the vertical axis.
scope
Relative to which containing scope something is placed.
The parent scope is primarily used with figures and, for this reason, the figure function has a mirrored `scope` parameter. Nonetheless, it can also be more generally useful to break out of the columns. A typical example would be to create a single-column title section in a two-column document.
Note that parent-scoped placement is currently only supported if `float` is `true`. This may change in the future.
    
    #set page(height: 150pt, columns: 2)
    #place(
      top + center,
      scope: "parent",
      float: true,
      rect(width: 80%, fill: aqua),
    )
    
    #lorem(25)
    
float
Whether the placed element has floating layout.
Floating elements are positioned at the top or bottom of the parent container, displacing in-flow content. They are always placed in the in-flow order relative to each other, as well as before any content following a later `place.flush` element.
    
    #set page(height: 150pt)
    #let note(where, body) = place(
      center + where,
      float: true,
      clearance: 6pt,
      rect(body),
    )
    
    #lorem(10)
    #note(bottom)[Bottom 1]
    #note(bottom)[Bottom 2]
    #lorem(40)
    #note(top)[Top]
    #lorem(10)
    
clearance
The spacing between the placed element and other elements in a floating layout.
Has no effect if `float` is `false`.
dx
The horizontal displacement of the placed content.
    
    #set page(height: 100pt)
    #for i in range(16) {
      let amount = i * 4pt
      place(center, dx: amount - 32pt, dy: amount)[A]
    }
    
This does not affect the layout of in-flow content. In other words, the placed content is treated as if it were wrapped in a `move` element.
dy
The vertical displacement of the placed content.
This does not affect the layout of in-flow content. In other words, the placed content is treated as if it were wrapped in a `move` element.
body
The content to place.
# flush
Asks the layout algorithm to place pending floating elements before continuing with the content.
This is useful for preventing floating figures from spilling into the next section.
# ratio
A ratio of a whole.
Written as a number, followed by a percent sign.
## Example
    
    #set align(center)
    #scale(x: 150%)[
      Scaled apart.
    ]
    
# relative
A length in relation to some known length.
This type is a combination of a length with a ratio. It results from addition and subtraction of a length and a ratio. Wherever a relative length is expected, you can also use a bare length or ratio.
## Example
    
    #rect(width: 100% - 50pt)
    
    #(100% - 50pt).length \
    #(100% - 50pt).ratio
    
A relative length has the following fields:
  * `length`: Its length component.
  * `ratio`: Its ratio component.


# repeat
Repeats content to the available space.
This can be useful when implementing a custom index, reference, or outline.
Space may be inserted between the instances of the body parameter, so be sure to adjust the `justify` parameter accordingly.
Errors if there are no bounds on the available space, as it would create infinite content.
## Example
    
    Sign on the dotted line:
    #box(width: 1fr, repeat[.])
    
    #set text(10pt)
    #v(8pt, weak: true)
    #align(right)[
      Berlin, the 22nd of December, 2022
    ]
    
body
The content to repeat.
gap
The gap between each instance of the body.
justify
Whether to increase the gap between instances to completely fill the available space.
# rotate
Rotates content without affecting layout.
Rotates an element by a given angle. The layout will act as if the element was not rotated unless you specify `reflow: true`.
## Example
    
    #stack(
      dir: ltr,
      spacing: 1fr,
      ..range(16)
        .map(i => rotate(24deg * i)[X]),
    )
    
angle
The amount of rotation.
    
    #rotate(-1.571rad)[Space!]
    
origin
The origin of the rotation.
If, for instance, you wanted the bottom left corner of the rotated element to stay aligned with the baseline, you would set it to `bottom + left` instead.
    
    #set text(spacing: 8pt)
    #let square = square.with(width: 8pt)
    
    #box(square())
    #box(rotate(30deg, origin: center, square()))
    #box(rotate(30deg, origin: top + left, square()))
    #box(rotate(30deg, origin: bottom + right, square()))
    
reflow
Whether the rotation impacts the layout.
If set to `false`, the rotated content will retain the bounding box of the original content. If set to `true`, the bounding box will take the rotation of the content into account and adjust the layout accordingly.
    
    Hello #rotate(90deg, reflow: true)[World]!
    
body
The content to rotate.
# scale
Scales content without affecting layout.
Lets you mirror content by specifying a negative scale on a single axis.
## Example
    
    #set align(center)
    #scale(x: -100%)[This is mirrored.]
    #scale(x: -100%, reflow: true)[This is mirrored.]
    
factor
The scaling factor for both axes, as a positional argument. This is just an optional shorthand notation for setting `x` and `y` to the same value.
x
The horizontal scaling factor.
The body will be mirrored horizontally if the parameter is negative.
y
The vertical scaling factor.
The body will be mirrored vertically if the parameter is negative.
origin
The origin of the transformation.
    
    A#box(scale(75%)[A])A \
    B#box(scale(75%, origin: bottom + left)[B])B
    
reflow
Whether the scaling impacts the layout.
If set to `false`, the scaled content will be allowed to overlap other content. If set to `true`, it will compute the new size of the scaled content and adjust the layout accordingly.
    
    Hello #scale(x: 20%, y: 40%, reflow: true)[World]!
    
body
The content to scale.
# skew
Skews content.
Skews an element in horizontal and/or vertical direction. The layout will act as if the element was not skewed unless you specify `reflow: true`.
## Example
    
    #skew(ax: -12deg)[
      This is some fake italic text.
    ]
    
ax
The horizontal skewing angle.
    
    #skew(ax: 30deg)[Skewed]
    
ay
The vertical skewing angle.
    
    #skew(ay: 30deg)[Skewed]
    
origin
The origin of the skew transformation.
The origin will stay fixed during the operation.
    
    X #box(skew(ax: -30deg, origin: center + horizon)[X]) X \
    X #box(skew(ax: -30deg, origin: bottom + left)[X]) X \
    X #box(skew(ax: -30deg, origin: top + right)[X]) X
    
reflow
Whether the skew transformation impacts the layout.
If set to `false`, the skewed content will retain the bounding box of the original content. If set to `true`, the bounding box will take the transformation of the content into account and adjust the layout accordingly.
    
    Hello #skew(ay: 30deg, reflow: true, "World")!
    
body
The content to skew.
# h
Inserts horizontal spacing into a paragraph.
The spacing can be absolute, relative, or fractional. In the last case, the remaining space on the line is distributed among all fractional spacings according to their relative fractions.
## Example
    
    First #h(1cm) Second \
    First #h(30%) Second
    
## Fractional spacing
With fractional spacing, you can align things within a line without forcing a paragraph break (like `align` would). Each fractionally sized element gets space based on the ratio of its fraction to the sum of all fractions.
    
    First #h(1fr) Second \
    First #h(1fr) Second #h(1fr) Third \
    First #h(2fr) Second #h(1fr) Third
    
## Mathematical Spacing
In mathematical formulas, you can additionally use these constants to add spacing between elements: `thin` (1/6 em), `med` (2/9 em), `thick` (5/18 em), `quad` (1 em), `wide` (2 em).
amount
How much spacing to insert.
weak
If `true`, the spacing collapses at the start or end of a paragraph. Moreover, from multiple adjacent weak spacings all but the largest one collapse.
Weak spacing in markup also causes all adjacent markup spaces to be removed, regardless of the amount of spacing inserted. To force a space next to weak spacing, you can explicitly write `#" "` (for a normal space) or `~` (for a non-breaking space). The latter can be useful to create a construct that always attaches to the preceding word with one non-breaking space, independently of whether a markup space existed in front or not.
    
    #h(1cm, weak: true)
    We identified a group of _weak_
    specimens that fail to manifest
    in most cases. However, when
    #h(8pt, weak: true) supported
    #h(8pt, weak: true) on both sides,
    they do show up.
    
    Further #h(0pt, weak: true) more,
    even the smallest of them swallow
    adjacent markup spaces.
    
# v
Inserts vertical spacing into a flow of blocks.
The spacing can be absolute, relative, or fractional. In the last case, the remaining space on the page is distributed among all fractional spacings according to their relative fractions.
## Example
    
    #grid(
      rows: 3cm,
      columns: 6,
      gutter: 1fr,
      [A #parbreak() B],
      [A #v(0pt) B],
      [A #v(10pt) B],
      [A #v(0pt, weak: true) B],
      [A #v(40%, weak: true) B],
      [A #v(1fr) B],
    )
    
amount
How much spacing to insert.
weak
If `true`, the spacing collapses at the start or end of a flow. Moreover, from multiple adjacent weak spacings all but the largest one collapse. Weak spacings will always collapse adjacent paragraph spacing, even if the paragraph spacing is larger.
    
    The following theorem is
    foundational to the field:
    #v(4pt, weak: true)
    $ x^2 + y^2 = r^2 $
    #v(4pt, weak: true)
    The proof is simple:
    
# stack
Arranges content and spacing horizontally or vertically.
The stack places a list of items along an axis, with optional spacing between each item.
## Example
    
    #stack(
      dir: ttb,
      rect(width: 40pt),
      rect(width: 120pt),
      rect(width: 90pt),
    )
    
dir
The direction along which the items are stacked. Possible values are:
  * `ltr`: Left to right.
  * `rtl`: Right to left.
  * `ttb`: Top to bottom.
  * `btt`: Bottom to top.


You can use the `start` and `end` methods to obtain the initial and final points (respectively) of a direction, as `alignment`. You can also use the `axis` method to determine whether a direction is `"horizontal"` or `"vertical"`. The `inv` method returns a direction's inverse direction.
For example, `ttb.start()` is `top`, `ttb.end()` is `bottom`, `ttb.axis()` is `"vertical"` and `ttb.inv()` is equal to `btt`.
spacing
Spacing to insert between items where no explicit spacing was provided.
children
The children to stack along the axis.
# visualize
Drawing and data visualization.
If you want to create more advanced drawings or plots, also have a look at the CetZ package as well as more specialized packages for your use case.
# circle
A circle with optional content.
## Example
    
    // Without content.
    #circle(radius: 25pt)
    
    // With content.
    #circle[
      #set align(center + horizon)
      Automatically \
      sized to fit.
    ]
    
radius
The circle's radius. This is mutually exclusive with `width` and `height`.
width
The circle's width. This is mutually exclusive with `radius` and `height`.
In contrast to `radius`, this can be relative to the parent container's width.
height
The circle's height. This is mutually exclusive with `radius` and `width`.
In contrast to `radius`, this can be relative to the parent container's height.
fill
How to fill the circle. See the rectangle's documentation for more details.
stroke
How to stroke the circle. See the rectangle's documentation for more details.
inset
How much to pad the circle's content. See the box's documentation for more details.
outset
How much to expand the circle's size without affecting the layout. See the box's documentation for more details.
body
The content to place into the circle. The circle expands to fit this content, keeping the 1-1 aspect ratio.
# color
A color in a specific color space.
Typst supports:
  * sRGB through the `rgb` function
  * Device CMYK through `cmyk` function
  * D65 Gray through the `luma` function
  * Oklab through the `oklab` function
  * Oklch through the `oklch` function
  * Linear RGB through the `color.linear-rgb` function
  * HSL through the `color.hsl` function
  * HSV through the `color.hsv` function


## Example
    
    #rect(fill: aqua)
    
## Predefined colors
Typst defines the following built-in colors:
ColorDefinition  
`black``luma(0)`  
`gray``luma(170)`  
`silver``luma(221)`  
`white``luma(255)`  
`navy``rgb("#001f3f")`  
`blue``rgb("#0074d9")`  
`aqua``rgb("#7fdbff")`  
`teal``rgb("#39cccc")`  
`eastern``rgb("#239dad")`  
`purple``rgb("#b10dc9")`  
`fuchsia``rgb("#f012be")`  
`maroon``rgb("#85144b")`  
`red``rgb("#ff4136")`  
`orange``rgb("#ff851b")`  
`yellow``rgb("#ffdc00")`  
`olive``rgb("#3d9970")`  
`green``rgb("#2ecc40")`  
`lime``rgb("#01ff70")`  
The predefined colors and the most important color constructors are available globally and also in the color type's scope, so you can write either `color.red` or just `red`.
## Predefined color maps
Typst also includes a number of preset color maps that can be used for gradients. These are simply arrays of colors defined in the module `color.map`.
    
    #circle(fill: gradient.linear(..color.map.crest))
    
MapDetails  
`turbo`A perceptually uniform rainbow-like color map. Read this blog post for more details.  
`cividis`A blue to gray to yellow color map. See this blog post for more details.  
`rainbow`Cycles through the full color spectrum. This color map is best used by setting the interpolation color space to HSL. The rainbow gradient is not suitable for data visualization because it is not perceptually uniform, so the differences between values become unclear to your readers. It should only be used for decorative purposes.  
`spectral`Red to yellow to blue color map.  
`viridis`A purple to teal to yellow color map.  
`inferno`A black to red to yellow color map.  
`magma`A black to purple to yellow color map.  
`plasma`A purple to pink to yellow color map.  
`rocket`A black to red to white color map.  
`mako`A black to teal to yellow color map.  
`vlag`A light blue to white to red color map.  
`icefire`A light teal to black to yellow color map.  
`flare`A orange to purple color map that is perceptually uniform.  
`crest`A blue to white to red color map.  
Some popular presets are not included because they are not available under a free licence. Others, like Jet, are not included because they are not color blind friendly. Feel free to use or create a package with other presets that are useful to you!
# luma
Create a grayscale color.
A grayscale color is represented internally by a single `lightness` component.
These components are also available using the `components` method.
lightness
The lightness component.
alpha
The alpha component.
color
Alternatively: The color to convert to grayscale.
If this is given, the `lightness` should not be given.
# oklab
Create an Oklab color.
This color space is well suited for the following use cases:
  * Color manipulation such as saturating while keeping perceived hue
  * Creating grayscale images with uniform perceived lightness
  * Creating smooth and uniform color transition and gradients


A linear Oklab color is represented internally by an array of four components:
  * lightness (`ratio`)
  * a (`float` or `ratio`. Ratios are relative to `0.4`; meaning `50%` is equal to `0.2`)
  * b (`float` or `ratio`. Ratios are relative to `0.4`; meaning `50%` is equal to `0.2`)
  * alpha (`ratio`)


These components are also available using the `components` method.
lightness
The lightness component.
a
The a ("green/red") component.
b
The b ("blue/yellow") component.
alpha
The alpha component.
color
Alternatively: The color to convert to Oklab.
If this is given, the individual components should not be given.
# oklch
Create an Oklch color.
This color space is well suited for the following use cases:
  * Color manipulation involving lightness, chroma, and hue
  * Creating grayscale images with uniform perceived lightness
  * Creating smooth and uniform color transition and gradients


A linear Oklch color is represented internally by an array of four components:
  * lightness (`ratio`)
  * chroma (`float` or `ratio`. Ratios are relative to `0.4`; meaning `50%` is equal to `0.2`)
  * hue (`angle`)
  * alpha (`ratio`)


These components are also available using the `components` method.
lightness
The lightness component.
chroma
The chroma component.
hue
The hue component.
alpha
The alpha component.
color
Alternatively: The color to convert to Oklch.
If this is given, the individual components should not be given.
# linear-rgb
Create an RGB(A) color with linear luma.
This color space is similar to sRGB, but with the distinction that the color component are not gamma corrected. This makes it easier to perform color operations such as blending and interpolation. Although, you should prefer to use the `oklab` function for these.
A linear RGB(A) color is represented internally by an array of four components:
  * red (`ratio`)
  * green (`ratio`)
  * blue (`ratio`)
  * alpha (`ratio`)


These components are also available using the `components` method.
red
The red component.
green
The green component.
blue
The blue component.
alpha
The alpha component.
color
Alternatively: The color to convert to linear RGB(A).
If this is given, the individual components should not be given.
# rgb
Create an RGB(A) color.
The color is specified in the sRGB color space.
An RGB(A) color is represented internally by an array of four components:
  * red (`ratio`)
  * green (`ratio`)
  * blue (`ratio`)
  * alpha (`ratio`)


These components are also available using the `components` method.
red
The red component.
green
The green component.
blue
The blue component.
alpha
The alpha component.
hex
Alternatively: The color in hexadecimal notation.
Accepts three, four, six or eight hexadecimal digits and optionally a leading hash.
If this is given, the individual components should not be given.
    
    #text(16pt, rgb("#239dad"))[
      *Typst*
    ]
    
color
Alternatively: The color to convert to RGB(a).
If this is given, the individual components should not be given.
# cmyk
Create a CMYK color.
This is useful if you want to target a specific printer. The conversion to RGB for display preview might differ from how your printer reproduces the color.
A CMYK color is represented internally by an array of four components:
  * cyan (`ratio`)
  * magenta (`ratio`)
  * yellow (`ratio`)
  * key (`ratio`)


These components are also available using the `components` method.
Note that CMYK colors are not currently supported when PDF/A output is enabled.
cyan
The cyan component.
magenta
The magenta component.
yellow
The yellow component.
key
The key component.
color
Alternatively: The color to convert to CMYK.
If this is given, the individual components should not be given.
# hsl
Create an HSL color.
This color space is useful for specifying colors by hue, saturation and lightness. It is also useful for color manipulation, such as saturating while keeping perceived hue.
An HSL color is represented internally by an array of four components:
  * hue (`angle`)
  * saturation (`ratio`)
  * lightness (`ratio`)
  * alpha (`ratio`)


These components are also available using the `components` method.
hue
The hue angle.
saturation
The saturation component.
lightness
The lightness component.
alpha
The alpha component.
color
Alternatively: The color to convert to HSL.
If this is given, the individual components should not be given.
# hsv
Create an HSV color.
This color space is useful for specifying colors by hue, saturation and value. It is also useful for color manipulation, such as saturating while keeping perceived hue.
An HSV color is represented internally by an array of four components:
  * hue (`angle`)
  * saturation (`ratio`)
  * value (`ratio`)
  * alpha (`ratio`)


These components are also available using the `components` method.
hue
The hue angle.
saturation
The saturation component.
value
The value component.
alpha
The alpha component.
color
Alternatively: The color to convert to HSL.
If this is given, the individual components should not be given.
# components
Extracts the components of this color.
The size and values of this array depends on the color space. You can obtain the color space using `space`. Below is a table of the color spaces and their components:
Color spaceC1C2C3C4  
`luma`Lightness  
`oklab`Lightness`a``b`Alpha  
`oklch`LightnessChromaHueAlpha  
`linear-rgb`RedGreenBlueAlpha  
`rgb`RedGreenBlueAlpha  
`cmyk`CyanMagentaYellowKey  
`hsl`HueSaturationLightnessAlpha  
`hsv`HueSaturationValueAlpha  
For the meaning and type of each individual value, see the documentation of the corresponding color space. The alpha component is optional and only included if the `alpha` argument is `true`. The length of the returned array depends on the number of components and whether the alpha component is included.
alpha
Whether to include the alpha component.
# space
Returns the constructor function for this color's space:
  * `luma`
  * `oklab`
  * `oklch`
  * `linear-rgb`
  * `rgb`
  * `cmyk`
  * `hsl`
  * `hsv`


# to-hex
Returns the color's RGB(A) hex representation (such as `#ffaa32` or `#020304fe`). The alpha component (last two digits in `#020304fe`) is omitted if it is equal to `ff` (255 / 100%).
# lighten
Lightens a color by a given factor.
factor
The factor to lighten the color by.
# darken
Darkens a color by a given factor.
factor
The factor to darken the color by.
# saturate
Increases the saturation of a color by a given factor.
factor
The factor to saturate the color by.
# desaturate
Decreases the saturation of a color by a given factor.
factor
The factor to desaturate the color by.
# negate
Produces the complementary color using a provided color space. You can think of it as the opposite side on a color wheel.
space
The color space used for the transformation. By default, a perceptual color space is used.
# rotate
Rotates the hue of the color by a given angle.
angle
The angle to rotate the hue by.
space
The color space used to rotate. By default, this happens in a perceptual color space (`oklch`).
# mix
Create a color by mixing two or more colors.
In color spaces with a hue component (hsl, hsv, oklch), only two colors can be mixed at once. Mixing more than two colors in such a space will result in an error!
colors
The colors, optionally with weights, specified as a pair (array of length two) of color and weight (float or ratio).
The weights do not need to add to `100%`, they are relative to the sum of all weights.
space
The color space to mix in. By default, this happens in a perceptual color space (`oklab`).
# transparentize
Makes a color more transparent by a given factor.
This method is relative to the existing alpha value. If the scale is positive, calculates `alpha - alpha * scale`. Negative scales behave like `color.opacify(-scale)`.
scale
The factor to change the alpha value by.
# opacify
Makes a color more opaque by a given scale.
This method is relative to the existing alpha value. If the scale is positive, calculates `alpha + scale - alpha * scale`. Negative scales behave like `color.transparentize(-scale)`.
scale
The scale to change the alpha value by.
# curve
A curve consisting of movements, lines, and Bézier segments.
At any point in time, there is a conceptual pen or cursor.
  * Move elements move the cursor without drawing.
  * Line/Quadratic/Cubic elements draw a segment from the cursor to a new position, potentially with control point for a Bézier curve.
  * Close elements draw a straight or smooth line back to the start of the curve or the latest preceding move segment.


For layout purposes, the bounding box of the curve is a tight rectangle containing all segments as well as the point `(0pt, 0pt)`.
Positions may be specified absolutely (i.e. relatively to `(0pt, 0pt)`), or relative to the current pen/cursor position, that is, the position where the previous segment ended.
Bézier curve control points can be skipped by passing `none` or automatically mirrored from the preceding segment by passing `auto`.
## Example
    
    #curve(
      fill: blue.lighten(80%),
      stroke: blue,
      curve.move((0pt, 50pt)),
      curve.line((100pt, 50pt)),
      curve.cubic(none, (90pt, 0pt), (50pt, 0pt)),
      curve.close(),
    )
    
fill
How to fill the curve.
When setting a fill, the default stroke disappears. To create a rectangle with both fill and stroke, you have to configure both.
fill-rule
The drawing rule used to fill the curve.
    
    // We use `.with` to get a new
    // function that has the common
    // arguments pre-applied.
    #let star = curve.with(
      fill: red,
      curve.move((25pt, 0pt)),
      curve.line((10pt, 50pt)),
      curve.line((50pt, 20pt)),
      curve.line((0pt, 20pt)),
      curve.line((40pt, 50pt)),
      curve.close(),
    )
    
    #star(fill-rule: "non-zero")
    #star(fill-rule: "even-odd")
    
stroke
How to stroke the curve. This can be:
Can be set to `none` to disable the stroke or to `auto` for a stroke of `1pt` black if and if only if no fill is given.
    
    #let down = curve.line((40pt, 40pt), relative: true)
    #let up = curve.line((40pt, -40pt), relative: true)
    
    #curve(
      stroke: 4pt + gradient.linear(red, blue),
      down, up, down, up, down,
    )
    
components
The components of the curve, in the form of moves, line and Bézier segment, and closes.
# move
Starts a new curve component.
If no `curve.move` element is passed, the curve will start at `(0pt, 0pt)`.
start
The starting point for the new component.
relative
Whether the coordinates are relative to the previous point.
# line
Adds a straight line from the current point to a following one.
end
The point at which the line shall end.
relative
Whether the coordinates are relative to the previous point.
    
    #curve(
      stroke: blue,
      curve.line((50pt, 0pt), relative: true),
      curve.line((0pt, 50pt), relative: true),
      curve.line((50pt, 0pt), relative: true),
      curve.line((0pt, -50pt), relative: true),
      curve.line((50pt, 0pt), relative: true),
    )
    
# quad
Adds a quadratic Bézier curve segment from the last point to `end`, using `control` as the control point.
control
The control point of the quadratic Bézier curve.
  * If `auto` and this segment follows another quadratic Bézier curve, the previous control point will be mirrored.
  * If `none`, the control point defaults to `end`, and the curve will be a straight line.


    
    #curve(
      stroke: 2pt,
      curve.quad((20pt, 40pt), (40pt, 40pt), relative: true),
      curve.quad(auto, (40pt, -40pt), relative: true),
    )
    
end
The point at which the segment shall end.
relative
Whether the `control` and `end` coordinates are relative to the previous point.
# cubic
Adds a cubic Bézier curve segment from the last point to `end`, using `control-start` and `control-end` as the control points.
control-start
The control point going out from the start of the curve segment.
  * If `auto` and this element follows another `curve.cubic` element, the last control point will be mirrored. In SVG terms, this makes `curve.cubic` behave like the `S` operator instead of the `C` operator.
  * If `none`, the curve has no first control point, or equivalently, the control point defaults to the curve's starting point.


    
    #curve(
      stroke: blue,
      curve.move((0pt, 50pt)),
      // - No start control point
      // - End control point at `(20pt, 0pt)`
      // - End point at `(50pt, 0pt)`
      curve.cubic(none, (20pt, 0pt), (50pt, 0pt)),
      // - No start control point
      // - No end control point
      // - End point at `(50pt, 0pt)`
      curve.cubic(none, none, (100pt, 50pt)),
    )
    
    #curve(
      stroke: blue,
      curve.move((0pt, 50pt)),
      curve.cubic(none, (20pt, 0pt), (50pt, 0pt)),
      // Passing `auto` instead of `none` means the start control point
      // mirrors the end control point of the previous curve. Mirror of
      // `(20pt, 0pt)` w.r.t `(50pt, 0pt)` is `(80pt, 0pt)`.
      curve.cubic(auto, none, (100pt, 50pt)),
    )
    
    #curve(
      stroke: blue,
      curve.move((0pt, 50pt)),
      curve.cubic(none, (20pt, 0pt), (50pt, 0pt)),
      // `(80pt, 0pt)` is the same as `auto` in this case.
      curve.cubic((80pt, 0pt), none, (100pt, 50pt)),
    )
    
control-end
The control point going into the end point of the curve segment.
If set to `none`, the curve has no end control point, or equivalently, the control point defaults to the curve's end point.
end
The point at which the curve segment shall end.
relative
Whether the `control-start`, `control-end`, and `end` coordinates are relative to the previous point.
# close
Closes the curve by adding a segment from the last point to the start of the curve (or the last preceding `curve.move` point).
mode
How to close the curve.
# ellipse
An ellipse with optional content.
## Example
    
    // Without content.
    #ellipse(width: 35%, height: 30pt)
    
    // With content.
    #ellipse[
      #set align(center)
      Automatically sized \
      to fit the content.
    ]
    
width
The ellipse's width, relative to its parent container.
height
The ellipse's height, relative to its parent container.
fill
How to fill the ellipse. See the rectangle's documentation for more details.
stroke
How to stroke the ellipse. See the rectangle's documentation for more details.
inset
How much to pad the ellipse's content. See the box's documentation for more details.
outset
How much to expand the ellipse's size without affecting the layout. See the box's documentation for more details.
body
The content to place into the ellipse.
When this is omitted, the ellipse takes on a default size of at most `45pt` by `30pt`.
# gradient
A color gradient.
Typst supports linear gradients through the `gradient.linear` function, radial gradients through the `gradient.radial` function, and conic gradients through the `gradient.conic` function.
A gradient can be used for the following purposes:
  * As a fill to paint the interior of a shape: `rect(fill: gradient.linear(..))`
  * As a stroke to paint the outline of a shape: `rect(stroke: 1pt + gradient.linear(..))`
  * As the fill of text: `set text(fill: gradient.linear(..))`
  * As a color map you can sample from: `gradient.linear(..).sample(50%)`


## Examples
    
    #stack(
      dir: ltr,
      spacing: 1fr,
      square(fill: gradient.linear(..color.map.rainbow)),
      square(fill: gradient.radial(..color.map.rainbow)),
      square(fill: gradient.conic(..color.map.rainbow)),
    )
    
Gradients are also supported on text, but only when setting the relativeness to either `auto` (the default value) or `"parent"`. To create word-by-word or glyph-by-glyph gradients, you can wrap the words or characters of your text in boxes manually or through a show rule.
    
    #set text(fill: gradient.linear(red, blue))
    #let rainbow(content) = {
      set text(fill: gradient.linear(..color.map.rainbow))
      box(content)
    }
    
    This is a gradient on text, but with a #rainbow[twist]!
    
## Stops
A gradient is composed of a series of stops. Each of these stops has a color and an offset. The offset is a ratio between `0%` and `100%` or an angle between `0deg` and `360deg`. The offset is a relative position that determines how far along the gradient the stop is located. The stop's color is the color of the gradient at that position. You can choose to omit the offsets when defining a gradient. In this case, Typst will space all stops evenly.
## Relativeness
The location of the `0%` and `100%` stops depends on the dimensions of a container. This container can either be the shape that it is being painted on, or the closest surrounding container. This is controlled by the `relative` argument of a gradient constructor. By default, gradients are relative to the shape they are being painted on, unless the gradient is applied on text, in which case they are relative to the closest ancestor container.
Typst determines the ancestor container as follows:
  * For shapes that are placed at the root/top level of the document, the closest ancestor is the page itself.
  * For other shapes, the ancestor is the innermost `block` or `box` that contains the shape. This includes the boxes and blocks that are implicitly created by show rules and elements. For example, a `rotate` will not affect the parent of a gradient, but a `grid` will.


## Color spaces and interpolation
Gradients can be interpolated in any color space. By default, gradients are interpolated in the Oklab color space, which is a perceptually uniform color space. This means that the gradient will be perceived as having a smooth progression of colors. This is particularly useful for data visualization.
However, you can choose to interpolate the gradient in any supported color space you want, but beware that some color spaces are not suitable for perceptually interpolating between colors. Consult the table below when choosing an interpolation space.
Color spacePerceptually uniform?  
OklabYes  
OklchYes  
sRGBNo  
linear-RGBYes  
CMYKNo  
GrayscaleYes  
HSLNo  
HSVNo  
## Direction
Some gradients are sensitive to direction. For example, a linear gradient has an angle that determines its direction. Typst uses a clockwise angle, with 0° being from left to right, 90° from top to bottom, 180° from right to left, and 270° from bottom to top.
    
    #stack(
      dir: ltr,
      spacing: 1fr,
      square(fill: gradient.linear(red, blue, angle: 0deg)),
      square(fill: gradient.linear(red, blue, angle: 90deg)),
      square(fill: gradient.linear(red, blue, angle: 180deg)),
      square(fill: gradient.linear(red, blue, angle: 270deg)),
    )
    
## Presets
Typst predefines color maps that you can use with your gradients. See the `color` documentation for more details.
## Note on file sizes
Gradients can be quite large, especially if they have many stops. This is because gradients are stored as a list of colors and offsets, which can take up a lot of space. If you are concerned about file sizes, you should consider the following:
  * SVG gradients are currently inefficiently encoded. This will be improved in the future.
  * PDF gradients in the `color.oklab`, `color.hsv`, `color.hsl`, and `color.oklch` color spaces are stored as a list of `color.rgb` colors with extra stops in between. This avoids needing to encode these color spaces in your PDF file, but it does add extra stops to your gradient, which can increase the file size.


# linear
Creates a new linear gradient, in which colors transition along a straight line.
stops
The color stops of the gradient.
space
The color space in which to interpolate the gradient.
Defaults to a perceptually uniform color space called Oklab.
relative
The relative placement of the gradient.
For an element placed at the root/top level of the document, the parent is the page itself. For other elements, the parent is the innermost block, box, column, grid, or stack that contains the element.
dir
The direction of the gradient.
angle
The angle of the gradient.
# radial
Creates a new radial gradient, in which colors radiate away from an origin.
The gradient is defined by two circles: the focal circle and the end circle. The focal circle is a circle with center `focal-center` and radius `focal-radius`, that defines the points at which the gradient starts and has the color of the first stop. The end circle is a circle with center `center` and radius `radius`, that defines the points at which the gradient ends and has the color of the last stop. The gradient is then interpolated between these two circles.
Using these four values, also called the focal point for the starting circle and the center and radius for the end circle, we can define a gradient with more interesting properties than a basic radial gradient.
stops
The color stops of the gradient.
space
The color space in which to interpolate the gradient.
Defaults to a perceptually uniform color space called Oklab.
relative
The relative placement of the gradient.
For an element placed at the root/top level of the document, the parent is the page itself. For other elements, the parent is the innermost block, box, column, grid, or stack that contains the element.
center
The center of the end circle of the gradient.
A value of `(50%, 50%)` means that the end circle is centered inside of its container.
radius
The radius of the end circle of the gradient.
By default, it is set to `50%`. The ending radius must be bigger than the focal radius.
focal-center
The center of the focal circle of the gradient.
The focal center must be inside of the end circle.
A value of `(50%, 50%)` means that the focal circle is centered inside of its container.
By default it is set to the same as the center of the last circle.
focal-radius
The radius of the focal circle of the gradient.
The focal center must be inside of the end circle.
By default, it is set to `0%`. The focal radius must be smaller than the ending radius`.
# conic
Creates a new conic gradient, in which colors change radially around a center point.
You can control the center point of the gradient by using the `center` argument. By default, the center point is the center of the shape.
stops
The color stops of the gradient.
angle
The angle of the gradient.
space
The color space in which to interpolate the gradient.
Defaults to a perceptually uniform color space called Oklab.
relative
The relative placement of the gradient.
For an element placed at the root/top level of the document, the parent is the page itself. For other elements, the parent is the innermost block, box, column, grid, or stack that contains the element.
center
The center of the last circle of the gradient.
A value of `(50%, 50%)` means that the end circle is centered inside of its container.
# sharp
Creates a sharp version of this gradient.
Sharp gradients have discrete jumps between colors, instead of a smooth transition. They are particularly useful for creating color lists for a preset gradient.
steps
The number of stops in the gradient.
smoothness
How much to smooth the gradient.
# repeat
Repeats this gradient a given number of times, optionally mirroring it at each repetition.
repetitions
The number of times to repeat the gradient.
mirror
Whether to mirror the gradient at each repetition.
# kind
Returns the kind of this gradient.
# stops
Returns the stops of this gradient.
# space
Returns the mixing space of this gradient.
# relative
Returns the relative placement of this gradient.
# angle
Returns the angle of this gradient.
Returns `none` if the gradient is neither linear nor conic.
# center
Returns the center of this gradient.
Returns `none` if the gradient is neither radial nor conic.
# radius
Returns the radius of this gradient.
Returns `none` if the gradient is not radial.
# focal-center
Returns the focal-center of this gradient.
Returns `none` if the gradient is not radial.
# focal-radius
Returns the focal-radius of this gradient.
Returns `none` if the gradient is not radial.
# sample
Sample the gradient at a given position.
The position is either a position along the gradient (a ratio between `0%` and `100%`) or an angle. Any value outside of this range will be clamped.
t
The position at which to sample the gradient.
# samples
Samples the gradient at multiple positions at once and returns the results as an array.
ts
The positions at which to sample the gradient.
# image
A raster or vector graphic.
You can wrap the image in a `figure` to give it a number and caption.
Like most elements, images are block-level by default and thus do not integrate themselves into adjacent paragraphs. To force an image to become inline, put it into a `box`.
## Example
    
    #figure(
      image("molecular.jpg", width: 80%),
      caption: [
        A step in the molecular testing
        pipeline of our lab.
      ],
    )
    
source
A path to an image file or raw bytes making up an image in one of the supported formats.
Bytes can be used to specify raw pixel data in a row-major, left-to-right, top-to-bottom format.
    
    #let original = read("diagram.svg")
    #let changed = original.replace(
      "#2B80FF", // blue
      green.to-hex(),
    )
    
    #image(bytes(original))
    #image(bytes(changed))
    
format
The image's format.
By default, the format is detected automatically. Typically, you thus only need to specify this when providing raw bytes as the `source` (even then, Typst will try to figure out the format automatically, but that's not always possible).
Supported formats are `"png"`, `"jpg"`, `"gif"`, `"svg"` as well as raw pixel data. Embedding PDFs as images is not currently supported.
When providing raw pixel data as the `source`, you must specify a dictionary with the following keys as the `format`:
  * `encoding` (str): The encoding of the pixel data. One of: 
    * `"rgb8"` (three 8-bit channels: red, green, blue)
    * `"rgba8"` (four 8-bit channels: red, green, blue, alpha)
    * `"luma8"` (one 8-bit channel)
    * `"lumaa8"` (two 8-bit channels: luma and alpha)
  * `width` (int): The pixel width of the image.
  * `height` (int): The pixel height of the image.


The pixel width multiplied by the height multiplied by the channel count for the specified encoding must then match the `source` data.
    
    #image(
      read(
        "tetrahedron.svg",
        encoding: none,
      ),
      format: "svg",
      width: 2cm,
    )
    
    #image(
      bytes(range(16).map(x => x * 16)),
      format: (
        encoding: "luma8",
        width: 4,
        height: 4,
      ),
      width: 2cm,
    )
    
width
The width of the image.
height
The height of the image.
alt
A text describing the image.
fit
How the image should adjust itself to a given area (the area is defined by the `width` and `height` fields). Note that `fit` doesn't visually change anything if the area's aspect ratio is the same as the image's one.
    
    #set page(width: 300pt, height: 50pt, margin: 10pt)
    #image("tiger.jpg", width: 100%, fit: "cover")
    #image("tiger.jpg", width: 100%, fit: "contain")
    #image("tiger.jpg", width: 100%, fit: "stretch")
    
scaling
A hint to viewers how they should scale the image.
When set to `auto`, the default is left up to the viewer. For PNG export, Typst will default to smooth scaling, like most PDF and SVG viewers.
Note: The exact look may differ across PDF viewers.
icc
An ICC profile for the image.
ICC profiles define how to interpret the colors in an image. When set to `auto`, Typst will try to extract an ICC profile from the image.
# decode
Decode a raster or vector graphic from bytes or a string.
data
The data to decode as an image. Can be a string for SVGs.
format
The image's format. Detected automatically by default.
width
The width of the image.
height
The height of the image.
alt
A text describing the image.
fit
How the image should adjust itself to a given area.
scaling
A hint to viewers how they should scale the image.
# line
A line from one point to another.
## Example
    
    #set page(height: 100pt)
    
    #line(length: 100%)
    #line(end: (50%, 50%))
    #line(
      length: 4cm,
      stroke: 2pt + maroon,
    )
    
start
The start point of the line.
Must be an array of exactly two relative lengths.
end
The point where the line ends.
length
The line's length. This is only respected if `end` is `none`.
angle
The angle at which the line points away from the origin. This is only respected if `end` is `none`.
stroke
How to stroke the line.
    
    #set line(length: 100%)
    #stack(
      spacing: 1em,
      line(stroke: 2pt + red),
      line(stroke: (paint: blue, thickness: 4pt, cap: "round")),
      line(stroke: (paint: blue, thickness: 1pt, dash: "dashed")),
      line(stroke: (paint: blue, thickness: 1pt, dash: ("dot", 2pt, 4pt, 2pt))),
    )
    
# path
A path through a list of points, connected by Bézier curves.
## Example
    
    #path(
      fill: blue.lighten(80%),
      stroke: blue,
      closed: true,
      (0pt, 50pt),
      (100%, 50pt),
      ((50%, 0pt), (40pt, 0pt)),
    )
    
fill
How to fill the path.
When setting a fill, the default stroke disappears. To create a rectangle with both fill and stroke, you have to configure both.
fill-rule
The drawing rule used to fill the path.
    
    // We use `.with` to get a new
    // function that has the common
    // arguments pre-applied.
    #let star = path.with(
      fill: red,
      closed: true,
      (25pt, 0pt),
      (10pt, 50pt),
      (50pt, 20pt),
      (0pt, 20pt),
      (40pt, 50pt),
    )
    
    #star(fill-rule: "non-zero")
    #star(fill-rule: "even-odd")
    
stroke
How to stroke the path. This can be:
Can be set to `none` to disable the stroke or to `auto` for a stroke of `1pt` black if and if only if no fill is given.
closed
Whether to close this path with one last Bézier curve. This curve will take into account the adjacent control points. If you want to close with a straight line, simply add one last point that's the same as the start point.
vertices
The vertices of the path.
Each vertex can be defined in 3 ways:
  * A regular point, as given to the `line` or `polygon` function.
  * An array of two points, the first being the vertex and the second being the control point. The control point is expressed relative to the vertex and is mirrored to get the second control point. The given control point is the one that affects the curve coming into this vertex (even for the first point). The mirrored control point affects the curve going out of this vertex.
  * An array of three points, the first being the vertex and the next being the control points (control point for curves coming in and out, respectively).


# polygon
A closed polygon.
The polygon is defined by its corner points and is closed automatically.
## Example
    
    #polygon(
      fill: blue.lighten(80%),
      stroke: blue,
      (20%, 0pt),
      (60%, 0pt),
      (80%, 2cm),
      (0%,  2cm),
    )
    
fill
How to fill the polygon.
When setting a fill, the default stroke disappears. To create a rectangle with both fill and stroke, you have to configure both.
fill-rule
The drawing rule used to fill the polygon.
See the curve documentation for an example.
stroke
How to stroke the polygon. This can be:
Can be set to `none` to disable the stroke or to `auto` for a stroke of `1pt` black if and if only if no fill is given.
vertices
The vertices of the polygon. Each point is specified as an array of two relative lengths.
# regular
A regular polygon, defined by its size and number of vertices.
fill
How to fill the polygon. See the general polygon's documentation for more details.
stroke
How to stroke the polygon. See the general polygon's documentation for more details.
size
The diameter of the circumcircle of the regular polygon.
vertices
The number of vertices in the polygon.
# rect
A rectangle with optional content.
## Example
    
    // Without content.
    #rect(width: 35%, height: 30pt)
    
    // With content.
    #rect[
      Automatically sized \
      to fit the content.
    ]
    
width
The rectangle's width, relative to its parent container.
height
The rectangle's height, relative to its parent container.
fill
How to fill the rectangle.
When setting a fill, the default stroke disappears. To create a rectangle with both fill and stroke, you have to configure both.
    
    #rect(fill: blue)
    
stroke
How to stroke the rectangle. This can be:
  * `none` to disable stroking
  * `auto` for a stroke of `1pt + black` if and if only if no fill is given.
  * Any kind of stroke
  * A dictionary describing the stroke for each side individually. The dictionary can contain the following keys in order of precedence: 
    * `top`: The top stroke.
    * `right`: The right stroke.
    * `bottom`: The bottom stroke.
    * `left`: The left stroke.
    * `x`: The horizontal stroke.
    * `y`: The vertical stroke.
    * `rest`: The stroke on all sides except those for which the dictionary explicitly sets a size.


    
    #stack(
      dir: ltr,
      spacing: 1fr,
      rect(stroke: red),
      rect(stroke: 2pt),
      rect(stroke: 2pt + red),
    )
    
radius
How much to round the rectangle's corners, relative to the minimum of the width and height divided by two. This can be:
  * A relative length for a uniform corner radius.
  * A dictionary: With a dictionary, the stroke for each side can be set individually. The dictionary can contain the following keys in order of precedence: 
    * `top-left`: The top-left corner radius.
    * `top-right`: The top-right corner radius.
    * `bottom-right`: The bottom-right corner radius.
    * `bottom-left`: The bottom-left corner radius.
    * `left`: The top-left and bottom-left corner radii.
    * `top`: The top-left and top-right corner radii.
    * `right`: The top-right and bottom-right corner radii.
    * `bottom`: The bottom-left and bottom-right corner radii.
    * `rest`: The radii for all corners except those for which the dictionary explicitly sets a size.


    
    #set rect(stroke: 4pt)
    #rect(
      radius: (
        left: 5pt,
        top-right: 20pt,
        bottom-right: 10pt,
      ),
      stroke: (
        left: red,
        top: yellow,
        right: green,
        bottom: blue,
      ),
    )
    
inset
How much to pad the rectangle's content. See the box's documentation for more details.
outset
How much to expand the rectangle's size without affecting the layout. See the box's documentation for more details.
body
The content to place into the rectangle.
When this is omitted, the rectangle takes on a default size of at most `45pt` by `30pt`.
# square
A square with optional content.
## Example
    
    // Without content.
    #square(size: 40pt)
    
    // With content.
    #square[
      Automatically \
      sized to fit.
    ]
    
size
The square's side length. This is mutually exclusive with `width` and `height`.
width
The square's width. This is mutually exclusive with `size` and `height`.
In contrast to `size`, this can be relative to the parent container's width.
height
The square's height. This is mutually exclusive with `size` and `width`.
In contrast to `size`, this can be relative to the parent container's height.
fill
How to fill the square. See the rectangle's documentation for more details.
stroke
How to stroke the square. See the rectangle's documentation for more details.
radius
How much to round the square's corners. See the rectangle's documentation for more details.
inset
How much to pad the square's content. See the box's documentation for more details.
outset
How much to expand the square's size without affecting the layout. See the box's documentation for more details.
body
The content to place into the square. The square expands to fit this content, keeping the 1-1 aspect ratio.
When this is omitted, the square takes on a default size of at most `30pt`.
# stroke
Defines how to draw a line.
A stroke has a paint (a solid color or gradient), a thickness, a line cap, a line join, a miter limit, and a dash pattern. All of these values are optional and have sensible defaults.
## Example
    
    #set line(length: 100%)
    #stack(
      spacing: 1em,
      line(stroke: 2pt + red),
      line(stroke: (paint: blue, thickness: 4pt, cap: "round")),
      line(stroke: (paint: blue, thickness: 1pt, dash: "dashed")),
      line(stroke: 2pt + gradient.linear(..color.map.rainbow)),
    )
    
## Simple strokes
You can create a simple solid stroke from a color, a thickness, or a combination of the two. Specifically, wherever a stroke is expected you can pass any of the following values:
  * A length specifying the stroke's thickness. The color is inherited, defaulting to black.
  * A color to use for the stroke. The thickness is inherited, defaulting to `1pt`.
  * A stroke combined from color and thickness using the `+` operator as in `2pt + red`.


For full control, you can also provide a dictionary or a `stroke` object to any function that expects a stroke. The dictionary's keys may include any of the parameters for the constructor function, shown below.
## Fields
On a stroke object, you can access any of the fields listed in the constructor function. For example, `(2pt + blue).thickness` is `2pt`. Meanwhile, `stroke(red).cap` is `auto` because it's unspecified. Fields set to `auto` are inherited.
# stroke
Converts a value to a stroke or constructs a stroke with the given parameters.
Note that in most cases you do not need to convert values to strokes in order to use them, as they will be converted automatically. However, this constructor can be useful to ensure a value has all the fields of a stroke.
paint
The color or gradient to use for the stroke.
If set to `auto`, the value is inherited, defaulting to `black`.
thickness
The stroke's thickness.
If set to `auto`, the value is inherited, defaulting to `1pt`.
cap
How the ends of the stroke are rendered.
If set to `auto`, the value is inherited, defaulting to `"butt"`.
join
How sharp turns are rendered.
If set to `auto`, the value is inherited, defaulting to `"miter"`.
dash
The dash pattern to use. This can be:
  * One of the predefined patterns: 
    * `"solid"` or `none`
    * `"dotted"`
    * `"densely-dotted"`
    * `"loosely-dotted"`
    * `"dashed"`
    * `"densely-dashed"`
    * `"loosely-dashed"`
    * `"dash-dotted"`
    * `"densely-dash-dotted"`
    * `"loosely-dash-dotted"`
  * An array with alternating lengths for dashes and gaps. You can also use the string `"dot"` for a length equal to the line thickness.
  * A dictionary with the keys `array` (same as the array above), and `phase` (of type length), which defines where in the pattern to start drawing.


If set to `auto`, the value is inherited, defaulting to `none`.
    
    #set line(length: 100%, stroke: 2pt)
    #stack(
      spacing: 1em,
      line(stroke: (dash: "dashed")),
      line(stroke: (dash: (10pt, 5pt, "dot", 5pt))),
      line(stroke: (dash: (array: (10pt, 5pt, "dot", 5pt), phase: 10pt))),
    )
    
miter-limit
Number at which protruding sharp bends are rendered with a bevel instead or a miter join. The higher the number, the sharper an angle can be before it is bevelled. Only applicable if `join` is `"miter"`.
Specifically, the miter limit is the maximum ratio between the corner's protrusion length and the stroke's thickness.
If set to `auto`, the value is inherited, defaulting to `4.0`.
    
    #let items = (
      curve.move((15pt, 0pt)),
      curve.line((0pt, 30pt)),
      curve.line((30pt, 30pt)),
      curve.line((10pt, 20pt)),
    )
    
    #set curve(stroke: 6pt + blue)
    #stack(
      dir: ltr,
      spacing: 1cm,
      curve(stroke: (miter-limit: 1), ..items),
      curve(stroke: (miter-limit: 4), ..items),
      curve(stroke: (miter-limit: 5), ..items),
    )
    
# tiling
A repeating tiling fill.
Typst supports the most common type of tilings, where a pattern is repeated in a grid-like fashion, covering the entire area of an element that is filled or stroked. The pattern is defined by a tile size and a body defining the content of each cell. You can also add horizontal or vertical spacing between the cells of the tiling.
## Examples
    
    #let pat = tiling(size: (30pt, 30pt))[
      #place(line(start: (0%, 0%), end: (100%, 100%)))
      #place(line(start: (0%, 100%), end: (100%, 0%)))
    ]
    
    #rect(fill: pat, width: 100%, height: 60pt, stroke: 1pt)
    
Tilings are also supported on text, but only when setting the relativeness to either `auto` (the default value) or `"parent"`. To create word-by-word or glyph-by-glyph tilings, you can wrap the words or characters of your text in boxes manually or through a show rule.
    
    #let pat = tiling(
      size: (30pt, 30pt),
      relative: "parent",
      square(
        size: 30pt,
        fill: gradient
          .conic(..color.map.rainbow),
      )
    )
    
    #set text(fill: pat)
    #lorem(10)
    
You can also space the elements further or closer apart using the `spacing` feature of the tiling. If the spacing is lower than the size of the tiling, the tiling will overlap. If it is higher, the tiling will have gaps of the same color as the background of the tiling.
    
    #let pat = tiling(
      size: (30pt, 30pt),
      spacing: (10pt, 10pt),
      relative: "parent",
      square(
        size: 30pt,
        fill: gradient
         .conic(..color.map.rainbow),
      ),
    )
    
    #rect(
      width: 100%,
      height: 60pt,
      fill: pat,
    )
    
## Relativeness
The location of the starting point of the tiling is dependent on the dimensions of a container. This container can either be the shape that it is being painted on, or the closest surrounding container. This is controlled by the `relative` argument of a tiling constructor. By default, tilings are relative to the shape they are being painted on, unless the tiling is applied on text, in which case they are relative to the closest ancestor container.
Typst determines the ancestor container as follows:
  * For shapes that are placed at the root/top level of the document, the closest ancestor is the page itself.
  * For other shapes, the ancestor is the innermost `block` or `box` that contains the shape. This includes the boxes and blocks that are implicitly created by show rules and elements. For example, a `rotate` will not affect the parent of a gradient, but a `grid` will.


## Compatibility
This type used to be called `pattern`. The name remains as an alias, but is deprecated since Typst 0.13.
# tiling
Construct a new tiling.
size
The bounding box of each cell of the tiling.
spacing
The spacing between cells of the tiling.
relative
The relative placement of the tiling.
For an element placed at the root/top level of the document, the parent is the page itself. For other elements, the parent is the innermost block, box, column, grid, or stack that contains the element.
body
The content of each cell of the tiling.
# introspection
Interactions between document parts.
This category is home to Typst's introspection capabilities: With the `counter` function, you can access and manipulate page, section, figure, and equation counters or create custom ones. Meanwhile, the `query` function lets you search for elements in the document to construct things like a list of figures or headers which show the current chapter title.
Most of the functions are contextual. It is recommended to read the chapter on context before continuing here.
# counter
Counts through pages, elements, and more.
With the counter function, you can access and modify counters for pages, headings, figures, and more. Moreover, you can define custom counters for other things you want to count.
Since counters change throughout the course of the document, their current value is contextual. It is recommended to read the chapter on context before continuing here.
## Accessing a counter
To access the raw value of a counter, we can use the `get` function. This function returns an array: Counters can have multiple levels (in the case of headings for sections, subsections, and so on), and each item in the array corresponds to one level.
    
    #set heading(numbering: "1.")
    
    = Introduction
    Raw value of heading counter is
    #context counter(heading).get()
    
## Displaying a counter
Often, we want to display the value of a counter in a more human-readable way. To do that, we can call the `display` function on the counter. This function retrieves the current counter value and formats it either with a provided or with an automatically inferred numbering.
    
    #set heading(numbering: "1.")
    
    = Introduction
    Some text here.
    
    = Background
    The current value is: #context {
      counter(heading).display()
    }
    
    Or in roman numerals: #context {
      counter(heading).display("I")
    }
    
## Modifying a counter
To modify a counter, you can use the `step` and `update` methods:
  * The `step` method increases the value of the counter by one. Because counters can have multiple levels , it optionally takes a `level` argument. If given, the counter steps at the given depth.
  * The `update` method allows you to arbitrarily modify the counter. In its basic form, you give it an integer (or an array for multiple levels). For more flexibility, you can instead also give it a function that receives the current value and returns a new value.


The heading counter is stepped before the heading is displayed, so `Analysis` gets the number seven even though the counter is at six after the second update.
    
    #set heading(numbering: "1.")
    
    = Introduction
    #counter(heading).step()
    
    = Background
    #counter(heading).update(3)
    #counter(heading).update(n => n * 2)
    
    = Analysis
    Let's skip 7.1.
    #counter(heading).step(level: 2)
    
    == Analysis
    Still at #context {
      counter(heading).display()
    }
    
## Page counter
The page counter is special. It is automatically stepped at each pagebreak. But like other counters, you can also step it manually. For example, you could have Roman page numbers for your preface, then switch to Arabic page numbers for your main content and reset the page counter to one.
    
    #set page(numbering: "(i)")
    
    = Preface
    The preface is numbered with
    roman numerals.
    
    #set page(numbering: "1 / 1")
    #counter(page).update(1)
    
    = Main text
    Here, the counter is reset to one.
    We also display both the current
    page and total number of pages in
    Arabic numbers.
    
## Custom counters
To define your own counter, call the `counter` function with a string as a key. This key identifies the counter globally.
    
    #let mine = counter("mycounter")
    #context mine.display() \
    #mine.step()
    #context mine.display() \
    #mine.update(c => c * 3)
    #context mine.display()
    
## How to step
When you define and use a custom counter, in general, you should first step the counter and then display it. This way, the stepping behaviour of a counter can depend on the element it is stepped for. If you were writing a counter for, let's say, theorems, your theorem's definition would thus first include the counter step and only then display the counter and the theorem's contents.
    
    #let c = counter("theorem")
    #let theorem(it) = block[
      #c.step()
      *Theorem #context c.display():*
      #it
    ]
    
    #theorem[$1 = 1$]
    #theorem[$2 < 3$]
    
The rationale behind this is best explained on the example of the heading counter: An update to the heading counter depends on the heading's level. By stepping directly before the heading, we can correctly step from `1` to `1.1` when encountering a level 2 heading. If we were to step after the heading, we wouldn't know what to step to.
Because counters should always be stepped before the elements they count, they always start at zero. This way, they are at one for the first display (which happens after the first step).
## Time travel
Counters can travel through time! You can find out the final value of the counter before it is reached and even determine what the value was at any particular location in the document.
    
    #let mine = counter("mycounter")
    
    = Values
    #context [
      Value here: #mine.get() \
      At intro: #mine.at(<intro>) \
      Final value: #mine.final()
    ]
    
    #mine.update(n => n + 3)
    
    = Introduction <intro>
    #lorem(10)
    
    #mine.step()
    #mine.step()
    
## Other kinds of state
The `counter` type is closely related to state type. Read its documentation for more details on state management in Typst and why it doesn't just use normal variables for counters.
# counter
Create a new counter identified by a key.
key
The key that identifies this counter.
  * If it is a string, creates a custom counter that is only affected by manual updates,
  * If it is the `page` function, counts through pages,
  * If it is a selector, counts through elements that matches with the selector. For example, 
    * provide an element function: counts elements of that type,
    * provide a `<label>`: counts elements with that label.


# get
Retrieves the value of the counter at the current location. Always returns an array of integers, even if the counter has just one number.
This is equivalent to `counter.at(here())`.
# display
Displays the current value of the counter with a numbering and returns the formatted output.
numbering
A numbering pattern or a function, which specifies how to display the counter. If given a function, that function receives each number of the counter as a separate argument. If the amount of numbers varies, e.g. for the heading argument, you can use an argument sink.
If this is omitted or set to `auto`, displays the counter with the numbering style for the counted element or with the pattern `"1.1"` if no such style exists.
both
If enabled, displays the current and final top-level count together. Both can be styled through a single numbering pattern. This is used by the page numbering property to display the current and total number of pages when a pattern like `"1 / 1"` is given.
# at
Retrieves the value of the counter at the given location. Always returns an array of integers, even if the counter has just one number.
The `selector` must match exactly one element in the document. The most useful kinds of selectors for this are labels and locations.
selector
The place at which the counter's value should be retrieved.
# final
Retrieves the value of the counter at the end of the document. Always returns an array of integers, even if the counter has just one number.
# step
Increases the value of the counter by one.
The update will be in effect at the position where the returned content is inserted into the document. If you don't put the output into the document, nothing happens! This would be the case, for example, if you write `let _ = counter(page).step()`. Counter updates are always applied in layout order and in that case, Typst wouldn't know when to step the counter.
level
The depth at which to step the counter. Defaults to `1`.
# update
Updates the value of the counter.
Just like with `step`, the update only occurs if you put the resulting content into the document.
update
If given an integer or array of integers, sets the counter to that value. If given a function, that function receives the previous counter value (with each number as a separate argument) and has to return the new value (integer or array).
# here
Provides the current location in the document.
You can think of `here` as a low-level building block that directly extracts the current location from the active context. Some other functions use it internally: For instance, `counter.get()` is equivalent to `counter.at(here())`.
Within show rules on locatable elements, `here()` will match the location of the shown element.
If you want to display the current page number, refer to the documentation of the `counter` type. While `here` can be used to determine the physical page number, typically you want the logical page number that may, for instance, have been reset after a preface.
## Examples
Determining the current position in the document in combination with the `position` method:
    
    #context [
      I am located at
      #here().position()
    ]
    
Running a query for elements before the current position:
    
    = Introduction
    = Background
    
    There are
    #context query(
      selector(heading).before(here())
    ).len()
    headings before me.
    
    = Conclusion
    
Refer to the `selector` type for more details on before/after selectors.
# locate
Determines the location of an element in the document.
Takes a selector that must match exactly one element and returns that element's `location`. This location can, in particular, be used to retrieve the physical `page` number and `position` (page, x, y) for that element.
## Examples
Locating a specific element:
    
    #context [
      Introduction is at: \
      #locate(<intro>).position()
    ]
    
    = Introduction <intro>
    
selector
A selector that should match exactly one element. This element will be located.
Especially useful in combination with
  * `here` to locate the current context,
  * a `location` retrieved from some queried element via the `location()` method on content.


# location
Identifies an element in the document.
A location uniquely identifies an element in the document and lets you access its absolute position on the pages. You can retrieve the current location with the `here` function and the location of a queried or shown element with the `location()` method on content.
## Locatable elements
Currently, only a subset of element functions is locatable. Aside from headings and figures, this includes equations, references, quotes and all elements with an explicit label. As a result, you can query for e.g. `strong` elements, but you will find only those that have an explicit label attached to them. This limitation will be resolved in the future.
# page
Returns the page number for this location.
Note that this does not return the value of the page counter at this location, but the true page number (starting from one).
If you want to know the value of the page counter, use `counter(page).at(loc)` instead.
Can be used with `here` to retrieve the physical page position of the current context:
# position
Returns a dictionary with the page number and the x, y position for this location. The page number starts at one and the coordinates are measured from the top-left of the page.
If you only need the page number, use `page()` instead as it allows Typst to skip unnecessary work.
# page-numbering
Returns the page numbering pattern of the page at this location. This can be used when displaying the page counter in order to obtain the local numbering. This is useful if you are building custom indices or outlines.
If the page numbering is set to `none` at that location, this function returns `none`.
# metadata
Exposes a value to the query system without producing visible content.
This element can be retrieved with the `query` function and from the command line with `typst query`. Its purpose is to expose an arbitrary value to the introspection system. To identify a metadata value among others, you can attach a `label` to it and query for that label.
The `metadata` element is especially useful for command line queries because it allows you to expose arbitrary values to the outside world.
    
    // Put metadata somewhere.
    #metadata("This is a note") <note>
    
    // And find it from anywhere else.
    #context {
      query(<note>).first().value
    }
    
value
The value to embed into the document.
# query
Finds elements in the document.
The `query` functions lets you search your document for elements of a particular type or with a particular label. To use it, you first need to ensure that context is available.
## Finding elements
In the example below, we manually create a table of contents instead of using the `outline` function.
To do this, we first query for all headings in the document at level 1 and where `outlined` is true. Querying only for headings at level 1 ensures that, for the purpose of this example, sub-headings are not included in the table of contents. The `outlined` field is used to exclude the "Table of Contents" heading itself.
Note that we open a `context` to be able to use the `query` function.
    
    #set page(numbering: "1")
    
    #heading(outlined: false)[
      Table of Contents
    ]
    #context {
      let chapters = query(
        heading.where(
          level: 1,
          outlined: true,
        )
      )
      for chapter in chapters {
        let loc = chapter.location()
        let nr = numbering(
          loc.page-numbering(),
          ..counter(page).at(loc),
        )
        [#chapter.body #h(1fr) #nr \ ]
      }
    }
    
    = Introduction
    #lorem(10)
    #pagebreak()
    
    == Sub-Heading
    #lorem(8)
    
    = Discussion
    #lorem(18)
    
To get the page numbers, we first get the location of the elements returned by `query` with `location`. We then also retrieve the page numbering and page counter at that location and apply the numbering to the counter.
## A word of caution
To resolve all your queries, Typst evaluates and layouts parts of the document multiple times. However, there is no guarantee that your queries can actually be completely resolved. If you aren't careful a query can affect itself—leading to a result that never stabilizes.
In the example below, we query for all headings in the document. We then generate as many headings. In the beginning, there's just one heading, titled `Real`. Thus, `count` is `1` and one `Fake` heading is generated. Typst sees that the query's result has changed and processes it again. This time, `count` is `2` and two `Fake` headings are generated. This goes on and on. As we can see, the output has a finite amount of headings. This is because Typst simply gives up after a few attempts.
In general, you should try not to write queries that affect themselves. The same words of caution also apply to other introspection features like counters and state.
    
    = Real
    #context {
      let elems = query(heading)
      let count = elems.len()
      count * [= Fake]
    }
    
## Command line queries
You can also perform queries from the command line with the `typst query` command. This command executes an arbitrary query on the document and returns the resulting elements in serialized form. Consider the following `example.typ` file which contains some invisible metadata:
    
    #metadata("This is a note") <note>
    
You can execute a query on it as follows using Typst's CLI:
    
    $ typst query example.typ "<note>"
    [
      {
        "func": "metadata",
        "value": "This is a note",
        "label": "<note>"
      }
    ]
    
Frequently, you're interested in only one specific field of the resulting elements. In the case of the `metadata` element, the `value` field is the interesting one. You can extract just this field with the `--field` argument.
    
    $ typst query example.typ "<note>" --field value
    ["This is a note"]
    
If you are interested in just a single element, you can use the `--one` flag to extract just it.
    
    $ typst query example.typ "<note>" --field value --one
    "This is a note"
    
target
Can be
  * an element function like a `heading` or `figure`,
  * a `<label>`,
  * a more complex selector like `heading.where(level: 1)`,
  * or `selector(heading).before(here())`.


Only locatable element functions are supported.
# state
Manages stateful parts of your document.
Let's say you have some computations in your document and want to remember the result of your last computation to use it in the next one. You might try something similar to the code below and expect it to output 10, 13, 26, and 21\. However this does not work in Typst. If you test this code, you will see that Typst complains with the following error message: Variables from outside the function are read-only and cannot be modified.
    
    // This doesn't work!
    #let x = 0
    #let compute(expr) = {
      x = eval(
        expr.replace("x", str(x))
      )
      [New value is #x. ]
    }
    
    #compute("10") \
    #compute("x + 3") \
    #compute("x * 2") \
    #compute("x - 5")
    
## State and document markup
Why does it do that? Because, in general, this kind of computation with side effects is problematic in document markup and Typst is upfront about that. For the results to make sense, the computation must proceed in the same order in which the results will be laid out in the document. In our simple example, that's the case, but in general it might not be.
Let's look at a slightly different, but similar kind of state: The heading numbering. We want to increase the heading counter at each heading. Easy enough, right? Just add one. Well, it's not that simple. Consider the following example:
    
    #set heading(numbering: "1.")
    #let template(body) = [
      = Outline
      ...
      #body
    ]
    
    #show: template
    
    = Introduction
    ...
    
Here, Typst first processes the body of the document after the show rule, sees the `Introduction` heading, then passes the resulting content to the `template` function and only then sees the `Outline`. Just counting up would number the `Introduction` with `1` and the `Outline` with `2`.
## Managing state in Typst
So what do we do instead? We use Typst's state management system. Calling the `state` function with an identifying string key and an optional initial value gives you a state value which exposes a few functions. The two most important ones are `get` and `update`:
  * The `get` function retrieves the current value of the state. Because the value can vary over the course of the document, it is a contextual function that can only be used when context is available.
  * The `update` function modifies the state. You can give it any value. If given a non-function value, it sets the state to that value. If given a function, that function receives the previous state and has to return the new state.


Our initial example would now look like this:
    
    #let s = state("x", 0)
    #let compute(expr) = [
      #s.update(x =>
        eval(expr.replace("x", str(x)))
      )
      New value is #context s.get().
    ]
    
    #compute("10") \
    #compute("x + 3") \
    #compute("x * 2") \
    #compute("x - 5")
    
State managed by Typst is always updated in layout order, not in evaluation order. The `update` method returns content and its effect occurs at the position where the returned content is inserted into the document.
As a result, we can now also store some of the computations in variables, but they still show the correct results:
    
    ...
    
    #let more = [
      #compute("x * 2") \
      #compute("x - 5")
    ]
    
    #compute("10") \
    #compute("x + 3") \
    #more
    
This example is of course a bit silly, but in practice this is often exactly what you want! A good example are heading counters, which is why Typst's counting system is very similar to its state system.
## Time Travel
By using Typst's state management system you also get time travel capabilities! We can find out what the value of the state will be at any position in the document from anywhere else. In particular, the `at` method gives us the value of the state at any particular location and the `final` methods gives us the value of the state at the end of the document.
    
    ...
    
    Value at `<here>` is
    #context s.at(<here>)
    
    #compute("10") \
    #compute("x + 3") \
    *Here.* <here> \
    #compute("x * 2") \
    #compute("x - 5")
    
## A word of caution
To resolve the values of all states, Typst evaluates parts of your code multiple times. However, there is no guarantee that your state manipulation can actually be completely resolved.
For instance, if you generate state updates depending on the final value of a state, the results might never converge. The example below illustrates this. We initialize our state with `1` and then update it to its own final value plus 1. So it should be `2`, but then its final value is `2`, so it should be `3`, and so on. This example displays a finite value because Typst simply gives up after a few attempts.
    
    // This is bad!
    #let s = state("x", 1)
    #context s.update(s.final() + 1)
    #context s.get()
    
In general, you should try not to generate state updates from within context expressions. If possible, try to express your updates as non-contextual values or functions that compute the new value from the previous value. Sometimes, it cannot be helped, but in those cases it is up to you to ensure that the result converges.
# state
Create a new state identified by a key.
key
The key that identifies this state.
init
The initial value of the state.
# get
Retrieves the value of the state at the current location.
This is equivalent to `state.at(here())`.
# at
Retrieves the value of the state at the given selector's unique match.
The `selector` must match exactly one element in the document. The most useful kinds of selectors for this are labels and locations.
selector
The place at which the state's value should be retrieved.
# final
Retrieves the value of the state at the end of the document.
# update
Update the value of the state.
The update will be in effect at the position where the returned content is inserted into the document. If you don't put the output into the document, nothing happens! This would be the case, for example, if you write `let _ = state("key").update(7)`. State updates are always applied in layout order and in that case, Typst wouldn't know when to update the state.
update
If given a non function-value, sets the state to that value. If given a function, that function receives the previous state and has to return the new state.
# data-loading
Data loading from external files.
These functions help you with loading and embedding data, for example from the results of an experiment.
# cbor
Reads structured data from a CBOR file.
The file must contain a valid CBOR serialization. Mappings will be converted into Typst dictionaries, and sequences will be converted into Typst arrays. Strings and booleans will be converted into the Typst equivalents, null-values (`null`, `~` or empty ``) will be converted into `none`, and numbers will be converted to floats or integers depending on whether they are whole numbers.
Be aware that integers larger than 263-1 will be converted to floating point numbers, which may result in an approximative value.
source
A path to a CBOR file or raw CBOR bytes.
# decode
Reads structured data from CBOR bytes.
data
CBOR data.
# encode
Encode structured data into CBOR bytes.
value
Value to be encoded.
# csv
Reads structured data from a CSV file.
The CSV file will be read and parsed into a 2-dimensional array of strings: Each row in the CSV file will be represented as an array of strings, and all rows will be collected into a single array. Header rows will not be stripped.
## Example
    
    #let results = csv("example.csv")
    
    #table(
      columns: 2,
      [*Condition*], [*Result*],
      ..results.flatten(),
    )
    
source
A path to a CSV file or raw CSV bytes.
delimiter
The delimiter that separates columns in the CSV file. Must be a single ASCII character.
row-type
How to represent the file's rows.
  * If set to `array`, each row is represented as a plain array of strings.
  * If set to `dictionary`, each row is represented as a dictionary mapping from header keys to strings. This option only makes sense when a header row is present in the CSV file.


# decode
Reads structured data from a CSV string/bytes.
data
CSV data.
delimiter
The delimiter that separates columns in the CSV file. Must be a single ASCII character.
row-type
How to represent the file's rows.
  * If set to `array`, each row is represented as a plain array of strings.
  * If set to `dictionary`, each row is represented as a dictionary mapping from header keys to strings. This option only makes sense when a header row is present in the CSV file.


# json
Reads structured data from a JSON file.
The file must contain a valid JSON value, such as object or array. JSON objects will be converted into Typst dictionaries, and JSON arrays will be converted into Typst arrays. Strings and booleans will be converted into the Typst equivalents, `null` will be converted into `none`, and numbers will be converted to floats or integers depending on whether they are whole numbers.
Be aware that integers larger than 263-1 will be converted to floating point numbers, which may result in an approximative value.
The function returns a dictionary, an array or, depending on the JSON file, another JSON data type.
The JSON files in the example contain objects with the keys `temperature`, `unit`, and `weather`.
## Example
    
    #let forecast(day) = block[
      #box(square(
        width: 2cm,
        inset: 8pt,
        fill: if day.weather == "sunny" {
          yellow
        } else {
          aqua
        },
        align(
          bottom + right,
          strong(day.weather),
        ),
      ))
      #h(6pt)
      #set text(22pt, baseline: -8pt)
      #day.temperature °#day.unit
    ]
    
    #forecast(json("monday.json"))
    #forecast(json("tuesday.json"))
    
source
A path to a JSON file or raw JSON bytes.
# decode
Reads structured data from a JSON string/bytes.
data
JSON data.
# encode
Encodes structured data into a JSON string.
value
Value to be encoded.
pretty
Whether to pretty print the JSON with newlines and indentation.
# read
Reads plain text or data from a file.
By default, the file will be read as UTF-8 and returned as a string.
If you specify `encoding: none`, this returns raw bytes instead.
## Example
    
    An example for a HTML file: \
    #let text = read("example.html")
    #raw(text, lang: "html")
    
    Raw bytes:
    #read("tiger.jpg", encoding: none)
    
path
Path to a file.
For more details, see the Paths section.
encoding
The encoding to read the file with.
If set to `none`, this function returns raw bytes.
# toml
Reads structured data from a TOML file.
The file must contain a valid TOML table. TOML tables will be converted into Typst dictionaries, and TOML arrays will be converted into Typst arrays. Strings, booleans and datetimes will be converted into the Typst equivalents and numbers will be converted to floats or integers depending on whether they are whole numbers.
The TOML file in the example consists of a table with the keys `title`, `version`, and `authors`.
## Example
    
    #let details = toml("details.toml")
    
    Title: #details.title \
    Version: #details.version \
    Authors: #(details.authors
      .join(", ", last: " and "))
    
source
A path to a TOML file or raw TOML bytes.
# decode
Reads structured data from a TOML string/bytes.
data
TOML data.
# encode
Encodes structured data into a TOML string.
value
Value to be encoded.
pretty
Whether to pretty-print the resulting TOML.
# xml
Reads structured data from an XML file.
The XML file is parsed into an array of dictionaries and strings. XML nodes can be elements or strings. Elements are represented as dictionaries with the following keys:
  * `tag`: The name of the element as a string.
  * `attrs`: A dictionary of the element's attributes as strings.
  * `children`: An array of the element's child nodes.


The XML file in the example contains a root `news` tag with multiple `article` tags. Each article has a `title`, `author`, and `content` tag. The `content` tag contains one or more paragraphs, which are represented as `p` tags.
## Example
    
    #let find-child(elem, tag) = {
      elem.children
        .find(e => "tag" in e and e.tag == tag)
    }
    
    #let article(elem) = {
      let title = find-child(elem, "title")
      let author = find-child(elem, "author")
      let pars = find-child(elem, "content")
    
      [= #title.children.first()]
      text(10pt, weight: "medium")[
        Published by
        #author.children.first()
      ]
    
      for p in pars.children {
        if type(p) == dictionary {
          parbreak()
          p.children.first()
        }
      }
    }
    
    #let data = xml("example.xml")
    #for elem in data.first().children {
      if type(elem) == dictionary {
        article(elem)
      }
    }
    
source
A path to an XML file or raw XML bytes.
# decode
Reads structured data from an XML string/bytes.
data
XML data.
# yaml
Reads structured data from a YAML file.
The file must contain a valid YAML object or array. YAML mappings will be converted into Typst dictionaries, and YAML sequences will be converted into Typst arrays. Strings and booleans will be converted into the Typst equivalents, null-values (`null`, `~` or empty ``) will be converted into `none`, and numbers will be converted to floats or integers depending on whether they are whole numbers. Custom YAML tags are ignored, though the loaded value will still be present.
Be aware that integers larger than 263-1 will be converted to floating point numbers, which may give an approximative value.
The YAML files in the example contain objects with authors as keys, each with a sequence of their own submapping with the keys "title" and "published"
## Example
    
    #let bookshelf(contents) = {
      for (author, works) in contents {
        author
        for work in works [
          - #work.title (#work.published)
        ]
      }
    }
    
    #bookshelf(
      yaml("scifi-authors.yaml")
    )
    
source
A path to a YAML file or raw YAML bytes.
# decode
Reads structured data from a YAML string/bytes.
data
YAML data.
# encode
Encode structured data into a YAML string.
value
Value to be encoded.
# pdf
PDF files focus on accurately describing documents visually, but also have facilities for annotating their structure. This hybrid approach makes them a good fit for document exchange: They render exactly the same on every device, but also support extraction of a document's content and structure (at least to an extent). Unlike PNG files, PDFs are not bound to a specific resolution. Hence, you can view them at any size without incurring a loss of quality.
## PDF standards
The International Standards Organization (ISO) has published the base PDF standard and various standards that extend it to make PDFs more suitable for specific use-cases. By default, Typst exports PDF 1.7 files. Adobe Acrobat 8 and later as well as all other commonly used PDF viewers are compatible with this PDF version.
### PDF/A
Typst optionally supports emitting PDF/A-conformant files. PDF/A files are geared towards maximum compatibility with current and future PDF tooling. They do not rely on difficult-to-implement or proprietary features and contain exhaustive metadata. This makes them suitable for long-term archival.
The PDF/A Standard has multiple versions (parts in ISO terminology) and most parts have multiple profiles that indicate the file's conformance level. Currently, Typst supports these PDF/A output profiles:
  * PDF/A-2b: The basic conformance level of ISO 19005-2. This version of PDF/A is based on PDF 1.7 and results in self-contained, archivable PDF files.
  * PDF/A-3b: The basic conformance level of ISO 19005-3. This version of PDF/A is based on PDF 1.7 and results in archivable PDF files that can contain arbitrary other related files as attachments. The only difference between it and PDF/A-2b is the capability to embed non-PDF/A-conformant files within.


When choosing between exporting PDF/A and regular PDF, keep in mind that PDF/A files contain additional metadata, and that some readers will prevent the user from modifying a PDF/A file. Some features of Typst may be disabled depending on the PDF standard you choose.
## Exporting as PDF
### Command Line
PDF is Typst's default export format. Running the `compile` or `watch` subcommand without specifying a format will create a PDF. When exporting to PDF, you have the following configuration options:
  * Which PDF standards Typst should enforce conformance with by specifying `--pdf-standard` followed by one or multiple comma-separated standards. Valid standards are `1.7`, `a-2b`, and `a-3b`. By default, Typst outputs PDF-1.7-compliant files.
  * Which pages to export by specifying `--pages` followed by a comma-separated list of numbers or dash-separated number ranges. Ranges can be half-open. Example: `2,3,7-9,11-`.


### Web App
Click the quick download button at the top right to export a PDF with default settings. For further configuration, click "File" > "Export as" > "PDF" or click the downwards-facing arrow next to the quick download button and select "Export as PDF". When exporting to PDF, you have the following configuration options:
  * Which PDF standards Typst should enforce conformance with. By default, Typst outputs PDF-1.7-compliant files. Valid additional standards are `A-2b` and `A-3b`.
  * Which pages to export. Valid options are "All pages", "Current page", and "Custom ranges". Custom ranges are a comma-separated list of numbers or dash-separated number ranges. Ranges can be half-open. Example: `2,3,7-9,11-`.


## PDF-specific functionality
Typst exposes PDF-specific functionality in the global `pdf` module. See below for the definitions it contains.
# embed
A file that will be embedded into the output PDF.
This can be used to distribute additional files that are related to the PDF within it. PDF readers will display the files in a file listing.
Some international standards use this mechanism to embed machine-readable data (e.g., ZUGFeRD/Factur-X for invoices) that mirrors the visual content of the PDF.
## Example
    
    #pdf.embed(
      "experiment.csv",
      relationship: "supplement",
      mime-type: "text/csv",
      description: "Raw Oxygen readings from the Arctic experiment",
    )
    
## Notes
  * This element is ignored if exporting to a format other than PDF.
  * File embeddings are not currently supported for PDF/A-2, even if the embedded file conforms to PDF/A-1 or PDF/A-2.

path
The path of the file to be embedded.
Must always be specified, but is only read from if no data is provided in the following argument.
data
Raw file data, optionally.
If omitted, the data is read from the specified path.
relationship
The relationship of the embedded file to the document.
Ignored if export doesn't target PDF/A-3.
mime-type
The MIME type of the embedded file.
description
A description for the embedded file.
# png
Instead of creating a PDF, Typst can also directly render pages to PNG raster graphics. PNGs are losslessly compressed images that can contain one page at a time. When exporting a multi-page document, Typst will emit multiple PNGs. PNGs are a good choice when you want to use Typst's output in an image editing software or when you can use none of Typst's other export formats.
In contrast to Typst's other export formats, PNGs are bound to a specific resolution. When exporting to PNG, you can configure the resolution as pixels per inch (PPI). If the medium you view the PNG on has a finer resolution than the PNG you exported, you will notice a loss of quality. Typst calculates the resolution of your PNGs based on each page's physical dimensions and the PPI. If you need guidance for choosing a PPI value, consider the following:
  * A value of 300 or 600 is typical for desktop printing.
  * Professional prints of detailed graphics can go up to 1200 PPI.
  * If your document is only viewed at a distance, e.g. a poster, you may choose a smaller value than 300.
  * If your document is viewed on screens, a typical PPI value for a smartphone is 400-500.


Because PNGs only contain a pixel raster, the text within cannot be extracted automatically (without OCR), for example by copy/paste or a screen reader. If you need the text to be accessible, export a PDF or HTML file instead.
PNGs can have transparent backgrounds. By default, Typst will output a PNG with an opaque white background. You can make the background transparent using `#set page(fill: none)`. Learn more on the `page` function's reference page.
## Exporting as PNG
### Command Line
Pass `--format png` to the `compile` or `watch` subcommand or provide an output file name that ends with `.png`.
If your document has more than one page, Typst will create multiple image files. The output file name must then be a template string containing at least one of
  * `{p}`, which will be replaced by the page number
  * `{0p}`, which will be replaced by the zero-padded page number (so that all numbers have the same length)
  * `{t}`, which will be replaced by the total number of pages


When exporting to PNG, you have the following configuration options:
  * Which resolution to render at by specifying `--ppi` followed by a number of pixels per inch. The default is `144`.
  * Which pages to export by specifying `--pages` followed by a comma-separated list of numbers or dash-separated number ranges. Ranges can be half-open. Example: `2,3,7-9,11-`.


### Web App
Click "File" > "Export as" > "PNG" or click the downwards-facing arrow next to the quick download button and select "Export as PNG". When exporting to PNG, you have the following configuration options:
  * The resolution at which the pages should be rendered, as a number of pixels per inch. The default is `144`.
  * Which pages to export. Valid options are "All pages", "Current page", and "Custom ranges". Custom ranges are a comma-separated list of numbers or dash-separated number ranges. Ranges can be half-open. Example: `2,3,7-9,11-`.


# svg
Instead of creating a PDF, Typst can also directly render pages to scalable vector graphics (SVGs), which are the preferred format for embedding vector graphics in web pages. Like PDF files, SVGs display your document exactly how you have laid it out in Typst. Likewise, they share the benefit of not being bound to a specific resolution. Hence, you can print or view SVG files on any device without incurring a loss of quality. (Note that font printing quality may be better with a PDF.) In contrast to a PDF, an SVG cannot contain multiple pages. When exporting a multi-page document, Typst will emit multiple SVGs.
SVGs can represent text in two ways: By embedding the text itself and rendering it with the fonts available on the viewer's computer or by embedding the shapes of each glyph in the font used to create the document. To ensure that the SVG file looks the same across all devices it is viewed on, Typst chooses the latter method. This means that the text in the SVG cannot be extracted automatically, for example by copy/paste or a screen reader. If you need the text to be accessible, export a PDF or HTML file instead.
SVGs can have transparent backgrounds. By default, Typst will output an SVG with an opaque white background. You can make the background transparent using `#set page(fill: none)`. Learn more on the `page` function's reference page.
## Exporting as SVG
### Command Line
Pass `--format svg` to the `compile` or `watch` subcommand or provide an output file name that ends with `.svg`.
If your document has more than one page, Typst will create multiple image files. The output file name must then be a template string containing at least one of
  * `{p}`, which will be replaced by the page number
  * `{0p}`, which will be replaced by the zero-padded page number (so that all numbers have the same length)
  * `{t}`, which will be replaced by the total number of pages


When exporting to SVG, you have the following configuration options:
  * Which pages to export by specifying `--pages` followed by a comma-separated list of numbers or dash-separated number ranges. Ranges can be half-open. Example: `2,3,7-9,11-`.


### Web App
Click "File" > "Export as" > "SVG" or click the downwards-facing arrow next to the quick download button and select "Export as SVG". When exporting to SVG, you have the following configuration options:
  * Which pages to export. Valid options are "All pages", "Current page", and "Custom ranges". Custom ranges are a comma-separated list of numbers or dash-separated number ranges. Ranges can be half-open. Example: `2,3,7-9,11-`.


