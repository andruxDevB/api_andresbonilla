function fn() {
  var config = {};

  config.baseUrl = 'https://petstore.swagger.io/v2';

  karate.configure('logPrettyRequest', true);
  karate.configure('logPrettyResponse', true);

  return config;
}
