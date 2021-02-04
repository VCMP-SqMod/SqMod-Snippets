// Keep fetching messages from sockets each frame
SqRoutine(this, SqZMQ.Process, 1);

// Create a ZMQ context (globally so we can access it from everywhere)
g_ZCtx <- SqZMQ.Context();

// Create Reply socket
local rep = g_ZCtx.Socket(SqZmq.REP);
// Create Request socket
local req = g_ZCtx.Socket(SqZmq.REQ);

// Bind our Reply socket
rep.Bind("tcp://127.0.0.1:3000");
// Connect our Request socket to the Reply socket
req.Connect("tcp://127.0.0.1:3000");

// Bind a function to know when work/data/messages are received
rep.OnData(function(messages, multipart) {
	print("- request received");
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
	// Send reply back
	rep.SendString("reply data");
});

// Bind a function to know when work/data/messages are received
req.OnData(function(messages, multipart) {
	print("- reply received");
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


// Send a request every second
SqRoutine(this, function() {
	req.SendString("request data");
	print("-- request sent");
}, 1000);
