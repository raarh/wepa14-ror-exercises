class FixStyleToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :style_id, :integer

    reversible do |dir|

      dir.up do
        rename_column :beers, :style, :old_style
        Beer.all.each do |beer|
          beer.style_id = Style.find_by(style:beer.old_style).id
          beer.save
        end
      end

    end
  end
end

