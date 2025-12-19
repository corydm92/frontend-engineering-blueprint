Fun Interview Questions:

Call Stack and Event Loop Problem
What would the expected outcome be for this javascript module?

// promiseTest.js console.clear();

console.log(1);

const generatePromise = () => {
console.log(2);

setTimeout(() => {
console.log(3);

new Promise((resolve) => {
console.log(4);
resolve('first res');
})
.then((res) => {
console.log(5);
console.log(res);
return res;
})
.then((res) => {
console.log(6);
console.log(res);
});

console.log(8);
}, 0);

Promise.resolve('second res').then((res) => {
console.log('A');
console.log(res);
});

console.log(9);
};

console.log(10);

generatePromise();

console.log(11)



