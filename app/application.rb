class Application

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
      
            term = req.path.split("/items/").last

            match = Item.all.find{|i| i.name == term}

            if match == nil
                resp.write "Item not found"
                resp.status = 400
            else
                resp.write "#{match.price}"
            end
            
        else
            resp.write "Route not found"
            resp.status = 404
        end
        resp.finish
    end


end