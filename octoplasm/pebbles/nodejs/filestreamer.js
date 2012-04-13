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
//opt_parse   	= require ('optparse');

//TODO: build self awareness, traverse symlinks, relative pathing
//      fs.readlink(path)
//			path.basename(path)
//			path.dirname(path)
//			path.normalize(path); path/..//../../ becomes path // trajectory pathing. self aware of options

base_path = process.env.PWD;
config = fs.readFileSync(base_path + '/../../config/pebbles.json', 'utf-8');
if (!config) {
	process.exit(1);
}

//TODO: consider file types seperator e.g. filestreamer.js = filestreamer_js
config = JSON.parse(config);
compiled = process.compile('config = config.' + path.basename(__filename, '.js') + ';', __filename);

// child process container
function sub_shell(error, stdout, stderr) {
	console.log('stdout: ' + stdout);
	console.log('stderr: ' + stderr);
	if (error !== null) {
		console.log('error: ' + error);
	}
}

var parameters = '';
for (i = 2; (i < process.argv.length); i++) {
	parameters += ' ' + process.argv[i];
}

// Copy the contents of a file from one place to another
child_process.exec('cp' + parameters, sub_shell);

// ls contents of a dir
// child_process.exec('ls' + parameters, sub_shell);

// vim:ft=js ts=2 sw=2 et :
