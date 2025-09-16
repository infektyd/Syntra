/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:892:20: error: cannot find type 'Proxy' in scope
 890 |             timeout: Timeout = Timeout(),
 891 |             connectionPool: ConnectionPool = ConnectionPool(),
 892 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 893 |             ignoreUncleanSSLShutdown: Bool = false,
 894 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:911:20: error: cannot find type 'Proxy' in scope
 909 |             redirectConfiguration: RedirectConfiguration? = nil,
 910 |             timeout: Timeout = Timeout(),
 911 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 912 |             ignoreUncleanSSLShutdown: Bool = false,
 913 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:931:20: error: cannot find type 'Proxy' in scope
 929 |             timeout: Timeout = Timeout(),
 930 |             maximumAllowedIdleTimeInConnectionPool: TimeAmount = .seconds(60),
 931 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 932 |             ignoreUncleanSSLShutdown: Bool = false,
 933 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:953:20: error: cannot find type 'Proxy' in scope
 951 |             timeout: Timeout = Timeout(),
 952 |             connectionPool: TimeAmount = .seconds(60),
 953 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 954 |             ignoreUncleanSSLShutdown: Bool = false,
 955 |             decompression: Decompression = .disabled,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:975:20: error: cannot find type 'Proxy' in scope
 973 |             redirectConfiguration: RedirectConfiguration? = nil,
 974 |             timeout: Timeout = Timeout(),
 975 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 976 |             ignoreUncleanSSLShutdown: Bool = false,
 977 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:995:20: error: cannot find type 'Proxy' in scope
 993 |             timeout: Timeout = Timeout(),
 994 |             connectionPool: ConnectionPool = ConnectionPool(),
 995 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 996 |             ignoreUncleanSSLShutdown: Bool = false,
 997 |             decompression: Decompression = .disabled,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:35:39: error: cannot infer contextual base in reference to member 'fullVerification'
33 |         // To start with, let's go with these values. Obtained from Firefox's config.
34 |         HTTPClient.Configuration(
35 |             certificateVerification: .fullVerification,
   |                                       `- error: cannot infer contextual base in reference to member 'fullVerification'
36 |             redirectConfiguration: .follow(max: 20, allowCycles: false),
37 |             timeout: Timeout(connect: .seconds(90), read: .seconds(90)),

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:36:37: error: cannot infer contextual base in reference to member 'follow'
34 |         HTTPClient.Configuration(
35 |             certificateVerification: .fullVerification,
36 |             redirectConfiguration: .follow(max: 20, allowCycles: false),
   |                                     `- error: cannot infer contextual base in reference to member 'follow'
37 |             timeout: Timeout(connect: .seconds(90), read: .seconds(90)),
38 |             connectionPool: .seconds(600),

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:38:30: error: cannot infer contextual base in reference to member 'seconds'
36 |             redirectConfiguration: .follow(max: 20, allowCycles: false),
37 |             timeout: Timeout(connect: .seconds(90), read: .seconds(90)),
38 |             connectionPool: .seconds(600),
   |                              `- error: cannot infer contextual base in reference to member 'seconds'
39 |             proxy: nil,
40 |             ignoreUncleanSSLShutdown: false,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:39:20: error: 'nil' requires a contextual type
37 |             timeout: Timeout(connect: .seconds(90), read: .seconds(90)),
38 |             connectionPool: .seconds(600),
39 |             proxy: nil,
   |                    `- error: 'nil' requires a contextual type
40 |             ignoreUncleanSSLShutdown: false,
41 |             decompression: .enabled(limit: .ratio(25)),

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:41:29: error: cannot infer contextual base in reference to member 'enabled'
39 |             proxy: nil,
40 |             ignoreUncleanSSLShutdown: false,
41 |             decompression: .enabled(limit: .ratio(25)),
   |                             `- error: cannot infer contextual base in reference to member 'enabled'
42 |             backgroundActivityLogger: nil
43 |         )

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:41:45: error: cannot infer contextual base in reference to member 'ratio'
39 |             proxy: nil,
40 |             ignoreUncleanSSLShutdown: false,
41 |             decompression: .enabled(limit: .ratio(25)),
   |                                             `- error: cannot infer contextual base in reference to member 'ratio'
42 |             backgroundActivityLogger: nil
43 |         )

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:42:39: error: 'nil' requires a contextual type
40 |             ignoreUncleanSSLShutdown: false,
41 |             decompression: .enabled(limit: .ratio(25)),
42 |             backgroundActivityLogger: nil
   |                                       `- error: 'nil' requires a contextual type
43 |         )
44 |     }
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:892:20: error: cannot find type 'Proxy' in scope
 890 |             timeout: Timeout = Timeout(),
 891 |             connectionPool: ConnectionPool = ConnectionPool(),
 892 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 893 |             ignoreUncleanSSLShutdown: Bool = false,
 894 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:911:20: error: cannot find type 'Proxy' in scope
 909 |             redirectConfiguration: RedirectConfiguration? = nil,
 910 |             timeout: Timeout = Timeout(),
 911 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 912 |             ignoreUncleanSSLShutdown: Bool = false,
 913 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:931:20: error: cannot find type 'Proxy' in scope
 929 |             timeout: Timeout = Timeout(),
 930 |             maximumAllowedIdleTimeInConnectionPool: TimeAmount = .seconds(60),
 931 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 932 |             ignoreUncleanSSLShutdown: Bool = false,
 933 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:953:20: error: cannot find type 'Proxy' in scope
 951 |             timeout: Timeout = Timeout(),
 952 |             connectionPool: TimeAmount = .seconds(60),
 953 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 954 |             ignoreUncleanSSLShutdown: Bool = false,
 955 |             decompression: Decompression = .disabled,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:975:20: error: cannot find type 'Proxy' in scope
 973 |             redirectConfiguration: RedirectConfiguration? = nil,
 974 |             timeout: Timeout = Timeout(),
 975 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 976 |             ignoreUncleanSSLShutdown: Bool = false,
 977 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:995:20: error: cannot find type 'Proxy' in scope
 993 |             timeout: Timeout = Timeout(),
 994 |             connectionPool: ConnectionPool = ConnectionPool(),
 995 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 996 |             ignoreUncleanSSLShutdown: Bool = false,
 997 |             decompression: Decompression = .disabled,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:35:39: error: cannot infer contextual base in reference to member 'fullVerification'
33 |         // To start with, let's go with these values. Obtained from Firefox's config.
34 |         HTTPClient.Configuration(
35 |             certificateVerification: .fullVerification,
   |                                       `- error: cannot infer contextual base in reference to member 'fullVerification'
36 |             redirectConfiguration: .follow(max: 20, allowCycles: false),
37 |             timeout: Timeout(connect: .seconds(90), read: .seconds(90)),

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:36:37: error: cannot infer contextual base in reference to member 'follow'
34 |         HTTPClient.Configuration(
35 |             certificateVerification: .fullVerification,
36 |             redirectConfiguration: .follow(max: 20, allowCycles: false),
   |                                     `- error: cannot infer contextual base in reference to member 'follow'
37 |             timeout: Timeout(connect: .seconds(90), read: .seconds(90)),
38 |             connectionPool: .seconds(600),

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:38:30: error: cannot infer contextual base in reference to member 'seconds'
36 |             redirectConfiguration: .follow(max: 20, allowCycles: false),
37 |             timeout: Timeout(connect: .seconds(90), read: .seconds(90)),
38 |             connectionPool: .seconds(600),
   |                              `- error: cannot infer contextual base in reference to member 'seconds'
39 |             proxy: nil,
40 |             ignoreUncleanSSLShutdown: false,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:39:20: error: 'nil' requires a contextual type
37 |             timeout: Timeout(connect: .seconds(90), read: .seconds(90)),
38 |             connectionPool: .seconds(600),
39 |             proxy: nil,
   |                    `- error: 'nil' requires a contextual type
40 |             ignoreUncleanSSLShutdown: false,
41 |             decompression: .enabled(limit: .ratio(25)),

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:41:29: error: cannot infer contextual base in reference to member 'enabled'
39 |             proxy: nil,
40 |             ignoreUncleanSSLShutdown: false,
41 |             decompression: .enabled(limit: .ratio(25)),
   |                             `- error: cannot infer contextual base in reference to member 'enabled'
42 |             backgroundActivityLogger: nil
43 |         )

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:41:45: error: cannot infer contextual base in reference to member 'ratio'
39 |             proxy: nil,
40 |             ignoreUncleanSSLShutdown: false,
41 |             decompression: .enabled(limit: .ratio(25)),
   |                                             `- error: cannot infer contextual base in reference to member 'ratio'
42 |             backgroundActivityLogger: nil
43 |         )

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:42:39: error: 'nil' requires a contextual type
40 |             ignoreUncleanSSLShutdown: false,
41 |             decompression: .enabled(limit: .ratio(25)),
42 |             backgroundActivityLogger: nil
   |                                       `- error: 'nil' requires a contextual type
43 |         )
44 |     }
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:892:20: error: cannot find type 'Proxy' in scope
 890 |             timeout: Timeout = Timeout(),
 891 |             connectionPool: ConnectionPool = ConnectionPool(),
 892 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 893 |             ignoreUncleanSSLShutdown: Bool = false,
 894 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:911:20: error: cannot find type 'Proxy' in scope
 909 |             redirectConfiguration: RedirectConfiguration? = nil,
 910 |             timeout: Timeout = Timeout(),
 911 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 912 |             ignoreUncleanSSLShutdown: Bool = false,
 913 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:931:20: error: cannot find type 'Proxy' in scope
 929 |             timeout: Timeout = Timeout(),
 930 |             maximumAllowedIdleTimeInConnectionPool: TimeAmount = .seconds(60),
 931 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 932 |             ignoreUncleanSSLShutdown: Bool = false,
 933 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:953:20: error: cannot find type 'Proxy' in scope
 951 |             timeout: Timeout = Timeout(),
 952 |             connectionPool: TimeAmount = .seconds(60),
 953 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 954 |             ignoreUncleanSSLShutdown: Bool = false,
 955 |             decompression: Decompression = .disabled,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:975:20: error: cannot find type 'Proxy' in scope
 973 |             redirectConfiguration: RedirectConfiguration? = nil,
 974 |             timeout: Timeout = Timeout(),
 975 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 976 |             ignoreUncleanSSLShutdown: Bool = false,
 977 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:995:20: error: cannot find type 'Proxy' in scope
 993 |             timeout: Timeout = Timeout(),
 994 |             connectionPool: ConnectionPool = ConnectionPool(),
 995 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 996 |             ignoreUncleanSSLShutdown: Bool = false,
 997 |             decompression: Decompression = .disabled,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:35:39: error: cannot infer contextual base in reference to member 'fullVerification'
33 |         // To start with, let's go with these values. Obtained from Firefox's config.
34 |         HTTPClient.Configuration(
35 |             certificateVerification: .fullVerification,
   |                                       `- error: cannot infer contextual base in reference to member 'fullVerification'
36 |             redirectConfiguration: .follow(max: 20, allowCycles: false),
37 |             timeout: Timeout(connect: .seconds(90), read: .seconds(90)),

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:36:37: error: cannot infer contextual base in reference to member 'follow'
34 |         HTTPClient.Configuration(
35 |             certificateVerification: .fullVerification,
36 |             redirectConfiguration: .follow(max: 20, allowCycles: false),
   |                                     `- error: cannot infer contextual base in reference to member 'follow'
37 |             timeout: Timeout(connect: .seconds(90), read: .seconds(90)),
38 |             connectionPool: .seconds(600),

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:38:30: error: cannot infer contextual base in reference to member 'seconds'
36 |             redirectConfiguration: .follow(max: 20, allowCycles: false),
37 |             timeout: Timeout(connect: .seconds(90), read: .seconds(90)),
38 |             connectionPool: .seconds(600),
   |                              `- error: cannot infer contextual base in reference to member 'seconds'
39 |             proxy: nil,
40 |             ignoreUncleanSSLShutdown: false,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:39:20: error: 'nil' requires a contextual type
37 |             timeout: Timeout(connect: .seconds(90), read: .seconds(90)),
38 |             connectionPool: .seconds(600),
39 |             proxy: nil,
   |                    `- error: 'nil' requires a contextual type
40 |             ignoreUncleanSSLShutdown: false,
41 |             decompression: .enabled(limit: .ratio(25)),

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:41:29: error: cannot infer contextual base in reference to member 'enabled'
39 |             proxy: nil,
40 |             ignoreUncleanSSLShutdown: false,
41 |             decompression: .enabled(limit: .ratio(25)),
   |                             `- error: cannot infer contextual base in reference to member 'enabled'
42 |             backgroundActivityLogger: nil
43 |         )

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:41:45: error: cannot infer contextual base in reference to member 'ratio'
39 |             proxy: nil,
40 |             ignoreUncleanSSLShutdown: false,
41 |             decompression: .enabled(limit: .ratio(25)),
   |                                             `- error: cannot infer contextual base in reference to member 'ratio'
42 |             backgroundActivityLogger: nil
43 |         )

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:42:39: error: 'nil' requires a contextual type
40 |             ignoreUncleanSSLShutdown: false,
41 |             decompression: .enabled(limit: .ratio(25)),
42 |             backgroundActivityLogger: nil
   |                                       `- error: 'nil' requires a contextual type
43 |         )
44 |     }
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:892:20: error: cannot find type 'Proxy' in scope
 890 |             timeout: Timeout = Timeout(),
 891 |             connectionPool: ConnectionPool = ConnectionPool(),
 892 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 893 |             ignoreUncleanSSLShutdown: Bool = false,
 894 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:911:20: error: cannot find type 'Proxy' in scope
 909 |             redirectConfiguration: RedirectConfiguration? = nil,
 910 |             timeout: Timeout = Timeout(),
 911 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 912 |             ignoreUncleanSSLShutdown: Bool = false,
 913 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:931:20: error: cannot find type 'Proxy' in scope
 929 |             timeout: Timeout = Timeout(),
 930 |             maximumAllowedIdleTimeInConnectionPool: TimeAmount = .seconds(60),
 931 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 932 |             ignoreUncleanSSLShutdown: Bool = false,
 933 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:953:20: error: cannot find type 'Proxy' in scope
 951 |             timeout: Timeout = Timeout(),
 952 |             connectionPool: TimeAmount = .seconds(60),
 953 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 954 |             ignoreUncleanSSLShutdown: Bool = false,
 955 |             decompression: Decompression = .disabled,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:975:20: error: cannot find type 'Proxy' in scope
 973 |             redirectConfiguration: RedirectConfiguration? = nil,
 974 |             timeout: Timeout = Timeout(),
 975 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 976 |             ignoreUncleanSSLShutdown: Bool = false,
 977 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:995:20: error: cannot find type 'Proxy' in scope
 993 |             timeout: Timeout = Timeout(),
 994 |             connectionPool: ConnectionPool = ConnectionPool(),
 995 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 996 |             ignoreUncleanSSLShutdown: Bool = false,
 997 |             decompression: Decompression = .disabled,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:35:39: error: cannot infer contextual base in reference to member 'fullVerification'
33 |         // To start with, let's go with these values. Obtained from Firefox's config.
34 |         HTTPClient.Configuration(
35 |             certificateVerification: .fullVerification,
   |                                       `- error: cannot infer contextual base in reference to member 'fullVerification'
36 |             redirectConfiguration: .follow(max: 20, allowCycles: false),
37 |             timeout: Timeout(connect: .seconds(90), read: .seconds(90)),

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:36:37: error: cannot infer contextual base in reference to member 'follow'
34 |         HTTPClient.Configuration(
35 |             certificateVerification: .fullVerification,
36 |             redirectConfiguration: .follow(max: 20, allowCycles: false),
   |                                     `- error: cannot infer contextual base in reference to member 'follow'
37 |             timeout: Timeout(connect: .seconds(90), read: .seconds(90)),
38 |             connectionPool: .seconds(600),

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:38:30: error: cannot infer contextual base in reference to member 'seconds'
36 |             redirectConfiguration: .follow(max: 20, allowCycles: false),
37 |             timeout: Timeout(connect: .seconds(90), read: .seconds(90)),
38 |             connectionPool: .seconds(600),
   |                              `- error: cannot infer contextual base in reference to member 'seconds'
39 |             proxy: nil,
40 |             ignoreUncleanSSLShutdown: false,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:39:20: error: 'nil' requires a contextual type
37 |             timeout: Timeout(connect: .seconds(90), read: .seconds(90)),
38 |             connectionPool: .seconds(600),
39 |             proxy: nil,
   |                    `- error: 'nil' requires a contextual type
40 |             ignoreUncleanSSLShutdown: false,
41 |             decompression: .enabled(limit: .ratio(25)),

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:41:29: error: cannot infer contextual base in reference to member 'enabled'
39 |             proxy: nil,
40 |             ignoreUncleanSSLShutdown: false,
41 |             decompression: .enabled(limit: .ratio(25)),
   |                             `- error: cannot infer contextual base in reference to member 'enabled'
42 |             backgroundActivityLogger: nil
43 |         )

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:41:45: error: cannot infer contextual base in reference to member 'ratio'
39 |             proxy: nil,
40 |             ignoreUncleanSSLShutdown: false,
41 |             decompression: .enabled(limit: .ratio(25)),
   |                                             `- error: cannot infer contextual base in reference to member 'ratio'
42 |             backgroundActivityLogger: nil
43 |         )

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:42:39: error: 'nil' requires a contextual type
40 |             ignoreUncleanSSLShutdown: false,
41 |             decompression: .enabled(limit: .ratio(25)),
42 |             backgroundActivityLogger: nil
   |                                       `- error: 'nil' requires a contextual type
43 |         )
44 |     }
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:892:20: error: cannot find type 'Proxy' in scope
 890 |             timeout: Timeout = Timeout(),
 891 |             connectionPool: ConnectionPool = ConnectionPool(),
 892 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 893 |             ignoreUncleanSSLShutdown: Bool = false,
 894 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:911:20: error: cannot find type 'Proxy' in scope
 909 |             redirectConfiguration: RedirectConfiguration? = nil,
 910 |             timeout: Timeout = Timeout(),
 911 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 912 |             ignoreUncleanSSLShutdown: Bool = false,
 913 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:931:20: error: cannot find type 'Proxy' in scope
 929 |             timeout: Timeout = Timeout(),
 930 |             maximumAllowedIdleTimeInConnectionPool: TimeAmount = .seconds(60),
 931 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 932 |             ignoreUncleanSSLShutdown: Bool = false,
 933 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:953:20: error: cannot find type 'Proxy' in scope
 951 |             timeout: Timeout = Timeout(),
 952 |             connectionPool: TimeAmount = .seconds(60),
 953 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 954 |             ignoreUncleanSSLShutdown: Bool = false,
 955 |             decompression: Decompression = .disabled,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:975:20: error: cannot find type 'Proxy' in scope
 973 |             redirectConfiguration: RedirectConfiguration? = nil,
 974 |             timeout: Timeout = Timeout(),
 975 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 976 |             ignoreUncleanSSLShutdown: Bool = false,
 977 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:995:20: error: cannot find type 'Proxy' in scope
 993 |             timeout: Timeout = Timeout(),
 994 |             connectionPool: ConnectionPool = ConnectionPool(),
 995 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 996 |             ignoreUncleanSSLShutdown: Bool = false,
 997 |             decompression: Decompression = .disabled,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:35:39: error: cannot infer contextual base in reference to member 'fullVerification'
33 |         // To start with, let's go with these values. Obtained from Firefox's config.
34 |         HTTPClient.Configuration(
35 |             certificateVerification: .fullVerification,
   |                                       `- error: cannot infer contextual base in reference to member 'fullVerification'
36 |             redirectConfiguration: .follow(max: 20, allowCycles: false),
37 |             timeout: Timeout(connect: .seconds(90), read: .seconds(90)),

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:36:37: error: cannot infer contextual base in reference to member 'follow'
34 |         HTTPClient.Configuration(
35 |             certificateVerification: .fullVerification,
36 |             redirectConfiguration: .follow(max: 20, allowCycles: false),
   |                                     `- error: cannot infer contextual base in reference to member 'follow'
37 |             timeout: Timeout(connect: .seconds(90), read: .seconds(90)),
38 |             connectionPool: .seconds(600),

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:38:30: error: cannot infer contextual base in reference to member 'seconds'
36 |             redirectConfiguration: .follow(max: 20, allowCycles: false),
37 |             timeout: Timeout(connect: .seconds(90), read: .seconds(90)),
38 |             connectionPool: .seconds(600),
   |                              `- error: cannot infer contextual base in reference to member 'seconds'
39 |             proxy: nil,
40 |             ignoreUncleanSSLShutdown: false,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:39:20: error: 'nil' requires a contextual type
37 |             timeout: Timeout(connect: .seconds(90), read: .seconds(90)),
38 |             connectionPool: .seconds(600),
39 |             proxy: nil,
   |                    `- error: 'nil' requires a contextual type
40 |             ignoreUncleanSSLShutdown: false,
41 |             decompression: .enabled(limit: .ratio(25)),

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:41:29: error: cannot infer contextual base in reference to member 'enabled'
39 |             proxy: nil,
40 |             ignoreUncleanSSLShutdown: false,
41 |             decompression: .enabled(limit: .ratio(25)),
   |                             `- error: cannot infer contextual base in reference to member 'enabled'
42 |             backgroundActivityLogger: nil
43 |         )

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:41:45: error: cannot infer contextual base in reference to member 'ratio'
39 |             proxy: nil,
40 |             ignoreUncleanSSLShutdown: false,
41 |             decompression: .enabled(limit: .ratio(25)),
   |                                             `- error: cannot infer contextual base in reference to member 'ratio'
42 |             backgroundActivityLogger: nil
43 |         )

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:42:39: error: 'nil' requires a contextual type
40 |             ignoreUncleanSSLShutdown: false,
41 |             decompression: .enabled(limit: .ratio(25)),
42 |             backgroundActivityLogger: nil
   |                                       `- error: 'nil' requires a contextual type
43 |         )
44 |     }
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:892:20: error: cannot find type 'Proxy' in scope
 890 |             timeout: Timeout = Timeout(),
 891 |             connectionPool: ConnectionPool = ConnectionPool(),
 892 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 893 |             ignoreUncleanSSLShutdown: Bool = false,
 894 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:911:20: error: cannot find type 'Proxy' in scope
 909 |             redirectConfiguration: RedirectConfiguration? = nil,
 910 |             timeout: Timeout = Timeout(),
 911 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 912 |             ignoreUncleanSSLShutdown: Bool = false,
 913 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:931:20: error: cannot find type 'Proxy' in scope
 929 |             timeout: Timeout = Timeout(),
 930 |             maximumAllowedIdleTimeInConnectionPool: TimeAmount = .seconds(60),
 931 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 932 |             ignoreUncleanSSLShutdown: Bool = false,
 933 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:953:20: error: cannot find type 'Proxy' in scope
 951 |             timeout: Timeout = Timeout(),
 952 |             connectionPool: TimeAmount = .seconds(60),
 953 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 954 |             ignoreUncleanSSLShutdown: Bool = false,
 955 |             decompression: Decompression = .disabled,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:975:20: error: cannot find type 'Proxy' in scope
 973 |             redirectConfiguration: RedirectConfiguration? = nil,
 974 |             timeout: Timeout = Timeout(),
 975 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 976 |             ignoreUncleanSSLShutdown: Bool = false,
 977 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:995:20: error: cannot find type 'Proxy' in scope
 993 |             timeout: Timeout = Timeout(),
 994 |             connectionPool: ConnectionPool = ConnectionPool(),
 995 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 996 |             ignoreUncleanSSLShutdown: Bool = false,
 997 |             decompression: Decompression = .disabled,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:35:39: error: cannot infer contextual base in reference to member 'fullVerification'
33 |         // To start with, let's go with these values. Obtained from Firefox's config.
34 |         HTTPClient.Configuration(
35 |             certificateVerification: .fullVerification,
   |                                       `- error: cannot infer contextual base in reference to member 'fullVerification'
36 |             redirectConfiguration: .follow(max: 20, allowCycles: false),
37 |             timeout: Timeout(connect: .seconds(90), read: .seconds(90)),

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:36:37: error: cannot infer contextual base in reference to member 'follow'
34 |         HTTPClient.Configuration(
35 |             certificateVerification: .fullVerification,
36 |             redirectConfiguration: .follow(max: 20, allowCycles: false),
   |                                     `- error: cannot infer contextual base in reference to member 'follow'
37 |             timeout: Timeout(connect: .seconds(90), read: .seconds(90)),
38 |             connectionPool: .seconds(600),

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:38:30: error: cannot infer contextual base in reference to member 'seconds'
36 |             redirectConfiguration: .follow(max: 20, allowCycles: false),
37 |             timeout: Timeout(connect: .seconds(90), read: .seconds(90)),
38 |             connectionPool: .seconds(600),
   |                              `- error: cannot infer contextual base in reference to member 'seconds'
39 |             proxy: nil,
40 |             ignoreUncleanSSLShutdown: false,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:39:20: error: 'nil' requires a contextual type
37 |             timeout: Timeout(connect: .seconds(90), read: .seconds(90)),
38 |             connectionPool: .seconds(600),
39 |             proxy: nil,
   |                    `- error: 'nil' requires a contextual type
40 |             ignoreUncleanSSLShutdown: false,
41 |             decompression: .enabled(limit: .ratio(25)),

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:41:29: error: cannot infer contextual base in reference to member 'enabled'
39 |             proxy: nil,
40 |             ignoreUncleanSSLShutdown: false,
41 |             decompression: .enabled(limit: .ratio(25)),
   |                             `- error: cannot infer contextual base in reference to member 'enabled'
42 |             backgroundActivityLogger: nil
43 |         )

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:41:45: error: cannot infer contextual base in reference to member 'ratio'
39 |             proxy: nil,
40 |             ignoreUncleanSSLShutdown: false,
41 |             decompression: .enabled(limit: .ratio(25)),
   |                                             `- error: cannot infer contextual base in reference to member 'ratio'
42 |             backgroundActivityLogger: nil
43 |         )

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:42:39: error: 'nil' requires a contextual type
40 |             ignoreUncleanSSLShutdown: false,
41 |             decompression: .enabled(limit: .ratio(25)),
42 |             backgroundActivityLogger: nil
   |                                       `- error: 'nil' requires a contextual type
43 |         )
44 |     }
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:892:20: error: cannot find type 'Proxy' in scope
 890 |             timeout: Timeout = Timeout(),
 891 |             connectionPool: ConnectionPool = ConnectionPool(),
 892 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 893 |             ignoreUncleanSSLShutdown: Bool = false,
 894 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:911:20: error: cannot find type 'Proxy' in scope
 909 |             redirectConfiguration: RedirectConfiguration? = nil,
 910 |             timeout: Timeout = Timeout(),
 911 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 912 |             ignoreUncleanSSLShutdown: Bool = false,
 913 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:931:20: error: cannot find type 'Proxy' in scope
 929 |             timeout: Timeout = Timeout(),
 930 |             maximumAllowedIdleTimeInConnectionPool: TimeAmount = .seconds(60),
 931 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 932 |             ignoreUncleanSSLShutdown: Bool = false,
 933 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:953:20: error: cannot find type 'Proxy' in scope
 951 |             timeout: Timeout = Timeout(),
 952 |             connectionPool: TimeAmount = .seconds(60),
 953 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 954 |             ignoreUncleanSSLShutdown: Bool = false,
 955 |             decompression: Decompression = .disabled,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:975:20: error: cannot find type 'Proxy' in scope
 973 |             redirectConfiguration: RedirectConfiguration? = nil,
 974 |             timeout: Timeout = Timeout(),
 975 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 976 |             ignoreUncleanSSLShutdown: Bool = false,
 977 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:995:20: error: cannot find type 'Proxy' in scope
 993 |             timeout: Timeout = Timeout(),
 994 |             connectionPool: ConnectionPool = ConnectionPool(),
 995 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 996 |             ignoreUncleanSSLShutdown: Bool = false,
 997 |             decompression: Decompression = .disabled,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:35:39: error: cannot infer contextual base in reference to member 'fullVerification'
33 |         // To start with, let's go with these values. Obtained from Firefox's config.
34 |         HTTPClient.Configuration(
35 |             certificateVerification: .fullVerification,
   |                                       `- error: cannot infer contextual base in reference to member 'fullVerification'
36 |             redirectConfiguration: .follow(max: 20, allowCycles: false),
37 |             timeout: Timeout(connect: .seconds(90), read: .seconds(90)),

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:36:37: error: cannot infer contextual base in reference to member 'follow'
34 |         HTTPClient.Configuration(
35 |             certificateVerification: .fullVerification,
36 |             redirectConfiguration: .follow(max: 20, allowCycles: false),
   |                                     `- error: cannot infer contextual base in reference to member 'follow'
37 |             timeout: Timeout(connect: .seconds(90), read: .seconds(90)),
38 |             connectionPool: .seconds(600),

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:38:30: error: cannot infer contextual base in reference to member 'seconds'
36 |             redirectConfiguration: .follow(max: 20, allowCycles: false),
37 |             timeout: Timeout(connect: .seconds(90), read: .seconds(90)),
38 |             connectionPool: .seconds(600),
   |                              `- error: cannot infer contextual base in reference to member 'seconds'
39 |             proxy: nil,
40 |             ignoreUncleanSSLShutdown: false,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:39:20: error: 'nil' requires a contextual type
37 |             timeout: Timeout(connect: .seconds(90), read: .seconds(90)),
38 |             connectionPool: .seconds(600),
39 |             proxy: nil,
   |                    `- error: 'nil' requires a contextual type
40 |             ignoreUncleanSSLShutdown: false,
41 |             decompression: .enabled(limit: .ratio(25)),

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:41:29: error: cannot infer contextual base in reference to member 'enabled'
39 |             proxy: nil,
40 |             ignoreUncleanSSLShutdown: false,
41 |             decompression: .enabled(limit: .ratio(25)),
   |                             `- error: cannot infer contextual base in reference to member 'enabled'
42 |             backgroundActivityLogger: nil
43 |         )

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:41:45: error: cannot infer contextual base in reference to member 'ratio'
39 |             proxy: nil,
40 |             ignoreUncleanSSLShutdown: false,
41 |             decompression: .enabled(limit: .ratio(25)),
   |                                             `- error: cannot infer contextual base in reference to member 'ratio'
42 |             backgroundActivityLogger: nil
43 |         )

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/Configuration+BrowserLike.swift:42:39: error: 'nil' requires a contextual type
40 |             ignoreUncleanSSLShutdown: false,
41 |             decompression: .enabled(limit: .ratio(25)),
42 |             backgroundActivityLogger: nil
   |                                       `- error: 'nil' requires a contextual type
43 |         )
44 |     }
error: emit-module command failed with exit code 1 (use -v to see invocation)
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/ConnectionPool/HTTPConnectionPool+Factory.swift:255:43: error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
253 | 
254 |     private func makeHTTPProxyChannel<Requester: HTTPConnectionRequester>(
255 |         _ proxy: HTTPClient.Configuration.Proxy,
    |                                           `- error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
256 |         requester: Requester,
257 |         connectionID: HTTPConnectionPool.Connection.ID,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:807:19: note: 'Configuration' declared here
 805 | 
 806 |     /// ``HTTPClient`` configuration.
 807 |     public struct Configuration {
     |                   `- note: 'Configuration' declared here
 808 |         /// TLS configuration, defaults to `TLSConfiguration.makeClientConfiguration()`.
 809 |         public var tlsConfiguration: Optional<TLSConfiguration>

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/ConnectionPool/HTTPConnectionPool+Factory.swift:303:43: error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
301 | 
302 |     private func makeSOCKSProxyChannel<Requester: HTTPConnectionRequester>(
303 |         _ proxy: HTTPClient.Configuration.Proxy,
    |                                           `- error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
304 |         requester: Requester,
305 |         connectionID: HTTPConnectionPool.Connection.ID,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:807:19: note: 'Configuration' declared here
 805 | 
 806 |     /// ``HTTPClient`` configuration.
 807 |     public struct Configuration {
     |                   `- note: 'Configuration' declared here
 808 |         /// TLS configuration, defaults to `TLSConfiguration.makeClientConfiguration()`.
 809 |         public var tlsConfiguration: Optional<TLSConfiguration>

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:892:20: error: cannot find type 'Proxy' in scope
 890 |             timeout: Timeout = Timeout(),
 891 |             connectionPool: ConnectionPool = ConnectionPool(),
 892 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 893 |             ignoreUncleanSSLShutdown: Bool = false,
 894 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:911:20: error: cannot find type 'Proxy' in scope
 909 |             redirectConfiguration: RedirectConfiguration? = nil,
 910 |             timeout: Timeout = Timeout(),
 911 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 912 |             ignoreUncleanSSLShutdown: Bool = false,
 913 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:931:20: error: cannot find type 'Proxy' in scope
 929 |             timeout: Timeout = Timeout(),
 930 |             maximumAllowedIdleTimeInConnectionPool: TimeAmount = .seconds(60),
 931 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 932 |             ignoreUncleanSSLShutdown: Bool = false,
 933 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:953:20: error: cannot find type 'Proxy' in scope
 951 |             timeout: Timeout = Timeout(),
 952 |             connectionPool: TimeAmount = .seconds(60),
 953 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 954 |             ignoreUncleanSSLShutdown: Bool = false,
 955 |             decompression: Decompression = .disabled,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:975:20: error: cannot find type 'Proxy' in scope
 973 |             redirectConfiguration: RedirectConfiguration? = nil,
 974 |             timeout: Timeout = Timeout(),
 975 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 976 |             ignoreUncleanSSLShutdown: Bool = false,
 977 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:995:20: error: cannot find type 'Proxy' in scope
 993 |             timeout: Timeout = Timeout(),
 994 |             connectionPool: ConnectionPool = ConnectionPool(),
 995 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 996 |             ignoreUncleanSSLShutdown: Bool = false,
 997 |             decompression: Decompression = .disabled,
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/ConnectionPool/HTTPConnectionPool+Factory.swift:255:43: error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
253 | 
254 |     private func makeHTTPProxyChannel<Requester: HTTPConnectionRequester>(
255 |         _ proxy: HTTPClient.Configuration.Proxy,
    |                                           `- error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
256 |         requester: Requester,
257 |         connectionID: HTTPConnectionPool.Connection.ID,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:807:19: note: 'Configuration' declared here
 805 | 
 806 |     /// ``HTTPClient`` configuration.
 807 |     public struct Configuration {
     |                   `- note: 'Configuration' declared here
 808 |         /// TLS configuration, defaults to `TLSConfiguration.makeClientConfiguration()`.
 809 |         public var tlsConfiguration: Optional<TLSConfiguration>

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/ConnectionPool/HTTPConnectionPool+Factory.swift:303:43: error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
301 | 
302 |     private func makeSOCKSProxyChannel<Requester: HTTPConnectionRequester>(
303 |         _ proxy: HTTPClient.Configuration.Proxy,
    |                                           `- error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
304 |         requester: Requester,
305 |         connectionID: HTTPConnectionPool.Connection.ID,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:807:19: note: 'Configuration' declared here
 805 | 
 806 |     /// ``HTTPClient`` configuration.
 807 |     public struct Configuration {
     |                   `- note: 'Configuration' declared here
 808 |         /// TLS configuration, defaults to `TLSConfiguration.makeClientConfiguration()`.
 809 |         public var tlsConfiguration: Optional<TLSConfiguration>
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/ConnectionPool/HTTPConnectionPool+Factory.swift:255:43: error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
253 | 
254 |     private func makeHTTPProxyChannel<Requester: HTTPConnectionRequester>(
255 |         _ proxy: HTTPClient.Configuration.Proxy,
    |                                           `- error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
256 |         requester: Requester,
257 |         connectionID: HTTPConnectionPool.Connection.ID,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:807:19: note: 'Configuration' declared here
 805 | 
 806 |     /// ``HTTPClient`` configuration.
 807 |     public struct Configuration {
     |                   `- note: 'Configuration' declared here
 808 |         /// TLS configuration, defaults to `TLSConfiguration.makeClientConfiguration()`.
 809 |         public var tlsConfiguration: Optional<TLSConfiguration>

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/ConnectionPool/HTTPConnectionPool+Factory.swift:303:43: error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
301 | 
302 |     private func makeSOCKSProxyChannel<Requester: HTTPConnectionRequester>(
303 |         _ proxy: HTTPClient.Configuration.Proxy,
    |                                           `- error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
304 |         requester: Requester,
305 |         connectionID: HTTPConnectionPool.Connection.ID,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:807:19: note: 'Configuration' declared here
 805 | 
 806 |     /// ``HTTPClient`` configuration.
 807 |     public struct Configuration {
     |                   `- note: 'Configuration' declared here
 808 |         /// TLS configuration, defaults to `TLSConfiguration.makeClientConfiguration()`.
 809 |         public var tlsConfiguration: Optional<TLSConfiguration>
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/ConnectionPool/HTTPConnectionPool+Factory.swift:255:43: error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
253 | 
254 |     private func makeHTTPProxyChannel<Requester: HTTPConnectionRequester>(
255 |         _ proxy: HTTPClient.Configuration.Proxy,
    |                                           `- error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
256 |         requester: Requester,
257 |         connectionID: HTTPConnectionPool.Connection.ID,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:807:19: note: 'Configuration' declared here
 805 | 
 806 |     /// ``HTTPClient`` configuration.
 807 |     public struct Configuration {
     |                   `- note: 'Configuration' declared here
 808 |         /// TLS configuration, defaults to `TLSConfiguration.makeClientConfiguration()`.
 809 |         public var tlsConfiguration: Optional<TLSConfiguration>

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/ConnectionPool/HTTPConnectionPool+Factory.swift:303:43: error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
301 | 
302 |     private func makeSOCKSProxyChannel<Requester: HTTPConnectionRequester>(
303 |         _ proxy: HTTPClient.Configuration.Proxy,
    |                                           `- error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
304 |         requester: Requester,
305 |         connectionID: HTTPConnectionPool.Connection.ID,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:807:19: note: 'Configuration' declared here
 805 | 
 806 |     /// ``HTTPClient`` configuration.
 807 |     public struct Configuration {
     |                   `- note: 'Configuration' declared here
 808 |         /// TLS configuration, defaults to `TLSConfiguration.makeClientConfiguration()`.
 809 |         public var tlsConfiguration: Optional<TLSConfiguration>
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/ConnectionPool/HTTPConnectionPool+Factory.swift:255:43: error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
253 | 
254 |     private func makeHTTPProxyChannel<Requester: HTTPConnectionRequester>(
255 |         _ proxy: HTTPClient.Configuration.Proxy,
    |                                           `- error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
256 |         requester: Requester,
257 |         connectionID: HTTPConnectionPool.Connection.ID,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:807:19: note: 'Configuration' declared here
 805 | 
 806 |     /// ``HTTPClient`` configuration.
 807 |     public struct Configuration {
     |                   `- note: 'Configuration' declared here
 808 |         /// TLS configuration, defaults to `TLSConfiguration.makeClientConfiguration()`.
 809 |         public var tlsConfiguration: Optional<TLSConfiguration>

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/ConnectionPool/HTTPConnectionPool+Factory.swift:303:43: error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
301 | 
302 |     private func makeSOCKSProxyChannel<Requester: HTTPConnectionRequester>(
303 |         _ proxy: HTTPClient.Configuration.Proxy,
    |                                           `- error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
304 |         requester: Requester,
305 |         connectionID: HTTPConnectionPool.Connection.ID,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:807:19: note: 'Configuration' declared here
 805 | 
 806 |     /// ``HTTPClient`` configuration.
 807 |     public struct Configuration {
     |                   `- note: 'Configuration' declared here
 808 |         /// TLS configuration, defaults to `TLSConfiguration.makeClientConfiguration()`.
 809 |         public var tlsConfiguration: Optional<TLSConfiguration>
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/ConnectionPool/HTTPConnectionPool+Factory.swift:255:43: error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
253 | 
254 |     private func makeHTTPProxyChannel<Requester: HTTPConnectionRequester>(
255 |         _ proxy: HTTPClient.Configuration.Proxy,
    |                                           `- error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
256 |         requester: Requester,
257 |         connectionID: HTTPConnectionPool.Connection.ID,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:807:19: note: 'Configuration' declared here
 805 | 
 806 |     /// ``HTTPClient`` configuration.
 807 |     public struct Configuration {
     |                   `- note: 'Configuration' declared here
 808 |         /// TLS configuration, defaults to `TLSConfiguration.makeClientConfiguration()`.
 809 |         public var tlsConfiguration: Optional<TLSConfiguration>

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/ConnectionPool/HTTPConnectionPool+Factory.swift:303:43: error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
301 | 
302 |     private func makeSOCKSProxyChannel<Requester: HTTPConnectionRequester>(
303 |         _ proxy: HTTPClient.Configuration.Proxy,
    |                                           `- error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
304 |         requester: Requester,
305 |         connectionID: HTTPConnectionPool.Connection.ID,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:807:19: note: 'Configuration' declared here
 805 | 
 806 |     /// ``HTTPClient`` configuration.
 807 |     public struct Configuration {
     |                   `- note: 'Configuration' declared here
 808 |         /// TLS configuration, defaults to `TLSConfiguration.makeClientConfiguration()`.
 809 |         public var tlsConfiguration: Optional<TLSConfiguration>
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/ConnectionPool/HTTPConnectionPool+Factory.swift:255:43: error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
253 | 
254 |     private func makeHTTPProxyChannel<Requester: HTTPConnectionRequester>(
255 |         _ proxy: HTTPClient.Configuration.Proxy,
    |                                           `- error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
256 |         requester: Requester,
257 |         connectionID: HTTPConnectionPool.Connection.ID,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:807:19: note: 'Configuration' declared here
 805 | 
 806 |     /// ``HTTPClient`` configuration.
 807 |     public struct Configuration {
     |                   `- note: 'Configuration' declared here
 808 |         /// TLS configuration, defaults to `TLSConfiguration.makeClientConfiguration()`.
 809 |         public var tlsConfiguration: Optional<TLSConfiguration>

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/ConnectionPool/HTTPConnectionPool+Factory.swift:303:43: error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
301 | 
302 |     private func makeSOCKSProxyChannel<Requester: HTTPConnectionRequester>(
303 |         _ proxy: HTTPClient.Configuration.Proxy,
    |                                           `- error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
304 |         requester: Requester,
305 |         connectionID: HTTPConnectionPool.Connection.ID,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:807:19: note: 'Configuration' declared here
 805 | 
 806 |     /// ``HTTPClient`` configuration.
 807 |     public struct Configuration {
     |                   `- note: 'Configuration' declared here
 808 |         /// TLS configuration, defaults to `TLSConfiguration.makeClientConfiguration()`.
 809 |         public var tlsConfiguration: Optional<TLSConfiguration>
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/ConnectionPool/HTTPConnectionPool+Factory.swift:255:43: error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
253 | 
254 |     private func makeHTTPProxyChannel<Requester: HTTPConnectionRequester>(
255 |         _ proxy: HTTPClient.Configuration.Proxy,
    |                                           `- error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
256 |         requester: Requester,
257 |         connectionID: HTTPConnectionPool.Connection.ID,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:807:19: note: 'Configuration' declared here
 805 | 
 806 |     /// ``HTTPClient`` configuration.
 807 |     public struct Configuration {
     |                   `- note: 'Configuration' declared here
 808 |         /// TLS configuration, defaults to `TLSConfiguration.makeClientConfiguration()`.
 809 |         public var tlsConfiguration: Optional<TLSConfiguration>

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/ConnectionPool/HTTPConnectionPool+Factory.swift:303:43: error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
301 | 
302 |     private func makeSOCKSProxyChannel<Requester: HTTPConnectionRequester>(
303 |         _ proxy: HTTPClient.Configuration.Proxy,
    |                                           `- error: 'Proxy' is not a member type of struct 'AsyncHTTPClient.HTTPClient.Configuration'
304 |         requester: Requester,
305 |         connectionID: HTTPConnectionPool.Connection.ID,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:807:19: note: 'Configuration' declared here
 805 | 
 806 |     /// ``HTTPClient`` configuration.
 807 |     public struct Configuration {
     |                   `- note: 'Configuration' declared here
 808 |         /// TLS configuration, defaults to `TLSConfiguration.makeClientConfiguration()`.
 809 |         public var tlsConfiguration: Optional<TLSConfiguration>
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:892:20: error: cannot find type 'Proxy' in scope
 890 |             timeout: Timeout = Timeout(),
 891 |             connectionPool: ConnectionPool = ConnectionPool(),
 892 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 893 |             ignoreUncleanSSLShutdown: Bool = false,
 894 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:911:20: error: cannot find type 'Proxy' in scope
 909 |             redirectConfiguration: RedirectConfiguration? = nil,
 910 |             timeout: Timeout = Timeout(),
 911 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 912 |             ignoreUncleanSSLShutdown: Bool = false,
 913 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:931:20: error: cannot find type 'Proxy' in scope
 929 |             timeout: Timeout = Timeout(),
 930 |             maximumAllowedIdleTimeInConnectionPool: TimeAmount = .seconds(60),
 931 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 932 |             ignoreUncleanSSLShutdown: Bool = false,
 933 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:953:20: error: cannot find type 'Proxy' in scope
 951 |             timeout: Timeout = Timeout(),
 952 |             connectionPool: TimeAmount = .seconds(60),
 953 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 954 |             ignoreUncleanSSLShutdown: Bool = false,
 955 |             decompression: Decompression = .disabled,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:975:20: error: cannot find type 'Proxy' in scope
 973 |             redirectConfiguration: RedirectConfiguration? = nil,
 974 |             timeout: Timeout = Timeout(),
 975 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 976 |             ignoreUncleanSSLShutdown: Bool = false,
 977 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:995:20: error: cannot find type 'Proxy' in scope
 993 |             timeout: Timeout = Timeout(),
 994 |             connectionPool: ConnectionPool = ConnectionPool(),
 995 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 996 |             ignoreUncleanSSLShutdown: Bool = false,
 997 |             decompression: Decompression = .disabled,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:983:58: error: cannot infer contextual base in reference to member 'seconds'
 981 |                 redirectConfiguration: redirectConfiguration,
 982 |                 timeout: timeout,
 983 |                 maximumAllowedIdleTimeInConnectionPool: .seconds(60),
     |                                                          `- error: cannot infer contextual base in reference to member 'seconds'
 984 |                 proxy: proxy,
 985 |                 ignoreUncleanSSLShutdown: ignoreUncleanSSLShutdown,
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:892:20: error: cannot find type 'Proxy' in scope
 890 |             timeout: Timeout = Timeout(),
 891 |             connectionPool: ConnectionPool = ConnectionPool(),
 892 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 893 |             ignoreUncleanSSLShutdown: Bool = false,
 894 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:911:20: error: cannot find type 'Proxy' in scope
 909 |             redirectConfiguration: RedirectConfiguration? = nil,
 910 |             timeout: Timeout = Timeout(),
 911 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 912 |             ignoreUncleanSSLShutdown: Bool = false,
 913 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:931:20: error: cannot find type 'Proxy' in scope
 929 |             timeout: Timeout = Timeout(),
 930 |             maximumAllowedIdleTimeInConnectionPool: TimeAmount = .seconds(60),
 931 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 932 |             ignoreUncleanSSLShutdown: Bool = false,
 933 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:953:20: error: cannot find type 'Proxy' in scope
 951 |             timeout: Timeout = Timeout(),
 952 |             connectionPool: TimeAmount = .seconds(60),
 953 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 954 |             ignoreUncleanSSLShutdown: Bool = false,
 955 |             decompression: Decompression = .disabled,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:975:20: error: cannot find type 'Proxy' in scope
 973 |             redirectConfiguration: RedirectConfiguration? = nil,
 974 |             timeout: Timeout = Timeout(),
 975 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 976 |             ignoreUncleanSSLShutdown: Bool = false,
 977 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:995:20: error: cannot find type 'Proxy' in scope
 993 |             timeout: Timeout = Timeout(),
 994 |             connectionPool: ConnectionPool = ConnectionPool(),
 995 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 996 |             ignoreUncleanSSLShutdown: Bool = false,
 997 |             decompression: Decompression = .disabled,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:983:58: error: cannot infer contextual base in reference to member 'seconds'
 981 |                 redirectConfiguration: redirectConfiguration,
 982 |                 timeout: timeout,
 983 |                 maximumAllowedIdleTimeInConnectionPool: .seconds(60),
     |                                                          `- error: cannot infer contextual base in reference to member 'seconds'
 984 |                 proxy: proxy,
 985 |                 ignoreUncleanSSLShutdown: ignoreUncleanSSLShutdown,
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:892:20: error: cannot find type 'Proxy' in scope
 890 |             timeout: Timeout = Timeout(),
 891 |             connectionPool: ConnectionPool = ConnectionPool(),
 892 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 893 |             ignoreUncleanSSLShutdown: Bool = false,
 894 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:911:20: error: cannot find type 'Proxy' in scope
 909 |             redirectConfiguration: RedirectConfiguration? = nil,
 910 |             timeout: Timeout = Timeout(),
 911 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 912 |             ignoreUncleanSSLShutdown: Bool = false,
 913 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:931:20: error: cannot find type 'Proxy' in scope
 929 |             timeout: Timeout = Timeout(),
 930 |             maximumAllowedIdleTimeInConnectionPool: TimeAmount = .seconds(60),
 931 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 932 |             ignoreUncleanSSLShutdown: Bool = false,
 933 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:953:20: error: cannot find type 'Proxy' in scope
 951 |             timeout: Timeout = Timeout(),
 952 |             connectionPool: TimeAmount = .seconds(60),
 953 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 954 |             ignoreUncleanSSLShutdown: Bool = false,
 955 |             decompression: Decompression = .disabled,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:975:20: error: cannot find type 'Proxy' in scope
 973 |             redirectConfiguration: RedirectConfiguration? = nil,
 974 |             timeout: Timeout = Timeout(),
 975 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 976 |             ignoreUncleanSSLShutdown: Bool = false,
 977 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:995:20: error: cannot find type 'Proxy' in scope
 993 |             timeout: Timeout = Timeout(),
 994 |             connectionPool: ConnectionPool = ConnectionPool(),
 995 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 996 |             ignoreUncleanSSLShutdown: Bool = false,
 997 |             decompression: Decompression = .disabled,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:983:58: error: cannot infer contextual base in reference to member 'seconds'
 981 |                 redirectConfiguration: redirectConfiguration,
 982 |                 timeout: timeout,
 983 |                 maximumAllowedIdleTimeInConnectionPool: .seconds(60),
     |                                                          `- error: cannot infer contextual base in reference to member 'seconds'
 984 |                 proxy: proxy,
 985 |                 ignoreUncleanSSLShutdown: ignoreUncleanSSLShutdown,
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:892:20: error: cannot find type 'Proxy' in scope
 890 |             timeout: Timeout = Timeout(),
 891 |             connectionPool: ConnectionPool = ConnectionPool(),
 892 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 893 |             ignoreUncleanSSLShutdown: Bool = false,
 894 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:911:20: error: cannot find type 'Proxy' in scope
 909 |             redirectConfiguration: RedirectConfiguration? = nil,
 910 |             timeout: Timeout = Timeout(),
 911 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 912 |             ignoreUncleanSSLShutdown: Bool = false,
 913 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:931:20: error: cannot find type 'Proxy' in scope
 929 |             timeout: Timeout = Timeout(),
 930 |             maximumAllowedIdleTimeInConnectionPool: TimeAmount = .seconds(60),
 931 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 932 |             ignoreUncleanSSLShutdown: Bool = false,
 933 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:953:20: error: cannot find type 'Proxy' in scope
 951 |             timeout: Timeout = Timeout(),
 952 |             connectionPool: TimeAmount = .seconds(60),
 953 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 954 |             ignoreUncleanSSLShutdown: Bool = false,
 955 |             decompression: Decompression = .disabled,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:975:20: error: cannot find type 'Proxy' in scope
 973 |             redirectConfiguration: RedirectConfiguration? = nil,
 974 |             timeout: Timeout = Timeout(),
 975 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 976 |             ignoreUncleanSSLShutdown: Bool = false,
 977 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:995:20: error: cannot find type 'Proxy' in scope
 993 |             timeout: Timeout = Timeout(),
 994 |             connectionPool: ConnectionPool = ConnectionPool(),
 995 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 996 |             ignoreUncleanSSLShutdown: Bool = false,
 997 |             decompression: Decompression = .disabled,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:983:58: error: cannot infer contextual base in reference to member 'seconds'
 981 |                 redirectConfiguration: redirectConfiguration,
 982 |                 timeout: timeout,
 983 |                 maximumAllowedIdleTimeInConnectionPool: .seconds(60),
     |                                                          `- error: cannot infer contextual base in reference to member 'seconds'
 984 |                 proxy: proxy,
 985 |                 ignoreUncleanSSLShutdown: ignoreUncleanSSLShutdown,
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:892:20: error: cannot find type 'Proxy' in scope
 890 |             timeout: Timeout = Timeout(),
 891 |             connectionPool: ConnectionPool = ConnectionPool(),
 892 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 893 |             ignoreUncleanSSLShutdown: Bool = false,
 894 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:911:20: error: cannot find type 'Proxy' in scope
 909 |             redirectConfiguration: RedirectConfiguration? = nil,
 910 |             timeout: Timeout = Timeout(),
 911 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 912 |             ignoreUncleanSSLShutdown: Bool = false,
 913 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:931:20: error: cannot find type 'Proxy' in scope
 929 |             timeout: Timeout = Timeout(),
 930 |             maximumAllowedIdleTimeInConnectionPool: TimeAmount = .seconds(60),
 931 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 932 |             ignoreUncleanSSLShutdown: Bool = false,
 933 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:953:20: error: cannot find type 'Proxy' in scope
 951 |             timeout: Timeout = Timeout(),
 952 |             connectionPool: TimeAmount = .seconds(60),
 953 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 954 |             ignoreUncleanSSLShutdown: Bool = false,
 955 |             decompression: Decompression = .disabled,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:975:20: error: cannot find type 'Proxy' in scope
 973 |             redirectConfiguration: RedirectConfiguration? = nil,
 974 |             timeout: Timeout = Timeout(),
 975 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 976 |             ignoreUncleanSSLShutdown: Bool = false,
 977 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:995:20: error: cannot find type 'Proxy' in scope
 993 |             timeout: Timeout = Timeout(),
 994 |             connectionPool: ConnectionPool = ConnectionPool(),
 995 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 996 |             ignoreUncleanSSLShutdown: Bool = false,
 997 |             decompression: Decompression = .disabled,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:983:58: error: cannot infer contextual base in reference to member 'seconds'
 981 |                 redirectConfiguration: redirectConfiguration,
 982 |                 timeout: timeout,
 983 |                 maximumAllowedIdleTimeInConnectionPool: .seconds(60),
     |                                                          `- error: cannot infer contextual base in reference to member 'seconds'
 984 |                 proxy: proxy,
 985 |                 ignoreUncleanSSLShutdown: ignoreUncleanSSLShutdown,
/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:892:20: error: cannot find type 'Proxy' in scope
 890 |             timeout: Timeout = Timeout(),
 891 |             connectionPool: ConnectionPool = ConnectionPool(),
 892 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 893 |             ignoreUncleanSSLShutdown: Bool = false,
 894 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:911:20: error: cannot find type 'Proxy' in scope
 909 |             redirectConfiguration: RedirectConfiguration? = nil,
 910 |             timeout: Timeout = Timeout(),
 911 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 912 |             ignoreUncleanSSLShutdown: Bool = false,
 913 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:931:20: error: cannot find type 'Proxy' in scope
 929 |             timeout: Timeout = Timeout(),
 930 |             maximumAllowedIdleTimeInConnectionPool: TimeAmount = .seconds(60),
 931 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 932 |             ignoreUncleanSSLShutdown: Bool = false,
 933 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:953:20: error: cannot find type 'Proxy' in scope
 951 |             timeout: Timeout = Timeout(),
 952 |             connectionPool: TimeAmount = .seconds(60),
 953 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 954 |             ignoreUncleanSSLShutdown: Bool = false,
 955 |             decompression: Decompression = .disabled,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:975:20: error: cannot find type 'Proxy' in scope
 973 |             redirectConfiguration: RedirectConfiguration? = nil,
 974 |             timeout: Timeout = Timeout(),
 975 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 976 |             ignoreUncleanSSLShutdown: Bool = false,
 977 |             decompression: Decompression = .disabled

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:995:20: error: cannot find type 'Proxy' in scope
 993 |             timeout: Timeout = Timeout(),
 994 |             connectionPool: ConnectionPool = ConnectionPool(),
 995 |             proxy: Proxy? = nil,
     |                    `- error: cannot find type 'Proxy' in scope
 996 |             ignoreUncleanSSLShutdown: Bool = false,
 997 |             decompression: Decompression = .disabled,

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:838:27: error: cannot find type 'Proxy' in scope
 836 |         public var connectionPool: ConnectionPool
 837 |         /// Upstream proxy, defaults to no proxy.
 838 |         public var proxy: Proxy?
     |                           `- error: cannot find type 'Proxy' in scope
 839 |         /// Enables automatic body decompression. Supported algorithms are gzip and deflate.
 840 |         public var decompression: Decompression

/Users/hansaxelsson/Documents/Documents - Hans’s Mac mini - 2/SyntraFoundation/.build/checkouts/async-http-client/Sources/AsyncHTTPClient/HTTPClient.swift:983:58: error: cannot infer contextual base in reference to member 'seconds'
 981 |                 redirectConfiguration: redirectConfiguration,
 982 |                 timeout: timeout,
 983 |                 maximumAllowedIdleTimeInConnectionPool: .seconds(60),
     |                                                          `- error: cannot infer contextual base in reference to member 'seconds'
 984 |                 proxy: proxy,
 985 |                 ignoreUncleanSSLShutdown: ignoreUncleanSSLShutdown,
[1720/1723] Compiling AsyncHTTPClient RequestValidation.swift
