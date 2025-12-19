Programming Glossary

Idiomatic
In programming, ñidiomaticî means natural to the language or framework.
ItÍs code that uses the languageÍs native constructs, conventions, and best-practice patterns rather than mechanically translating from another language.

Example:
Writing Array.map() instead of a for loop in JavaScript when transforming lists „ thatÍs idiomatic JS.
Non-idiomatic code ñworks,î but feels foreign to experienced readers and often hides intent.


------------------------------------------------------------


Unidiomatic
Unidiomatic code goes against the grain of the language or framework.
It often ñworks,î but itÍs awkward, verbose, or misuses constructs in ways that confuse other developers.
Usually the result of bringing habits from another language or paradigm instead of embracing the local idioms.

Example:
Using a class-based approach with manual DOM manipulation inside a React component is unidiomatic „ React is designed for declarative UI, not imperative DOM control.

Unidiomatic code creates friction, making codebases harder to read, extend, and maintain.
It signals a misunderstanding of the frameworkÍs intended mental model.


------------------------------------------------------------


Imperative
Imperative code describes how to do something, step by step.
It gives the computer explicit instructions and manipulates state directly.

Example:
const numbers = [1, 2, 3];
const doubled = [];
for (let i = 0; i < numbers.length; i++) {
doubled.push(numbers[i] * 2);
}

YouÍre commanding the machine line by line.
Imperative style is about control flow „ loops, assignments, conditionals.


------------------------------------------------------------


Declarative
Declarative code describes what you want, not how to get it.
The system figures out the execution details.

Example:
const doubled = numbers.map(n => n * 2);

You declare intent „ ñI want a new array where each element is doubled.î
ReactÍs JSX is declarative: you declare what the UI should look like given state, and React decides how to update the DOM.
