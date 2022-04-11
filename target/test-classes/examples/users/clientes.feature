#1.- En el Dado o Given, definimos la ruta en la que está disponible el servicio.

#2.- En el Cuando o When, el tipo de método, GET.

#3.- En el Entonces o Then, esperamos que la respuesta HTTP de la operación sea 200.

#4.- En el Entonces o And, comprobamos que el cuerpo de la respue

Feature: Ejemplo

 Scenario: Conexion Exitosa y zip codigo 
   Given url 'https://jsonplaceholder.typicode.com/users'
   When method get
   Then status 200
   And match $.[0].address.zipcode == '92998-3874'

  Scenario: Mostrar user name
    Given url 'https://jsonplaceholder.typicode.com/users'
    When method get
    Then match $.[0].username == "Bret"

  Scenario: Validar correo existente
    Given url 'https://jsonplaceholder.typicode.com/users'
    When method get
    Then match $.[0].email == "Sincere@april.biz"


  Scenario: Validar username que no existe
    Given url 'https://jsonplaceholder.typicode.com/users'
    When method get
    Then match $.[1].username == "Tomas"


  Scenario: Validar correo no existente
    Given url 'https://jsonplaceholder.typicode.com/users'
    When method get
    Then match $.[0].email == "Sincere@april.com"


  Scenario: Alta de usuario
    Given url 'https://jsonplaceholder.typicode.com/users'
    And request
    """
        {
        "name": "Tomas",
        "username": "tomas1",
        "email": "tomas1@tomas.com",
        "address": {
          "street": "carmenca",
          "suite": "Apt. 156",
          "city": "Lima",
          "zipcode": "54321-6789"
        }
      }
    """
    When method post
    Then status 201
    And match $.name == "Tomas"

  Scenario Outline: Alta de 3 usuarios
    Given url 'https://jsonplaceholder.typicode.com/users'
    And request
    """
        {
        "name": '<name>',
        "username": '<username>',
        "email": "tomas1@tomas.com",
        "address": {
          "street": "carmenca",
          "suite": "Apt. 156",
          "city": "Lima",
          "zipcode": "54321-6789"
        }
      }
    """
    When method post
    Then status 201
    And match $.name == '<name>'
    And match $.username == '<username>'


    Examples:
      |name|username|
      |tomas|tomas0|
      |tomas1|tomas1|
      |tomas2|tomas2|



