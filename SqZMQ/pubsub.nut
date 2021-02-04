// Keep fetching messages from sockets each frame
SqRoutine(this, SqZMQ.Process, 1);

// Create a ZMQ context (globally so we can access it from everywhere)
g_ZCtx <- SqZMQ.Context();

// Create Publisher socket
local pub = g_ZCtx.Socket(SqZmq.PUB);

// Create some Subscriber sockets
local sub_1 = g_ZCtx.Socket(SqZmq.SUB);
local sub_2 = g_ZCtx.Socket(SqZmq.SUB);
local sub_3 = g_ZCtx.Socket(SqZmq.SUB);

// Subscribe socket 1 to channel A and B
sub_1.SetOpt(SqZmq.SUBSCRIBE, "A");
sub_1.SetOpt(SqZmq.SUBSCRIBE, "B");

// Subscribe socket 1 to channel A and C
sub_2.SetOpt(SqZmq.SUBSCRIBE, "A");
sub_2.SetOpt(SqZmq.SUBSCRIBE, "C");

// Subscribe socket 3 to channels B and C
sub_3.SetOpt(SqZmq.SUBSCRIBE, "B");
sub_3.SetOpt(SqZmq.SUBSCRIBE, "C");

// Bind our Publisher socket
pub.Bind("tcp://127.0.0.1:3000");
// Connect our Subscriber sockets to the Publisher socket
sub_1.Connect("tcp://127.0.0.1:3000");
sub_2.Connect("tcp://127.0.0.1:3000");
sub_3.Connect("tcp://127.0.0.1:3000");

// Push messages every second
SqRoutine(this, function() {
	// Send simple work
	pub.SendString("work data");
	// Send work through channel A
	pub.SendStrings(["A", "A work data"]);
	// Send work through channel B
	pub.SendStrings(["B", "B work data"]);
	// Send work through channel C
	pub.SendStrings(["C", "C work data"]);
}, 1000);

// Helper function to avoid duplicating code
function PrintWork(messages, multipart) {
	// Is this a multi-part message?
	if(multipart)
	{
		// Then `messages` is an array
		foreach(msg in messages)
		{
			print(msg);
		}
	}
	// This is a single message
	else
	{
		print(messages);
	}
}

// Bind a function to know when work/data/messages are received
sub_1.OnData(function(messages, multipart) {
	print("- worker 1 -- received work");
	PrintWork(messages, multipart);
});

sub_2.OnData(function(messages, multipart) {
	print("- worker 2 -- received work");
	PrintWork(messages, multipart);
});

sub_3.OnData(function(messages, multipart) {
	print("- worker 3 -- received work");
	PrintWork(messages, multipart);
});
