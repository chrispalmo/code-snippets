Check python version (might need to use `python3` depending on how the system `PATH` variable is set up):

`py --version`

1. Create new project folder:
`mkdir my-new-project`
`cd my-new-project`

2. Create a vircual environment in the project root folder:
`py -m venv ./venv`

3. Activate the virtual environment:

### Windows

`./venv/scripts/activate.ps1`

### Mac

`source ./venv/bin/activate`
or
`. ./venv/bin/activate`

The above won't work from within a script, so consider using a function:

```
function ACTIVATE_MY_ENV() {
    cd path/to/project
    source ./venv/bin/activate
}
```

Deactivate the virtual environment:

```
> deactivate
```
