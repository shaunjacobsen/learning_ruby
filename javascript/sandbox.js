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

function push(arr, new_val) {
  new_idx = arr.length;
  arr[new_idx] = new_val;
  return new_idx;
}

function pop(arr) {
  var newLength = arr.length - 1;
  var value = array[newLength];
  array.length = newLength;
  return value;
}

function unshift(arr, newVal) {
  var shiftedArray = [];
  for (var i = 0; i < arr.length; i++) {
    shiftedArray[i + 1] = arr[i];
  }
  shiftedArray[0] = newVal;
  return shiftedArray;
}

function indexOf(arr, value) {
  for (var i = 0; i < arr.length; i++) {
    if (arr[i] === value) {
      return i;
    }
  }
  return -1;
}

function lastIndexOf(arr, value) {
  for (var i = arr.length - 1; i >= 0; i--) {
    if (arr[i] === value) {
      return i;
    }
  }
  return -1;
}

function slice(arr, start, end) {
  var returnArray = [];
  for (var i = start; i < end; i++) {
    push(returnArray, arr[i]);
  }
  return returnArray;
}

function splice(arr, start, num) {
  var returnArray = [];
  for (var i = start; i < arr.length; i++) {
    if (i < start + num) {
      push(returnArray, arr[i]);
    }
    arr[i] = arr[i + num]; 
  }
  arr.length = arr.length - num;
  return returnArray;
}

function concat(firstArray, secondArray) {
  var newArray = [];
  for (var i = 0; i < firstArray.length; i++) {
    push(newArray, firstArray[i]);
  }

  for (var i = 0; i < secondArray.length; i++) {
    push(newArray, secondArray[i]);
  }

  return newArray;
}

function join(arr, delim) {
  var returnString = '';
  for (var i = 0; i < arr.length; i++) {
    returnString += arr[i] + delim;
  }
  return returnString;
}

function firstNOf(arr, num) {
  var newArray = [];
  for (var i = 0; i < num; i++) {
    push(newArray, arr[i]);
  }
  return newArray;
}

function joinArray(arr, joiner) {
  var returnString = arr[0].toString();
  var joiner = joiner || '';
  for (var i = 1; i < arr.length; i++) {
    returnString += joiner + arr[i];
  }
  return returnString;
}

function missing(arr) {
  var returnArray = [];
  var low = arr[0];
  var high = arr[arr.length - 1];
  for (i = low; i < high; i++) {
    if (arr.indexOf(i) < 0) {
      returnArray.push(i);
    }
  }
  return returnArray;
}

function objectHasProperty(obj, key) {
  var keys = Object.keys(obj);
  return keys.indexOf(key) !== -1;
}

function incrementProperty(obj, key) {
  var keys = Object.keys(obj);
  if (keys.indexOf(key) === -1) {
    obj[key] = 1;
  } else {
    obj[key] += 1;
  }
}

function copyProperties(obj1, obj2) {
  var count = 0;
  for (var key in obj1) {
    obj2[key] = obj1[key]
    count++;
  }
  return count;
}

function wordCount(str) {
  splitUp = str.split(' ');
  newObj = {};
  for (var i = 0; i < splitUp.length; i++) {
    if (newObj[splitUp[i]]) {
      newObj[splitUp[i]]++;
    } else {
      newObj[splitUp[i]] = 1;
    }
  }
  return newObj;
}




