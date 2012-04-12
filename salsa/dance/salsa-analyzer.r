#!/usr/bin/Rscript
args <- commandArgs(TRUE)

systemEnvPath <- Sys.getenv('PATH')

# scan and dump config builds
# for now config must conform to the json pebbles.json format
# config builds will generate md5 hashes for the different combinations
# of parameters.

# analyzing simple file copy session
results = scan(file="../cases/filecopy.txt", what=list(shell="", cmd="", param1="", param2="", param3="", param4="", param5="", param6="", param7="", param8="", param9="", param10=""), sep=" ", flush=TRUE)

# analyze build symfony session
# results = scan(file="cases/build-symfony-web-app.txt", what=list(shell="", cmd="", param1="", param2="", param3="", param4="", param5="", param6="", param7="", param8="", param9="", param10=""), sep=" ", flush=TRUE)

# specifically for copy, build into ngram
#unlist(results['cmd'])[4]
#unlist(results['param1'])[4]
#unlist(results['param2'])[4]

# matrix for resolution, dimensions need to be known :(
# A <- matrix(scan("cases/filecopy.txt", n = 200*2000), 200, 2000, byrow = TRUE)

# will check for known binaries and store build configs of parameter hashes
paths <- unlist(strsplit(systemEnvPath, ':'))
# collecting configs commands param hashes
for (path in paths) {
	cmd <- sprintf("ls -1 %s", path)
	bins <- system(cmd, intern = TRUE, ignore.stderr = FALSE)
	for (bin in bins) {
		index = 0
		for (command in unlist(results['cmd'])) {
			index = index + 1
			if (command == bin) {
				print (bin)

				index_match = 0
				for (param in unlist(results['param1'])) {
					index_match = index_match + 1
					if (index_match == index) {
						print(param)
						param1 = param
						break
					}
				}

				index_match = 0
				for (param in unlist(results['param2'])) {
					index_match = index_match + 1
					if (index_match == index) {
						print(param)
						param2 = param
						break
					}
				}

				index_match = 0
				for (param in unlist(results['param3'])) {
					index_match = index_match + 1
					if (index_match == index) {
						print(param)
						param3 = param
						break
					}
				}

				index_match = 0
				for (param in unlist(results['param4'])) {
					index_match = index_match + 1
					if (index_match == index) {
						print(param)
						param4 = param
						break
					}
				}

	
			# JSON config dump here
			# TODO: find literal presentation or just write to file
			#   		check params for null
			# 			compute md5 hash of all combinations of command options against command manpage, usage
			# 			all other non option parameters should be dumped to avoid duplicating operations or
			#				mini-todo: decide on what should happen when a command needs to be run more than once.
			print(sprintf('{"%s" : {"parameters":["%s", "%s", "%s", "%s"]}}', bin, param1, param2, param3, param4))

			}
		}
	}

}

q(status=0)
