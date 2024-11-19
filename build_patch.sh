Source="${1-""}" # commit hash, branch or tag
BBBuilder="${2-"BBBuilder.exe"}"

currentBranch=$(git rev-parse --abbrev-ref HEAD)

[ -d "./.bbbuilder" ] && rm -r "./.bbbuilder"

"$BBBuilder" build "./" -diff "$Source,$currentBranch"