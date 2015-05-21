class LucidDream::WebApp < Roda
  def self.css_files
    %w[normalize.css foundation.min.css]
  end

  def self.foundation_plugins(*plugins)
    plugins.map{|f| "foundation/foundation.#{f}.js" }
  end

  def self.js_files
    js = []
    js.concat %w[vendor/jquery.js vendor/modernizr.js vendor/fastclick.js foundation/foundation.js]
    js.concat foundation_plugins("alert", "topbar")
    js << "main.js"
    js
  end

  plugin :assets, css: css_files, js: js_files
  compile_assets if production?
end
