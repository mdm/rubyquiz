class Deck
  def initialize 
    @deck = Array.new
    for val in 1..54
      @deck << val
    end
  end
    
  def key(key)
    srand(key)

    for a in 0..52
      b = a + 1 + rand(53 - a)
      @deck[a], @deck[b] = @deck[b], @deck[a]
    end
  end

  def stream
    #puts "move joker a", @deck.to_s

    src_a = @deck.index(53)
    dest_a = src_a + 1 
    if dest_a == 54
      dest_a = 1
      @deck = [@deck[0]] + [@deck[53]] + @deck.slice(1..52)
    else
      @deck[src_a], @deck[dest_a] = @deck[dest_a], @deck[src_a]
    end

    #puts "move joker b", @deck.to_s

    src_b = @deck.index(54)
    dest_b = src_b + 1
    if dest_b == 54
      dest_b = 1
      @deck = [@deck[0]] + [@deck[53]] + @deck.slice(1..52)
    else
      @deck[src_b], @deck[dest_b] = @deck[dest_b], @deck[src_b]
    end
    src_b = dest_b
    dest_b = src_b + 1
    if dest_b == 54
      dest_b = 1
      @deck = [@deck[0]] + [@deck[53]] + @deck.slice(1..52)
    else
      @deck[src_b], @deck[dest_b] = @deck[dest_b], @deck[src_b]
    end
    
    #puts "triple cut", @deck.to_s
    
    dest_a = @deck.index(53)
    dest_b = @deck.index(54)
    if dest_a < dest_b
      top = @deck.slice(0, dest_a)
      middle = @deck.slice(dest_a..dest_b)
      bottom = @deck.slice((dest_b + 1), 54)
    else
      top = @deck.slice(0, dest_b)
      middle = @deck.slice(dest_b..dest_a)
      bottom = @deck.slice((dest_a + 1), 54)
    end

    #puts "parts", dest_a, dest_b
    #puts top.to_s
    #puts middle.to_s
    #puts bottom.to_s

    @deck = bottom + middle + top
    #puts "count cut", @deck.to_s

    count = @deck[-1]
    count = 53 if count == 54

    top = @deck.slice(0, count)
    middle = @deck.slice(count..52)
    @deck = middle + top << @deck[53]

    #puts "Top:", @deck.to_s

    if @deck[0] == 54
      card = @deck[53]
    else
      card = @deck[@deck[0]]
    end
  
    if card > 52
      return ""
    else
      return (64 + card % 26).chr
    end
  end

  def encode(clear_text)
    cleaned = ""
    clear_text.upcase.each_char {|char| cleaned << char if char =~ /[A-Z]/}

    blocks = Array.new
    while cleaned.length > 4
      blocks << cleaned.slice!(0..4)
    end
    blocks << cleaned << ("X" * (5 - cleaned.length)) if not cleaned.empty?
    
    puts blocks.join(" ")
    
    blocks.collect! do |block|
      cipher_text = ""
      block.each_char do |char|
        key = ""
        key << stream while key.length == 0
        #print char, char.ord - 64, key, key.ord - 64, "\n"
        cipher_text << (64 + ((char.ord - 64) + (key.ord - 64)) % 26).chr
      end
      cipher_text
    end
    
    return blocks.join(" ")
  end
  
  def decode(cipher_text)
    blocks = cipher_text.split

    blocks.collect! do |block|
      clear_text = ""
      block.each_char do |char|
        key = ""
        key << stream while key.length == 0
        #print char, char.ord - 64, key, key.ord - 64, "\n"
        clear_text << (64 + ((char.ord - 64) - (key.ord - 64)) % 26).chr
      end
      clear_text
    end
    
    return blocks.join(" ")
  end
end

enc_test = "Code in Ruby, live longer!"
dec_test = "CLEPK HHNIY CFPWH FDFEH"
deck = Deck.new
puts deck.decode(dec_test)
