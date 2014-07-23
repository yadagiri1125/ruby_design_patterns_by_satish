class Song

def initialize(name, artist, duration)
@name= name
@artist= artist
@duration = duration
end
end
song = Song.new("Bicylops", "Fleck", 260)
song.inspect

song = Song.new("Bicylops", "Fleck", 260)
song.to_s

class Song
def to_s
"Song: #@name--#@artist (#@duration)"
end
end
song = Song.new("Bicylops", "Fleck", 260)
song.to_s

class KaraokeSong < Song
def initialize(name, artist, duration, lyrics)
super(name, artist, duration)
@lyrics = lyrics
end
end

song = KaraokeSong.new("My Way", "Sinatra", 225, "And now, the...")
song.to_s


class KaraokeSong
# ...
def to_s
"KS: #@name--#@artist (#@duration) [#@lyrics]"
end
end
song = KaraokeSong.new("My Way", "Sinatra", 225, "And now, the...")
song.to_s

# #When KaraokeSong#to_s is called, we’ll have it call its parent’s to_s method to get
# the song details. It will then append to this the lyric information and return the result.
# The trick here is the Ruby keyword super. When you invoke super with no arguments,
# Ruby sends a message to the parent of the current object, asking it to invoke a method
# of the same name as the method invoking super. 



class KaraokeSong < Song
# Format ourselves as a string by appending
# our lyrics to our parent's #to_s value.
def to_s
super + " [#@lyrics]"
end
end
song = KaraokeSong.new("My Way", "Sinatra", 225, "And now, the...")
song.to_s

#all objects have Object as an ancestor and that Object’s instance methods are available to every object in Ruby

class Song
def name
@name
end
def artist
@artist
end
def duration
@duration
end
end
song = Song.new("Bicylops", "Fleck", 260)
song.artist → "Fleck"
song.name → "Bicylops"
song.duration → 260

#Because this is such a common idiom, Ruby provides a convenient shortcut: attr_reader creates these accessor methods for you.

class Song
attr_reader :name, :artist, :duration
end

class Song
def duration=(new_duration)
@duration = new_duration
end
end
song = Song.new("Bicylops", "Fleck", 260)
song.duration→ 260
song.duration = 257
# set attribute with updated value
song.duration → 257

class Song
attr_writer :duration
end
song = Song.new("Bicylops", "Fleck", 260)
song.duration = 257

class Song
def duration_in_minutes
@duration/60.0
# force floating point
end
def duration_in_minutes=(new_duration)
@duration = (new_duration*60).to_i
end
end
song = Song.new("Bicylops", "Fleck", 260)
song.duration_in_minutes → 4.33333333333333
song.duration_in_minutes = 4.2
song.duration→ 252

# Attributes, Instance Variables, and Methods ( objects internal state = instance variables and external state = attributes )
#  1.An attribute is just a method. Sometimes an attribute simply returns the value of an instance variable. Sometimes an attribute returns the result of a calculation
#  2.sometimes those funky methods with equals signs at the end of their names are used to update the state of an object
#  3.When you design a class, you decide what internal state it has and also decide how that state is to appear on the outside (to users of your class). 
#  4.The internal state is held in instance variables.
#  5. The external state is exposed through methods we’re call-ing attributes. And the other actions your class can perform are just regular methods.

# Class Variables and Class Methods
# 1.all the classes we’ve created have contained instance variables and instance methods: variables that are associated with a particular instance of the class, and meth-
# ods that work on those variables.
# 2. Sometimes classes themselves need to have their own states. This is where class variables come in.

# Class Variables

# 1.A class variable is shared among all objects of a class, and it is also accessible to the class methods that we’ll describe later.
# 2. Only one copy of a particular class variable exists for a given class. 
# 3.Class variable names start with two “at” signs, such as @@count.
# 4.Unlike global and instance variables, class variables must be initialized before they are used. Often this initialization is just a simple assignment in the body of the class
# definition


class Song
@@plays = 0
def initialize(name, artist, duration)
@name = name
@artist = artist
@duration = duration
@plays = 0
end

def play
@plays += 1
# same as @plays = @plays + 1
@@plays += 1
"This song: #@plays plays. Total #@@plays plays."
end
end

s1 = Song.new("Song1", "Artist1", 234) #
s2 = Song.new("Song2", "Artist2", 345)
s1.play → "This song: 1 plays. Total
s2.play → "This song: 1 plays. Total
s1.play → "This song: 2 plays. Total
s1.play → "This song: 3 plays. Total
test songs..
1
2
3
4
plays."
plays."
plays."
plays."


Class Methods

1.Sometimes a class needs to provide methods that work without being tied to any par-ticular object. 
2.The new method creates a new Song object but is not itself associated with a particular song.
song = Song.new(....)
3. For example, objects of class File represent open files in the underlying file system. However, class File also provides several class methods for manipulating files that aren’t open and there-fore don’t have a File object.
4. If you want to delete a file, you call the class method
File.delete, passing in the name.
File.delete("doomed.txt")

5.Class methods are distinguished from instance methods by their definition; class meth- ods are defined by placing the class name and a period in front of the method name 
class Example
def instance_method # instance method
end 
def Example.class_method # class method
end 
end

class SongList
MAX_TIME = 5*60 #5 minutes
def SongList.is_too_long(song)
return song.duration > MAX_TIME
end
end

song1 = Song.new("Bicylops", "Fleck", 260)
SongList.is_too_long(song1)  → false
song2 = Song.new("The Calling", "Santana", 468)
SongList.is_too_long(song2) → true

1.The following all define class methods within class Demo.
class Demo
def Demo.meth1
# ...
end
def self.meth2
# ...
end
class <<self
def meth3
# ...
end
end
end


Enter the Singleton pattern, documented in Design Patterns [GHJV95]. We’ll arrange
things so that the only way to create a logging object is to call MyLogger.create, and
we’ll ensure that only one logging object is ever created.
class MyLogger
private_class_method :new
@@logger = nil
def MyLogger.create
@@logger = new unless @@logger
@@logger
end
end

1.By making MyLogger’s new method private, we prevent anyone from creating a log-ging object using the conventional constructor. Instead, we provide a class method,
MyLogger.create. 
2.This method uses the class variable @@logger to keep a referenceto a single instance of the logger, returning that instance every time it is called.3 We
can check this by looking at the object identifiers the method returns.
MyLogger.create.id
MyLogger.create.id

936550
936550

class Shape
def Shape.triangle(side_length)
Shape.new(3, side_length*3)
end
def Shape.square(side_length)
Shape.new(4, side_length*4)
end
end


class Point
end

p = Point.new

p.class # => Point
p.is_a? Point # => true
class Point
def initialize(x,y)
@x, @y = x, y
end
end
# 1.The new method of the class object creates a new instance object, and then it
# automatically invokes the initialize method on that instance. 
# 2.Whatever arguments you passed to new are passed on to initialize
p = Point.new(0,0)
1.In addition to being automatically invoked by Point.new, the initialize method is
automatically made private. 
2.An object can call initialize on itself, but you cannot explicitly call initialize on p to reinitialize its state.
3.The instance variables of an object can only be accessed by the instance methods of that object. 
4.Code that is not inside an instance method cannot read or set the value ofan instance variable
# Incorrect code!
class Point
@x = 0 # Create instance variable @x and assign a default. WRONG!
@y = 0 # Create instance variable @y and assign a default. WRONG!
def initialize(x,y)
@x, @y = x, y # Now initialize previously created @x and @y.
end
end


class Point
def initialize(x,y)
@x, @y = x, y
end
def to_s
"(#@x,#@y)"
end
end
# Return a String that represents this point
# Just interpolate the instance variables into a string
p = new Point(1,2)
puts p
# Create a new Point object
# Displays "(1,2)"
class Point
def initialize(x,y)
@x, @y = x, y
end
def x
@x
end
def y
@y
end
end


p = Point.new(1,2)
q = Point.new(p.x*2, p.y*3)
class MutablePoint
def initialize(x,y); @x, @y = x, y; end
def x; @x; end # The getter method for @x
def y; @y; end # The getter method for @y
def x=(value) # The setter method for @x
@x = value 
end 
def y=(value) # The setter method for @y
@y = value 
end 
end 
# 1.Recall that assignment expressions can be used to invoke setter methods like these. 
# 2.So with these methods defined, we can write:
p = Point.new(1,1)
p.x = 0
p.y = 0
# 1.The attr_reader and attr_accessor methods are defined by the Module class.
# 2. All classes are modules, (the Class class is a subclass of Module) so you can invoke these method inside any class definition.
# 3. Both methods take any number of symbols naming attributes. 
# 4.attr_reader creates trivial getter methods for the instance variables with the same name. 
# 5.attr_accessor creates getter and setter methods

class Point
attr_accessor :x, :y # Define accessor methods for our instance variables
end
# And if we were defining an immutable version of the class, we’d write:
class Point
attr_reader :x, :y
end
# Define reader methods for our instance variables


1.The accepted style is to use symbols, but we can also write code like this:
attr_reader "x", "y"

2.attr is a similar method with a shorter name but with behavior that differs in Ruby
1.8 and Ruby 1.9. 
3.In 1.8, attr can define only a single attribute at a time. With a singlesymbol argument, it defines a getter method.
4.If the symbol is followed by the value true, then it defines a setter method as well:
attr :x
attr :y, true
# Define a trivial getter method x for @x
# Define getter and setter methods for @y

1.The attr, attr_reader, and attr_accessor methods create instance methods for us.This is an example of metaprogramming



class Point
attr_reader :x, :y
# Define accessor methods for our instance variables
def initialize(x,y)
@x,@y = x, y
end
def +(other)
# Define + to do vector addition
Point.new(@x + other.x, @y + other.y)
end
def -@
# Define unary minus to negate both coordinates
Point.new(-@x, -@y)
end
def *(scalar)
# Define * to perform scalar multiplication
Point.new(@x*scalar, @y*scalar)
end
end


Array and Hash Access with [ ]

# Define [] method to allow a Point to look like an array or
# a hash with keys :x and :y
def [](index)
case index
when 0, -2: @x
# Index 0 (or -2) is the X coordinate
when 1, -1: @y
# Index 1 (or -1) is the Y coordinate
when :x, "x": @x
# Hash keys as symbol or string for X
when :y, "y": @y
# Hash keys as symbol or string for Y


else nil
end
end
# Arrays and hashes just return nil on bad indexes


# This iterator passes the X coordinate to the associated block, and then
# passes the Y coordinate, and then returns. It allows us to enumerate
# a point as if it were an array with two elements. This each method is
# required by the Enumerable module.
def each
yield @x
yield @y
end
With this iterator defined, we can write code like this:
p = Point.new(1,2)
p.each {|x| print x }
# Prints "12"


Point Equality

def ==(o)
if o.is_a? Point
@x==o.x && @y==o.y
elsif
false
end
end

Is self == o?
If o is a Point object
then compare the fields.
If o is not a Point
then, by definition, self != o.

def eql?(o)
if o.instance_of? Point
@x.eql?(o.x) && @y.eql?(o.y)
elsif
false
end
end


def hash
@x.hash + @y.hash
end

def hash
code = 17
code = 37*code + @x.hash
code = 37*code + @y.hash
# Add lines like this for each significant instance variable
code # Return the resulting code
end


include Comparable
# Mix in methods from the Comparable module.
# Define an ordering for points based on their distance from the origin.
# This method is required by the Comparable module.
def <=>(other)
return nil unless other.instance_of? Point
@x**2 + @y**2 <=> other.x**2 + other.y**2
end


p,q = Point.new(1,0), Point.new(0,1)
p == q
# => false: p is not equal to q
p < q
# => false: p is not less than q
p > q
# => false: p is not greater than q


def add!(p)
@x += p.x
@y += p.y
self
end
# Add p to self, return modified self

def add(p)
q = self.dup
q.add!(p)
end
# A nonmutating version of add!
# Make a copy of self
# Invoke the mutating method on the copy


Quick and Easy Mutable Classes

1.If you want a mutable Point class, one way to create it is with Struct. Struct is a core
Ruby class that generates other classes. 
2.These generated classes have accessor methods for the named fields you specify. There are two ways to create a new class with
Struct.new:
Struct.new("Point", :x, :y)
Point = Struct.new(:x, :y)
# Creates new class Struct::Point
# Creates new class, assigns to Point

C = Class.new
c = C.new
c.class.to_s
# A new class with no body, assigned to a constant
# Create an instance of the class
# => "C": constant name becomes class name
p = Point.new(1,2)
p.x
p.y
p.x = 3
p.x
#<struct Point x=1, y=2>
1
2
3
3

1.Structs also define the [] and []= operators for array and hash-style indexing, and even provide each and each_pair iterators for looping through the values held in an instance
of the struct:
p[:x] = 4
# => 4: same as p.x =
p[:x]
# => 4: same as p.x
p[1]
# => 2: same as p.y
p.each {|c| print c} # prints "42"
p.each_pair {|n,c| print n,c } # prints "x4y2"

1.Struct-based classes have a working == operator, can be used as hash keys (though caution is necessary because they are mutable), and even define a helpful to_s method:
q = Point.new(4,2)
q == p
# => true
h = {q => 1} # Create a hash using q as a key
h[p]
# => 1: extract value using p as key
q.to_s
# => "#<struct Point x=4, y=2>"


1.A Point class defined as a struct does not have point-specific methods like add! or the<=> operator defined earlier in this chapter. There is no reason we can’t add them,
though. Ruby class definitions are not static. 
2.Any class (including classes defined withStruct.new) can be “opened” and have methods added to it. Here’s a Point class initially
defined as a Struct, with point-specific methods added:

Point = Struct.new(:x, :y)
class Point
def add!(other)
self.x += other.x
self.y += other.y
self
end
# Create new class, assign to Point
# Open Point class for new methods
# Define an add! method

include Comparable
# Include a module for the class
def <=>(other)
# Define the <=> operator
return nil unless other.instance_of? Point
self.x**2 + self.y**2 <=> other.x**2 + other.y**2
end
end
1.As noted at the beginning of this section, the Struct class is designed to create mutable
classes. 
2.With just a bit of work, however, we can make a Struct-based class immutable:
Point = Struct.new(:x, :y)
class Point
undef x=,y=,[]=
end

# Define mutable class
# Open the class
# Undefine mutator methods

 This method is not an instance method invoked on a Point object.
Rather, it is a class method, invoked through the Point class itself. We might invoke the
sum method like this:
total = Point.sum(p1, p2, p3)
# p1, p2 and p3 are Point objects

Our class method
sum is defined like this:
class Point
attr_reader :x, :y
# Define accessor methods for our instance variables
def Point.sum(*points) # Return the sum of an arbitrary number of points
x = y = 0
points.each {|p| x += p.x; y += p.y }
Point.new(x,y)
end
# ...the rest of class omitted here...
end
Thus, this method could also be written like this:
def self.sum(*points) # Return the sum of an arbitrary number of points
x = y = 0
points.each {|p| x += p.x; y += p.y }
Point.new(x,y)
end
# Open up the Point object so we can add methods to it
class << Point
# Syntax for adding methods to a single object
def sum(*points) # This is the class method Point.sum
x = y = 0
points.each {|p| x += p.x; y += p.y }
Point.new(x,y)
end
# Other class methods can be defined here
end
This technique can also be used inside the class definition, where we can use self
instead of repeating the class name:
class Point
# Instance methods go here
class << self
# Class methods go here
end
end
Constants
Many classes can benefit from the definition of some associated constants. Here are
some constants that might be useful for our Point class:
class Point
def initialize(x,y)
@x,@y = x, y
end
# Initialize method
ORIGIN = Point.new(0,0)
UNIT_X = Point.new(1,0)
UNIT_Y = Point.new(0,1)
# Rest of class definition goes here
end
Point::UNIT_X + Point::UNIT_Y
# => (1,1)
Point::NEGATIVE_UNIT_X = Point.new(-1,0)

Class Variables

1.Class variables are visible to, and shared by, the class methods and the instance methods of a class, and also by the class definition itself. Like instance variables, class variables
are encapsulated; 
2.they can be used by the implementation of a class, but they are notvisible to the users of a class.
3.Class variables have names that begin with @@.
4.There is no real need to use class variables in our Point class, but for the purposes of
this tutorial, let’s suppose that we want to collect data about the number of Point
objects that are created and their average coordinates. 
5.Here’s how we might write the
code:
class Point
# Initialize our class variables in the class definition itself
@@n = 0
# How many points have been created
@@totalX = 0
# The sum of all X coordinates
@@totalY = 0
# The sum of all Y coordinates
def initialize(x,y)
@x,@y = x, y
# Initialize method
# Sets initial values for instance variables
# Use the class variables in this instance method to collect data
@@n += 1
# Keep track of how many Points have been created
@@totalX += x
# Add these coordinates to the totals
@@totalY += y
end
# A class method to report the data we collected
def self.report
# Here we use the class variables in a class method
puts "Number of points created: #@@n"
puts "Average X coordinate: #{@@totalX.to_f/@@n}"
puts "Average Y coordinate: #{@@totalY.to_f/@@n}"
end
end


class Point
# Initialize our class instance variables in the class definition itself
@n = 0
# How many points have been created
@totalX = 0
# The sum of all X coordinates
@totalY = 0
# The sum of all Y coordinates
def initialize(x,y) # Initialize method
@x,@y = x, y
# Sets initial values for instance variables
end
def self.new(x,y)
# Class method to create new Point objects
# Use the class instance variables in this class method to collect data
@n += 1
# Keep track of how many Points have been created
@totalX += x
# Add these coordinates to the totals
@totalY += y
super
# Invoke the real definition of new to create a Point
# More about super later in the chapter
end


# A class method to report the data we collected
def self.report
# Here we use the class instance variables in a class method
puts "Number of points created: #@n"
puts "Average X coordinate: #{@totalX.to_f/@n}"
puts "Average Y coordinate: #{@totalY.to_f/@n}"
end
en

1.Because class instance variables are just instance variables of class objects, we can use
attr, attr_reader, and attr_accessor to create accessor methods for them.
2.This same syntax allows us to define attribute accessor methods for class instance variables:
class << self
attr_accessor :n, :totalX, :totalY
end
3.With these accessors defined, we can refer to our raw data as Point.n, Point.totalX,
and Point.totalY

class Point
# Initialize our class instance variables in the class definition itself
@n = 0
# How many points have been created
@totalX = 0
# The sum of all X coordinates
@totalY = 0
# The sum of all Y coordinates
def initialize(x,y) # Initialize method
@x,@y = x, y
# Sets initial values for instance variables
end
def self.new(x,y)
# Class method to create new Point objects
# Use the class instance variables in this class method to collect data
@n += 1
# Keep track of how many Points have been created
@totalX += x
# Add these coordinates to the totals
@totalY += y
super
# Invoke the real definition of new to create a Point
# More about super later in the chapter
end
# A class method to report the data we collected
def self.report
# Here we use the class instance variables in a class method
puts "Number of points created: #@n"
puts "Average X coordinate: #{@totalX.to_f/@n}"
puts "Average Y coordinate: #{@totalY.to_f/@n}"
end
end


 1.This same syntax allows us to define attribute accessor methods for class instance variables:
class << self
attr_accessor :n, :totalX, :totalY
end
2.With these accessors defined, we can refer to our raw data as Point.n, Point.totalX,
and Point.totalY.

1.Instance methods may be public, private, or protected. If you’ve programmed with other
object-oriented languages, you may already be familiar with these terms.
2. Pay attention anyway, because these words have a somewhat different meaning in Ruby than they
do in other languages.
3.Methods are normally public unless they are explicitly declared to be private or pro-tected.
4. One exception is the initialize method, which is always implicitly private.
5.Another exception is any “global” method declared outside of a class definition—those
methods are defined as private instance methods of Object.
6. A public method can be invoked from anywhere—there are no restrictions on its use.
7.A private method is internal to the implementation of a class, and it can only be called
by other instance methods of the class (or, as we’ll see later, its subclasses).
8. Private methods are implicitly invoked on self, and may not be explicitly invoked on an object.
9.If m is a private method, then you must invoke it in functional style as m. You cannot
write o.m or even self.m.
10.A protected method is like a private method in that it can only be invoked from within
the implementation of a class or its subclasses.
11. It differs from a private method in that it may be explicitly invoked on any instance of the class, and it is not restricted to
implicit invocation on self. 
12.A protected method can be used, for example, to definean accessor that allows instances of a class to share internal state with each other, but
does not allow users of the class to access that state.


class Point
# public methods go here
# The following methods are protected
protected
# protected methods go here
# The following methods are private
private
# private methods go here
end



class Widget
def x
@x
end
protected :x
def utility_method
nil
end
private :utility_method
end
# Accessor method for @x
# Make it protected
# Define a method
# And make it private
1.To do this, use the private_class_method method, specifying one or more method
names as symbols:
private_class_method :new

w = Widget.new
w.send :utility_method
w.instance_eval { utility_method }
w.instance_eval { @x }
Create a Widget
Invoke private method!
Another way to invoke it
Read instance variable of w


class Point3D < Point
end
# Define class Point3D as a subclass of Point

Subclassing a Struct
Earlier in this chapter, we saw how to use Struct.new to automatically generate simple
classes. It is also possible to subclass a struct-based class, so that methods other than
the automatically generated ones can be added:
class Point3D < Struct.new("Point3D", :x, :y, :z)
# Superclass struct gives us accessor methods, ==, to_s, etc.
# Add point-specific methods here
end
Overriding Methods
When we define a new class, we a

o = Object.new
puts o.to_s
# Prints something like "#<Object:0xb7f7fce4>"

# Greet the World
class WorldGreeter
def greet
puts "#{greeting} #{who}"
end
# Display a greeting
def greeting # What greeting to use
"Hello" 
end 
def who # Who to greet
"World" 
end 
end
# Greet the world in Spanish
class SpanishWorldGreeter < WorldGreeter
def greeting
# Override the greeting
"Hola"
end
end
# We call a method defined in WorldGreeter, which calls the overridden
# version of greeting in SpanishWorldGreeter, and prints "Hola World"
SpanishWorldGreeter.new.greet

1.Notice that it is also perfectly reasonable to define an abstract class that invokes certain
undefined “abstract” methods, which are left for subclasses to define. The opposite of abstract is concrete.
2. A class that extends an abstract class is concrete if it defines all of
the abstract methods of its ancestors. For example:
# This class is abstract; it doesn't define greeting or who
# No special syntax is required: any class that invokes methods that are
# intended for a subclass to implement is abstract.
class AbstractGreeter
def greet
puts "#{greeting} #{who}"
end
end
# A concrete subclass
class WorldGreeter < AbstractGreeter
def greeting; "Hello"; end
def who; "World"; end
end
WorldGreeter.new.greet
# Displays "Hello World"
Overriding private methods
Private methods cannot be invoked from outside the class that defines them. But they
are inherited by subclasses. This means that subclasses can invoke them and can
override them.
in Ruby, you should only subclass when you are familiar with the
implementation of the superclass. If you only want to depend on the public API of a
class and not on its implementation, then you should extend the functionality of the
class by encapsulating and delegating to it, not by inheriting from it

Augmenting Behavior by Chaining
Sometimes when we override a method, we don’t want to replace it altogether, we just
want to augment its behavior by adding some new code. In order to do this, we need
a way to invoke the overridden method from the overriding method. This is known
as chaining, and it is accomplished with the keyword super
super works like a special method invocation: it invokes a method with the same name
as the current one, in the superclass of the current class. (Note that the superclass need
not define that method itself—it can inherit it from one of its ancestors.) You may
specify arguments for super just as you would for a normal method invocation. One
common and important place for method chaining is the initialize method of a class.
Here is how we might write the initialize method of our Point3D class:
class Point3D < Point
def initialize(x,y,z)
# Pass our first two arguments along to the superclass initialize method
super(x,y)
# And deal with the third argument ourself
@z = z;
end
end


Inheritance of Class Methods
Class methods may be inherited and overridden just as instance methods can be. If our
Point class defines a class method sum, then our Point3D subclass inherits that method.
That is, if Point3D does not define its own class method named sum, then the expression
Point3D.sum invokes the same method as the expression Point.sum.
As a stylistic matter, it is preferable to invoke class methods through the class object
on which they are defined. A code maintainer seeing an expression Point3D.sum would
go looking for a definition of the sum method in the Point3D class, and he might have a
hard time finding it in the Point class. When invoking a class method with an explicit
receiver, you should avoid relying on inheritance—always invoke the class method
through the class that defines it.*
Within the body of a class method, you may invoke the other class methods of the class
without an explicit receiver—they are invoked implicitly on self, and the value of
self in a class method is the class on which it was invoked. It is here, inside the body
of a class method, that the inheritance of class methods is useful: it allows you to
implicitly invoke a class method even when that class method is defined by a superclass.
Finally, note that class methods can use super just as instance methods can to invoke
the same-named method in the superclass


 Inheritance and Instance Variables
Instance variables often appear to be inherited in Ruby. Consider this code, for
example:
class Point3D < Point
def initialize(x,y,z)
super(x,y)
@z = z;
end
def to_s
"(#@x, #@y, #@z)"
end
end
# Variables @x and @y inherited?
The to_s method in Point3D references the @x and @y variables from the superclass
Point. This code works as you probably expect it to:
Point3D.new(1,2,3).to_s
# => "(1, 2, 3)"
 Inheritance and Class Variables
Class variables are shared by a class and all of its subclasses. If a class A defines a variable
@@a, then subclass B can use that variable. Although this may appear, superficially, to
be inheritance, is it actually something different.
The difference becomes clear when we think about setting the value of a class variable.
If a subclass assigns a value to a class variable already in use by a superclass, it does not
create its own private copy of the class variable, but instead alters the value seen by the
superclass. It also alters the shared value seen by all other subclasses of the superclass.
Ruby 1.8 prints a warning about this if you run it with -w. Ruby 1.9 does not issue this
warning.
If a class uses class variables, then any subclass can alter the behavior of the class and
all its descendants by changing the value of the shared class variable. This is a strong
argument for the use of class instance variables instead of class variables
The following code demonstrates the sharing of class variables. It outputs 123:
class A
@@value = 1
def A.value; @@value; end
end
print A.value
class B < A; @@value = 2; end
print A.value
class C < A; @@value = 3; end
print B.value
# A class variable
# An accessor method for it
#
#
#
#
#
Display value of As class variable
Subclass alters shared class variable
Superclass sees altered value
Another alters shared variable again
1st subclass sees value from 2nd subclass




Inheritance of Constants
Constants are inherited and can be overridden, much like instance methods can. There
is, however, a very important difference between the inheritance of methods and the
inheritance of constants.
Our Point3D class can use the ORIGIN constant defined by its Point superclass, for ex-
ample. Although the clearest style is to qualify constants with their defining class,
Point3D could also refer to this constant with an unqualified ORIGIN or even as
Point3D::ORIGIN.
Where inheritance of constants becomes interesting is when a class like Point3D
redefines a constant. A three-dimensional point class probably wants a constant named
ORIGIN to refer to a three-dimensional point, so Point3D is likely to include a line like this:
ORIGIN = Point3D.new(0,0,0)
As you know, Ruby issues a warning when a constant is redefined. In this case, however,
this is a newly created constant. We now have two constants Point::ORIGIN and
Point3D::ORIGIN.
The important difference between constants and methods is that constants are looked
up in the lexical scope of the place they are used before they are looked up in the
inheritance hierarchy (§7.9 has details). This means that if Point3D inherits methods
that use the constant ORIGIN, the behavior of those inherited methods will not change
when Point3D defines its own version of ORIGIN.


Object Creation and Initialization
new, allocate, and initialize

def new(*args)
o = self.allocate
# Create a new object of this class
o.initialize(*args) # Call the object's initialize method with our args
o
# Return new object; ignore return value of initialize
end

Class::new and Class#new

Class defines two methods named new. One, Class#new, is an instance method, and the
other, Class::new, is a class method (we use the disambiguating naming convention of
the ri tool here). The first is the instance method that we’ve been describing here; it is
inherited by all class objects, becoming a class method of the class, and is used to create
and initialize new instances.
The class method Class::new is the Class class’ own version of the method, and it can
be used to create new classes.

1.You can often do this by providing parameter defaults on the initialize method. 
2.With an initialize method defined as follows, for example, you can invoke new with either
two or three arguments:

class Point
# Initialize a Point with two or three coordinates
def initialize(x, y, z=nil)
@x,@y,@z = x, y, z
end
end


1.Sometimes, however, parameter defaults are not enough, and we need to write factory
methods other than new for creating instances of our class.
2. Suppose that we want to be able to initialize Point objects using either Cartesian or polar coordinates:
class Point
# Define an initialize method as usual...
def initialize(x,y) # Expects Cartesian coordinates
@x,@y = x,y
end
# But make the factory method new private
private_class_method :new
def Point.cartesian(x,y) # Factory method for Cartesian coordinates
new(x,y) # We can still call new from other class methods
end
def Point.polar(r, theta) # Factory method for polar coordinates
new(r*Math.cos(theta), r*Math.sin(theta))
end
end

1.This code still relies on new and initialize, but it makes new private, so that users of
the Point class can’t call it directly.
2. Instead, they must use one of the custom factory methods.


class Point
def initialize(*coords)
@coords = coords
end
# A point in n-space
# Accept an arbitrary # of coordinates
# Store the coordinates in an array
def initialize_copy(orig) # If someone copies this Point object
@coords = @coords.dup
# Make a copy of the coordinates array, too
end
end


class Season
NAMES = %w{ Spring Summer Autumn Winter }
INSTANCES = []
# Array of season names
# Array of Season objects
def initialize(n) # The state of a season is just its
@n = n # index in the NAMES and INSTANCES arrays
end 
def to_s # Return the name of a season
NAMES[@n] 
end 
# This code creates instances of this class to represent the seasons
# and defines constants to refer to those instances.
# Note that we must do this after initialize is defined.
NAMES.each_with_index do |name,index|
instance = new(index)
# Create a new instance
INSTANCES[index] = instance
# Save it in an array of instances
const_set name, instance
# Define a constant to refer to it
end
# Now that we have created all the instances we'll ever need, we must
# prevent any other instances from being created
private_class_method :new,:allocate # Make the factory methods private
private :dup, :clone
# Make copying methods private
end


marshal_dump and marshal_load

1.A third way that objects are created is when Marshal.load is called to re-create objects
previously marshaled (or “serialized”) with Marshal.dump.
2. Marshal.dump saves the class of an object and recursively marshals the value of each of its instance variables


If you define a custom marshal_dump method, you must define a matching
marshal_load method, of course. marshal_load will be invoked on a newly allocated
(with allocate) but uninitialized instance of the class. It will be passed a reconstituted
copy of the object returned by marshal_dump, and it must initialize the state of the
receiver object based on the state of the object it is passed.
As an example, let’s return to the multidimensional Point class we started earlier. If we
add the constraint that all coordinates are integers, then we can shave a few bytes off
the size of the marshaled object by packing the array of integer coordinates into a string
(you may want to use ri to read about Array.pack to help you understand this code):
class Point
def initialize(*coords)
@coords = coords
end
def marshal_dump
@coords.pack("w*")
end
# A point in n-space
# Accept an arbitrary # of coordinates
# Store the coordinates in an array
# Pack coords into a string and marshal that
def marshal_load(s)
# Unpack coords from unmarshaled string
@coords = s.unpack("w*") # and use them to initialize the object
end
end


If you are writing a class—such as the Season class shown previously—for which you
have disabled the clone and dup methods, you will also need to implement custom
marshaling methods because dumping and loading an object is an easy way to create
a copy of it. You can prevent marshaling completely by defining marshal_dump and
marshal_load methods that raise an exception, but that is rather heavy-handed. A more
elegant solution is to customize the unmarshaling so that Marshal.load returns an
existing object rather than creating a copy.
To accomplish this, we must define a different pair of custom marshaling methods
because the return value of marshal_load is ignored. _dump is an instance method that
must return the state of the object as a string. The matching _load method is a class
method that accepts the string returned by _dump and returns an object. _load is allowed
to create a new object or return a reference to an existing one.
To allow marshaling, but prevent copying, of Season objects, we add these methods to
the class:
class Season
# We want to allow Season objects to be marshaled, but we don't
# want new instances to be created when they are unmarshaled.
def _dump(limit)
# Custom marshaling method
@n.to_s
# Return index as a string
end
def self._load(s)
INSTANCES[Integer(s)]
end
end
# Custom unmarshaling method
# Return an existing instance


The Singleton Pattern
1.A singleton is a class that has only a single instance. Singletons can be used to store
global program state within an object-oriented framework and can be useful alternatives to class methods and class variables.

Singleton Terminology

1.This section discusses the “Singleton Pattern,” a well-known design pattern in object-
oriented programming.
2. In Ruby, we have to be careful with the term “singleton”because it is overloaded.
3. A method added to a single object rather than to a class of objects is known as a singleton method .
4. The implicit class object to which such singleton methods are added is sometimes called a singleton class (though this
book uses the term eigenclass instead;).


1.Properly implementing a singleton requires a number of the tricks shown earlier. 
2.The new and allocate methods must be made private, dup and clone must be prevented from
making copies, and so on. 
3.Fortunately, the Singleton module in the standard librarydoes this work for us; just require 'singleton' and then include Singleton into your
class. 
4.This defines a class method named instance, which takes no arguments andreturns the single instance of the class. 
5.Define an initialize method to perform initi-alization of the single instance of the class. 
6.Note, however, that no arguments will bepassed to this method.

example::
require 'singleton' # Singleton module is not built-in
class PointStats # Define a class
include Singleton # Make it a singleton
def initialize
# A normal initialization method
@n, @totalX, @totalY = 0, 0.0, 0.0
end
def record(point)
@n += 1
@totalX += point.x
@totalY += point.y
end
# Record a new point
def report
# Report point statistics
puts "Number of points created: #@n"
puts "Average X coordinate: #{@totalX/@n}"
puts "Average Y coordinate: #{@totalY/@n}"
end
end
With a class like this in place, we might write the initialize method for our Point class
like this:
def initialize(x,y)
@x,@y = x,y
PointStats.instance.record(self)
end
The Singleton module automatically creates the instance class method for us, and we
invoke the regular instance method record on that singleton instance. Similarly, when
we want to query the point statistics, we write:

PointStats.instance.report

Modules
Like a class, a module is a named group of methods, constants, and class variables.
Modules are defined much like classes are, but the module keyword is used in place of
the class keyword. Unlike a class, however, a module cannot be instantiated, and it
cannot be subclassed. Modules stand alone; there is no “module hierarchy” of
inheritance.
Modules are used as namespaces and as mixins. The subsections that follow explain
these two uses.
Just as a class object is an instance of the Class class, a module object is an instance of
the Module class. Class is a subclass of Module. This means that all classes are modules,
but not all modules are classes. Classes can be used as namespaces, just as modules
can. Classes cannot, however, be used as mixins.


Modules
1.Like a class, a module is a named group of methods, constants, and class variables.
2.Modules are defined much like classes are, but the module keyword is used in place of
the class keyword.
3. Unlike a class, however, a module cannot be instantiated, and it
cannot be subclassed. 
4.Modules stand alone; there is no “module hierarchy” of
inheritance.
5.Modules are used as namespaces and as mixins. The subsections that follow explain
these two uses.
6.Just as a class object is an instance of the Class class, a module object is an instance of
the Module class.
7. Class is a subclass of Module. This means that all classes are modules,
but not all modules are classes. Classes can be used as namespaces, just as modules
can. Classes cannot, however, be used as mixins.

odules as Namespaces
1.Modules are a good way to group related methods when object-oriented programming
is not necessar

module Base64
def self.encode
end
def self.decode
end
end

# This is how we invoke the methods of the Base64 module
text = Base64.encode(data)
data = Base64.decode(text)
1.Modules may also contain constants. Our Base64 implementation would likely use a
constant to hold a string of the 64 characters used as digits in Base64:
module Base64
DIGITS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' \
'abcdefghijklmnopqrstuvwxyz' \
'0123456789+/'
end


module Base64
DIGITS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
class Encoder
def encode
end
end
class Decoder
def decode
end
end
# A utility function for use by both classes
def Base64.helper
end
end


Nested namespaces

module Base64
DIGITS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
class Encoder
def encode
end
end
class Decoder
def decode
end
end
# A utility function for use by both classes
def Base64.helper
end
end


1.By structuring our code this way, we’ve defined two new classes, Base64::Encoder and
Base64::Decoder.
2.Inside the Base64 module, the two classes can refer to each other by
their unqualified names, without the Base64 prefix. 
3.And each of the classes can use the DIGITS constant without a prefix.
4.On the other hand, consider the Base64.helper utility function. 
5.The nested Encoder andDecoder classes have no special access to the methods of the containing module, and
they must refer to this helper method by its fully qualified name: Base64.helper.

Because classes are modules, they too can be nested. Nesting one class within another
only affects the namespace of the inner class; it does not give that class any special
access to the methods or variables of the outer class. If your implementation of a class
requires a helper class, a proxy class, or some other class that is not part of a public
API, you may want to consider nesting that internal class within the class that uses it.
This keeps the namespace tidy but does not actually make the nested class private in
any way


1.To mix a module into a class, use include. include is usually used as if it were a language
keyword:
class Point
include Comparable
end
2.In fact, it is a private instance method of Module, implicitly invoked on self—the class
into which the module is being included. 
3.In method form, this code would be:
class Point
include(Comparable)
end
1.Because include is a private method, it must be invoked as a function, and we cannot
write self.include(Comparable).
2. The include method accepts any number of Module
objects to mix in, so a class that defines each and <=> might include the line:
include Enumerable, Comparable


"text".is_a? Comparable
Enumerable === "text"
# => true
# => true in Ruby 1.8, false in 1.9


"text".instance_of? Comparable
# => false

module Iterable
# Classes that define next can include this module
include Enumerable
# Define iterators on top of each
def each
# And define each on top of next
loop { yield self.next }
end
end


module. As an example, consider this code from Chapter 5:
module Iterable
# Classes that define next can include this module
include Enumerable
# Define iterators on top of each
def each
# And define each on top of next
loop { yield self.next }
end
end


ere is an example:
countdown = Object.new
def countdown.each
yield 3
yield 2
yield 1
end
countdown.extend(Enumerable)
print countdown.sort
# A plain old object
# The each iterator as a singleton method
# Now the object has all Enumerable methods
# Prints "[1, 2, 3]"



Math.sin(0)
# => 0.0: Math is a namespace
include 'Math' # The Math namespace can be included
sin(0)
# => 0.0: Now we have easy access to the functions


Loading and Requiring Modules
Ruby programs may be broken up into multiple files, and the most natural way to
partition a program is to place each nontrivial class or module into a separate file. These
separate files can then be reassembled into a single program (and, if well-designed, can
be reused by other programs) using require or load. These are global functions defined
in Kernel, but are used like language keywords. The same require method is also used
for loading files from the standard library.
load and require serve similar purposes, though require is much more commonly used
than load. Both functions can load and execute a specified file of Ruby source code. If
the file to load is specified with an absolute path, or is relative to ~ (the user’s home
directory), then that specific file is loaded. Usually, however, the file is specified as a
relative path, and load and require search for it relative to the directories of Ruby’s
load path (details on the load path appear below).
Despite these overall similarities, there are important differences between load and
require:

Despite these overall similarities, there are important differences between load and
require:

• In addition to loading source code, require can also load binary extensions to
Ruby. Binary extensions are, of course, implementation-dependent, but in C-based
implementations, they typically take the form of shared library files with exten-
sions like .so or .dll.

• load expects a complete filename including an extension. require is usually passed
a library name, with no extension, rather than a filename. In that case, it searches
for a file that has the library name as its base name and an appropriate source or
native library extension. If a directory contains both an .rb source file and a binary
extension file, require will load the source file instead of the binary file.

• load can load the same file multiple times. require tries to prevent multiple loads
of the same file. (require can be fooled, however, if you use two different, but
equivalent, paths to the same library file. In Ruby 1.9, require expands relative
paths to absolute paths, which makes it somewhat harder to fool.) require keeps
track of the files that have been loaded by appending them to the global array
$" (also known as $LOADED_FEATURES). load does not do this.

• load loads the specified file at the current $SAFE level. require loads the specified
library with $SAFE set to 0, even if the code that called require has a higher value
for that variable. See §10.5 for more on $SAFE and Ruby’s security system. (Note
that if $SAFE is set to a value higher than 0, require will refuse to load any file with
a tainted filename or from a world-writable directory. In theory, therefore, it should
be safe for require to load files with a reduced $SAFE level.)


Ruby’s load path is an array that you can access using either of the global variables
$LOAD_PATH or $:. (The mnemonic for this global is that colons are used as path separator
characters on Unix-like operating systems.) Each element of the array is the name of a
directory that Ruby will search for files to load. Directories at the start of the array are
searched before directories at the end of the array. The elements of $LOAD_PATH must be
strings in Ruby 1.8, but in Ruby 1.9, they may be strings or any object that has a
to_path method that returns a string.
The default value of $LOAD_PATH depends on your implementation of Ruby, on the op-
erating system it is running on, and even on where in your filesystem you installed it.
Here is a typical value for Ruby 1.8, obtained with ruby -e 'puts $:':

/usr/lib/site_ruby/1.8
/usr/lib/site_ruby/1.8/i386-linux
/usr/lib/site_ruby
/usr/lib/ruby/1.8
/usr/lib/ruby/1.8/i386-linux
.
The /usr/lib/ruby/1.8/ directory is where the Ruby standard library is installed.
The /usr/lib/ruby/1.8/i386-linux/ directory holds Linux binary extensions for the stand-
ard library. The site_ruby directories in the path are for site-specific libraries that you
have installed. Note that site-specific directories are searched first, which means that
you can override the standard library with files installed here. The current working
directory “.” is at the end of the search path. This is the directory from which a user
invokes your Ruby program; it is not the same as the directory in which your Ruby
program is installed.
In Ruby 1.9, the default load path is more complicated. Here is a typical value:
/usr/local/lib/ruby/gems/1.9/gems/rake-0.7.3/lib
/usr/local/lib/ruby/gems/1.9/gems/rake-0.7.3/bin
/usr/local/lib/ruby/site_ruby/1.9
/usr/local/lib/ruby/site_ruby/1.9/i686-linux
/usr/local/lib/ruby/site_ruby
/usr/local/lib/ruby/vendor_ruby/1.9
/usr/local/lib/ruby/vendor_ruby/1.9/i686-linux
/usr/local/lib/ruby/vendor_ruby
/usr/local/lib/ruby/1.9
/usr/local/lib/ruby/1.9/i686-linux


One minor load path change in Ruby 1.9 is the inclusion of vendor_ruby directories
that are searched after site_ruby and before the standard library. These are intended for
customizations provided by operating system vendors.
The more significant load path change in Ruby 1.9 is the inclusion of RubyGems in-
stallation directories. In the path shown here, the first two directories searched are for
the rake package installed with the gem command of the RubyGems package manage-
ment system. There is only one gem installed in this example, but if you have many
gems on your system, your default load path may become quite long. (When running
programs that do not use gems, you may get a minor speed boost by invoking Ruby
with the --disable-gems command-line option, which prevents these directories from
being added to the load path.) If more than one version of a gem is installed, the version
with the highest version number is included in the default load path. Use the
Kernel.gem method to alter this default.
RubyGems is built into Ruby 1.9: the gem command is distributed with Ruby and can
be used to install new packages whose installation directories are automatically added
to the default load path. In Ruby 1.8, RubyGems must be installed separately (though
some distributions of Ruby 1.8 may automatically bundle it), and gem installation di-
rectories are never added to the load path. Instead, Ruby 1.8 programs require the


rubygems module. Doing this replaces the default require method with a new version
that knows where to look for installed gems. See §1.2.5 for more on RubyGems.
You can add new directories to the start of Ruby’s search path with the –I command-
line option to the Ruby interpreter. Use multiple –I options to specify multiple
directories, or use a single –I and separate multiple directories from each other with
colons (or semicolons on Windows).
Ruby programs can also modify their own load path by altering the contents of the
$LOAD_PATH array. Here are some examples:
# Remove the current directory from the load path
$:.pop if $:.last == '.'
# Add the installation directory for the current program to
# the beginning of the load path
$LOAD_PATH.unshift File.expand_path($PROGRAM_NAME)
# Add the value of an environment variable to the end of the path
$LOAD_PATH << ENV['MY_LIBRARY_DIRECTORY']
Finally, keep in mind that you can bypass the load path entirely by passing absolute
filenames (that begin with / or ~) to load or require.


Singleton Methods and the Eigenclass
We learned in Chapter 6 that it is possible to define singleton methods—methods that
are defined for only a single object rather than a class of objects. To define a singleton
method sum on an object Point, we’d write:
def Point.sum
# Method body goes here
end
As noted earlier in this chapter, the class methods of a class are nothing more than
singleton methods on the Class instance that represents that class.
The singleton methods of an object are not defined by the class of that object. But they
are methods and they must be associated with a class of some sort. The singleton
methods of an object are instance methods of the anonymous eigenclass associated with
that object. “Eigen” is a German word meaning (roughly) “self,” “own,” “particular
to,” or “characteristic of.” The eigenclass is also called the singleton class or (less com-
monly) the metaclass. The term “eigenclass” is not uniformly accepted within the Ruby
community, but it is the term we’ll use in this book.
Ruby defines a syntax for opening the eigenclass of an object and adding methods to
it. This provides an alternative to defining singleton methods one by one; we can instead
define any number of instance methods of the eigenclass. To open the eigenclass of the
object o, use class << o. For example, we can define class methods of Point like this:


class << Point
def class_method1
end
# This is an instance method of the eigenclass.
# It is also a class method of Point.
def class_method2
end
end
If you open the eigenclass of a class object within the definition of a class itself, then
you can use self instead of repeating the name of the class. To repeat an example from
earlier in this chapter:
class Point
# instance methods go here
class << self
# class methods go here as instance methods of the eigenclass
end
end
Be careful with your syntax. Note that there is considerable difference between the
following three lines:
class Point
class Point3D < Point
class << Point
# Create or open the class Point
# Create a subclass of Point
# Open the eigenclass of the object Point
In general, it is clearer to define class methods as individual singleton methods without
explicitly opening the eigenclass.
When you open the eigenclass of an object, self refers to the eigenclass object. The
idiom for obtaining the eigenclass of an object o is therefore:
eigenclass = class << o; self; end
We can formalize this into a method of Object, so that we can ask for the eigenclass of
any object:
class Object
def eigenclass
class << self; self; end
end
end
Unless you are doing sophisticated metaprogramming with Ruby, you are unlikely to
really need an eigenclass utility function like the one shown here. It is worth under-
standing eigenclasses, however, because you’ll occasionally see them used in existing
code, and because they’re an important part of Ruby’s method name resolution
algorithm, which we describe next.



Method Lookup
When Ruby evaluates a method invocation expression, it must first figure out which
method is to be invoked. The process for doing this is called method lookup or method
name resolution. For the method invocation expression o.m, Ruby performs name
resolution with the following steps:
1. First, it checks the eigenclass of o for singleton methods named m.
2. If no method m is found in the eigenclass, Ruby searches the class of o for an instance
method named m.
3. If no method m is found in the class, Ruby searches the instance methods of any
modules included by the class of o. If that class includes more than one module,
then they are searched in the reverse of the order in which they were included. That
is, the most recently included module is searched first.
4. If no instance method m is found in the class of o or in its modules, then the search
moves up the inheritance hierarchy to the superclass. Steps 2 and 3 are repeated
for each class in the inheritance hierarchy until each ancestor class and its included
modules have been searched.

5. If no method named m is found after completing the search, then a method named
method_missing is invoked instead. In order to find an appropriate definition of this
method, the name resolution algorithm starts over at step 1. The Kernel module
provides a default implementation of method_missing, so this second pass of name
resolution is guaranteed to succeed. The method_missing method is covered in more
detail in §8.4.5.
Let’s consider a concrete example of this algorithm. Suppose we have the following
code:
message = "hello"
message.world
We want to invoke a method named world on the String instance "hello". Name
resolution proceeds as follows:


1. Check the eigenclass for singleton methods. There aren’t any in this case.
2. Check the String class. There is no instance method named world.
3. Check the Comparable and Enumerable modules of the String class for an instance
method named world. Neither module defines such a method.
4. Check the superclass of String, which is Object. The Object class does not define
a method named world, either.
5. Check the Kernel module included by Object. The world method is not found here
either, so we now switch to looking for a method named method_missing.
6. Look for method_missing in each of the spots above (the eigenclass of the String
object, the String class, the Comparable and Enumerable modules, the Object class,
and the Kernel module). The first definition of method_missing we find is in the
Kernel module, so this is the method we invoke. What it does is raise an exception:
NoMethodError: undefined method world for "hello":String
This may seem like it requires Ruby to perform an exhaustive search every time it
invokes a method. In typical implementations, however, successful method lookups
will be cached so that subsequent lookups of the same name (with no intervening
method definitions) will be very quick.

 Class Method Lookup
The name resolution algorithm for class methods is exactly the same as it is for instance
methods, but there is a twist. Let’s start with a simple case, without the twist. Here is
a class C that defines no class methods of its own:
class C
end

Remember that after we define a class like this, the constant C refers to an object that
is an instance of Class. Any class methods we define are simply singleton methods of
the object C.
Once we have defined a class C, we are likely to write a method invocation expression
involving the class method new:
c = C.new
To resolve the method new, Ruby first looks for singleton methods in the eigenclass of
the object C. Our class does not have any class methods, so nothing is found there. After
searching the eigenclass, the name resolution algorithm searches the class object of C.
The class of C is Class, so Ruby next looks for methods in Class, and it finds an instance
method named new there


You read that right. The method name resolution algorithm for the class method
C.new ends up locating the instance method Class.new. The distinction between instance
methods and class methods is a useful one to draw in the object-oriented programming
paradigm, but the truth is that in Ruby—where classes are represented by objects—
the distinction is somewhat artificial. Every method invocation, whether instance
method or class method, has a receiver object and a method name. The name resolution
algorithm finds the appropriate method definition for that object. Our object C is an
instance of class Class, so we can of course invoke the instance methods of Class
through C. Furthermore, Class inherits the instance methods of Module, Object, and
Kernel, so those inherited methods are also available as methods of C. The only reason
we call these “class methods” is that our object C happens to be a class.
Our class method C.new is found as an instance method of Class. If it had not been
found there, however, the name resolution algorithm would have continued just as it
would have for an instance method. After searching Class unsuccessfully, we would
have looked at modules (Class doesn’t include any) and then at the superclass
Module. Next, we would search the modules of Module (there aren’t any), and finally the
superclass of Module, Object, and its module Kernel.
The twist mentioned at the beginning of this section has to do with the fact that class
methods are inherited just like instance methods are. Let’s define a class method
Integer.parse to use as an example:
def Integer.parse(text)
text.to_i
end
Because Fixnum is a subclass of Integer, we can invoke this method with an expression
like this:
n = Fixnum.parse("1")
From the description of the method name resolution algorithm that we’ve seen previ-
ously, we know that Ruby would first search the eigenclass of Fixnum for singleton
methods. Next, it would search for instance methods of Class, Module, Object, and


Kernel. So where does it find the parse method? A class method of Integer is just a
singleton method of the Integer object, which means that it is defined by the eigenclass
of Integer. So how does this eigenclass of Integer get involved in the name resolution
algorithm?
Class objects are special: they have superclasses. The eigenclasses of class objects are
also special: they have superclasses, too. The eigenclass of an ordinary object stands
alone and has no superclass. Let’s use the names Fixnum' and Integer' to refer to the
eigenclasses of Fixnum and Integer. The superclass of Fixnum' is Integer'.
With that twist in mind, we can now more fully explain the method name resolution
algorithm and say that when Ruby searches for singleton methods in the eigenclass of
an object, it also searches the superclass (and all ancestors) of the eigenclass as well. So
when looking for a class method of Fixnum, Ruby first checks the singleton methods of
Fixnum, Integer, Numeric, and Object, and then checks the instance methods of Class,
Module, Object, and Kernel.


Constant Lookup
When a constant is referenced without any qualifying namespace, the Ruby interpreter
must find the appropriate definition of the constant. To do so, it uses a name resolution
algorithm, just as it does to find method definitions. However, constants are resolved
much differently than methods.
Ruby first attempts to resolve a constant reference in the lexical scope of the reference.
This means that it first checks the class or module that encloses the constant reference
to see if that class or module defines the constant. If not, it checks the next enclosing
class or module. This continues until there are no more enclosing classes or modules.
Note that top-level or “global” constants are not considered part of the lexical scope
and are not considered during this part of constant lookup. The class method
Module.nesting returns the list of classes and modules that are searched in this step, in
the order they are searched.
If no constant definition is found in the lexically enclosing scope, Ruby next tries to
resolve the constant in the inheritance hierarchy by checking the ancestors of the class
or module that referred to the constant. The ancestors method of the containing class
or module returns the list of classes and modules searched in this step.
If no constant definition is found in the inheritance hierarchy, then top-level constant
definitions are checked.
If no definition can be found for the desired constant, then the const_missing method
—if there is one—of the containing class or module is called and given the opportunity
to provide a value for the constant. This const_missing hook is covered in Chapter 8,
and Example 8-3 illustrates its use.


There are a few points about this constant lookup algorithm that are worth noting in
more detail:
• Constants defined in enclosing modules are found in preference to constants
defined in included modules.
• The modules included by a class are searched before the superclass of the class.
• The Object class is part of the inheritance hierarchy of all classes. Top-level con-
stants, defined outside of any class or module, are like top-level methods: they are
implicitly defined in Object. When a top-level constant is referenced from within
a class, therefore, it is resolved during the search of the inheritance hierarchy. If
the constant is referenced within a module definition, however, an explicit check
of Object is needed after searching the ancestors of the module.
• The Kernel module is an ancestor of Object. This means that constants defined in
Kernel behave like top-level constants but can be overridden by true top-level
constants, that are defined in Object.
Example 7-1 defines and resolves constants in six different scopes and demonstrates
the constant name lookup algorithm described previously.
module Kernel
# Constants defined in Kernel
A = B = C = D = E = F = "defined in kernel"
end
# Top-level or "global" constants defined in Object
A = B = C = D = E = "defined at toplevel"
class Super
# Constants defined in a superclass
A = B = C = D = "defined in superclass"
end
module Included
# Constants defined in an included module
A = B = C = "defined in included module"
end
module Enclosing
# Constants defined in an enclosing module
A = B = "defined in enclosing module"
class Local < Super
include Included
# Locally defined constant
A = "defined locally"
# The list of modules searched, in the order searched
# [Enclosing::Local, Enclosing, Included, Super, Object, Kernel]
search = (Module.nesting + self.ancestors + Object.ancestors).uniq
puts
puts
puts
puts
puts
puts
end
end
A
B
C
D
E
F
#
#
#
#
#
#
Prints
Prints
Prints
Prints
Prints
Prints
"defined
"defined
"defined
"defined
"defined
"defined
locally"
in enclosing module"
in included module"
in superclass"
at toplevel"
in kernel"
Reflection and Metaprogramming
We’ve seen that Ruby is a very dynamic language; you can insert new methods into
classes at runtime, create aliases for existing methods, and even define methods on
individual objects. In addition, it has a rich API for reflection. Reflection, also called
introspection, simply means that a program can examine its state and its structure. A
Ruby program can, for example, obtain the list of methods defined by the Hash class,
query the value of a named instance variable within a specified object, or iterate through
all Regexp objects currently defined by the interpreter. The reflection API actually goes
further and allows a program to alter its state and structure. A Ruby program can
dynamically set named variables, invoke named methods, and even define new classes
and new methods.
Ruby’s reflection API—along with its generally dynamic nature, its blocks-and-
iterators control structures, and its parentheses-optional syntax—makes it an ideal
language for metaprogramming. Loosely defined, metaprogramming is writing pro-
grams (or frameworks) that help you write programs. To put it another way, meta-
programming is a set of techniques for extending Ruby’s syntax in ways that make
programming easier. Metaprogramming is closely tied to the idea of writing domain-
specific languages, or DSLs. DSLs in Ruby typically use method invocations and blocks
as if they were keywords in a task-specific extension to the language.
This chapter starts with several sections that introduce Ruby’s reflection API. This API
is surprisingly rich and consists of quite a few methods. These methods are defined,
for the most part, by Kernel, Object, and Module.
As you read these introductory sections, keep in mind that reflection is not, by itself,
metaprogramming. Metaprogramming typically extends the syntax or the behavior of
Ruby in some way, and often involves more than one kind of reflection. After intro-
ducing Ruby’s core reflection API, this chapter moves on to demonstrate, by example,
common metaprogramming techniques that use that API.
Note that this chapter covers advanced topics. You can be a productive Ruby pro-
grammer without ever reading this chapter. You may find it helpful to read the
remaining chapters of this book first, and then return to this chapter. Consider this
chapter a kind of final exam: if you understand the examples (particularly the longer
ones at the end), then you have mastered Ruby!
8.1 Types, Classes, and Modules
The most commonly used reflective methods are those for determining the type of an
object—what class it is an instance of and what methods it responds to. We intrced
most of these important methods early in this book in §3.8.4. To review:
o.class
Returns the class of an object o.
c.superclass
Returns the superclass of a class c.
o.instance_of? c
Determines whether the object o.class == c.
o.is_a? c
Determines whether o is an instance of c, or of any of its subclasses. If c is a module,
this method tests whether o.class (or any of its ancestors) includes the module.
o.kind_of? c
kind_of? is a synonym for is_a?.
c === o
For any class or module c, determines if o.is_a?(c).
o.respond_to? name
Determines whether the object o has a public or protected method with the speci-
fied name. Passes true as the second argument to check private methods as well.
Ancestry and Modules
In addition to these methods that you’ve already seen, there are a few related reflective
methods for determining the ancestors of a class or module and for determining which
modules are included by a class or module. These methods are easy to understand when
demonstrated:
module A; end
module B; include A; end;
class C; include B; end;
# Empty module
# Module B includes A
# Class C includes module B
C < B # =>
B < A # =>
C < A # =>
Fixnum < Integer # =>
Integer <Comparable # =>
Integer < Fixnum # =>
String < Numeric # =>
true: C includes B
true: B includes A
true
true: all fixnums are integers
true: integers are comparable
false: not all integers are fixnums
nil: strings are not numbers
A.ancestors # => [A]
B.ancestors # => [B, A]
C.ancestors # => [C, B, A, Object, Kernel]
String.ancestors # => [String, Enumerable, Comparable, Object, Kernel]
                 # Note: in Ruby 1.9 String is no longer Enumerable
C.include?(B) # =>
C.include?(A) # =>
B.include?(A) # =>
A.include?(A) # =>
A.include?(B) # =>
A.included_modules # => []
B.included_modules # => [A]
C.included_modules # => [B, A, Kernel]
This code demonstrates include?, which is a public instance method defined by the
Module class. But it also features two invocations of the include method (without the
question mark), which is a private instance method of Module. As a private method, it
can only be invoked implicitly on self, which restricts its usage to the body of a class or
module definition. This use of the method include as if it were a keyword is a meta-
programming example in Ruby’s core syntax.
A method related to the private include method is the public Object.extend. This
method extends an object by making the instance methods of each of the specified
modules into singleton methods of the object:
module Greeter; def hi;
s = "string object"
s.extend(Greeter)
s.hi
String.extend(Greeter)
String.hi
"hello"; end; end # A silly module
#
#
#
#
Add hi as a singleton method to s
=> "hello"
Add hi as a class method of String
=> "hello"
The class method Module.nesting is not related to module inclusion or ancestry; in-
stead, it returns an array that specifies the nesting of modules at the current location.
Module.nesting[0] is the current class or module, Module.nesting[1] is the containing
class or module, and so on:
module M
class C
Module.nesting
end
end
# => [M::C, M]
8.1.2 Defining Classes and Module
Classes and modules are instances of the Class and Module classes. As such, you can
create them dynamically:
M = Module.new
C = Class.new
D = Class.new(C) {
include M
}
D.to_s
#
#
#
#
Define a new module M
Define a new class C
Define a subclass of C
that includes module M
# => "D": class gets constant name by magic
One nice feature of Ruby is that when a dynamically created anonymous module or
class is assigned to a constant, the name of that constant is used as the name of the
module or class (and is returned by its name and to_s methods).
Evaluating Strings and Blocks
One of the most powerful and straightforward reflective features of Ruby is its eval
method. If your Ruby program can generate a string of valid Ruby code, the
Kernel.eval method can evaluate that code:
x = 1
eval "x + 1"
# => 2
eval is a very powerful function, but unless you are actually writing a shell program
(like irb) that executes lines of Ruby code entered by a user you are unlikely to really
need it. (And in a networked context, it is almost never safe to call eval on text received
from a user, as it could contain malicious code.) Inexperienced programmers some-
times end up using eval as a crutch. If you find yourself using it in your code, see if
there isn’t a way to avoid it. Having said that, there are some more useful ways to use
eval and eval-like methods.
 Bindings and eval
A Binding object represents the state of Ruby’s variable bindings at some moment. The
Kernel.binding object returns the bindings in effect at the location of the call. You may
pass a Binding object as the second argument to eval, and the string you specify will
be evaluated in the context of those bindings. If, for example, we define an instance
method that returns a Binding object that represents the variable bindings inside an
object, then we can use those bindings to query and set the instance variables of that
object. We might accomplish this as follows:
class Object
def bindings
binding
end
end
# Open Object to add a new method
# Note plural on this method
# This is the predefined Kernel method
class Test
# A simple class with an instance variable
def initialize(x); @x = x; end
end
t = Test.new(10)
# Create a test object
eval("@x", t.bindings) # => 10: We've peeked inside t
Note that it is not actually necessary to define an Object.bindings method of this sort
to peek at the instance variables of an object. Several other methods described shortly
offer easier ways to query (and set) the value of the instance variables of an object.
As described in §6.6.2, the Proc object defines a public binding method that returns a
Binding object representing the variable bindings in effect for the body of that Proc.
Furthermore, the eval method allows you to pass a Proc object instead of a Binding
object as the second argument.
Ruby 1.9 defines an eval method on Binding objects, so instead of passing a Binding as
the second argument to the global eval, you can instead invoke the eval method on a
Binding. Which one you choose is purely a stylistic matter; the two techniques are
equivalent
instance_eval and class_eval
The Object class defines a method named instance_eval, and the Module class defines
a method named class_eval. (module_eval is a synonym for class_eval.) Both of these
methods evaluate Ruby code, like eval does, but there are two important differences.
The first difference is that they evaluate the code in the context of the specified object
or in the context of the specified module—the object or module is the value of self
while the code is being evaluated. Here are some examples:
o.instance_eval("@x")
# Return the value of o's instance variable @x
# Define an instance method len of String to return string length
String.class_eval("def len; size; end")
# Here's another way to do that
# The quoted code behaves just as if it was inside "class String" and "end"
String.class_eval("alias len size")
# Use instance_eval to define class method String.empty
# Note that quotes within quotes get a little tricky...
String.instance_eval("def empty; ''; end")
Note the subtle but crucial difference between instance_eval and class_eval when the
code being evaluated contains a method definition. instance_eval defines singleton
methods of the object (and this results in class methods when it is called on a class
object). class_eval defines regular instance methods.
The second important difference between these two methods and the global eval is
that instance_eval and class_eval can accept a block of code to evaluate. When passed
a block instead of a string, the code in the block is executed in the appropriate context.
Here, therefore, are alternatives to the previously shown invocations:
o.instance_eval { @x }
String.class_eval {
def len
size
end
}
String.class_eval { alias len size }
String.instance_eval { def empty; ""; end }
 instance_exec and class_exec
Ruby 1.9 defines two more evaluation methods: instance_exec and class_exec (and its
alias, module_exec). These methods evaluate a block (but not a string) of code in the
context of the receiver object, as instance_eval and class_eval do. The difference is
that the exec methods accept arguments and pass them to the block. Thus, the block
of code is evaluated in the context of the specified object, with parameters whose values
come from outside the object.
Variables and Constants
Kernel, Object, and Module define reflective methods for listing the names (as strings)
of all defined global variables, currently defined local variables, all instance variables
of an object, all class variables of a class or module, and all constants of a class or
module:
global_variables
x = 1
local_variables
# => ["$DEBUG", "$SAFE", ...]
# Define a local variable
# => ["x"]
# Define a simple class
class Point
def initialize(x,y); @x,@y = x,y; end # Define instance variables
@@classvar = 1
# Define a class variable
ORIGIN = Point.new(0,0)
# Define a constant
end
Point::ORIGIN.instance_variables # => ["@y", "@x"]
Point.class_variables
# => ["@@classvar"]
Point.constants
# => ["ORIGIN"]
The global_variables, instance_variables, class_variables, and constants methods
return arrays of strings in Ruby 1.8 and arrays of symbols in Ruby 1.9. The
local_variables method returns an array of strings in both versions of the language.



 instance_eval and class_eval
The Object class defines a method named instance_eval, and the Module class defines
a method named class_eval. (module_eval is a synonym for class_eval.) Both of these
methods evaluate Ruby code, like eval does, but there are two important differences.
The first difference is that they evaluate the code in the context of the specified object
or in the context of the specified module—the object or module is the value of self
while the code is being evaluated. Here are some examples:
o.instance_eval("@x")
# Return the value of o's instance variable @x
# Define an instance method len of String to return string length
String.class_eval("def len; size; end")
# Here's another way to do that
# The quoted code behaves just as if it was inside "class String" and "end"
String.class_eval("alias len size")
# Use instance_eval to define class method String.empty
# Note that quotes within quotes get a little tricky...
String.instance_eval("def empty; ''; end")
Note the subtle but crucial difference between instance_eval and class_eval when the
code being evaluated contains a method definition. instance_eval defines singleton
methods of the object (and this results in class methods when it is called on a class
object). class_eval defines regular instance methods
The second important difference between these two methods and the global eval is
that instance_eval and class_eval can accept a block of code to evaluate. When passed
a block instead of a string, the code in the block is executed in the appropriate context.
Here, therefore, are alternatives to the previously shown invocations:
o.instance_eval { @x }
String.class_eval {
def len
size
end
}
String.class_eval { alias len size }
String.instance_eval { def empty; ""; end }


instance_exec and class_exec
Ruby 1.9 defines two more evaluation methods: instance_exec and class_exec (and its
alias, module_exec). These methods evaluate a block (but not a string) of code in the
context of the receiver object, as instance_eval and class_eval do. The difference is
that the exec methods accept arguments and pass them to the block. Thus, the block
of code is evaluated in the context of the specified object, with parameters whose values
come from outside the object.

Variables and Constants
Kernel, Object, and Module define reflective methods for listing the names (as strings)
of all defined global variables, currently defined local variables, all instance variables
of an object, all class variables of a class or module, and all constants of a class or
module:
global_variables
x = 1
local_variables
# => ["$DEBUG", "$SAFE", ...]
# Define a local variable
# => ["x"]
# Define a simple class
class Point
def initialize(x,y); @x,@y = x,y; end # Define instance variables
@@classvar = 1
# Define a class variable
ORIGIN = Point.new(0,0)
# Define a constant
end
Point::ORIGIN.instance_variables # => ["@y", "@x"]
Point.class_variables
# => ["@@classvar"]
Point.constants
# => ["ORIGIN"]
The global_variables, instance_variables, class_variables, and constants methods
return arrays of strings in Ruby 1.8 and arrays of symbols in Ruby 1.9. The
local_variables method returns an array of strings in both versions of the language.

 Variables and Constants
Kernel, Object, and Module define reflective methods for listing the names (as strings)
of all defined global variables, currently defined local variables, all instance variables
of an object, all class variables of a class or module, and all constants of a class or
module:
global_variables
x = 1
local_variables
# => ["$DEBUG", "$SAFE", ...]
# Define a local variable
# => ["x"]
# Define a simple class
class Point
def initialize(x,y); @x,@y = x,y; end # Define instance variables
@@classvar = 1
# Define a class variable
ORIGIN = Point.new(0,0)
# Define a constant
end
Point::ORIGIN.instance_variables # => ["@y", "@x"]
Point.class_variables
# => ["@@classvar"]
Point.constants
# => ["ORIGIN"]
The global_variables, instance_variables, class_variables, and constants methods
return arrays of strings in Ruby 1.8 and arrays of symbols in Ruby 1.9. The
local_variables method returns an array of strings in both versions of the language.


Querying, Setting, and Testing Variables
In addition to listing defined variables and constants, Ruby Object and Module also
define reflective methods for querying, setting, and removing instance variables, class
variables, and constants. There are no special purpose methods for querying or setting
local variables or global variables, but you can use the eval method for this purpose:
x = 1
varname = "x"
eval(varname)
eval("varname = '$g'")
eval("#{varname} = x")
eval(varname)
#
#
#
#
=> 1
Set varname to "$g"
Set $g to 1
=> 1
Note that eval evaluates its code in a temporary scope. eval can alter the value of
instance variables that already exist. But any new instance variables it defines are local
to the invocation of eval and cease to exist when it returns. (It is as if the evaluated
code is run in the body of a block—variables local to a block do not exist outside the
block.)
You can query, set, and test the existence of instance variables on any object and of
class variables and constants on any class or module:
o = Object.new
o.instance_variable_set(:@x, 0)
o.instance_variable_get(:@x)
# Note required @ prefix
# => 0
o.instance_variable_defined?(:@x) # => true
Object.class_variable_set(:@@x, 1)
# Private in Ruby 1.8
Object.class_variable_get(:@@x)
# Private in Ruby 1.8
Object.class_variable_defined?(:@@x) # => true; Ruby 1.9 and later
Math.const_set(:EPI, Math::E*Math::PI)
Math.const_get(:EPI)
# => 8.53973422267357
Math.const_defined? :EPI
# => true
In Ruby 1.9, you can pass false as the second argument to const_get and
const_defined? to specify that these methods should only look at the current class or
module and should not consider inherited constants.
The methods for querying and setting class variables are private in Ruby 1.8. In that
version, you can invoke them with class_eval:
String.class_eval { class_variable_set(:@@x, 1) }
String.class_eval { class_variable_get(:@@x) }
# Set @@x in String
# => 1
Object and Module define private methods for undefining instance variables, class var-
iables, and constants. They all return the value of the removed variable or constant.
Because these methods are private, you can’t invoke them directly on an object, class,
or module, and you must use an eval method or the send method (described later in
this chapter):
o.instance_eval { remove_instance_variable :@x }
String.class_eval { remove_class_variable(:@@x) }
Math.send :remove_const, :EPI # Use send to invoke private method
The const_missing method of a module is invoked, if there is one, when a reference is
made to an undefined constant. You can define this method to return the value of the
named constant. (This feature can be used, for example, to implement an autoload
facility in which classes or modules are loaded on demand.) Here is a simpler example:
def Symbol.const_missing(name)
name # Return the constant name as a symbol
end
Symbol::Test
# => :Test: undefined constant evaluates to a Symbol
Methods
The Object and Module classes define a number of methods for listing, querying,
invoking, and defining methods. We’ll consider each category in turn.
8.4.1 Listing and Testing For Methods
Object defines methods for listing the names of methods defined on the object. These
methods return arrays of methods names. Those name are strings in Ruby 1.8 and
symbols in Ruby 1.9:
It is also possible to query a class for the methods it defines rather than querying an
instance of the class. The following methods are defined by Module. Like the Object
methods, they return arrays of strings in Ruby 1.8 and arrays of symbols in 1.9:
String.instance_methods == "s".public_methods
# => true
String.instance_methods(false) == "s".public_methods(false) # => true
String.public_instance_methods == String.instance_methods
# => true
String.protected_instance_methods
# => []
String.private_instance_methods(false) # => ["initialize_copy",
#
"initialize"]
Recall that the class methods of a class or module are singleton methods of the Class
or Module object. So to list class methods, use Object.singleton_methods:
Math.singleton_methods
# => ["acos", "log10", "atan2", ... ]
In addition to these listing methods, the Module class defines some predicates for testing
whether a specified class or module defines a named instance method:
String.public_method_defined? :reverse
String.protected_method_defined? :reverse
String.private_method_defined? :initialize
String.method_defined? :upcase!
#
#
#
#
=>
=>
=>
=>
true
false
true
true
Module.method_defined? checks whether the named method is defined as a public or
protected method. It serves essentially the same purpose as Object.respond_to?. In
Ruby 1.9, you can pass false as the second argument to specify that inherited methods
should not be considered.
Obtaining Method Objects
To query a specific named method, call method on any object or instance_method on
any module. The former returns a callable Method object bound to the receiver, and the
latter returns an UnboundMethod. In Ruby 1.9, you can limit your search to public meth-
ods by calling public_method and public_instance_method. We covered these methods
and the objects they return in §6.7:
"s".method(:reverse)
# => Method object
String.instance_method(:reverse) # => UnboundMethod object
 Invoking Methods
As noted earlier, and in §6.7, you can use the method method of any object to obtain a
Method object that represents a named method of that object. Method objects have a
call method just like Proc objects do; you can use it to invoke the method.
Usually, it is simpler to invoke a named method of a specified object with send:
"hello".send :upcase
# => "HELLO": invoke an instance method
Math.send(:sin, Math::PI/2) # => 1.0: invoke a class method
send invokes on its receiver the method named by its first argument, passing any
remaining arguments to that method. The name “send” derives from the object-
oriented idiom in which invoking a method is called “sending a message” to an object.
send can invoke any named method of an object, including private and protected meth-
ods. We saw send used earlier to invoke the private method remove_const of a Module
object. Because global functions are really private methods of Object, we can use
send to invoke these methods on any object (though this is not anything that we’d ever
actually want to do):
"hello".send :puts, "world"
# prints "world"
Ruby 1.9 defines public_send as an alternative to send. This method works like send,
but will only invoke public methods, not private or protected methods:
"hello".public_send :puts, "world"
# raises NoMethodError
send is a very fundamental method of Object, but it has a common name that might be
overridden in subclasses. Therefore, Ruby defines __send__ as a synonym, and issues a
warning if you attempt to delete or redefine __send__.==++++++++++++++++++++++=========\

 Defining, Undefining, and Aliasing Methods
If you want to define a new instance method of a class or module, use define_method.
This instance method of Module takes the name of the new method (as a Symbol) as its
first argument. The body of the method is provided either by a Method object passed as
the second argument or by a block. It is important to understand that define_method is
private. You must be inside the class or module you want to use it on in order to call it:
# Add an instance method named m to class c with body b
def add_method(c, m, &b)
c.class_eval {
define_method(m, &b)
}
end
add_method(String, :greet) { "Hello, " + self }
"world".greet
# => "Hello, world"
Defining Attribute Accessor Methods
The attr_reader and attr_accessor methods (see §7.1.5) also define new methods for
a class. Like define_method, these are private methods of Module and can easily be im-
plemented in terms of define_method. These method-creation methods are an excellent
example of how define_method is useful. Notice that because these methods are inten-
ded to be used inside a class definition, they are not hampered by the fact that
define_method is private

To define a class method (or any singleton method) with define_method, invoke it on
the eigenclass:
def add_class_method(c, m, &b)
eigenclass = class << c; self; end
eigenclass.class_eval {
define_method(m, &b)
}
end
add_class_method(String, :greet) {|name| "Hello, " + name }
String.greet("world")
# => "Hello, world"
In Ruby 1.9, you can more easily use define_singleton_method, which is a method of
Object:
String.define_singleton_method(:greet) {|name| "Hello, " + name }
One shortcoming of define_method is that it does not allow you to specify a method
body that expects a block. If you need to dynamically create a method that accepts a
block, you will need to use the def statement with class_eval. And if the method you
are creating is sufficiently dynamic, you may not be able to pass a block to
class_eval and will instead have to specify the method definition as a string to be
evaluated. We’ll see examples of this later in the chapter.
To create a synonym or an alias for an existing method, you can normally use the
alias statement:
alias plus +
# Make "plus" a synonym for the + operator
When programming dynamically, however, you sometimes need to use alias_method
instead. Like define_method, alias_method is a private method of Module. As a method,
it can accept two arbitrary expressions as its arguments, rather than requiring two
identifiers to be hardcoded in your source code. (As a method, it also requires a comma
between its arguments.) alias_method is often used for alias chaining existing
methods. Here is a simple example; we’ll see more later in the chapter:
# Create an alias for the method m in the class (or module) c
def backup(c, m, prefix="original")
n = :"#{prefix}_#{m}"
# Compute the alias
c.class_eval {
# Because alias_method is private
alias_method n, m
# Make n an alias for m
}
end
backup(String, :reverse)
"test".original_reverse # => "tset"
As we learned in §6.1.5, you can use the undef statement to undefine a method. This
works only if you can express the name of a method as a hardcoded identifier in your
program. If you need to dynamically delete a method whose name has been computed
by your program, you have two choices: remove_method or undef_method. Both are pri-
vate methods of Module. remove_method removes the definition of the method from the
current class. If there is a version defined by a superclass, that version will now be
inherited. undef_method is more severe; it prevents any invocation of the specified
method through an instance of the class, even if there is an inherited version of that
method.
If you define a class and want to prevent any dynamic alterations to it, simply invoke
the freeze method of the class. Once frozen, a class cannot be altered
Handling Undefined Methods
When the method name resolution algorithm (see §7.8) fails to find a method, it looks
up a method named method_missing instead. When this method is invoked, the first
argument is a symbol that names the method that could not be found. This symbol is
followed by all the arguments that were to be passed to the original method. If there is
a block associated with the method invocation, that block is passed to
method_missing as well.
The default implementation of method_missing, in the Kernel module, simply raises a
NoMethodError. This exception, if uncaught, causes the program to exit with an error
message, which is what you would normally expect to happen when you try to invoke
a method that does not exist.
Defining your own method_missing method for a class allows you an opportunity to
handle any kind of invocation on instances of the class. The method_missing hook is
one of the most powerful of Ruby’s dynamic capabilities, and one of the most com-
monly used metaprogramming techniques. We’ll see examples of its use later in this
chapter. For now, the following example code adds a method_missing method to the
Hash class. It allows us to query or set the value of any named key as if the key were the
name of a method:
class Hash
# Allow hash values to be queried and set as if they were attributes.
# We simulate attribute getters and setters for any key.
def method_missing(key, *args)
text = key.to_s
if text[-1,1] == "="
276 | Chapter 8: Reflection and Metaprogramming
# If key ends with = set a value
self[text.chop.to_sym] = args[0] # Strip = from key
else
# Otherwise...
self[key]
# ...just return the key value
end
end
end
h = {}
h.one = 1
puts h.one
# Create an empty hash object
# Same as h[:one] = 1
# Prints 1. Same as puts h[:one]
8.4.6 Setting Method Visibility
§7.2 introduced public, protected, and private. These look like language keywords
but are actually private instance methods defined by Module. These methods are usually
used as a static part of a class definition. But, with class_eval, they can also be used
dynamically:
String.class_eval { private :reverse }
"hello".reverse # NoMethodError: private method 'reverse'
private_class_method and public_class_method are similar, except that they operate
on class methods and are themselves public:
# Make all Math methods private
# Now we have to include Math in order to invoke its methods
Math.private_class_method *Math.singleton_methods
Hooks
Module, Class, and Object implement several callback methods, or hooks. These meth-
ods are not defined by default, but if you define them for a module, class, or object,
then they will be invoked when certain events occur. This gives you an opportunity to
extend Ruby’s behavior when classes are subclassed, when modules are included, or
when methods are defined. Hook methods (except for some deprecated ones not
described here) have names that end in “ed.”
When a new class is defined, Ruby invokes the class method inherited on the superclass
of the new class, passing the new class object as the argument. This allows classes to
add behavior to or enforce constraints on their descendants. Recall that class methods
are inherited, so that the an inherited method will be invoked if it is defined by any of
the ancestors of the new class. Define Object.inherited to receive notification of all
new classes that are defined:
def Object.inherited(c)
puts "class #{c} < #{self}"
end
When a module is included into a class or into another module, the included class
method of the included module is invoked with the class or module object into which
it was included as an argument. This gives the included module an opportunity to
augment or alter the class in whatever way it wants—it effectively allows a module to
define its own meaning for include. In addition to adding methods to the class into
which it is included, a module with an included method might also alter the existing
methods of that class, for example:
module Final
# A class that includes Final can't be subclassed
def self.included(c)
# When included in class c
c.instance_eval do
# Define a class method of c
def inherited(sub) # To detect subclasses
raise Exception, # And abort with an exception
"Attempt to create subclass #{sub} of Final class #{self}"
end
end
end
end
Similarly, if a module defines a class method named extended, that method will be
invoked any time the module is used to extend an object (with Object.extend). The
argument to the extended method will be the object that was extended, of course, and
the extended method can take whatever actions it wants on that object.
In addition to hooks for tracking classes and the modules they include, there are also
hooks for tracking the methods of classes and modules and the singleton methods of
arbitrary objects. Define a class method named method_added for any class or module
and it will be invoked when an instance method is defined for that class or module:
def String.method_added(name)
puts "New instance method #{name} added to String"
end
Note that the method_added class method is inherited by subclasses of the class on which
it is defined. But no class argument is passed to the hook, so there is no way to tell
whether the named method was added to the class that defines method_added or whether
it was added to a subclass of that class. A workaround for this problem is to define an
inherited hook on any class that defines a method_added hook. The inherited method
can then define a method_added method for each subclass.
When
a
singleton
method
is
defined
for
any
object,
the
method
singleton_method_added is invoked on that object, passing the name of the new method.
Remember that for classes, singleton methods are class methods:
def String.singleton_method_added(name)
puts "New class method #{name} added to String"
end
Interestingly, Ruby invokes this singleton_method_added hook when the hook method
itself is first defined. Here is another use of the hook. In this case,
singleton_method_added is defined as an instance method of any class that includes a
module. It is notified of any singleton methods added to instances of that class:
# Including this module in a class prevents instances of that class
# from having singleton methods added to them. Any singleton methods added
# are immediately removed again.
module Strict
def singleton_method_added(name)
STDERR.puts "Warning: singleton #{name} added to a Strict object"
eigenclass = class << self; self; end
eigenclass.class_eval { remove_method name }
end
end
In addition to method_added and singleton_method_added, there are hooks for tracking
when instance methods and singleton methods are removed or undefined. When an
instance method is removed or undefined on a class or module, the class methods
method_removed and method_undefined are invoked on that module. When a singleton
method is removed or undefined on an object, the methods
singleton_method_removed and singleton_method_undefined are invoked on that object.
Finally, note that the method_missing and const_missing methods documented
elsewhere in this chapter also behave like hook methods.
Tracing
Ruby defines a number of features for tracing the execution of a program. These are
mainly useful for debugging code and printing informative error messages. Two of the
simplest features are actual language keywords: __FILE__ and __LINE__. These keyword
expressions always evaluate to the name of the file and the line number within that file
on which they appear, and they allow an error message to specify the exact location at
which it was generated:
STDERR.puts #{__FILE__}:#{__LINE__): invalid data
As an aside, note that the methods Kernel.eval, Object.instance_eval, and
Module.class_eval all accept a filename (or other string) and a line number as their final
two arguments. If you are evaluating code that you have extracted from a file of some
sort, you can use these arguments to specify the values of __FILE__ and __LINE__ for
the evaluation.
You have undoubtedly noticed that when an exception is raised and not handled, the
error message printed to the console contains filename and line number information.
This information is based on __FILE__ and __LINE__, of course. Every Exception object
has a backtrace associated with it that shows exactly where it was raised, where the
method that raised the exception was invoked, where that method was invoked, and
so on. The Exception.backtrace method returns an array of strings containing this
information. The first element of this array is the location at which the exception
occurred, and each subsequent element is one stack frame higher.
You needn’t raise an exception to obtain a current stack trace, however. The
Kernel.caller method returns the current state of the call stack in the same form as
Exception.backtrace. With no argument, caller returns a stack trace whose first ele-
ment is the method that invoked the method that calls caller. That is, caller[0]
specifies the location from which the current method was invoked. You can also invoke
caller with an argument that specifies how many stack frames to drop from the start
of the backtrace. The default is 1, and caller(0)[0] specifies the location at which the
caller method is invoked. This means, for example, that caller[0] is the same thing
as caller(0)[1] and that caller(2) is the same as caller[1..-1].
Stack traces returned by Exception.backtrace and Kernel.caller also include method
names. Prior to Ruby 1.9, you must parse the stack trace strings to extract method
names. In Ruby 1.9, however, you can obtain the name (as a symbol) of the currently
executing method with Kernel.__method__ or its synonym, Kernel.__callee__.
__method__ is useful in conjunction with __FILE__ and __LINE__:
raise "Assertion failed in #{__method__} at #{__FILE__}:#{__LINE__}"
Note that __method__ returns the name by which a method was originally defined, even
if the method was invoked through an alias.

Instead of simply printing the filename and number at which an error occurs, you can
take it one step further and display the actual line of code. If your program defines a
global constant named SCRIPT_LINES__ and sets it equal to a hash, then the require and
load methods add an entry to this hash for each file they load. The hash keys are file-
names and the values associated with those keys are arrays that contain the lines of
those files. If you want to include the main file (rather than just the files it requires) in
the hash, initialize it like this:
SCRIPT_LINES__ = {__FILE__ => File.readlines(__FILE__)}
If you do this, then you can obtain the current line of source code anywhere in your
program with this expression:
SCRIPT_LINES__[__FILE__][__LINE__-1]
Ruby allows you to trace assignments to global variables with Kernel.trace_var. Pass
this method a symbol that names a global variable and a string or block of code. When
the value of the named variable changes, the string will be evaluated or the block will
be invoked. When a block is specified, the new value of the variable is passed as an
argument. To stop tracing the variable, call Kernel.untrace_var. In the following
example, note the use of caller[1] to determine the program location at which the
variable tracing block was invoked:
# Print a message every time $SAFE changes
trace_var(:$SAFE) {|v|
puts "$SAFE set to #{v} at #{caller[1]}"
}
The final tracing method is Kernel.set_trace_func, which registers a Proc to be invoked
after every line of a Ruby program. set_trace_func is useful if you want to write a
debugger module that allows line-by-line stepping through a program, but we won’t
cover it in any detail here.
8.7 ObjectSpace and GC
The ObjectSpace module defines a handful of low-level methods that can be occasion-
ally useful for debugging or metaprogramming. The most notable method is
each_object, an iterator that can yield every object (or every instance of a specified class)
that the interpreter knows about:
# Print out a list of all known classes
ObjectSpace.each_object(Class) {|c| puts c }
ObjectSpace._id2ref is the inverse of Object.object_id: it takes an object ID as its
argument and returns the corresponding object, or raises a RangeError if there is no
object with that ID.
ObjectSpace.define_finalizer allows the registration of a Proc or a block of code to be
invoked when a specified object is garbage collected. You must be careful when regis-
tering such a finalizer, however, as the finalizer block is not allowed to use the garbage
collected object. Any values required to finalize the object must be captured in the scope
of the finalizer block, so that they are available without dereferencing the object. Use
ObjectSpace.undefine_finalizer to delete all finalizer blocks registered for an object.
The final ObjectSpace method is ObjectSpace.garbage_collect, which forces Ruby’s
garbage collector to run. Garbage collection functionality is also available through the
GC module. GC.start is a synonym for ObjectSpace.garbage_collect. Garbage collection
can be temporarily disabled with GC.disable, and it can be enabled again with
GC.enable.
The combination of the _id2ref and define_finalizer methods allows the definition
of “weak reference” objects, which hold a reference to a value without preventing the
value from being garbage collected if they become otherwise unreachable. See the
WeakRef class in the standard library (in lib/weakref.rb) for an example.
8.8 Custom Control Structures
Ruby’s use of blocks, coupled with its parentheses-optional syntax, make it very easy
to define iterator methods that look like and behave like control structures. The loop
method of Kernel is a simple example. In this section we develop three more examples.
The examples here use Ruby’s threading API; you may need to read §9.9 to understand
all the details.
Delaying and Repeating Execution: after and every
Example 8-1 defines global methods named after and every. Each takes a numeric
argument that represents a number of seconds and should have a block associated with
it. after creates a new thread and returns the Thread object immediately. The newly
created thread sleeps for the specified number of seconds and then calls (with no
arguments) the block you provided. every is similar, but it calls the block repeatedly,
sleeping the specified number of seconds between calls. The second argument to
every is a value to pass to the first invocation of the block. The return value of each
invocation becomes the value passed for the next invocation. The block associated with
every can use break to prevent any future invocations.
Here is some example code that uses after and every:
require 'afterevery'
1.upto(5) {|i| after i { puts i} }
sleep(5)
every 1, 6 do |count|
puts count
break if count == 10
count + 1
end
sleep(6)
# Slowly print the numbers 1 to 5
# Wait five seconds
# Now slowly print 6 to 10
# The next value of count
# Give the above time to run
The sleep call at the end of this code prevents the example program from exiting before
the thread created by every can complete its count. With that example of how after
and every are used, we are now ready to present their implementation. Remember to
consult §9.9 if you don’t understand Thread.new.
The after and every methods
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
Define Kernel methods after and every for deferring blocks of code.
Examples:
after 1 { puts "done" }
every 60 { redraw_clock }
Both methods return Thread objects. Call kill on the returned objects
to cancel the execution of the code.
Note that this is a very naive implementation. A more robust
implementation would use a single global timer thread for all tasks,
would allow a way to retrieve the value of a deferred block, and would
provide a way to wait for all pending tasks to complete.
# Execute block after sleeping the specified number of seconds.
def after(seconds, &block)
Thread.new do
# In a new thread...
sleep(seconds) # First sleep
block.call
# Then call the block
end
end
# Return the Thread object right away
# Repeatedly sleep and then execute the block.
# Pass value to the block on the first invocation.
# On subsequent invocations, pass the value of the previous invocation.
def every(seconds, value=nil, &block)
Thread.new do
# In a new thread...
loop do
# Loop forever (or until break in block)
sleep(seconds)
# Sleep
value = block.call(value) # And invoke block
end
# Then repeat..
end
# every returns the Thread
end
 Thread Safety with Synchronized Blocks
When writing programs that use multiple threads, it is important that two threads do
not attempt to modify the same object at the same time. One way to do this is to place
the code that must be made thread-safe in a block associated with a call to the
synchronize method of a Mutex object. Again, this is discussed in detail in §9.9. In
Example 8-2 we take this a step further, and emulate Java’s synchronized keyword with
a global method named synchronized. This synchronized method expects a single object
argument and a block. It obtains a Mutex associated with the object, and uses
Mutex.synchronize to invoke the block. The tricky part is that Ruby’s object, unlike
Java’s objects, do not have a Mutex associated with them. So Example 8-2 also defines
an instance method named mutex in Object. Interestingly, the implementation of this
mutex method uses synchronized in its new keyword-style form!
Example 8-2. Simple synchronized blocks
require 'thread'
# Ruby 1.8 keeps Mutex in this library
# Obtain the Mutex associated with the object o, and then evaluate
# the block under the protection of that Mutex.
# This works like the synchronized keyword of Java.
def synchronized(o)
o.mutex.synchronize { yield }
end
# Object.mutex does not actually exist. We've got to define it.
# This method returns a unique Mutex for every object, and
# always returns the same Mutex for any particular object.
# It creates Mutexes lazily, which requires synchronization for
# thread safety.
class Object
# Return the Mutex for this object, creating it if necessary.
# The tricky part is making sure that two threads don't call
# this at the same time and end up creating two different mutexes.
def mutex
# If this object already has a mutex, just return it
return @__mutex if @__mutex
# Otherwise, we've got to create a mutex for the object.
# To do this safely we've got to synchronize on our class object.
synchronized(self.class) {
# Check again: by the time we enter this synchronized block,
# some other thread might have already created the mutex.
@__mutex = @__mutex || Mutex.new
}
# The return value is @__mutex
end
end
# The Object.mutex method defined above needs to lock the class
# if the object doesn't have a Mutex yet. If the class doesn't have
# its own Mutex yet, then the class of the class (the Class object)
# will be locked. In order to prevent infinite recursion, we must
# ensure that the Class object has a mutex.
Class.instance_eval { @__mutex = Mutex.new }
Missing Methods and Missing Constants
The method_missing method is a key part of Ruby’s method lookup algorithm (see
§7.8) and provides a powerful way to catch and handle arbitrary invocations on an
object. The const_missing method of Module performs a similar function for the con-
stant lookup algorithm and allows us to compute or lazily initialize constants on the
fly. The examples that follow demonstrate both of these methods.
8.9.1 Unicode Codepoint Constants with const_missing
Example 8-3 defines a Unicode module that appears to define a constant (a UTF-8
encoded string) for every Unicode codepoint from U+0000 to U+10FFFF. The only prac-
tical way to support this many constants is to use the const_missing method. The code
makes the assumption that if a constant is referenced once, it is likely to be used again,
so the const_missing method calls Module.const_set to define a real constant to refer
to each value it computes.
Example 8-3. Unicode codepoint constants with const_missing
# This module provides constants that define the UTF-8 strings for
# all Unicode codepoints. It uses const_missing to define them lazily.
# Examples:
#
copyright = Unicode::U00A9
#
euro = Unicode::U20AC
#
infinity = Unicode::U221E
module Unicode
# This method allows us to define Unicode codepoint constants lazily.
def self.const_missing(name) # Undefined constant passed as a symbol
# Check that the constant name is of the right form.
# Capital U followed by a hex number between 0000 and 10FFFF.
if name.to_s =~ /^U([0-9a-fA-F]{4,5}|10[0-9a-fA-F]{4})$/
# $1 is the matched hexadecimal number. Convert to an integer.
codepoint = $1.to_i(16)
# Convert the number to a UTF-8 string with the magic of Array.pack.
utf8 = [codepoint].pack("U")
# Make the UTF-8 string immutable.
utf8.freeze
# Define a real constant for faster lookup next time, and return
# the UTF-8 text for this time.
const_set(name, utf8)
else
# Raise an error for constants of the wrong form.
raise NameError, "Uninitialized constant: Unicode::#{name}"
end
end
end
Tracing Method Invocations with method_missing
Earlier in this chapter, we demonstrated an extension to the Hash class using
method_missing. Now, in Example 8-4, we demonstrate the use of method_missing to
delegate arbitrary calls on one object to another object. In this example, we do this in
order to output tracing messages for the object.
Example 8-4 defines an Object.trace instance method and a TracedObject class. The
trace method returns an instance of TracedObject that uses method_missing to catch
invocations, trace them, and delegate them to the object being traced. You might use
it like this:
a = [1,2,3].trace("a")
a.reverse
puts a[2]
puts a.fetch(3)
This produces the following tracing output:
Invoking: a.reverse() at trace1.rb:66
Returning: [3, 2, 1] from a.reverse to trace1.rb:66
Invoking: a.fetch(3) at trace1.rb:67
Raising: IndexError:index 3 out of array from a.fetch
Notice that in addition to demonstrating method_missing, Example 8-4 also demon-
strates Module.instance_methods, Module.undef_method, and Kernel.caller.
Example 8-4. Tracing method invocations with method_missing
# Call the trace method of any object to obtain a new object that
# behaves just like the original, but which traces all method calls
# on that object. If tracing more than one object, specify a name to
# appear in the output. By default, messages will be sent to STDERR,
# but you can specify any stream (or any object that accepts strings
# as arguments to <<).
class Object
def trace(name="", stream=STDERR)
# Return a TracedObject that traces and delegates everything else to us.
TracedObject.new(self, name, stream)
end
end
# This class uses method_missing to trace method invocations and
# then delegate them to some other object. It deletes most of its own
# instance methods so that they don't get in the way of method_missing.
# Note that only methods invoked through the TracedObject will be traced.
# If the delegate object calls methods on itself, those invocations
# will not be traced.
class TracedObject
# Undefine all of our noncritical public instance methods.
# Note the use of Module.instance_methods and Module.undef_method.
instance_methods.each do |m|
m = m.to_sym # Ruby 1.8 returns strings, instead of symbols
next if m == :object_id || m == :__id__ || m == :__send__
undef_method m
end
# Initialize this TracedObject instance.
def initialize(o, name, stream)
@o = o
# The object we delegate to
@n = name
# The object name to appear in tracing messages
@trace = stream
# Where those tracing messages are sent
end
# This is the key method of TracedObject. It is invoked for just
# about any method invocation on a TracedObject.
def method_missing(*args, &block)
m = args.shift
# First arg is the name of the method
begin
# Trace the invocation of the method.
arglist = args.map {|a| a.inspect}.join(', ')
@trace << "Invoking: #{@n}.#{m}(#{arglist}) at #{caller[0]}\n"
# Invoke the method on our delegate object and get the return value.
r = @o.send m, *args, &block
# Trace a normal return of the method.
@trace << "Returning: #{r.inspect} from #{@n}.#{m} to #{caller[0]}\n"
# Return whatever value the delegate object returned.
r
rescue Exception => e
# Trace an abnormal return from the method.
@trace << "Raising: #{e.class}:#{e} from #{@n}.#{m}\n"
# And re-raise whatever exception the delegate object raised.
raise
end
end
# Return the object we delegate to.
def __delegate
@o
end
end
Synchronized Objects by Delegation
In Example 8-2, we saw a global method synchronized, which accepts an object and
executes a block under the protection of the Mutex associated with that object. Most of
the example consisted of the implementation of the Object.mutex method. The
synchronized method was trivial:
def synchronized(o)
o.mutex.synchronize { yield }
end
Example 8-5 modifies this method so that, when invoked without a block, it returns a
SynchronizedObject wrapper around the object. SynchronizedObject is a delegating
wrapper class based on method_missing. It is much like the TracedObject class of Ex-
ample 8-4, but it is written as a subclass of Ruby 1.9’s BasicObject, so there is no need
to explicitly delete the instance methods of Object. Note that the code in this example
does not stand alone; it requires the Object.mutex method defined earlier.
Example 8-5. Synchronizing methods with method_missing
def synchronized(o)
if block_given?
o.mutex.synchronize { yield }
else
SynchronizedObject.new(o)
end
end
# A delegating wrapper class using method_missing for thread safety
# Instead of extending Object and deleting our methods we just extend
# BasicObject, which is defined in Ruby 1.9. BasicObject does not
# inherit from Object or Kernel, so the methods of a BasicObject cannot
# invoke any top-level methods: they are just not there.
class SynchronizedObject < BasicObject
def initialize(o); @delegate = o; end
def __delegate; @delegate; end
def method_missing(*args, &block)
@delegate.mutex.synchronize {
@delegate.send *args, &block
}
end
end
8.10 Dynamically Creating Methods
One important metaprogramming technique is the use of methods that create methods.
The attr_reader and attr_accessor methods (see §7.1.5) are examples. These private
instance methods of Module are used like keywords within class definitions. They accept
attribute names as their arguments, and dynamically create methods with those names.
The examples that follow are variants on these attribute accessor creation methods and
demonstrate two different ways to dynamically create methods like this.
8.10.1 Defining Methods with class_eval
Example 8-6 defines private instance methods of Module named readonly and
readwrite. These methods work like attr_reader and attr_accessor do, and they are
here to demonstrate how those methods are implemented. The implementation is ac-
tually quite simple: readonly and readwrite first build a string of Ruby code containing
the def statements required to define appropriate accessor methods. Next, they evaluate
that string of code using class_eval (described earlier in the chapter). Using
class_eval like this incurs the slight overhead of parsing the string of code. The benefit,
however, is that the methods we define need not use any reflective APIs themselves;
they can query or set the value of an instance variable directly.
Example 8-6. Attribute methods with class_eval
class Module
private
# The methods that follow are both private
# This method works like attr_reader, but has a shorter name
def readonly(*syms)
return if syms.size == 0 # If no arguments, do nothing
code = ""
# Start with an empty string of code
# Generate a string of Ruby code to define attribute reader methods.
# Notice how the symbol is interpolated into the string of code.
syms.each do |s|
# For each symbol
code << "def #{s}; @#{s}; end\n"
# The method definition
end
# Finally, class_eval the generated code to create instance method
class_eval code
end
# This method works like attr_accessor, but has a shorter name.
def readwrite(*syms)
return if syms.size == 0
code = ""
syms.each do |s|
code << "def #{s}; @#{s} end\n"
code << "def #{s}=(value); @#{s} = value; end\n"
end
class_eval code
end
end
8.10.2 Defining Methods with define_method
Example 8-7 is a different take on attribute accessors. The attributes method is some-
thing like the readwrite method defined in Example 8-6. Instead of taking any number
of attribute names as arguments, it expects a single hash object. This hash should have
attribute names as its keys, and should map those attribute names to the default values
for the attributes. The class_attrs method works like attributes, but defines class
attributes rather than instance attributes.
Remember that Ruby allows the curly braces to be omitted around hash literals when
they are the final argument in a method invocation. So the attributes method might
be invoked with code like this:
class Point
attributes :x => 0, :y => 0
end
In Ruby 1.9, we can use the more succinct hash syntax:
class Point
attributes x:0, y:0
end
This is another example that leverages Ruby’s flexible syntax to create methods that
behave like language keywords.
The implementation of the attributes method in Example 8-7 is quite a bit different
than that of the readwrite method in Example 8-6. Instead of defining a string of Ruby
code and evaluating it with class_eval, the attributes method defines the body of the
attribute accessors in a block and defines the methods using define_method. Because
this method definition technique does not allow us to interpolate identifiers directly
into the method body, we must rely on reflective methods such as
instance_variable_get. Because of this, the accessors defined with attributes are likely
to be less efficient than those defined with readwrite.
An interesting point about the attributes method is that it does not explicitly store the
default values for the attributes in a class variable of any kind. Instead, the default value
for each attribute is captured by the scope of the block used to define the method. (See
§6.6 for more about closures like this.)
The class_attrs method defines class attributes very simply: it invokes attributes on
the eigenclass of the class. This means that the resulting methods use class instance
variables (see §7.1.16) instead of regular class variables.
Example 8-7. Attribute methods with define_method
class Module
# This method defines attribute reader and writer methods for named
# attributes, but expects a hash argument mapping attribute names to
# default values. The generated attribute reader methods return the
# default value if the instance variable has not yet been defined.
def attributes(hash)
hash.each_pair do |symbol, default|
# For each attribute/default pair
getter = symbol
# Name of the getter method
setter = :"#{symbol}="
# Name of the setter method
variable = :"@#{symbol}"
# Name of the instance variable
define_method getter do
# Define the getter method
if instance_variable_defined? variable
instance_variable_get variable
else
default
end
end
define_method setter do |value|
instance_variable_set variable,
value
end
end
end
# Return variable, if defined
# Otherwise return default
# Define setter method
# Set the instance variable
# To the argument value
# This method works like attributes, but defines class methods instead
# by invoking attributes on the eigenclass instead of on self.
# Note that the defined methods use class instance variables
# instead of regular class variables.
def class_attrs(hash)
eigenclass = class << self; self; end
eigenclass.class_eval { attributes(hash) }
end
# Both methods are private
private :attributes, :class_attrs
end
Alias Chaining
As we’ve seen, metaprogramming in Ruby often involves the dynamic definition of
methods. Just as common is the dynamic modification of methods. Methods are modi-
fied with a technique we’ll call alias chaining.* It works like this:
• First, create an alias for the method to be modified. This alias provides a name for
the unmodified version of the method.
• Next, define a new version of the method. This new version should call the
unmodified version through the alias, but it can add whatever functionality is
needed before and after it does that.
Note that these steps can be applied repeatedly (as long as a different alias is used each
time), creating a chain of methods and aliases.
This section includes three alias chaining examples. The first performs the alias chain-
ing statically; i.e., using regular alias and def statements. The second and third
examples are more dynamic; they alias chain arbitrarily named methods using
alias_method, define_method, and class_eval.
Tracing Files Loaded and Classes Defined
Example 8-8 is code that keeps track of all files loaded and all classes defined in a
program. When the program exits, it prints a report. You can use this code to “instru-
ment” an existing program so that you better understand what it is doing. One way to
use this code is to insert this line at the beginning of the program:
require 'classtrace'
An easier solution, however, is to use the -r option to your Ruby interpreter:
ruby -rclasstrace my_program.rb
--traceout /tmp/trace
The -r option loads the specified library before it starts running the program. See
§10.1 for more on the Ruby interpreter’s command-line arguments.
Example 8-8 uses static alias chaining to trace all invocations of the Kernel.require and
Kernel.load methods. It defines an Object.inherited hook to track definitions of new
classes. And it uses Kernel.at_exit to execute a block of code when the program ter-
minates. (The END statement described in §5.7 would work here as well.) Besides alias
chaining require and load and defining Object.inherited, the only modification to the
global namespace made by this code is the definition of a module named ClassTrace.
All state required for tracing is stored in constants within this module, so that we don’t
pollute the namespace with global variables.
Example 8-8. Tracing files loaded and classes defined
# We define this module to hold the global state we require, so that
# we don't alter the global namespace any more than necessary.
module ClassTrace
# This array holds our list of files loaded and classes defined.
# Each element is a subarray holding the class defined or the
# file loaded and the stack frame where it was defined or loaded.
T = [] # Array to hold the files loaded
# Now define the constant OUT to specify where tracing output goes.
# This defaults to STDERR, but can also come from command-line arguments
if x = ARGV.index("--traceout")
# If argument exists
OUT = File.open(ARGV[x+1], "w") # Open the specified file
ARGV[x,2] = nil
# And remove the arguments
else
OUT = STDERR
# Otherwise default to STDERR
end
end
# Alias chaining step 1: define aliases for the original methods
alias original_require require
alias original_load load
# Alias chaining step 2: define new versions of the methods
def require(file)
ClassTrace::T << [file,caller[0]]
# Remember what was loaded where
original_require(file)
# Invoke the original method
end
def load(*args)
ClassTrace::T << [args[0],caller[0]]
original_load(*args)
end
# Remember what was loaded where
# Invoke the original method
# This hook method is invoked each time a new class is defined
def Object.inherited(c)
ClassTrace::T << [c,caller[0]]
# Remember what was defined where
end
# Kernel.at_exit registers a block to be run when the program exits
# We use it to report the file and class data we collected
at_exit {
o = ClassTrace::OUT
o.puts "="*60
o.puts "Files Loaded and Classes Defined:"
o.puts "="*60
ClassTrace::T.each do |what,where|
if what.is_a? Class # Report class (with hierarchy) defined
o.puts "Defined: #{what.ancestors.join('<-')} at #{where}"
else
# Report file loaded
o.puts "Loaded: #{what} at #{where}"
end
end
}
Chaining Methods for Thread Safety
Two earlier examples in this chapter have involved thread safety. Example 8-2 defined
a synchronized method (based on an Object.mutex method) that executed a block under
the protection of a Mutex object. Then, Example 8-5 redefined the synchronized method
so that when it was invoked without a block, it would return a SynchronizedObject
wrapper around an object, protecting access to any methods invoked through that
wrapper object. Now, in Example 8-9, we augment the synchronized method again so
that when it is invoked within a class or module definition, it alias chains the named
methods to add synchronization.
The alias chaining is done by our method Module.synchronize_method, which in turn
uses a helper method Module.create_alias to define an appropriate alias for any given
method (including operator methods like +).
After defining these new Module methods, Example 8-9 redefines the synchronized
method again. When the method is invoked within a class or a module, it calls
synchronize_method on each of the symbols it is passed. Interestingly, however, it can
also be called with no arguments; when used this way, it adds synchronization to
whatever instance method is defined next. (It uses the method_added hook to receive
notifications when a new method is added.) Note that the code in this example depends
on the Object.mutex method of Example 8-2 and the SynchronizedObject class of Ex-
ample 8-5.
Example 8-9. Alias chaining for thread safety
# Define a Module.synchronize_method that alias chains instance methods
# so they synchronize on the instance before running.
class Module
# This is a helper function for alias chaining.
# Given a method name (as a string or symbol) and a prefix, create
# a unique alias for the method, and return the name of the alias
# as a symbol. Any punctuation characters in the original method name
# will be converted to numbers so that operators can be aliased.
def create_alias(original, prefix="alias")
# Stick the prefix on the original name and convert punctuation
aka = "#{prefix}_#{original}"
aka.gsub!(/([\=\|\&\+\-\*\/\^\!\?\~\%\<\>\[\]])/) {
num = $1[0]
# Ruby 1.8 character -> ordinal
num = num.ord if num.is_a? String # Ruby 1.9 character -> ordinal
'_' + num.to_s
}
# Keep appending underscores until we get a name that is not in use
aka += "_" while method_defined? aka or private_method_defined? aka
aka = aka.to_sym
alias_method aka, original
aka
end
# Convert the alias name to a symbol
# Actually create the alias
# Return the alias name
# Alias chain the named method to add synchronization
def synchronize_method(m)
# First, make an alias for the unsynchronized version of the method.
aka = create_alias(m, "unsync")
# Now redefine the original to invoke the alias in a synchronized block.
# We want the defined method to be able to accept blocks, so we
# can't use define_method, and must instead evaluate a string with
# class_eval. Note that everything between %Q{ and the matching }
# is a double-quoted string, not a block.
class_eval %Q{
def #{m}(*args, &block)
synchronized(self) { #{aka}(*args, &block) }
end
}
end
end
# This global synchronized method can now be used in three different ways.
def synchronized(*args)
# Case 1: with one argument and a block, synchronize on the object
# and execute the block
if args.size == 1 && block_given?
args[0].mutex.synchronize { yield }
# Case two: with one argument that is not a symbol and no block
# return a SynchronizedObject wrapper
elsif args.size == 1 and not args[0].is_a? Symbol and not block_given?
SynchronizedObject.new(args[0])
# Case three: when invoked on a module with no block, alias chain the
# named methods to add synchronization. Or, if there are no arguments,
# then alias chain the next method defined.
elsif self.is_a? Module and not block_given?
if (args.size > 0) # Synchronize the named methods
args.each {|m| self.synchronize_method(m) }
else
# If no methods are specified synchronize the next method defined
eigenclass = class<<self; self; end
eigenclass.class_eval do # Use eigenclass to define class methods
# Define method_added for notification when next method is defined
define_method :method_added do |name|
# First remove this hook method
eigenclass.class_eval { remove_method :method_added }
# Next, synchronize the method that was just added
self.synchronize_method name
end
end
end
# Case 4: any other invocation is an error
else
raise ArgumentError, "Invalid arguments to synchronize()"
end
end
 Chaining Methods for Tracing
Example 8-10 is a variant on Example 8-4 that supports tracing of named methods of
an object. Example 8-4 used delegation and method_missing to define an
Object.trace method that would return a traced wrapper object. This version uses
chaining to alter methods of an object in place. It defines trace! and untrace! to chain
and unchain named methods of an object.
The interesting thing about this example is that it does its chaining in a different way
from Example 8-9; it simply defines singleton methods on the object and uses super
within the singleton to chain to the original instance method definition. No method
aliases are created.
Example 8-10. Chaining with singleton methods for tracing
# Define trace! and untrace! instance methods for all objects.
# trace! "chains" the named methods by defining singleton methods
# that add tracing functionality and then use super to call the original.
# untrace! deletes the singleton methods to remove tracing.
class Object
# Trace the specified methods, sending output to STDERR.
def trace!(*methods)
@_traced = @_traced || []
# Remember the set of traced methods
# If no methods were specified, use all public methods defined
# directly (not inherited) by the class of this object
methods = public_methods(false) if methods.size == 0
methods.map! {|m| m.to_sym } # Convert any strings to symbols
methods -= @_traced
# Remove methods that are already traced
return if methods.empty?
# Return early if there is nothing to do
@_traced |= methods
# Add methods to set of traced methods
# Trace the fact that we're starting to trace these methods
STDERR << "Tracing #{methods.join(', ')} on #{object_id}\n"
# Singleton methods are defined in the eigenclass
eigenclass = class << self; self; end
methods.each do |m|
# For each method m
# Define a traced singleton version of the method m.
# Output tracing information and use super to invoke the
# instance method that it is tracing.
# We want the defined methods to be able to accept blocks, so we
# can't use define_method, and must instead evaluate a string.
# Note that everything between %Q{ and the matching } is a
# double-quoted string, not a block. Also note that there are
# two levels of string interpolations here. #{} is interpolated
# when the singleton method is defined. And \#{} is interpolated
# when the singleton method is invoked.
eigenclass.class_eval %Q{
def #{m}(*args, &block)
begin
STDERR << "Entering: #{m}(\#{args.join(', ')})\n"
result = super
STDERR << "Exiting: #{m} with \#{result}\n"
result
rescue
STDERR << "Aborting: #{m}: \#{$!.class}: \#{$!.message}"
raise
end
end
}
end
end
# Untrace the specified methods or all traced methods
def untrace!(*methods)
if methods.size == 0
# If no methods specified untrace
methods = @_traced
# all currently traced methods
STDERR << "Untracing all methods on #{object_id}\n"
else
# Otherwise, untrace
methods.map! {|m| m.to_sym } # Convert string to symbols
methods &= @_traced
# all specified methods that are traced
STDERR << "Untracing #{methods.join(', ')} on #{object_id}\n"
end
@_traced -= methods
# Remove them from our set of traced methods
# Remove the traced singleton methods from the eigenclass
# Note that we class_eval a block here, not a string
(class << self; self; end).class_eval do
 Domain-Specific Languages
The goal of metaprogramming in Ruby is often the creation of domain-specific lan-
guages, or DSLs. A DSL is just an extension of Ruby’s syntax (with methods that look
like keywords) or API that allows you to solve a problem or represent data more nat-
urally than you could otherwise. For our examples, we’ll take the problem domain to
be the output of XML formatted data, and we’ll define two DSLs—one very simple and
one more clever—to tackle this problem.*
8.12.1 Simple XML Output with method_missing
We begin with a simple class named XML for generating XML output. Here’s an example
of how the XML can be used:
pagetitle = "Test Page for XML.generate"
XML.generate(STDOUT) do
html do
head do
title { pagetitle }
comment "This is a test"
end
body do
h1(:style => "font-family:sans-serif") { pagetitle }
ul :type=>"square" do
li { Time.now }
li { RUBY_VERSION }
end
end
end
end
This code doesn’t look like XML, and it only sort of looks like Ruby. Here’s the output
it generates (with some line breaks added for legibility):
<html><head>
<title>Test Page for XML.generate</title>
<!-- This is a test -->
</head><body>
<h1 style='font-family:sans-serif'>Test Page for XML.generate</h1>
<ul type='square'>
<li>2007-08-19 16:19:58 -0700</li>
<li>1.9.0</li>
</ul></body></html>
To implement this class and the XML generation syntax it supports, we rely on:
•
•
•
•
Ruby’s block structure
Ruby’s parentheses-optional method invocations
Ruby’s syntax for passing hash literals to methods without curly braces
The method_missing method
Example 8-11 shows the implementation for this simple DSL.
Example 8-11. A simple DSL for generating XML output
class XML
# Create an instance of this class, specifying a stream or object to
# hold the output. This can be any object that responds to <<(String).
def initialize(out)
@out = out # Remember where to send our output
end
# Output the specified object as CDATA, return nil.
def content(text)
@out << text.to_s
nil
end
# Output the specified object as a comment, return nil.
def comment(text)
@out << "<!-- #{text} -->"
nil
end
# Output a tag with the specified name and attributes.
# If there is a block invoke it to output or return content.
# Return nil.
def tag(tagname, attributes={})
# Output the tag name
@out << "<#{tagname}"
# Output the attributes
attributes.each {|attr,value| @out << " #{attr}='#{value}'" }
if block_given?
# This block has content
@out << '>'
#
content = yield
#
if content
#
@out << content.to_s #
end
@out << "</#{tagname}>" #
End the opening tag
Invoke the block to output or return content
If any content returned
Output it as a string
else
# Otherwise, this is an empty tag, so just close it.
@out << '/>'
end
nil # Tags output themselves, so they don't return any content
end
# The code below is what changes this from an ordinary class into a DSL.
# First: any unknown method is treated as the name of a tag.
alias method_missing tag
# Second: run a block in a new instance of the class.
def self.generate(out, &block)
XML.new(out).instance_eval(&block)
end
end
Validated XML Output with Method Generation
The XML class of Example 8-11 is helpful for generating well-formed XML, but it does
no error checking to ensure that the output is valid according to any particular XML
grammar. In the next example, Example 8-12, we add some simple error checking
(though not nearly enough to ensure complete validity—that would require a much
longer example). This example is really two DSLs in one. The first is a DSL for defining
an XML grammar: a set of tags and the allowed attributes for each tag. You use it like
this:
class HTMLForm < XMLGrammar
element :form, :action => REQ,
:method => "GET",
:enctype => "application/x-www-form-urlencoded",
:name => OPT
element :input, :type => "text", :name => OPT, :value => OPT,
:maxlength => OPT, :size => OPT, :src => OPT,
:checked => BOOL, :disabled => BOOL, :readonly => BOOL
element :textarea, :rows => REQ, :cols => REQ, :name => OPT,
:disabled => BOOL, :readonly => BOOL
element :button, :name => OPT, :value => OPT,
:type => "submit", :disabled => OPT
end
This first DSL is defined by the class method XMLGrammar.element. You use it by sub-
classing XMLGrammar to create a new class. The element method expects the name of a
tag as its first argument and a hash of legal attributes as the second argument. The keys
of the hash are attribute names. These names may map to default values for the
attribute, to the constant REQ for required attributes, or to the constant OPT for optional
attributes. Calling element generates a method with the specified name in the subclass
you are defining.
The subclass of XMLGrammar you define is the second DSL, and you can use it to generate
XML output that is valid according to the rules you specified. The XMLGrammar class does
not have a method_missing method so it won’t allow you to use a tag that is not part of
the grammar. And the tag method for outputting tags performs error checking on your
attributes. Use the generated grammar subclass like the XML class of Example 8-11:
HTMLForm.generate(STDOUT) do
comment "This is a simple HTML form"
form :name => "registration",
:action => "http://www.example.com/register.cgi" do
content "Name:"
input :name => "name"
content "Address:"
textarea :name => "address", :rows=>6, :cols=>40 do
"Please enter your mailing address here"
end
button { "Submit" }
end
end
Example 8-12 shows the implementation of the XMLGrammar class.
Example 8-12. A DSL for validated XML output
class XMLGrammar
# Create an instance of this class, specifying a stream or object to
# hold the output. This can be any object that responds to <<(String).
def initialize(out)
@out = out # Remember where to send our output
end
# Invoke the block in an instance that outputs to the specified stream.
def self.generate(out, &block)
new(out).instance_eval(&block)
end
# Define an allowed element (or tag) in the grammar.
# This class method is the grammar-specification DSL
# and defines the methods that constitute the XML-output DSL.
def self.element(tagname, attributes={})
@allowed_attributes ||= {}
@allowed_attributes[tagname] = attributes
class_eval %Q{
def #{tagname}(attributes={}, &block)
tag(:#{tagname},attributes,&block)
end
}
end
# These are constants used when defining attribute values.
OPT = :opt
# for optional attributes
REQ = :req
# for required attributes
BOOL = :bool
# for attributes whose value is their own name
def self.allowed_attributes
@allowed_attributes
end
# Output the specified object as CDATA, return nil.
def content(text)
@out << text.to_s
nil
end
# Output the specified object as a comment, return nil.
def comment(text)
@out << "<!-- #{text} -->"
nil
end
# Output a tag with the specified name and attribute.
# If there is a block, invoke it to output or return content.
# Return nil.
def tag(tagname, attributes={})
# Output the tag name
@out << "<#{tagname}"
# Get the allowed attributes for this tag.
allowed = self.class.allowed_attributes[tagname]
# First, make sure that each of the attributes is allowed.
# Assuming they are allowed, output all of the specified ones.
attributes.each_pair do |key,value|
raise "unknown attribute: #{key}" unless allowed.include?(key)
@out << " #{key}='#{value}'"
end
end
# Now look through the allowed attributes, checking for
# required attributes that were omitted and for attributes with
# default values that we can output.
allowed.each_pair do |key,value|
# If this attribute was already output, do nothing.
next if attributes.has_key? key
if (value == REQ)
raise "required attribute '#{key}' missing in <#{tagname}>"
elsif value.is_a? String
@out << " #{key}='#{value}'"
end
end
if block_given?
# This block has content
@out << '>'
# End the opening tag
content = yield
# Invoke the block to output or return content
if content
# If any content returned
@out << content.to_s # Output it as a string
end
@out << "</#{tagname}>" # Close the tag
else
# Otherwise, this is an empty tag, so just close it.
@out << '/>'
end
nil # Tags output themselves, so they don't return any content.
end
end
Defining Simple Methods
# Define a method named 'factorial' with a single parameter 'n'
def factorial(n)
if n < 1
# Test the argument value for validity
raise "argument must be > 0"
elsif n == 1
# If the argument is 1
1
# then the value of the method invocation is 1
else
# Otherwise, the factorial of n is n times
n * factorial(n-1)
# the factorial of n-1
end
end
Method Return Value
def factorial(n)
raise "bad argument" if n < 1
return 1 if n == 1
n * factorial(n-1)
end
We could also use return on the last line of this method body to emphasize that this
expression is the method’s return value. In common practice, however, return is
omitted where it is not required.
Ruby methods may return more than one value. To do this, use an explicit return
statement, and separate the values to be returned with commas:
# Convert the Cartesian point (x,y) to polar (magnitude, angle) coordinates
def polar(x,y)
return Math.hypot(y,x), Math.atan2(y,x)
end
When there is more than one return value, the values are collected into an array, and
the array becomes the single return value of the method. Instead of using the return
statement with multiple values, we can simply create an array of values ourselves:
# Convert polar coordinates to Cartesian coordinates
def cartesian(magnitude, angle)
[magnitude*Math.cos(angle), magnitude*Math.sin(angle)]
end
Methods of this form are typically intended for use with parallel assignment (see
§4.5.5) so that each return value is assigned to a separate variable:
distance, theta = polar(x,y)
x,y = cartesian(distance,theta)
Methods and Exception Handling
A def statement that defines a method may include exception-handling code in the
form of rescue, else, and ensure clauses, just as a begin statement can. These exception-
handling clauses go after the end of the method body but before the end of the def
statement. In short methods, it can be particularly tidy to associate your rescue clauses
with the def statement. This also means you don’t have to use a begin statement and
the extra level of indentation that comes with it. See §5.6.6 for further details.
 Invoking a Method on an Object
Methods are always invoked on an object. (This object is sometimes called the
receiver in a reference to an object-oriented paradigm in which methods are called
“messages” and are “sent to” receiver objects.) Within the body of a method, the key-
word self refers to the object on which the method was invoked. If we don’t specify
an object when invoking a method, then the method is implicitly invoked on self.
You’ll learn how to define methods for classes of objects in Chapter 7. Notice, however,
that you’ve already seen examples of invoking methods on objects, in code like this:
first = text.index(pattern)
Like most object-oriented languages, Ruby uses . to separate the object from the meth-
od to be invoked on it. This code passes the value of the variable pattern to the method
named index of the object stored in the variable text, and stores the return value in the
variable first.
6.1.4 Defining Singleton Methods
The methods we’ve defined so far are all global methods. If we place a def statement
like the ones shown earlier inside a class statement, then the methods that are defined
are instance methods of the class; these methods are defined on all objects that are
instances of the class. (Classes and instance methods are explained in Chapter 7.)
It is also possible, however, to use the def statement to define a method on a single
specified object. Simply follow the def keyword with an expression that evaluates to
an object. This expression should be followed by a period and the name of the method
to be defined. The resulting method is known as a singleton method because it is
available only on a single object:
o = "message"
def o.printme
puts self
end
o.printme
# A string is an object
# Define a singleton method for this object
# Invoke the singleton
Class methods (covered in Chapter 7) such as Math.sin and File.delete are actually
singleton methods. Math is a constant that refers to a Module object, and File is a constant
that refers to a Class object. These two objects have singleton methods named sin and
delete, respectively.
Ruby implementations typically treat Fixnum and Symbol values as immediate values
rather than as true object references. (See §3.8.1.1.) For this reason, singleton methods
may not be defined on Fixnum and Symbol objects. For consistency, singletons are also
prohibited on other Numeric objects.
6.1.5 Undefining Methods
Methods are defined with the def statement and may be undefined with the undef
statement:
def sum(x,y); x+y; end
puts sum(1,2)
undef sum
# Define a method
# Use it
# And undefine it
In this code, the def statement defines a global method, and undef undefines it. undef
also works within classes (which are the subject of Chapter 7) to undefine the instance
methods of the class. Interestingly, undef can be used to undefine inherited methods,
without affecting the definition of the method in the class from which it is inherited.
Suppose class A defines a method m, and class B is a subclass of A and therefore inherits
m. (Subclasses and inheritance are also explained in Chapter 7.) If you don’t want to
allow instances of class B to be able to invoke m, you can use undef m within the body
of the subclass.
undef is not a commonly used statement. In practice, it is much more common to
redefine a method with a new def statement than it is to undefine or delete the method.
Note that the undef statement must be followed by a single identifier that specifies the
method name. It cannot be used to undefine a singleton method in the way that def
can be used to define such a method.
Within a class or module, you can also use undef_method (a private method of Module)
to undefine methods. Pass a symbol representing the name of the method to be
undefined.
6.2 Method Names
By convention, method names begin with a lowercase letter. (Method names can begin
with a capital letter, but that makes them look like constants.) When a method name
is longer than one word, the usual convention is to separate the words with underscores
like_this rather than using mixed case likeThis.
Method Name Resolution
This section describes the names you give to methods when you define them. A related
topic is method name resolution: how does the Ruby interpreter find the definition of
the method named in a method invocation expression? The answer to that question
must wait until we’ve discussed classes in Ruby. It is covered in §7.8.
Method names may (but are not required to) end with an equals sign, a question mark,
or an exclamation point. An equals sign suffix signifies that the method is a setter that
can be invoked using assignment syntax. Setter methods are described in §4.5.3 and
additional examples are provided in §7.1.5. The question mark and exclamation point
suffixes have no special meaning to the Ruby interpreter, but they are allowed because
they enable two extraordinarily useful naming conventions.
The first convention is that any method whose name ends with a question mark returns
a value that answers the question posed by the method invocation. The empty? method
of an array, for example, returns true if the array has no elements. Methods like these
are called predicates and. Predicates typically return one of the Boolean values true or
false, but this is not required, as any value other than false or nil works like true
when a Boolean value is required. (The Numeric method nonzero?, for example, returns
nil if the number it is invoked on is zero, and just returns the number otherwise.)
The second convention is that any method whose name ends with an exclamation mark
should be used with caution. The Array object, for example, has a sort method that
makes a copy of the array, and then sorts that copy. It also has a sort! method that
Method names may (but are not required to) end with an equals sign, a question mark,
sorts the array in place. The exclamation mark indicates that you need to be more
careful when using that version of the method.
Often, methods that end with an exclamation mark are mutators, which alter the in-
ternal state of an object. But this is not always the case; there are many mutators that
do not end with an exclamation mark, and a number of nonmutators that do. Mutating
methods (such as Array.fill) that do not have a nonmutating variant do not typically
have an exclamation point.
Consider the global function exit: it makes the Ruby program stop running in a con-
trolled way. There is also a variant named exit! that aborts the program immediately
without running any END blocks or shutdown hooks registered with at_exit. exit! isn’t
a mutator; it’s the “dangerous” variant of the exit method and is flagged with ! to
remind a programmer using it to be careful.
or an exclamation point. An equals sign suffix signifies that the method is a setter that
can be invoked using assignment syntax. Setter methods are described in §4.5.3 and
additional examples are provided in §7.1.5. The question mark and exclamation point
suffixes have no special meaning to the Ruby interpreter, but they are allowed because
they enable two extraordinarily useful naming conventions.
The first convention is that any method whose name ends with a question mark returns
a value that answers the question posed by the method invocation. The empty? method
of an array, for example, returns true if the array has no elements. Methods like these
are called predicates and. Predicates typically return one of the Boolean values true or
false, but this is not required, as any value other than false or nil works like true
when a Boolean value is required. (The Numeric method nonzero?, for example, returns
nil if the number it is invoked on is zero, and just returns the number otherwise.)
The second convention is that any method whose name ends with an exclamation mark
should be used with caution. The Array object, for example, has a sort method that
makes a copy of the array, and then sorts that copy. It also has a sort! method that
Operator Methods
Many of Ruby’s operators, such as +, *, and even the array index operator [], are im-
plemented with methods that you can define in your own classes. You define an
operator by defining a method with the same “name” as the operator. (The only ex-
ceptions are the unary plus and minus operators, which use method names +@ and
-@.) Ruby allows you to do this even though the method name is all punctuation. You
might end up with a method definition like this:
def +(other)
self.concatenate(other)
end
# Define binary plus operator: x+y is x.+(y)
Table 4-2 in Chapter 4 specifies which of Ruby’s operators are defined as methods.
These operators are the only punctuation-based method names that you can use: you
can’t invent new operators or define methods whose names consist of other sequences
of punctuation characters. There are additional examples of defining method-based
operators in §7.1.6.
Methods that define a unary operator are passed no arguments. Methods that define
binary operators are passed one argument and should operate on self and the argu-
ment. The array access operators [] and []= are special because they can be invoked
with any number of arguments. For []=, the last argument is always the value being
assigned.
Method Aliases
It is not uncommon for methods in Ruby to have more than one name. The language
has a keyword alias that serves to define a new name for an existing method. Use it
like this:
alias aka also_known_as
# alias new_name existing_name
After executing this statement, the identifier aka will refer to the same method thats
also_known_as does.
Method aliasing is one of the things that makes Ruby an expressive and natural lan-
guage. When there are multiple names for a method, you can choose the one that seems
most natural in your code. The Range class, for example, defines a method for testing
whether a value falls within the range. You can call this method with the name
include? or with the name member?. If you are treating a range as a kind of set, the name
member? may be the most natural choice.
A more practical reason for aliasing methods is to insert new functionality into a
method. The following is a common idiom for augmenting existing methods:
def hello # A nice simple method
puts "Hello World" # Suppose we want to augment it...
end 
alias original_hello hello # Give the method a backup name
def hello #
puts "Your attention please" #
original_hello #
puts "This has been a test" #
end 
Now we define a new method with the old name
That does some stuff
Then calls the original method
Then does some more stuff
In this code, we’re working on global methods. It is more common to use alias with
the instance methods of a class. (We’ll learn about this in Chapter 7.) In this situation,
alias must be used within the class whose method is to be renamed. Classes in Ruby
can be “reopened” (again, this is discussed in Chapter 7)—which means that your code
can take an existing class, ‘open’ it with a class statement, and then use alias as shown
in the example to augment or alter the existing methods of that class. This is called
“alias chaining” and is covered in detail in §8.11.
Aliasing Is Not Overloading
A Ruby method may have two names, but two methods cannot share a single name. In
statically typed languages, methods can be distinguished by the number and type of
their arguments, and two or more methods may share the same name as long as they
expect different numbers or types of arguments. This kind of overloading is not possible
in Ruby.
On the other hand, method overloading is not really necessary in Ruby. Methods can
accept arguments of any class and can be written to do different things based on the
type of the arguments they are passed. Also (as we’ll see later), Ruby’s method argu-
ments can be declared with default values, and these arguments may be omitted form
method invocations. This allows a single method to be invoked with differing numbers
of arguments.
Optional Parentheses
Parentheses are omitted from method invocations in many common Ruby idioms. The
following two lines of code, for example, are equivalent:
puts "Hello World"
puts("Hello World")
In the first line, puts looks like a keyword, statement, or command built in to the
language. The equivalent second line demonstrates that it is simply the invocation of
a global method, with the parentheses omitted. Although the second form is clearer,
the first form is more concise, more commonly used, and arguably more natural.
Next, consider this code:
greeting = "Hello"
size = greeting.length
If you are accustomed to other object-oriented languages, you may think that length
is a property, field, or variable of string objects. Ruby is strongly object oriented, how-
ever, and its objects are fully encapsulated; the only way to interact with them is by
invoking their methods. In this code, greeting.length is a method invocation. The
length method expects no arguments and is invoked without parentheses. The
following code is equivalent:
size = greeting.length()
Including the optional parentheses emphasizes that a method invocation is occurring.
Omitting the parentheses in method invocations with no arguments gives the illusion
of property access, and is a very common practice.
Parentheses are very commonly omitted when there are zero or one arguments to the
invoked method. Although it is less common, the parentheses may be omitted even
when there are multiple arguments, as in the following code:
x = 3
x.between? 1,5
# x is a number
# same as x.between?(1,5)
Parentheses may also be omitted around the parameter list in method definitions,
though it is hard to argue that this makes your code clearer or more readable. The
following code, for example, defines a method that returns the sum of its arguments:
def sum x, y
x+y
end
 Required Parentheses
Some code is ambiguous if the parentheses are omitted, and here Ruby requires that
you include them. The most common case is nested method invocations of the form
f g x, y. In Ruby, invocations of that form mean f(g(x,y)). Ruby 1.8 issues a warning,
however, because the code could also be interpreted as f(g(x),y). The warning has
been removed in Ruby 1.9. The following code, using the sum method defined above,
prints 4, but issues a warning in Ruby 1.8:
puts sum 2, 2
To remove the warning, rewrite the code with parentheses around the arguments:
puts sum(2,2)
Note that using parentheses around the outer method invocation does not resolve the
ambiguity:
puts(sum 2,2)
# Does this mean puts(sum(2,2)) or puts(sum(2), 2)?
An expression involving nested function calls is only ambiguous when there is more
than one argument. The Ruby interpreter can only interpret the following code in one
way:
puts factorial x
# This can only mean puts(factorial(x))
Despite the lack of ambiguity here, Ruby 1.8 still issues a warning if you omit the
parentheses around the x.
Sometimes omitting parentheses is a true syntax error rather than a simple warning.
The following expressions, for example, are completely ambiguous without parenthe-
ses, and Ruby doesn’t even attempt to guess what you mean:
puts 4, sum 2,2
[sum 2,2]
# Error: does the second comma go with the 1st or 2nd method?
# Error: two array elements or one?
There is another wrinkle that arises from the fact that parentheses are optional. When
you do use parentheses in a method invocation, the opening parenthesis must imme-
diately follow the method name, with no intervening space. This is because parentheses
do double-duty: they can be used around an argument list in a method invocation, and
they can be used for grouping expressions. Consider the following two expressions,
which differ only by a single space:
square(2+2)*2
square (2+2)*2
# square(4)*2 = 16*2 = 32
# square(4*2) = square(8) = 64
In the first expression, the parentheses represent method invocation. In the second,
they represent expression grouping. To reduce the potential for confusion, you should
always use parentheses around a method invocation if any of the arguments use
parentheses. The second expression would be written more clearly as:
square((2+2)*2)
We’ll end this discussion of parentheses with one final twist. Recall that the following
expression is ambiguous and causes a warning:
puts(sum 2,2)
# Does this mean puts(sum(2,2)) or puts(sum(2), 2)?
The best way to resolve this ambiguity is to put parentheses around the arguments to
the sum method. Another way is to add a space between puts and the opening
parenthesis:
puts (sum 2,2)
Adding the space converts the method invocation parentheses into expression grouping
parentheses. Because these parentheses group a subexpression, the comma can no
longer be interpreted as an argument delimiter for the puts invocation.
 Method Arguments
Simple method declarations include a comma-separated list of argument names (in
optional parentheses) after the method name. But there is much more to Ruby’s method
arguments. The subsections that follow explain:
• How to declare an argument that has a default value, so that the argument can be
omitted when the method is invoked
• How to declare a method that accepts any number of arguments
• How to simulate named method arguments with special syntax for passing a hash
to a method
• How to declare a method so that the block associated with an invocation of the
method is treated as a method argument
6.4.1 Parameter Defaults
When you define a method, you can specify default values for some or all of the
parameters. If you do this, then your method may be invoked with fewer argument
values than the declared number of parameters. If arguments are omitted, then the
default value of the parameter is used in its place. Specify a default value by following
the parameter name with an equals sign and a value:
def prefix(s, len=1)
s[0,len]
end
This method declares two parameters, but the second one has a default. This means
that we can invoke it with either one argument or two:
prefix("Ruby", 3)
prefix("Ruby")
# => "Rub"
# => "R"
Argument defaults need not be constants: they may be arbitrary expressions, and can
be referred to instance variables and to previous parameters in the parameter list. For
example:
# Return the last character of s or the substring from index to the end
def suffix(s, index=s.size-1)
s[index, s.size-index]
end
Parameter defaults are evaluated when a method is invoked rather than when it is
parsed. In the following method, the default value [] produces a new empty array on
each invocation, rather than reusing a single array created when the method is defined:
# Append the value x to the array a, return a.
# If no array is specified, start with an empty one.
def append(x, a=[])
a << x
end
In Ruby 1.8, method parameters with default values must appear after all ordinary
parameters in the parameter list. Ruby 1.9 relaxes this restriction and allows ordinary
parameters to appear after parameters with defaults. It still requires all parameters with
defaults to be adjacent in the parameter list—you can’t declare two parameters with
default values with an ordinary parameter between them, for example. When a method
has more than one parameter with a default value, and you invoke the method with an
argument for some, but not all, of these parameters, they are filled in from left to right.
Suppose a method has two parameters, and both of those parameters have defaults.
You can invoke this method with zero, one, or two arguments. If you specify one ar-
gument, it is assigned to the first parameter and the second parameter uses its default
value. There is no way, however, to specify a value for the second parameter and use
the default value of the first parameter.
Variable-Length Argument Lists and Arrays
Sometimes we want to write methods that can accept an arbitrary number of argu-
ments. To do this, we put an * before one of the method’s parameters. Within the body
of the method, this parameter will refer to an array that contains the zero or more
arguments passed at that position. For example:
# Return the largest of the one or more arguments passed
def max(first, *rest)
# Assume that the required first argument is the largest
max = first
# Now loop through each of the optional arguments looking for bigger ones
rest.each {|x| max = x if x > max }
# Return the largest one we found
max
end
The max method requires at least one argument, but it may accept any number of ad-
ditional arguments. The first argument is available through the first parameter. Any
additional arguments are stored in the rest array. We can invoke max like this:
max(1)
max(1,2)
max(1,2,3)
# first=1, rest=[]
# first=1, rest=[2]
# first=1, rest=[2,3]
Note that in Ruby, all Enumerable objects automatically have a max method, so the
method defined here is not particularly useful.
No more than one parameter may be prefixed with an *. In Ruby 1.8, this parameter
must appear after all ordinary parameters and after all parameters with defaults speci-
fied. It should be the last parameter of the method, unless the method also has a
parameter with an & prefix (see below). In Ruby 1.9, a parameter with an * prefix must
still appear after any parameters with defaults specified, but it may be followed by
additional ordinary parameters. It must also still appear before any &-prefixed
parameter.
 Passing arrays to methods
We’ve seen how * can be used in a method declaration to cause multiple arguments to
be gathered or coalesced into a single array. It can also be used in a method invocation
to scatter, expand, or explode the elements of an array (or range or enumerator) so that
each element becomes a separate method argument. The * is sometimes called the splat
operator, although it is not a true operator. We’ve seen it used before in the discussion
of parallel assignment in §4.5.5.
Suppose we wanted to find the maximum value in an array (and that we didn’t know
that Ruby arrays have a built-in max method!). We could pass the elements of the array
to the max method (defined earlier) like this:
data = [3, 2, 1]
m = max(*data)
# first = 3, rest=[2,1] => 3
Consider what happens without the *:
m = max(data)
# first = [3,2,1], rest=[] => [3,2,1]
In this case, we’re passing an array as the first and only argument, and our max method
returns that first argument without performing any comparisons on it.
The * can also be used with methods that return arrays to expand those arrays for use
in another method invocation. Consider the polar and cartesian methods defined
earlier in this chapter:
# Convert the point (x,y) to Polar coordinates, then back to Cartesian
x,y = cartesian(*polar(x, y))
In Ruby 1.9, enumerators are splattable objects. To find the largest letter in a string,
for example, we could write:
max(*"hello world".each_char)
# => 'w'
 Mapping Arguments to Parameters
When a method definition includes parameters with default values or a parameter pre-
fixed with an *, the assignment of argument values to parameters during method
invocation gets a little bit tricky.
In Ruby 1.8, the position of the special parameters is restricted so that argument values
are assigned to parameters from left to right. The first arguments are assigned to the
ordinary parameters. If there are any remaining arguments, they are assigned to the
parameters that have defaults. And if there are still more arguments, they are assigned
to the array argument.
Ruby 1.9 has to be more clever about the way it maps arguments to parameters because
the order of the parameters is no longer constrained. Suppose we have a method that
is declared with o ordinary parameters, d parameters with default values, and one array
parameter prefixed with *. Now assume that we invoke this method with a arguments.
If a is less than o, an ArgumentError is raised; we have not supplied the minimum
required number of arguments.
If a is greater than or equal to o and less than or equal to o+d, then the leftmost a–o
parameters with defaults will have arguments assigned to them. The remaining (to the
right) o+d–a parameters with defaults will not have arguments assigned to them, and
will just use their default values.
If a is greater than o+d, then the array parameter whose name is prefixed with an * will
have a–o–d arguments stored in it; otherwise, it will be empty.
Once these calculations are performed, the arguments are mapped to parameters from
left to right, assigning the appropriate number of arguments to each parameter.
6.4.4 Hashes for Named Arguments
When a method requires more than two or three arguments, it can be difficult for the
programmer invoking the method to remember the proper order for those arguments.
Some languages allow you to write method invocations that explicitly specify a pa-
rameter name for each argument that is passed. Ruby does not support this method
invocation syntax, but it can be approximated if you write a method that expects a hash
as its argument or as one of its arguments:
# This method returns an array a of n numbers. For any index i, 0 <= i < n,
# the value of element a[i] is m*i+c. Arguments n, m, and c are passed
# as keys in a hash, so that it is not necessary to remember their order.
def sequence(args)
# Extract the arguments from the hash.
# Note the use of the || operator to specify defaults used
# if the hash does not define a key that we are interested in.
n = args[:n] || 0
m = args[:m] || 1
c = args[:c] || 0
a = []
n.times {|i| a << m*i+c }
a
end
# Start with an empty array
# Calculate the value of each array element
# Return the array
You might invoke this method with a hash literal argument like this:
sequence({:n=>3, :m=>5})
# => [0, 5, 10]
In order to better support this style of programming, Ruby allows you to omit the curly
braces around the hash literal if it is the last argument to the method (or if the only
argument that follows it is a block argument, prefixed with &). A hash without braces
is sometimes called a bare hash, and when we use one it looks like we are passing
separate named arguments, which we can reorder however we like:
sequence(:m=>3, :n=>5)
# => [0, 3, 6, 9, 12]
As with other ruby methods, we can omit the parentheses, too:
# Ruby 1.9 hash syntax
sequence c:1, m:3, n:5
# => [1, 4, 7, 10, 13]
If you omit the parentheses, then you must omit the curly braces. If curly braces follow
the method name outside of parentheses, Ruby thinks you’re passing a block to the
method:
sequence {:m=>3, :n=>5}
# Syntax error!
 Block Arguments
Recall from §5.3 that a block is a chunk of Ruby code associated with a method invo-
cation, and that an iterator is a method that expects a block. Any method invocation
may be followed by a block, and any method that has a block associated with it may
invoke the code in that block with the yield statement. To refresh your memory, the
following code is a block-oriented variant on the sequence method developed earlier in
the chapter:
# Generate a sequence of n numbers m*i + c and pass them to the block
def sequence2(n, m, c)
i = 0
while(i < n)
# loop n times
yield i*m + c
# pass next element of the sequence to the block
i += 1
end
end
# Here is how you might use this version of the method
sequence2(5, 2, 2) {|x| puts x } # Print numbers 2, 4, 6, 8, 10
One of the features of blocks is their anonymity. They are not passed to the method in
a traditional sense, they have no name, and they are invoked with a keyword rather
than with a method. If you prefer more explicit control over a block (so that you can
pass it on to some other method, for example), add a final argument to your method,
and prefix the argument name with an ampersand.* If you do this, then that argument
will refer to the block—if any—that is passed to the method. The value of the argument
will be a Proc object, and instead of using yield, you invoke the call method of the Proc:
def sequence3(n, m, c, &b) # Explicit argument to get block as a Proc
i = 0
while(i < n)
b.call(i*m + c)
# Invoke the Proc with its call method
i += 1
end
end
# Note that the block is still passed outside of the parentheses
sequence3(5, 2, 2) {|x| puts x }
Notice that using the ampersand in this way changes only the method definition. The
method invocation remains the same. We end up with the block argument being
declared inside the parentheses of the method definition, but the block itself is still
specified outside the parentheses of the method invocation.
Passing Proc Objects Explicitly
If you create your own Proc object (we’ll see how to do this later in the chapter) and
want to pass it explicitly to a method, you can do this as you would pass any other
value—a Proc is an object like any other. In this case, you should not use an ampersand
in the method definition:
# This version expects an explicitly-created Proc object, not a block
def sequence4(n, m, c, b) # No ampersand used for argument b
i = 0
while(i < n)
b.call(i*m + c)
# Proc is called explicitly
i += 1
end
end
p = Proc.new {|x| puts x }
sequence4(5, 2, 2, p)
# Explicitly create a Proc object
# And pass it as an ordinary argument
Twice before in this chapter, we’ve said that a special kind of parameter must be the
last one in the parameter list. Block arguments prefixed with ampersands must really
be the last one. Because blocks are passed unusually in method invocations, named
block arguments are different and do not interfere with array or hash parameters in
which the brackets and braces have been omitted. The following two methods are legal,
for example:
def sequence5(args, &b) # Pass arguments as a hash and follow with a block
n, m, c = args[:n], args[:m], args[:c]
i = 0
while(i < n)
b.call(i*m + c)
i += 1
end
end
# Expects one or more arguments, followed by a block
def max(first, *rest, &block)
max = first
rest.each {|x| max = x if x > max }
block.call(max)
max
end
These methods work fine, but notice that you can avoid the complexity of these cases
by simply leaving your blocks anonymous and calling them with yield.
It is also worth noting that the yield statement still works in a method defined with an
& parameter. Even if the block has been converted to a Proc object and passed as an
argument, it can still be invoked as an anonymous block, as if the block argument was
not there.
Using & in method invocation
We saw earlier that you can use * in a method definition to specify that multiple argu-
ments should be packed into an array, and that you can use * in a method invocation
to specify that an array should be unpacked so that its elements become separate
arguments. & can also be used in definitions and invocations. We’ve just seen that & in
a method definition allows an ordinary block associated with a method invocation to
be used as a named Proc object inside the method. When & is used before a Proc object
in a method invocation, it treats the Proc as if it was an ordinary block following the
invocation.
Consider the following code which sums the contents of two arrays:
a, b = [1,2,3], [4,5]
sum = a.inject(0) {|total,x| total+x }
sum = b.inject(sum) {|total,x| total+x }
# Start with some data.
# => 6. Sum elements of a.
# => 15. Add the elements of b in.
We described the inject iterator earlier in §5.3.2. If you don’t remember, you can look
up its documentation with ri Enumerable.inject. The important thing to notice about
this example is that the two blocks are identical. Rather than having the Ruby inter-
preter parse the same block twice, we can create a Proc to represent the block, and use
the single Proc object twice:
a, b = [1,2,3], [4,5]
# Start with some data.
summation = Proc.new {|total,x| total+x } # A Proc object for summations.
sum = a.inject(0, &summation)
# => 6
sum = b.inject(sum, &summation)
# => 15


If you use & in a method invocation, it must appear before the last argument in the
invocation. Blocks can be associated with any method call, even when the method is
not expecting a block, and never uses yield. In the same way, any method invocation
may have an & argument as its last argument.
In a method invocation an & typically appears before a Proc object. But it is actually
allowed before any object with a to_proc method. The Method class (covered later in
this chapter) has such a method, so Method objects can be passed to iterators just as
Proc objects can.
In Ruby 1.9, the Symbol class defines a to_proc method, allowing symbols to be prefixed
with & and passed to iterators. When a symbol is passed like this, it is assumed to be
the name of a method. The Proc object returned by the to_proc method invokes the
named method of its first argument, passing any remaining arguments to that named
method. The canonical case is this: given an array of strings, create a new array of those
strings, converted to uppercase. Symbol.to_proc allows us to accomplish this elegantly
as follows:
words = ['and', 'but', 'car']
# An array of words
uppercase = words.map &:upcase
# Convert to uppercase with String.upcase
upper = words.map {|w| w.upcase } # This is the equivalent code with a block
 Procs and Lambdas
Blocks are syntactic structures in Ruby; they are not objects, and cannot be manipulated
as objects. It is possible, however, to create an object that represents a block. Depending
on how the object is created, it is called a proc or a lambda. Procs have block-like
behavior and lambdas have method-like behavior. Both, however, are instances of class
Proc.
Creating Procs
We’ve already seen one way to crfate a Proc object: by associating a block with a method
that is defined with an ampersand-prefixed block argument. There is nothing prevent-
ing such a method from returning the Proc object for use outside the method:
# This method creates a proc from a block
def makeproc(&p) # Convert associated block to a Proc and store in p
p
end
# Return the Proc object
With a makeproc method like this defined, we can create a Proc object for ourselves:
adder = makeproc {|x,y| x+y }
The variable adder now refers to a Proc object. Proc objects created in this way are procs,
not lambdas. All Proc objects have a call method that, when invoked, runs the code
contained by the block from which the proc was created. For example:
sum = adder.call(2,2)
# => 4
In addition to being invoked, Proc objects can be passed to methods, stored in data
structures and otherwise manipulated like any other Ruby object.
As well as creating procs by method invocation, there are three methods that create
Proc objects (both procs and lambdas) in Ruby. These methods are commonly used,
and it is not actually necessary to define a makeproc method like the one shown earlier.
In addition to these Proc-creation methods, Ruby 1.9 also supports a new literal syntax
for defining lambdas. The subsections that follow discuss the methods Proc.new,
lambda, and proc, and also explain the Ruby 1.9 lambda literal syntax.
Proc.new
We’ve already seen Proc.new used in some of the previous examples in this chapter.
This is the normal new method that most classes support, and it’s the most obvious way
to create a new instance of the Proc class. Proc.new expects no arguments, and returns
a Proc object that is a proc (not a lambda). When you invoke Proc.new with an associated
block, it returns a proc that represents the block. For example:
p = Proc.new {|x,y| x+y }
If Proc.new is invoked without a block from within a method that does have an asso-
ciated block, then it returns a proc representing the block associated with the containing
method. Using Proc.new in this way provides an alternative to using an ampersand-
prefixed block argument in a method definition. The following two methods are
equivalent, for example:
def invoke(&b)
b.call
end
def invoke
Proc.new.call
end
Kernel.lambda
Another technique for creating Proc objects is with the lambda method. lambda is a
method of the Kernel module, so it behaves like a global function. As its name suggests,
the Proc object returned by this method is a lambda rather than a proc. lambda expects
no arguments, but there must be a block associated with the invocation:
is_positive = lambda {|x| x > 0 }
Lambda History
Lambdas and the lambda method are so named in reference to lambda calculus, a branch
of mathematical logic that has been applied to functional programming languages. Lisp
also uses the term “lambda” to refer to functions that can be manipulated as objects
Kernel.proc
In Ruby 1.8, the global proc method is a synonym for lambda. Despite its name, it returns
a lambda, not a proc. Ruby 1.9 fixes this; in that version of the language, proc is a
synonym for Proc.new.
Because of this ambiguity, you should never use proc in Ruby 1.8 code. The behavior
of your code might change if the interpreter was upgraded to a newer version. If you
are using Ruby 1.9 code and are confident that it will never be run with a Ruby 1.8
interpreter, you can safely use proc as a more elegant shorthand for Proc.new.
Lambda Literals
Ruby 1.9 supports an entirely new syntax for defining lambdas as literals. We’ll begin
with a Ruby 1.8 lambda, created with the lambda method:
succ = lambda {|x| x+1}
In Ruby 1.9, we can convert this to a literal as follows:
• Replace the metAs with blocks in Ruby 1.9, the argument list of a lambda literal may include the dec-
laration of block-local variables that are guaranteed not to overwrite variables with the
same name in the enclosing scope. Simply follow the parameter list with a semicolon
and a list of local variables:
# This lambda takes 2 args and declares 3 local vars
f = ->(x,y; i,j,k) { ... }
hod name lambda with the punctuation ->.
• Move the list of arguments outside of and just before the curly braces.
• Change the argument list delimiters from || to ().
With these changes, we get a Ruby 1.9 lambda literal:
succ = ->(x){ x+1 }
succ now holds a Proc object, which we can use just like any other:
succ.call(2)
# => 3
The introduction of this syntax into Ruby was controversial, and it takes some getting
used to. Note that the arrow characters -> are different from those used in hash literals.
A lambda literal uses an arrow made with a hyphen, whereas a hash literal uses an arrow
made with an equals sign.
One benefit of this new lambda syntax over the traditional block-based lambda creation
methods is that the Ruby 1.9 syntax allows lambdas to be declared with argument
defaults, just as methods can be:
zoom = ->(x,y,factor=2) { [x*factor, y*factor] }
As with method declarations, the parentheses in lambda literals are optional, because
the parameter list and local variable lists are completely delimited by the ->, ;, and {.
We could rewrite the three lambdas above like this:
succ = ->x { x+1 }
f = -> x,y; i,j,k { ... }
zoom = ->x,y,factor=2 { [x*factor, y*factor] }
Lambda parameters and local variables are optional, of course, and a lambda literal can
omit this altogether. The minimal lambda, which takes no arguments and returns
nil, is the following:
->{}
One benefit of this new syntax is its succinctness. It can be helpful when you want to
pass a lambda as an argument to a method or to another lambda:
def compose(f,g)
# Compose 2 lambdas
->(x) { f.call(g.call(x)) }
end
succOfSquare = compose(->x{x+1}, ->x{x*x})
succOfSquare.call(4)
# => 17: Computes (4*4)+1

Lambda literals create Proc objects and are not the same thing as blocks. If you want
to pass a lambda literal to a method that expects a block, prefix the literal with &, just
as you would with any other Proc object. Here is how we might sort an array of numbers
into descending order using both a block and a lambda literal:
data.sort {|a,b| b-a }
# The block version
data.sort &->(a,b){ b-a } # The lambda literal version
In this case, as you can see, regular block syntax is simpler.
Invoking Procs and Lambdas
Procs and lambdas are objects, not methods, and they cannot be invoked in the same
way that methods are. If p refers to a Proc object, you cannot invoke p as a method. But
because p is an object, you can invoke a method of p. We’ve already mentioned that
the Proc class defines a method named call. Invoking this method executes the code
in the original block. The arguments you pass to the call method become arguments
to the block, and the return value of the block becomes the return value of the call
method:
f = Proc.new {|x,y| 1.0/(1.0/x + 1.0/y) }
z = f.call(x,y)
The Proc class also defines the array access operator to work the same way as call. This
means that you can invoke a proc or lambda using a syntax that is like method
invocation, where parentheses have been replaced with square brackets. The proc
invocation above, for example, could be replaced with this code:
z = f[x,y]
Ruby 1.9 offers an additional way to invoke a Proc object; as an alternative to square
brackets, you can use parentheses prefixed with a period:
z = f.(x,y)
.() looks like a method invocation missing the method name. This is not an operator
that can be defined, but rather is syntactic-sugar that invokes the call method. It can
be used with any object that defines a call method and is not limited to Proc objects.
The Arity of a Proc
The arity of a proc or lambda is the number of arguments it expects. (The word is
derived from the “ary” suffix of unary, binary, ternary, etc.) Proc objects have an
arity method that returns the number of arguments they expect. For example:
lambda{||}.arity
# => 0. No arguments expected
lambda{|x| x}.arity
# => 1. One argument expected
lambda{|x,y| x+y}.arity # => 2. Two arguments expected
The notion of arity gets confusing when a Proc accepts an arbitrary number of argu-
ments in an *-prefixed final argument. When a Proc allows optional arguments, the
arity method returns a negative number of the form -n-1. A return value of this form
indicates that the Proc requires n arguments, but it may optionally take additional ar-
guments as well. -n-1 is known as the one’s-complement of n, and you can invert it
with the ~ operator. So if arity returns a negative number m, then ~m (or -m-1) gives you
the number of required arguments:
lambda {|*args|}.arity
# => -1.
lambda {|first, *rest|}.arity # => -2.
~-1 = -(-1)-1 = 0 arguments required
~-2 = -(-2)-1 = 1 argument required
There is one final wrinkle to the arity method. In Ruby 1.8, a Proc declared without
any argument clause at all (that is, without any || characters) may be invoked with any
number of arguments (and these arguments are ignored). The arity method returns
–1 to indicate that there are no required arguments. This has changed in Ruby 1.9: a
Proc declared like this has an arity of 0. If it is a lambda, then it is an error to invoke it
with any arguments:
puts lambda {}.arity
# –1 in Ruby 1.8; 0 in Ruby 1.9
Proc Equality
The Proc class defines an == method to determine whether two Proc objects are equal.
It is important to understand, however, that merely having the same source code is not
enough to make two procs or lambdas equal to each other:
lambda {|x| x*x } == lambda {|x| x*x }
# => false
The == method only returns true if one Proc is a clone or duplicate of the other:
p = lambda {|x| x*x }
q = p.dup
p == q
p.object_id == q.object_id
# => true: the two procs are equal
# => false: they are not the same object
How Lambdas Differ from Procs
A proc is the object form of a block, and it behaves like a block. A lambda has slightly
modified behavior and behaves more like a method than a block. Calling a proc is like
yielding to a block, whereas calling a lambda is like invoking a method. In Ruby 1.9,
you can determine whether a Proc object is a proc or a lambda with the instance method
lambda?. This predicate returns true for lambdas and false for procs. The subsections
that follow explain the differences between procs and lambdas in detail.
6.5.5.1 Return in blocks, procs, and lambdas
Recall from Chapter 5 that the return statement returns from the lexically enclosing
method, even when the statement is contained within a block. The return statement
in a block does not just return from the block to the invoking iterator, it returns from
the method that invoked the iterator. For example:
def test
puts "entering method"
1.times { puts "entering block"; return } # Makes test method return
puts "exiting method" # This line is never executed
end
test
A proc is like a block, so if you call a proc that executes a return statement, it attempts
to return from the method that encloses the block that was converted to the proc. For
example:
def test
puts "entering method"
p = Proc.new { puts "entering proc"; return }
p.call
# Invoking the proc makes method return
puts "exiting method" # This line is never executed
end
test
Using a return statement in a proc is tricky, however, because procs are often passed
around between methods. By the time a proc is invoked, the lexically enclosing method
may already have returned:
def procBuilder(message)
# Create and return a proc
Proc.new { puts message; return } # return returns from procBuilder
# but procBuilder has already returned here!
end
def test
puts "entering method"
p = procBuilder("entering proc")
p.call
# Prints "entering proc" and raises LocalJumpError!
puts "exiting method" # This line is never executed
end
test
By converting a block into an object, we are able to pass that object around and use it
“out of context.” If we do this, we run the risk of returning from a method that has
already returned, as was the case here. When this happens, Ruby raises a
LocalJumpError.
The fix for this contrived example is to remove the unnecessary return statement, of
course. But a return statement is not always unnecessary, and another fix is to use a
lambda instead of a proc. As we said earlier, lambdas work more like methods than
blocks. A return statement in a lambda, therefore, returns from the lambda itself, not
from the method that surrounds the creation site of the lambda:
def test
puts "entering method"
p = lambda { puts "entering lambda"; return }
p.call
# Invoking the lambda does not make the method return
puts "exiting method" # This line *is* executed now
end
test
The fact that return in a lambda only returns from the lambda itself means that we
never have to worry about LocalJumpError:
def lambdaBuilder(message)
# Create and return a lambda
lambda { puts message; return } # return returns from the lambda
end
def test
puts "entering method"
l = lambdaBuilder("entering lambda")
l.call
# Prints "entering lambda"
puts "exiting method" # This line is executed
end
test
Break in blocks, procs and lambdas
Figure 5-3 illustrated the behavior of the break statement in a block; it causes the block
to return to its iterator and the iterator to return to the method that invoked it. Because
procs work like blocks, we expect break to do the same thing in a proc. We can’t easily
test this, however. When we create a proc with Proc.new, Proc.new is the iterator that
break would return from. And by the time we can invoke the proc object, the iterator
has already returned. So it never makes sense to have a top-level break statement in a
proc created with Proc.new:
def test
puts "entering test method"
proc = Proc.new { puts "entering proc"; break }
proc.call
# LocalJumpError: iterator has already returned
puts "exiting test method"
end
test
If we create a proc object with an & argument to the iterator method, then we can invoke
it and make the iterator return:
def iterator(&proc)
puts "entering iterator"
proc.call # invoke the proc
puts "exiting iterator"
# Never executed if the proc breaks
end
def test
iterator { puts "entering proc"; break }
end
test
Lambdas are method-like, so putting a break statement at the top-level of a lambda,
without an enclosing loop or iteration to break out of, doesn’t actually make any sense!
We might expect the following code to fail because there is nothing to break out of in
the lambda. In fact, the top-level break just acts like a return:
def test
puts "entering test method"
lambda = lambda { puts "entering lambda"; break; puts "exiting lambda" }
lambda.call
puts "exiting test method"
end
test
6.5.5.3 Other control-flow statements
A top-level next statement works the same in a block, proc, or lambda: it causes the
yield statement or call method that invoked the block, proc, or lambda to return. If
next is followed by an expression, then the value of that expression becomes the return
value of the block, proc, or lambda
redo also works the same in procs and lambdas: it transfers control back to the begin-
ning of the proc or lambda.
retry is never allowed in procs or lambdas: using it always results in a LocalJumpError.
raise behaves the same in blocks, procs, and lambdas. Exceptions always propagate
up the call stack. If a block, proc, or lambda raises an exception and there is no local
rescue clause, the exception first propagates to the method that invoked the block with
yield or that invoked the proc or lambda with call.
6.5.5.4 Argument passing to procs and lambdas
Invoking a block with yield is similar to, but not the same as, invoking a method. There
are differences in the way argument values in the invocation are assigned to the argu-
ment variables declared in the block or method. The yield statement uses yield
semantics, whereas method invocation uses invocation semantics. Yield semantics are
similar to parallel assignment and are described in §5.4.4. As you might expect,
invoking a proc uses yield semantics and invoking a lambda uses invocation semantics:
p = Proc.new {|x,y| print x,y }
p.call(1)
# x,y=1:
nil used for missing rvalue:
p.call(1,2)
# x,y=1,2:
2 lvalues, 2 rvalues:
p.call(1,2,3)
# x,y=1,2,3: extra rvalue discarded:
p.call([1,2])
# x,y=[1,2]: array automatically unpacked:
Prints
Prints
Prints
Prints
1nil
12
12
This code demonstrates that the call method of a proc handles the arguments it
receives flexibly: silently discarding extras, silently adding nil for omitted arguments,
and even unpacking arrays. (Or, not demonstrated here, packing multiple arguments
into a single array when the proc expects only a single argument.)
Lambdas are not flexible in this way; like methods, they must be invoked with precisely
the number of arguments they are declared with:
l = lambda {|x,y|
l.call(1,2)
#
l.call(1)
#
l.call(1,2,3)
#
l.call([1,2])
#
l.call(*[1,2]) #
print x,y }
This works
Wrong number of
Wrong number of
Wrong number of
Works: explicit
arguments
arguments
arguments
splat to unpack the array
Closures and Shared Variables
It is important to understand that a closure does not just retain the value of the variables
it refers to—it retains the actual variables and extends their lifetime. Another way to
say this is that the variables used in a lambda or proc are not statically bound when the
lambda or proc is created. Instead, the bindings are dynamic, and the values of the
variables are looked up when the lambda or proc is executed.
As an example, the following code defines a method that returns two lambdas. Because
the lambdas are defined in the same scope, they share access to the variables in that
scope. When one lambda alters the value of a shared variable, the new value is available
to the other lambda:
# Return a pair of lambdas that share access to a local variable.
def accessor_pair(initialValue=nil)
value = initialValue # A local variable shared by the returned lambdas.
getter = lambda { value }
# Return value of local variable.
setter = lambda {|x| value = x }
# Change value of local variable.
return getter,setter
# Return pair of lambdas to caller.
end
getX, setX = accessor_pair(0) # Create accessor lambdas for initial value 0.
puts getX[]
# Prints 0. Note square brackets instead of call.
setX[10]
# Change the value through one closure.
puts getX[]
# Prints 10. The change is visible through the other.
The fact that lambdas created in the same scope share access to variables can be a feature
or a source of bugs. Any time you have a method that returns more than one closure,
you should pay particular attention to the variables they use. Consider the following
code:
# Return an array of lambdas that multiply by the arguments
def multipliers(*args)
x = nil
args.map {|x| lambda {|y| x*y }}
end
double,triple = multipliers(2,3)
puts double.call(2)
# Prints 6 in Ruby 1.8
This multipliers method uses the map iterator and a block to return an array of lambdas
(created inside the block). In Ruby 1.8, block arguments are not always local to the
block (see §5.4.3), and so all of the lambdas that are created end up sharing access to
x, which is a local variable of the multipliers method. As noted above, closures dont
capture the current value of the variable: they capture the variable itself. Each of the
lambdas created here share the variable x. That variable has only one value, and all of
the returned lambdas use that same value. That is why the lambda we name double
ends up tripling its argument instead of doubling it.
In this particular code, the issue goes away in Ruby 1.9 because block arguments are
always block-local in that version of the language. Still, you can get yourself in trouble
any time you create lambdas within a loop and use a loop variables (such as an array
index) within the lambda.

 Closures and Bindings
The Proc class defines a method named binding. Calling this method on a proc or
lambda returns a Binding object that represents the bindings in effect for that closure.
More About Bindings
We’ve been discussing the bindings of a closure as if they were simply a mapping from
variable names to variable values. In fact, bindings involve more than just variables.
They hold all the information necessary to execute a method, such as the value of
self, and the block, if any, that would be invoked by a yield.
A Binding object doesn’t have interesting methods of its own, but it can be used as the
second argument to the global eval function (see §8.2), providing a context in which
to evaluate a string of Ruby code. In Ruby 1.9, Binding has its own eval method, which
you may prefer to use. (Use ri to learn more about Kernel.eval and Binding.eval.)
The use of a Binding object and the eval method gives us a back door through which
we can manipulate the behavior of a closure. Take another look at this code from earlier:

# Return a lambda that retains or "closes over" the argument n
def multiplier(n)
lambda {|data| data.collect{|x| x*n } }
end
doubler = multiplier(2)
# Get a lambda that knows how to double
puts doubler.call([1,2,3]) # Prints 2,4,6
Now suppose we want to alter the behavior of doubler:
eval("n=3", doubler.binding) # Or doubler.binding.eval("n=3") in Ruby 1.9
puts doubler.call([1,2,3])
# Now this prints 3,6,9!
As a shortcut, the eval method allows you to pass a Proc object directly instead of
passing the Binding object of the Proc. So we could replace the eval invocation above
with:
eval("n=3", doubler)
Bindings are not only a feature of closures. The Kernel.binding method returns a
Binding object that represents the bindings in effect at whatever point you happen to
call it.
WSGC
 Method Objects
Ruby’s methods and blocks are executable language constructs, but they are not ob-
jects. Procs and lambdas are object versions of blocks; they can be executed and also
manipulated as data. Ruby has powerful metaprogramming (or reflection) capabilities,
and methods can actually be represented as instances of the Method class. (Metaprog-
ramming is covered in Chapter 8, but Method objects are introduced here.) You should
note that invoking a method through a Method object is less efficient than invoking it
directly. Method objects are not typically used as often as lambdas and procs.
The Object class defines a method named method. Pass it a method name, as a string or
a symbol, and it returns a Method object representing the named method of the receiver
(or throws a NameError if there is no such method). For example:
m = 0.method(:succ)
# A Method representing the succ method of Fixnum 0
In Ruby 1.9, you can also use public_method to obtain a Method object. It works like
method does but ignores protected and private methods (see §7.2).
The Method class is not a subclass of Proc, but it behaves much like it. Method objects
are invoked with the call method (or the [] operator), just as Proc objects are. And
Method defines an arity method just like the arity method of Proc. To invoke the Method
m:
puts m.call
# Same as puts 0.succ. Or use puts m[].
Invoking a method through a Method object does not change the invocation semantics,
nor does it alter the meaning of control-flow statements such as return and break. The

call method of a Method object uses method-invocation semantics, not yield semantics.
Method objects, therefore, behave more like lambdas than like procs.
Method objects work very much like Proc objects and can usually be used in place of
them. When a true Proc is required, you can use Method.to_proc to convert a Method to
a Proc. This is why Method objects can be prefixed with an ampersand and passed to a
method in place of a block. For example:
def square(x); x*x; end
puts (1..10).map(&method(:square))
Defining Methods with Procs
In addition to obtaining a Method object that represents a method and converting it to
a Proc, we can also go in the other direction. The define_method method (of Module)
expects a Symbol as an argument, and creates a method with that name using the asso-
ciated block as the method body. Instead of using a block, you can also pass a Proc or
a Method object as the second argument.
One important difference between Method objects and Proc objects is that Method objects
are not closures. Ruby’s methods are intended to be completely self-contained, and
they never have access to local variables outside of their own scope. The only binding
retained by a Method object, therefore, is the value of self—the object on which the
method is to be invoked.
In Ruby 1.9, the Method class defines three methods that are not available in 1.8: name
returns the name of the method as a string; owner returns the class in which the method
was defined; and receiver returns the object to which the method is bound. For any
method object m, m.receiver.class must be equal to or a subclass of m.owner.
Unbound Method Objects
In addition to the Method class, Ruby also defines an UnboundMethod class. As its name
suggests, an UnboundMethod object represents a method, without a binding to the object
on which it is to be invoked. Because an UnboundMethod is unbound, it cannot be
invoked, and the UnboundMethod class does not define a call or [] method.
To obtain an UnboundMethod object, use the instance_method method of any class or
module:
unbound_plus = Fixnum.instance_method("+")
In Ruby 1.9, you can also use public_instance_method to obtain an UnboundMethod
object. It works like instance_method does, but it ignores protected and private methods
(see §7.2).
In order to invoke an unbound method, you must first bind it to an object using the
bind method:
plus_2 = unbound_plus.bind(2)
# Bind the method to the object 2
The bind method returns a Method object, which can be invoked with its call method:
sum = plus_2.call(2)
# => 4
Another way to obtain an UnboundMethod object is with the unbind method of the
Method class:
plus_3 = plus_2.unbind.bind(3)
In Ruby 1.9, UnboundMethod has name and owner methods that work just as they do for
the Method class.
Functional Programming
Ruby is not a functional programming language in the way that languages like Lisp and
Haskell are, but Ruby’s blocks, procs, and lambdas lend themselves nicely to a func-
tional programming style. Any time you use a block with an Enumerable iterator like
map or inject, you’re programming in a functional style. Here are examples using the
map and inject iterators:
# Compute the average and standard deviation of an array of numbers
mean = a.inject {|x,y| x+y } / a.size
sumOfSquares = a.map{|x| (x-mean)**2 }.inject{|x,y| x+y }
standardDeviation = Math.sqrt(sumOfSquares/(a.size-1))
If the functional programming style is attractive to you, it is easy to add features to
Ruby’s built-in classes to facilitate functional programming. The rest of this chapter
explores some possibilities for working with functions. The code in this section is dense
and is presented as a mind-expanding exploration, not as a prescription for good
programming style. In particular, redefining operators as heavily as the code in the next
section does is likely to result in programs that are difficult for others to read and
maintain!
This is advanced material and the code that follows assumes familiarity with Chap-
ter 7. You may, therefore, want to skip the rest of this chapter the first time through
the book.
Applying a Function to an Enumerable
map and inject are two of the most important iterators defined by Enumerable. Each
expects a block. If we are to write programs in a function-centric way, we might like
methods on our functions that allow us to apply those functions to a specified
Enumerable object:
# This module defines methods and operators for functional programming.
module Functional
# Apply this function to each element of the specified Enumerable,
# returning an array of results. This is the reverse of Enumerable.map.
