class Roda
  module RodaPlugins
    module FoundationHelpers
      module InstanceMethods
        TYPES = {
                 default: "",
                 success: "success",
                 secondary: "secondary",
                 alert: "alert",
                 info: "info",
                }
        SIZES = {
                 default: "",
                 tiny:     "tiny",
                 small:    "small",
                 large:    "large",
                 expand:   "expand",
                }

        def label(text)
          content_tag(:span, text, class: "label")
        end

        def button(text=nil, href, **options, &block)
          text  = capture_haml(&block) if block_given?
          klass = "button #{options.delete(:class)}"
          foundation_tag(:a, text, href: href, class: klass, **options)
        end

        def button_group(**options, &block)
          klass = "button-group #{options.delete(:class)}"
          
          foundation_tag(:ul, class: klass, **options) do
            capture_haml(&block) if block_given?
          end
        end

        def button_item(text=nil, href, **options, &block)
          foundation_tag(:li) do
            button(text, href, **options, &block)
          end
        end

        TYPES.each do |type, _|
          define_method("#{type}_button") do |text=nil, href, **options, &block|
            button(text, href, type: type, **options, &block)
          end
          alias :"button_#{type}" :"#{type}_button"
        end

        def panel(title: nil, &block)
          content_tag(:div, title, class: "panel") do
            title_text = if title
                           content_tag(:h2, title, class: "text-center") +
                             content_tag(:hr)
                         end
            [
             title_text,
             content_tag(:span, &block)
            ].compact.join
          end
        end

        private

        def foundation_tag(tag, text=nil, type: :default, size: :default, disabled: false, **options, &block)
          text     = capture_haml(&block) if block_given?
          type     = TYPES[type]
          size     = SIZES[size]
          disabled = disabled ? "disabled" : ""
          klass    = options.delete(:class)
          classes  = [ klass, type, size, disabled ].uniq.join(" ").gsub(/\s+/, " ").chomp(" ")
          content_tag(tag, text, class: classes, **options)
        end

        def content_tag(tag, text=nil, **options, &block)
          text=capture_haml(&block) if block_given?
          html_options = options.map {|k, v| "#{k}=\"#{v}\""}.join(" ")
          "<#{tag} #{html_options}> #{text} </#{tag}>"
        end
      end
    end

    register_plugin(:foundation_helpers, FoundationHelpers)
  end
end
