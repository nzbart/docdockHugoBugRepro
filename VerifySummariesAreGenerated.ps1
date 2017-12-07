pushd $PSScriptRoot
try {
    git submodule update --init --recursive
    if(!$?) {
        throw "Failed to update docdock submodule."
    }

    cd Source

    if(Test-Path  public) {
        rm -r -fo public
    }

    ..\ThirdParty\Hugo\hugo.exe

    $html = cat public\test\index.html -Raw
    if($html.Contains('This is a summary.')) {
        Write-Host "The summary is present and working correctly." -Fore Green
    }
    else {
        Write-Host "The summary is NOT present, so something isn't working as expected." -Fore Red
    }
}
finally
{
    popd
}
