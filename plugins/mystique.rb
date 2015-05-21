require "mystique"
class Roda
  module RodaPlugins
    module MystiquePlugin
      module InstanceMethods
        def present(obj, context: self,**options, &block)
          Mystique.present(obj, context: context, **options, &block)
        end

        def present_collection(collection, context: self, &block)
          Mystique.present_collection(collection, context: context,  &block)
        end
      end
    end

    register_plugin(:mystique, MystiquePlugin)
  end
end
