class PostRepresenter < ApplicationRepresenter
    def initialize(posts)
        @posts = posts
    end


    def as_json
        # if @posts.respond_to?(:each)
        # # if @posts.is_a?(Array)
        #   @posts.map do |post|
        #     {
        #       title: post.title,
        #       body: post.body,
        #       views: post.views
        #     }
        #   end
        # else
        #   {
        #     title: @posts.title,
        #     body: @posts.body,
        #     views: @posts.views,
        #   }
        # end
        if @posts.present?
          {status: {code: "200", message: "Successfully showing the post", posts: posts}}
        else
            {status: {code: "422", message: "something went wrong!!!"}}
        end
      end

    def call
        increment
        as_json
    end

    def increment
      @posts.views += 1
      @posts.save!
    end

    private
      attr_reader :posts
end