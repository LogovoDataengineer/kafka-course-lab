FROM mcr.microsoft.com/devcontainers/python:1-3.12-bookworm

USER root
# This Python image includes an unused Yarn apt source with an expired signing key.
# Remove only that optional source before the Docker feature runs apt-get update.
# Debian and Docker package signature verification remains enabled.
RUN rm -f /etc/apt/sources.list.d/yarn.list /etc/apt/sources.list.d/yarn.sources
USER vscode
