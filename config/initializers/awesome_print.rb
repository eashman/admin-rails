AwesomePrint.defaults = {
    :indent     => 4,      # Indent using 4 spaces.
    :index      => true,   # Display array indices.
    :html       => false,  # Use ANSI color codes rather than HTML.
    :multiline  => true,   # Display in multiple lines.
    :plain      => false,  # Use colors.
    :raw        => false,  # Do not recursively format object instance variables.
    :sort_keys  => false,  # Do not sort hash keys.
    :limit      => false,  # Limit large output for arrays and hashes. Set to a boolean or integer.
    # supported colors   [:gray, :red, :green, :yellow, :blue, :purple, :cyan, :white
    # :black, :redish, :greenish, :yellowish, :blueish, :purpleish, :cyanish, :pale ]
    :color => {
        :args       => :pale,
        :array      => :red,
        :bigdecimal => :blue,
        :class      => :red,
        :date       => :greenish,
        :falseclass => :red,
        :fixnum     => :blue,
        :float      => :black,
        :hash       => :purple,
        :keyword    => :cyan,
        :method     => :purpleish,
        :nilclass   => :red,
        :rational   => :blue,
        :string     => :green,
        :struct     => :pale,
        :symbol     => :green,
        :time       => :greenish,
        :trueclass  => :green,
        :variable   => :cyanish
    }
}
