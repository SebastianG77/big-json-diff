big-json-diff
===========

This module is a fork of [json-diff 0.5.3](https://www.npmjs.com/package/json-diff/v/0.5.3). It generally offers all functions of the original module but also extends it by offering an option for bignumber.js support. 

Use the following command to install this module locally:

```
$ npm install big-json-diff
```

If you prefer a global installation, you of course can also use this command instead: 

```
$ npm install -g big-json-diff
```

When adding the option ```--bigNumberSupport``` or its shortcut ```-b``` while running big-json-diff, it is possible to get proper diffs for JSON files that contain numbers of any size as this module then uses a big number JSON parser internally to build objects of JSON files. 

If you have installed big-json-diff globally, just run one of the following commands from console to create a diff for JSON files that contain big numbers. 

```
$ big-json-diff -b <path-to-old-file> <path-to-new-file>
```

or 

```
$ big-json-diff --bigNumberSupport <path-to-old-file> <path-to-new-file>
```

Of course, in case you have installed big-json-diff locally and would like to execute it via console, navigate to the installation root directory and use one of the following commands for getting diffs that also consider big numbers.

```
$ node_modules/.bin/big-json-diff -b <path-to-old-file> <path-to-new-file>
```

or 

```
$ node_modules/.bin/big-json-diff --bigNumberSupport <path-to-old-file> <path-to-new-file>
```

If you need to call the crorresponding function programatically, you first have to ensure all big numbers are already converted to bignumber.js objects. Then simply run the function diffString() and add the option { bigNumberSupport: true } to the function as displayed in the following example.

```
const BigNumber = require('bignumber.js');
const bigJsonDiff = require('big-json-diff')

const oldBigNumber = BigNumber('3e+5000')

const newBigNumber = BigNumber('12345678901234567890')

console.log(bigJsonDiff.diffString(oldBigNumber, newBigNumber, { bigNumberSupport: true })) // -3e+5000
                                                                                          // +12345678901234567890
```

**Note:** Since this module internally works with bignumber.js objects, it cannot be guaranteed for big numbers that they will be represented in the same way as transferred to big-diff-string. This means, big-diff-string can represent numbers written in scientific notation as decimal numbers and vice versa. However, the representation does not have any effect on the actual meaning of the result, such that big-json-diff should always be able to return all diffs.

Of course, it is also possible to add the option { bigNumberSupport: true } to the function diff(). Also in this case bigNumber.js objects will be recognized as such, which is illustrated in the second example: 

```
const BigNumber = require('bignumber.js');
const bigJsonDiff = require('big-json-diff')

const oldBigNumber = BigNumber('3e+5000')

const newBigNumber = BigNumber('12345678901234567890')

console.log(bigJsonDiff.diff(oldBigNumber, newBigNumber, { bigNumberSupport: true })) 
// { __old: BigNumber { s: 1, e: 5000, c: [ 300 ] },
//  __new: BigNumber { s: 1, e: 19, c: [ 123456, 78901234567890 ] } }
```

Further features that are already supported by [json-diff 0.5.3](https://www.npmjs.com/package/json-diff/v/0.5.3) can be seen in the corresponding README.
