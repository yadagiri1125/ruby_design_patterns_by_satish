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


