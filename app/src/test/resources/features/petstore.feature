Feature: Gestión de mascotas en PetStore API

  Background:
    * url baseUrl
    * def datos = read('classpath:data/mascotas.csv')
    * def randomId = function(){ return Math.floor(Math.random() * 1000000) }

  @FlujoTest
  Scenario Outline: Flujo completo de mascota usando CSV

    * def petId = randomId()

    # Crear mascota
    Given path '/pet'
    And request
    """
    {
      "id": #(petId),
      "name": "<name>",
      "status": "<status>"
    }
    """
    When method post
    Then status 200
    And match response.id == petId
    And match response.status == "<status>"

    # Consultar por ID
    Given path '/pet', petId
    When method get
    Then status 200
    And match response.name == "<name>"

    # Actualizar mascota
    Given path '/pet'
    And request
    """
    {
      "id": #(petId),
      "name": "<newName>",
      "status": "<newStatus>"
    }
    """
    When method put
    Then status 200
    And match response.name == "<newName>"
    And match response.status == "<newStatus>"

    # Buscar por status
    Given path '/pet/findByStatus'
    And param status = "sold"
    When method get
    Then status 200

    * def mascotaFiltrada = response.filter(x => x.id + '' == petId + '')
    * assert mascotaFiltrada.length == 1
    * match mascotaFiltrada[0].status == "sold"
    * match mascotaFiltrada[0].name == "<newName>"


    Examples:
      | read('classpath:data/mascotas.csv') |
