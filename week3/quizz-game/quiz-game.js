var prompt = require('prompt');
var fs = require("fs");
//var jsonfile = require('jsonfile');
//var util = require('util');
prompt.start();

function filter_by_category(array,id_value,category){
	return array_filtered = array.filter(function(item){ return item[category] == id_value});
};

function index_to_keyvalue_in_arrayobjects(array_objs,key,value){
	var index = 0;
	var index_obj = null;
	array_objs.forEach(function(obj){
		if (obj[key] == value){ index_obj = index};
		index++;
	});
	return index_obj;
}

function generate_random(min, number_of_results) {
  return Math.floor(Math.random() * number_of_results) + min;
};

function range(start,end){
	var size = end - (start - 1); 
	return new Array(size).join().split(",").map(function(item){return start++})
};

var init_id_questions = 1;

function Question(question,posibilities,answer,bonus){
	this.real_id = init_id_questions++;
	this.question = question;
	this.posibilities = posibilities;
	this.answer = answer;
	this.bonus_point = bonus;
};

function User(name,points,questions_storage,ranking,version){
	this.user_name = name;
	this.points = points;
	this.questions = questions_storage;
	this.ranking = ranking;
	this.version_game = version;
};

function Quizz(){

	var player = null;
	var user_index = null;
	var version_quizz = 0;

	var Database_game = {};
	var database = [];
	var database_file = "./ddbb.json"
	
	var ranking = [];
	
	var list_questions = [];
	var DatabaseQuestions = {};
	var questions_file = "./questions.json";
	var new_questions = "./new_questions.txt";

	Database_game.add_user = function(user_name,user_points,questions_storage,user_ranking,version){
		database.push(new User(user_name,user_points,questions_storage,user_ranking,version));
		//console.log(database);
	};

	Database_game.save_to_file = function(rute_file,data){
		fs.writeFileSync(rute_file, JSON.stringify(data));
		//jsonfile.writeFileSync(rute_file, database)
	};

	Database_game.check_user_name = function(name,type_user){
		fs.readFile(database_file, {encoding: 'utf8'}, function (err, data) {
			database = (data != []) ? JSON.parse(data): [];
			var user = database.filter(function(user){return user.user_name == name});
				if (user.length == 0){
					if (type_user == "old_user") {
						console.log("I'm sorry, %s. You're not in my database.", name);
						relogin();
					} else if (type_user == "new_user"){
						Database_game.add_user(name,0,range(1,list_questions.length),null,list_questions.length);
						Database_game.load_game();
					};
				} else {
					if (type_user == "old_user"){
						console.log("Hi, %s. I'm happy to see you again.\r\nLet's play!", name);
						Database_game.load_game();
					} else if (type_user == "new_user"){
						console.log("What a pitty, %s!.\r\nWe have an user with your name.", name);
						relogin();
					};
				};
		});
	}

	Database_game.load_game = function(){
		user_index = index_to_keyvalue_in_arrayobjects(database,"user_name",player);
		check_version();
		Database_game.load_ranking();
		//console.log(database);
	};

	Database_game.load_ranking = function(){
		var index = 0;
		database.forEach(function(user){
			ranking[index] = {user_name: user.user_name, points: user.points};
			index++;
		});
		//console.log(ranking);
		re_sort_ranking();
	};

	function check_version(){
		if (version_quizz > database[user_index].version_game){
			console.log("We have new questions for this game.\r\nDo you want them?");
			prompt.get(['response'], function (err, result) {
				var answer = result.response.toLowerCase();
				if ((/^y/).test(answer)){
					var new_range_questions = range(version_quizz,list_questions.length);
					new_range_questions.forEach(function(num){database[user_index].questions.push(num)});
					console.log("Your game is update.\r\nHave fun with %s new questions.", (version_quizz-database[user_index].version_game));
					database[user_index].version_game = version_quizz;
				}else if ((/^n/).test(answer)){
					console.log("Ok, no problem.")
				};
				make_question(null);
			});			
		} else {
			make_question(null);
		};
	}

	DatabaseQuestions.add_questions_new = function(){
		var data = fs.readFileSync(new_questions,"utf8");
		if (data != undefined){
			var arr = data.split("\n");
			arr.pop();
			var questions = arr.map(function(string){return string.split("-")});
			questions.forEach(function(quizz){
				list_questions.push(new Question(quizz[0],quizz[1],quizz[2],parseInt(quizz[3])));	
			});
			list_questions.pop();
			Database_game.save_to_file(questions_file,list_questions);
		};
		//console.log(list_questions);
	};

	DatabaseQuestions.load_questions_file = function(){
		var data = fs.readFileSync(questions_file,"utf8");
		list_questions = JSON.parse(data);
		version_quizz = list_questions.length;
		init_id_questions = list_questions.length+1;
	}

	var relogin =	this.login = function(){
		DatabaseQuestions.load_questions_file();
		console.log("New user?")
		prompt.get(['response'], function (err, result) {
			var answer = result.response.toLowerCase();
			if ((/^y/).test(answer)){
				console.log("what's your name?");
				prompt.get(['response'], function (err, result) {
					player = result.response;
					if (player == "" || player == "exit") {};
					var user = Database_game.check_user_name(player,"new_user");
				});
			} else if ((/^n/).test(answer)){
				console.log("I'm going to read my DDBB\r\nwhat's your user_name?");
				prompt.get(['response'], function (err, result) {
					player = result.response;
					if (player == "" || player == "exit") {}
					var user = Database_game.check_user_name(player,"old_user");
				});
			} else if (answer == "add"){
				DatabaseQuestions.add_questions_new();
				relogin();
			} else {
			};
		});
	}

	function ask_by_category(id_question,category) {
		var array_filtered = filter_by_category(list_questions,id_question,"real_id");
		return array_filtered[0][category];
	};

	function check_answer(answer,id_question) {
		var array_filtered = filter_by_category(list_questions,id_question,"real_id");
		return array_filtered[0].answer.toLowerCase() == answer;
	};

	function re_sort_ranking(){
		if (ranking.length > 1) {ranking.sort(function(a,b){return b.points - a.points})};
		//console.log(database);
			database.forEach(function(user){
				var index = 0;
				ranking.forEach(function(position){
					if (user.user_name == position.user_name){user.ranking = index+1};
					index++;
				});
			});			
	};

	function alert_ranking(index){
		var old_ranking = database[index].ranking;
		re_sort_ranking();
		Database_game.load_ranking();
		var new_ranking = database[index].ranking;
		var new_index_ranking = index_to_keyvalue_in_arrayobjects(ranking,"user_name",player);
		if (old_ranking < new_ranking){
			console.log("Now you are in the %s# position, under %s", new_ranking, ranking[new_index_ranking-1].user_name);
		}else if (old_ranking > new_ranking){
			console.log("Now you are in the %s# position, over %s", new_ranking, ranking[new_index_ranking+1].user_name);
		};
	}

	function show_ranking(){
		re_sort_ranking();
		ranking.forEach(function(user){
			console.log("%s ------ %s Points", user.user_name, user.points);
		});
	}

	function make_question(id){
		if (database[user_index].questions.length > 0){
			if (id == null){
				var size = (database[user_index].questions.length > 1) ? database[user_index].questions.length-1: 1; 
				var index = generate_random(0,size);
				var real_id = database[user_index].questions[index];
				var quizz = ask_by_category(real_id,"question");
				var posibility = ask_by_category(real_id,"posibilities");
			} else {
				var real_id = id;
				var quizz = ask_by_category(real_id,"question");
				var posibility = ask_by_category(real_id,"posibilities");
			};
			console.log(quizz);
			console.log(posibility);
				prompt.get(['response'], function (err, result) {
						answer = result.response.toLowerCase();
						if (check_answer(answer,real_id)){
							database[user_index].points += filter_by_category(list_questions,real_id,"real_id")[0].bonus_point;
			    		console.log('Congratulations, your response is ok!\r\nYour total score is %s points\r\n%s questions remain.', database[user_index].points, database[user_index].questions.length);
			    		database[user_index].questions = database[user_index].questions.filter(function(question){ return question != real_id});
			    		if (ranking.length > 1) {
			    			alert_ranking(user_index);
			    			show_ranking();	
			    		};			    		
			    		make_question(null);
			  		} else if (answer == "exit" || answer == "save") {
			  			console.log("Bye %s!\r\nI hope you enjoyed the game.\r\nWould you save the game before??", database[user_index].user_name);
			  			prompt.get(['response'], function (err, result) {
								var answer = result.response.toLowerCase();
								if ((/^y/).test(answer)){
									Database_game.save_to_file(database_file,database);
									console.log("Saved game!\r\nYou can continue your game another day.");
								} else if ((/^n/).test(answer) || answer == "" || answer == "exit"){
								};
							});
			  		} else {
			  			//console.log(database[user_index].questions.length);
			  			database[user_index].points -= filter_by_category(list_questions,real_id,"real_id")[0].bonus_point;
			  			console.log('Your response is wrong!\r\nYour total score is %s points', database[user_index].points);
			  			if (ranking.length > 1) {
			  				alert_ranking(user_index);
			  				show_ranking();
			  			};			  			
			  			make_question(real_id);
			  		}
		  	});
		} else {
			console.log("This is the end.\r\nNo more questions founded, %s\r\nThe Quizz Game is Over!\r\nYour total score is %s points\r\n%s# ranking position", database[user_index].user_name, database[user_index].points, database[user_index].ranking);
			show_ranking();
			Database_game.save_to_file(database_file,database);
		};
	};

};

var quizz = new Quizz();
quizz.login();
/*database = fs.readFileSync("./ddbb.json", 'utf8');
console.log(JSON.parse(database));*/
/*database = jsonfile.readFileSync("./ddbb.json", 'utf8');
console.log(database);*/