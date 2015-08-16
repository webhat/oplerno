module ActiveAdmin
  module Views
    class Footer < Component
      REVISION = IO.read('REVISION')

      def build
        super :id => 'footer'
        super :style => 'text-align: right;'

        div do
          small do
            link_to "Revision #{REVISION}", "https://github.com/webhat/oplerno/commit/#{REVISION}"
          end
        end
      end
    end
  end
end
