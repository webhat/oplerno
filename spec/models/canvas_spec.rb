require 'spec_helper'

describe CanvasModule do

  class TestCanvas
    extend CanvasModule
  end

  context 'Interact with Canvas'  do
    vcr_options = {:record => :none}
    context 'Interact with Canvas', vcr: vcr_options do
      it 'connects to canvas with oauth' do
        TestCanvas.connect_to_canvas_oauth
      end
      it 'connects to canvas with oauth + token' do
        TestCanvas.connect_to_canvas_oauth ENV['CANVAS_TOKEN']
      end
      it 'connects to canvas with oauth bad token' do
        TestCanvas.connect_to_canvas_oauth 'abcdefg'
      end
      it 'connects to canvas' do
        TestCanvas.connect_to_canvas
      end
    end
  end
end
