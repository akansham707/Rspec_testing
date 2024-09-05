module RequestHelper
   def response_request
    JSON.parse(response.body)
   end
end
