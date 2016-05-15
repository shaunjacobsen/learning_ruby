  def change(param)
    param += "greeting"
    param << "hey"
    #param = "hi"
    param << " world"
  end

  greeting = "hello"
  change(greeting)

  puts greeting