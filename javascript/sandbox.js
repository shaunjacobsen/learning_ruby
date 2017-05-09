function computeGrade(scores) {
  mark = computeAverage(scores);
  if (mark >= 90) {
    return 'A';
  } else if (mark >= 70) {
    return 'B';
  } else if (mark >= 50) {
    return 'C';
  } else if (mark < 50) {
    return 'F';
  }
}

function computeAverage(scores) {
  var total = 0;
  for (var i = 0; i < scores.length; i++) {
    total += scores[i];
  }
  return (total / scores.length);
}


var num_list = '';

function generatePattern(n) {
  for (var i = 1; i <= n; i++) {
    var stars = Array((n - i) + 1).join('*');
    num_list += i;
    console.log(num_list + stars);
  }
}

function splitString(string, delimeter) {
  var log_me = '';
  for (var i = 0; i < string.length; i++) {
    if (string[i] !== delimeter) {
      log_me += string[i];
    } else if (string[i] === delimeter) {
      console.log(log_me);
      log_me = '';
    }
  }
}

function repeat(string, times) {
  function isValidNumber(input) {
    if ((typeof(input) !== 'number') || (isNaN(input)) || (input < 0)) {
      return false;
    } else {
      return true;
    }
  }

  var str = '';

  if (isValidNumber(times)) {
    for (var i = 1; i <= times; i++) {
      str += string;
    }
  } else {
    str = 'Undefined';
  }

  console.log(str);
  
}

function startsWith(string, searchString) {
  var ssLength = searchString.length;
  var isValid = '';

  for (var i = 0; i < ssLength; i++) {
    if (searchString[i] === string[i]) {
      isValid = true;
      continue;
    } else {
      isValid = false;
    }
  }
  console.log(isValid);
}

function toLowerCase(string) {
  var adjusted_string = '';

  function isUpperCase(letter) {
    var ascii_code = letter.charCodeAt(0);
    if ((ascii_code > 64) && (ascii_code < 91)) {
      return true;
    }
  }

  for (var i = 0; i < string.length; i++) {
    var new_letter = string[i];
    if (isUpperCase(string[i])) {
      var this_letter = string[i].charCodeAt(0);
      new_letter = String.fromCharCode(this_letter + 32);
    }
    adjusted_string += new_letter;
  }
  return adjusted_string;
}

function rot13(string) {
  var normal = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  var shifted = 'nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM';

  var new_string = '';

  function isEnglishLetter(character) {
    var ascii_code = character.charCodeAt(0);
    if ((ascii_code > 64) && (ascii_code < 91) || (ascii_code > 96) && (ascii_code < 123)) {
      return true;
    }
  }

  for (i = 0; i < string.length; i++) {
    if (isEnglishLetter(string[i])) {
      var idx = normal.indexOf(string[i]);
      var new_letter = shifted[idx];
      new_string += new_letter;
    } else {
      new_string += string[i];
    }
    
  }

  return new_string;
}

function lastInArray(arr) {
  var last_val = arr.length - 1;
  return arr[last_val];
}

function rollCall(arr) {
  for (var i = 0; i < arr.length; i++) {
    console.log(arr[i]);
  }
}

function reverseRollCall(arr) {
  var reversed_arr = [];
  for (var i = arr.length - 1; i >= 0; i--) {
    reversed_arr.push(arr[i]);
  }
  console.log(reversed_arr);
}

function search(term, arr) {
  var idx = -1;
  for (var i = 0; i < arr.length; i++) {
    if (term === arr[i]) {
      idx = i;
      break;
    }
  }
  return idx;
}

function returnString(arr) {
  var str = '';
  for (var i = 0; i < arr.length; i++) {
    str += arr[i].toString();
  }
  return str;
}


