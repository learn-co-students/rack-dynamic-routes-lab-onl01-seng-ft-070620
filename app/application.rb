class Application
    @@items = []

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            item_name = req.path.split('/items/').last

            if @@items.find{|item| item.name == item_name}
                item = @@items.find{|item| item.name == item_name}
                resp.write item.price
                resp.write "You requested a(n) #{item.name}"
            else #if the item is not found
                resp.write "Item not found"
                resp.status = 400
            end
        
        else #if the route is invalid
            resp.write "Route not found"
            resp.status = 404
        end

        resp.finish
    end
end