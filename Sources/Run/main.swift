import App
import Vapor
import JWT

var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)
let app = Application(env)
defer { app.shutdown() }
try configure(app)
try app.run()

//try app.jwt.signers.use(.es256(key: .generate()))
//try app.jwt.signers.use(.hs256(key: .init(data: "asdfssas".data(using: .utf8)!)))
