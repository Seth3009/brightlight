class DiknasConvertedItem < ActiveRecord::Base
  belongs_to :diknas_converted
  belongs_to :diknas_conversion
  validates :p_score, :t_score, presence: true

  def self.in_words(int)
    huruf = Array.new
    word_array = ["Nol","Satu","Dua","Tiga","Empat","Lima","Enam","Tujuh","Delapan","Sembilan","Seratus"]
    if int.to_i == 100
      return "Seratus"
    else
      int.to_i.to_s.split(//).each do |str|
        huruf << word_array[str.to_i]
      end
      return huruf.join(' ')
    end   
  end
  
end
