## Version

---

- ruby 2.6.6
- rails 5.2.6
- elasticsearch 1.7.3

## Setup Local

---

Create db `rails db:create`
Migrate Table `rails db:migrate`
Seed Data rails `db:seed`
Run local server `rails s`
run Elasticsearch Locally

# “The Name Guesser”

> Service to guess country code possibility from people name parameter

## How it works

---

##### run curl http://localhost:3000/name_guesser\?name\=Müller

&nbsp;
response

```sh
{"guessed_country":["DE","SK"],"requested_name":"Müller","time_processed":"93 ms"}
```

# “The Calculator”

> Service to get arithmetic calculation from parameter

## How it works

---

##### run curl http://localhost:3000/calculator\?expression\=5\*5\*5-5

&nbsp;
response

```sh
{"expression":"5*5*5-5","result":120.0}
```

# “The Archive”

> resolve problem
> `case` :
> We have 100 data in archives table here, 50 old data and 50 new data
> but we don’t need older ones anymore (but
> still do not want to lose them).
> `Solution`:
> In rails ActiveRecord we can add default_scope to limit data base on date that we want
> for example here I want to display the data for the last month only based on timestamp column,

## How it works

---

##### run curl http://localhost:3000/archives

&nbsp;
Archive.all will use default scope, then the result will only showing count 50

```sh
{"count":50}
```

##### how to show all data?

we can simply call `Archive.unscoped`

# “The Source”

```ruby
class String
    def r
        self.split('').reverse.join
    end
end
# the class String is an object holds and manipulates an arbitrary sequence of bytes,
# we create method r to splitting words to be an array, then reverse the array
# and the reversed array will be joined again with the join method
# the result is reversing the word
# we can call the function through the string for ex: "dani".r
# the result will be "inad"

tf = lambda do |i|
    puts i
end

f = lambda {|i| "#{i.to_s.r} bar" }
# variable f containing lambda
# lambda is proc object that similar with method
# lambda will check the number of arguments
# we also can call the f lambda variable like:
# f.call 'params'
# the params will convert to String and call method r to reverse params
# then the result will merge with bar word

a = ARGV.map(&f)
# ARGV is a constant defined in the Object class
# It is an instance of the Array class and has access to all the array methods
# when we pass arguments to ruby program , ruby will capture all in the ARGV array

# the variable a containing arguments of array in ARGV then map it to call
# lambda in f variable and parsing arguments one by one in array
# to get result reversed word for example
# ARGV = ['dani', 'lyla']
# then we map it and call f lambda to be
# ["inad bar", "alyl bar"]

puts a.join(', ')
# this code will puts result from a variable
# then concatenate array with comma
# the result will convert the array to string splitted with comma
```
