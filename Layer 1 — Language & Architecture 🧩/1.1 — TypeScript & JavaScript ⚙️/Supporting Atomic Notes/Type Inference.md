Type Inference

// ? GOOD „ clear inference
const count = 5;

// ? GOOD „ contextual inference (TS knows x is a number)
const arr = [1, 2, 3];
arr.map(x => x * 2);

// ? GOOD „ explicit type when needed
type User = { id: number; name: string };
export function parseUser(json: string): User {
return JSON.parse(json);
}

// ? CAUTION „ fetch() returns untyped JSON (any)
const res = await fetch('/api/users');
const data = await res.json(); // any[]
data[0].id.toUpperCase(); // no TS error, runtime fail

// ? FIX „ assert or define the expected type
const safeData = (await res.json()) as User[];
safeData[0].name.toUpperCase(); // type-safe

// ? CAUTION „ arr is any[], x is any (unsafe)
const arr2: any[] = [1, 2, 3];
arr2.map(x => x.toUpperCase()); // no TS error, crashes at runtime

// ? FIX „ type it explicitly
const arr3: number[] = [1, 2, 3];
arr3.map(x => x * 2);

// ? BAD „ overly broad inference
const data2 = []; // any[]

// ? FIX
const data3: string[] = []; // define element type

// ? BAD „ redundant typing (code bloat)
const add: (a: number, b: number) => number = (a, b) => a + b;

// ? FIX „ let inference handle it
const add2 = (a: number, b: number) => a + b;

// ? BAD „ assigning redundant type to a value that already infers cleanly
let total: number = 0;

// ? FIX „ let TS infer from initializer
let total2 = 0;

// ? BAD „ using 'as any' to escape type safety
const config = getConfig() as any;

// ? FIX „ define or narrow the type
interface Config { apiUrl: string; retries: number; }
const config2 = getConfig() as Config;

// ? BAD „ implicit 'any' in function params
function log(message) {
console.log(message.toUpperCase());
}

// ? FIX „ annotate parameters or infer from context
function log2(message: string) {
console.log(message.toUpperCase());
}

// ? BAD „ union too broad (breaks downstream inference)
let value: string | number | boolean = 'ok';
value.toUpperCase(); // TS can't narrow safely

// ? FIX „ narrow or use specific overloads
let value2: string = 'ok';
value2.toUpperCase();

// ? BAD „ using JSON.parse() without typing
const user = JSON.parse('{"id":1}');
user.nonexistent; // no error

// ? FIX „ assert the expected type
const user2 = JSON.parse('{"id":1}') as User;
user2.id; // fully type-checked
