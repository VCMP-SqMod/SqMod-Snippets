local ivec = SqUtils.IntVec();
local svec = SqUtils.StrVec();
local fvec = SqUtils.FloatVec();
local xvec = SqUtils.ByteVec();
local bvec = SqUtils.BoolVec();

// All should be valid
SqAssert(!ivec.Null).What("ivec: is valid");
SqAssert(!svec.Null).What("svec: is valid");
SqAssert(!fvec.Null).What("fvec: is valid");
SqAssert(!xvec.Null).What("xvec: is valid");
SqAssert(!bvec.Null).What("bvec: is valid");

// Size == How much it currently has stored in it (actual elements)
// Capacity == How much it can store before having to allocate memory again

// Both should be 0
SqAssertEQ(ivec.Size, ivec.Capacity).What("ivec: Size ({0}) == Capacity ({1})");
SqAssertEQ(svec.Size, svec.Capacity).What("svec: Size ({0}) == Capacity ({1})");
SqAssertEQ(fvec.Size, fvec.Capacity).What("fvec: Size ({0}) == Capacity ({1})");
SqAssertEQ(xvec.Size, xvec.Capacity).What("xvec: Size ({0}) == Capacity ({1})");
SqAssertEQ(bvec.Size, bvec.Capacity).What("bvec: Size ({0}) == Capacity ({1})");
// All should be empty
SqAssert(ivec.Empty).What("ivec: is empty");
SqAssert(svec.Empty).What("svec: is empty");
SqAssert(fvec.Empty).What("fvec: is empty");
SqAssert(xvec.Empty).What("xvec: is empty");
SqAssert(bvec.Empty).What("bvec: is empty");
// Add one element to the back of the container
ivec.Push(347);
svec.Push("xyz");
fvec.Push(2.4);
xvec.Push(90);
bvec.Push(false);
// Size should be 1
SqAssertEQ(ivec.Size, 1).What("ivec: Size == 1");
SqAssertEQ(svec.Size, 1).What("svec: Size == 1");
SqAssertEQ(fvec.Size, 1).What("fvec: Size == 1");
SqAssertEQ(xvec.Size, 1).What("xvec: Size == 1");
SqAssertEQ(bvec.Size, 1).What("bvec: Size == 1");
// Capacity equal or greater than Size
SqAssertGE(ivec.Capacity, ivec.Size).What("ivec: Capacity ({0}) >= Size ({1})");
SqAssertGE(svec.Capacity, svec.Size).What("svec: Capacity ({0}) >= Size ({1})");
SqAssertGE(fvec.Capacity, fvec.Size).What("fvec: Capacity ({0}) >= Size ({1})");
SqAssertGE(xvec.Capacity, xvec.Size).What("xvec: Capacity ({0}) >= Size ({1})");
SqAssertGE(bvec.Capacity, bvec.Size).What("bvec: Capacity ({0}) >= Size ({1})");
// The first and last element should be equal when there's just one
SqAssertEQ_(ivec.Front, ivec.Back).What("ivec: Front ({0}) == Back ({1})");
SqAssertEQ_(svec.Front, svec.Back).What("svec: Front ({0}) == Back ({1})");
SqAssertEQ_(fvec.Front, fvec.Back).What("fvec: Front ({0}) == Back ({1})");
SqAssertEQ_(xvec.Front, xvec.Back).What("xvec: Front ({0}) == Back ({1})");
SqAssertEQ_(bvec.Front, bvec.Back).What("bvec: Front ({0}) == Back ({1})");
// All should not be empty
SqAssert(!ivec.Empty).What("ivec: is not empty");
SqAssert(!svec.Empty).What("svec: is not empty");
SqAssert(!fvec.Empty).What("fvec: is not empty");
SqAssert(!xvec.Empty).What("xvec: is not empty");
SqAssert(!bvec.Empty).What("bvec: is not empty");
// Add the same element to the back of the container
ivec.Push(347);
svec.Push("xyz");
fvec.Push(2.4);
xvec.Push(90);
bvec.Push(false);
// Size should be 2
SqAssertEQ(ivec.Size, 2).What("ivec: Size == 2");
SqAssertEQ(svec.Size, 2).What("svec: Size == 2");
SqAssertEQ(fvec.Size, 2).What("fvec: Size == 2");
SqAssertEQ(xvec.Size, 2).What("xvec: Size == 2");
SqAssertEQ(bvec.Size, 2).What("bvec: Size == 2");
// Capacity equal or greater than Size
SqAssertGE(ivec.Capacity, ivec.Size).What("ivec: Capacity ({0}) >= Size ({1})");
SqAssertGE(svec.Capacity, svec.Size).What("svec: Capacity ({0}) >= Size ({1})");
SqAssertGE(fvec.Capacity, fvec.Size).What("fvec: Capacity ({0}) >= Size ({1})");
SqAssertGE(xvec.Capacity, xvec.Size).What("xvec: Capacity ({0}) >= Size ({1})");
SqAssertGE(bvec.Capacity, bvec.Size).What("bvec: Capacity ({0}) >= Size ({1})");
// The first and last element should be equal because they're the same value
SqAssertEQ_(ivec.Front, ivec.Back).What("ivec: Front ({0}) == Back ({1})");
SqAssertEQ_(svec.Front, svec.Back).What("svec: Front ({0}) == Back ({1})");
SqAssertEQ_(fvec.Front, fvec.Back).What("fvec: Front ({0}) == Back ({1})");
SqAssertEQ_(xvec.Front, xvec.Back).What("xvec: Front ({0}) == Back ({1})");
SqAssertEQ_(bvec.Front, bvec.Back).What("bvec: Front ({0}) == Back ({1})");
// Add a different element to the back of the container
ivec.Push(288);
svec.Push("abc");
fvec.Push(1.3);
xvec.Push(65);
bvec.Push(true);
// Size should be 3
SqAssertEQ(ivec.Size, 3).What("ivec: Size == 3");
SqAssertEQ(svec.Size, 3).What("svec: Size == 3");
SqAssertEQ(fvec.Size, 3).What("fvec: Size == 3");
SqAssertEQ(xvec.Size, 3).What("xvec: Size == 3");
SqAssertEQ(bvec.Size, 3).What("bvec: Size == 3");
// Capacity equal or greater than Size
SqAssertGE(ivec.Capacity, ivec.Size).What("ivec: Capacity ({0}) >= Size ({1})");
SqAssertGE(svec.Capacity, svec.Size).What("svec: Capacity ({0}) >= Size ({1})");
SqAssertGE(fvec.Capacity, fvec.Size).What("fvec: Capacity ({0}) >= Size ({1})");
SqAssertGE(xvec.Capacity, xvec.Size).What("xvec: Capacity ({0}) >= Size ({1})");
SqAssertGE(bvec.Capacity, bvec.Size).What("bvec: Capacity ({0}) >= Size ({1})");
// The first and last element should not be equal anymore
SqAssertNE_(ivec.Front, ivec.Back).What("ivec: Front ({0}) != Back ({1})");
SqAssertNE_(svec.Front, svec.Back).What("svec: Front ({0}) != Back ({1})");
SqAssertNE_(fvec.Front, fvec.Back).What("fvec: Front ({0}) != Back ({1})");
SqAssertNE_(xvec.Front, xvec.Back).What("xvec: Front ({0}) != Back ({1})");
SqAssertNE_(bvec.Front, bvec.Back).What("bvec: Front ({0}) != Back ({1})");
// The order in which these specific values were added should not make the container unsorted
SqAssert(!ivec.Sorted).What("ivec: is not sorted");
SqAssert(!svec.Sorted).What("svec: is not sorted");
SqAssert(!fvec.Sorted).What("fvec: is not sorted");
SqAssert(!xvec.Sorted).What("xvec: is not sorted");
//SqAssert(!bvec.Sorted).What("bvec: is not sorted");//not implemented

// We added these values twice
SqAssertEQ(ivec.Count(347), 2).What("ivec: 347 was found {0} times");
SqAssertEQ(svec.Count("xyz"), 2).What("svec: \"xyz\" was found {0} times");
SqAssertEQ(fvec.Count(2.4), 2).What("fvec: 2.4 was found {0} times");
SqAssertEQ(xvec.Count(90), 2).What("xvec: 90 was found {0} times");
SqAssertEQ(bvec.Count(false), 2).What("bvec: false was found {0} times");

// We added these values twice
SqAssertEQ(ivec.Find(288), 2).What("ivec: 288 was found at index {0}");
SqAssertEQ(svec.Find("abc"), 2).What("svec: \"abc\" was found at index {0}");
SqAssertEQ(fvec.Find(1.3), 2).What("fvec: 1.3 was found at index {0}");
SqAssertEQ(xvec.Find(65), 2).What("xvec: 65 was found at index {0}");
SqAssertEQ(bvec.Find(true), 2).What("bvec: true was found at index {0}");

// Sort the containers and check again
SqAssert(ivec.Sort().Sorted).What("ivec: is sorted");
SqAssert(svec.Sort().Sorted).What("svec: is sorted");
SqAssert(fvec.Sort().Sorted).What("fvec: is sorted");
SqAssert(xvec.Sort().Sorted).What("xvec: is sorted");
//SqAssert(bvec.Sort().Sorted).What("bvec: is sorted");//not implemented

// Reverse the containers and check again
SqAssert(!ivec.Reverse().Sorted).What("ivec: is not sorted");
SqAssert(!svec.Reverse().Sorted).What("svec: is not sorted");
SqAssert(!fvec.Reverse().Sorted).What("fvec: is not sorted");
SqAssert(!xvec.Reverse().Sorted).What("xvec: is not sorted");
//SqAssert(!bvec.Reverse().Sorted).What("bvec: is not sorted");//not implemented
