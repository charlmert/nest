#!/usr/bin/env nodejs
/** -*- mode:nodejs -*-
 *
 *
 * File Streamer Pebble
 * Description: Operates on the file copy argument types: file1 file2, file1 dir/file2, dir dir2/
 *			 			  using the appropriate middle man command e.g. cp, scp
 * 
 */

fs         			= require ('fs');
path       			= require ('path');
http       			= require ('http');
sys     			  = require ('sys');
child_process   = require ('child_process');
spawn 					= require('child_process').spawn,
//opt_parse   		= require ('optparse');

// child process container
function sub_shell(error, stdout, stderr) {
	console.log('stdout: ' + stdout);
	console.log('stderr: ' + stderr);
	if (error !== null) {
		console.log('error: ' + error);
	}
}

/*
var parameters = '';
for (i = 2; (i < process.argv.length); i++) {
	parameters += ' ' + process.argv[i];
}

// find command in current env
child_process.exec('find' + parameters, sub_shell);
*/

var parameters = [];
for (i = 2; (i < process.argv.length); i++) {
	parameters[i-2] = process.argv[i];
}

// find command in new restorable env with pid
cmd    = spawn('find', parameters);

cmd.stdout.on('data', function (data) {
  sys.print(data);
});

cmd.stderr.on('data', function (data) {
  sys.print(data);
});

cmd.on('exit', function (code) {
	//console.log('child process exited with code ' + code);
	process.exit(code)
});

// vim:ft=js ts=2 sw=2 et :
