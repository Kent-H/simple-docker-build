FROM <name>:<pinned version> as build

# project-specific information
# ARG PROJECT_PATH=...  etc.

# get and install dependencies

# copy in pinned code dependency file(s)
# COPY vendor/vendor.json vendor/

# download/install dependencies by pinned version
# RUN govendor sync -v
# RUN govendor install -v -tags netgo +vendor

# get working tree information from build script
ARG GIT_BRANCH
ARG GIT_COMMIT_NUM
ARG GIT_COMMIT
ARG GIT_UNCOMMITTED_CHANGES

# bring in source files
# COPY . ./

# perform actual build



# create final container
FROM <name>:<pinned version>

# project-specific information... again, if required
# ARG PROJECT_PATH=...  etc.

# add static dependencies
# RUN apk --no-cache add...  etc.

# copy final resources from last build stage
# COPY --from=build /src/... /dst/...

# startup command
CMD ["/run/this/executable"]
