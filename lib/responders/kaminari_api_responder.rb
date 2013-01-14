module Responders
  module KaminariApiResponder

    def initialize(controller, resources, options = {})
      super
      @options = options
    end

    def to_format
      add_pagination!
      super
    end

    # Could be stubbed
    def self.per_page
      nil
    end

  private

    def add_pagination!
      return unless activate_paginate?
      set_instance_variable
      set_headers
    end

    def activate_paginate?
      get? &&
      resource.is_a?(ActiveRecord::Relation) &&
      controller.action_name == 'index' || @options[:paginate]
    end

    def klass
      @klass ||= controller.controller_name.classify.constantize
    end

    def page_params
      controller.request.params[:page] || 1
    end

    def per_page
      @options[:per_page] || klass.default_per_page || 25
    end

    def set_instance_variable
      controller.instance_variable_set(
        "@#{controller.controller_name}",
        resource.page(page_params).per(per_page))
    end

    def set_headers
      paginated_instance = controller.instance_variable_get("@#{controller.controller_name}")
      controller.response.headers['X-Page'] = paginated_instance.current_page.to_s
      controller.response.headers['X-Per-Page'] = per_page.to_s
      controller.response.headers['X-Total-Count'] = paginated_instance.total_count.to_s
    end

  end
end
