## Simple Docker Build

A simple yet powerful docker base to use when starting new projects.

### Supported Languages

* Golang

### Features

* 100% Docker (avoiding extraneous build dependencies)
* Workspace non-polluting (no bind-mounting of local folders, etc.)
* Efficient
  * Utilizes build stages to create a minimal final container.
  * Non-source files & development directories are excluded by `.dockerignore`.
  * Utilizes the `docker build` cache
    * Dockerfile build dependencies are processed from least-to-most volatile, to best utilize docker's build caching.
    * Pinned dependencies are always pulled in first, 
* Versioned
  * Repeatable builds.
  * The following variables are injected into the docker build process.  Dockerfiles SHOULD expose these variables to the final executable in the final container.
    * `BRANCH_NAME`
    * `COMMIT_NUMBER` (counted from the initial commit)
    * `GIT_COMMIT` (a hash)
    * `CHANGED` (a git directory modified flag)
  * A build initiated with a clean git repository, will result in an image with a tag of the form:<br/>
    `$REPO$NAME:0.$COMMIT_NUMBER` (if on the master branch)<br/>
    or<br/>
    `$REPO$NAME:$BRANCH_NAME-0.$COMMIT_NUMBER` (if on any other branch).<br/>
    Builds initiated with a non-clean git repository will simply be tagged as: `$REPO$NAME:latest`<br/>
    Though not truly SemVer-compliant, this is easily SemVer-compatible.

### Usage

1. Copy the build.sh script from this project to the root of your project.
1. Change the first few lines of the build script `NAME=""`, `REPO=""` to use the desired docker build tag.
1. Copy the Dockerfile and .dockerignore from the relevant `spellbooks/{language}/` to the root of your project.
1. Follow any instructions in `spellbooks/{language}/README.md`<br/>
   <br/>
   Test by running `./build.sh`

Also recommended:
1. Update `.dockerignore` to include project-specific ignores.
1. Check and update pinned versions in the Dockerfile.

### Contributing

When adding Dockerfiles for a new language, `spellbooks/template/...` should be used as a general guide.
