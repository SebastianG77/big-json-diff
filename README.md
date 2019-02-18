big-json-diff
===========

This module is a fork of [json-diff 0.5.3](https://www.npmjs.com/package/json-diff/v/0.5.3). It generally offers all functions of the original module but also extends it by offering an option for bignumber.js support. 

When adding the option ```--bigNumberSupport``` or its shortcut ```-b``` while running big-json-diff, it is possible to get proper diffs for JSON files that contain numbers of any size as this module then uses a big number JSON parser internally to build objects of JSON files. 

Just run one of the following commands from console to create a diff for JSON files that contain big numbers. 

```
$ npm install big-json-diff -b <path-to-old-file> <path-to-new-file>
```

or 

```
$ npm install big-json-diff --bigNumberSupport <path-to-old-file> <path-to-new-file>
```

If you need to call the crorresponding function programatically, you first have to ensure all big numbers are already converted to bignumber.js objects. Then simply run the function diffString() and pass the option { bigNumberSupport: true } as displayed in the following example.

```
const BigNumber = require('bignumber.js');
const bigJsonDiff = require('big-json-diff')

const oldBigNumber = BigNumber('3e+5000')

const newBigNumber = BigNumber('12345678901234567890')

console.log(bigJsonDiff.diffString(oldBigNumber, newBigNumber, { bigNumberSupport: true })) // -3e+5000
                                                                                          // +12345678901234567890
```

**Note:** Since this module internally works with bignumber.js objects, it cannot be guaranteed for big numbers that they will be represented in the same way as transferred to big-diff-string. This means, big-diff-string can represent numbers written in scientific notation as decimal numbers and vice versa. However, the representation does not have any effect on the actual meaning of the result, such that big-json-diff should always be able to return each diff.

Of course, it is also possible to add the option { bigNumberSupport: true } to the function diff(). Also in this case bigNumber.js objects will be recognized as such, which is illustrated in the second example: 

```
const BigNumber = require('bignumber.js');
const bigJsonDiff = require('big-json-diff')

const oldBigNumber = BigNumber('3e+5000')

const newBigNumber = BigNumber('12345678901234567890')

console.log(bigJsonDiff.diffString(oldBigNumber, newBigNumber, { bigNumberSupport: true })) 
// { __old: BigNumber { s: 1, e: 5000, c: [ 300 ] },
//  __new: BigNumber { s: 1, e: 19, c: [ 123456, 78901234567890 ] } }
```

Further features that are already supported by [json-diff 0.5.3](https://www.npmjs.com/package/json-diff/v/0.5.3) can be seen in the corresponding README.
