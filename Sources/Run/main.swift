import App
import Vapor
import JWT

var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)
let app = Application(env)

try app.jwt.signers.use(.es512(key: .generate()))
//try app.jwt.signers.use(.hs256(key: "Khaa7ich_y9bE4sdn".data(using: .utf8)!))

defer { app.shutdown() }
try configure(app)
try app.run()
