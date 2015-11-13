var prompt = require('prompt');  

function filter_by_id(array,id){
	return array_filtered = array.filter(function(item){ return item.real_id == id});
};

function generate_random(min, number_of_results) {
  return Math.floor(Math.random() * number_of_results) + min;
}; 

var init_id_questions = 1;

function Question(question,answer){
	this.real_id = init_id_questions++;
	this.question = question;
	this.answer = answer;
};

function Quizz(){

	this.make_question = function(question){
		if (question == null){
			var quizz = array_questions[generate_random(0,array_questions.length-1)];
		} else {
			var quizz = question;
		};			
		prompt.start();
			console.log(quizz.question);
				var control = prompt.get(['response'], function (err, result) {
						answer = result.response;
						if (answer == quizz.answer){
			    		console.log('Congratulations, your response is ok!');
			    		array_questions = array_questions.filter(function(question){ return question.real_id != quizz.real_id});
			    		make_question();
			  		} else {
			  			console.log('Your response is wrong!');
			  			make_question();
			  		}
		  	});
		};
};

Quizz.prototype.ask = function(id_question) {
	var array_filtered = filter_by_id(array_questions,id_question);
	console.log(array_filtered[0].question);
};

Quizz.prototype.check_answer = function(answer,id_question) {
	var array_filtered = filter_by_id(array_questions,id_question);
	console.log(array_filtered[0].answer == answer);
};


var array_questions = [
	new Question("tu nombre?","Raúl"),
	new Question("tu apellido?","Cabrera")
];


/*console.log(array_questions[0]);*/

var quizz = new Quizz();
/*quizz.ask(2);
quizz.check_answer("Raúl",1);*/
quizz.make_question();