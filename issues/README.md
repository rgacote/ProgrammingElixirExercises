# Issues

My solution to the OrganizingAProject-4 exercise from Programming Elixir by Dave Thomas.

## Installation

Clone the GitHub repository.

```
https://github.com/rgacote/ProgrammingElixirExercises.git
```

## Tests
[Coveralls](https://github.com/parroty/excoveralls#usage)
shows adding `MIX_ENV=test` before executing.
The _Programming Elixir_ book does not do this, and I'm not yet seeing any difference.

```
mix test

# With coverage
mix coveralls
mix coveralls.detail
mix coveralls.html

# Post coverage to a pre-configured third party
mix coveralls.post

# JSON and XML output is available for CLI integration.
mix coveralls.json
mix.coveralls.xml
```
