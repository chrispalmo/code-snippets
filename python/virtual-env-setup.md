# Python virtual environment setup

## using pyenv (popular for individual devs managing multiple Python versions)

1. Install pyenv + pyenv-virtualenv:

`curl https://pyenv.run | bash`

2. Add to ~/.zshrc:

```
# The next line sets up pyenv for managing multiple Python versions 
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

3. Reload / open new shell

4. Check installation

```
pyenv version
pyenv doctor
```

5. Install Python and create virtual environment

```
pyenv install 3.11.8
pyenv virtualenv 3.11.8 my-env
```

6. In project folder:

`echo "my-env" > .python-version`

Now, pyenv will auto-activate my-env when you cd into this folder.

7. Verify

```
python --version   # Should show Python 3.11.8
which python       # Should point to pyenv's shims
```

## using venv (built-in) (Default for projects using system or Docker Python)

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
