class Application

  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last

      # if the item is found, return its price
      if @@items.find { |i| i.name == item_name}
        item = @@items.find { |i| i.name == item_name}
        resp.write item.price
      else # if it's not found, return a 400 error
        resp.write "Item not found"
        resp.status = 400
      end

    else # if the user used an invalid path, return a 404 error
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end

end
