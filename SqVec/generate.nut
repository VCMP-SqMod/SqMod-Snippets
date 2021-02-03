/* There are 4 methods that can be used to generate values in the vector:

	Generate([object] context, [function] callback)
	GenerateSome([integer] num, [object] context, [function] callback)
	GenerateFrom([integer] pos, [integer] num, [object] context, [function] callback)
	GenerateBetween([integer] pos, [integer] num, [object] context, [function] callback)

	The `context` parameter is any script object that should be forwarded to the callback on each call
	It can be used to maintain a state throughout each invocation of the callback
	NOTE: integer, float, bool, null types are passed by copy each time.
			Which means that any modification will not propagate to the next call.
			Therefore in such cases you can wrap them in a table or array like:
			Tables: {counter = 0} and then access as .counter (i.e. my_table.counter)
			Arrays: [0] and then access as index 0 (i.e. my_array[0])

	The value returned by the function/callback will be used as the element value.
*/


/*	Generate: Generate a new value and add it to the back of the container.
				It will continue to generate a new values until the callback returns null.

	GenerateSome: Generate a specific amount of values and add them at the back of the container.


	GenerateFrom: Generate a specific amount of values and insert them from the specified position.

	GenerateBetween: Generate a new value for every element in the specified range.
						It is effectively the same as Generate but can apply only to a portion of the container elements.
						First parameter is the start position and the other is how many elements to process after that.
*/


// Create an empty vector
// Then generate 10 random values between 10 and 20
// Should print ten random values between 10 and 20
SqUtils.IntVec().Generate([0], function(ctx) {
	if (++ctx[0] <= 10) {
		return SqRand.Integer(10, 20);
	} else {
		return null;
	}
}).Each(print);

print("---- ---- ---- ----");

// Create a vector with space reserved for at least 10 elements
// Then generate 10 elements at the back of the container.
// Should print 0 through 9
SqUtils.IntVec(10).GenerateSome(10, {counter = 0}, function(ctx) {
	return ctx.counter++;
}).Each(print);

print("---- ---- ---- ----");

// Create a vector with 10 elements. Each element will be the value 546
// Then generate 5 new values (267) in the middle
// Should print 546 five times then 267 five times then again 546 five times
SqUtils.IntVec(10, 546).GenerateFrom(5, 5, null, function(ctx) {
	return 267;
}).Each(print);

print("---- ---- ---- ----");

// Create a vector with 10 elements. Each element will be the value 277
// Then generate a new value (288) for the first 5 elements
// Should print 288 five times then 277 five times
SqUtils.IntVec(10, 277).GenerateBetween(0, 4, null, function(ctx) {
	return 288;
}).Each(print);
