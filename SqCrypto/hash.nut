local text = "hello";
local algorithms = ["SHA1", "SHA224", "SHA384", "SHA512", "MDC2", "MD4", "MD5", "RIPEMD", "RMD160", "WHIRLPOOL"];

foreach(algorithm in algorithms)
    printf("%s: %s", algorithm, SqCrypto.Hash(algorithm, text));