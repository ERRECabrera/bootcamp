var prompt = require('prompt');  
prompt.start();

function filter_by_id(array,id){
	return array_filtered = array.filter(function(item){ return item.real_id == id});
};

function generate_random(min, number_of_results) {
  return Math.floor(Math.random() * number_of_results) + min;
}; 

var init_id_questions = 1;

function Question(question,answer,bonus){
	this.real_id = init_id_questions++;
	this.question = question;
	this.answer = answer;
	this.bonus_point = bonus;
};

function Quizz(user){

	var database = {user: user, points: 0};
	var array_questions_original = [
		new Question("tu nombre?","Raúl",1),
		new Question("tu apellido?","Cabrera",1)
	];
	var array_questions = array_questions_original;

	function ask(id_question) {
		var array_filtered = filter_by_id(array_questions_original,id_question);
		return array_filtered[0].question;
	};

	function check_answer(answer,id_question) {
		if (array_questions.length > 1){
			var array_filtered = filter_by_id(array_questions_original,id_question);
			return array_filtered[0].answer == answer;
		} else {
			return array_questions[0].answer == answer;
		};
	};

	function make_question(question,id){
		if (array_questions.length > 0){
			if (question == null){
				if (array_questions.length > 1){
					var real_id = generate_random(1,array_questions.length);
					var quizz = ask(real_id);
				} else {
					var real_id = array_questions[0].real_id;
					var quizz = array_questions[0].question;
				};
			} else {
				var real_id = id;
				var quizz = question;
			};
			console.log(quizz);
				prompt.get(['response'], function (err, result) {
						answer = result.response;
						console.log(answer);
						if (check_answer(answer,real_id)){
							database.points += filter_by_id(array_questions,real_id)[0].bonus_point;
			    		console.log('Congratulations, your response is ok!\r\nYour total score is %s points', database.points);
			    		array_questions = array_questions.filter(function(question){ return question.real_id != real_id});
			    		make_question(null);
			  		} else if (answer == "exit") {
			  			console.log("Bye %s!", database.user);
			  		} else {
			  			database.points -= filter_by_id(array_questions,real_id)[0].bonus_point;
			  			console.log('Your response is wrong!\r\nYour total score is %s points', database.points);
			  			make_question(quizz,real_id);
			  		}
		  	});
		} else {
			console.log("No more questions founded, %s\r\nThe Quizz Game is Over!\r\nYour total score is %s points", database.user, database.points);
		};
	};

	make_question();

};

Quizz("Raúl");