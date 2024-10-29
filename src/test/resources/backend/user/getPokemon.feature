@PokemonGet
Feature:Query Pokemon - Service/Users GET Method
  As a QA Automation Engineer,
  I want to be able to query Pokemons
  so i can ensure the proper behavior of the API

  Background: consume service and define preconditions and scripts
    * url url

  @name
  Scenario Outline: Find the names of the evolutions

    Given path "pokemon/<namePokemon>"
    When method get
    Then status 200
    Given url response.species.url
    When method get
    Then status 200
    Given url response.evolution_chain.url
    When method get
    Then status 200
    Then match response.chain.evolves_to[0].species.name == '<PokemonEvolution_2>'
    Then match response.chain.evolves_to[0].evolves_to[0].species.name == '<PokemonEvolution_3>'

    Examples:
      | namePokemon | PokemonEvolution_2 | PokemonEvolution_3 |
      | charmander  | charmeleon         | charizard          |

  @squirtle
  Scenario: Getting and ordering Squirtle's moves
    Given path "pokemon/squirtle"
    When method GET
    Then status 200
    And def movimientos = karate.map(response.moves, x => x.move.name)
    And def movimientosOrdenados = movimientos.sort()
    And print 'Movimientos de Squirtle ordenados alfabéticamente:', movimientosOrdenados