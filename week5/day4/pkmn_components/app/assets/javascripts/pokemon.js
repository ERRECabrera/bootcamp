// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

PokemonApp.Pokemon = function(pokemonUri){
  this.id = PokemonApp.Pokemon.idFromUri(pokemonUri);
};

PokemonApp.Pokemon.prototype.render = function(){

  var self = this;

  $.ajax({
    url: "/api/pokemon/" + this.id,
    success: function (response) {
      self.info = response;
      $('.modal-body').html('<dl class="dl-horizontal"><dt>Height</dt><dd class="js-pkmn-height"></dd><dt>Weight</dt><dd class="js-pkmn-weight"></dd><dt>Hit points</dt><dd class="js-pkmn-hp"></dd><dt>Attack & Defense</dt><dd class="js-pkmn-atk-def"></dd><dt>Special atk & def</dt><dd class="js-pkmn-special"></dd><dt>Speed</dt><dd class="js-pkmn-speed"></dd><dt>Types</dt><dd class="js-pkmn-types"></dd><dt>Images</dt><dd class="js-pkmn-figure"></dd><dt>Description</dt><dd class="js-pkmn-description"></dd></dl><div class="center"><button type="button" id="js-pkmn-evolution">Evolution</button></div>');
      $('.js-pkmn-name').text(self.info.name);
      $('.js-pkmn-number').text('#'+self.info.pkdx_id);
      $('.js-pkmn-height').text(self.info.height);
      $('.js-pkmn-weight').text(self.info.weight);
      $('.js-pkmn-hp').text(self.info.hp);
      $('.js-pkmn-atk-def').text(self.info.attack+' / '+self.info.defense);
      $('.js-pkmn-special').text(self.info.sp_atk+' / '+self.info.sp_def);
      $('.js-pkmn-speed').text(self.info.speed);
      var types = self.info.types.map(function(type){
        return type.name
      });
      $('.js-pkmn-types').text(types.join('/'));
      $('.js-pokemon-modal').modal('show');
      $('.js-pkmn-figure').empty();
      self.info.sprites.forEach(function(image){
        request = $.get(image.resource_uri);
        request.done(function(img_url){ $('.js-pkmn-figure').append('<img src="http://pokeapi.co'+img_url.image+'">')});
      });
      //debugger;
      $('.js-pkmn-description').empty();
      var uri_description = self.info.descriptions[self.info.descriptions.length-1].resource_uri;
      var request = $.get(uri_description);
      request.done(function(description){ $('.js-pkmn-description').html('<p>'+description.description+'</p>')});
      //debugger;      
      $('#js-pkmn-evolution').on('click', function(event){
        $('.js-pkmn-name').text('Evolutions to..');
        $('.js-pkmn-number').empty();
        $('.modal-body').html('<figure class="center" data-uri=""><figcaption class="js-evolution-name"></figcaption><div class="js-evolution-figure"></div></figure>');
        self.info.evolutions.forEach(function(pokemon){
          $('.js-evolution-name').text(pokemon.to);
          var request = $.get(pokemon.resource_uri);
          request.done(function(pokemon_obj){
            var uri = pokemon_obj.pkdx_id;
            $('figure.center').attr('data-uri', pokemon_obj.resource_uri);
            pokemon_obj.sprites.forEach(function(image){
              request = $.get(image.resource_uri);
              request.done(function(img_url){ $('.js-evolution-figure').append('<img src="http://pokeapi.co'+img_url.image+'">')});
            });
          });
        });
        $('.modal-body').on('click', 'figure', function(event){
          var uri = $(event.currentTarget).attr('data-uri'); 
          var pokemon = new PokemonApp.Pokemon(uri);
          pokemon.render();      
        });
      });
    },
    fail: function(response) {
      console.log("El baile del perrito");
    }
  });
};

PokemonApp.Pokemon.idFromUri = function (pokemonUri) {
  var uriSegments = pokemonUri.split("/");
  var secondLast = uriSegments.length - 2;
  return uriSegments[secondLast];
};

$(document).on('ready', function(){
  $('.js-show-pokemon').on('click', function(event){
    var $button = $(event.currentTarget);
    var pokemonUri = $button.data('pokemon-uri');
    var pokemon = new PokemonApp.Pokemon(pokemonUri);
    pokemon.render();
  });
});