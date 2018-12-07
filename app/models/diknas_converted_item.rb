class DiknasConvertedItem < ActiveRecord::Base
  belongs_to :diknas_converted
  belongs_to :diknas_conversion


  def in_words_pscore
    huruf = Array.new
    word_array = ["Nol","Satu","Dua","Tiga","Empat","Lima","Enam","Tujuh","Delapan","Sembilan","Seratus"]
    if self.P_score.to_i == 100
      return "Seratus"
    else
      self.P_score.to_i.to_s.split(//).each do |str|
        huruf << word_array[str.to_i]
      end
      return huruf.join(' ')
    end   
  end

  def in_words_tscore
    huruf = Array.new
    word_array = ["Nol","Satu","Dua","Tiga","Empat","Lima","Enam","Tujuh","Delapan","Sembilan","Seratus"]
    if self.T_score.to_i == 100
      return "Seratus"
    else
      self.T_score.to_i.to_s.split(//).each do |str|
        huruf << word_array[str.to_i]
      end
      return huruf.join(' ')
    end   
  end  
end
