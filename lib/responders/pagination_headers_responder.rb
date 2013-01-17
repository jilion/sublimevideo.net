module Responders
  module PaginationHeadersResponder

    def initialize(controller, resources, options = {})
      super
      @options = options
    end

    def to_format
      add_pagination_headers!
      super
    end

  private

    def add_pagination_headers!
      return unless paginated_resource?
      set_headers
    end

    def paginated_resource?
      resource.respond_to?(:current_page)
    end

    def set_headers
      controller.response.headers['X-Page']        = resource.current_page.to_s
      controller.response.headers['X-Offset']      = resource.offset_value.to_s
      controller.response.headers['X-Limit']       = resource.limit_value.to_s
      controller.response.headers['X-Total-Count'] = resource.total_count.to_s
    end

  end
end
