let currentInput = '';
let expression = '';

// Yoyi Liao
document.addEventListener("DOMContentLoaded", function() {
    document.getElementById('display').value = '';
});

// Yoyi Liao
function append(ele) {
    currentInput += ele;
    expression += ele;
    document.getElementById('display').value = expression;
}

// Yoyi Liao
function clearDisplay() {
    currentInput = '';
    expression = '';
    document.getElementById('display').value = '';
}

// Yoyi Liao
function appendOperation(operation) {
    if (currentInput === '' && operation !== '(' && operation !== ')') return;
    expression += ` ${operation} `;
    currentInput = '';  
    document.getElementById('display').value = expression;
}

/**
 * author: Yoyi Liao
 * update display so it shows the newest result
 * clear currentOperation and previousInput string
 */
function updateDisplay(result) {
    currentInput = result.toString();
    currentOperation = '';
    previousInput = '';
    document.getElementById('display').value = currentInput;
}

// Yoyi Liao
function calculate() {
    try {
        let result = evaluateExpression(expression);
        updateDisplay(result);
        expression = result.toString();
        currentInput = result;
    } catch (error) {
        alert("Invalid expression");
        clearDisplay();
    }
}


/**
 * Author: Yoyi Liao
 * Converts infix expression to postfix notation and calls evaluatePostFix()
 */
function evaluateExpression(expr) {
    let outputQueue = [];
    let operatorStack = [];
    let precedence = { '+': 1, '-': 1, '*': 2, '/': 2 };
    let tokens = expr.match(/\d+\.?\d*|[()+\-*/]/g);

    if (!tokens) throw new Error("Invalid expression");

    for (let token of tokens) {
        if (!isNaN(token)) {
            outputQueue.push(parseFloat(token));
        } else if (token === '(') {
            operatorStack.push(token);
        } else if (token === ')') {
            while (operatorStack.length && operatorStack[operatorStack.length - 1] !== '(') {
                outputQueue.push(operatorStack.pop());
            }
            operatorStack.pop();
        } else {
            while (operatorStack.length && precedence[operatorStack[operatorStack.length - 1]] >= precedence[token]) {
                outputQueue.push(operatorStack.pop());
            }
            operatorStack.push(token);
        }
    }

    while (operatorStack.length) {
        outputQueue.push(operatorStack.pop());
    }

    return evaluatePostfix(outputQueue);
}


/**
 * Author: Yoyi Liao
 * Evaluates postfix expression and returns the final result
 */
function evaluatePostfix(postfixTokens) {
    let stack = [];
    for (let token of postfixTokens) {
        if (!isNaN(token)) {
            stack.push(token);
        } else {
            let b = stack.pop();
            let a = stack.pop();
            switch (token) {
                case '+': stack.push(a + b); break;
                case '-': stack.push(a - b); break;
                case '*': stack.push(a * b); break;
                case '/': 
                    if (b === 0) throw new Error("Cannot divide by zero");
                    stack.push(a / b); 
                    break;
            }
        }
    }
    return stack.pop();
}

// Yoyi Liao
function option(opt, isList) {
    let result;

    if (isList === 'y') {
        let list = currentInput.split(",");

        switch(opt) {
            case 'log' :
                result = logBase(list[0], list[1]);
                break;
            case 'exponent' :
                result = exponent(list[0], list[1]);
                break;
            case 'generateEven' :
                result = generateEven(list[0], list[1]);
                break;
            case 'generateSquare' :
                result = generateSquare(list[0], list[1]);
                break;
            case 'percentage' :
                result = percentage(list[0], list[1]);
                break;
            case 'median' :
                result = median(list);
                break;
            case 'min' :
                result = min(list);
                break;
            case 'generateOdd' :
                result = generateOdd(list[0], list[1]);
                break;  
            case 'mode' :
                result = mode(list);
                break;
            case 'mean' :
                result = mean(list);
                break;        
            case 'max' :
                result = max(list);
                break; 
            default :
                break;
        }
    } else {
        let current = parseFloat(currentInput);

        switch(opt) {
            case 'sqrt' :
                result = sqrt(current);
                break;
            case 'cbrt' :
                result = cbrt(current);
                break;
            case 'sin' :
                result = sin(current);
                break;
            case 'cos' :
                result = cos(current);
                break;
            case 'tan' :
                result = tan(current);
                break;
            case 'deciToBi' :
                result = deciToBi(current);
                break;
            case 'deciToHex' :
                result = deciToHex(current);
                break;
            case 'deciToOct' :
                result = deciToOct(current);
                break;
            case 'abs' :
                result = abs(current);
                break;
            case 'factorial' :
                result = factorial(current);
                break;    
            case 'generatePrime' :
                result = generatePrime(current);
                break;
            case 'isPrime' :
                result = isPrime(current);
                break;
            case 'generateFibonacci' :
                result = generateFibonacci(current);
                break;   
            case 'FtoC' :
                result = FtoC(current);
                break;
            default :
                break;
        }
    }

    updateDisplay(result);
}

//Jia Hui
function abs(n) {
    return n < 0 ? -n : n;
}

/**
 * author: Ava Daniel
 * Returns cube root of a number n
 */
function cbrt(n) {
    return Math.cbrt(n); // Math.cbrt() works for both positive and negative numbers
}

/**
 * author: Ava Daniel
 * Returns cosine of degree in radians 
 */
function cos(n) {
    if (typeof n !== "number" || isNaN(n)) {
        return "Error: Input must be a number";
    }
    const radians = n * (Math.PI / 180); // Convert degrees to radians
    return Math.cos(radians);
}

/**
 * author: Ava Daniel
 * Returns decimal converted to binomial
 */
function deciToBi(n) {
    if (!Number.isInteger(n) || n < 0) {
        return "Error: Input must be a positive integer";
    }
    return n.toString(2);
}

/**
 * author: Ava Daniel
 * Returns decimal converted to hexadecimal
 */
function deciToHex(n) {
    if (!Number.isInteger(n) || n < 0) {
        return "Error: Input must be a positive integer";
    }
    return n.toString(16);
}

/**
 * author: Ava Daniel
 * Returns decimal converted to octadecimal
 */
function deciToOct(n) {
    if (!Number.isInteger(n) || n < 0) {
        return "Error: Input must be a positive integer";
    }
    return n.toString(8);
}
//Jia Hui
function exponent(a,b) {
    let result = 1

    for (let i = 0; i<b; i++) {
        result*=a;
    }
    return result;
}

//Jia Hui
function factorial(n) {
   let result = 1;
    if ( n==0 || n == 1){
        return result;
    } else{
        for (let i = 2; i<=n; i++){
            result*=i;
        }
        return result;
    }
}

/**
 * author: Ryan Carmody
 * Convers Fahrenheit to Celsius.
 */
function FtoC(n) {
    return (n - 32) * 5 / 9;
}

//Jia Hui
function generateEven(start, last) {
    let even_num = new Array();
    for (let i = start; i<=last; i++){
        if (i%2 ==0){
            even_num.push(i);
        }
    }
    return even_num;
}

/**
 * author: Ryan Carmody
 * Generates Fibonacci numbers up to given limit and save them to a file.
 */
function generateFibonacci(last) {
    const fibonacci = [0, 1];
    
    while (fibonacci[fibonacci.length - 1] + fibonacci[fibonacci.length - 2] <= last) {
      const nextFib = fibonacci[fibonacci.length - 1] + fibonacci[fibonacci.length - 2];
      fibonacci.push(nextFib);
    }
    
    // Format the content for display
    const message = `Fibonacci Numbers up to ${last}:\n\n${fibonacci.join('\n')}`;
    
    // Show alert with the fibonacci numbers
    alert(message);
    
    console.log('Fibonacci numbers displayed');
    
    return fibonacci;
}

/**
 * author: Ryan Carmody
 * Generates odd numbers within a specified range and save them to a file.
 */
function generateOdd(start, last) {
    let odd_num = new Array();
    for (let i = start; i<=last; i++){
        if (i%2 !=0){
            odd_num.push(i);
        }
    }
    return odd_num;
}

//Jia Hui
function generatePrime(last) {
    let prime_list = new Array(last); 
    let index = 0; 

    for (let num = 2; num < last; num++) { 
        if (isPrime(num)) {
            prime_list[index] = num; 
            index++; 
        }
    }
    let result = new Array(index);
    for (let i = 0; i < index; i++) {
        result[i] = prime_list[i]; 
    }
    return result;
}

//Jia Hui
function generateSquare(start, last) {
    let square_list = new Array(last - start + 1); 
    let index = 0; 

    for (let i = start; i <= last; i++) {
        square_list[index] = i * i; 
        index++; 
    }

    return square_list;
}

/**
 * author: Ryan Carmody
 * Checks if given number n is prime. 
 */
function isPrime(n) {
    if (n < 2) {
      return false;
    }
  
    for (let i = 2; i <= Math.sqrt(n); i++) {
      if (n % i === 0) {
        return false;
      }
    }
  
    return true;
}

/**
 * author: Ava Daniel
 * Returns log of number(a) given the base of the log(b)
 */
function logBase(a, b) {
    if (b <= 0 || b === 1) {
        return "Error: Base b must be positive and not equal to 1";
    }
    if (a <= 0) {
        return "Error: Argument a must be positive";
    }
    // change of base formula
    return Math.log(a) / Math.log(b); 
}

/**
 * author: Ryan Carmody
 * Returns largest value of data set. 
 */
function max(list) {
    if (list.length === 0) {
      return undefined;
    }
    
    return Math.max(...list);
}

/**
 * author: Ryan Carmody
 * Calculates mean of data set. 
 */
function mean(list) {
    if (list.length === 0) {
      return null;
    }
    
    sum = 0;

    for (i = 0; i < list.length; i++) {
        sum += parseFloat(list[i]);
    }
    
    return sum / list.length;
}

//Jia Hui
function median(list) {
    let sorted = list.sort((a, b) => a - b);
    let size = sorted.length;
    let half = size / 2;

    if (size % 2 !==0){
        let index = half - 0.5;
        return sorted[index]
    } else{
        return (parseFloat(sorted[half-1]) + parseFloat(sorted[half]))/2
    }
}

/**
 * author: Ryan Carmody
 * Returns smallest valuein given list.
 */
function min(list) {
    if (list.length === 0) {
      return undefined;
    }
  
    let minimum = list[0];
  
    for (let i = 1; i < list.length; i++) {
      if (list[i] < minimum) {
        minimum = list[i];
      }
    }
    
    return minimum;
  }
  
  /**
   * author: Ryan Carmody
   * Finds mode of data set. 
   */
  function mode(list) { 
      if (list.length === 0) return null;
      
      const frequency = list.reduce((acc, val) => {
        acc[val] = (acc[val] || 0) + 1;
        return acc;
      }, {});
      
      const maxFreq = Math.max(...Object.values(frequency));
      
      const modes = Object.keys(frequency)
        .filter(key => frequency[key] === maxFreq)
        .map(Number);
      
      if (modes.length === Object.keys(frequency).length) return null;
      
      return modes.length === 1 ? modes[0] : modes;
}

//Jia Hui
function percentage(a, b) {
    let result =1;
    if (b == 0){
        return "Denominator (b) cannot be zero";
    }
    else{
        return (a/b)*100 +"%";
    }
}

/**
 * author: Ava Daniel
 * Returns sin of degree in radians 
 */
function sin(n) {
    if (typeof n !== "number" || isNaN(n)) {
        return "Error: Input must be a number";
    }
    const radians = n * (Math.PI / 180); // Convert degrees to radians
    return Math.sin(radians);
}

/**
 * author: Ava Daniel
 * Returns square root of positive integer
 */
function sqrt(n) {
    if (n < 0) {
        return "Error: Cannot calculate square root of a negative number";
    }
    return Math.sqrt(n);
}

/**
 * author: Ava Daniel
 * Returns tangent of degree in radians 
 */
function tan(n) {
    if (typeof n !== "number" || isNaN(n)) {
        return "Error: Input must be a number";
    }
    const radians = n * (Math.PI / 180); // Convert degrees to radians
    return Math.tan(radians);
}