class PigLatin
  VOWELS = %w(a e i o u)
  CONSONANTS = %w(b c d f g h j k l m n p q r s t v w x y z)
  TWO_LETTER_EXCEPTIONS = %w(ch qu th)
  THREE_LETTER_EXCEPTIONS = %w(thr sch)

  def initialize
  end

  def self.add(word, string='ay')
    new_word = word + string
  end

  def self.translate(word_string)
    @words = word_string.split(' ')
    translated_phrase = []
    @words.each do |word|
      first_letter = word.split('').first
      case
      when THREE_LETTER_EXCEPTIONS.include?(word.split('').slice(0..2).join)
        word += word.slice!(0..2)
        new_word = word + 'ay'
        translated_phrase << new_word
      when TWO_LETTER_EXCEPTIONS.include?(word.split('').slice(0..1).join)
        word += word.slice!(0..1)
        translated_phrase << add(word)
      when word.include?('qu')
        letters_around_qu = word.split('qu')
        new_word = letters_around_qu[1] + letters_around_qu[0] + 'quay'
        translated_phrase << new_word
      when word.start_with?('ye')
        word.slice!(0)
        translated_phrase << word + 'yay'
      when word.start_with?('yt', 'xr')
        translated_phrase << add(word)
      when VOWELS.include?(first_letter)
        translated_phrase << add(word)
      when CONSONANTS.include?(first_letter)
        letters = word.split('')
        letters << letters.shift
        letters << ['a', 'y']
        translated_phrase << letters.join
      end
    end
    translated_phrase.join(' ')
  end

end