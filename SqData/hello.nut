// Create an in-memory database
session <- SqData.Session("sqlite", ":memory:", 60);

// Create the table in the database
SqData.Statement(session, "CREATE TABLE Dummy (count INTEGER(10), text VARCHAR)").Execute(true);

/* A data binding is like a value that can only be passed around as a reference.
	When the value of a binding is modified. The value will change everywhere that binding is referenced.

	Which means that when we give a binding to a statement we actually give a reference not a copy.
	And when the statement tries to access the value from that binding. It will get the last value we stored in it.
	And not the value it had when we gave it to the statement.

	This is necessary because fundamental values in squirrel (such as: integer, float, bool, null etc.) are passed by copy.
	That means whenever you pass one of these variables as n argument to a function you're actually giving a copy of it.

	And the string type is immutable. What that means is that strings cannot be modified once created.
	Which is why you actually need to create a new string if you need to modify something in another string.

	And because of these limitations, these bindings are necessary. They are almost the same as script values but can be shared.
*/

// Create an integer data binding
local count = SqData.IntBind();
local text = SqData.StrBind();

// ? are anonymous statement parameters that can only be addressed by index.
// Tell the statement that ? and ? actually refer to the value inside `count` and `text` bindings.
local insert = SqData.Statement(session, "INSERT INTO Dummy VALUES(?, ?)").Use(count).Use(text);

// Run the above statement 100 times
for (local i = 0; i < 10; ++i)
{
	// Change the value in `count` to the value in `i`
	count.Value = i;
	// Change the value in `text` to the value "Count is #"
	// Where # is whatever value `i` currently is
	text.Set("Count is %d", i);
	// Execute the statement with the current values in `count` and `text`
    insert.Execute();
}

// Create a statement that selects a single row from the database where `column` value is 4.
// The statement selects all columns and we have 2 (`count` and `text`) in our table.
//	We tell the statement to take the value from those columns and store it into `count` and `text` bindings we created earlier.
// We then bind the value `4` into the parameter denoted by `?`.
//	Bind() is just like Use(), except it can take a copy of the given value, not just references (i.e. bindings).
// 	And because this value is only given once and it happens to be literal we can use Bind() instead of Use().
local select = SqData.Statement(session, "SELECT * FROM Dummy WHERE count=?").Into(count).Into(text).Bind(4).Execute_();

// If there are rows extracted/available then we can access their value from the bindings we specified.
if (select.RowsExtracted > 0)
{
	printf("count found: %d", count.Value);
	printf("text found: %s", text.Value);
}

// Create a record-set (i.e. a special kind of Statement) which selects all row in our table.
// Record-sets allow iteration over multiple rows individually unlike vector containers.
// If you need to select more than one row and you cannot use vector containers then this works as an alternative.
local record = SqData.RecordSet(session, "SELECT * FROM Dummy");

// Check the row count initially to see if any rows are available.
// Each round check if the record-set has a row available.
// After each round move the record-set to the next row.
for (local more = record.RowCount > 0; more; more = record.Next())
{
	printf("count: %d", record.Value("count"));
	printf("text: %s", record.Value("text"));
}
