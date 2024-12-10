FROM node:22-slim AS base

EXPOSE 8000

# ------------------------------------------------------------
# Create the application user/group and installation directory

ENV APP_USER=cadet
ENV APP_UID=40037

RUN groupadd --system --gid $APP_UID $APP_USER \
    && useradd --home-dir /opt/app --system --uid $APP_UID --gid $APP_USER $APP_USER

RUN mkdir -p /opt/app \
    && chown -R $APP_USER:$APP_USER /opt/app

# Get list of available packages
RUN apt-get update -qq

# Install standard packages from the Debian repository
RUN apt-get install -y --no-install-recommends \
    curl \
    unzip

# ------------------------------------------------------------
# Run configuration

# All subsequent commands are executed relative to this directory.
WORKDIR /opt/app
COPY . .

RUN chown -R $APP_USER:$APP_USER /opt/app/data

# Run as the application user to minimize risk to the host.
USER $APP_USER

# We install CADET on the container *starting* rather than when it's built
# because of the EULA for CADET
CMD ./install-cadet.sh && \
    node cadet/cadet-resources/cadet-server.js --dir /opt/app/data