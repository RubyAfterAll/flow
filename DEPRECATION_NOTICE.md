# ⚠️ Deprecation Warning

Since its inception, Flow Operations worked with direct state access. 
 
The introduction of State Accessors, a explicit way to map the relation of Operations and States, is the cornerstone for a collection of future features and enhancements.

Therefore we need to discontinue direct state access to ensure a consistency baseplate for the new features.

## State Readers

These should be used when getting data from the state:

```ruby
# Don't do this:
class BadOperation < ApplciationOperation
  def behavior
    ThirdParty.do_a_thing if state.foo == :foo
  end
end

# Do this instead:
class GoodOperation < ApplciationOperation
  state_reader :foo
  
  def behavior
    ThirdParty.do_a_thing if foo == :foo
  end
end
```

💁‍ **Note**: You should omit the `state.` prefix when reading data.

## State Writers

These should be used when setting data on the state:

```ruby
# Don't do this:
class BadOperation < ApplciationOperation
  def behavior
    state.token = SecureRandom.hex
  end
end

# Do this instead:
class GoodOperation < ApplciationOperation
  state_writer :token
  
  def behavior
    state.token = SecureRandom.hex
  end
end
```

🚨‍ **Note**: You **cannot** omit the `state.` prefix when setting data.

## State Accessors

These should be used when reading and writing to the same variable on the state:

```ruby
# Don't do this:
class BadOperation < ApplciationOperation
  def behavior
    state.foo = :bar if state.foo == :baz
  end
end

# Do this instead:
class GoodOperation < ApplciationOperation
  state_accessor :foo
  
  def behavior
    state.foo = :bar if foo == :baz
  end
end
```

You should also prefer using an accessor over separate reader/write for the same field:

```ruby
# Don't do this:
class BadOperation < ApplciationOperation
  state_reader :foo
  state_writer :foo
  
  def behavior
    state.foo = :bar if foo == :baz
  end
end

# Do this instead:
class GoodOperation < ApplciationOperation
  state_accessor :foo
  
  def behavior
    state.foo = :bar if foo == :baz
  end
end
```

You should also use `state_accessor` if you intend to manipulate an in-memory object:

```ruby
# Don't do this:
class BadOperation < ApplciationOperation
  attr_reader :foo
  attr_reader :bar
  
  def behavior
    foo << :new_thing
    bar.update!(foo: true)
  end
end

# Do this instead:
class GoodOperation < ApplciationOperation
  state_accessor :foo
  state_accessor :bar
  
  def behavior
    foo << :new_thing
    bar.update!(foo: true)
  end
end
```
