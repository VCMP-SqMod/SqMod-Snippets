/* Specialized array-like containers with efficient memory usage and optimized lookup
	They're primary usage for send or receive collection of values to and form a database.
	They store only their designated type and no other type.

	IntVec		- Vector/Array of integers.
	StrVec		- Vector/Array of strings.
	FloatVec	- Vector/Array of floats.
	ByteVec		- Vector/Array of bytes.
	BoolVec		- Vector/Array of bools.
*/

/* They have two constructors:

	Vector(capacity)	- Reserve the specified capacity. Doesn't create any element.
	Vector(size, value)	- Create a container and fill it with the specified amount of values.
							Each value will be a copy of `value`. After construction the o.Size member should be equal to `size`

	For the string container. Each method that takes in a string, supports formatting.
	Ex: StrVec(5, "hello world").Set(2, "goodbye %s", "world");
	Will create a container with 5 strings and change the 3'd element to "goodbye world"
*/

local v = SqUtils.StrVec(3, "hello world");
// Get the value of the element at position 2 (same as my_array[2])
print(v.Get(2));
// Set the value of the element at position 2 (same as my_array[2])
v.Set(2, "goodbye %s", "world");
// Last element should be "goodbye world"
v.Each(print);

// Size should be 3 and capacity something equal or bigger
printf("vector size: %d capacity: %d", v.Size, v.Capacity);
// Increase capacity
v.Reserve(100);
// Size should be 3 and capacity something equal or bigger than 100
printf("vector size: %d capacity: %d", v.Size, v.Capacity);

// Allocate memory only to store the current amount of elements
v.Compact();
// Size should be 3 and capacity also 3 (most likely)
printf("vector size: %d capacity: %d", v.Size, v.Capacity);

// Remove all elements from the container
v.Clear();

// Append values at the back of the existing ones
for (local n = 0; n < 3; ++n)
{
	// Push and Append are the same thing
	v.Push(n);
	v.Append(n + 10);
}

// Append another container
v.Extend(SqUtils.StrVec(3, "abc"));
// Container now has: "0", "10", "1", "11", "2", "12", "abc", "abc", "abc"
//v.Each(print);

// Check if the container has no elements stored in it
print(v.Empty);

// Remove the last value in the container
v.Pop();
v.Pop();
// Container now has: "0", "10", "1", "11", "2", "12", "abc"
//v.Each(print);

// .Front property is the first element in the container
print(v.Front); // should print "0"

// .Back property is the last element in the container
print(v.Back); // should print "abc"

// Remove the element at a certain position
v.EraseAt(2);
// Container now has: "0", "10", "11", "2", "12", "abc"
//v.Each(print);

// Remove a certain amount of elements starting from a certain position
v.EraseFrom(1, 2);
// Container now has: "0", "2", "12", "abc"
//v.Each(print);

// Remove every occurrence of a specific value
v.EraseValue("abc");
// Container now has: "0", "2", "12"
//v.Each(print);

// Insert a new value at a certain position
v.InsertAt(0, "meow");
// Container now has: "meow", "0", "2", "12"
//v.Each(print);

// Insert a new value at a certain position a certain amount of times
v.Insert(1, 2, "bark");
// Container now has: "meow", "bark", "bark", "0", "2", "12"
//v.Each(print);

// Find the position of the first occurrence of a value
// Returns -1 if not found
print(v.Find("bark")); // should be 1

// Find the position of the first occurrence of a value starting from a certain position (i.e. offset)
// Returns -1 if not found
print(v.FindFrom(4, "bark")); // should be -1

// Count the number of occurrences of a value
print(v.Count("bark")); // should be 2

// Check if 2 vectors have the same values
print(SqUtils.IntVec(3, 434).Equal(SqUtils.IntVec(3, 245))); // should be false

// Create a new vector with a slice of elements from another vector
// First parameter is the start position and the other is how many elements to slice
v.Slice(0, 3).Each(print); // should print: "meow", "bark", "bark"

// Takes in a function and for each element calls that function with the element itself
SqUtils.IntVec(3, 773).Each(print); // Should print the value 773 three times

// Takes in a function and for each element in the specified range, calls that function with the element itself
// First parameter is the start position and the other is how many elements to process
v.EachRange(1, 2, print); // should print: "bark", "bark"

// Same as Each but the function can return false to stop at any time
// Returning true or null (i.e. nothing) allows the next element to be processed
v.While(function(e) {
	if (e == "bark") return false;
	else print(e);
}); // should print: "meow"

// Same as EachRange but with the functionality of While
v.WhileRange(2, 3, function(e) {
	if (e == "0") return false;
	else print(e);
}); // should print: "bark"

// Create a regular script array with the elements from the container
print(typeof(v.AsArray())); // This is costly. Cache the array if vector is not modified

// Reverse the elements in the vector
// Container now has: "12", "2", "0", "bark", "bark", "meow"
v.Reverse().Each(print);

// Sort the elements in the vector
// Container now has: "0", "12", "2", "bark", "bark", "meow"
v.Sort().Each(print);

// Check if elements are sorted
print(v.Sorted); // should be true since we just sorted them

// Randomize the order of the elements
v.Shuffle().Each(print); // should be different each time
