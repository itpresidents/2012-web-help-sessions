# Help Session from December 10: Associations

This example exhibits 2 different types of associations. 1 to many and many to many.

## 1 to Many

The 1-to-Many association is exhibited between the Tag class (1) and the Post class (many). For a given Tag, such as a Tag with the `title` of 'food' there are many Posts that can be associated with that one Tag, thus the name 1-to-many.

We need to keep a record of this association in the database. Each Post needs to know what its Tag is. And a Tag needs to know what Posts have that Tag. We store this link in our Post class (or whichever class is the "many" of our association). If you are associating Post and Tag as in this example you would add the following line of code:

````ruby
class Post
  include DataMapper::Resource

  # MAYE SOME OTHER PROPERTY DECLARATIONS

  property :tag_id, Integer

  # MAYBE SOME OTHER PROPERTY DECLARATIONS
end
````