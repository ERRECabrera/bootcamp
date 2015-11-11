function caesarCipher (message){
	var messageArray = message.split("");

	var numberMessage = messageArray.map (function(char){
		if (!/\w/.test(char)){
			return char;
		} else {
			return char.charCodeAt(0);
		}
	});

	return {
		encrypted: function(pass){
		var numberPass = pass%26
		var letterMessage = numberMessage.map (function(num){
			if (!/\w/.test(num)){
				return num;
			} else {
				if (pass > 0){
					range = num+numberPass;
					if (range > 122){
						code = 97+((range%122)-1);
						return String.fromCharCode(code);
					} else {
						code = range;
						return String.fromCharCode(code);
					}
				} else if (pass < 0){
					range = num-numberPass;
					if (range < 97){
						code = 97+((range%122)-1);
						return String.fromCharCode(code);
					} else {
						code = range;
						return String.fromCharCode(code);
					}
				} else {
					range = num-3;
					if (range < 97){
						code = 97+((range%122)-1);
						return String.fromCharCode(code);
					} else {
						code = range;
						return String.fromCharCode(code);
					}
				}
			}
		});
		return letterMessage.join("");
	},
		desencrypted: function(pass){
		var numberPass = pass%26*-1;
		var letterMessage = numberMessage.map (function(num){
			if (!/\w/.test(num)){
				return num;
			} else if (pass) {
					range = num+numberPass;
					if (range > 122){
						code = 97+((range%122)-1);
						return String.fromCharCode(code);
					} else if (range < 97 && range > 90){
						code = 122+((range-97)+1);
						return String.fromCharCode(code);
					} else if (range < 65){
						code = 90+((range-65)+1);
						return String.fromCharCode(code);
					} else if (range > 64 && range < 91){
						code = range;
						return String.fromCharCode(code);
					} else {
						code = range;
						return String.fromCharCode(code);
					}
			} else {
				range = num-3;
				if (range < 97){
					code = 97+((range%122)-1);
					return String.fromCharCode(code);
				} else {
					code = range;
						return String.fromCharCode(code);
					}
				}
		});
		return letterMessage.join("");
	}
	};

}

var enc = caesarCipher("Et tu, brute?");
var des = caesarCipher("Kz za, hxazk?");

console.log(enc.encrypted(6));
console.log(des.desencrypted(6));