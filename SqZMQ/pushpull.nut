// Keep fetching messages from sockets each frame
SqRoutine(this, SqZMQ.Process, 1);

// Create a ZMQ context (globally so we can access it from everywhere)
g_ZCtx <- SqZMQ.Context();

// Create PUSH socket
local push = g_ZCtx.Socket(SqZmq.PUSH);
// Create PULL socket
local pull = g_ZCtx.Socket(SqZmq.PULL);

// Bind our PUSH socket
push.Bind("tcp://127.0.0.1:3000");
// Connect our PULL socket to the PUSH socket
pull.Connect("tcp://127.0.0.1:3000");

// Push messages every second
SqRoutine(this, function() {
	push.SendString("work data");
	push.SendStrings(["main data", "other data"]);
	print("-- work sent");
}, 1000);

// Bind a function to know when work/data/messages are received
pull.OnData(function(messages, multipart) {
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
});
