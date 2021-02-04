// Create an in-memory database
session <- SqData.Session("sqlite", ":memory:", 60);

// Create the table in the database
SqData.Statement(session, "CREATE TABLE Dummy (count INTEGER(10), text VARCHAR)").Execute();

// ? are anonymous statement parameters that can only be addressed by index
SqData.Statement(session, "INSERT INTO Dummy VALUES(?, ?)")
// Generate a new IntVec container with integers from 0 to 100 and use it as the first statement parameter
.Use(SqUtils.IntVec(100).GenerateSome(100, [0], function(c) { return c[0]++; }))
// Generate a new IntVec container with strings "Count is #" (where # is from 0 to 100) and use it as the second statement parameter
.Use(SqUtils.StrVec(100).GenerateSome(100, [0], function(c) { return "Count is " + c[0]++; }))
// Because the generated vectors have the same size
// It will execute the statement for each pair of values in them
.Execute();

// Create an empty vector and reserve space for 100 in advance (.Size == 0 && .Capacity == 100)
local count = SqUtils.IntVec(100);
// Create an empty vector and reserve space for 100 in advance (.Size == 0 && .Capacity == 100)
local text = SqUtils.StrVec(100);

// Create a SELECT statement that selects all values from the Dummy table
// Because the table only has 2 columns we can use the vectors we just created
// Obviously in the same order in which the columns are laid out in the table
SqData.Statement(session, "SELECT * FROM Dummy").Into(count).Into(text).Execute();

// The statement should have gathered all rows and inserted the values into the specified vectors
// We can now process the data directly from the vectors themselves
printf("Counts selected %d", count.Size);
printf("Texts selected %d", text.Size);
/* Output should be:

Counts selected 100
Texts selected 100

*/


// Print the `text` column from the first 5 rows
text.EachRange(0, 5, print);
/* Output should be:

Count is 0
Count is 1
Count is 2
Count is 3
Count is 4

*/
