import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }

    let todoController = TodoController()
    app.get("todos", use: todoController.index)
    app.post("todos", use: todoController.create)
    app.delete("todos", ":todoID", use: todoController.delete)
    

    let authController = AuthorizeController()
    app.post(GlobalTool.routerName(group: "authorize", name: "login"), use: authController.login)
    app.post(GlobalTool.routerName(group: "authorize", name: "update_userinfo"), use: authController.update_userinfo)
    
    
    let demandController = DemandController()
    app.post(GlobalTool.routerName(group: "demand", name: "get_demand_type_list"), use: demandController.get_demand_type_list)
    app.post(GlobalTool.routerName(group: "demand", name: "create_demand"), use: demandController.create_demand)
    app.post(GlobalTool.routerName(group: "demand", name: "get_demand_list"), use: demandController.get_demand_list)
}
