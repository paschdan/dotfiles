encode64() {
    if [[ $# -eq 0 ]]; then
        cat | base64
	cat | base64 | pbcopy
    else
        printf '%s' $1 | base64
        printf '%s' $1 | base64 | pbcopy
    fi
}

decode64() {
    if [[ $# -eq 0 ]]; then
        cat | base64 --decode
        cat | base64 --decode | pbcopy
    else
        printf '%s' $1 | base64 --decode
        printf '%s' $1 | base64 --decode | pbcopy
    fi
}

alias e64=encode64
alias d64=decode64

alias sopse="sops -i -e"
alias sopsd="sops -i -d"
