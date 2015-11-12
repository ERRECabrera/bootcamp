function generate_random(min, number_of_results) {
  return Math.floor(Math.random() * number_of_results) + min;
}

function Viking(name,armour){
  this.name = name;
  this.age = generate_random(10,40);
  this.health = generate_random(10000, 100);
  this.strength = generate_random(150, 50);
  this.armour = armour;
  this.armory_bonus = armory[armour];
}

Viking.prototype.hit = function(){
  return generate_random(20, this.strength - 20) + this.armory_bonus[0];
}

Viking.prototype.receive_damage = function(damage){
  this.health = this.health + this.armory_bonus[1] - damage;
}

Viking.prototype.show_hit = function(damage){
  console.log("The viking %s has made %s damage(with a plus bonus of +%s). %s health left(with a defensive bonus of -%s).", this.name, damage, this.armory_bonus[0], this.health, this.armory_bonus[1]);
}

function Pit(viking1, viking2){
  this.maxDamage = 130;
  this.maxTurns = 10;
  this.viking1 = viking1;
  this.viking2 = viking2;
}

Pit.prototype.fight = function(){
  var turns = 0;
  while((this.viking1.health > this.maxDamage && this.viking2.health > this.maxDamage) || (turns == this.maxDamage)) {
    var damage_1 = this.viking1.hit();
    var damage_2 = this.viking2.hit();

    this.viking2.receive_damage(damage_1);
    this.viking1.receive_damage(damage_2);

    this.viking1.show_hit(damage_1);
    this.viking2.show_hit(damage_2);

    turns++;
  }

  if(this.viking1.health <= this.maxDamage) {
    console.log("The winner is %s", this.viking2.name);
  } else {
    console.log("The winner is %s", this.viking1.name);
  }
}

var armory = { axe: [10,0], spear: [5,5], bow: [3,7], shield: [0,10]};

var v1 = new Viking("Rafa","axe");
var v2 = new Viking("Isaura","bow");

var pit = new Pit(v1, v2);
pit.fight();

function Saxons(armour){
  this.health = generate_random(30, 10);
  this.strength = generate_random(5, 15); 
  this.armour = armour;
  this.armory_bonus = armory[armour];
}

Saxons.prototype.hit = function(){
  return generate_random(10, this.strength - 10) + this.armory_bonus[0];
}

Saxons.prototype.receive_damage = function(damage){
  this.health = this.health + this.armory_bonus[1] - damage;
}

Saxons.prototype.show_hit = function(damage){
  console.log("The 'unnamed' Saxon has made %s damage(with a plus bonus of +%s). %s health left(with a defensive bonus of -%s).", damage, this.armory_bonus[0], this.health, this.armory_bonus[1]);
}

function War(vikings_array, saxons_array){
  var numbersof_vikings = vikings_array.length;
  var numbersof_saxons = saxons_array.length;
  while(vikings_array.length > 0 && saxons_array.length > 0){
    vikings_array.forEach (function(viking){
      var saxon = saxons_array[generate_random(0, saxons_array.length-1)];
      var damage = viking.hit();

      saxon.receive_damage(damage);
      viking.show_hit(damage);

      if(saxon.health > 0){
        var saxon_damage = saxon.hit();
        viking.receive_damage(saxon_damage);
        saxon.show_hit(saxon_damage);
      }
    });

    saxons_array = saxons_array.filter(function(saxon){
      return saxon.health > 0;
    });

    saxons_array.forEach (function(saxon){
      var viking = vikings_array[generate_random(0,vikings_array.length-1)];
      var damage = saxon.hit();

      viking.receive_damage(damage);
      saxon.show_hit(damage);

      if(viking.health > 0){
        var viking_damage = viking.hit();
        saxon.receive_damage(viking_damage);
        viking.show_hit(viking_damage);
      }
    });

    vikings_array = vikings_array.filter(function(viking){
      return viking.health > 0;
    });
    console.log(" ");
  }

  if(vikings_array.length > 0) {
    console.log("The vikings have won!!\r\n%s saxons dead", numbersof_saxons);
    var percent_vikings_end = vikings_array.length/numbersof_vikings*100;
    console.log("%s% survivers", percent_vikings_end)
    vikings_array.forEach(function(viking){
      console.log("%s has finished the combat with %s health", viking.name, viking.health);
    });
    if(vikings_array.length == 1) {
      console.log("The weak vikings didn't deserve to live.");
    }
  } else {
    console.log("The saxons have won!! The history has been written today!!\r\n%s vikings dead", numbersof_vikings);
    var percent_saxons_end = saxons_array.length/numbersof_saxons*100;
    console.log("%s% survivers", percent_saxons_end)
  }
}
var vikings_array_prev = [];
var names_of_vikings = ["Astrid","Brynhild","Freydis","Gudrun","Gunnhild","Gunnvor","Hilde","Ingrid","Ragnhild","Ranveig","Sigrid","Sigrunn","Siv","Solveig","Svanhild","Torhild","Torunn","Turid","Vigdis","Yngvild"];
var armours = ["axe","spear","bow","shield"];

for (var i = 0; i < generate_random(1,7); i++){
  vikings_array_prev.push(new Viking(names_of_vikings[generate_random(0,names_of_vikings.length-1)],armours[generate_random(0,armours.length-1)]));
};
//console.log(vikings_array_prev);
var vikings_array = vikings_array_prev.filter(function(viking){ return (viking.age > 15 && viking.age < 45);});
var saxons_array = [];
for (var i = 0; i < generate_random(30,70); i++) {
  saxons_array.push(new Saxons(armours[generate_random(0,armours.length-1)]));
};
War(vikings_array,saxons_array);