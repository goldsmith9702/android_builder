#!/bin/bash

# Gradle Wrapper - Manually created for GitHub Actions

APP_NAME="gradlew"

# Add default JVM options here if needed.
DEFAULT_JVM_OPTS=""

# Use the maximum available, or set MAX_FD != -1 to use that value.
MAX_FD="maximum"

warn() {
    echo "$*"
}

die() {
    echo
    echo "$*"
    echo
    exit 1
}

# Determine the Java command to use to start the JVM.
JAVACMD="java"
which java >/dev/null 2>&1 || die "ERROR: 'java' command not found in your PATH.

Please make sure Java is installed and your PATH is set correctly."

# Increase the maximum file descriptors if we can.
if [ "$MAX_FD" = "maximum" -o "$MAX_FD" = "max" ] ; then
    MAX_FD_LIMIT=`ulimit -H -n`
    if [ $? -eq 0 ] ; then
        MAX_FD="$MAX_FD_LIMIT"
    else
        warn "Could not query maximum file descriptor limit: $MAX_FD_LIMIT"
    fi
fi

# For Cygwin, ensure paths are in UNIX format before anything is touched.
case "`uname`" in
    CYGWIN* )
        [ -n "$JAVA_HOME" ] && JAVA_HOME=`cygpath --unix "$JAVA_HOME"`
        ;;
esac

# Determine the appropriate version of the JVM to use.
if [ "$JAVA_HOME" != "" ] ; then
    if [ -x "$JAVA_HOME/bin/java" ] ; then
        JAVACMD="$JAVA_HOME/bin/java"
    else
        die "ERROR: JAVA_HOME is set to an invalid directory: $JAVA_HOME

Please set the JAVA_HOME variable in your environment to match the
location of your Java installation."
    fi
fi

# Extract release version and JVM version, check we have a valid JVM
$JAVACMD -version > /dev/null 2>&1
if [ $? -eq 0 ] ; then
    # Extract version from first line of java -version output
    `$JAVACMD -version 2>&1 | awk 'NR==1{ gsub(/"/,""); print $3 }'` > /dev/null 2>&1
else
    die "ERROR: Java not found or is not executable.

Please make sure Java is installed and your PATH is set correctly."
fi

# Set default JVM options
DEFAULT_JVM_OPTS="-Dorg.gradle.appname=$APP_NAME"

# Set JVM options passed through environment variables
if [ "$ORG_GRADLE_PROJECT_OPTS" != "" ] ; then
    DEFAULT_JVM_OPTS="$DEFAULT_JVM_OPTS $ORG_GRADLE_PROJECT_OPTS"
fi

# For Cygwin, switch paths to Windows format before running java
if [ "$CYGWIN" = "true" -o "$msys" = "true" ] ; then
    APP_HOME=`cygpath --path --windows "$APP_HOME"`
    CLASSPATH=`cygpath --path --windows "$CLASSPATH"`
    JAVACMD=`cygpath --unix "$JAVACMD"`
fi

# Escape application home and jar paths for spaces
APP_HOME=`echo "$APP_HOME" | sed 's/ /\\ /g'`
CLASSPATH=`echo "$CLASSPATH" | sed 's/ /\\ /g'`

# Construct command-line arguments
ARGS="$DEFAULT_JVM_OPTS -classpath \"$CLASSPATH\" org.gradle.wrapper.GradleWrapperMain $@"

# Execute Gradle
exec "$JAVACMD" $ARGS
