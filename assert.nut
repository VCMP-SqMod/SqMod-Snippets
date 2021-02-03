// ------------------------------------------------------------------------------------------------
/* SqAssert(e) is the simplest of the bunch. It only checks if the given expression is true.
 *
*/
SqAssert(true); // Pass
//SqAssert(false); // Throws error
SqAssert(true != false); // Pass

// ------------------------------------------------------------------------------------------------
/* SqAssert[OP](a, b) family of functions compare two values that can be compared.
 *
 * SqAssertEQ(a, b) - [==] - (a) Equal (b)
 * SqAssertNE(a, b) - [!=] - (a) Not Equal (b)
 * SqAssertLT(a, b) - [< ] - (a) Less Than (b)
 * SqAssertGT(a, b) - [> ] - (a) Greater (b)
 * SqAssertLE(a, b) - [<=] - (a) Less That Or Equal (b)
 * SqAssertGE(a, b) - [>=] - (a) Greater That Or Equal (b)
*/
SqAssertEQ(33, 33).What("{0} == {1}").Where();
//SqAssertEQ(33, 44).What("{0} == {1}").Where(); // Throws error

// ------------------------------------------------------------------------------------------------
/* SqAssert[OP]_(a, b) family of functions compare two values of same type.
 * Notice the trailing underscore in the name.
*/
SqAssertEQ_(33, 33).What("{0} == {1}").Where();
//SqAssertEQ_(33, 33.0).What("{0} == {1}").Where(); // Throws error

// ------------------------------------------------------------------------------------------------
/* They all return an object of type SqAssertResult which has two methods:
 *
 * What(...) - (optionally) takes a string that can be used to describe what was happened
 *	The string can make use of two substitute values:
 *		{0} which is the first parameter (i.e. a)
 *		{1} which is the second parameter (i.e. b)
 *	Wherever those two are found in the string they'll be substitute with the actual value in the associated parameter.
 *	If a string is not provided then the default generic one is used instead. Either way you're getting something.
 *
 * Where() - Will sub-log a message with the location where the assert function was invoked
 *	Format will be:  =>In: source.nut : line
 *	Ex:  =>In: hello.nut : 43
 *
 * To not display any information about the assert in case it passed, don't invoke either of those methods.
 * Or simply call just one of them to show the information you need if the assertion passed.
*/
