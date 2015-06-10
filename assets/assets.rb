class LucidDream::WebApp < Roda
  def self.css_files
    %w[materialize.scss]
  end

  def self.js_files
    js = []
    js.concat %w[vendor/jquery.js]
    js << "materialize.min.js"
    js << "main.js"
    js
  end

  dependencies = Hash.new(Dir["assets/" "**/*.*"])

  self.plugin :assets, css: css_files, js: js_files, dependencies: dependencies
  compile_assets if production?
end
