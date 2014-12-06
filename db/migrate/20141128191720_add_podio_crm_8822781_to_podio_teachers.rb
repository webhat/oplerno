class AddPodioCrm8822781ToPodioTeachers < ActiveRecord::Migration
  def change
		# WARNING: Only modify the lines below if you know what you are doing!
    create_table :podio_teachers do |t|
              													t.string :field_68472121
						                        													t.string :field_68472122
						                        													t.string :field_68472123
						                        													t.string :field_68472124
						                        													t.string :field_68472125
						                        													t.string :field_68472126
						                        													t.string :field_68472127
						                        													t.string :field_68472128
						                        													t.string :field_68472129
						                        													t.string :field_68472130
						                        													t.string :field_68472131
						                        													t.string :field_68472132
						                        													t.belongs_to :teacher
						                       t.timestamps
    end
  end
end
