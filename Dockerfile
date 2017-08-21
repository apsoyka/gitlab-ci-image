FROM java:jdk

ENV GRADLE_VERSION=4.1 \
    GRADLE_HOME=/opt/gradle \
    GRADLE_USER_HOME=/cache/.gradle \
    GRADLE_OPTS="-Dorg.gradle.daemon=false"
ENV PATH $PATH:$GRADLE_HOME/bin

WORKDIR $GRADLE_HOME

RUN apt update --yes && \
    apt install --yes wget bsdtar && \
    wget --quiet --output-document=- https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip | \
    bsdtar --strip-components=1 --extract --verbose --file - && \
    chmod +x $GRADLE_HOME/bin/gradle

HEALTHCHECK CMD gradle --version | grep --quiet 'Gradle $GRADLE_VERSION'