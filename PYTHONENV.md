# Notes on using emacs as a Python 'IDE': eply or lsp-mode

There are two Python IDE environments I have used, and which this configuration
can support: *lsp-mode* with *python-lsp-server* or *elpy*.

Both provide advanced Python specific IDE abilities and greatly enhance the
Python programming experience inside *emacs*.

Both have some of the same features and this overlap means they are not fully
compatible. You will have to pick between them.

In general, *elpy* is a bit leaner. *lsp-mode* is slower and provides a more
consistent interface between the different programming languages which
*lsp-mode* supports.

*lsp-mode* is a compelling choice if you use the lsp-server to enforce
consistent style and code requirements across a shop/team. You simply pick a
server and configure it with the standard requirements and everyone can use
their own preferred editor/IDE pointed at the configured lsp server. Then
everyone is writing code to the same standards.

The default setup for Python uses *python-lsp-server*.

## Using *python-lsp-server*

*lsp-mode* should start or connect to an existing *python-lsp-server* whenever
you open any python file.

If lsp-mode is running poorly, you can triage the situation with *lsp-doctor*.

A good guide for using *lsp-doctor* and increasing *lsp-mode* performance is
found here: <https://emacs-lsp.github.io/lsp-mode/page/performance/>.

A good guide for configuring and setting up *python-lsp-server* is here:
<https://emacs-lsp.github.io/lsp-mode/page/lsp-pylsp/#server>


## Enabling and using elpy

See: <https://elpy.readthedocs.io/en/latest/introduction.html> for more info on *elpy*.

By default, *elpy* is disabled in favor of LSP, but you can edit
*custom/setup-python.el* to enable it. First, uncomment sections referencing
*elpy*. and then comment all sections in all files referencing *lsp-mode* and
python in *custom/setup-editing.el*.

To make sure elpy is running correctly, *M-X elpy-config*. Note any *warnings*
or missing packages and install them.

If you are using a dedicated virtual environment per project, elpy may warn
about *~/.local/bin* not being in the PATH. You will have to either: modify your PATH
variable before starting emacs, or stop running emacs from the virtual
environment.

To modify your path, add a line like the following to your *~/.bashrc*:

```bash
export PATH="$PATH:$HOME/.local/bin"
```

## Adding and configuring additional Python packages: autopep8, yapf, jedi, rope, black, flake8

These pip packages provide features used by *elpy* and/or *python-lsp-server*,
but are handy on their own.

* *autopep8* helps elpy enforce compliance with the Python Pep-8 coding standards
by underlining in red all non-compliant code. See:
<http://paetzke.me/project/py-autopep8.el>.

* *flake8* is the linter static analysis engine used by autopep8.

* *yapf* is used as a more feature completed *autopep8* with a slightly different
and more hands-on approach to enforcing code-style beyond pep8 compliance.

In general, you should configure your editor to use 1 of these at a time.

However, you can still install all of them on your machine and have different
linting tools run them as part of your gating process-- both inside or outside
of *emacs*.


To install all python packages supported by Elpy:

```bash
pip install autopep8 jedi rope yapf black flake8 pydocstyle
```

To install all optional packages supported by *python-lsp-server*:

```bash
pip install python-lsp-server[all]

```

Sometimes, you may want to override some of autopep8's style settings, such as
the default line length being set to only allow 80 characters, which is archaic.

Another issue is that pycodestyle enforces W503 and W504 out of the box
when all warnings are enabled.  These two rules actually conflict with each
other. The current best practice in PEP8 is to use W504, as W503 is deprecated.

To change settings, edit *$HOME/.config/pycodestyle* and add the appropriate
ini-file style configuration settings.  The following changes the default line
length from 80 to 160 characters and turns off W503:

```
[pycodestyle]
max_line_length = 160
ignore = W503
```

To override the default pylint settings, create an rc file in your home
directory or project root called *.pylintrc*:

```
[MASTER]

persistent=yes

[FORMAT]
max-line-length=160

```

To override settings in flake8, look for file *~/.config/flake8*:
```
[flake8]
max-line-length = 160
```

## Using the python invoke package

Most of my Python projects use a package called *invoke* to execute the creation
of build and release targets. *invoke* is a "task execution tool and library."
It is similar in purpose to *make*, *maven* or Ruby *rake*.

You can install it via *pip*:

```bash
pip install invoke
```

To setup invoke, you create a tasks.py file in the top directory of your project/package:


Here is an example *tasks.py* file:

```python
"""Invoke build and compile tasks.

"""
import os
from urllib.request import pathname2url
from invoke import Collection, task
import webbrowser


def open_browser(file_name: str):
    """Open the default browser at a local html file."""
    uri = pathname2url(os.path.abspath(file_name))
    webbrowser.open(f"file://{uri}")

@task
def pip_install_requirements(c):
    """Install dependencies needed to run packagename.

    Runs 'pip install -r requirements.txt'.
    """
    c.run('pip install -r requirements.txt')


@task(pip_install_requirements)
def pip_install_development_requirements(c):
    """Install development dependencies needed to develop packagename.

    Runs 'pip install -r requirements_dev.txt'.
    """
    c.run('pip install -r requirements_dev.txt')


@task(pip_install_development_requirements)
def pip_install_emacs_requirements(c):
    """Install all dependencies needed to develop with emacs as an IDE.

    Runs 'pip install -r requirements_emacs_dev.txt'.
    """
    c.run('pip install -r requirements_emacs_dev.txt')


@task(pip_install_development_requirements, default=True)
def pip_install_dev_mode(c):
    """Install dev environment: required dev packages and also install locally in development mode.

    Runs 'pip install -e .'.
    """
    c.run('pip install -e .')


@task
def clean_release(c):
    """Clean build artifacts produced when creating and releasing the package.

    Runs remove file and directory commands to remove sdist and python egg files and directories.
    """
    c.run('rm -rf build/')
    c.run('rm -rf dist/')
    c.run('rm -rf .eggs/')
    c.run('rm -rf packagename.egg-info/')
    c.run("find . -name '*.egg-info' -exec rm -fr {} +")
    c.run("find . -name '*.egg' -exec rm -f {} +")


@task
def clean_pyc(c):
    """Find and remove stale compiled python files ending in pyc or pyo as well as emacs backup files and __pycache__ directories."""
    c.run("find . -name '*.pyc' -exec rm -f {} +")
    c.run("find . -name '*.pyo' -exec rm -f {} +")
    c.run("find . -name '*~' -exec rm -f {} +")
    c.run("find . -name '__pycache__' -exec rm -fr {} +")


@task
def clean_testing(c):
    """Remove cruft created during testing activities, including stale coverage and pytest output."""
    c.run("rm -rf .tox/")
    c.run("rm -f .coverage")
    c.run("rm -rf htmlcov/")
    c.run("rm -rf .pytest_cache")


@task
def clean_install(c):
    """Uninstall packagename, regardless of original installation mode or method.

    Runs 'pip uninstall -y packagename'.
    """
    c.run("pip uninstall -y packagename")


@task(clean_release, clean_pyc, clean_testing, clean_install)
def pristine(c):
    """Uninstall packagename and cleanup everything."""
    pass


@task(default=True)
def unit_test(c):
    """Run unit tests.

    Runs 'python -m unittest'.
    """
    c.run("python -m unittest")


@task
def coverage(c):
    """Run unit tests and collect code coverage statistics.

    Runs:
    'coverage run --source packagename -m unittest discover'
    'coverage report -m'
    'coverage html'
    Then attempts to start a local browser pointed at ./htmlcov/index.html.
    """
    c.run("coverage run --source packagename -m unittest discover")
    c.run("coverage report -m")
    c.run("coverage html")
    open_browser("./htmlcov/index.html")


@task
def lint_bin(c):
    """Run pylint code quality static analyzer on the contents of the ./bin directory."""
    c.run("pylint --fail-under=8 ./bin")


@task(lint_bin)
def lint(c):
    """Run pylint code quality static analyzer on the contents of the ./packagename and ./bin directories."""
    c.run("pylint --fail-under=8 ./packagename")


@task(lint)
def lint_tests(c):
    """Run pylint code quality static analyzer on the contents of the ./packagename, ./bin and ./test directories."""
    c.run("pylint --fail-under=2 ./tests")


@task
def security(c):
    """Run bandit security static analyzer on the contents of the ./packagename directory."""
    c.run("bandit -r packagename")


@task
def docs(c):
    """Generate API documentation in markdown format and overlay ./docs directory.

    Done via pdoc3.
    """
    c.run("pdoc3 --pdf packagename > docs/README.md")


@task(docs, default=True)
def release(c):
    """Build a package suitable for redistribution.

    Package can be uploaded to a PyPi compatible server such as an Azure DevOps Artifacts repository.

    Runs 'python setup.py sdist'
    """
    c.run("python setup.py sdist")


@task(docs)
def install_local(c):
    """Install packagename locally via pip, see build.release and develop.install before running.

    This does not install in dev mode and is used mainly for testing. Use build.release to promote and develop.install to develop.

    Runs 'pip install .'.
    """
    c.run("pip install ./")

ns = Collection()

quality = Collection('quality')
quality.add_task(coverage)
quality.add_task(lint)
quality.add_task(lint_tests)
quality.add_task(security)
quality.add_task(unit_test)

build = Collection('build')
build.add_task(clean_install, 'uninstall')
build.add_task(pristine)
build.add_task(install_local)
build.add_task(release)

develop = Collection('develop')
develop.add_task(pip_install_emacs_requirements, 'install-emacs')
develop.add_task(pip_install_dev_mode, 'install')

ns.add_collection(quality)
ns.add_collection(build)
ns.add_collection(develop)

```

More info on *invoke*: <https://www.pyinvoke.org>
