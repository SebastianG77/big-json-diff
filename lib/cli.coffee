fs  = require 'fs'
JSONbig = require 'true-json-bigint'
tty = require 'tty'

{ diff } = require './index'
{ colorize } = require './colorize'

module.exports = (argv) ->
  options = require('dreamopt') [
    "Usage: json-diff [-vjCk] first.json second.json"

    "Arguments:"
    "  first.json              Old file #var(file1) #required"
    "  second.json             New file #var(file2) #required"

    "General options:"
    "  -b, --bigNumberSupport  Handle large numbers as bignumber.js objects to ensure correct diffs for them"
    "  -v, --verbose           Output progress info"
    "  -C, --[no-]color        Colored output"
    "  -j, --raw-json          Display raw JSON encoding of the diff #var(raw)"
    "  -k, --keys-only         Compare only the keys, ignore the differences in values #var(keysOnly)"
  ], argv

  process.stderr.write "#{JSON.stringify(options, null, 2)}\n"  if options.verbose

  process.stderr.write "Loading files...\n"  if options.verbose
  data1 = fs.readFileSync(options.file1, 'utf8')
  data2 = fs.readFileSync(options.file2, 'utf8')

  process.stderr.write "Parsing old file...\n"  if options.verbose
  json1 = if options.bigNumberSupport then JSONbig.parse(data1) else JSON.parse(data1)
  process.stderr.write "Parsing new file...\n"  if options.verbose
  json2 = if options.bigNumberSupport then JSONbig.parse(data2) else JSON.parse(data2)

  process.stderr.write "Running diff...\n"  if options.verbose
  result = diff(json1, json2, options)

  options.color ?= tty.isatty(process.stdout.fd)

  if result
    if options.raw
      process.stderr.write "Serializing JSON output...\n"  if options.verbose
      process.stdout.write if options.bigNumberSupport then JSONbig.stringify(result, null, 2) else JSON.stringify(result, null, 2)
    else
      process.stderr.write "Producing colored output...\n"  if options.verbose
      process.stdout.write colorize(result, {color: options.color, bigNumberSupport: if options.bigNumberSupport then true else false })
  else
    process.stderr.write "No diff" if options.verbose

  process.exit 1 if result
