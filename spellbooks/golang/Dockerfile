FROM golang:1.9 as build

# project-specific information
ARG PROJECT_PATH=github.com/kent-h/nextslope-backend
ARG INJECT_PACKAGE_PATH="main"
ARG FILE_NAME="nextslope-backend"

WORKDIR /go/src/$PROJECT_PATH

# get and install dependencies
RUN go get -u github.com/kardianos/govendor

# copy in pinned code dependency file(s)
COPY vendor/vendor.json vendor/

# download/install pinned versions of dependencies
RUN govendor sync -v
RUN govendor install -v -tags netgo +vendor

# get working tree information from build script
ARG GIT_BRANCH
ARG GIT_COMMIT_NUM
ARG GIT_COMMIT
ARG CHANGED

# bring in source files
COPY . ./

# build static binary
RUN go build -v -tags netgo \
	--ldflags "-extldflags \"-static\" \
	-X \"$INJECT_PACKAGE_PATH.GIT_BRANCH=$GIT_BRANCH\" \
	-X \"$INJECT_PACKAGE_PATH.GIT_COMMIT_NUM=$GIT_COMMIT_NUM\" \
	-X \"$INJECT_PACKAGE_PATH.GIT_COMMIT=$GIT_COMMIT\" \
	-X \"$INJECT_PACKAGE_PATH.CHANGED=$CHANGED\"" \
	-o build/$FILE_NAME main.go



# create final container
FROM alpine:3.6

# project-specific information
ARG PROJECT_PATH=github.com/kent-h/nextslope-backend
ARG FILE_NAME=nextslope-backend

# add static dependencies
RUN apk --no-cache add ca-certificates

# copy final resources from last build stage
COPY --from=build /go/src/$PROJECT_PATH/build/$FILE_NAME /bin/$FILE_NAME

# startup command
CMD ["nextslope-backend"]
