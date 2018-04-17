class InlineFormsCreateRelatedWords < ActiveRecord::Migration[5.0]

  def self.up
    create_table :related_words do |t|
      t.string :name
      t.belongs_to :begrip
      t.timestamps
    end

    Begrip.all.each do |begrip|
      next if begrip.synonym.nil?
      synonyms = begrip.synonym.split(/[,;]/).map { |s| s.strip.downcase }
      synonyms.each do |synonym|
        related_word = RelatedWord.find_by_name(synonym)
        # the related word already exists but it belongs to another begrip
        # NOT GOOD
        if !related_word.nil? && related_word.begrip_id != begrip.id
          say "#{synonym} belongs to #{related_word.begrip_id} and #{begrip.id}"
        # the related word no exits, so let's create it
        elsif related_word.nil?
          begrip.related_words.create(name: synonym)
        end
      end
    end

    remove_column :begrips, :synonym
  end

  def self.down
    add_column :begrips, :synonym, :string

    Begrip.all.each do |begrip|
      next if begrip.related_words.empty?
      begrip.synonym = begrip.related_words.map(&:name).join(',')
      begrip.save
    end

    drop_table :related_words
  end

end
